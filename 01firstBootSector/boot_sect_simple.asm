; A simple boot sector program that loops forever

; Start of the infinite loop
loop:
    jmp loop ; Jump to the start of the loop, creating an infinite loop

; Fill the rest of the boot sector (up to byte 510) with zeros
times 510-($-$$) db 0

; Write the boot signature (0xaa55) at the end of the boot sector (bytes 511 and 512)
; This signature is required for the BIOS to recognize it as a bootable disk
dw 0xaa55


; ----------------------------- NOTES -----------------------------

; To compile and run this boot sector program, you can use the following commands:
; nasm -f bin boot_sect_simple.asm -o boot_sect_simple.bin

; To run the compiled binary file (boot_sect_simple.bin), you can use the following command:
; qemu-system-x86_64 boot_sect_simple.bin

