;-------------------------------------------------------------------------------
; Escudo a prova de choque e atrai os anéis do Sonic / Miles / Knuckles
; ->>>
;------------------------------------------------------------------------------- 
; Offset_0x01046C:
                move.l  #Lightning_Shield_Mappings, Obj_Map(A0) ; Offset_0x01076C, $000C
                move.l  #Lightning_Shield_Dyn_Script, Obj_Control_Var_0C(A0) ; Offset_0x010822, $003C
                move.l  #Art_Lightning_Shield, Obj_Control_Var_08(A0) ; Offset_0x083E40, $0038
                move.b  #$04, Obj_Flags(A0)                              ; $0004
                move.w  #$0080, Obj_Priority(A0)                         ; $0008
                move.b  #$18, Obj_Width(A0)                              ; $0007
                move.b  #$18, Obj_Height(A0)                             ; $0006
                move.w  #$079C, Obj_Art_VRAM(A0)                         ; $000A
                move.w  #$F380, Obj_Control_Var_10(A0)                   ; $0040
                btst    #$07, (Obj_Player_One+Obj_Art_VRAM).w        ; $FFFFB00A
                beq.s   Offset_0x0104B6
                bset    #$07, Obj_Art_VRAM(A0)                           ; $000A
Offset_0x0104B6:
                move.l  #Offset_0x0104BC, (A0)
Offset_0x0104BC:                
                move.w  Obj_Player_Last(A0), A2                          ; $0042
                btst    #Invincibility_Type, Obj_Player_Status(A2)  ; $01, $002F
                bne.s   Offset_0x01050A
                btst    #Classic_Type, Obj_Player_Status(A2)        ; $00, $002F
                beq.s   Offset_0x01050C
                move.w  Obj_X(A2), Obj_X(A0)                      ; $0010, $0010
                move.w  Obj_Y(A2), Obj_Y(A0)                      ; $0014, $0014
                move.b  Obj_Status(A2), Obj_Status(A0)            ; $002A, $002A
                andi.w  #$7FFF, Obj_Art_VRAM(A0)                         ; $000A
                tst.w   Obj_Art_VRAM(A2)                                 ; $000A
                bpl.s   Offset_0x0104F4
                ori.w   #$8000, Obj_Art_VRAM(A0)                         ; $000A
Offset_0x0104F4:
                lea     (Lightning_Shield_Animate_Data), A1    ; Offset_0x010618
                jsr     (AnimateSprite)                        ; Offset_0x01115E
                bsr     Load_Shield_Dynamic_PLC                ; Offset_0x0105B8
                jmp     (DisplaySprite)                        ; Offset_0x011148
Offset_0x01050A:
                rts
Offset_0x01050C:
                jmp     (DeleteObject)                         ; Offset_0x011138                                                            
;-------------------------------------------------------------------------------
; Escudo a prova de choque e atrai os anéis do Sonic / Miles / Knuckles
; <<<-
;-------------------------------------------------------------------------------