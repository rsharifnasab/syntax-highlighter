package syntaxhighlighter;
import java.io.*;
import org.jsoup.*;
import org.jsoup.nodes.*;
import org.jsoup.select.*;

public class App {

	final static String TAB = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";

	private static void printStartOfFile(String title,FileWriter output) throws IOException{
		output.write( "<!DOCTYPE html>\n" );
		output.write( "<html>\n" );
		output.write( "  <head>\n" );
		output.write( "      <title>" + title + "</title>\n" );
		output.write( "  </head>\n" );
		output.write( "  <body>\n" );
		output.write( "     <p>" );
	}

	private static void printEndOfFile(FileWriter output) throws IOException{
		output.write( "    </p>\n" );
		output.write( "  </body>\n" );
		output.write( "</html>\n");
		output.flush();
		output.close();
	}

	public static void main(String[] args) throws IOException {


      String html = "<html><head><title>Sample Title</title></head>"
         + "<body><p>Sample Content</p></body></html>";

      Document document = Jsoup.parse(html);
      System.out.println(document.title());
      Elements paragraphs = document.getElementsByTag("p");
      for (Element paragraph : paragraphs) {
            System.out.println(paragraph.text());
      }
  

		ArgumentParser argParser = new ArgumentParser(args);
		FileReader input = argParser.getFileReader();
		FileWriter output = argParser.getOutFileWriter();


		Document doc = Jsoup.parse("<html></html>");
		doc.body().addClass("body-styles-cls");
		doc.body().appendElement("div");
		System.out.println(doc.toString());


		printStartOfFile(argParser.getJustName(),output);

		MyScanner yylex = new MyScanner( input );

		for ( Symbol current = yylex.next(); current.tokenType != TokenType.EOF; current = yylex.next() ){
			TokenType token = current.tokenType;
			if ( token == TokenType.ENTER )
				output.write( "<br>\n" );
			else if ( token == TokenType.TAB )
			//	output.write( TAB );
				output.write( "<span class=\"indent\"></span>" );
			else if ( token == TokenType.LESSTHAN )
				output.write( "&lt;" );
			else if ( token == TokenType.MORETHAN )
				output.write( "&gt;" );
			else if ( token == TokenType.IDENTIFIER )
				output.write( "<span style=\"color:orange\">" + current.content + "</span>" );
			else if ( token == TokenType.INTEGERLITERAL )
				output.write( "<span style=\"color:violet\">" + current.content + "</span>" );
			else if ( token == TokenType.STRING )
				output.write("<span style=\"color:red\">" + current.content + "</span>");
			else if ( token == TokenType.SPECIAL_CHARACTER )
				output.write( "<span style=\"color:green\"><i>" + current.content + "</i></span>" );
			else if ( token == TokenType.COMMENT )
				output.write( "<span style=\"color:gray\">" + commentToHTMLString( current.content ) + "</span>" );
			else if ( token == TokenType.NORMAL_CHARACTER )
				output.write("<span style=\"color:green\">" + current.content + "</span>");
			else if ( token == TokenType.FLOATLITERAL )
				output.write("<span style=\"color:violet\"><i>" + current.content + "</i></span>");
			else if ( token != TokenType.NOTHING )
				output.write( "<span style=\"color:blue\"><b>" + current.content + "</b></span>" );
			else
				output.write( current.content );
		}

		printEndOfFile(output);
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
