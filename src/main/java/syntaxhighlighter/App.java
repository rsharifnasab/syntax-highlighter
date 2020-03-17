package syntaxhighlighter;
import java.io.*;

/**
 * Hello world!
 */
public class App
{
    public static void main( String[] args )
    {
        System.out.println( "Hello hello!!" );
        new String("salam  ").strip(); /* getClass(). */
        String add = App.class.getResource("/sample1.txt").getFile().toString();
        String add2 = new App().getClass().getResource("/sample1.txt").getFile().toString();
        System.out.println( add );
        System.out.println( add2 );
    }
}
