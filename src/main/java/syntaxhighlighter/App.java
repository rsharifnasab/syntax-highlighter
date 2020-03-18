package syntaxhighlighter;
import java.io.*;

public class App {

	final static String TAB = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";

	public static void main(String[] args) throws IOException {
		java.io.FileReader input = new ArgumentParser(args).getFileReader();
		String outputFile = args[0].split("\\.")[0] + ".html";

		Writer fileWriter = new FileWriter( outputFile );
		fileWriter.write( "<!DOCTYPE html>\n" );
		fileWriter.write( "<html>\n" );

		fileWriter.write( "<head>\n" );
		fileWriter.write( "<title>" + args[0] + "</title>\n" );
		//fileWriter.write( "<style>p.indent{ padding-left: 1.8em }</style>\n" );
		fileWriter.write( "</head>\n" );

		fileWriter.write( "<body>\n" );

		fileWriter.write( "<p>" );

		MyScanner yylex = new MyScanner( input );
		for ( Symbol current = yylex.next(); current.tokenType != TokenType.EOF; current = yylex.next() ){
			TokenType token = current.tokenType;
			if ( token == TokenType.ENTER )
				fileWriter.write( "<br>" );
			else if ( token == TokenType.TAB )
				fileWriter.write( TAB );
				//fileWriter.write( "<span class=\"indent\"></span>" );
			else if ( token == TokenType.LESSTHAN )
				fileWriter.write( "&lt;" );
			else if ( token == TokenType.MORETHAN )
				fileWriter.write( "&gt;" );
			else if ( token == TokenType.IDENTIFIER )
				fileWriter.write( "<span style=\"color:orange\">" + current.content + "</span>" );
			else if ( token == TokenType.INTEGERLITERAL )
				fileWriter.write( "<span style=\"color:violet\">" + current.content + "</span>" );
			else if ( token == TokenType.STRING )
				fileWriter.write("<span style=\"color:red\">" + current.content + "</span>");
			else if ( token == TokenType.SPECIAL_CHARACTER )
				fileWriter.write( "<span style=\"color:green\"><i>" + current.content + "</i></span>" );
			else if ( token == TokenType.COMMENT )
				fileWriter.write( "<span style=\"color:gray\">" + commentToHTMLString( current.content ) + "</span>" );
			else if ( token == TokenType.NORMAL_CHARACTER )
				fileWriter.write("<span style=\"color:green\">" + current.content + "</span>");
			else if ( token == TokenType.FLOATLITERAL )
				fileWriter.write("<span style=\"color:violet\"><i>" + current.content + "</i></span>");
			else if ( token != TokenType.NOTHING )
				fileWriter.write( "<span style=\"color:blue\"><b>" + current.content + "</b></span>" );
			else
				fileWriter.write( current.content );
		}

		fileWriter.write( "</p>\n</body>\n</html>\n" );
		fileWriter.flush();

		fileWriter.close();

	}

	public static String commentToHTMLString(String s ) throws IOException {
		String returnValue = "";
		for ( int i = 0; i < s.length(); i++ ) {
			if ( s.charAt(i) == '\n' )
				returnValue = returnValue.concat( "<br>" );
			else if ( s.charAt(i) == '\t' )
				returnValue = returnValue.concat( TAB );
			else
				returnValue = returnValue.concat( Character.toString( s.charAt( i ) ) );
		}
		return returnValue;
	}

}
