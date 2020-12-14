#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <string.h>

#include <getopt.h>
#include <unistd.h>
#include <errno.h>
#include <stdint.h>
#include <assert.h>
#include "functions.h"

#define STRING_HASH_INIT 1
#define STRING_HASH_MORE 2
#define STRING_HASH_DONE 3


static void string_hash_done(string_hash *sh)
{
	assert(sh->flag == STRING_HASH_INIT || sh->flag == STRING_HASH_MORE);

	if ((sh->hash ^= sh->size) == -1)
		sh->hash = -2;

	sh->flag = STRING_HASH_DONE;
}

static void string_hash_init(string_hash *h)
{
	h->flag = STRING_HASH_INIT;
	h->hash = 0;
	h->size = 0;
}


int32_t processLine(char *line, string_hash* hash){
	size_t len = strlen(line);
	string_hash_init(hash);
	string_hash_more(hash, line, len);
	string_hash_done(hash);
	return hash->hash;
}


//programa de prueba para manejar entrada y salida por terminal

int main(int argc, char *argv[]) {

	//defino variables que voy a usar en el programa
	char *defaultInput = "-";
	int i=0;
	char *inputFileRoute = defaultInput;
	char *outputFileRoute = defaultInput;
	FILE *outputFile;
	FILE *inputSource = stdin;

    string_hash hash;
    ssize_t read;
	int invalido = 0;
   // size_t len = 0;

	//parseo los argumentos para buscar input/output file route:
	if (argc >1) {
		// Busco el -h
		for (i=1; i< argc; i++) {
			if ((strcmp("-h",argv[i]) == 0)) {
				printf(
					"\nUsage:\n"
						"\t tp1 -h \n"
						"\t tp1 -V \n"
						"\t tp1 -i in_file -o out_file \n"
					"Options:\n"
						"\t -V, --version Print version and quit.\n "
						"\t -h, --help Print this information and quit.\n "
						"\t -i, --input Specify input stream/file, \"-\" for stdin. \n"
						"\t -o, --output Specify output stream/file, \"-\" for stdout. \n"
					"Examples:\n "
						"\t tp1 < in.txt > out.txt\n"
						"\t cat in.txt | tp1 -i - > out.txt\n\n"
				);
				return 0;
			}
	 	}
		// Busco el -v
		for (i=1; i< argc; i++) {
			if ((strcmp("-V",argv[i]) == 0)) {
				 printf(
					"\nTrabajo Practico nro 1 - Organizacion de Computadoras. \n\n"
					"Integrantes:\n"
					"\t Micaela Villordo 103828\n"
					"\t Martin Charytoniuk 96354\n"
					"\t Josue Giovanni Valdivia 93075\n\n"
				);
				return 0;
			}
	 	}
		// Busco el -test
		for (i=1; i< argc; i++) {
			if ((strcmp("-test",argv[i]) == 0)) {
			    printf( "\nTesteando codigo aseembly. \n\n"  );
				char *msg = "mensaje para string hash";
				int32_t resultado = processLine(msg,&hash);
				printf("hash 1: 0x%04x\n", resultado);
				return 0;
			}
	 	}
	 	//busco el input
		for (i=1; i< argc; i++) {
			if ((strcmp("-i",argv[i]) == 0) && (i+1 <argc)){
				inputFileRoute = argv[i+1];
				//el input esta seteado
				invalido = 1;
			} else if ((strcmp("-i",argv[i]) == 0)) {
				invalido = 2;
			}
	 	}
	 	//busco el output
		for (i=1; i< argc; i++) {
			if ((strcmp("-o",argv[i]) == 0) && (i+1 <argc)){
				outputFileRoute = argv[i+1];
				//el output esta seteado
				invalido = 1;
			}
	 	}

        if (invalido == 0) {
			fprintf(stderr,"No se reconoce el comando\n");
			return -1;
		}

		if (invalido == 2) {
			fprintf(stderr,"Falta definir la entrada.\n");
			return -1;
		}
 	}
    
 	//si el output esta seteado != default, abro para escribir
	if (strcmp(defaultInput,outputFileRoute) != 0){
		outputFile = fopen(outputFileRoute,"w");
		if ( outputFile ==  NULL ) {
            fprintf(stderr,"No pudo abrir el archivo\n");
            return -1;
        }
	}

	//inputSource es la fuente de donde lee. Si el input es default, es stdin. Si no, es el archivo.

 	if (strcmp(defaultInput,inputFileRoute) != 0){
 		inputSource = fopen(inputFileRoute, "r");
		 if ( inputSource ==  NULL ) {
            fprintf(stderr,"No pudo abrir el archivo\n");
            return -1;
		 }
 	}

	//leo archivo o stdin
	// ssize_t read;
	char* line = NULL;
	size_t len = 0;
	while ((read = getline(&line, &len, inputSource)) != -1)
	{
        len = strlen(line);

        if (strcmp(defaultInput,outputFileRoute) == 0) {
			//proceso linea por linea
			processLine(line,&hash);
		    printf("0x%04x %s", hash.hash, line);
        }
        else
        {
			int32_t resultado = processLine(line,&hash);
            if (fprintf(outputFile,"0x%04x %s",resultado,line) < 0){
                fprintf(stderr,"Error al escribir en archivo de salida.");
            }
        }
    }

	//cierro los archivos
	if (strcmp(defaultInput,inputFileRoute) != 0){
	 	fclose(inputSource);
	}
	if (strcmp(defaultInput,outputFileRoute) != 0){
		fclose(outputFile);
	}

 	//si el output no esta seteado imprimo por pantalla:

 	if (strcmp(defaultInput,outputFileRoute) != 0){
	    int fd;
	    char *name = outputFileRoute;
	    fd = open(name, O_WRONLY | O_CREAT, 0644);
	    if (fd == -1) {
	        perror("open failed");
			fprintf(stderr,"open failed");
	        exit(1);
	    }

	    if (dup2(fd, 1) == -1) {
	        perror("dup2 failed"); 
			fprintf(stderr,"dup2 failed");
	        exit(1);
	    }

		//ssize_t read;
		char* line = NULL;
		size_t len;

		while ((read = getline(&line, &len, inputSource)) != -1)
		{
            len = strlen(line);

            //proceso linea por linea
			processLine(line,&hash);
		    printf("0x%04x %s", hash.hash, line);
        }
	    close(fd);
	}
    return 0;
}
