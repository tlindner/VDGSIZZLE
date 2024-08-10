; VDG Extrasizzler
; Go thru all 8 bits of VDG modes and display
; them with a standard bit pattern
;
; tim lindner
; August 2024

POLCAT equ $a000

    org $6000
bits fcb 0
toggle fcb 0
start
    clr $71 ; force cold start on reset
; Draw 6K standard pattern starting at $e00
    ldx #$e00
    ldd #0
loop
    std ,x++
    stb ,x+
    inca
    cmpx #$e00+(1024*6)
    bne loop

; view menu
view_menu
    clr toggle
    jsr switch_to_menu_view
; check keyboard
menu_loop
    jsr [POLCAT]
    beq menu_loop
    cmpa #'G
    beq sub_go
    cmpa #'T
    beq sub_toggle
    cmpa #'8
    ble sub_number
    bra menu_loop

sub_number
    cmpa #'1
    bge continue_number
    bra menu_loop
continue_number
    suba #'1
    ; should have the bit position to flip
    ; in A
    ldb #$80
number_loop
    deca
    bmi found_mask
    lsrb
    bra number_loop
found_mask
    eorb bits
    stb bits
    bsr write_bits
; check view
    tst toggle
    beq menu_loop
    bsr switch_to_display_view
    bra menu_loop
    
sub_go
    jsr go_view_all
    jmp view_menu

sub_toggle
    jsr view_toggle
    jmp menu_loop

view_toggle
    sync
    com toggle
    beq switch_to_menu_view
    ; change to display
    bra switch_to_display_view

; Display bit description
switch_to_menu_view
info_display
    ; set display address to $400
    sta $ffc6
    sta $ffca
    ; Set display mode to SG4
    sta $ffc0
    sta $ffc2
    sta $ffc4
    lda #$0
    sta $ff22
write_bits
    ; Write bits to text screen
    lda bits
    ldb #8
    pshs a,b
    lda #'1
    ldb #'0
    ldx #1120
info_loop
    lsl 0,s
    bcc write0
write1
    sta ,x
    bra written
write0
    stb ,x
written
    leax 32,x
    dec 1,s
    bne info_loop
    puls a,b,pc

switch_to_display_view
; Update SAM
    lda bits
do_v2
    lsla
    bcc v2c
v2s
    sta $ffc5
    bra do_v1
v2c
    sta $ffc4
do_v1    
    lsla
    bcc v1c
v1s
    sta $ffc3
    bra do_v0
v1c
    sta $ffc2
do_v0
    lsla
    bcc v0c
v0s
    sta $ffc1
    bra do_vdg
v0c
    sta $ffc0
; update VDG
do_vdg
    sta $ff22
; Switch display address to $e00    
    sta $ffc7
    sta $ffcb
    rts

go_view_all
    clr toggle
    com toggle
next_view
    com toggle
    bsr switch_to_menu_view   
; wait four video frames
    sync
    nop
    sync
    nop
    sync
    nop
    sync
    nop
    sync
    nop
    sync
    nop
    sync
    nop
    sync
    nop
    sync
    nop
    sync
    nop
    sync
    nop
    sync
    nop
    com toggle
    bsr switch_to_display_view
; wait four video frames
    sync
    nop
    sync
    nop
    sync
    nop
    sync
    nop
    sync
    nop
    sync
    nop
    sync
    nop
    sync
    nop
    sync
    nop
    sync
    nop
    sync
    nop
    sync
    nop
; check for key press
    jsr [POLCAT]
    bne finish
; incement same/vdg bits
    inc bits
    bne next_view
finish
    rts

    end start