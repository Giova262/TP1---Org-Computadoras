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


	sw a1, 44(fp)  #segundo parametro: msg
	sw a1, 4(fp)

	sw a2, 48(fp)  #tercer parametro: len
	sw a2, 8(fp)

	lw  t0, 0(fp)
	sw  t0, 16(fp) #16(fp) -> hash

	lw  t0, 4(fp)
	sw  t0, 20(fp) #20(fp) -> *str






    lw t0, 16(fp)   #t0 = direccion del hash
    lw t1, 0(t0)   #t1 = primer word del hash 
    srl t1, t1, 24 #t1= hash->flag

    li t0, 1	   #t0=STRING_HASH_INIT

    bne t1, t0, while

ifflag1:

	lw t0, 16(fp)  #t0 = direccion del hash
	li t1, 2	   #t1= STRING_HASH_MORE
	sll t1, t1, 24
	sw t1, 0(t0)   #hash->flag = 2 



    lw t0, 4(fp) # t0 -> *str
    lw t1, 0(t0) # t1 -> *str (primeros 4 bytes)
	sll t1, t1, 7        #t1 = (*str) << 7;

	lw t0, 16(fp)  #t0 = direccion del hash
	sw t1, 4(t0)   #hash->hash = (*str) << 7;


while:


    lw t0, 20(fp) # t0 -> str
    lw t1, 0(t0) # t1 -> *str (primeros 4 bytes)

	li t0, 0
	beq t1, t0, endwhile # if (*str)==0

	lw t0, 8(fp) # t0 = len
	beq t0, 0, endwhile

continue:
	



	lw t3, 20(fp)  #t3=*str
    addiu t3,t3,1  #t3=*str+1
    sw t3, 20(fp)  #str++


	lw t0, 16(fp)  #t0 = direccion del hash
	lw t1, 8(t0)   #t1 = hash->size
	addiu t1,t1,1  #t1 = hash->size +1
	sw t1, 8(t0)   #hash->size++


	lw t0, 8(fp)   # t0=len
	subu t0, t0, 1 # t0--
	sw t0, 8(fp)   # len --

	b while


endwhile:




#	addiu v0, a1, 0
#	lw v0, 4(a1)

#	b fin














	sll v0, v0, 7        #sh->hash = (*str) << 7;
	mul  t0, v0, 1000003 #t0 = 1000003 * sh->hash

	addiu t1, a1, 1     #t1 = *str++

	# t0 = base  y t1 = e  ->  base*e
	addiu  a0, t0, 0
	addiu  a1, t1, 0



	li  a0, 5
	li  a1, 3

    la t9, potencia
    jal ra, t9



###############################################



    lw t3, 16(fp)

    lw t0,0(t3)   
    srl t0, t0, 24#t0= flag

#    lw t0,4(t3)   #t0= hash
#    lw t0,8(t3)   #t0= size


#    lw t3, 20(fp) 
 #   addiu t3,t3,1      
 #   sw t3, 20(fp)  #t4 = primeros 4 caracteres de msd
#    addiu t0, t4, 0


 #   lw t3, 20(fp) 
 #   lw t4, 0(t3)  #t4 = primeros 4 caracteres de msd
  #  addiu t0, t4, 0


#    lw t0, 8(fp)  #t0 = len

 #   lw t0,0(t3)  #primeros 4 bytes de msg




    addiu v0, t0, 0

    #v0 = (1000003 * sh->hash) ^ *str++


############################################










fin:

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
