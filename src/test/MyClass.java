package test;

import org.junit.Test;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertTrue;

/**
 * Created by dilip on 7/12/16.
 */
public class MyClass {
    int number =25;
    @Test
    public void testAdd() {
       // assertTrue(number < 10);
        assertTrue("Number is not less than 10" , number < 10);

    }
    }

