all: bc-parser-example

CPPFLAGS=-g -std=c++17 -Isrc/ -Ibin/ -I.

bc-parser-example: bin/bc-parser.cpp bin/bc-lexer.cpp bc-parser/utils.cpp bc-parser/bc-parser-driver.cpp
	g++ $(CPPFLAGS) bc-parser/bc-parser-driver.cpp bc-parser/utils.cpp bin/bc-parser.cpp bin/bc-lexer.cpp -o bc-parser-example

bin/bc-parser.cpp: bc-parser/bc-parser.yy
	bison -Dapi.prefix={bc} --output=bin/bc-parser.cpp --defines=bin/bc-parser.h bc-parser/bc-parser.yy

bin/bc-lexer.cpp: bc-parser/bc-lexer.lex
	flex -P bc --outfile=bin/bc-lexer.cpp --header-file=bin/bc-lexer.h bc-parser/bc-lexer.lex

clean: 
	rm -f bin/bc-lexer.cpp bin/bc-lexer.h bin/bc-parser.cpp bin/bc-parser.h bc-parser.output bc-parser-example
