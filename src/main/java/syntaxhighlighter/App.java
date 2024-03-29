package syntaxhighlighter;

import org.jsoup.*;
import org.jsoup.nodes.*;
import org.jsoup.select.*;

import java.io.*;

public class App {

    static final String SPACE = "&nbsp;";
    static final String TAB = SPACE + SPACE + SPACE;

    private static void printStartOfFile(String title, FileWriter output) throws IOException {
        output.write("<!DOCTYPE html>\n");
        output.write("<html>\n");
        output.write("  <head>\n");
        output.write("      <title>" + title + "</title>\n");
        output.write("  </head>\n");
        output.write("  <body>\n");
        output.write("     <p>");
    }

    private static void printEndOfFile(FileWriter output) throws IOException {
        output.write("    </p>\n");
        output.write("  </body>\n");
        output.write("</html>\n");
        output.flush();
        output.close();
    }

    public static void main(String[] args) throws IOException {

        ArgumentParser argParser = new ArgumentParser(args);
        FileReader input = argParser.getFileReader();
        FileWriter output = argParser.getOutFileWriter();

        printStartOfFile(argParser.getJustName(), output);

        MyScanner yylex = new MyScanner(input);

        Symbol current;
        for (current = yylex.next(); !yylex.yyatEOF(); current = yylex.next()) {
            switch (current.tokenType) {
                case RESERVED_WORD:
                    output.write(
                            "<span style=\"color:blue\"><b>" + current.content + "</b></span>");
                    break;

                case IDENTIFIER:
                    output.write("<span style=\"color:violet\">" + current.content + "</span>");
                    break;

                case INTEGER_NUMBER:
                    output.write("<span style=\"color:orange\">" + current.content + "</span>");
                    break;

                case REAL_NUMBER:
                    output.write(
                            "<span style=\"color:orange\"><i>" + current.content + "</i></span>");
                    break;

                case STRING_AND_CHARACTER:
                    output.write("<span style=\"color:green\">" + current.content + "</span>");
                    break;

                case SPECIAL_CHARACTER:
                    output.write(
                            "<span style=\"color:green\"><i>" + current.content + "</i></span>");
                    break;

                case COMMENT:
                    output.write(
                            "<span style=\"color:gray\">"
                                    + commentToHTML(current.content)
                                    + "</span>");
                    break;

                case NOTHING:
                case OTHER:
                    output.write(
                            "<span style=\"color:black\"><b>" + current.content + "</b></span>");
                    break;

                case ENTER:
                    output.write("<br>\n\n");
                    break;

                case TAB:
                    output.write(TAB);
                    break;

                case SPACE:
                    output.write(SPACE);
                    break;

                default:
                    throw new RuntimeException("chera inja resid? bad enum?");
            }
        }

        printEndOfFile(output);
        yylex.yyclose();
    }

    public static String commentToHTML(String comment) {
        StringBuilder returnValue = new StringBuilder();
        for (Character c : comment.toCharArray()) {
            switch (c) {
                case '\n':
                    returnValue.append("<br>");
                    break;

                case '\t':
                    returnValue.append(TAB);
                    break;

                case ' ':
                    returnValue.append(SPACE);
                    break;

                default:
                    returnValue.append(c);
            }
        }
        return returnValue.toString();
    }
}

