#include <sys/regdef.h>
#include <sys/syscall.h>

	.text			# segmento de texto del programa

	.abicalls
	.align 2		# alineacion 2^2


	.globl	hashTest
	.ent	hashTest

hashTest:
	.frame fp, 40, ra
	.set	noreorder	# apaga reordenamiento de instrucciones
	.cpload t9		# directiva usada para codigo PIC
	.set	reorder		# enciende reordenamiento de instrucciones

	# creo stack frame
	subu	sp, sp, 40	# 4 (SRA) + 2 (LTA) + 4 (ABA)
	.cprestore 24		# sw gp, 24(sp)
	sw	fp, 28(sp)
	sw	ra, 32(sp)
	move	fp, sp
	
	# salvo 1er arg (siempre)
	sw	a0, 40(fp)	# n: a0, sp+40 -> El contenido del registro a0 se almacena en memoria(40+fp)
	sw	a0, 0(fp) # msg


	lw  t0, 0(fp)
	sw  t0, 16(fp) #16(fp) -> *str

	li t0, 0
	sw t0, 20(fp) #20(fp)-> hash = 0

ifflag1:

    lw t0, 0(fp) # t0 -> *str
    lw t1, 0(t0) # t1 -> *str (primeros 4 bytes)
    srl t1,t1,24 # t1 = primer caracter de str

	sll t1, t1, 7        #t1 = (*str) << 7;

	sw t1, 20(fp)   #hash = (*str) << 7;

	
while:

    lw t0, 16(fp) # t0 -> str
    lw t1, 0(t0) # t1 -> *str (primeros 4 bytes)
    srl t1,t1,24 # t1 = primer caracter de str

	li t0, 0
	beq t1, t0, endwhile # if (*str)==0

continue:
	

	lw t1, 20(fp)  #t1 = hash

	mul  t0, t1, 1000003 #t0 = 1000003 * hash
	
	lw t1, 16(fp)  #t1 = str
	lw t2, 0(t1)   #t2 = *str
	srl t1, t2, 24 #t1 = primer caracter de str

	xor t0,t1,t0

	sw t0, 20(fp)  #hash = (1000003 * hash) ^ *str


	lw t3, 16(fp)  #t3=*str
    addiu t3,t3,1  #t3=*str+1
    sw t3, 16(fp)  #str++

	b while

endwhile:

	lw v0, 20(fp)

	# restauro callee-saved regs
	lw	gp, 24(sp)
	lw	fp, 28(sp)
	lw	ra, 32(sp)
	# destruyo stack frame
	addu	sp, sp, 40
	# vuelvo a funcion llamante
	jr	ra

	.end	hashTest
	.size	hashTest,.-hashTest
