%include "io.inc"

; #######################################################
; #                                                     #
; # Store your string literals in the data section      #
; # These variables cannot be changed at runtime        #
; #                                                     #
; #######################################################

segment .data 

; task 1

prompt1 db "Enter Four Integer values: ", 0
prompt1Len equ $ - prompt1 

intOne db "Integer Value One: ", 0
int1Len equ $ - intOne

intTwo db "Integer Value Two: ", 0
int2Len equ $ - intTwo

intThree db "Integer Value Three: ", 0 
int3Len equ $ - intThree

intFour db "Integer Value Four: ", 0
int4Len equ $ - intFour

int1to3 db "Enter a valid integer between 1 and 3: ", 0
int1to3Len equ $ - int1to3

sum_prompt db "The sum of all the numbers is: ", 0 
sum_promptLen equ $ - sum_prompt

product_prompt db "The product of all the numbers is: ", 0 
product_promptLen equ $ - product_prompt

difference_prompt db "The difference of all the numbers is: ", 0 
difference_promptLen equ $ - difference_prompt

error_message db "Error. ", 0
error_messageLen equ $ - error_message

finish db "Program Finished", 0
finishLen equ $ - finish

; #######################################################
; #                                                     #
; # Store your variables in the data section            #
; # These variables can be changed at runtime           #
; #                                                     #
; #######################################################

segment .bss 

; task 1

ui1 resb 32

ui2 resb 32

ui3 resb 32

ui4 resb 32

ui1to3 resb 32


; #######################################################
; #                                                     #
; # Indicate the main method                            #
; #                                                     #
; #######################################################

segment .text
        global  asm_main



; #######################################################
; #                                                     #
; # Do your work here!                                  #
; #                                                     #
; #######################################################

asm_main:
        push	rbp	         ; setup routine
	    
        ;***************CODE STARTS HERE***************************
; task 3

mov rax, prompt1
mov rdx, prompt1Len
call print_string
call print_nl

;moving the prompt
mov rax, intOne
mov rdx, int1Len
call print_string

; saving the user input
mov rax, ui1
call read_input	

; converting a char to an int
mov rax, ui1
call to_int
mov [ui1], rax


mov rax, intTwo
mov rdx, int2Len
call print_string
mov rax, ui2
call read_input
mov rax, ui2
call to_int
mov [ui2], rax

mov rax, intThree
mov rdx, int3Len
call print_string
mov rax, ui3
call read_input
mov rax, ui3
call to_int
mov [ui3], rax

mov rax, intFour
mov rdx, int4Len
call print_string
mov rax, ui4
call read_input
mov rax, ui4
call to_int
mov [ui4], rax
        
; task 4

mov rax, int1to3
mov rdx, int1to3Len
call print_string
mov rax, ui1to3
call read_input
mov rax, ui1to3
call to_int
mov [ui1to3], rax

; task 11
mov rax, [ui1to3]
cmp rax, 1
je sum_proc
cmp rax, 2
je product_proc
cmp rax, 3
je difference_proc
call error_mssg
; jmp done
call print
call end

end:
; call end of program prompt
mov rax, finish
mov rdx, finishLen
call print_string
call print_nl





	    ;***************CODE ENDS HERE*****************************
        
        mov	rax, 0           ; return back to C
       	pop	rbp               
        ret

; task 5 
set_registers:
    mov rax, [ui1]
    mov rbx, [ui2]
    mov rcx, [ui3]
    mov rdx, [ui4]
; can check the registers using GBD
    ret

; task 6 and 7
print:
    call print_int
    call done ; call done as fallthrough
    ret

; task 8
sum_proc:
    mov rax, sum_prompt
    mov rdx, sum_promptLen
    call print_string
    call set_registers
    mov rax, [ui1]
    add rax, rbx 
    add rax, rcx
    add rax, rdx
    call print_int
    jmp end

; task 9
product_proc:
    mov rax, product_prompt
    mov rdx, product_promptLen
    call print_string
    call set_registers
    mov rax, [ui1]
    imul rax, rbx 
    imul rax, rcx
    imul rax, rdx
    call print_int
    jmp end

; task 10
difference_proc:
    mov rax, difference_prompt
    mov rdx, difference_promptLen
    call print_string
    call set_registers
    mov rax, [ui1]
    sub rax, rbx 
    sub rax, rcx
    sub rax, rdx
    call print_int
    jmp end

error_mssg:
    ; if not 1,2,3 then error
    mov rax, error_message
    mov rdx, error_messageLen
    call print_string
    ret

done:
    mov rax, finish
    mov rdx, finishLen
    call print_string
    ret


