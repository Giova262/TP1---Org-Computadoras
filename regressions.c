#include <stdio.h>
#include <stdint.h>
#include <string.h>
#include <assert.h>
#include "functions.h"

#include "hash.h"

typedef struct {
	int32_t hash;
	char *msg;
} regression;


int
main(int argc, char * const argv[])
{
	regression regressions[] = {
		{ 0xcc2b6c5a, "66.20 Organizacion de Computadoras\n" },
		{ 0xcb5af1f1, "TP 1 - Segundo Cuatrimestre, 2020\n"  },
		{ 0xd788c5a5, "Archivo de prueba TP 1.\n"            },
		{ 0x91ff4b5b, "1\n"                                  },
	};
	regression *iter;
	int32_t hash;

	for (iter = regressions; iter->msg != NULL; iter++) {
	       hash = hashTest(iter->msg);
	       printf("0x%08x %s", hash, iter->msg);
	       assert(iter->hash == hash);
	}

	return 0;
}
