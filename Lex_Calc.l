
%{
#include <stdlib.h>
void yyerror(char *c);

#include "Parser_Calc.tab.h"

%}

%%
[0-9]+ {
		yylval = atoi(yytext);
		return N;
		}

\n { return EOL; }
[+] { return OP; }
[[:space:]]+ ;
. {yyerror("token desconhecido\n"); }

%%

int yywrap(){
	return 1;
}