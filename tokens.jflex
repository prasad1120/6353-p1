/*-***
 *
 * This file defines a stand-alone lexical analyzer for a subset of the Pascal
 * programming language.  This is the same lexer that will later be integrated
 * with a CUP-based parser.  Here the lexer is driven by the simple Java test
 * program in ./PascalLexerTest.java, q.v.  See 330 Lecture Notes 2 and the
 * Assignment 2 writeup for further discussion.
 *
 */


import java_cup.runtime.*;


%%
/*-*
 * LEXICAL FUNCTIONS:
 */

%cup
%line
%column
%unicode
%class Lexer

%{

/**
 * Return a new Symbol with the given token id, and with the current line and
 * column numbers.
 */
Symbol newSym(int tokenId) {
    return new Symbol(tokenId, yyline, yycolumn);
}

/**
 * Return a new Symbol with the given token id, the current line and column
 * numbers, and the given token value.  The value is used for tokens such as
 * identifiers and numbers.
 */
Symbol newSym(int tokenId, Object value) {
    return new Symbol(tokenId, yyline, yycolumn, value);
}

%}

comment	= \\\\.*\n
multi_comment = "\\*" ~"*\\"
whitespace = [ \n\t\r]

letter	= [a-zA-Z]
digit	= [0-9]
id	= {letter}[{letter}{digit}]*

intlit	= {digit}+
floatlit = {intlit}\.{intlit}

charlit = \'([^\\\n\t\"\']|\\.)\'
str = ([^\\\n\t\"\']|\\.)*
strlit = \"{str}\"



%%
/**
 * LEXICAL RULES:
 */

/**
 * Implement terminals here, ORDER MATTERS!
 */

 class                {return newSym(sym.CLASS, "class");}
 else                 {return newSym(sym.ELSE, "else");}
 if	                  {return newSym(sym.IF, "if");}
 while                {return newSym(sym.WHILE, "while");}
 return               {return newSym(sym.RETURN, "return");}
 read                 {return newSym(sym.READ, "read");}
 print                {return newSym(sym.PRINT, "print");}
 printline            {return newSym(sym.PRINTLN, "printline");}
 true                 {return newSym(sym.TRUE, "true");}
 false                {return newSym(sym.FALSE, "false");}
 void                 {return newSym(sym.VOID, "void");}
 int                  {return newSym(sym.INT, "int");}
 char                 {return newSym(sym.CHAR, "char");}
 bool                 {return newSym(sym.BOOL, "bool");}
 float                {return newSym(sym.FLOAT, "float");}
 final                {return newSym(sym.FINAL, "final");}
 "("                  {return newSym(sym.LPAREN, "(");}
 ")"                  {return newSym(sym.RPAREN, ")");}
 "["                  {return newSym(sym.LSQB, "[");}
 "]"                  {return newSym(sym.RSQB, "]");}
 "{"                  {return newSym(sym.LCURLY, "{");}
 "}"                  {return newSym(sym.RCURLY, "}");}
 "?"                  {return newSym(sym.QUESTION, "?");}
 ":"                  {return newSym(sym.COLON, ":");}
 ";"                  {return newSym(sym.SEMIC, ";");}
 "="                  {return newSym(sym.ASSIGN, "=");}
 ","                  {return newSym(sym.COMMA, ",");}
 "~"                  {return newSym(sym.NOT, "~");}
 "*"		          {return newSym(sym.MULTIPLY, "*");}
 "/"		          {return newSym(sym.DIVIDE, "/");}
 "+"		          {return newSym(sym.PLUS, "+");}
 "-"		          {return newSym(sym.MINUS, "-");}
 "<"		          {return newSym(sym.LT, "<");}
 ">"		          {return newSym(sym.GT, ">");}
 "++"		          {return newSym(sym.INC, "++");}
 "--"		          {return newSym(sym.DEC, "--");}
 "=="		          {return newSym(sym.EQ, "==");}
 "<="                 {return newSym(sym.LTE, "<=");}
 ">="                 {return newSym(sym.GTE, ">=");}
 "<>"                 {return newSym(sym.NE, "<>");}
 "||"                 {return newSym(sym.OR, "||");}
 "&&"                 {return newSym(sym.AND, "&&");}
 {intlit}             {return newSym(sym.INTLIT, yytext());}
 {charlit}            {return newSym(sym.CHARLIT, yytext());}
 {strlit}             {return newSym(sym.STRLIT, yytext());}
 {floatlit}           {return newSym(sym.FLOATLIT, yytext());}
 {id}                 {return newSym(sym.ID, yytext());}
 {comment}            {/* comment */}
 {multi_comment}      {/* multiline comment */}
 {whitespace}         { /* Ignore whitespace. */ }
.                     { System.out.println("Illegal char, '" + yytext() +
                    "' line: " + yyline + ", column: " + yychar); }