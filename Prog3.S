.data
str1: .asciz "%d" @ Format string for reading an int with scanf
.align 2
str2: .asciz "The greatest number is %d\n" @ Format string for printf
.align 2
str3: .asciz "The smallest number is %d\n" @ Format string for printf
.align 2
str4: .asciz "The positive numbers are = %d\n" @ Format string for printf
.align 2
str5: .asciz "The n negative numbers are = %d\n" @ Format string for printf
.align 2
a: .word 0 @ A place to store an integer
b: .word 0 @ A place to store an integer
c: .word 0 @ A place to store an integer

.text
.globl main @ This is a comment

main: stmfd sp!, {lr} /* push lr onto stack */

@ scanf("%d\0",&a)
ldr r0, =str1 /* load address of format string */
ldr r1, =a /* load address of int variable */
bl scanf /* call scanf("%d\0",&a) */

@ scanf("%d\0",&b)
ldr r0, =str1 /* load address of format string */
ldr r1, =b /* load address of int variable */
bl scanf /* call scanf("%d\0",&b) */

@ scanf("%d\0",&c)
ldr r0, =str1               /* load address of format string */
ldr r1, =c                  /* load address of int variable */
bl scanf                          /* call scanf("%d\0",&c) */


ldr r1, =a/* load address of int variable */
ldr r1, [r1] /* load int variable */

ldr r2, =b/* load address of int variable */
ldr r2, [r2] /* load int variable */

ldr r3, =c/* load address of int variable */
ldr r3, [r3] /* load int variable */

mov r4, r1
mov r5, r1

cmp r4, r2
movle r4, r2

cmp r5,r2
movge r5, r2

cmp r4, r3
movle r4, r3

cmp r5, r3
movge r5, r3

mov r6, #0
cmp r1, #00
addlt r6, r6, #1
cmp r2, #00
addlt r6, r6, #1
cmp r3, #00
addlt r6, r6, #1


mov r7, #0
cmp r1, #00
addge r7, r7, #1
cmp r2, #00
addge r7, r7, #1
cmp r3, #00
addge r7, r7, #1


ldr r0, =str2
mov r1, r4
bl printf /* call printf("You entered %d\n",n) */
ldr r0, =str3
mov r1, r5 
bl printf
ldr r0, =str4
mov r1, r7
bl printf /* call printf("You entered %d\n",n) */
ldr r0, =str5
mov r1, r6 
bl printf


ldmfd sp!, {lr} /* pop lr from stack */
mov r0, #0 /* load return value */
mov pc, lr /* return from main */
.end

