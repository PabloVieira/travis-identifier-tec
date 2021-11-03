# Travis example for Identifier created by Rafael Garibotti

GCCFLAGS = -g -Wall -Wfatal-errors
ALL = identifier cov gcov cppcheck sanitizer valgrind
GCC = gcc

all: $(ALL)

identifier: identifier.c
	$(GCC) $(GCCFLAGS) -o $@ $@.c

cov: identifier.c
	$(GCC) $(GCCFLAGS) -fprofile-arcs -ftest-coverage -o $@ identifier.c 

gcov: cov
	gcov -b identifier

cppcheck: identifier.c
	cppcheck --enable=all --suppress=missingIncludeSystem identifier.c

sanitizer: identifier.c
	$(GCC) $(GCCFLAGS) -fsanitize=address identifier.c -o identifier

valgrind: identifier
	valgrind --leak-check=full --show-leak-kinds=all ./identifier	

clean:
	rm -fr $(ALL) *.o cov* *.dSYM *.gcda *.gcno *.gcov

test: all
	bash test
