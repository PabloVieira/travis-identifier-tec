# Travis example for Identifier created by Rafael Garibotti

GCCFLAGS = -g -Wall -Wfatal-errors 
ALL = identifier cov cppcheck valgrind
GCC = gcc

all: $(ALL)

identifier: identifier.c
	$(GCC) $(GCCFLAGS) -o $@ $@.c

cov: identifier.c
	$(GCC) $(GCCFLAGS) -fprofile-arcs -ftest-coverage -o $@ identifier.c	

gcov: identifier.c
	gcov -b identifier

cppcheck: identifier.c
	cppcheck --enable=all --suppress=missingIncludeSystem identifier.c

sanitizer:
	$(GCC) $(GCCFLAGS) -fsanitize=address identifier.c -o identifier

valgrind:
	$(GCC) $(GCCFLAGS) identifier.c -o identifier
	valgrind --leak-check=full --show-leak-kinds=all ./identifier	

clean:
	rm -fr $(ALL) *.o cov* *.dSYM *.gcda *.gcno *.gcov

test: all
	bash test
