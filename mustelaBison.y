
%{
#include <stdio.h>
%}

%token IF ELSE WHILE NUMBER VARIABLE
%token PLUS MINUS TIMES DIVIDE
%token EQUAL LESS GREATER AND OR
%token OPEN_PAREN CLOSE_PAREN OPEN_BRACE CLOSE_BRACE SEMICOLON

%%

expressao_condicional : IF OPEN_PAREN expressao_booleana CLOSE_PAREN bloco
                    | IF OPEN_PAREN expressao_booleana CLOSE_PAREN bloco ELSE bloco
                    | IF OPEN_PAREN expressao_booleana CLOSE_PAREN bloco ELSE IF OPEN_PAREN expressao_booleana CLOSE_PAREN bloco
                    | IF OPEN_PAREN expressao_booleana CLOSE_PAREN bloco ELSE IF OPEN_PAREN expressao_booleana CLOSE_PAREN bloco ELSE bloco
                    ;

expressao_booleana : expressao_relacional
                  | expressao_booleana AND expressao_relacional
                  | expressao_booleana OR expressao_relacional
                  ;

expressao_relacional : expressao_aritmetica
                   | expressao_aritmetica EQUAL expressao_aritmetica
                   | expressao_aritmetica LESS expressao_aritmetica
                   | expressao_aritmetica GREATER expressao_aritmetica
                   ;

expressao_aritmetica : termo
                   | expressao_aritmetica PLUS termo
                   | expressao_aritmetica MINUS termo
                   | expressao_aritmetica TIMES termo
                   | expressao_aritmetica DIVIDE termo
                   ;

termo : NUMBER
     | VARIABLE
     | OPEN_PAREN expressao_aritmetica CLOSE_PAREN
     ;

bloco : OPEN_BRACE comandos CLOSE_BRACE
      | SEMICOLON
      ;

comandos : comando
         | comandos comando
         ;

comando : expressao_condicional
        | expressao_aritmetica SEMICOLON
        ;

%%

int main() {
    yyparse();
    return 0;
}

int yyerror(const char *msg) {
    fprintf(stderr, "Erro de sintaxe: %s\n", msg);
    return 0;
}
