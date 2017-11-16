	.data
penny:	.word	0
nickel:	.word	0
dime:	.word	0
quarter:.word	0
week:	.word	0
total:	.word	0
avg:	.word	0
yearly:	.word	0
str1:	.asciz	"Enter the number of pennies, nickels, dimes, and quarters\
 for week %d: " 
	.align	2
str2:	.asciz	"%d %d %d %d"
	.align	2
str3:	.asciz	"Over four weeks you have collected %d pennies, %d nickels,\
 %d dimes, and %d quarters.\n"
	.align	2
str4:	.asciz	"This comes to $%d.%d\n"
	.align	2
str5:	.asciz	"Your weekly average is $%d.%d\n"
	.align	2
str6:	.asciz	"Your estimated yearly savings is $%d.%d\n"
	.align	2

	.text
	.global main
main:	stmfd	sp!, {lr}
	mov	r5, #0
	mov	r6, #0
	mov	r7, #0
	mov	r8, #0
	mov	r10, #0
	mov	r11, #1
loop:	cmp	r11, #5
	beq	quit

	sub	sp, sp, #4
	ldr	r0, =str1
	mov	r1, r11
	bl	printf

	ldr	r0, =str2
	ldr	r1, =penny
	ldr	r2, =nickel
	ldr	r3, =dime
	ldr	r4, =quarter
	str	r4, [sp]	
	bl	scanf

	ldr	r1, =penny
	ldr	r1, [r1]
	add	r5, r5, r1
	
	ldr	r1, =nickel
	ldr	r2, [r1]
	add	r6, r6, r2
	
	ldr	r1, =dime
	ldr	r3, [r1]
	add	r7, r7, r3
	
	ldr	r1, =quarter
	ldr	r4, [r1]
	add	r8, r8, r4
	add	sp, sp, #4

	add	r11, r11, #1
	b	loop

quit:	mov	r0, r8
	stmfd	sp!, {r0}
	ldr	r0, =str3
	mov	r1, r5
	mov	r2, r6
	mov	r3, r7
	mov	r4, r8
	bl	printf
	sub	sp, sp, #4
	ldmfd	sp!, {r0}
	add	sp, sp, #4

	add	r10, r10, r5	@ pennies
	
	add	r0, r6, r6, lsl #2	@ nickels
	add	r10, r10, r0
	
	lsl	r0, r7, #1	@ dimes
	add	r0, r0, r0, lsl #2
	add	r10, r10, r0
	
	mov	r0, #0
	add	r0, r8, r8, lsl #1	@ quarters
	add	r0, r8, r0, lsl #3	
	add	r10, r10, r0	@ holds total number
	
	mov 	r0, #0	
	add	r0, r0, r10, lsl #2
	add	r0, r0, r10, lsl #3
	add	r0, r0, r10, lsl #5
	add	r0, r0, r10, lsl #6
	add	r0, r0, r10, lsl #7
	add	r0, r0, r10, lsl #8
	add	r0, r0, r10, lsl #12
	add	r0, r0, r10, lsl #14	
	lsr	r0, r0, #21
	mov 	r9, r0	@ r9 holds integer part of number	

	mov	r0, #0
	add	r0, r0, r9, lsl #2
	add	r0, r0, r9, lsl #5
	add	r0, r0, r9, lsl #6
	mov	r1, r0
	sub	r2, r10, r1 @ r2 holds cent portion
	mov	r1, r9
	
	ldr	r0, =str4
	bl	printf	@ print total dollars and cents
	
	mov	r0, #0
	add	r0, r0, r10, lsr #2
	mov	r4, r0

	mov	r0, #0
	add     r0, r0, r4, lsl #2
        add     r0, r0, r4, lsl #3
        add     r0, r0, r4, lsl #5
        add     r0, r0, r4, lsl #6
        add     r0, r0, r4, lsl #7
        add     r0, r0, r4, lsl #8
        add     r0, r0, r4, lsl #12
        add     r0, r0, r4, lsl #14    
        lsr     r0, r0, #21
        mov     r9, r0  @ r9 holds integer part of number

	mov     r0, #0
        add     r0, r0, r9, lsl #2
        add     r0, r0, r9, lsl #5
        add     r0, r0, r9, lsl #6
        mov     r1, r0
        sub     r2, r4, r1 @ r2 holds cent portion
        mov     r1, r9

	ldr	r0, =str5
	bl	printf
	
	mov 	r0, #0
	add	r0, r0, r10, lsl #0
	add	r0, r0, r10, lsl #2
	add	r0, r0, r10, lsl #3
	mov	r4, r0

	mov	r0, #0
	add	r0, r0, r4, lsl #2
	add	r0, r0, r4, lsl #3
	add	r0, r0, r4, lsl #5
	add	r0, r0, r4, lsl #6
	add	r0, r0, r4, lsl #7
	add	r0, r0, r4, lsl #8
	add	r0, r0, r4, lsl #12
	add	r0, r0, r4, lsl #14	
	lsr	r0, r0, #21
	mov 	r9, r0	@ r9 holds integer part of number	

	mov	r0, #0
	add	r0, r0, r9, lsl #2
	add	r0, r0, r9, lsl #5
	add	r0, r0, r9, lsl #6
	mov	r1, r0
	sub	r2, r4, r1 @ r2 holds cent portion
	mov	r1, r9
	
	ldr	r0, =str4
	bl	printf	@ print total dollars and cents


	mov	r0, #0
	mov	pc, lr
	.end
