#include <sys/regdef.h>
#include <sys/syscall.h>

	.text
	.ent potencia
	.globl potencia
	
potencia:	

	.frame 	fp,40,ra

	subu 	sp,sp,40 	#Stack frame creation

	.cprestore 24		#Saved register area. 
	sw	ra,32(sp)
	sw	fp,28(sp)	
	move	fp,sp

	sw	a0,40(fp)	#Argument Building Area
	sw	a0,16(fp)	#Local and Temporary Area.

	sw	a1,44(fp)	#Argument Building Area
	sw	a1,20(fp)	#Local and Temporary Area.
				
	lw	t1,20(fp)
	beq	t1,zero,ret1

rec:
	lw	t0,16(fp)	#t0 = base
	subu	t1,t1,1 #t1 = e-1
	sw	t1,20(fp)
	addu	a0,t0,zero
	addu	a1,t1,zero
	jal	potencia	#llamada
	
					#v0 = potencia(base,e-1)
	lw	t0,40(fp)	
	mul	v0,v0,t0	#v0 = base * potencia(base,e-1)
	b	fin

ret1:	li	v0,1		#return 1

fin:	
	lw	ra,32(sp)
	lw	fp,28(sp)
	addu	sp,sp,40

	jr	ra
	.end 	potencia
	



	


	
