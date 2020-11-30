#ifndef _FUNCTIONS_H
#define _FUNCTIONS_H

typedef struct {
	int8_t flag;
	int32_t hash;
	size_t size;
} string_hash;

int32_t string_hash_more(string_hash *, char *, size_t);

#endif