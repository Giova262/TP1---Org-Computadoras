#include <sys/regdef.h>
#include <sys/syscall.h>

        .text                   # segmento de texto del programa

        .abicalls
        .align 2                # alineacion 2^2

        .globl  hashAs
        .ent    hashAs

hashAs:
        .frame fp, 40, ra

        # creo stack frame
        subu    sp, sp, 40      
        .cprestore 24           # sw gp, 24(sp)
        sw      fp, 28(sp)
        sw      ra, 32(sp)
        move    fp, sp

        sw      a0, 40(fp)      #primer parametro: sh
        sw      a0, 0(fp)

        sw      a1, 44(fp)      #segundo parametro: str
        sw      a1, 4(fp)

        sw      a2, 48(fp)      #tercer parametro: len
        sw      a2, 8(fp)


        lw      t0, 0(fp)
        sw      t0, 16(fp)      #16(fp) -> sh

        lw      t0, 4(fp)
        sw      t0, 20(fp)      #20(fp) -> str

        lw      t0, 16(fp)      #t0 = direccion del sh
        lw      t1, 0(t0)       #t1 = primer word del sh
        srl     t1, t1, 24      #t1 = sh->flag
    
        li      t0, 1           #t0 = STRING_HASH_INIT
    
        bne     t1, t0, while

ifflag1:
        lw      t0, 16(fp)      #t0 = direccion del sh
        li      t1, 2           #t1 = STRING_HASH_MORE
        sll     t1, t1, 24
        sw      t1, 0(t0)       #sh->flag = 2

        lw      t0, 4(fp)       #t0 -> str
        lw      t1, 0(t0)       #t1 -> *str (primeros 4 bytes)
        srl     t1,t1,24        #t1 = primer caracter de str

        sll     t1, t1, 7        #t1 = (*str) << 7;


        lw      t0, 16(fp)      #t0 = direccion del sh
        sw      t1, 4(t0)       #sh->hash = (*str) << 7;


while:
        lw      t0, 20(fp)      #t0 -> str
        lw      t1, 0(t0)       #t1 -> *str (primeros 4 bytes)
        srl     t1,t1,24        #t1 = primer caracter de str

        li      t0, 0
        beq     t1, t0, endwhile    #if (*str) == 0

        lw      t0, 8(fp)           # t0 = len
        beq     t0, 0, endwhile

continue:
        lw      t0, 16(fp)      #t0 = direccion del sh
        lw      t1, 4(t0)       #t1 = sh->hash

        mul     t0, t1, 1000003 #t0 = 1000003 * sh->hash

        lw      t1, 20(fp)      #t1 = str
        lw      t2, 0(t1)       #t2 = *str
        srl     t1, t2, 24      #t1 = primer caracter de str

        xor     t0,t1,t0

        lw      t1, 16(fp)      #t0 = direccion del sh
        sw      t0, 4(t1)       #sh->hash = (1000003 * sh->hash) ^ *str

        lw      t3, 20(fp)      #t3 = str
        addiu       t3,t3,1     #t3 = *str+1
        sw      t3, 20(fp)      #*str++


        lw      t0, 16(fp)      #t0 = direccion del sh
        lw      t1, 8(t0)       #t1 = sh->size
        addiu       t1,t1,1     #t1 = sh->size +1
        sw      t1, 8(t0)       #hash->size++


        lw      t0, 8(fp)       #t0 = len
        subu    t0, t0, 1       #t0 - -
        sw      t0, 8(fp)       #len - -

        b       while

endwhile:
        # restauro callee-saved regs
        lw      gp, 24(sp)
        lw      fp, 28(sp)
        lw      ra, 32(sp)
        # destruyo stack frame
        addu    sp, sp, 40
        # vuelvo a funcion llamante
        jr      ra

        .end    hashAs
        .size   hashAs,.-hashAs