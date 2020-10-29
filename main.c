#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <getopt.h>
#include <unistd.h>
#include <errno.h>
#include "functions.h"

int IsValidNumber(char * string)
{
    int j = 0;
    for(int i = 0; i < strlen( string ); i ++)
    {
        if ( string[i] >= '0' && string[i] <= '9' )
            j = 1;
            break;
    }

   return j;
}


int main(int argc, char *argv[])
{
    int i;
    char *docFileName = NULL;

    for (i = 1; i < argc; i++) {
        char* arg=argv[i] ;

        if (strcmp(arg, "-h") == 0) {
            fprintf(stderr,
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
            fprintf(stderr,
                "\nTrabajo Practico nro 1 - Organizacion de Computadoras. \n\n"
                "Integrantes:\n"
                "\t Micaela Villordo 103828\n"
                "\t Martin Charytoniuk 96354\n"
                "\t Josue Giovanni Valdivia 93075\n\n"
            );
            break;
        }

        if (strcmp(arg, "-i") == 0) {
            fprintf(stderr,
                "\nCargando Archivo para hashear..\n\n"
            );

            //abro el archivo
            FILE * fp;
            char * line = NULL;
            size_t len = 0;
            ssize_t read;

            fp = fopen(argv[2], "r");
            if (fp == NULL)
                exit(EXIT_FAILURE);

            while ((read = getline(&line, &len, fp)) != -1) {

                //veo si la linea es un numero
                if (IsValidNumber(line) == 1){
                    int num = atoi(line);
                    //llamo la funcion en assembler para que incremente
                    num = add(num);
                    printf("%d     ", num);
                } else {
                    printf("NO NUMERO   ");
                }


                


                printf("%s", line);
            }
            printf("\n");

            fclose(fp);
            if (line)
                free(line);
            exit(EXIT_SUCCESS);
            break;
        }

        docFileName = arg;
    }

    return 0;
}
