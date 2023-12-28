// desativa o comportamento padrão do analisador léxico de retornar ao início do buffer de entrada após cada token
%option noyywrap

%{
// bibliotecas necessárias
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// constantes para os tokens
#define INT 256
#define IF 257
#define ELSE 258
#define WHILE 259
#define DO 260
#define FOR 261

// Verifica se a macro YYSTYPE já foi definida. 
// Se não estiver, define a união YYSTYPE 
// para armazenar valores inteiros (intval) ou strings (strval).
// - Samamba: essa parte eu entendi que é para estruturar o token, mas não entendi o que é o YYSTYPE;
#ifndef YYSTYPE
typedef union {
    int intval;
    char* strval;
} YYSTYPE;
#endif

// Variável global para armazenar o valor do token atual.
YYSTYPE yylval;

#define ID 262

%}

// Define expressões regulares para identificar dígitos e as letras do alfabeto.
DIGIT     [0-9]
LETTER    [a-zA-Z]

%%

// Regras de análise léxica para cada token. Cada regra
{DIGIT}+    { yylval.intval = atoi(yytext); return INT; }
{LETTER}+   { yylval.strval = strdup(yytext); return ID; }

"se_mux"                 { printf("Palavra chave 'if'\n"); return IF; }
"senao_mux"               { printf("Palavra chave 'else'\n"); return ELSE; }
"enquanto_mux"              { printf("Palavra chave 'while'\n"); return WHILE; }
"faz_mux"                 { printf("Palavra chave 'do'\n"); return DO; }
"para_mux"                { printf("Palavra chave 'for'\n"); return FOR; }
"{"                  { printf("Chave de abertura\n"); return '{'; }
"}"                  { printf("Chave de fechamento\n"); return '}'; }
";"                  { printf("Ponto e vírgula\n"); return ';'; }
">"					 { printf("Sinal de maior\n"); return '>'; }
"<"                  { printf("Sinal de menor\n"); return '<'; }
"+"         { printf("Operador de adição\n"); return '+'; }
"-"         { printf("Operador de subtração\n"); return '-'; }
"*"         { printf("Operador de multiplicação\n"); return '*'; }
"/"         { printf("Operador de divisão\n"); return '/'; }
"("         { printf("Parêntese de abertura\n"); return '('; }
")"         { printf("Parêntese de fechamento\n"); return ')'; }

[ \t\n]     { /* Ignorar espaços em branco e quebras de linha */ }

.           { printf("Caractere desconhecido: %s\n", yytext); return 0; }

%%

// Função principal que chama o analisador léxico.
int main() {
    yylex();
    return 0;
}