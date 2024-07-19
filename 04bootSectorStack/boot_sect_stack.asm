mov ah, 0x0e ; specifies the TTY (teletype) mode for the BIOS interrupt

; ; specifies the TTY (teletype) mode for the BIOS interrupt.
mov bp, 0x8000 ;address far from 0x7c00 so we don't get overwritten

; specifies the TTY (teletype) mode for the BIOS interrupt.
mov sp, bp ; if the stack is empty then sp points to bp

; specifies the TTY (teletype) mode for the BIOS interrupt.

push 'A'
push 'B'
push 'C'

;to show the stack grows downwards
mov al, [0x7ffe] ; 0x8000 - 2
int 0x10 ; prints A 

; however don't try to access [0x8000] now, because it won't work
; you can only access the stack top so, at this point, only 0x7ffe
mov al, [0x8000]
int 0x10


; recover our characters using the standard procedure: 'pop'
; We can only pop full words so we need an auxillary register to manipulate
pop bx
mov al, bl
int 0x10 ;prints C

pop bx
mov al, bl
int 0x10 ;prints B

pop bx
mov al, bl
int 0x10 ;prints A

; data that has been pop'd form the stack is grabage now
mov al, [0x8000]
int 0x10

jmp $
times 510-($-$$) db 0
dw 0xaa55

; TO RUN
; nasm -f bin boot_sect_stack.asm -o boot_sect_stack.bin
; qemu-system-x86_64 boot_sect_stack.bin