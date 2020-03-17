import java_cup.runtime.Symbol;

%%

%class Lexer
%unicode
%public
%final
%integer
%line
%column
%cup
 
%eofval{
    return createSymbol(sym.EOF);
%eofval}

%{
    // user custom code
    StringBuffer sb = new StringBuffer();//Hold a String.

    private Symbol createSymbol(int type) {
        return new Symbol(type, yyline+1, yycolumn+1);
    }

    private Symbol createSymbol(int type, Object value) {
        return new Symbol(type, yyline+1, yycolumn+1, value);
    }

%}

LineTerminator = \r|\n|\r\n
WhiteSpace     = {LineTerminator} | [ \t\f]
Comment        = "/*" [^*] ~"*/" | "/*" "*"+ "/"
Exponent       = [eE][\+\-]?[0-9]+
Float1         = [0-9]+ \. [0-9]+ {Exponent}?
Float2         = \.[0-9]+  {Exponent}?
Float3         = [0-9]+ \. {Exponent}?
Float4         = [0-9]+ {Exponent}
FloatLiteral   = {Float1} | {Float2} | {Float3} | {Float4}
Identifier     = [:jletter:] [:jletterdigit:]*
IntegerLiteral = 0 | [1-9][0-9]*
Char           = '\\[ nt0]' | '.'

%state STRING

%%

//Main initial state
<YYINITIAL> {
    /* reserved keywords */
    "print"                        { return createSymbol(sym.PRINT); }
    "float"                        { return createSymbol(sym.FLOAT); }
    "int"                          { return createSymbol(sym.INT); }
    "char"                         { return createSymbol(sym.CHAR); }
    "String"					             { return createSymbol(sym.STRING); }
    "while"                        { return createSymbol(sym.WHILE); }
    "do"                           { return createSymbol(sym.DO);}
    "if"                           { return createSymbol(sym.IF); }
    "else"                         { return createSymbol(sym.ELSE); }
    "void"                         { return createSymbol(sym.VOID); }
    "return"                       { return createSymbol(sym.RETURN); }
    "break"                        { return createSymbol(sym.BREAK); }
    "continue"                     { return createSymbol(sym.CONTINUE); }
    "new"                          { return createSymbol(sym.NEW); }


    /* identifiers */
    {Identifier}                   { return createSymbol(sym.IDENTIFIER, yytext()); }

    /* literals */
    {IntegerLiteral}               { return createSymbol(sym.INTEGER_LITERAL, Integer.valueOf(yytext())); }
    {FloatLiteral}                 { return createSymbol(sym.DOUBLE_LITERAL, Double.valueOf(yytext())); }
    {Char}                         { String temp = (String) yytext().replaceAll("\'", "");
              if (Character.valueOf(temp.charAt(0)) == '\\') {
                char c = '\\';
                switch(Character.valueOf( temp.charAt(1))){
                  case 'n':
                    c = '\n';
                    break;
                  case 't':
                    c = '\t';
                    break;
                  case '0':
                    c='\0';
                    break;
                  case '"':
                    c='\"';
                    break;
                }
                return createSymbol(sym.CHARACTER_LITERAL, c);
              }
              return createSymbol(sym.CHARACTER_LITERAL, Character.valueOf( temp.charAt(0)));
        }

    /* String (New Initial State) */
    \"                             { sb.setLength(0); yybegin(STRING); }

    /* operators */
    "="                           { return createSymbol(sym.EQ); }
    ">"						                { return createSymbol(sym.GREATER); }
    "<"						                { return createSymbol(sym.LESS); }
    "!="					                { return createSymbol(sym.NOT_EQUAL); }
    "<="					                { return createSymbol(sym.LESS_EQ); }
    ">="					                { return createSymbol(sym.GREATER_EQ); }
    "=="                          { return createSymbol(sym.EQUAL); }
    "+"                           { return createSymbol(sym.PLUS); }
    "-"                           { return createSymbol(sym.MINUS); }
    "*"                           { return createSymbol(sym.MULTI); }
    "/"						                { return createSymbol(sym.DIV); }
    "%"						                { return createSymbol(sym.MOD); }
    "&&"					                { return createSymbol(sym.AND); }
    "||"					                { return createSymbol(sym.OR); }
    "!"						                { return createSymbol(sym.NOT); }

    /* Separators */
    "{"						                { return createSymbol(sym.LCURBRACKET); }
    "}"						                { return createSymbol(sym.RCURBRACKET);  }
    "["                           { return createSymbol(sym.LBRACKET); }
    "]"                           { return createSymbol(sym.RBRACKET); }
    ";"                           { return createSymbol(sym.SEMICOLON); }
    "("						                { return createSymbol(sym.LPAREN); }
    ")"						                { return createSymbol(sym.RPAREN); }
    ","                           { return createSymbol(sym.COMMA); }

    /* comments */
    {Comment}                      { /* ignore */ }

    /* whitespace */
    {WhiteSpace}                   { /* ignore */ }
}

/*Initial state for String.*/
<STRING> {
    \"                             { yybegin(YYINITIAL);
                                     return createSymbol(sym.STRING_LITERAL, sb.toString());
                                   }

    [^\n\r\'\"\\]+                   { sb.append(yytext()); }
    \\t                            { sb.append('\t'); }
    \\n                            { sb.append('\n'); }
    \\0                            { sb.append('\0');}
    \\\"                           { sb.append('\"'); }
    \\                             { sb.append('\\'); }
}

/* error fallback */
[^]                                { throw new RuntimeException((yyline+1) + ":" + (yycolumn+1) + ": illegal character <"+ yytext()+">"); }
