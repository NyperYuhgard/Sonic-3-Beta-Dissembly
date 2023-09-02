;===============================================================================
; Objeto 0x38 - Escudo clássico
; ->>>
;===============================================================================    
; Offset_0x00F972:
                moveq   #$00, D0
                move.b  Obj_Routine(A0), D0                              ; $0005
                move.w  Offset_0x00F980(PC, D0), D1
                jmp     Offset_0x00F980(PC, D1)
;-------------------------------------------------------------------------------
Offset_0x00F980:
                dc.w    Offset_0x00F984-Offset_0x00F980
                dc.w    Offset_0x00F9A8-Offset_0x00F980      
;-------------------------------------------------------------------------------
Offset_0x00F984:
                addq.b  #$02, Obj_Routine(A0)                            ; $0005
                move.l  #Classic_Shield_Mappings, Obj_Map(A0) ; Offset_0x00FC66, $000C
                move.b  #$04, Obj_Flags(A0)                              ; $0004
                move.w  #$0080, Obj_Priority(A0)                         ; $0008
                move.b  #$18, Obj_Width(A0)                              ; $0007
                move.w  #$079C, Obj_Art_VRAM(A0)                         ; $000A
;-------------------------------------------------------------------------------  
Offset_0x00F9A8:
                move.w  Obj_Player_Last(A0), A2                          ; $0042
                btst    #$01, Obj_Player_Status(A2)                      ; $002F
                bne.s   Offset_0x00F9F2
                btst    #$00, Obj_Player_Status(A2)                      ; $002F
                beq.s   Offset_0x00F9F4
                move.w  Obj_X(A2), Obj_X(A0)                      ; $0010, $0010
                move.w  Obj_Y(A2), Obj_Y(A0)                      ; $0014, $0014
                move.b  Obj_Status(A2), Obj_Status(A0)            ; $002A, $002A
                andi.w  #$7FFF, Obj_Art_VRAM(A0)                         ; $000A
                tst.w   Obj_Art_VRAM(A2)                                 ; $000A
                bpl.s   Offset_0x00F9E0
                ori.w   #$8000, Obj_Art_VRAM(A0)                         ; $000A
Offset_0x00F9E0:
                lea     (Classic_Shield_Animate_Data), A1      ; Offset_0x00FC58
                jsr     (AnimateSprite)                        ; Offset_0x01115E
                jmp     (DisplaySprite)                        ; Offset_0x011148
Offset_0x00F9F2:
                rts
Offset_0x00F9F4:
                jmp     (DeleteObject)                         ; Offset_0x011138
;===============================================================================
; Objeto 0x38 - Escudo clássico
; <<<-
;===============================================================================                                                      