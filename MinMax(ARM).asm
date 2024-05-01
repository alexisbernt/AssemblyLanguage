;Min Max ARM
.code
ldr r0, =prompt01
ldr r0, =nip
swi 5
swi 2
mov r5, r0
ldr r0, =nip2
swi 5
swi 2
mov r6, r0
ldr r0, =nip3
swi 5
swi 2
mov r7, r0
bl loadRegs
bl sortNums
bl printNums
swi 6
loadRegs:
mov r0, r5
mov r1, r6
mov r2, r7
bx lr
sortNums:
cmp r0, r1
blt swap1
bge step2
swap1:
push {lr+r0}
mov r0, r1
step2:
cmp r0, r2
blt swap2
bge step3
swap2:
push {lr+r0}
mov r0, r2
step3:
cmp r1, r2
blt swap3
bge endLabel
swap3:
push {lr+r1}
mov r1, r2
endLabel:
bx lr
printNums:
swi 1
mov r1, r0
swi 1
mov r2, r0
swi 1
bx lr
.data
prompto1: .asciiz "Welcome to the program. Whoop whoop!!"
nip: .asciiz "Enter the number of your choosing (1) "
nip2: .asciiz "Enter the number of your choosing (2) "
nip3: .asciiz "Enter the number of your choosing (3) "
