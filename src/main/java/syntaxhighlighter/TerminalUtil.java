package syntaxhighlighter;

/**
 TerminalUtil as wr have in Terminal utilities
**/
public class TerminalUtil{

	/**
	 a String just containing escape
	**/
	public static final String ESCAPE = ""+(char) 27 ;

	/**
		ansi character for reset
		if we print this, all setting of colored text will be reverted
		we print this after printing colored text
	**/
	public static final String Reset = ESCAPE + "[0m";

	public static final String Red = ESCAPE + "[31m";
	public static final String Blue = ESCAPE +  "[94m";
	public static final String Green = ESCAPE +  "[32m";
	public static final String Yellow = ESCAPE +  "[93m";
	public static final String White = ESCAPE +  "[97m";

	/**
		in case of pritning this, current line of terminal will be cleaned!
	**/
	public static final String CLEARER = "\033[H\033[2J";

	/**
		in case of pritning this, current line of terminal will be cleaned!
	**/
	public static final String LINE_DELETER = "\u001b[K";

	/**
		print the toPrint string with the specified color
		and after printing, we reset terminal printing color
	**/
	public static void print(String toPrint, String color){
		String colorer = White;
		switch (color){
			case "RED":
				colorer = Red; break;
			case "BLUE":
				colorer = Blue; break;
			case "GREEN":
				colorer = Green; break;
			case "YELLOW":
				colorer = Yellow; break;
			default:
				colorer = White;
		}
		System.out.println( colorer + toPrint + Reset );
		System.out.flush();
	}

	/**
	 print an error in red and exit whole program
	**/
	public static void PError(String errorText){
		//clearConsule();
		print(errorText, "RED");
		System.exit(0);
	}

	/**
		clear consule with prinitng the clean cunsole escape character
	**/
	public static void clearConsule() {
		System.out.print(CLEARER);
		System.out.flush();
	}

	/**
		we want to make terminal handy here
		what is that mean?
		set the buffer of terminal to one
		why? if uer enterred a key, we recieve it continuesly not after hittinh enter
	 	we can handle this in makefile but i wanted to do it here!
	 **/
	public static void makeTerminalHandy(){
		try{
			Runtime.getRuntime().exec(new String[]{"/bin/sh","-c","stty -icanon min 1 </dev/tty"}).waitFor();
			TerminalUtil.print("making terminal handy (no buffer)!" ,"YELLOW");
		}
		catch (Exception e){
			TerminalUtil.PError("couldnt change terminal buffer!");
		}
	}

	/**
		we want to make terminal normal
		we should reset buffer
		read also : makeTerminalHandy
	 	we can handle this in makefile but i wanted to do it here!
	 **/
	public static void makeTerminalNormal(){
		try{
			Runtime.getRuntime().exec(new String[]{"/bin/sh","-c","stty icanon </dev/tty"});
		}
		catch (Exception e){
			TerminalUtil.PError("couldnt make terminal normal!");
		}
	}


	/**
		hardest method to write, probably easiest to findout
		it get a character from user like c's getch
		but is that easy? no! ofcourse not
		because java is such platform independent and we can not have low level access

		what we have here?
		we use System.in (input stream) and read byte by byte from it
		we can only read one chacter at a time with system.in.read()
		for handling problem of esc = 27 and arrow_up = 27 - 93 - 65
		we read a 3-byte array
		if the length of input is 1? it return 1 as bytesRead and return garbage value and data[1] and data[2]
		so if the bytesRead == 1 : we get one character in data[0] such as esc or other chacters
		of the bytesRead == 3 : we get arrow key with escape character as data[0] and other characters in data[1] and data[2]

		read also ETCUtil.arrowKeyToChar
	**/
	public static char getChar(){ // tricky sensetive code
		try{
			byte[] data  = new byte[3];
			int bytesRead = System.in.read(data);
			if (bytesRead == 3){// arrow key found
				int sum = data[0] + data[1] + data[2];
				return (char) (sum + 10); // gharar dad baraye arrowkey ha
			}
			else  // otherwise : one character
				return (char) (data[0]);
		} catch(Exception e){
			TerminalUtil.PError("error in getting char from user with system.in\nexiting");
		}
		return ' '; // should not reach here
	}


	private TerminalUtil() {}

}
