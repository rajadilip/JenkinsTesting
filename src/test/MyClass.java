package test;

import junit.framework.TestCase;
import org.junit.Test;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertTrue;

/**
 * Created by dilip on 7/12/16.
 */
public class MyClass extends TestCase {
    private int number = 35;

    protected void setUp() throws Exception {
        super.setUp();
        JUnitTestManager.getInstance().setJUnitTestRunning(true);
    }
    protected void tearDown() throws Exception
    {
        super.tearDown();
    }
    public void testNumber()
    {
        assertEquals(35 , number);
    }
}