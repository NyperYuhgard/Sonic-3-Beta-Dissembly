;===============================================================================
; Objeto 0x02 - Alterna o plano do cen�rio em rela��o ao jogador
; ->>>
;===============================================================================      
; Offset_0x012AE8:
                move.l  #Layer_Switch_Mappings, Obj_Map(A0) ; Offset_0x012E98, $000C
                move.w  #$26BC, Obj_Art_VRAM(A0)                         ; $000A
                ori.b   #$04, Obj_Flags(A0)                              ; $0004
                move.b  #$40, Obj_Width(A0)                              ; $0007
                move.b  #$40, Obj_Height(A0)                             ; $0006
                move.w  #$0280, Obj_Priority(A0)                         ; $0008
                move.b  Obj_Subtype(A0), D0                              ; $002C
                btst    #$02, D0
                beq.s   Offset_0x012B76
                andi.w  #$0007, D0
                move.b  D0, Obj_Map_Id(A0)                               ; $0022
                andi.w  #$0003, D0
                add.w   D0, D0
                move.w  Layer_Switch_Conf_Sizes(PC, D0), Obj_Control_Var_02(A0) ; Offset_0x012B6E, $0032
                move.w  Obj_Y(A0), D1                                    ; $0014
                lea     (Obj_Player_One).w, A1                       ; $FFFFB000
                cmp.w   Obj_Y(A1), D1                                    ; $0014
                bcc.s   Offset_0x012B40
                move.b  #$01, Obj_Control_Var_04(A0)                     ; $0034
Offset_0x012B40:
                lea     (Obj_Player_Two).w, A1                       ; $FFFFB04A
                cmp.w   Obj_Y(A1), D1                                    ; $0014
                bcc.s   Offset_0x012B50
                move.b  #$01, Obj_Control_Var_05(A0)                     ; $0035
Offset_0x012B50:
                move.l  #Offset_0x012D2E, (A0)
                tst.w   (Two_Player_Flag).w                          ; $FFFFFFD8
                beq     Offset_0x012D2E
                move.l  #Offset_0x012D58, (A0)
                move.w  #$63D2, Obj_Art_VRAM(A0)                         ; $000A
                bra     Offset_0x012D58       
;-------------------------------------------------------------------------------
Layer_Switch_Conf_Sizes:                                       ; Offset_0x012B6E
                dc.w    $0020, $0040, $0080, $0100  
;-------------------------------------------------------------------------------
Offset_0x012B76:
                andi.w  #$0003, D0
                move.b  D0, Obj_Map_Id(A0)                               ; $0022
                add.w   D0, D0
                move.w  Layer_Switch_Conf_Sizes(PC, D0), Obj_Control_Var_02(A0) ; Offset_0x012B6E, $0032
                move.w  Obj_X(A0), D1                                    ; $0010
                lea     (Obj_Player_One).w, A1                       ; $FFFFB000
                cmp.w   Obj_X(A1), D1                                    ; $0010
                bcc.s   Offset_0x012B9A
                move.b  #$01, Obj_Control_Var_04(A0)                     ; $0034
Offset_0x012B9A:
                lea     (Obj_Player_Two).w, A1                       ; $FFFFB04A
                cmp.w   Obj_X(A1), D1                                    ; $0010
                bcc.s   Offset_0x012BAA
                move.b  #$01, Obj_Control_Var_05(A0)                     ; $0035
Offset_0x012BAA:
                move.l  #Offset_0x012BC4, (A0)
                tst.w   (Two_Player_Flag).w                          ; $FFFFFFD8
                beq.s   Offset_0x012BC4
                move.l  #Offset_0x012BEE, (A0)
                move.w  #$63D2, Obj_Art_VRAM(A0)                         ; $000A
                bra.s   Offset_0x012BEE
Offset_0x012BC4:
                tst.w   (Debug_Mode_Flag_Index).w                    ; $FFFFFE08
                bne     Offset_0x012BE0
                move.w  Obj_X(A0), D1                                    ; $0010
                lea     Obj_Control_Var_04(A0), A2                       ; $0034
                lea     (Obj_Player_One).w, A1                       ; $FFFFB000
                bsr.s   Offset_0x012C16
                lea     (Obj_Player_Two).w, A1                       ; $FFFFB04A
                bsr.s   Offset_0x012C16
Offset_0x012BE0:
                tst.w   (Debug_Mode_Active).w                        ; $FFFFFFFA
                beq     MarkObjGone_3                          ; Offset_0x011B3E
                jmp     (MarkObjGone)                          ; Offset_0x011AF2
Offset_0x012BEE:
                move.w  Obj_X(A0), D1                                    ; $0010
                lea     Obj_Control_Var_04(A0), A2                       ; $0034
                lea     (Obj_Player_One).w, A1                       ; $FFFFB000
                bsr.s   Offset_0x012C16
                lea     (Obj_Player_Two).w, A1                       ; $FFFFB04A
                bsr.s   Offset_0x012C16
                lea     (Obj_Fixed_RAM).w, A1                        ; $FFFFCB2C
                tst.w   (Debug_Mode_Active).w                        ; $FFFFFFFA
                beq     Offset_0x012C16
                bsr.s   Offset_0x012C16
                jmp     (DisplaySprite)                        ; Offset_0x011148
Offset_0x012C16:
                tst.b   (A2)+
                bne     Offset_0x012CA8
                cmp.w   Obj_X(A1), D1                                    ; $0010
                bhi     Offset_0x012D2C
                move.b  #$01, -1(A2)
                move.w  Obj_Y(A0), D2                                    ; $0014
                move.w  D2, D3
                move.w  Obj_Control_Var_02(A0), D4                       ; $0032
                sub.w   D4, D2
                add.w   D4, D3
                move.w  Obj_Y(A1), D4                                    ; $0014
                cmp.w   D2, D4
                blt     Offset_0x012D2C
                cmp.w   D3, D4
                bge     Offset_0x012D2C
                move.b  Obj_Subtype(A0), D0                              ; $002C
                bpl.s   Offset_0x012C58
                btst    #$01, Obj_Status(A1)                             ; $002A
                bne     Offset_0x012D2C
Offset_0x012C58:
                move.w  Obj_X(A1), D2                                    ; $0010
                sub.w   D1, D2
                bcc.s   Offset_0x012C62
                neg.w   D2
Offset_0x012C62:
                cmpi.w  #$0040, D2
                bcc     Offset_0x012D2C
                btst    #$00, Obj_Flags(A0)                              ; $0004
                bne.s   Offset_0x012C90
                move.b  #$0C, Obj_Player_Top_Solid(A1)                   ; $0046
                move.b  #$0D, Obj_Player_LRB_Solid(A1)                   ; $0047
                btst    #$03, D0
                beq.s   Offset_0x012C90
                move.b  #$0E, Obj_Player_Top_Solid(A1)                   ; $0046
                move.b  #$0F, Obj_Player_LRB_Solid(A1)                   ; $0047
Offset_0x012C90:
                andi.w  #$7FFF, Obj_Art_VRAM(A1)                         ; $000A
                btst    #$05, D0
                beq     Offset_0x012D2C
                ori.w   #$8000, Obj_Art_VRAM(A1)                         ; $000A
                bra     Offset_0x012D2C
Offset_0x012CA8:
                cmp.w   Obj_X(A1), D1                                    ; $0010
                bls     Offset_0x012D2C
                move.b  #$00, -1(A2)
                move.w  Obj_Y(A0), D2                                    ; $0014
                move.w  D2, D3
                move.w  Obj_Control_Var_02(A0), D4                       ; $0032
                sub.w   D4, D2
                add.w   D4, D3
                move.w  Obj_Y(A1), D4                                    ; $0014
                cmp.w   D2, D4
                blt     Offset_0x012D2C
                cmp.w   D3, D4
                bge     Offset_0x012D2C
                move.b  Obj_Subtype(A0), D0                              ; $002C
                bpl.s   Offset_0x012CE4
                btst    #$01, Obj_Status(A1)                             ; $002A
                bne     Offset_0x012D2C
Offset_0x012CE4:
                move.w  Obj_X(A1), D2                                    ; $0010
                sub.w   D1, D2
                bcc.s   Offset_0x012CEE
                neg.w   D2
Offset_0x012CEE:
                cmpi.w  #$0040, D2
                bcc.s   Offset_0x012D2C
                btst    #$00, Obj_Flags(A0)                              ; $0004
                bne.s   Offset_0x012D1A
                move.b  #$0C, Obj_Player_Top_Solid(A1)                   ; $0046
                move.b  #$0D, Obj_Player_LRB_Solid(A1)                   ; $0047
                btst    #$04, D0
                beq.s   Offset_0x012D1A
                move.b  #$0E, Obj_Player_Top_Solid(A1)                   ; $0046
                move.b  #$0F, Obj_Player_LRB_Solid(A1)                   ; $0047
Offset_0x012D1A:
                andi.w  #$7FFF, Obj_Art_VRAM(A1)                         ; $000A
                btst    #$06, D0
                beq.s   Offset_0x012D2C
                ori.w   #$8000, Obj_Art_VRAM(A1)                         ; $000A
Offset_0x012D2C:
                rts
;-------------------------------------------------------------------------------                
Offset_0x012D2E:
                tst.w   (Debug_Mode_Flag_Index).w                    ; $FFFFFE08
                bne     Offset_0x012D4A
                move.w  Obj_Y(A0), D1                                    ; $0014
                lea     Obj_Control_Var_04(A0), A2                       ; $0034
                lea     (Obj_Player_One).w, A1                       ; $FFFFB000
                bsr.s   Offset_0x012D80
                lea     (Obj_Player_Two).w, A1                       ; $FFFFB04A
                bsr.s   Offset_0x012D80
Offset_0x012D4A:
                tst.w   (Debug_Mode_Active).w                        ; $FFFFFFFA
                beq     MarkObjGone_3                          ; Offset_0x011B3E
                jmp     (MarkObjGone)                          ; Offset_0x011AF2
;-------------------------------------------------------------------------------                
Offset_0x012D58:
                move.w  Obj_Y(A0), D1                                    ; $0014
                lea     Obj_Control_Var_04(A0), A2                       ; $0034
                lea     (Obj_Player_One).w, A1                       ; $FFFFB000
                bsr.s   Offset_0x012D80
                lea     (Obj_Player_Two).w, A1                       ; $FFFFB04A
                bsr.s   Offset_0x012D80
                lea     (Obj_Fixed_RAM).w, A1                        ; $FFFFCB2C
                tst.w   (Debug_Mode_Active).w                        ; $FFFFFFFA
                beq     Offset_0x012D80
                bsr.s   Offset_0x012D80
                jmp     (DisplaySprite)                        ; Offset_0x011148
Offset_0x012D80:
                tst.b   (A2)+
                bne     Offset_0x012E12
                cmp.w   Obj_Y(A1), D1                                    ; $0014
                bhi     Offset_0x012E96
                move.b  #$01, -1(A2)
                move.w  Obj_X(A0), D2                                    ; $0010
                move.w  D2, D3
                move.w  Obj_Control_Var_02(A0), D4                       ; $0032
                sub.w   D4, D2
                add.w   D4, D3
                move.w  Obj_X(A1), D4                                    ; $0010
                cmp.w   D2, D4
                blt     Offset_0x012E96
                cmp.w   D3, D4
                bge     Offset_0x012E96
                move.b  Obj_Subtype(A0), D0                              ; $002C
                bpl.s   Offset_0x012DC2
                btst    #$01, Obj_Status(A1)                             ; $002A
                bne     Offset_0x012E96
Offset_0x012DC2:
                move.w  Obj_Y(A1), D2                                    ; $0014
                sub.w   D1, D2
                bcc.s   Offset_0x012DCC
                neg.w   D2
Offset_0x012DCC:
                cmpi.w  #$0040, D2
                bcc     Offset_0x012E96
                btst    #$00, Obj_Flags(A0)                              ; $0004
                bne.s   Offset_0x012DFA
                move.b  #$0C, Obj_Player_Top_Solid(A1)                   ; $0046
                move.b  #$0D, Obj_Player_LRB_Solid(A1)                   ; $0047
                btst    #$03, D0
                beq.s   Offset_0x012DFA
                move.b  #$0E, Obj_Player_Top_Solid(A1)                   ; $0046
                move.b  #$0F, Obj_Player_LRB_Solid(A1)                   ; $0047
Offset_0x012DFA:
                andi.w  #$7FFF, Obj_Art_VRAM(A1)                         ; $000A
                btst    #$05, D0
                beq     Offset_0x012E96
                ori.w   #$8000, Obj_Art_VRAM(A1)                         ; $000A
                bra     Offset_0x012E96
Offset_0x012E12:
                cmp.w   Obj_Y(A1), D1                                    ; $0014
                bls     Offset_0x012E96
                move.b  #$00, -1(A2)
                move.w  Obj_X(A0), D2                                    ; $0010
                move.w  D2, D3
                move.w  Obj_Control_Var_02(A0), D4                       ; $0032
                sub.w   D4, D2
                add.w   D4, D3
                move.w  Obj_X(A1), D4                                    ; $0010
                cmp.w   D2, D4
                blt     Offset_0x012E96
                cmp.w   D3, D4
                bge     Offset_0x012E96
                move.b  Obj_Subtype(A0), D0                              ; $002C
                bpl.s   Offset_0x012E4E
                btst    #$01, Obj_Status(A1)                             ; $002A
                bne     Offset_0x012E96
Offset_0x012E4E:
                move.w  Obj_Y(A1), D2                                    ; $0014
                sub.w   D1, D2
                bcc.s   Offset_0x012E58
                neg.w   D2
Offset_0x012E58:
                cmpi.w  #$0040, D2
                bcc.s   Offset_0x012E96
                btst    #$00, Obj_Flags(A0)                              ; $0004
                bne.s   Offset_0x012E84
                move.b  #$0C, Obj_Player_Top_Solid(A1)                   ; $0046
                move.b  #$0D, Obj_Player_LRB_Solid(A1)                   ; $0047
                btst    #$04, D0
                beq.s   Offset_0x012E84
                move.b  #$0E, Obj_Player_Top_Solid(A1)                   ; $0046
                move.b  #$0F, Obj_Player_LRB_Solid(A1)                   ; $0047
Offset_0x012E84:
                andi.w  #$7FFF, Obj_Art_VRAM(A1)                         ; $000A
                btst    #$06, D0
                beq.s   Offset_0x012E96
                ori.w   #$8000, Obj_Art_VRAM(A1)                         ; $000A
Offset_0x012E96:
                rts  
;-------------------------------------------------------------------------------
Layer_Switch_Mappings:                                         ; Offset_0x012E98
                dc.w    Offset_0x012EA8-Layer_Switch_Mappings
                dc.w    Offset_0x012EC2-Layer_Switch_Mappings
                dc.w    Offset_0x012EDC-Layer_Switch_Mappings
                dc.w    Offset_0x012EDC-Layer_Switch_Mappings
                dc.w    Offset_0x012EF6-Layer_Switch_Mappings
                dc.w    Offset_0x012F10-Layer_Switch_Mappings
                dc.w    Offset_0x012F2A-Layer_Switch_Mappings
                dc.w    Offset_0x012F2A-Layer_Switch_Mappings
Offset_0x012EA8:
                dc.w    $0004
                dc.w    $E005, $0000, $FFF8
                dc.w    $F005, $0000, $FFF8
                dc.w    $0005, $0000, $FFF8
                dc.w    $1005, $0000, $FFF8
Offset_0x012EC2:
                dc.w    $0004
                dc.w    $C005, $0000, $FFF8
                dc.w    $E005, $0000, $FFF8
                dc.w    $0005, $0000, $FFF8
                dc.w    $3005, $0000, $FFF8
Offset_0x012EDC:
                dc.w    $0004
                dc.w    $8005, $0000, $FFF8
                dc.w    $E005, $0000, $FFF8
                dc.w    $0005, $0000, $FFF8
                dc.w    $7005, $0000, $FFF8
Offset_0x012EF6:
                dc.w    $0004
                dc.w    $F805, $0000, $FFE0
                dc.w    $F805, $0000, $FFF0
                dc.w    $F805, $0000, $0000
                dc.w    $F805, $0000, $0010
Offset_0x012F10:
                dc.w    $0004
                dc.w    $F805, $0000, $FFC0
                dc.w    $F805, $0000, $FFE0
                dc.w    $F805, $0000, $0000
                dc.w    $F805, $0000, $0030
Offset_0x012F2A:
                dc.w    $0004
                dc.w    $F805, $0000, $FF80
                dc.w    $F805, $0000, $FFE0
                dc.w    $F805, $0000, $0000
                dc.w    $F805, $0000, $0070                                                                                                                                              
;===============================================================================
; Objeto 0x02 - Alterna o plano do cen�rio em rela��o ao jogador
; <<<-
;===============================================================================  