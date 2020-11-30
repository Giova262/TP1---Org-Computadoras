#include <sys/regdef.h>
#include <sys/syscall.h>

		.data
		mensaje: .asciiz "Assert failed\n"
		longitud: .word 15

        .text                   # segmento de texto del programa

        .abicalls
        .align 2                # alineacion 2^2

        .globl  string_hash_more
        .ent    string_hash_more

string_hash_more:
        .frame fp, 16, ra

        # creo stack frame
        subu    sp, sp, 16      
        .cprestore 8           # sw gp, 8(sp)
        sw      fp, 12(sp)
        move    fp, sp

        sw      a0, 16(fp)      #primer parametro: sh
        sw      a1, 20(fp)      #segundo parametro: str
        sw      a2, 24(fp)      #tercer parametro: len


        lw      t0, 16(fp)
        sw      t0, 0(fp)      #0(fp) -> estructura 

        lw      t0, 20(fp)   # str
        sw      t0, 4(fp)      #4(fp) -> str

        lw      t0, 0(fp)      #t0 = direccion del sh
        lb      t1, 0(t0)       #t1 = flag

		#Assert  1
		beq     t1, 1, no_error
		beq     t1, 2, no_error
		
		li a0, 1
		la a1, mensaje
		lw	a2, longitud
		li v0, SYS_write 
		syscall
		li v0, SYS_exit
		syscall
    
no_error:

        li      t0, 1           #t0 = STRING_HASH_INIT
        bne     t1, t0, while

ifflag1:
        lw      t0, 0(fp)      #t0 = direccion del sh
        li      t1, 2           #t1 = STRING_HASH_MORE
        sll     t1, t1, 24	#recorro la estructura
        sw      t1, 0(t0)       #sh->flag = 2

        lw      t0, 20(fp)       #t0 -> str
        lb      t1, 0(t0)       #t1 -> *str (primeros 4 bytes)

        sll     t1, t1, 7        #t1 = (*str) << 7;


        lw      t0, 0(fp)      #t0 = direccion del sh
        sw      t1, 4(t0)       #sh->hash = (*str) << 7;


while:
        lw      t0, 4(fp)      #t0 -> str
        lb      t1, 0(t0)       #t1 -> *str (primeros 4 bytes)
        li      t0, 0
        beq     t1, t0, endwhile    #if (*str) == 0

        lw      t0, 24(fp)           # t0 = len
        beq     t0, 0, endwhile

continue:
        lw      t0, 0(fp)      #t0 = direccion del sh
        lw      t1, 4(t0)       #t1 = sh->hash

        mul     t0, t1, 1000003 #t0 = 1000003 * sh->hash

        lw      t1, 4(fp)      #t1 = str
        lb      t1, 0(t1)       #t2 = *str

        xor     t0,t1,t0

        lw      t1, 0(fp)      #t0 = direccion del sh
        sw      t0, 4(t1)       #sh->hash = (1000003 * sh->hash) ^ *str

        lw      t3, 4(fp)      #t3 = str
        addiu       t3,t3,1     #t3 = *str+1
        sw      t3, 4(fp)      #*str++


        lw      t0, 0(fp)      #t0 = direccion del sh
        lw      t1, 8(t0)       #t1 = sh->size
        addiu       t1,t1,1     #t1 = sh->size +1
        sw      t1, 8(t0)       #hash->size++


        lw      t0, 24(fp)       #t0 = len
        subu    t0, t0, 1       #t0 - -
        sw      t0, 24(fp)       #len - -

        b       while

endwhile:
        # restauro callee-saved regs
        lw      gp, 8(sp)
        lw      fp, 12(sp)
        # destruyo stack frame
        addu    sp, sp, 16
        # vuelvo a funcion llamante
        jr      ra

        .end    string_hash_more
        .size   string_hash_more,.-string_hash_more