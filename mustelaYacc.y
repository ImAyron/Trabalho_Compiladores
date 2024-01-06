
%{
# include <stdio.h>

	void yyerror(char* c);
	int yylex(void);

%}

%token N OP EOL


%%
S : E EOL {printf("Valor da soma(S):  %d\n ", $1); }
  ;
E :	E OP T{$$ = $1 + $3; printf("Valor da soma(S = E + T):  %d\n ", $$);}
  | T { $$ = $1; printf("Valor atribuido S=T: %d\n ", $$); }
  ;
T : 
    T '*' F {$$ = $1 * $3; printf("Valor da multiplicacao: %d\n ", $$);}
  |	F { $$ = $1; printf("Valor atribuido T=S: %d\n ", $1); }
  ;
F :
	N { $$ = $1; printf("encontrei um numero: %d\n", $1); }
  ;

// expressao_condicional : if (expressao_booleana) bloco
//                     | if (expressao_booleana) bloco else bloco
//                     | if (expressao_booleana) bloco else if (expressao_booleana) bloco
//                     | if (expressao_booleana) bloco else if (expressao_booleana) bloco else bloco
//                     ;

// expressao_booleana : expressao_relacional
//                   | expressao_booleana operador_logico expressao_relacional
//                   ;

// expressao_relacional : expressao_aritmetica
//                    | expressao_relacional operador_relacional expressao_aritmetica
//                    ;

// expressao_aritmetica : termo
//                    | expressao_aritmetica operador_aritmetico termo
//                    ;

// termo : numero
//      | variavel
//      | (expressao_aritmetica)
//      ;

// bloco : { comandos }

// comandos : comando
//          | comandos comando
//          ;

// comando : expressao_condicional
//         | expressao_aritmetica ;

%%

void yyerror(char* c) {
	printf("Erro: %s\n", c);
}

int main() {
	yyparse();
	return 0;
}
