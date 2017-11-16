           .data
str:       .asciz "Y u not easy?\n"
             

           



main:       stmfd sp!,{lr}
            ldr   r0, =str
            bl    printf
            mov   r0, #0
            ldmfd sp!,{lr}
            mov   pc, lr
