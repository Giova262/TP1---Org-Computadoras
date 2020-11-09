CFLAGS=-Wall -g

all: regressions
	:

regressions: regressions.c hash.c hash.S
	$(CC) $(CFLAGS) -o regressions regressions.c hash.c hash.S

test: regressions
	./regressions

clean:
	rm -f regressions


Instrucciones

Pasar los archivos a la maquina emulada
1- scp -P 5555 regressions.c hash.S hash.h hash.c root@localhost:/tmp

Compilar los archivos
2- gcc -Wall -o exec2 regressions.c hash.S hash.c

Correr el test
3- ./exec2
