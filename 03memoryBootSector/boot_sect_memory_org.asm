; specifies the origin, or starting address, of the code. 
; ensures that all memory references within the code are correctly calculated relative to this address.
; without it, assembler would assume the code starts at address 0x0000, and any memory references would 
; be incorrect when the code is actually loaded at 0x7c00. This would lead to incorrect behavior, as the 
; code would be referencing the wrong memory locations.

; this is where the bootloader is stored
[org 0x7c00]
mov ah, 0x0e

; attempt 1
; Will fail again regardless of 'org' because we are still addressing the pointer
; and not the data it points to
mov al, "1"
int 0x10
mov al, the_secret
int 0x10

; ------------------- Cananocal way of doing the thing --------------------------
; attempt 2
; Having solved the memory offset problem with 'org', this is now the correct answer
mov al, "2"
int 0x10
mov al, [the_secret]
int 0x10

; attempt 3
; As you expected, we are adding 0x7c00 twice, so this is not going to work
mov al, "3"
int 0x10
mov bx, the_secret
add bx, 0x7c00
mov al, [bx]
int 0x10

; attempt 4
; This still works because there are no memory references to pointers, so
; the 'org' mode never applies. Directly addressing memory by counting bytes
; is always going to work, but it's inconvenient
mov al, "4"
int 0x10
mov al, [0x7c2d]
int 0x10


jmp $ ; infinite loop

the_secret:
    ; ASCII code 0x58 ('X') is stored just before the zero-padding.
    ; On this code that is at byte 0x2d (check it out using 'xxd file.bin')
    db "X"

; zero padding and magic bios number
times 510-($-$$) db 0
dw 0xaa55