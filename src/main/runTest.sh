#!/usr/bin/env bash

#!/bin/sh
#example of usage of this file bash runTest.sh cloeTest kratos 10
# here are changing the locahost with actual hostname using sed command
hostname=`hostname`
sed -i "s/localhost/$hostname/g" node.properties


echo "PWD=`pwd`"

 # By default Cloe run duration is 1 Hour

marketDurationInMins=10;

echo "The calculated market duration ( in min. ) is $marketDurationInMins"

# Compute market open from system time
marketOpenTime=`date +"%H:%M:%S"`

# modify market duration by subtracting 5 minutes from the input argument
modifiedMarketDuration=echo 'ibase=10;obase=10; $marketDurationInMins-5'|'bc'

echo "MarketTime is " $modifiedMarketDuration

#echo marketDurationInMins before $marketDurationInMins
#modifiedMarketDuration=$marketDurationInMins-5
#echo marketDurationInMins after $marketDurationInMins

# duration of the failover test is 3 min. lesser
#failOverTestDurationInMins=`echo $marketDurationInMins-3|bc`
failOverTestDurationInMins=$marketDurationInMins

#compute market closing time by adding the modified market duration in minutes
marketCloseTime=`date -d "$modifiedMarketDuration minute" +"%H:%M"`

echo "Market Closing Time is $marketCloseTime"

# write the Market Open time and Market Duration properties into cloe.linux.properties file
echo "cloe.marketOpenTime=$marketOpenTime" >> cloe.linux.properties
echo "cloe.marketDurationInMins=$modifiedMarketDuration" >> cloe.linux.properties

case $testType in

 cloeTest)
         LOGS_DIR=`grep "CLOE_LOGS" cloeEnv.sh | cut -d '=' -f2`
         echo "Removing all old Logs Files from $LOGS_DIR"
         rm -r ${LOGS_DIR}/*

         sh runCloe.sh
         echo "Sleeping for $marketDurationInMins minutes"
         sleep "$marketDurationInMins"m

         echo "stop the feed,inboundSim and mktSim components"
         bash manageCloe.sh $hostname feed stop
         bash manageCloe.sh $hostname inboundSim stop
         bash manageCloe.sh $hostname mktSim stop

         echo "restart the work container"
         bash manageCloe.sh $hostname wc1 force-restart

         sleep 2m

         echo "Pre-processing emit data files using the EmitTestsDataGenerator"

         DATE=`date "+%Y-%m-%d"`

         sh EmitFromText.sh $DATE

         sleep 1m

         echo "Generating Reports"

         sh run.sh batchtc net.deepvalue.report.batch.GenerateEodDataBatch EMITTEST `date +%Y-%m-%d`

         echo "Sleeping for $sleepDuringEmittestInMins minutes during emit test"
         sleep "$sleepDuringEmittestInMins"m

         sh run.sh batchtc net.deepvalue.extapp.OverNightTestReports `date +%Y-%m-%d`
         sleep 2m

         echo "Generating Emit Data the inbound_tickets that failed the emit tests"
	     sh generateEmitData.sh
         sleep 1m

         echo "Stopping Cloe"
         sh stopCloe.sh

         echo "Archiving the Test run Data"
         sh backup.sh
	     ;;

 failOverTest)
         LOGS_DIR=`grep "CLOE_LOGS" cloeEnv.sh | cut -d '=' -f2`
         echo "Removing all old Logs Files from $LOGS_DIR"
         rm -r ${LOGS_DIR}/*

         sh runCloe.sh
         sleep 3m

         echo "Started the failover test that runs for $failOverTestDurationInMins minutes"
         sh failOverCloeProcess.sh $failOverTestDurationInMins &

         sleepPriorToReportGenerationInMins=`echo $failOverTestDurationInMins+8|bc`
         echo "Sleeping for $sleepPriorToReportGenerationInMins minutes before overnight test report generation"

         sleep "$sleepPriorToReportGenerationInMins"m

         echo "Generating Reports"

         sh run.sh batchtc net.deepvalue.extapp.OverNightTestReports `date +%Y-%m-%d`
         sleep 5m

         echo "Stopping Cloe"
         sh stopCloe.sh

         echo "Archiving the Test run Data"
         sh backup.sh
         ;;

 emitTest)
         ;;

 feedTest)
         ;;

esac

