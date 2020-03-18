package syntaxhighlighter;

import junit.framework.Test;
import junit.framework.TestCase;
import junit.framework.TestSuite;

/**
 * Unit test for our App.
 */
public class AppTest extends TestCase {
    /**
     * Create the test case
     * @param testName name of the test case
     */
    public AppTest( String testName ){
        super( testName );
    }

    /**
     * @return the suite of tests being tested
     */
    public static Test suite(){
        return new TestSuite( AppTest.class );
    }

    /**
     * test if we can Construct scanner or not
     */
    public void testScannerConstructor(){
        MyScanner yylex = new MyScanner( null );
        assertNotNull(yylex);
    }
}
