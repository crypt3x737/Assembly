.data

str1: .asciz "%d" 
.align 2
str2: .asciz "Enter natural number n : \n" 
.align 2
str3: .asciz "The number is prime %d \n"
.align 2
str4: .asciz "The number of prime are %d \n"
.align 2


n: 	.word 0	 
i:      .word 1 
sum:	.word 0

.text
		

isPrime:
		stmfd	sp!, {lr}
		mov	r4, r0
		mov	r1, #2
		mov	r5, #2
		mov	r10, #0

		
loop:		
		mov	r0, r4
		bl 	divide
		cmp	r1, #0
		addeq	r10, r10, #1
		cmp	r5, r4
		addle	r5, r5, #1
		movle	r1,r5
		cmp	r5, r4
		bgt	done
		b	loop
done:
		ldmfd sp!, {lr} 
		mov pc, lr 
	

		.global divide

divide:		cmp	r1, #0
		beq	quitdivide
		mov	r2, r1		
		mov	r1, r0
		mov	r0, #0
		mov	r3, #1

divstrt:	cmp	r2, #0
		blt	divloop
		cmp	r2, r1
		lslls	r2, r2, #1
		lslls	r3, r3, #1
		bls	divstrt

divloop:	cmp	r1, r2
		subge	r1, r1, r2
		addge	r0, r0, r3
		lsr	r2, r2, #1
		lsrs	r3, r3, #1
		bcc	divloop

quitdivide:
		mov	pc, lr
	


 

.globl main

main:
	stmfd	sp!, {lr}
	ldr	r0, =str2
	bl	printf
	ldr	r0, =str1
	ldr	r1, =n
  	bl	scanf
	ldr	r0, =n
	ldr	r0, [r0]
	mov	r4, r0
	mov	r8, #0

loop1:
		cmp	r4, #2
		blt	exit
		bl	isPrime		
		cmp	r10, #1
		addeq	r8, r8, #1
		ldreq	r0, =str3
		moveq	r1, r4
		bleq	printf
		cmp	r4, #1
		subgt	r4, r4, #1
		movgt	r0, r4
		b	loop1

exit:	ldr	r0, =str4
	mov	r1, r8
	bl	printf
	ldmfd sp!, {lr} 
	mov r0, #0 
	mov pc, lr 
	.end




