package syntaxhighlighter;

public class Symbol {

    public final String content;
    public final TokenType tokenType;
    public final int yyline;
    public final int yycolumn;

    // constructor
    public Symbol(String content, TokenType tokenType, int yyline, int yycolumn) {
        this.content = content;
        this.tokenType = tokenType;
        this.yyline = yyline;
        this.yycolumn = yycolumn;
    }

    @Override
    public String toString() {
        switch (tokenType) { // TODO
            case RESERVED_WORD:
                return this.content;

            default:
                return this.content;
        }
    }
}

enum TokenType {
    RESERVED_WORD,
    IDENTIFIER,
    INTEGER_NUMBER,
    REAL_NUMBER,
    STRING_AND_CHARACTER,
    SPECIAL_CHARACTER,
    COMMENT,
    OTHER,

    ENTER,
    TAB,
    SPACE,
    EOF,
    NOTHING,
}
