.data

str1: .asciz "Enter text(ctrl-D to end): \n" 
.align 2
str2: .asciz "The checksum is %08d \n" 
.align 2
str3: .asciz "The checksum is %08d \n" 
.align 2

buffer: .skip 4096	 
i:      .word 0 
sum:	.word 0

.text
 
checksum:	
		stmfd	sp!, {lr}
			
		ldr	r0, =str1
		bl	printf
		mov 	r5, #0
		mov	r6, #0
		ldr	r4, =buffer
       		
loop:		bl	getchar
		cmp	r0, #-1
		beq	done	
  		cmp 	r5, #4096
		bgt	done
		add	r6, r0		
		strb	r0,[r4, r5]
		add	r5, r5, #1
		b	loop
	
done:		mov	r0, r5

		ldmfd 	sp!, {lr}
		mov	r0, #0 
		mov	pc, lr 


.globl main

main:
	stmfd	sp!, {lr}
	bl	checksum
	ldr	r0, =str2	
	mov	r1, r6
	bl	printf
	ldr	r0, =str3	
	mov	r1, r6
	bl	printf

	ldmfd sp!, {lr} 
	mov r0, #0 
	mov pc, lr 
	.end




