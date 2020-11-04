#include <sys/regdef.h>
#include <sys/syscall.h>

	.text			# segmento de texto del programa

	.abicalls
	.align 2		# alineacion 2^2


	.globl	hashAs
	.ent	hashAs

hashAs:
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
	sw	a0, 0(fp) # integer n -> El contenido del registro a0 se almacena en memoria(0+fp)

	lw  t3, 0(fp)
	lw  v0, 0(fp)
	sll v0, v0, 7
	mul  v0, v0, 1000003

	# t1 = x  y t0 = n  ->  x*n
	addiu  t1, v0, 0
	addiu  t0, t3, 0

	addiu  t2, t1, 0
	bne	   t0, 0, potencia	# if $t0 != $t1 then target
	li     t1, 1
	b finPotencia  # jump to target and save position to $ra
	
potencia:
	beq  t0,1,finPotencia
 	subu t0, t0, 1
 	mul  t1, t1, t2
 	b  potencia

finPotencia:	
	addiu v0, t1, 0

	# restauro callee-saved regs
	lw	gp, 24(sp)
	lw	fp, 28(sp)
	lw	ra, 32(sp)
	# destruyo stack frame
	addu	sp, sp, 40
	# vuelvo a funcion llamante
	jr	ra

	.end	hashAs
	.size	hashAs,.-hashAs
