/* this part will be added to java files directly! */
package syntaxhighlighter;

import java.io.*;

class Symbol {

	public String content;
	public TokenType tokenType;
	public int yyline, yycolumn;

	public Symbol( TokenType tokenType, int yyline, int yycolumn, String content ) {
		this.content = content;
		this.tokenType = tokenType;
		this.yyline = yyline;
		this.yycolumn = yycolumn;
	}

}

enum TokenType {

	AUTO, DOUBLE,
	INT, STRUCT,
	CONST, FLOAT,
	SHORT, UNSIGNED,
	BREAK, ELSE,
	LONG, SWITCH,
	CONTINUE, FOR,
	SIGNED, VOID,
	CASE, ENUM,
	REGISTER, TYPEDEF,
	DEFAULT, GOTO,
	SIZEOF, VOLATILE,
	CHAR, EXTERN,
	RETURN, UNION,
	DO, IF,
	STATIC, WHILE,
	LESSTHAN, MORETHAN,
	IDENTIFIER, INTEGERLITERAL,
	FLOATLITERAL, ENTER, TAB,
	SPECIAL_CHARACTER, STRING,
	COMMENT, NORMAL_CHARACTER,
	NOTHING, EOF;

}


/***** options and macros (declerations) *****/
%%

%class MyScanner //name of output class

%public // class is public, why? accessible out of package!
%final // class is final, why anyone should inherit an autogenrated class?



%unicode //input file use the last version of unicode!

%line // line counting: current line can be accesssed with the variable yyline
%column // column counting: same as line!

%type Symbol

%function next

%state STRING, CHARACTER

LineTerminator = \r|\n|\r\n // support linux line ending and windows line ending
InputCharacter = [^\r\n] // evething except line terminator is input character!

WhiteSpace = {LineTerminator} | [ \t\f] // tab and space and form feeds are WhiteSpace

CStyleComment = "/*"~"*/"
OneLineComment = "//" {InputCharacter}* {LineTerminator}

Comment = {CStyleComment}|{OneLineComment}

Letter = [A-Za-z]
Digit = [0-9]
Underscore = "_"

Identifier = {Letter} ({Letter}|{Digit}|{Underscore})*

Zero = 0
Octal = 0[0-7]+
Decimal = [1-9][0-9]*
HexaDecimal = [0][xX][0-9a-fA-F]+;

IntegerNumbers = {Zero}|{Octal}|{Decimal}|{HexaDecimal}

NormalFloat = ( ({Digit}+\.{Digit}*) | ({Digit}*\.{Digit}+) )
ScientificFloat = ( {NormalFloat}|{Zero}|{Decimal} ) "e" ( \+|\- )? {Digit}+

FloatNumbers = NormalFloat | ScientificFloat

StringCharacter = [^\n\r\t\v\b\f\a\?\0\\]
SingleCharacter = [^\n\r\t\v\b\f\a\?\0\\]

NormalCharacter = "'" {SingleCharacter} "'"


/******** lexical rules ***********/
%%

<YYINITIAL> {

	/* keywords */
	"auto"          { return new Symbol( TokenType.AUTO, yyline, yycolumn, "auto" ); }
	"double"        { return new Symbol( TokenType.DOUBLE, yyline, yycolumn, "double" ); }
	"int"           { return new Symbol( TokenType.INT, yyline, yycolumn, "int" ); }
	"struct"        { return new Symbol( TokenType.STRUCT, yyline, yycolumn, "struct" ); }
	"const"         { return new Symbol( TokenType.CONST, yyline, yycolumn, "const" ); }
	"float"         { return new Symbol( TokenType.FLOAT, yyline, yycolumn, "float" ); }
	"short"         { return new Symbol( TokenType.SHORT, yyline, yycolumn, "short" ); }
	"unsigned"      { return new Symbol( TokenType.UNSIGNED, yyline, yycolumn, "unsigned" ); }
	"break"         { return new Symbol( TokenType.BREAK, yyline, yycolumn, "break" ); }
	"else"          { return new Symbol( TokenType.ELSE, yyline, yycolumn, "else" ); }
	"long"          { return new Symbol( TokenType.LONG, yyline, yycolumn, "long" ); }
	"switch"        { return new Symbol( TokenType.SWITCH, yyline, yycolumn, "switch" ); }
	"continue"      { return new Symbol( TokenType.CONTINUE, yyline, yycolumn, "continue" ); }
	"for"           { return new Symbol( TokenType.FOR, yyline, yycolumn, "for" ); }
	"signed"        { return new Symbol( TokenType.SIGNED, yyline, yycolumn, "signed" ); }
	"void"          { return new Symbol( TokenType.VOID, yyline, yycolumn, "void" ); }
	"case"          { return new Symbol( TokenType.CASE, yyline, yycolumn, "case" ); }
	"enum"          { return new Symbol( TokenType.ENUM, yyline, yycolumn, "enum" ); }
	"register"      { return new Symbol( TokenType.REGISTER, yyline, yycolumn, "register" ); }
	"typedef"       { return new Symbol( TokenType.TYPEDEF, yyline, yycolumn, "typedef" ); }
	"default"       { return new Symbol( TokenType.DEFAULT, yyline, yycolumn, "default" ); }
	"goto"          { return new Symbol( TokenType.GOTO, yyline, yycolumn, "goto" ); }
	"sizeof"        { return new Symbol( TokenType.SIZEOF, yyline, yycolumn, "sizeof" ); }
	"volatile"      { return new Symbol( TokenType.VOLATILE, yyline, yycolumn, "volatile" ); }
	"char"          { return new Symbol( TokenType.CHAR, yyline, yycolumn, "char" ); }
	"extern"        { return new Symbol( TokenType.EXTERN, yyline, yycolumn, "extern" ); }
	"return"        { return new Symbol( TokenType.RETURN, yyline, yycolumn, "return" ); }
	"union"         { return new Symbol( TokenType.UNION, yyline, yycolumn, "union" ); }
	"do"            { return new Symbol( TokenType.DO, yyline, yycolumn, "do" ); }
	"if"            { return new Symbol( TokenType.IF, yyline, yycolumn, "if" ); }
	"static"        { return new Symbol( TokenType.STATIC, yyline, yycolumn, "static" ); }
	"while"         { return new Symbol( TokenType.WHILE, yyline, yycolumn, "while" ); }
	"<"             { return new Symbol( TokenType.LESSTHAN, yyline, yycolumn, "lessthan" ); }
	">"             { return new Symbol( TokenType.MORETHAN, yyline, yycolumn, "morethan" ); }

	{Identifier}    { return new Symbol( TokenType.IDENTIFIER, yyline, yycolumn, yytext() ); }

	{IntegerNumbers}    { return new Symbol( TokenType.INTEGERLITERAL, yyline, yycolumn, yytext() ); }

	{NormalFloat}  { return new Symbol( TokenType.FLOATLITERAL, yyline, yycolumn, yytext() ); }
	{ScientificFloat}   { return new Symbol( TokenType.FLOATLITERAL, yyline, yycolumn, yytext() ); }

	{Comment}       { return new Symbol( TokenType.COMMENT, yyline, yycolumn, yytext() ); }

	"\t"           { return new Symbol( TokenType.TAB, yyline, yycolumn, "\t" ); }

	"\""              { yybegin( STRING ); return new Symbol( TokenType.STRING, yyline, yycolumn, yytext() ); }

	//{NormalCharacter}   { return new Symbol( TokenType.NORMAL_CHARACTER, yyline, yycolumn, yytext() ); }
	"'"             { yybegin( CHARACTER ); return new Symbol( TokenType.NORMAL_CHARACTER, yyline, yycolumn, "'" ); }

	{LineTerminator}    {return new Symbol( TokenType.ENTER, yyline, yycolumn, "\n" ); }

	[^]             { return new Symbol( TokenType.NOTHING, yyline, yycolumn, yytext() ); }

	//<<EOF>>

}

<STRING> {

	"\""          { yybegin( YYINITIAL ); return new Symbol( TokenType.STRING, yyline, yycolumn, yytext() ); }

//	{StringCharacter}+      { return new Symbol( TokenType.STRING, yyline, yycolumn, yytext() );  }

	"\\n"       { return new Symbol( TokenType.SPECIAL_CHARACTER, yyline, yycolumn, "\\n" ); }
	"\\t"       { return new Symbol( TokenType.SPECIAL_CHARACTER, yyline, yycolumn, "\\t" ); }
	"\\v"       { return new Symbol( TokenType.SPECIAL_CHARACTER, yyline, yycolumn, "\\v" ); }
	"\\b"       { return new Symbol( TokenType.SPECIAL_CHARACTER, yyline, yycolumn, "\\b" ); }
	"\\r"       { return new Symbol( TokenType.SPECIAL_CHARACTER, yyline, yycolumn, "\\r" ); }
	"\\f"       { return new Symbol( TokenType.SPECIAL_CHARACTER, yyline, yycolumn, "\\f" ); }
	"\\a"       { return new Symbol( TokenType.SPECIAL_CHARACTER, yyline, yycolumn, "\\a" ); }
	"\\\\"      { return new Symbol( TokenType.SPECIAL_CHARACTER, yyline, yycolumn, "\\\\" ); }
	"\\?"       { return new Symbol( TokenType.SPECIAL_CHARACTER, yyline, yycolumn, "\\?" ); }
	"\\'"       { return new Symbol( TokenType.SPECIAL_CHARACTER, yyline, yycolumn, "\\'" ); }
	"\\\""      { return new Symbol( TokenType.SPECIAL_CHARACTER, yyline, yycolumn, "\\\"" ); }
	"\\0"       { return new Symbol( TokenType.SPECIAL_CHARACTER, yyline, yycolumn, "\\0" ); }

	.           { return new Symbol( TokenType.STRING, yyline, yycolumn, yytext() ); }


}

<CHARACTER> {

	"\\n"\'     { yybegin( YYINITIAL ); return new Symbol( TokenType.SPECIAL_CHARACTER, yyline, yycolumn, "\\n'" ); }
	"\\t"\'     { yybegin( YYINITIAL ); return new Symbol( TokenType.SPECIAL_CHARACTER, yyline, yycolumn, "\\t'" ); }
	"\\v"\'     { yybegin( YYINITIAL ); return new Symbol( TokenType.SPECIAL_CHARACTER, yyline, yycolumn, "\\v'" ); }
	"\\b"\'     { yybegin( YYINITIAL ); return new Symbol( TokenType.SPECIAL_CHARACTER, yyline, yycolumn, "\\b'" ); }
	"\\r"\'     { yybegin( YYINITIAL ); return new Symbol( TokenType.SPECIAL_CHARACTER, yyline, yycolumn, "\\r'" ); }
	"\\f"\'     { yybegin( YYINITIAL ); return new Symbol( TokenType.SPECIAL_CHARACTER, yyline, yycolumn, "\\f'" ); }
	"\\a"\'     { yybegin( YYINITIAL ); return new Symbol( TokenType.SPECIAL_CHARACTER, yyline, yycolumn, "\\a'" ); }
	"\\\\"\'    { yybegin( YYINITIAL ); return new Symbol( TokenType.SPECIAL_CHARACTER, yyline, yycolumn, "\\\\'" ); }
	"\\?"\'     { yybegin( YYINITIAL ); return new Symbol( TokenType.SPECIAL_CHARACTER, yyline, yycolumn, "\\?'" ); }
	"\\'"\'     { yybegin( YYINITIAL ); return new Symbol( TokenType.SPECIAL_CHARACTER, yyline, yycolumn, "\\''" ); }
	"\\\""\'    { yybegin( YYINITIAL ); return new Symbol( TokenType.SPECIAL_CHARACTER, yyline, yycolumn, "\\\"'" ); }
	"\\0"\'     { yybegin( YYINITIAL ); return new Symbol( TokenType.SPECIAL_CHARACTER, yyline, yycolumn, "\\0'" ); }

	{SingleCharacter}\'     { yybegin( YYINITIAL ); return new Symbol( TokenType.NORMAL_CHARACTER, yyline, yycolumn, yytext() ); }


}

<<EOF>>             { return new Symbol( TokenType.EOF, yyline, yycolumn, "EOF" ); }
