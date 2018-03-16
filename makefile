INFO = "-Wall -Wextra"

all:
	mkdir -p bin
	$(MAKE) grammar
	$(MAKE) lex
	g++ -std=c++17 ${NOINFO} bin/grammar.tab.c bin/lex.yy.c src/main.cpp -o bin/a.out
	$(MAKE) run
	g++ -std=c++17 bin/main.cpp -o bin/output
	$(MAKE) runcompiled

grammar:
	bison -d src/grammar.y -o bin/grammar.tab.c

lex:
	flex -o bin/lex.yy.c src/lex.l 

run:
	./bin/a.out < test/main.hades

runcompiled:
	./bin/output

clear:
	rm -rf bin