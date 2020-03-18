/* this part will be added to java files directly! */
package syntaxhighlighter;

import java.io.*;



%% /* * * * * options and macros (declerations) * * * * * * * */


%class MyScanner //name of output class

%public // class is public, why? accessible out of package!
%final // class is final, why anyone should inherit an autogenrated class?

%buffer 1000000
%unicode //input file use the last version of unicode!

%line // line counting: current line can be accesssed with the variable yyline
%column // column counting: same as line!


%function next // name of function (instead of yylex)
%type Symbol //define output of out next() function

%state STRING
%state CHARACTER 

LineTerminator = \r|\n|\r\n // support linux line ending and windows line ending
InputCharacter = [^\r\n] // evething except line terminator is input character!

WhiteSpace = {LineTerminator} | [ \t\f] // tab and space and form feeds are WhiteSpace

/*   *   *   *   *  *  comments  *   *   *   *    *   *  */
CStyleComment = "/*"~"*/"
OneLineComment = "//" {InputCharacter}* {LineTerminator}
Comment = {CStyleComment}|{OneLineComment}


Letter = [A-Za-z]
Digit = [0-9]
Underscore = "_"
Identifier = {Underscore}* {Letter} ({Letter}|{Digit}|{Underscore})*


/****** numbers *******/
Sign = (\+|\-)?
DecimalInt = {Sign}[0-9]+
DecimalLong = {DecimalInt}[L]
HexaDecimal = {Sign}[0][xX][0-9a-fA-F]+
IntegerNumber ={DecimalInt}|{DecimalLong}|{HexaDecimal}

Ee = (e|E)
Num = {FloatNumber}|{DecimalInt}
FloatNumber = {Sign}(\.{Digit}+) | {Sign}({Digit}+\.) |{Sign}({Digit}+\.{Digit}+)
ScientificFloat = {Num}{Ee}{Sign}{DecimalInt} //todo space

RealNumber = {FloatNumber} | {FloatNumber}[F] | ScientificFloat



/* * * *  string and characters * * * * * */

SingleCharacter = [^\n\r\t\v\b\f\a\?\0\\]

NormalCharacter = "'" {SingleCharacter} "'"



%%  /* * * * * * * * lexical rules * * * * * ** * * * */

<YYINITIAL> {  // state e avvalie ke tush hastim

	/* keywords */
	"int"             { return new Symbol( yytext(), TokenType.RESERVED_WORD, yyline, yycolumn ); }
	"if"               { return new Symbol( yytext(), TokenType.RESERVED_WORD, yyline, yycolumn ); }
	"short"        { return new Symbol( yytext(), TokenType.RESERVED_WORD, yyline, yycolumn ); }
	"else"          { return new Symbol( yytext(), TokenType.RESERVED_WORD, yyline, yycolumn ); }
	"long"         { return new Symbol( yytext(), TokenType.RESERVED_WORD, yyline, yycolumn ); }
	"switch"      { return new Symbol( yytext(), TokenType.RESERVED_WORD, yyline, yycolumn ); }
	"float"         { return new Symbol( yytext(), TokenType.RESERVED_WORD, yyline, yycolumn ); }
	"case"         { return new Symbol( yytext(), TokenType.RESERVED_WORD, yyline, yycolumn ); }
	"double"     { return new Symbol( yytext(), TokenType.RESERVED_WORD, yyline, yycolumn ); }
	"default"    { return new Symbol( yytext(), TokenType.RESERVED_WORD, yyline, yycolumn ); }
	"char"         { return new Symbol( yytext(), TokenType.RESERVED_WORD, yyline, yycolumn ); }
	"auto"         { return new Symbol( yytext(), TokenType.RESERVED_WORD, yyline, yycolumn ); }
	"string"       { return new Symbol( yytext(), TokenType.RESERVED_WORD, yyline, yycolumn ); }
	"volatile"    { return new Symbol( yytext(), TokenType.RESERVED_WORD, yyline, yycolumn ); }
	"const"       { return new Symbol( yytext(), TokenType.RESERVED_WORD, yyline, yycolumn ); }
	"static"       { return new Symbol( yytext(), TokenType.RESERVED_WORD, yyline, yycolumn ); }
	"for"           { return new Symbol( yytext(), TokenType.RESERVED_WORD, yyline, yycolumn ); }
	"goto"        { return new Symbol( yytext(), TokenType.RESERVED_WORD, yyline, yycolumn ); }
	"foreach"   { return new Symbol( yytext(), TokenType.RESERVED_WORD, yyline, yycolumn ); }
	"signed"     { return new Symbol( yytext(), TokenType.RESERVED_WORD, yyline, yycolumn ); }
	"while"       { return new Symbol( yytext(), TokenType.RESERVED_WORD, yyline, yycolumn ); }
	"bool"        { return new Symbol( yytext(), TokenType.RESERVED_WORD, yyline, yycolumn ); }
	"do"           { return new Symbol( yytext(), TokenType.RESERVED_WORD, yyline, yycolumn ); }
	"void"        { return new Symbol( yytext(), TokenType.RESERVED_WORD, yyline, yycolumn ); }
	"in"            { return new Symbol( yytext(), TokenType.RESERVED_WORD, yyline, yycolumn ); }
	"return"    { return new Symbol( yytext(), TokenType.RESERVED_WORD, yyline, yycolumn ); }

 	"break"         { return new Symbol( yytext(), TokenType.RESERVED_WORD, yyline, yycolumn ); }
	"record"       { return new Symbol( yytext(), TokenType.RESERVED_WORD, yyline, yycolumn ); }
	"continue"   { return new Symbol( yytext(), TokenType.RESERVED_WORD, yyline, yycolumn ); }
	"new"           { return new Symbol( yytext(), TokenType.RESERVED_WORD, yyline, yycolumn ); }
	"until"          { return new Symbol( yytext(), TokenType.RESERVED_WORD, yyline, yycolumn ); }
	"sizeof"        { return new Symbol( yytext(), TokenType.RESERVED_WORD, yyline, yycolumn ); }
	"function"   { return new Symbol( yytext(), TokenType.RESERVED_WORD, yyline, yycolumn ); }
	"do"             { return new Symbol( yytext(), TokenType.RESERVED_WORD, yyline, yycolumn ); }
	"println"     { return new Symbol( yytext(), TokenType.RESERVED_WORD, yyline, yycolumn ); }
	"true"         { return new Symbol( yytext(), TokenType.RESERVED_WORD, yyline, yycolumn ); }
	"false"        { return new Symbol( yytext(), TokenType.RESERVED_WORD, yyline, yycolumn ); }

	"<"          { return new Symbol( yytext(), TokenType.OTHER, yyline, yycolumn ); }
	">"          { return new Symbol( yytext(), TokenType.OTHER, yyline, yycolumn ); }

	{Identifier}             { return new Symbol( yytext(), TokenType.IDENTIFIER, yyline, yycolumn); }

	{IntegerNumber} { return new Symbol( yytext(), TokenType.INTEGER_NUMBER, yyline, yycolumn ); }

	{RealNumber}      { return new Symbol( yytext(), TokenType.REAL_NUMBER, yyline, yycolumn ); }

	{Comment}          { return new Symbol( yytext(), TokenType.COMMENT, yyline, yycolumn ); }

	"\t"                        { return new Symbol( yytext(), TokenType.TAB, yyline, yycolumn ); }
    
    {LineTerminator}    {return new Symbol( "\n", TokenType.ENTER, yyline, yycolumn ); }

    /* jump to another state: String */
	"\""                      { yybegin( STRING ); return new Symbol( yytext(), TokenType.STRING_AND_CHARACTER, yyline, yycolumn ); }

	/* jump to another state: character */
	"'"                     { yybegin( CHARACTER ); return new Symbol( "'", TokenType.STRING_AND_CHARACTER, yyline, yycolumn ); }

	
	[^]             { return new Symbol( yytext(), TokenType.NOTHING, yyline, yycolumn ); }

	//<<EOF>>
}

/* * * * * * * *  * * * State : S T R I N G * * * * * * * */
<STRING> {

	"\""          { yybegin( YYINITIAL ); return new Symbol(  yytext(), TokenType.STRING_AND_CHARACTER, yyline, yycolumn ); }

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

/* * * * * * * *  * * * State : C H A RA C T E R * * * * * * * */
<CHARACTER> {

    "\\n" \'     { yybegin( YYINITIAL ); return new Symbol( "\\n'", TokenType.SPECIAL_CHARACTER, yyline, yycolumn ); }
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

<<EOF>>           { return new Symbol("EOF", TokenType.EOF, yyline, yycolumn ); }

[^]   { return new Symbol( yytext(), TokenType.NOTHING, yyline, yycolumn ); }
