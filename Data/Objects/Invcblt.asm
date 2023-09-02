;===============================================================================
; Invencibilidade do Sonic / Miles / Knuckles
; ->>>     
;===============================================================================                   
; Offset_0x00F9FA:
                moveq   #$00, D0
                move.b  Obj_Routine(A0), D0                              ; $0005
                move.w  Offset_0x00FA08(PC, D0), D1
                jmp     Offset_0x00FA08(PC, D1)   
;-------------------------------------------------------------------------------
Offset_0x00FA08:
                dc.w    Offset_0x00FA20-Offset_0x00FA08
                dc.w    Offset_0x00FA86-Offset_0x00FA08
                dc.w    Offset_0x00FAFE-Offset_0x00FA08  
;-------------------------------------------------------------------------------
Offset_0x00FA0E:
                dc.l    Offset_0x00FC11
                dc.w    $000B
                dc.l    Offset_0x00FC26
                dc.w    $160D
                dc.l    Offset_0x00FC3F
                dc.w    $2C0D  
;-------------------------------------------------------------------------------
Offset_0x00FA20:
                moveq   #$00, D2
                lea     Offset_0x00FA08(PC), A2
                lea     (A0), A1
                moveq   #$03, D1
Offset_0x00FA2A:
                move.l  (A0), (A1)
                move.b  #$04, Obj_Routine(A1)                            ; $0005
                move.l  #Invincibility_Mappings, Obj_Map(A1) ; Offset_0x00FD0E, $000C
                move.w  #$079C, Obj_Art_VRAM(A1)                         ; $000A
                move.w  #$0080, Obj_Priority(A1)                         ; $0008
                move.b  #$04, Obj_Flags(A1)                              ; $0004
                bset    #$06, Obj_Flags(A1)                              ; $0004
                move.b  #$10, Obj_Width(A1)                              ; $0007
                move.w  #$0002, Obj_Sub_Y(A1)                            ; $0016
                move.w  Obj_Player_Last(A0), Obj_Player_Last(A1)  ; $0042, $0042
                move.b  D2, Obj_Control_Var_06(A1)                       ; $0036
                addq.w  #$01, D2
                move.l  (A2)+, Obj_Control_Var_00(A1)                    ; $0030
                move.w  (A2)+, Obj_Control_Var_04(A1)                    ; $0034
                lea     Obj_Size(A1), A1                                 ; $004A
                dbra    D1, Offset_0x00FA2A
                move.b  #$02, Obj_Routine(A0)                            ; $0005
                move.b  #$04, Obj_Control_Var_04(A0)                     ; $0034
;-------------------------------------------------------------------------------
Offset_0x00FA86:                
                tst.b   (Super_Sonic_Flag).w                         ; $FFFFFE19
                bne     DeleteObject                           ; Offset_0x011138
                move.w  Obj_Player_Last(A0), A1                          ; $0042
                btst    #Invincibility_Type, Obj_Player_Status(A1)  ; $01, $002F
                beq     DeleteObject                           ; Offset_0x011138
                move.w  Obj_X(A1), D0                                    ; $0010
                move.w  D0, Obj_X(A0)                                    ; $0010
                move.w  Obj_Y(A1), D1                                    ; $0014
                move.w  D1, Obj_Y(A0)                                    ; $0014
                lea     Obj_Speed_X(A0), A2                              ; $0018
                lea     Offset_0x00FC04(PC), A3
                moveq   #$00, D5
Offset_0x00FAB6:
                move.w  Obj_Control_Var_08(A0), D2                       ; $0038
                move.b  $00(A3, D2), D5
                bpl.s   Offset_0x00FAC6
                clr.w   Obj_Control_Var_08(A0)                           ; $0038
                bra.s   Offset_0x00FAB6
Offset_0x00FAC6:
                addq.w  #$01, Obj_Control_Var_08(A0)                     ; $0038
                lea     Offset_0x00FBC4(PC), A6
                move.b  Obj_Control_Var_04(A0), D6                       ; $0034
                jsr     Offset_0x00FBAE(PC)
                move.w  D2, (A2)+
                move.w  D3, (A2)+
                move.w  D5, (A2)+
                addi.w  #$0020, D6
                jsr     Offset_0x00FBAE(PC)
                move.w  D2, (A2)+
                move.w  D3, (A2)+
                move.w  D5, (A2)+
                moveq   #$12, D0
                btst    #$00, Obj_Status(A1)                             ; $002A
                beq.s   Offset_0x00FAF6
                neg.w   D0
Offset_0x00FAF6:
                add.b   D0, Obj_Control_Var_04(A0)                       ; $0034
                bra     DisplaySprite                          ; Offset_0x011148
;-------------------------------------------------------------------------------
Offset_0x00FAFE:
                tst.b   (Super_Sonic_Flag).w                         ; $FFFFFE19
                bne     DeleteObject                           ; Offset_0x011138
                move.w  Obj_Player_Last(A0), A1                          ; $0042
                btst    #Invincibility_Type, Obj_Player_Status(A1)  ; $01, $002F
                beq     DeleteObject                           ; Offset_0x011138
                cmpi.w  #Miles_Alone, (Player_Selected_Flag).w ; $0002, $FFFFFF08
                beq.s   Offset_0x00FB2A
                lea     (Position_Table_Index).w, A5                 ; $FFFFEE26
                lea     (Position_Table_Data).w, A6                  ; $FFFFE500
                tst.b   Obj_Player_One_Or_Two_2(A0)                      ; $0043
                beq.s   Offset_0x00FB32
Offset_0x00FB2A:
                lea     (Position_Table_Index_2P).w, A5              ; $FFFFEE2A
                lea     (Position_Table_Data_P2).w, A6               ; $FFFFE600
Offset_0x00FB32:
                move.b  Obj_Control_Var_06(A0), D1                       ; $0036
                lsl.b   #$02, D1
                move.w  D1, D2
                add.w   D1, D1
                add.w   D2, D1
                move.w  (A5), D0
                sub.b   D1, D0
                lea     $00(A6, D0), A2
                move.w  (A2)+, D0
                move.w  (A2)+, D1
                move.w  D0, Obj_X(A0)                                    ; $0010
                move.w  D1, Obj_Y(A0)                                    ; $0014
                lea     Obj_Speed_X(A0), A2                              ; $0018
                move.l  Obj_Control_Var_00(A0), A3                       ; $0030
Offset_0x00FB5A:
                move.w  Obj_Control_Var_08(A0), D2                       ; $0038
                move.b  $00(A3, D2), D5
                bpl.s   Offset_0x00FB6A
                clr.w   Obj_Control_Var_08(A0)                           ; $0038
                bra.s   Offset_0x00FB5A
Offset_0x00FB6A:
                swap.w  D5
                add.b   Obj_P_Invcbility_Time(A0), D2                    ; $0035
                move.b  $00(A3, D2), D5
                addq.w  #$01, Obj_Control_Var_08(A0)                     ; $0038
                lea     Offset_0x00FBC4(PC), A6
                move.b  Obj_Control_Var_04(A0), D6                       ; $0034
                jsr     Offset_0x00FBAE(PC)
                move.w  D2, (A2)+
                move.w  D3, (A2)+
                move.w  D5, (A2)+
                addi.w  #$0020, D6
                swap.w  D5
                jsr     Offset_0x00FBAE(PC)
                move.w  D2, (A2)+
                move.w  D3, (A2)+
                move.w  D5, (A2)+
                moveq   #$02, D0
                btst    #$00, Obj_Status(A1)                             ; $002A
                beq.s   Offset_0x00FBA6
                neg.w   D0
Offset_0x00FBA6:
                add.b   D0, Obj_Control_Var_04(A0)                       ; $0034
                bra     DisplaySprite                          ; Offset_0x011148  
;-------------------------------------------------------------------------------
Offset_0x00FBAE:
                andi.w  #$003E, D6
                move.b  $00(A6, D6), D2
                move.b  $01(A6, D6), D3
                ext.w   D2
                ext.w   D3
                add.w   D0, D2
                add.w   D1, D3
                rts                 
;-------------------------------------------------------------------------------  
Offset_0x00FBC4:
                dc.b    $0F, $00, $0F, $03, $0E, $06, $0D, $08
                dc.b    $0B, $0B, $08, $0D, $06, $0E, $03, $0F
                dc.b    $00, $10, $FC, $0F, $F9, $0E, $F7, $0D
                dc.b    $F4, $0B, $F2, $08, $F1, $06, $F0, $03
                dc.b    $F0, $00, $F0, $FC, $F1, $F9, $F2, $F7
                dc.b    $F4, $F4, $F7, $F2, $F9, $F1, $FC, $F0
                dc.b    $FF, $F0, $03, $F0, $06, $F1, $08, $F2
                dc.b    $0B, $F4, $0D, $F7, $0E, $F9, $0F, $FC
;-------------------------------------------------------------------------------
Offset_0x00FC04:
                dc.b    $08, $05, $07, $06, $06, $07, $05, $08
                dc.b    $06, $07, $07, $06, $FF    
;-------------------------------------------------------------------------------
Offset_0x00FC11:
                dc.b    $08, $07, $06, $05, $04, $03, $04, $05
                dc.b    $06, $07, $FF, $03, $04, $05, $06, $07
                dc.b    $08, $07, $06, $05, $04   
;-------------------------------------------------------------------------------
Offset_0x00FC26:
                dc.b    $08, $07, $06, $05, $04, $03, $02, $03
                dc.b    $04, $05, $06, $07, $FF, $02, $03, $04
                dc.b    $05, $06, $07, $08, $07, $06, $05, $04
                dc.b    $03       
;-------------------------------------------------------------------------------
Offset_0x00FC3F:
                dc.b    $07, $06, $05, $04, $03, $02, $01, $02
                dc.b    $03, $04, $05, $06, $FF, $01, $02, $03
                dc.b    $04, $05, $06, $07, $06, $05, $04, $03
                dc.b    $02                                                                                                                                                                                                                                                           
;===============================================================================
; Invencibilidade do Sonic / Miles / Knuckles
; <<<-       
;===============================================================================  