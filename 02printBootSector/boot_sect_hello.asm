; (ah) the high byte of ax
; used to specify the function number for the BIOS interrupt.
mov ah, 0x0e ; specifies the TTY (teletype) mode for the BIOS interrupt.

; (al) the low byte of ax
; used to hold the ASCII value of the character to be printed.
mov al, 'H'

; When int 0x10 is called with ah set to 0x0e, it performs 
; the "Teletype output" function, which prints the character 
; in al to the screen and advances the cursor.
int 0x10
mov al, 'e'
int 0x10
mov al, 'l'
int 0x10
int 0x10 ; 'l' is still on al, remember?
mov al, 'o'
int 0x10

jmp $ ; jump to current address = infinite loop

; padding and magic number
times 510 - ($-$$) db 0
dw 0xaa55 


; What does this do?
; Simply prints hello to the screen
; to run
; qemu-system-x86_64 boot_sect_hello.bin