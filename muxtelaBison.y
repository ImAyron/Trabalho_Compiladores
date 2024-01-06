
%{
#include <stdio.h>
%}

%token IF ELSE WHILE FOR INT ID
%token '+' '-' '*' '/'
%token '==' '<' '>' '&&' '||' '!' '<=' '>=' '!='
%token '(' ')' '{' '}' ';'

%%

expressao_condicional : IF '(' expressao_booleana ')' bloco
                    | IF '(' expressao_booleana ')' bloco ELSE bloco
                    | IF '(' expressao_booleana ')' bloco ELSE IF '(' expressao_booleana ')' bloco
                    | IF '(' expressao_booleana ')' bloco ELSE IF '(' expressao_booleana ')' bloco ELSE bloco
                    ;

expressao_incondicional : WHILE '(' expressao_booleana ')' bloco
                         | FOR '(' expressao_aritmetica ';' expressao_booleana ';' expressao_aritmetica ')' bloco
                         ;

expressao_booleana : expressao_relacional
                  | expressao_booleana '&&' expressao_relacional
                  | expressao_booleana '||' expressao_relacional
                  ;

expressao_relacional : expressao_aritmetica
                   | expressao_aritmetica '==' expressao_aritmetica
                   | expressao_aritmetica '<' expressao_aritmetica
                   | expressao_aritmetica '>' expressao_aritmetica
                   | expressao_aritmetica '<=' expressao_aritmetica
                   | expressao_aritmetica '>=' expressao_aritmetica
                   | expressao_aritmetica '!' expressao_aritmetica
                   | expressao_aritmetica '!=' expressao_aritmetica
                   ;

expressao_aritmetica : termo
                   | expressao_aritmetica '+' termo
                   | expressao_aritmetica '-' termo
                   | expressao_aritmetica '*' termo
                   | expressao_aritmetica '/' termo
                   ;

termo : INT
     | ID
     | '(' expressao_aritmetica ')'
     ;

bloco : '{' comandos '}'
      | ';'
      ;

comandos : comando
         | comandos comando
         ;

comando : expressao_condicional
        | expressao_aritmetica ';'
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
