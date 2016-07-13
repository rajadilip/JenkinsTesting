package main;

import org.junit.Test;
import static org.junit.Assert.assertEquals;

/**
 * Created by dilip on 7/12/16.
 */
public class TestJUnit {

    String message = "Hello World";
    MessageUtil messageUtil = new MessageUtil(message);

    @Test
    public void testPrintMessage() {
        message = "New Word";
        assertEquals(message,messageUtil.printMessage());
    }
}
