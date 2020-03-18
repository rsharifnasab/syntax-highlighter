/* this part will be added to java files directly! */
package syntaxhighlighter;

import java.io.*;




/***** options and macros (declerations) *****/
%%

%class MyScanner //name of output class

%public // class is public, why? accessible out of package!
%final // class is final, why anyone should inherit an autogenrated class?


%unicode //input file use the last version of unicode!

%line // line counting: current line can be accesssed with the variable yyline
%column // column counting: same as line!


%function next // name of function (instead of yylex)
%type Symbol //define output of out next() function

%state STRING, CHARACTER

LineTerminator = \r|\n|\r\n // support linux line ending and windows line ending
InputCharacter = [^\r\n] // evething except line terminator is input character!

WhiteSpace = {LineTerminator} | [ \t\f] // tab and space and form feeds are WhiteSpace

/****** comments *******/
CStyleComment = "/*"~"*/"
OneLineComment = "//" {InputCharacter}* {LineTerminator}
Comment = {CStyleComment}|{OneLineComment}


Letter = [A-Za-z]
Digit = [0-9]
Underscore = "_"
Identifier = {Letter} ({Letter}|{Digit}|{Underscore})*


/****** numbers *******/
Sign = (\+|\-)?
DecimalInt = {Sign}[0-9]+
DecimalLong = {DecimalInt}[L]
HexaDecimal = {Sign}[0][xX][0-9a-fA-F]+
IntegerNumber ={DecimalInt}|{DecimalLong}|{HexaDecimal}

FloatNumber = {Sign}(\.{Digit}+) | ({Digit}+\.) | ({Digit}+\.{Digit}+)
RealNumber = {FloatNumber} | {FloatNumber}[F]

ScientificFloat = ({FloatNumber}|{DecimalInt})[eE]{Sign}{DecimalInt} //todo space

/**** string and characters *********/

StringCharacter = [^\n\r\t\v\b\f\a\?\0\\]
SingleCharacter = [^\n\r\t\v\b\f\a\?\0\\]

NormalCharacter = "'" {SingleCharacter} "'"


/******** lexical rules ***********/
%%

<YYINITIAL> {

	/* keywords */
	"int"        { return new Symbol( yytext(), TokenType.RESERVED_WORD, yyline, yycolumn ); }
	"if"         { return new Symbol( yytext(), TokenType.RESERVED_WORD, yyline, yycolumn ); }
	"short"      { return new Symbol( yytext(), TokenType.RESERVED_WORD, yyline, yycolumn ); }
	"else"       { return new Symbol( yytext(), TokenType.RESERVED_WORD, yyline, yycolumn ); }
	"long"       { return new Symbol( yytext(), TokenType.RESERVED_WORD, yyline, yycolumn ); }
	"switch"     { return new Symbol( yytext(), TokenType.RESERVED_WORD, yyline, yycolumn ); }
	"float"      { return new Symbol( yytext(), TokenType.RESERVED_WORD, yyline, yycolumn ); }
	"case"       { return new Symbol( yytext(), TokenType.RESERVED_WORD, yyline, yycolumn ); }
	"double"     { return new Symbol( yytext(), TokenType.RESERVED_WORD, yyline, yycolumn ); }
	"default"    { return new Symbol( yytext(), TokenType.RESERVED_WORD, yyline, yycolumn ); }
	"char"       { return new Symbol( yytext(), TokenType.RESERVED_WORD, yyline, yycolumn ); }
	"auto"       { return new Symbol( yytext(), TokenType.RESERVED_WORD, yyline, yycolumn ); }
	"string"     { return new Symbol( yytext(), TokenType.RESERVED_WORD, yyline, yycolumn ); }
	"volatile"   { return new Symbol( yytext(), TokenType.RESERVED_WORD, yyline, yycolumn ); }
	"const"      { return new Symbol( yytext(), TokenType.RESERVED_WORD, yyline, yycolumn ); }
	"static"     { return new Symbol( yytext(), TokenType.RESERVED_WORD, yyline, yycolumn ); }
	"for"        { return new Symbol( yytext(), TokenType.RESERVED_WORD, yyline, yycolumn ); }
	"goto"       { return new Symbol( yytext(), TokenType.RESERVED_WORD, yyline, yycolumn ); }
	"foreach"    { return new Symbol( yytext(), TokenType.RESERVED_WORD, yyline, yycolumn ); }
	"signed"     { return new Symbol( yytext(), TokenType.RESERVED_WORD, yyline, yycolumn ); }
	"while"      { return new Symbol( yytext(), TokenType.RESERVED_WORD, yyline, yycolumn ); }
	"bool"       { return new Symbol( yytext(), TokenType.RESERVED_WORD, yyline, yycolumn ); }
	"do"         { return new Symbol( yytext(), TokenType.RESERVED_WORD, yyline, yycolumn ); }
	"void"       { return new Symbol( yytext(), TokenType.RESERVED_WORD, yyline, yycolumn ); }
	"in"         { return new Symbol( yytext(), TokenType.RESERVED_WORD, yyline, yycolumn ); }
	"return"     { return new Symbol( yytext(), TokenType.RESERVED_WORD, yyline, yycolumn ); }

 	"break"      { return new Symbol( yytext(), TokenType.RESERVED_WORD, yyline, yycolumn ); }
	"record"     { return new Symbol( yytext(), TokenType.RESERVED_WORD, yyline, yycolumn ); }
	"continue"   { return new Symbol( yytext(), TokenType.RESERVED_WORD, yyline, yycolumn ); }
	"new"        { return new Symbol( yytext(), TokenType.RESERVED_WORD, yyline, yycolumn ); }
	"until"      { return new Symbol( yytext(), TokenType.RESERVED_WORD, yyline, yycolumn ); }
	"sizeof"     { return new Symbol( yytext(), TokenType.RESERVED_WORD, yyline, yycolumn ); }
	"function"   { return new Symbol( yytext(), TokenType.RESERVED_WORD, yyline, yycolumn ); }
	"do"         { return new Symbol( yytext(), TokenType.RESERVED_WORD, yyline, yycolumn ); }
	"println"    { return new Symbol( yytext(), TokenType.RESERVED_WORD, yyline, yycolumn ); }
	"true"       { return new Symbol( yytext(), TokenType.RESERVED_WORD, yyline, yycolumn ); }
	"false"      { return new Symbol( yytext(), TokenType.RESERVED_WORD, yyline, yycolumn ); }

	"<"          { return new Symbol( yytext(), TokenType.OTHER, yyline, yycolumn ); }
	">"          { return new Symbol( yytext(), TokenType.OTHER, yyline, yycolumn ); }

	{Identifier} { return new Symbol( yytext(), TokenType.IDENTIFIER, yyline, yycolumn); }

/*
Sign = (\+|\-)?
DecimalInt = {Sign}[0-9]+
DecimalLong = {DecimalInt}[L]
HexaDecimal = {Sign}[0][xX][0-9a-fA-F]+
IntegerNumber ={DecimalInt}|{DecimalLong}|{HexaDecimal}

FloatNumber = {Sign}(\.{Digit}+) | ({Digit}+\.) | ({Digit}+\.{Digit}+)
RealNumber = {FloatNumber} | {FloatNumber}[F]

ScientificFloat = ({FloatNumber}|{DecimalInt})[eE]{Sign}{DecimalInt} //todo space

*/
	{IntegerNumber} { return new Symbol( yytext(), TokenType.RESERVED_WORD, yyline, yycolumn ); }

	{RealNumber}  { return new Symbol( yytext(), TokenType.RESERVED_WORD, yyline, yycolumn ); }

	{ScientificFloat}  { return new Symbol( yytext(), TokenType.RESERVED_WORD, yyline, yycolumn ); }


	{Comment}       { return new Symbol( yytext(), TokenType.COMMENT, yyline, yycolumn ); }

	"\t"           { return new Symbol( yytext(), TokenType.TAB, yyline, yycolumn ); }

	"\""              { yybegin( STRING ); return new Symbol( yytext(), TokenType.STRING_AND_CHARACTER, yyline, yycolumn ); }

	//{NormalCharacter}   { return new Symbol( TokenType.NORMAL_CHARACTER, yyline, yycolumn, yytext() ); }
	"'"             { yybegin( CHARACTER ); return new Symbol( "'", TokenType.STRING_AND_CHARACTER, yyline, yycolumn ); }

	{LineTerminator}    {return new Symbol( "\n", TokenType.ENTER, yyline, yycolumn ); }

	[^]             { return new Symbol( yytext(), TokenType.NOTHING, yyline, yycolumn ); }

	//<<EOF>>

}

<STRING> {

	"\""          { yybegin( YYINITIAL ); return new Symbol(  yytext(), TokenType.STRING_AND_CHARACTER, yyline, yycolumn ); }

	//	{StringCharacter}+      { return new Symbol( TokenType.STRING, yyline, yycolumn, yytext() );  }

	"\\n"       { return new Symbol( yytext(), TokenType.SPECIAL_CHARACTER, yyline, yycolumn ); }
	"\\t"       { return new Symbol( yytext(), TokenType.SPECIAL_CHARACTER, yyline, yycolumn ); }
	"\\v"       { return new Symbol( yytext(), TokenType.SPECIAL_CHARACTER, yyline, yycolumn ); }
	"\\b"       { return new Symbol( yytext(), TokenType.SPECIAL_CHARACTER, yyline, yycolumn ); }
	"\\r"       { return new Symbol( yytext(), TokenType.SPECIAL_CHARACTER, yyline, yycolumn ); }
	"\\f"       { return new Symbol( yytext(), TokenType.SPECIAL_CHARACTER, yyline, yycolumn ); }
	"\\a"       { return new Symbol( yytext(), TokenType.SPECIAL_CHARACTER, yyline, yycolumn ); }
	"\\\\"      { return new Symbol( yytext(), TokenType.SPECIAL_CHARACTER, yyline, yycolumn ); }
	"\\?"       { return new Symbol( yytext(), TokenType.SPECIAL_CHARACTER, yyline, yycolumn ); }
	"\\'"       { return new Symbol( yytext(), TokenType.SPECIAL_CHARACTER, yyline, yycolumn ); }
	"\\\""      { return new Symbol( yytext(), TokenType.SPECIAL_CHARACTER, yyline, yycolumn ); }
	"\\0"       { return new Symbol( yytext(), TokenType.SPECIAL_CHARACTER, yyline, yycolumn ); }

	.           { return new Symbol( yytext(), TokenType.STRING_AND_CHARACTER, yyline, yycolumn ); }


}

<CHARACTER> {

	"\\n"\'     { yybegin( YYINITIAL ); return new Symbol( "\\n'", TokenType.SPECIAL_CHARACTER, yyline, yycolumn ); }
	"\\t"\'     { yybegin( YYINITIAL ); return new Symbol( "\\t'", TokenType.SPECIAL_CHARACTER, yyline, yycolumn ); }
	"\\v"\'     { yybegin( YYINITIAL ); return new Symbol( "\\v'", TokenType.SPECIAL_CHARACTER, yyline, yycolumn ); }
	"\\b"\'     { yybegin( YYINITIAL ); return new Symbol( "\\b'", TokenType.SPECIAL_CHARACTER, yyline, yycolumn ); }
	"\\r"\'     { yybegin( YYINITIAL ); return new Symbol( "\\r'", TokenType.SPECIAL_CHARACTER, yyline, yycolumn ); }
	"\\f"\'     { yybegin( YYINITIAL ); return new Symbol( "\\f'", TokenType.SPECIAL_CHARACTER, yyline, yycolumn ); }
	"\\a"\'     { yybegin( YYINITIAL ); return new Symbol( "\\a'", TokenType.SPECIAL_CHARACTER, yyline, yycolumn  ); }
	"\\\\"\'    { yybegin( YYINITIAL ); return new Symbol( "\\\\'", TokenType.SPECIAL_CHARACTER, yyline, yycolumn ); }
	"\\?"\'     { yybegin( YYINITIAL ); return new Symbol( "\\?'", TokenType.SPECIAL_CHARACTER, yyline, yycolumn ); }
	"\\'"\'     { yybegin( YYINITIAL ); return new Symbol( "\\''", TokenType.SPECIAL_CHARACTER, yyline, yycolumn ); }
	"\\\""\'    { yybegin( YYINITIAL ); return new Symbol( "\\\"'", TokenType.SPECIAL_CHARACTER, yyline, yycolumn ); }
	"\\0"\'     { yybegin( YYINITIAL ); return new Symbol( "\\0'", TokenType.SPECIAL_CHARACTER, yyline, yycolumn ); }

	{SingleCharacter}\'  { yybegin( YYINITIAL ); return new Symbol( yytext(), TokenType.STRING_AND_CHARACTER, yyline, yycolumn ); }

}

<<EOF>>             { return new Symbol("EOF", TokenType.EOF, yyline, yycolumn ); }
