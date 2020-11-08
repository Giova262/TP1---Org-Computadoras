#ifndef _FUNCTIONS_H
#define _FUNCTIONS_H

typedef struct {
	int8_t flag;
	int32_t hash;
	size_t size;
} string_hash;

int32_t hashAs(int32_t, int32_t, size_t);
unsigned int  potencia (unsigned int n, int);
// void hashAs(string_hash *sh, char *str, size_t len);

#endif