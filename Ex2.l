%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "Ex2.tab.h"
%}

%%

[ \t\n]              ; // Ignorar espaços em branco e quebras de linha
"int"                { return INT; }
"if"                 { return IF; }
"else"               { return ELSE; }
"while"              { return WHILE; }
"do"                 { return DO; }
"for"                { return FOR; }
"("                  { return '('; }
")"                  { return ')'; }
"{"                  { return '{'; }
"}"                  { return '}'; }
";"                  { return ';'; }
">"					 { return '>'; }
"<"                  { return '<'; }
[0-9]+               { yylval = atoi(yytext); return NUM; } 
[a-zA-Z][a-zA-Z0-9]* { yylval = strdup(yytext); return ID; }
"+"                { return '+'; } // Escape o operador '+'
"-"                { return '-'; } // Escape o operador '-'
"*"                { return '*'; } // Escape o operador '*'
"/"                  { return '/'; }
"="                  { return '='; }

.                    { printf("Caractere inesperado: %s\n", yytext); }
%%

int yywrap(){
	return 1;
}