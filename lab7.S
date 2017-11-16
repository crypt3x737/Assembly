	.data
lower:	.word	0
upper:	.word	0
rows:	.word	0
x:	.word	0
msg:	.asciz	"This program will create a table for \
f(x) = ( 5x^3 - 3x^2 + 2x + 20 ) / 11\n"
	.align	2
msgl:	.asciz	"Enter the lower limit of x: "
	.align	2	
msgu:	.asciz	"Enter the upper limit of x: "
	.align	2
nrows:	.asciz	"Enter the number of rows for the table: "
	.align	2
lowstr:	.asciz	""
	.align	2
upstr:	.asciz	""
	.align	2
nrow:	.asciz	"%d"
	.align	2
tableh:	.asciz	"     x    |     f(x)   \n --------------------- \n"
	.align	2
tablec:	.asciz	"          |          "
	.align	2
newl:	.asciz "\n"
	.align	2

	.text	
	.global	fofx
fofx:	stmfd	sp!, {lr}
	
	ldmfd	sp!, {lr}

	.global main
main:	stmfd	sp!, {lr}
	
	@ print msg
	ldr	r0, =msg
	bl	printf

	@ print statement to get lower limit and grab as a string
	ldr	r0, =msgl
	bl	printf
	ldr	r0, =lowstr
	bl	gets

	@ print statement to get upper limit and grab as a string
	ldr	r0, =msgu
	bl	printf
	ldr	r0, =upstr
	bl	gets
	
	@ print statement asking for number of rows
	ldr	r0, =nrows
	bl	printf

	@ store the value for the numbers of rows in rows
	ldr	r0, =nrow
	ldr	r1, =rows
	bl	scanf

	@ convert the lower limit to a bit pattern
	ldr	r0, =lowstr
	mov	r1, #16
	bl	strtoSfixed
	ldr	r1, =lower
	str	r0, [r1]
	
	ldr	r10, =lower
	ldr	r10, [r10] @ r10 keeps the value of the lower limit

	@ convert the upper limit to a bit battern
	ldr	r0, =upstr
	mov	r1, #16
	bl	strtoSfixed
	ldr	r1, =upper
	str	r0, [r1]

	ldr	r9, =upper
	ldr	r9, [r9] @ r9 keeps the value of the upper limit
	
	@ calculate increment
	ldr	r1, =upper
	ldr	r1, [r1]
	ldr	r2, =lower
	ldr	r2, [r2]
	sub	r0, r1, r2
	
	ldr	r1, =x
	str	r0, [r1]	

	ldr	r0, =x
	ldr	r0, [r0]
	ldr	r1, =rows
	ldr	r1, [r1]
	bl	sdiv32
	ldr	r2, =x
	str	r0, [r2]		
	
	@ print table header
	ldr	r0, =tableh
	bl	printf

	ldr	r8, =rows @ r8 holds the number of rows
	ldr	r8, [r8]

	ldr	r5, =x
	ldr	r5, [r5]


	@ use r7 as a counter for the number of rows, add 1 each time through the loop
	mov	r7, #0
	@ start of the loop, use r5 as the increment value (x), until r8 (number of rows) i        @ s reached
loop:	cmp	r8, r7
	beq	quit
	mov	r0, r10
	mov	r1, #16
	bl	printS
	ldr	r0, =tablec
	bl	printf
	ldr	r0, =newl
	bl	printf

@Calculating 5*x^3
	smull	r0,r6,r10,r10
	lsl	r6,r6,#16
	lsr	r0,r0,#16
	orr	r0,r6,r0
	smull	r0,r6,r0,r10
	lsl	r6,r6,#16
	lsr	r0,r0,#16
	orr	r0,r6,r0
	mov	r4, r0
	add     r0, r0, r4, lsl #2
	mov	r6,r0

@Calculating 3*x^2
	smull	r0,r2,r10,r10
	lsl	r2,r2,#16
	lsr	r0,r0,#16
	orr	r0,r2,r0
	mov	r4, r0
	add     r0, r0, r4, lsl #1
	mov	r9,r0
@Calculating 2x
	add	r11,r10,r10

@Calculating the numerator
	add	r6,r6,r11
	mov	r1,#20
	add	r6,r6,r1,lsl #16
	sub	r6,r6,r9

@Calculating the f(x)
	mov 	r0,r6
	mov	r1, #11
	bl 	sdiv32
	mov	r6,r0
	mov	r0,r6
	mov	r1,#16
	bl	printS
	

	add	r10, r10, r5 @ add the increment to the lower limit each time 
	add	r7, r7, #1 @ add 1 to the loop counter
	b	loop

quit:	ldmfd	sp!, {lr}
	mov	r0, #0
	mov	pc, lr
	.end
