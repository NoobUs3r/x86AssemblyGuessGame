.model small

.stack 100h
.data
    message db 'Guess a number from 0 to 9!', 13, 10, '$'
    incorrect db 13, 10, 'Try again!', 13, 10, '$'
    correct db 13, 10, 'Correct!$'
.code
    START:
	; Message
	mov ax, @data
	mov ds, ax
	mov ah, 09h
	lea dx, message
	int 21h

	; Generate random number
	mov ah, 00h ; Interrupts to get system time
	int 1Ah ; CX:DX now hold number of clock ticks since midnight

	mov ax, dx
	xor dx, dx
	mov cx, 10
	div cx ; DX contains remainder of the division (0 to 9)

	mov bl, dl
	add bl, '0' ; Convert to ASCII

	INPT:
	    mov ax, @data
	    mov ds, ax
	    mov ah, 1
	    int 21h

	    ; Exit if 'q'
	    mov bh, 71h
	    cmp al, bh
	    je EXIT

	    ; Compare values
	    cmp al, bl
	    jne NO
	    jmp YES

	NO:
	    mov ax, @data
	    mov ds, ax
	    mov ah, 09h
	    lea dx, incorrect
	    int 21h
	    jmp INPT

	YES:
	    mov ax, @data
	    mov ds, ax
	    mov ah, 09h
	    lea dx, correct
	    int 21h

	EXIT:
	    mov ah, 4Ch
	    int 21h
end START
