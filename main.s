	.file	1 "main.c"
	.section .mdebug.abi32
	.previous
	.nan	legacy
	.module	fp=xx
	.module	nooddspreg
	.abicalls
	.rdata
	.align	2
$LC0:
	.ascii	"main.c\000"
	.align	2
$LC1:
	.ascii	"sh->flag == STRING_HASH_INIT || sh->flag == STRING_HASH_"
	.ascii	"MORE\000"
	.text
	.align	2
	.set	nomips16
	.set	nomicromips
	.ent	string_hash_done
	.type	string_hash_done, @function
string_hash_done:
	.frame	$fp,32,$31		# vars= 0, regs= 2/0, args= 16, gp= 8
	.mask	0xc0000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$25
	.set	nomacro
	addiu	$sp,$sp,-32
	sw	$31,28($sp)
	sw	$fp,24($sp)
	move	$fp,$sp
	.cprestore	16
	sw	$4,32($fp)
	lw	$2,32($fp)
	lb	$3,0($2)
	li	$2,1			# 0x1
	beq	$3,$2,$L2
	nop

	lw	$2,32($fp)
	lb	$3,0($2)
	li	$2,2			# 0x2
	beq	$3,$2,$L2
	nop

	lw	$2,%got(__PRETTY_FUNCTION__.3238)($28)
	addiu	$7,$2,%lo(__PRETTY_FUNCTION__.3238)
	li	$6,20			# 0x14
	lw	$2,%got($LC0)($28)
	addiu	$5,$2,%lo($LC0)
	lw	$2,%got($LC1)($28)
	addiu	$4,$2,%lo($LC1)
	lw	$2,%call16(__assert_fail)($28)
	move	$25,$2
	.reloc	1f,R_MIPS_JALR,__assert_fail
1:	jalr	$25
	nop

$L2:
	lw	$2,32($fp)
	lw	$2,4($2)
	move	$3,$2
	lw	$2,32($fp)
	lw	$2,8($2)
	xor	$2,$3,$2
	move	$3,$2
	lw	$2,32($fp)
	sw	$3,4($2)
	lw	$2,32($fp)
	lw	$3,4($2)
	li	$2,-1			# 0xffffffffffffffff
	bne	$3,$2,$L3
	nop

	lw	$2,32($fp)
	li	$3,-2			# 0xfffffffffffffffe
	sw	$3,4($2)
$L3:
	lw	$2,32($fp)
	li	$3,3			# 0x3
	sb	$3,0($2)
	nop
	move	$sp,$fp
	lw	$31,28($sp)
	lw	$fp,24($sp)
	addiu	$sp,$sp,32
	jr	$31
	nop

	.set	macro
	.set	reorder
	.end	string_hash_done
	.size	string_hash_done, .-string_hash_done
	.align	2
	.set	nomips16
	.set	nomicromips
	.ent	string_hash_init
	.type	string_hash_init, @function
string_hash_init:
	.frame	$fp,8,$31		# vars= 0, regs= 1/0, args= 0, gp= 0
	.mask	0x40000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-8
	sw	$fp,4($sp)
	move	$fp,$sp
	sw	$4,8($fp)
	lw	$2,8($fp)
	li	$3,1			# 0x1
	sb	$3,0($2)
	lw	$2,8($fp)
	sw	$0,4($2)
	lw	$2,8($fp)
	sw	$0,8($2)
	nop
	move	$sp,$fp
	lw	$fp,4($sp)
	addiu	$sp,$sp,8
	jr	$31
	nop

	.set	macro
	.set	reorder
	.end	string_hash_init
	.size	string_hash_init, .-string_hash_init
	.align	2
	.globl	processLine
	.set	nomips16
	.set	nomicromips
	.ent	processLine
	.type	processLine, @function
processLine:
	.frame	$fp,40,$31		# vars= 8, regs= 2/0, args= 16, gp= 8
	.mask	0xc0000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$25
	.set	nomacro
	addiu	$sp,$sp,-40
	sw	$31,36($sp)
	sw	$fp,32($sp)
	move	$fp,$sp
	.cprestore	16
	sw	$4,40($fp)
	sw	$5,44($fp)
	lw	$4,40($fp)
	lw	$2,%call16(strlen)($28)
	move	$25,$2
	.reloc	1f,R_MIPS_JALR,strlen
1:	jalr	$25
	nop

	lw	$28,16($fp)
	sw	$2,24($fp)
	lw	$4,44($fp)
	lw	$2,%got(string_hash_init)($28)
	addiu	$2,$2,%lo(string_hash_init)
	move	$25,$2
	.reloc	1f,R_MIPS_JALR,string_hash_init
1:	jalr	$25
	nop

	lw	$28,16($fp)
	lw	$6,24($fp)
	lw	$5,40($fp)
	lw	$4,44($fp)
	lw	$2,%call16(string_hash_more)($28)
	move	$25,$2
	.reloc	1f,R_MIPS_JALR,string_hash_more
1:	jalr	$25
	nop

	lw	$28,16($fp)
	lw	$4,44($fp)
	lw	$2,%got(string_hash_done)($28)
	addiu	$2,$2,%lo(string_hash_done)
	move	$25,$2
	.reloc	1f,R_MIPS_JALR,string_hash_done
1:	jalr	$25
	nop

	lw	$28,16($fp)
	lw	$2,44($fp)
	lw	$2,4($2)
	move	$sp,$fp
	lw	$31,36($sp)
	lw	$fp,32($sp)
	addiu	$sp,$sp,40
	jr	$31
	nop

	.set	macro
	.set	reorder
	.end	processLine
	.size	processLine, .-processLine
	.rdata
	.align	2
$LC2:
	.ascii	"-\000"
	.align	2
$LC3:
	.ascii	"-h\000"
	.align	2
$LC4:
	.ascii	"\012Usage:\012\011 tp1 -h \012\011 tp1 -V \012\011 tp1 -"
	.ascii	"i in_file -o out_file \012Options:\012\011 -V, --version"
	.ascii	" Print version and quit.\012 \011 -h, --help Print this "
	.ascii	"information and quit.\012 \011 -i, --input Specify input"
	.ascii	" stream/file, \"-\" for stdin. \012\011 -o, --output Spe"
	.ascii	"cify output stream/file, \"-\" for stdout. \012Examples:"
	.ascii	"\012 \011 tp1 < in.txt > out.txt\012\011 cat in.txt | tp"
	.ascii	"1 -i - > out.txt\012\000"
	.align	2
$LC5:
	.ascii	"-V\000"
	.align	2
$LC6:
	.ascii	"\012Trabajo Practico nro 1 - Organizacion de Computadora"
	.ascii	"s. \012\012Integrantes:\012\011 Micaela Villordo 103828\012"
	.ascii	"\011 Martin Charytoniuk 96354\012\011 Josue Giovanni Val"
	.ascii	"divia 93075\012\000"
	.align	2
$LC7:
	.ascii	"-test\000"
	.align	2
$LC8:
	.ascii	"\012Testeando codigo aseembly. \012\000"
	.align	2
$LC9:
	.ascii	"mensaje para string hash\000"
	.align	2
$LC10:
	.ascii	"hash 1: 0x%04x\012\000"
	.align	2
$LC11:
	.ascii	"-i\000"
	.align	2
$LC12:
	.ascii	"-o\000"
	.align	2
$LC13:
	.ascii	"No se reconoce el comando\012\000"
	.align	2
$LC14:
	.ascii	"Falta definir la entrada.\012\000"
	.align	2
$LC15:
	.ascii	"w\000"
	.align	2
$LC16:
	.ascii	"No pudo abrir el archivo\012\000"
	.align	2
$LC17:
	.ascii	"r\000"
	.align	2
$LC18:
	.ascii	"0x%04x %s\000"
	.align	2
$LC19:
	.ascii	"Error al escribir en archivo de salida.\000"
	.align	2
$LC20:
	.ascii	"Success\000"
	.align	2
$LC21:
	.ascii	"Error al leer la linea.\012\000"
	.align	2
$LC22:
	.ascii	"open failed\000"
	.align	2
$LC23:
	.ascii	"dup2 failed\000"
	.text
	.align	2
	.globl	main
	.set	nomips16
	.set	nomicromips
	.ent	main
	.type	main, @function
main:
	.frame	$fp,112,$31		# vars= 80, regs= 2/0, args= 16, gp= 8
	.mask	0xc0000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$25
	.set	nomacro
	addiu	$sp,$sp,-112
	sw	$31,108($sp)
	sw	$fp,104($sp)
	move	$fp,$sp
	.cprestore	16
	sw	$4,112($fp)
	sw	$5,116($fp)
	lw	$2,%got($LC2)($28)
	addiu	$2,$2,%lo($LC2)
	sw	$2,48($fp)
	sw	$0,24($fp)
	lw	$2,48($fp)
	sw	$2,28($fp)
	lw	$2,48($fp)
	sw	$2,32($fp)
	lw	$2,%got(stdin)($28)
	lw	$2,0($2)
	sw	$2,40($fp)
	sw	$0,44($fp)
	lw	$2,112($fp)
	slt	$2,$2,2
	bne	$2,$0,$L8
	nop

	li	$2,1			# 0x1
	sw	$2,24($fp)
	b	$L9
	nop

$L12:
	lw	$2,24($fp)
	sll	$2,$2,2
	lw	$3,116($fp)
	addu	$2,$3,$2
	lw	$2,0($2)
	move	$5,$2
	lw	$2,%got($LC3)($28)
	addiu	$4,$2,%lo($LC3)
	lw	$2,%call16(strcmp)($28)
	move	$25,$2
	.reloc	1f,R_MIPS_JALR,strcmp
1:	jalr	$25
	nop

	lw	$28,16($fp)
	bne	$2,$0,$L10
	nop

	lw	$2,%got($LC4)($28)
	addiu	$4,$2,%lo($LC4)
	lw	$2,%call16(puts)($28)
	move	$25,$2
	.reloc	1f,R_MIPS_JALR,puts
1:	jalr	$25
	nop

	lw	$28,16($fp)
	move	$2,$0
	b	$L41
	nop

$L10:
	lw	$2,24($fp)
	addiu	$2,$2,1
	sw	$2,24($fp)
$L9:
	lw	$3,24($fp)
	lw	$2,112($fp)
	slt	$2,$3,$2
	bne	$2,$0,$L12
	nop

	li	$2,1			# 0x1
	sw	$2,24($fp)
	b	$L13
	nop

$L15:
	lw	$2,24($fp)
	sll	$2,$2,2
	lw	$3,116($fp)
	addu	$2,$3,$2
	lw	$2,0($2)
	move	$5,$2
	lw	$2,%got($LC5)($28)
	addiu	$4,$2,%lo($LC5)
	lw	$2,%call16(strcmp)($28)
	move	$25,$2
	.reloc	1f,R_MIPS_JALR,strcmp
1:	jalr	$25
	nop

	lw	$28,16($fp)
	bne	$2,$0,$L14
	nop

	lw	$2,%got($LC6)($28)
	addiu	$4,$2,%lo($LC6)
	lw	$2,%call16(puts)($28)
	move	$25,$2
	.reloc	1f,R_MIPS_JALR,puts
1:	jalr	$25
	nop

	lw	$28,16($fp)
	move	$2,$0
	b	$L41
	nop

$L14:
	lw	$2,24($fp)
	addiu	$2,$2,1
	sw	$2,24($fp)
$L13:
	lw	$3,24($fp)
	lw	$2,112($fp)
	slt	$2,$3,$2
	bne	$2,$0,$L15
	nop

	li	$2,1			# 0x1
	sw	$2,24($fp)
	b	$L16
	nop

$L18:
	lw	$2,24($fp)
	sll	$2,$2,2
	lw	$3,116($fp)
	addu	$2,$3,$2
	lw	$2,0($2)
	move	$5,$2
	lw	$2,%got($LC7)($28)
	addiu	$4,$2,%lo($LC7)
	lw	$2,%call16(strcmp)($28)
	move	$25,$2
	.reloc	1f,R_MIPS_JALR,strcmp
1:	jalr	$25
	nop

	lw	$28,16($fp)
	bne	$2,$0,$L17
	nop

	lw	$2,%got($LC8)($28)
	addiu	$4,$2,%lo($LC8)
	lw	$2,%call16(puts)($28)
	move	$25,$2
	.reloc	1f,R_MIPS_JALR,puts
1:	jalr	$25
	nop

	lw	$28,16($fp)
	lw	$2,%got($LC9)($28)
	addiu	$2,$2,%lo($LC9)
	sw	$2,52($fp)
	addiu	$2,$fp,76
	move	$5,$2
	lw	$4,52($fp)
	lw	$2,%got(processLine)($28)
	move	$25,$2
	.reloc	1f,R_MIPS_JALR,processLine
1:	jalr	$25
	nop

	lw	$28,16($fp)
	sw	$2,56($fp)
	lw	$5,56($fp)
	lw	$2,%got($LC10)($28)
	addiu	$4,$2,%lo($LC10)
	lw	$2,%call16(printf)($28)
	move	$25,$2
	.reloc	1f,R_MIPS_JALR,printf
1:	jalr	$25
	nop

	lw	$28,16($fp)
	move	$2,$0
	b	$L41
	nop

$L17:
	lw	$2,24($fp)
	addiu	$2,$2,1
	sw	$2,24($fp)
$L16:
	lw	$3,24($fp)
	lw	$2,112($fp)
	slt	$2,$3,$2
	bne	$2,$0,$L18
	nop

	li	$2,1			# 0x1
	sw	$2,24($fp)
	b	$L19
	nop

$L22:
	lw	$2,24($fp)
	sll	$2,$2,2
	lw	$3,116($fp)
	addu	$2,$3,$2
	lw	$2,0($2)
	move	$5,$2
	lw	$2,%got($LC11)($28)
	addiu	$4,$2,%lo($LC11)
	lw	$2,%call16(strcmp)($28)
	move	$25,$2
	.reloc	1f,R_MIPS_JALR,strcmp
1:	jalr	$25
	nop

	lw	$28,16($fp)
	bne	$2,$0,$L20
	nop

	lw	$2,24($fp)
	addiu	$3,$2,1
	lw	$2,112($fp)
	slt	$2,$3,$2
	beq	$2,$0,$L20
	nop

	lw	$2,24($fp)
	addiu	$2,$2,1
	sll	$2,$2,2
	lw	$3,116($fp)
	addu	$2,$3,$2
	lw	$2,0($2)
	sw	$2,28($fp)
	li	$2,1			# 0x1
	sw	$2,44($fp)
	b	$L21
	nop

$L20:
	lw	$2,24($fp)
	sll	$2,$2,2
	lw	$3,116($fp)
	addu	$2,$3,$2
	lw	$2,0($2)
	move	$5,$2
	lw	$2,%got($LC11)($28)
	addiu	$4,$2,%lo($LC11)
	lw	$2,%call16(strcmp)($28)
	move	$25,$2
	.reloc	1f,R_MIPS_JALR,strcmp
1:	jalr	$25
	nop

	lw	$28,16($fp)
	bne	$2,$0,$L21
	nop

	li	$2,2			# 0x2
	sw	$2,44($fp)
$L21:
	lw	$2,24($fp)
	addiu	$2,$2,1
	sw	$2,24($fp)
$L19:
	lw	$3,24($fp)
	lw	$2,112($fp)
	slt	$2,$3,$2
	bne	$2,$0,$L22
	nop

	li	$2,1			# 0x1
	sw	$2,24($fp)
	b	$L23
	nop

$L25:
	lw	$2,24($fp)
	sll	$2,$2,2
	lw	$3,116($fp)
	addu	$2,$3,$2
	lw	$2,0($2)
	move	$5,$2
	lw	$2,%got($LC12)($28)
	addiu	$4,$2,%lo($LC12)
	lw	$2,%call16(strcmp)($28)
	move	$25,$2
	.reloc	1f,R_MIPS_JALR,strcmp
1:	jalr	$25
	nop

	lw	$28,16($fp)
	bne	$2,$0,$L24
	nop

	lw	$2,24($fp)
	addiu	$3,$2,1
	lw	$2,112($fp)
	slt	$2,$3,$2
	beq	$2,$0,$L24
	nop

	lw	$2,24($fp)
	addiu	$2,$2,1
	sll	$2,$2,2
	lw	$3,116($fp)
	addu	$2,$3,$2
	lw	$2,0($2)
	sw	$2,32($fp)
	li	$2,1			# 0x1
	sw	$2,44($fp)
$L24:
	lw	$2,24($fp)
	addiu	$2,$2,1
	sw	$2,24($fp)
$L23:
	lw	$3,24($fp)
	lw	$2,112($fp)
	slt	$2,$3,$2
	bne	$2,$0,$L25
	nop

	lw	$2,44($fp)
	bne	$2,$0,$L26
	nop

	lw	$2,%got(stderr)($28)
	lw	$2,0($2)
	move	$7,$2
	li	$6,26			# 0x1a
	li	$5,1			# 0x1
	lw	$2,%got($LC13)($28)
	addiu	$4,$2,%lo($LC13)
	lw	$2,%call16(fwrite)($28)
	move	$25,$2
	.reloc	1f,R_MIPS_JALR,fwrite
1:	jalr	$25
	nop

	lw	$28,16($fp)
	li	$2,-1			# 0xffffffffffffffff
	b	$L41
	nop

$L26:
	lw	$3,44($fp)
	li	$2,2			# 0x2
	bne	$3,$2,$L8
	nop

	lw	$2,%got(stderr)($28)
	lw	$2,0($2)
	move	$7,$2
	li	$6,26			# 0x1a
	li	$5,1			# 0x1
	lw	$2,%got($LC14)($28)
	addiu	$4,$2,%lo($LC14)
	lw	$2,%call16(fwrite)($28)
	move	$25,$2
	.reloc	1f,R_MIPS_JALR,fwrite
1:	jalr	$25
	nop

	lw	$28,16($fp)
	li	$2,-1			# 0xffffffffffffffff
	b	$L41
	nop

$L8:
	lw	$5,32($fp)
	lw	$4,48($fp)
	lw	$2,%call16(strcmp)($28)
	move	$25,$2
	.reloc	1f,R_MIPS_JALR,strcmp
1:	jalr	$25
	nop

	lw	$28,16($fp)
	beq	$2,$0,$L27
	nop

	lw	$2,%got($LC15)($28)
	addiu	$5,$2,%lo($LC15)
	lw	$4,32($fp)
	lw	$2,%call16(fopen)($28)
	move	$25,$2
	.reloc	1f,R_MIPS_JALR,fopen
1:	jalr	$25
	nop

	lw	$28,16($fp)
	sw	$2,36($fp)
	lw	$2,36($fp)
	bne	$2,$0,$L27
	nop

	lw	$2,%got(stderr)($28)
	lw	$2,0($2)
	move	$7,$2
	li	$6,25			# 0x19
	li	$5,1			# 0x1
	lw	$2,%got($LC16)($28)
	addiu	$4,$2,%lo($LC16)
	lw	$2,%call16(fwrite)($28)
	move	$25,$2
	.reloc	1f,R_MIPS_JALR,fwrite
1:	jalr	$25
	nop

	lw	$28,16($fp)
	li	$2,-1			# 0xffffffffffffffff
	b	$L41
	nop

$L27:
	lw	$5,28($fp)
	lw	$4,48($fp)
	lw	$2,%call16(strcmp)($28)
	move	$25,$2
	.reloc	1f,R_MIPS_JALR,strcmp
1:	jalr	$25
	nop

	lw	$28,16($fp)
	beq	$2,$0,$L28
	nop

	lw	$2,%got($LC17)($28)
	addiu	$5,$2,%lo($LC17)
	lw	$4,28($fp)
	lw	$2,%call16(fopen)($28)
	move	$25,$2
	.reloc	1f,R_MIPS_JALR,fopen
1:	jalr	$25
	nop

	lw	$28,16($fp)
	sw	$2,40($fp)
	lw	$2,40($fp)
	bne	$2,$0,$L28
	nop

	lw	$2,%got(stderr)($28)
	lw	$2,0($2)
	move	$7,$2
	li	$6,25			# 0x19
	li	$5,1			# 0x1
	lw	$2,%got($LC16)($28)
	addiu	$4,$2,%lo($LC16)
	lw	$2,%call16(fwrite)($28)
	move	$25,$2
	.reloc	1f,R_MIPS_JALR,fwrite
1:	jalr	$25
	nop

	lw	$28,16($fp)
	li	$2,-1			# 0xffffffffffffffff
	b	$L41
	nop

$L28:
	sw	$0,88($fp)
	sw	$0,92($fp)
	b	$L29
	nop

$L31:
	lw	$2,88($fp)
	move	$4,$2
	lw	$2,%call16(strlen)($28)
	move	$25,$2
	.reloc	1f,R_MIPS_JALR,strlen
1:	jalr	$25
	nop

	lw	$28,16($fp)
	sw	$2,92($fp)
	lw	$5,32($fp)
	lw	$4,48($fp)
	lw	$2,%call16(strcmp)($28)
	move	$25,$2
	.reloc	1f,R_MIPS_JALR,strcmp
1:	jalr	$25
	nop

	lw	$28,16($fp)
	bne	$2,$0,$L30
	nop

	lw	$2,88($fp)
	addiu	$3,$fp,76
	move	$5,$3
	move	$4,$2
	lw	$2,%got(processLine)($28)
	move	$25,$2
	.reloc	1f,R_MIPS_JALR,processLine
1:	jalr	$25
	nop

	lw	$28,16($fp)
	lw	$2,80($fp)
	lw	$3,88($fp)
	move	$6,$3
	move	$5,$2
	lw	$2,%got($LC18)($28)
	addiu	$4,$2,%lo($LC18)
	lw	$2,%call16(printf)($28)
	move	$25,$2
	.reloc	1f,R_MIPS_JALR,printf
1:	jalr	$25
	nop

	lw	$28,16($fp)
	b	$L29
	nop

$L30:
	lw	$2,88($fp)
	addiu	$3,$fp,76
	move	$5,$3
	move	$4,$2
	lw	$2,%got(processLine)($28)
	move	$25,$2
	.reloc	1f,R_MIPS_JALR,processLine
1:	jalr	$25
	nop

	lw	$28,16($fp)
	sw	$2,64($fp)
	lw	$2,88($fp)
	move	$7,$2
	lw	$6,64($fp)
	lw	$2,%got($LC18)($28)
	addiu	$5,$2,%lo($LC18)
	lw	$4,36($fp)
	lw	$2,%call16(fprintf)($28)
	move	$25,$2
	.reloc	1f,R_MIPS_JALR,fprintf
1:	jalr	$25
	nop

	lw	$28,16($fp)
	bgez	$2,$L29
	nop

	lw	$2,%got(stderr)($28)
	lw	$2,0($2)
	move	$7,$2
	li	$6,39			# 0x27
	li	$5,1			# 0x1
	lw	$2,%got($LC19)($28)
	addiu	$4,$2,%lo($LC19)
	lw	$2,%call16(fwrite)($28)
	move	$25,$2
	.reloc	1f,R_MIPS_JALR,fwrite
1:	jalr	$25
	nop

	lw	$28,16($fp)
$L29:
	addiu	$3,$fp,92
	addiu	$2,$fp,88
	lw	$6,40($fp)
	move	$5,$3
	move	$4,$2
	lw	$2,%call16(getline)($28)
	move	$25,$2
	.reloc	1f,R_MIPS_JALR,getline
1:	jalr	$25
	nop

	lw	$28,16($fp)
	sw	$2,60($fp)
	lw	$3,60($fp)
	li	$2,-1			# 0xffffffffffffffff
	bne	$3,$2,$L31
	nop

	lw	$2,%call16(__errno_location)($28)
	move	$25,$2
	.reloc	1f,R_MIPS_JALR,__errno_location
1:	jalr	$25
	nop

	lw	$28,16($fp)
	lw	$2,0($2)
	move	$4,$2
	lw	$2,%call16(strerror)($28)
	move	$25,$2
	.reloc	1f,R_MIPS_JALR,strerror
1:	jalr	$25
	nop

	lw	$28,16($fp)
	move	$3,$2
	lw	$2,%got($LC20)($28)
	addiu	$5,$2,%lo($LC20)
	move	$4,$3
	lw	$2,%call16(strcmp)($28)
	move	$25,$2
	.reloc	1f,R_MIPS_JALR,strcmp
1:	jalr	$25
	nop

	lw	$28,16($fp)
	beq	$2,$0,$L32
	nop

	lw	$2,%got(stderr)($28)
	lw	$2,0($2)
	move	$7,$2
	li	$6,24			# 0x18
	li	$5,1			# 0x1
	lw	$2,%got($LC21)($28)
	addiu	$4,$2,%lo($LC21)
	lw	$2,%call16(fwrite)($28)
	move	$25,$2
	.reloc	1f,R_MIPS_JALR,fwrite
1:	jalr	$25
	nop

	lw	$28,16($fp)
$L32:
	lw	$5,28($fp)
	lw	$4,48($fp)
	lw	$2,%call16(strcmp)($28)
	move	$25,$2
	.reloc	1f,R_MIPS_JALR,strcmp
1:	jalr	$25
	nop

	lw	$28,16($fp)
	beq	$2,$0,$L33
	nop

	lw	$4,40($fp)
	lw	$2,%call16(fclose)($28)
	move	$25,$2
	.reloc	1f,R_MIPS_JALR,fclose
1:	jalr	$25
	nop

	lw	$28,16($fp)
$L33:
	lw	$5,32($fp)
	lw	$4,48($fp)
	lw	$2,%call16(strcmp)($28)
	move	$25,$2
	.reloc	1f,R_MIPS_JALR,strcmp
1:	jalr	$25
	nop

	lw	$28,16($fp)
	beq	$2,$0,$L34
	nop

	lw	$4,36($fp)
	lw	$2,%call16(fclose)($28)
	move	$25,$2
	.reloc	1f,R_MIPS_JALR,fclose
1:	jalr	$25
	nop

	lw	$28,16($fp)
$L34:
	lw	$5,32($fp)
	lw	$4,48($fp)
	lw	$2,%call16(strcmp)($28)
	move	$25,$2
	.reloc	1f,R_MIPS_JALR,strcmp
1:	jalr	$25
	nop

	lw	$28,16($fp)
	beq	$2,$0,$L35
	nop

	lw	$2,32($fp)
	sw	$2,68($fp)
	li	$6,420			# 0x1a4
	li	$5,257			# 0x101
	lw	$4,68($fp)
	lw	$2,%call16(open)($28)
	move	$25,$2
	.reloc	1f,R_MIPS_JALR,open
1:	jalr	$25
	nop

	lw	$28,16($fp)
	sw	$2,72($fp)
	lw	$3,72($fp)
	li	$2,-1			# 0xffffffffffffffff
	bne	$3,$2,$L36
	nop

	lw	$2,%got($LC22)($28)
	addiu	$4,$2,%lo($LC22)
	lw	$2,%call16(perror)($28)
	move	$25,$2
	.reloc	1f,R_MIPS_JALR,perror
1:	jalr	$25
	nop

	lw	$28,16($fp)
	lw	$2,%got(stderr)($28)
	lw	$2,0($2)
	move	$7,$2
	li	$6,11			# 0xb
	li	$5,1			# 0x1
	lw	$2,%got($LC22)($28)
	addiu	$4,$2,%lo($LC22)
	lw	$2,%call16(fwrite)($28)
	move	$25,$2
	.reloc	1f,R_MIPS_JALR,fwrite
1:	jalr	$25
	nop

	lw	$28,16($fp)
	li	$4,1			# 0x1
	lw	$2,%call16(exit)($28)
	move	$25,$2
	.reloc	1f,R_MIPS_JALR,exit
1:	jalr	$25
	nop

$L36:
	li	$5,1			# 0x1
	lw	$4,72($fp)
	lw	$2,%call16(dup2)($28)
	move	$25,$2
	.reloc	1f,R_MIPS_JALR,dup2
1:	jalr	$25
	nop

	lw	$28,16($fp)
	move	$3,$2
	li	$2,-1			# 0xffffffffffffffff
	bne	$3,$2,$L37
	nop

	lw	$2,%got($LC23)($28)
	addiu	$4,$2,%lo($LC23)
	lw	$2,%call16(perror)($28)
	move	$25,$2
	.reloc	1f,R_MIPS_JALR,perror
1:	jalr	$25
	nop

	lw	$28,16($fp)
	lw	$2,%got(stderr)($28)
	lw	$2,0($2)
	move	$7,$2
	li	$6,11			# 0xb
	li	$5,1			# 0x1
	lw	$2,%got($LC23)($28)
	addiu	$4,$2,%lo($LC23)
	lw	$2,%call16(fwrite)($28)
	move	$25,$2
	.reloc	1f,R_MIPS_JALR,fwrite
1:	jalr	$25
	nop

	lw	$28,16($fp)
	li	$4,1			# 0x1
	lw	$2,%call16(exit)($28)
	move	$25,$2
	.reloc	1f,R_MIPS_JALR,exit
1:	jalr	$25
	nop

$L37:
	sw	$0,96($fp)
	b	$L38
	nop

$L39:
	lw	$2,96($fp)
	move	$4,$2
	lw	$2,%call16(strlen)($28)
	move	$25,$2
	.reloc	1f,R_MIPS_JALR,strlen
1:	jalr	$25
	nop

	lw	$28,16($fp)
	sw	$2,100($fp)
	lw	$2,96($fp)
	addiu	$3,$fp,76
	move	$5,$3
	move	$4,$2
	lw	$2,%got(processLine)($28)
	move	$25,$2
	.reloc	1f,R_MIPS_JALR,processLine
1:	jalr	$25
	nop

	lw	$28,16($fp)
	lw	$2,80($fp)
	lw	$3,96($fp)
	move	$6,$3
	move	$5,$2
	lw	$2,%got($LC18)($28)
	addiu	$4,$2,%lo($LC18)
	lw	$2,%call16(printf)($28)
	move	$25,$2
	.reloc	1f,R_MIPS_JALR,printf
1:	jalr	$25
	nop

	lw	$28,16($fp)
$L38:
	addiu	$3,$fp,100
	addiu	$2,$fp,96
	lw	$6,40($fp)
	move	$5,$3
	move	$4,$2
	lw	$2,%call16(getline)($28)
	move	$25,$2
	.reloc	1f,R_MIPS_JALR,getline
1:	jalr	$25
	nop

	lw	$28,16($fp)
	sw	$2,60($fp)
	lw	$3,60($fp)
	li	$2,-1			# 0xffffffffffffffff
	bne	$3,$2,$L39
	nop

	lw	$2,%call16(__errno_location)($28)
	move	$25,$2
	.reloc	1f,R_MIPS_JALR,__errno_location
1:	jalr	$25
	nop

	lw	$28,16($fp)
	lw	$2,0($2)
	move	$4,$2
	lw	$2,%call16(strerror)($28)
	move	$25,$2
	.reloc	1f,R_MIPS_JALR,strerror
1:	jalr	$25
	nop

	lw	$28,16($fp)
	move	$3,$2
	lw	$2,%got($LC20)($28)
	addiu	$5,$2,%lo($LC20)
	move	$4,$3
	lw	$2,%call16(strcmp)($28)
	move	$25,$2
	.reloc	1f,R_MIPS_JALR,strcmp
1:	jalr	$25
	nop

	lw	$28,16($fp)
	beq	$2,$0,$L40
	nop

	lw	$2,%got(stderr)($28)
	lw	$2,0($2)
	move	$7,$2
	li	$6,24			# 0x18
	li	$5,1			# 0x1
	lw	$2,%got($LC21)($28)
	addiu	$4,$2,%lo($LC21)
	lw	$2,%call16(fwrite)($28)
	move	$25,$2
	.reloc	1f,R_MIPS_JALR,fwrite
1:	jalr	$25
	nop

	lw	$28,16($fp)
$L40:
	lw	$4,72($fp)
	lw	$2,%call16(close)($28)
	move	$25,$2
	.reloc	1f,R_MIPS_JALR,close
1:	jalr	$25
	nop

	lw	$28,16($fp)
$L35:
	move	$2,$0
$L41:
	move	$sp,$fp
	lw	$31,108($sp)
	lw	$fp,104($sp)
	addiu	$sp,$sp,112
	jr	$31
	nop

	.set	macro
	.set	reorder
	.end	main
	.size	main, .-main
	.rdata
	.align	2
	.type	__PRETTY_FUNCTION__.3238, @object
	.size	__PRETTY_FUNCTION__.3238, 17
__PRETTY_FUNCTION__.3238:
	.ascii	"string_hash_done\000"
	.ident	"GCC: (Debian 6.3.0-18+deb9u1) 6.3.0 20170516"
