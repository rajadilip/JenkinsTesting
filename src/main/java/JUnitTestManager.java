package main.java;

/**
 * Created by dilip on 7/13/16.
 */
public class JUnitTestManager {
    /**
     * Allows the JUnit tests to indicate they are running so that tested objects can avoid Cloe specific logic,
     */
    private boolean _isJUnitTestRunning = false;

    private static final JUnitTestManager _instance = new JUnitTestManager();

    public static JUnitTestManager getInstance()
    {
        return _instance;
    }

    /**
     * Will return false unless setJUnitTestRunning has been set to true i.e. false is default value.
     *
     * @return the isJUnitTestRunning
     */
    public final boolean isJUnitTestRunning()
    {
        return _isJUnitTestRunning;
    }

    /**
     * @param isJUnitTestRunning
     *            the isJUnitTestRunning to set
     */
    public final void setJUnitTestRunning(boolean isJUnitTestRunning)
    {
        this._isJUnitTestRunning = isJUnitTestRunning;
    }
}
