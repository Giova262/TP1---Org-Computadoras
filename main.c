#include <stdio.h>
#include <stdlib.h>
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

int main(int argc, char *argv[])
{
    int i;
    string_hash hash;
    FILE * fp;
    FILE * output;
    char * line = NULL;
    ssize_t read;
    size_t len = 0;
    

    for (i = 1; i < argc; i++) {
        char* arg=argv[i] ;

        if (strcmp(arg, "-h") == 0) {
            printf(
                "\nUsage:\n"
                    "\t tp1 -h \n"
                    "\t tp1 -V \n"
                    "\t tp1 -i in_file -o out_file \n"
                "Options:"
                    "\t -V, --version Print version and quit.\n "
                    "\t -h, --help Print this information and quit.\n "
                    "\t -i, --input Specify input stream/file, \"-\" for stdin. \n"
                    "\t -o, --output Specify output stream/file, \"-\" for stdout. \n"
                "Examples:\n "
                    "\t tp1 < in.txt > out.txt\n"
                    "\t cat in.txt | tp1 -i - > out.txt\n\n"
            );
            break;
        }

        if (strcmp(arg, "-V") == 0) {
            printf(
                "\nTrabajo Practico nro 1 - Organizacion de Computadoras. \n\n"
                "Integrantes:\n"
                "\t Micaela Villordo 103828\n"
                "\t Martin Charytoniuk 96354\n"
                "\t Josue Giovanni Valdivia 93075\n\n"
            );
            break;
        }

        if (strcmp(arg, "-test") == 0) {
            printf( "\nTesteando codigo aseembly. \n\n"  );
            char *msg = "mensaje para string hash";
            len = strlen("mensaje para string hash");
            string_hash_init(&hash);
            string_hash_more(&hash, msg, len);
            string_hash_done(&hash);
            printf("hash 1: 0x%04x\n", hash.hash);
            break;
        }

        if (strcmp(arg, "-i") == 0) {

            printf("\n");
            if ( argc <= 2 ) {
                printf("Falta definir algun argumento\n");
                return -1;
            }
            
            fp = fopen(argv[2], "r");
            if ( fp ==  NULL ) {
                printf("No pudo abrir el archivo\n");
                return -1;
            }
            
            if ( argc == 5 ) {
                char* codigo=argv[3] ;
                char* nombreSalida=argv[4] ;
                if (strcmp(codigo, "-o") == 0) {

                    output = fopen(nombreSalida,"w");
                    if (output == NULL) {
                        printf("Error al crear el archivo de salida\n");
                        return -1;
                    }

                    while ((read = getline(&line, &len, fp)) != -1) {
                        len = strlen(line);
                        string_hash_init(&hash);
                        string_hash_more(&hash, line, len);
                        string_hash_done(&hash);
                        if (strcmp(nombreSalida, "-") == 0) {
                            printf("0x%04x %s", hash.hash, line);
                        }else{
                            if (fprintf(output,"0x%04x %s", hash.hash, line) < 0){
                                printf("Error al escribir en archivo de salida.");
                            }
                        }
                    }
                    fclose(output);

                } else {
                    printf("No se reconoce el comando %s\n",codigo);
                }
        
            } else {

                 printf("Falta definir el -o salida.txt por ejemplo\n");
            }

            fclose(fp);
            if (line)
                free(line);
            exit(EXIT_SUCCESS);
            break;
        }
    }

    return 0;
}
