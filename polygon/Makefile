tests: polygon.o tests.o
	gcc -g -o tests polygon.o tests.o

polygon.o:
	gcc -g -c polygon.c

tests.o:
	gcc -g -c tests.c

clean:
	rm -f *.o
	rm -f *.core
	rm -f tests
