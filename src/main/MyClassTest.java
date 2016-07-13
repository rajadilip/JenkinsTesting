package main;

import junit.framework.TestCase;
import org.junit.Test;

/**
 * Created by dilip on 7/12/16.
 */
public class MyClassTest extends TestCase {
    private int number = 35;

    protected void setUp() throws Exception {
        super.setUp();
        JUnitTestManager.getInstance().setJUnitTestRunning(true);
    }
    protected void tearDown() throws Exception
    {
        super.tearDown();
    }

    @Test
    public void testNumber()
    {
        assertEquals(25 , number);
    }
}