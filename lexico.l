%{
#include <stdio.h>
%}

DIGIT     [0-9]
LETTER    [a-zA-Z]

%%

{DIGIT}+    { printf("Número inteiro: %s\n", yytext); }

{LETTER}+   { printf("Identificador: %s\n", yytext); }



"intm"                { printf("Palavra chave 'int'") return INT; }
"se_mux"                 { printf("Palavra chave 'if'") return IF; }
"senao_mux"               { printf("Palavra chave 'else'") return ELSE; }
"enquanto_mux"              { printf("Palavra chave 'while'") return WHILE; }
"faz_mux"                 { printf("Palavra chave 'do'") return DO; }
"para_mux"                { printf("Palavra chave 'for'") return FOR; }
"{"                  { printf("Chave de abertura") return '{'; }
"}"                  { printf("Chave de fechamento") return '}'; }
";"                  { printf("Ponto e virgula") return ';'; }
">"					 { printf("") return '>'; }
"<"                  { printf("") return '<'; }
[0-9]+               { yylval = atoi(yytext); return NUM; } 
[a-zA-Z][a-zA-Z0-9]* { yylval = strdup(yytext); return ID; }
"+"         { printf("Operador de adicao\n"); return '+'; }
"-"         { printf("Operador de subtracao\n"); return '-'; }
"*"         { printf("Operador de multiplicacao\n"); return '*'; }
"/"         { printf("Operador de divisao\n"); return '/'; }
"("         { printf("Parentese de abertura\n"); return '('; }
")"         { printf("Parentese de fechamento\n"); return ')'; }

[ \t\n]     { /* Ignorar espaços em branco e quebras de linha */ }

.          { printf("Caractere não reconhecido: %s\n", yytext); }

%%

int yywrap() {
    return 1; // Indica o fim da análise léxica
}

int main() {
    yylex(); // Chama o analisador léxico
    return 0;
}