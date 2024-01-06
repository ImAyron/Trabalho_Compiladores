all:
	flex muxtela.l

	bison -d muxtelaBison.y

	gcc -o muxtela muxtelaBison.tab.c lex.yy.c -lfl