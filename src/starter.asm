.linecont       +               ; Allow line continuations
.feature        c_comments

.segment "IMG"
.incbin "../img/HelloWorld.chr"

.include "./def/header.asm"
.include "./lib/utils.asm"
.include "./lib/gamepad.asm"
.include "./def/ppu.asm"
.include "./def/palette.asm"

.include "./vectors/irq.asm"              ; not currently using irq code, but it must be defined
.include "./vectors/reset.asm"            ; code and macros related to pressing the reset button
.include "./vectors/nmi.asm"


game_loop:
    lda nmi_ready
    bne game_loop

    jsr set_gamepad

    set nmi_ready, #1

    dec scroll_y
    lda scroll_y
    
    cmp #15
    bne not_15
        set scroll_y, #0
    not_15:

    jmp game_loop
