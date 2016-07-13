package test.java;

import junit.framework.TestCase;
/**
 * Created by dilip on 7/13/16.
 */
public class MyClassTest extends TestCase{

   MyClass myClass = new MyClass();

    public void testConcatenate() {

       String result = myClass.concatenate("one", "two");

        assertEquals("onetwo", result);

    }
    public void testAdd()
    {
        assertEquals(myClass.add(2 , 3) , 6);

    }
}
