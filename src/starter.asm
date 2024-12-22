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

    lda gamepad_press
    and PRESS_UP
    beq up_press
        inc scroll_y
        inc scroll_y
    up_press:

    lda gamepad_press
    and PRESS_DOWN
    beq down_press
        dec scroll_y
        dec scroll_y
    down_press:
  
    lda gamepad_press
    and PRESS_LEFT
    beq left_press
        dec scroll_x
        dec scroll_x
    left_press:

    lda gamepad_press
    and PRESS_RIGHT
    beq right_press
        inc scroll_x
        inc scroll_x
    right_press:
    
    /*
    lda scroll_y  ; Load scroll_y into accumulator
    cmp #16  ; Compare accumulator to #240
    bne not_16 ; if the cmp result is "not equal" go to next line, else: run not_240
        set scroll_y, #0
    not_16:
        set $0300, scroll_y
    */
    
    jsr game_loop
