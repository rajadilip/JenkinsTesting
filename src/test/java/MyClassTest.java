package test.java;

import junit.framework.TestCase;
//import main.MyClass;
import org.junit.Test;

/**
 * Created by dilip on 7/13/16.
 */
public class MyClassTest extends TestCase{
    //private String  test = "onetwo";
    public void testConcatenate() {
       MyClass myUnit = new MyClass();

       String result = myUnit.concatenate("one", "two");

        assertEquals("onetwo", result);

    }
}
