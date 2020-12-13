#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <string.h>


void processLine(char *line){
	size_t len = strlen(line);
	printf("%ld\n",len);

	//inserto el procesamiento real que tiene que hacer el programa linea por linea

	//string_hash_init(&hash);
    //string_hash_more(&hash, line, len);
    //string_hash_done(&hash);
        
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

	//parseo los argumentos para buscar input/output file route:
	if (argc >1) {
	 	//busco el input
		for (i=1; i< argc; i++) {
			if ((strcmp("-i",argv[i]) == 0) && (i+1 <argc)){
				inputFileRoute = argv[i+1];
				//el input esta seteado
			}
	 	}
	 	//busco el output
		for (i=1; i< argc; i++) {
			if ((strcmp("-o",argv[i]) == 0) && (i+1 <argc)){
				outputFileRoute = argv[i+1];
				//el output esta seteado
			}
	 	}
 	}
    
 	//si el output esta seteado != default, abro para escribir
	if (strcmp(defaultInput,outputFileRoute) != 0){
		outputFile = fopen(outputFileRoute,"w");
	}

	//inputSource es la fuente de donde lee. Si el input es default, es stdin. Si no, es el archivo.

 	if (strcmp(defaultInput,inputFileRoute) != 0){
 		inputSource = fopen(inputFileRoute, "r");
 	}

	//leo archivo o stdin
	ssize_t read;
	char* line = NULL;
	size_t len = 0;
	while ((read = getline(&line, &len, inputSource)) != -1)
	{
        len = strlen(line);

        if (strcmp(defaultInput,outputFileRoute) == 0) {
			//proceso linea por linea
        	processLine(line);
        }
        else
        {
            if (fprintf(outputFile,"%ld\n",len) < 0){
                printf("Error al escribir en archivo de salida.");
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
	        exit(1);
	    }

	    if (dup2(fd, 1) == -1) {
	        perror("dup2 failed"); 
	        exit(1);
	    }

		ssize_t read;
		char* line = NULL;
		size_t len;

		while ((read = getline(&line, &len, inputSource)) != -1)
		{
            len = strlen(line);

            //proceso linea por linea
        	processLine(line);
        }
	    close(fd);
	}
    return 0;
}
