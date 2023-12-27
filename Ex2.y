%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

extern FILE *yyin;
extern int yylex();

%}

%token INT IF ELSE WHILE DO FOR NUM ID
%left '+' '-'
%left '*' '/'
%right '='

%%

program:
    statements
    ;

statements:
    statements statement
    |
    statement
    ;

statement:
    INT ID ';'   {  $$ = $1;    printf("(=, , ,%s)\n",$1);}
    |
    ID '=' exp ';'
    {
        $$ = $3; 
        printf("(=, , ,%s)\n", $3);
    }
    |
    IF '(' condition ')' '{' statement '}'
    |
    IF '(' condition ')' '{' statement '}' ELSE '{' statement '}'
    |
    WHILE '(' condition ')' '{' statement '}'
    |
    DO '{'statement '}' WHILE '(' condition ')' ';'
    |
    FOR '(' statement ';' condition ';' statement ')' '{' statement '}'
    ;

condition:
    exp
    |
    exp '>' exp
    {
        if ($1 != '_' && $3 != '_') {
            printf("(>,%s,%s)\n", $1, $3);
        } else {
            printf("(>,%s,%s,%s)\n", $1, $3, $$);
        }
    }
    |exp '<' exp
    {
        if ($1 != '_' && $3 != '_') {
            printf("(<,%s,%s)\n", $1, $3);
        } else {
            printf("(<,%s,%s,%s)\n", $1, $3, $$);
        }
    }
    ;

exp:
    exp '+' exp
    {
        printf("(+,%s,%s,%s)\n", $1, $3, $$); // Gere a quadrupla
    }
    |
    exp '-' exp
    {
        printf("(-,%s,%s,%s)\n", $1, $3, $$);
    }
    |
    exp '*' exp
    {
        printf("(*,%s,%s,%s)\n", $1, $3, $$);
    }
    |
    exp '/' exp
    {
        printf("(/,%s,%s,%s)\n", $1, $3, $$);
    }
    |
    ID
    {
        $$ = $1;
        printf("(=,%s,%s,%s)\n", $1, "", $$);
    }
    |
    NUM
    {
        printf("(=,%d,%s,%s)\n", $1, "", $$);
    }
    ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Erro: %s", s);
}

int main() {


    yyparse();
    return 0;
}
