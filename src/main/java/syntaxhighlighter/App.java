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
    

		Symbol current;
		for (current = yylex.next(); !yylex.yyatEOF(); current = yylex.next() ){
			TokenType token = current.tokenType;
			switch(token){
                        
                case RESERVED_WORD:
                    output.write( "<span style=\"color:blue\"><b>" + current.content + "</b></span>" );
                    break;
            
                case IDENTIFIER:
                    output.write( "<span style=\"color:violet\">" + current.content + "</span>" );
                    break;
                
                case INTEGER_NUMBER:
                    output.write("<span style=\"color:orange\">" + current.content + "</span>");
                    break;
                
                case REAL_NUMBER:
                    output.write("<span style=\"color:orange\"><i>" + current.content + "</i></span>");
                    break;
                
       
                case STRING_AND_CHARACTER:
                    output.write("<span style=\"color:green\">" + current.content + "</span>");
                    break;
                    
                case SPECIAL_CHARACTER:
                	output.write( "<span style=\"color:green\"><i>" + current.content + "</i></span>" );
                	break;
                
                case COMMENT :
                    output.write( "<span style=\"color:gray\">" + commentToHTMLString( current.content ) + "</span>" );
                    break;
                
                
                case NOTHING:
                case OTHER:
                    output.write( "<span style=\"color:black\"><b>" + current.content + "</b></span>" );
          //          output.write( "&lt;" );     //todo
           //         output.write( "&gt;" );
                    break;
                
                
                          
                case ENTER:
                    output.write( "<br>\n\n" );
                    break;
                
                case TAB:
        			output.write( "<span class=\"indent\">            </span>" );
                    break;
                
                case EOF:
                    //TODO
                    System.out.println("done we reached eof");
                    break;
                    
                default:
                    throw new RuntimeException("chera inja resid? bad enum?");
			}
		}		
    
		printEndOfFile(output);
		yylex.yyclose();
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
