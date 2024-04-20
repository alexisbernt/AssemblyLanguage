%include "io.inc"

; #######################################################
; #                                                     #
; # Store your string literals in the data section      #
; # These variables cannot be changed at runtime        #
; #                                                     #
; #######################################################

segment .data 

firstPrompt db "Enter first number: " , 0 
firstPromptLen equ $ - firstPrompt

secondPrompt db "Enter second number: " , 0 
secondPromptLen equ $ - secondPrompt

thirdPrompt db "Enter third number: " , 0 
thirdPromptLen equ $ - thirdPrompt

maxPrompt db "The MAX value is: " , 0 
maxPromptLen equ $ - maxPrompt

minPrompt db "The MIN value is: " , 0 
minPromptLen equ $ - minPrompt

; #######################################################
; #                                                     #
; # Store your variables in the data section            #
; # These variables can be changed at runtime           #
; #                                                     #
; #######################################################

segment .bss 

input1 resb 32
input2 resb 32
input3 resb 32

MAX resb 32
MIN resb 32

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
		
; foo call three integers
;push 100
;push 200
;push 300
;add rsp, 3*8     

; Calling Read User Input Function
; push firstPrompt ... if push then pop 
push firstPrompt
push firstPromptLen
push input1
call readUserInput
add rsp, 3*8

; For inputs two and three
push secondPrompt
push secondPromptLen
push input2
call readUserInput
add rsp, 3*8

push thirdPrompt
push thirdPromptLen
push input3
call readUserInput
add rsp, 3*8

; Process to Sort Numbers
push qword [input1]
push qword [input2]
push qword [input3]
call sortNums
add rsp, 3*8

call printVars

; correct stack
;add rsp, 3*8	
	    ;***************CODE ENDS HERE*****************************
        
        mov	rax, 0           ; return back to C
       	pop	rbp               
        ret

; ------- demo -------
; entry and exit procedure 
foo:
    ; entry procedure 
    push rbp
    mov rbp, rsp
    ; We have a new stack frame! 

    ; call print_string
    ; mov rax, input1
    ; call to_int
    ; mov rbx, input1
    ; mov rbx, [rax]

    ; exit procedure 
    mov rsp, rbp
    pop rbp
    ret 

; -------- code starts here ------------

readUserInput:
    push rbp
    mov rbp, rsp

    mov rbx, [rbp+16] ; Storage address (move address to rax)
    mov rdx, [rbp+24] ; Length (move length to rdx)
    mov rax, [rbp+32] ; Prompt (move string to rbx)
    
    call print_string
    mov rax, [rbp+16]
    call read_input
    mov rax, [rbp+16]
    call to_int
    mov rbx, [rbp+16]
    mov [rbx], rax

    mov rsp, rbp
    pop rbp
    ret

sortNums:
    ; entry procedure 
    push rbp
    mov rbp, rsp

    mov rax, [rbp+16]
    mov rbx, [rbp+24]
    mov rcx, [rbp+32]

    ; sorting algorithm
    cmp rax, rbx
    jl swap1
    jmp pt2

swap1:
    push rax
    mov rax, rbx
    pop rbx
    jmp pt2

pt2:
    cmp rax, rcx
    jl swap2
    jmp pt3

swap2:
    push rax
    mov rax, rcx
    pop rcx
    jmp pt3

pt3:
    cmp rbx, rcx
    jl swap3
    jmp to_end

swap3:
    push rbx
    mov rbx, rcx
    pop rcx
    jmp to_end

to_end:
    mov [MAX], rax
    mov [MIN], rcx
    ; exit procedure 
    mov rsp, rbp
    pop rbp
    ret 


printVars:
    ; entry procedure 
    push rbp
    mov rbp, rsp

    mov rax, maxPrompt
    mov rdx, maxPromptLen
    call print_string
    mov rax, [MAX]
    call print_int

    mov rax, minPrompt
    mov rdx, minPromptLen
    call print_string
    mov rax, [MIN]
    call print_int

    ; exit procedure 
    mov rsp, rbp
    pop rbp
    ret 
    
