all:
	mkdir -p bin
	$(MAKE) grammar
	$(MAKE) lex
	g++ -std=c++17 -Wall -Wextra bin/grammar.tab.c bin/lex.yy.c src/main.cpp -o bin/a.out
	$(MAKE) run

grammar:
	bison -d src/grammar.y -o bin/grammar.tab.c

lex:
	flex -o bin/lex.yy.c src/lex.l 

run:
	./bin/a.out < test/main.hades