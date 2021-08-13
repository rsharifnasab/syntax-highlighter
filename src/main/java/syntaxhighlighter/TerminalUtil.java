package syntaxhighlighter;

/** TerminalUtil as wr have in Terminal utilities */
public class TerminalUtil {

    /** a String just containing escape */
    public static final String ESCAPE = "" + (char) 27;

    /**
     * ansi character for reset if we print this, all setting of colored text will be reverted we
     * print this after printing colored text
     */
    public static final String Reset = ESCAPE + "[0m";

    public static final String Red = ESCAPE + "[31m";
    public static final String Blue = ESCAPE + "[94m";
    public static final String Green = ESCAPE + "[32m";
    public static final String Yellow = ESCAPE + "[93m";
    public static final String White = ESCAPE + "[97m";

    /** in case of pritning this, current line of terminal will be cleaned! */
    public static final String CLEARER = "\033[H\033[2J";

    /** in case of pritning this, current line of terminal will be cleaned! */
    public static final String LINE_DELETER = "\u001b[K";

    /**
     * print the toPrint string with the specified color and after printing, we reset terminal
     * printing color
     */
    public static void print(String toPrint, String color) {
        String colorer = White;
        switch (color) {
            case "RED":
                colorer = Red;
                break;
            case "BLUE":
                colorer = Blue;
                break;
            case "GREEN":
                colorer = Green;
                break;
            case "YELLOW":
                colorer = Yellow;
                break;
            default:
                colorer = White;
        }
        System.out.println(colorer + toPrint + Reset);
        System.out.flush();
    }

    /** print an error in red and exit whole program */
    public static void PError(String errorText) {
        // clearConsule();
        print(errorText, "RED");
        System.exit(0);
    }

    /** clear consule with prinitng the clean cunsole escape character */
    public static void clearConsule() {
        System.out.print(CLEARER);
        System.out.flush();
    }

    private TerminalUtil() {}
}
