#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <getopt.h>
#include <unistd.h>
#include <errno.h>
#include <stdint.h>
#include <assert.h>

#define STRING_HASH_INIT 1
#define STRING_HASH_MORE 2
#define STRING_HASH_DONE 3

typedef struct {
	int8_t flag;
	int32_t hash;
	size_t size;
} string_hash;



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
    string_hash hash;
    size_t len = 0;

    char *msg = "mensaje para string hash";
    len = strlen("mensaje para string hash");
   
    string_hash_init(&hash);
    string_hash_more(&hash, msg, len);
    string_hash_done(&hash);
    printf("0x%04x  ", hash.hash);
    printf("%s\n\n", msg);
        
    return 0;
}