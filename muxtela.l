%option noyywrap

%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define INT 256
#define IF 257
#define ELSE 258
#define WHILE 259
#define DO 260
#define FOR 261

#ifndef YYSTYPE
typedef union {
    int intval;
    char* strval;
} YYSTYPE;
#endif

YYSTYPE yylval;

#define ID 262

%}


DIGIT     [0-9]
LETTER    [a-zA-Z]

%%

{DIGIT}+    { yylval.intval = atoi(yytext); return INT; }
{LETTER}+   { yylval.strval = strdup(yytext); return ID; }

"se_mux"                 { printf("Palavra chave 'if'\n"); return IF; }
"senao_mux"               { printf("Palavra chave 'else'\n"); return ELSE; }
"enquanto_mux"              { printf("Palavra chave 'while'\n"); return WHILE; }
"para_mux"                { printf("Palavra chave 'for'\n"); return FOR; }
"{"                  { printf("Chave de abertura\n"); return '{'; }
"}"                  { printf("Chave de fechamento\n"); return '}'; }
";"                  { printf("Ponto e vírgula\n"); return ';'; }
">"					 { printf("Sinal de maior\n"); return '>'; }
"<"                  { printf("Sinal de menor\n"); return '<'; }
">="                 { printf("Sinal de maior ou igual\n"); return '>='; }
"<="                 { printf("Sinal de menor ou igual\n"); return '<='; }
"=="                 { printf("Sinal de igual\n"); return '=='; }
"!="                 { printf("Sinal de diferente\n"); return '!='; }
"||"                 { printf("Operador lógico 'ou'\n"); return '||'; }
"&&"                 { printf("Operador lógico 'e'\n"); return '&&'; }
"!"                  { printf("Operador lógico 'não'\n"); return '!'; }
"+"         { printf("Operador de adição\n"); return '+'; }
"-"         { printf("Operador de subtração\n"); return '-'; }
"*"         { printf("Operador de multiplicação\n"); return '*'; }
"/"         { printf("Operador de divisão\n"); return '/'; }
"("         { printf("Parêntese de abertura\n"); return '('; }
")"         { printf("Parêntese de fechamento\n"); return ')'; }

[ \t\n]     { /* Ignorar espaços em branco e quebras de linha */ }

.           { printf("Caractere desconhecido: %s\n", yytext); return 0; }

%%

int main() {
    yylex();
    return 0;
}
