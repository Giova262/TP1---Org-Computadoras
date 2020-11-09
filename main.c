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


int IsValidNumber(char * string)
{
    int j = 0;
    for(int i = 0; i < strlen( string ); i ++)
    {
        if ( string[i] >= '0' && string[i] <= '9' ){
	    j = 1;
            break;
	}
            
    }

   return j;
}

static void string_hash_done(string_hash *sh)
{
	assert(sh->flag == STRING_HASH_INIT || sh->flag == STRING_HASH_MORE);

	if ((sh->hash ^= sh->size) == -1)
		sh->hash = -2;

	sh->flag = STRING_HASH_DONE;
}

static void string_hash_more(string_hash *sh, char *str, size_t len)
{
	// assert(sh->flag == STRING_HASH_INIT || sh->flag == STRING_HASH_MORE);

	if (sh->flag == STRING_HASH_INIT) {
		sh->flag = STRING_HASH_MORE;
		sh->hash = (*str) << 7;
	}
    // printf("%d\n",*str);
    /*printf("%d\n",len);*/
	while ((*str) != 0 && len--) {
		sh->hash = (1000003 * sh->hash) ^ *str++;
		sh->size++;
	}
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
    char * line = NULL;
    ssize_t read;
    size_t len = 0;

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

        if (strcmp(arg, "-test") == 0) {
            printf( "\nTesteando codigo aseembly. \n\n"  );
            char *msg = "mensaje para string hash";
            len = strlen("mensaje para string hash");
            string_hash_init(&hash);
            hashAs(&hash, msg, len);
            string_hash_done(&hash);
            printf("hash 1: 0x%04x\n", hash.hash);

            string_hash_init(&hash);
            string_hash_more(&hash, msg, len);
            string_hash_done(&hash);
            printf("hash 2: 0x%04x  ", hash.hash);
            printf("%s\n\n", msg);

            break;
        }

        if (strcmp(arg, "-i") == 0) {

            printf("\n");
            fp = fopen(argv[2], "r");
            if (fp == NULL)
                exit(EXIT_FAILURE);

            while ((read = getline(&line, &len, fp)) != -1) {

                len = strlen(line);

                string_hash_init(&hash);
                hashAs(&hash, line, len);
                string_hash_done(&hash);
                printf("hash: 0x%04x ", hash.hash);

                printf("%s", line);
            }

            printf("\n");

            fclose(fp);
            if (line)
                free(line);
            exit(EXIT_SUCCESS);
            break;
        }
    }

    return 0;
}
