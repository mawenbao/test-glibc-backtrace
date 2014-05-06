help:
	@echo usage: make [command]
	@echo
	@echo commands:
	@echo "    all:       build all and generate asm file"
	@echo "    test:      build main.cpp and hello.cpp"
	@echo "    test.asm:  generate asm file from test"
	@echo "    clean:     remove all the build files"
	@echo "    parse:     build test and parse output with parser.py"

all: test test.asm

parse: test
	./test | python parser.py test

test.asm: test
	objdump -dS test > test.asm

test: main.cpp libhello.a
	g++ -o test -rdynamic -g main.cpp libhello.a

libhello.a: hello.o
	ar cr libhello.a hello.o

hello.o: hello.cpp
	g++ -o hello.o -g -c hello.cpp

.PHONY: help all parse clean

clean:
	rm -f hello.o libhello.a test test.asm parser.pyc

