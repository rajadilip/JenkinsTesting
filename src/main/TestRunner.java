package main;

import junit.framework.TestCase;
import org.junit.runner.JUnitCore;
import org.junit.runner.Result;
import org.junit.runner.notification.Failure;

/**
 * Created by dilip on 7/12/16.
 */
public class TestRunner extends TestCase{

    public static void main(String[] args) {
            Result result = JUnitCore.runClasses(MyClassTest.class );

            for (Failure failure : result.getFailures()) {
                System.out.println(failure.toString());
            }
            System.out.println(result.wasSuccessful());
        }
    }