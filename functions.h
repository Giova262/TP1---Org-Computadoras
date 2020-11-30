#ifndef _FUNCTIONS_H
#define _FUNCTIONS_H

typedef struct {
	int8_t flag;
	int32_t hash;
	size_t size;
} string_hash;

extern void string_hash_more(string_hash *, char *, size_t);

#endif