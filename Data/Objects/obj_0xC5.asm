;===============================================================================
; Objeto 0xC5 - Monitores ocultos que aparecem ao tocar o painel de fim de fase
; ->>>          
;===============================================================================
; Offset_0x04178A:
                lea     Hidden_Monitors_Setup_Data(PC), A1     ; Offset_0x041806
                jsr     Object_Settings(PC)                    ; Offset_0x041D72
                move.l  #Offset_0x0417B2, (A0)
                move.b  #$0F, Obj_Height_2(A0)                           ; $001E
                move.b  #$0F, Obj_Width_2(A0)                            ; $001F
                move.b  #$46, Obj_Col_Flags(A0)                          ; $0028
                move.b  Obj_Subtype(A0), Obj_Ani_Number(A0)       ; $002C, $0020
                rts
;-------------------------------------------------------------------------------
Offset_0x0417B2:
                move.w  (Obj_End_Panel_Mem_Address).w, A1            ; $FFFFFAA6
                cmpi.l  #Obj_End_Panel, (A1)                   ; Offset_0x041812
                bne.s   Offset_0x0417FC
                btst    #$00, Obj_Control_Var_08(A1)                     ; $0038
                beq.s   Offset_0x0417FC
                move.w  Obj_X(A0), D0                                    ; $0010
                move.w  Obj_X(A1), D1                                    ; $0010
                lea     Offset_0x041802(PC), A2
                add.w   (A2)+, D0
                cmp.w   D0, D1
                bcs.s   Offset_0x0417FC
                add.w   (A2)+, D0
                cmp.w   D0, D1
                bcc.s   Offset_0x0417FC
                bclr    #$00, Obj_Control_Var_08(A1)                     ; $0038
                move.l  #Obj_0x01_Monitors, (A0)               ; Offset_0x012F44
                move.b  #$02, Obj_Routine(A0)                            ; $0005
                move.b  #$04, Obj_Control_Var_0C(A0)                     ; $003C
                move.w  #$FC00, Obj_Speed_Y(A0)                          ; $001A
Offset_0x0417FC:
                jmp     (MarkObjGone)                          ; Offset_0x011AF2
;-------------------------------------------------------------------------------
Offset_0x041802:
                dc.w    $FFF2, $001C
;-------------------------------------------------------------------------------
Hidden_Monitors_Setup_Data:                                    ; Offset_0x041806
                dc.l    Monitors_Mappings                      ; Offset_0x0134A2
                dc.w    $04C4, $0180
                dc.b    $0E, $10, $00, $00                                                                                   
;===============================================================================
; Objeto 0xC5 - Monitores ocultos que aparecem ao tocar o painel de fim de fase
; <<<- 
;===============================================================================  