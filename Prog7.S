	.data
lower:	.word	0
upper:	.word	0
rows:	.word	0




str1:	.asciz	"The program will be creating at table for f(x)=(5x^3-3x^2+2x+20)/11  \n" 
	.align	2
str2:	.asciz	"Enter the lower limit for number x : \n"
	.align	2
input:	.asciz	"%s"
	.align	2
str3:	.asciz	"Enter the upper limit for number x : \n"
	.align	2
str4:	.asciz	"Enter the number of rows : \n"
	.align	2
inp:	.asciz	"%d"
	.align	2
str5:	.asciz	"     x          f(x)   "
	.align	2
print:	.asciz "print %d \n"
	.align	2

	.text

	

udiv32:	cmp	r1,#0		@ if divisor == zero
	beq	quitudiv32	@   exit immediately
	mov     r2,r1           @ move divisor to r2
        mov     r1,r0           @ move dividend to r1
        mov     r0,#0           @ clear r0 to accumulate result
        mov     r3,#1           @ set "current" bit in r3
divstrt:cmp	r2,#0           @ WHILE ((msb of r2 != 1)
	blt	divloop
	cmp     r2,r1		@ && (r2 < r1))
        lslls   r2,r2,#1        @  shift dividend left
        lslls   r3,r3,#1        @  shift "current" bit left
        bls     divstrt		@ end WHILE
divloop:cmp     r1,r2           @ if dividend >= divisor
        subge   r1,r1,r2        @   subtract divisor from dividend
        addge   r0,r0,r3        @   set "current" bit in the result
        lsr	r2,r2,#1	@ shift dividend right
        lsrs    r3,r3,#1	@ Shift current bit right into carry
        bcc     divloop         @ If carry not clear, R3 has shifted
                                @ one bit past where it started, and we
                                @ are done.
quitudiv32:	
        mov     pc,lr


sdiv32:	stmfd	sp!,{r4,lr}
	@@ If dividend is negative
	cmp	r0,#0
	rsblt	r0,r0,#0	@ complement it
	movlt	r4,#1		@ and set sign bit for result
	movge	r4,#0		@ else clear sign bit for result
	@@ If divisor is negative
	cmp	r1,#0
	rsblt	r1,r1,#0	@ complement it
	eorlt	r4,#1		@ and complement sign bit for result

	bl 	udiv32

	@@ complement result if needed
	cmp	r4,#0
	rsbne	r0,r0,#0	@ complement it

	ldmfd	sp!,{r4,pc}

	.global main

main:	stmfd	sp!, {lr}
	
	ldr	r0,=str1
	bl	printf

	ldr 	r0,=str2
	bl	printf

	ldr 	r0,=input
	ldr	r1,=lower
	bl	scanf
	ldr	r1,=lower
	ldr	r1, [r1]
	mov	r5, r1

	ldr 	r0,=str3
	bl	printf
	ldr 	r0,=input
	ldr	r1,=upper
	bl	scanf
	ldr	r1,=upper
	ldr	r1, [r1]
	mov	r6,r1

	ldr 	r0,=str4
	bl	printf
	ldr	r0,=inp
	ldr	r1,=rows
	bl	scanf
	ldr	r1,=rows
	ldr	r1, [r1]
	mov	r7,r1
	

	ldr	r0,=print
	mov	r1, r5
	bl	printf

	



	ldmfd sp!, {lr} 
	mov	r0, #0
	mov	pc, lr
	.end
