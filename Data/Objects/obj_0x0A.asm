;===============================================================================
; Objeto 0x0A - Corda que o jogador agarra e desliza na Angel Island
; ->>>
;===============================================================================      
; Offset_0x013F66:
                move.l  #AIz_Zipline_Peg_Mappings, Obj_Map(A0) ; Offset_0x013F92, $000C
                move.w  #$0380, Obj_Priority(A0)                         ; $0008
                move.b  #$20, Obj_Width(A0)                              ; $0007
                move.b  #$04, Obj_Flags(A0)                              ; $0004
                move.w  #$4324, Obj_Art_VRAM(A0)                         ; $000A
                move.l  #Offset_0x013F8C, (A0)
Offset_0x013F8C:                
                jmp     (MarkObjGone)                          ; Offset_0x011AF2
;-------------------------------------------------------------------------------
AIz_Zipline_Peg_Mappings:                                      ; Offset_0x013F92
                dc.w    Offset_0x013F94-AIz_Zipline_Peg_Mappings
Offset_0x013F94:
                dc.w    $0003
                dc.w    $F40C, $0000, $FFE0
                dc.w    $FC04, $0004, $FFF8
                dc.w    $F40A, $0006, $0008                                                       
;===============================================================================
; Objeto 0x0A - Corda que o jogador agarra e desliza na Angel Island
; <<<-
;===============================================================================  