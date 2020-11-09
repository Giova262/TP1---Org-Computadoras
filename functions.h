#ifndef _FUNCTIONS_H
#define _FUNCTIONS_H

typedef struct {
	int8_t flag;
	int32_t hash;
	size_t size;
} string_hash;

int32_t hashAs(string_hash *, char *, size_t);
// unsigned int  potencia (unsigned int n, int);
// int32_t hashTest(char *);
// void hashAs(string_hash *sh, char *str, size_t len);

#endif