;-------------------------------------------------------------------------------
; Tela de resultados das fases
; ->>>
;------------------------------------------------------------------------------- 
; Offset_0x0247D0:
                moveq   #$00, D0
                move.b  Obj_Routine(A0), D0                              ; $0005
                move.w  Offset_0x0247DE(PC, D0), D1
                jmp     Offset_0x0247DE(PC, D1)  
;-------------------------------------------------------------------------------
Offset_0x0247DE:
                dc.w    Offset_0x0247E6-Offset_0x0247DE
                dc.w    Offset_0x0248B4-Offset_0x0247DE
                dc.w    Offset_0x02490E-Offset_0x0247DE
                dc.w    Offset_0x02495E-Offset_0x0247DE 
;-------------------------------------------------------------------------------   
Offset_0x0247E6:
                lea     (Title_Card_Results), A1               ; Offset_0x13A8DA
                move.w  #$A400, D2
                jsr     (Kosinski_Moduled_Dec)                 ; Offset_0x0018A8
                lea     (Title_Card_Number_1), A1              ; Offset_0x13AB6C
                move.w  #$B000, D2
                tst.b   (Act_Id_2).w                                 ; $FFFFEE55
                beq.s   Offset_0x024810
                lea     (Title_Card_Number_2), A1              ; Offset_0x13AC2E
                move.w  #$B400, D2
Offset_0x024810:
                jsr     (Kosinski_Moduled_Dec)                 ; Offset_0x0018A8
                lea     (Level_Results_Sonic), A1              ; Offset_0x13A272
                cmpi.w  #Sonic_Alone, (Player_Selected_Flag).w ; $0001, $FFFFFF08
                bls.s   Offset_0x024844
                lea     (Level_Results_Knuckles), A1           ; Offset_0x13A668
                cmpi.w  #Knuckles_Alone, (Player_Selected_Flag).w ; $0003, $FFFFFF08
                beq.s   Offset_0x024844
                lea     (Level_Results_Miles), A1              ; Offset_0x13A3D4
                tst.b   (Hardware_Id).w                              ; $FFFFFFF8
                beq.s   Offset_0x024844
                lea     (Level_Results_Tails), A1              ; Offset_0x13A526
Offset_0x024844:
                move.w  #$AC20, D2
                jsr     (Kosinski_Moduled_Dec)                 ; Offset_0x0018A8
                moveq   #$00, D0
                move.b  (Timer_Minute_Count_Address).w, D0           ; $FFFFFE23
                mulu.w  #$003C, D0
                moveq   #$00, D1
                move.b  (Timer_Second_Count_Address).w, D1           ; $FFFFFE24
                add.w   D1, D0
                cmpi.w  #$0257, D0
                bne.s   Offset_0x02486E
                move.w  #$2710, (Level_Results_Time_Bonus).w         ; $FFFFF7D2
                bra.s   Offset_0x024886
Offset_0x02486E:
                divu.w  #$001E, D0
                moveq   #$09, D1
                cmp.w   D1, D0
                bcs.s   Offset_0x02487A
                move.w  D1, D0
Offset_0x02487A:
                add.w   D0, D0
                lea     LR_Decimal_Values(PC), A1              ; Offset_0x024B08
                move.w  $00(A1, D0), (Level_Results_Time_Bonus).w    ; $FFFFF7D2
Offset_0x024886:
                move.w  (Ring_Count_Address).w, D0                   ; $FFFFFE20
                mulu.w  #$000A, D0
                move.w  D0, (Level_Results_Ring_Bonus).w             ; $FFFFF7D4
                clr.w   (Level_Results_Total_Bonus).w                ; $FFFFFF8E
                move.w  #$0096, Obj_Timer(A0)                            ; $002E
                move.w  #$000C, Obj_Control_Var_00(A0)                   ; $0030
                move.b  #$1E, (Obj_Player_One+Obj_Subtype).w         ; $FFFFB02C
                move.b  #$1E, (Obj_Player_Two+Obj_Subtype).w         ; $FFFFB076
                addq.b  #$02, Obj_Routine(A0)                            ; $0005
                rts     
;-------------------------------------------------------------------------------
Offset_0x0248B4:
                subq.w  #$01, Obj_Timer(A0)                              ; $002E
                tst.b   (Kosinski_Modules_Left).w                    ; $FFFFFF60
                bne.s   Offset_0x02490C
                jsr     (SingleObjectLoad_A0)                  ; Offset_0x011DE0
                bne.s   Offset_0x02490C
                lea     Level_Results_Conf(PC), A2             ; Offset_0x024B1C
                moveq   #$0B, D1
Offset_0x0248CC:
                move.l  (A2)+, (A1)
                move.w  (A2)+, Obj_Control_Var_16(A1)                    ; $0046
                move.w  (A2)+, Obj_X(A1)                                 ; $0010
                spl     Obj_Routine(A1)                                  ; $0005
                move.w  (A2)+, Obj_Y(A1)                                 ; $0014
                move.b  (A2)+, Obj_Map_Id(A1)                            ; $0022
                move.b  (A2)+, Obj_Width(A1)                             ; $0007
                move.w  (A2)+, D2
                move.b  D2, Obj_Col_Flags(A1)                            ; $0028
                move.b  #$40, Obj_Flags(A1)                              ; $0004
                move.l  #Level_Results_Mappings, Obj_Map(A1) ; Offset_0x02528A, $000C
                move.w  A0, Obj_Respaw_Ref(A1)                           ; $0048
                jsr     (SingleObjectLoad_A1_D0)               ; Offset_0x011DC8
                dbne    D1, Offset_0x0248CC
                addq.b  #$02, Obj_Routine(A0)                            ; $0005
Offset_0x02490C:
                rts             
;-------------------------------------------------------------------------------    
Offset_0x02490E:
                tst.w   Obj_Timer(A0)                                    ; $002E
                beq.s   Offset_0x02491A
                subq.w  #$01, Obj_Timer(A0)                              ; $002E
                rts
Offset_0x02491A:
                moveq   #$00, D0
                tst.w   (Level_Results_Time_Bonus).w                 ; $FFFFF7D2
                beq.s   Offset_0x02492C
                addi.w  #$000A, D0
                subi.w  #$000A, (Level_Results_Time_Bonus).w         ; $FFFFF7D2
Offset_0x02492C:
                tst.w   (Level_Results_Ring_Bonus).w                 ; $FFFFF7D4
                beq.s   Offset_0x02493C
                addi.w  #$000A, D0
                subi.w  #$000A, (Level_Results_Ring_Bonus).w         ; $FFFFF7D4
Offset_0x02493C:
                add.w   D0, (Level_Results_Total_Bonus).w            ; $FFFFFF8E
                tst.w   D0
                beq.s   Offset_0x024954
                jsr     (Add_Points_P1)                        ; Offset_0x007AB0
                move.w  (Level_Frame_Count).w, D0                    ; $FFFFFE04
                andi.w  #$0003, D0
                rts
Offset_0x024954:
                move.w  #$003C, Obj_Timer(A0)                            ; $002E
                addq.b  #$02, Obj_Routine(A0)                            ; $0005
;-------------------------------------------------------------------------------
Offset_0x02495E:                
                tst.w   Obj_Timer(A0)                                    ; $002E
                beq.s   Offset_0x02496A
                subq.w  #$01, Obj_Timer(A0)                              ; $002E
                rts
Offset_0x02496A:
                tst.w   Obj_Control_Var_00(A0)                           ; $0030
                beq.s   Offset_0x024976
                addq.w  #$01, Obj_Control_Var_02(A0)                     ; $0032
                rts
Offset_0x024976:
                tst.b   (Act_Id_2).w                                 ; $FFFFEE55
                beq.s   Offset_0x02498A
                clr.b   (Player_Control_Lock_Flag).w                 ; $FFFFFAA8
                st      (End_Level_Flag).w                           ; $FFFFFAAA
                jmp     (DeleteObject)                         ; Offset_0x011138
Offset_0x02498A:
                move.b  #$01, (Act_Id_2).w                           ; $FFFFEE55
                clr.b   (Player_Control_Lock_Flag).w                 ; $FFFFFAA8
                move.l  #Obj_Title_Cards, (A0)                 ; Offset_0x024546
                clr.b   Obj_Routine(A0)                                  ; $0005
                st      Obj_Control_Var_0E(A0)                           ; $003E
                rts
;-------------------------------------------------------------------------------
Obj_Lvl_Res_Sonic_Miles_Knuckles_Tails:                        ; Offset_0x0249A4
                cmpi.w  #Miles_Alone, (Player_Selected_Flag).w  ; $0002, $FFFFFF08
                beq.s   Offset_0x0249C8
                cmpi.w  #Knuckles_Alone, (Player_Selected_Flag).w  ; $0003, $FFFFFF08
                bne.s   Offset_0x0249E4
                addq.b  #$03, Obj_Map_Id(A0)                             ; $0022
                moveq   #$30, D0
                sub.w   D0, Obj_X(A0)                                    ; $0010
                sub.w   D0, Obj_Control_Var_16(A0)                       ; $0046
                add.b   D0, Obj_Width(A0)                                ; $0007
                bra.s   Offset_0x0249E4
Offset_0x0249C8:
                addq.b  #$01, Obj_Map_Id(A0)                             ; $0022
                tst.b   (Hardware_Id).w                              ; $FFFFFFF8
                bpl.s   Offset_0x0249E4
                addq.b  #$01, Obj_Map_Id(A0)                             ; $0022
                moveq   #$08, D0
                add.w   D0, Obj_X(A0)                                    ; $0010
                add.w   D0, Obj_Control_Var_16(A0)                       ; $0046
                sub.b   D0, Obj_Width(A0)                                ; $0007
Offset_0x0249E4:
                move.l  #Obj_LvL_Res_GOT, (A0)                 ; Offset_0x0249EA
;-------------------------------------------------------------------------------                
Obj_LvL_Res_GOT:                                               ; Offset_0x0249EA     
Obj_LvL_Res_THROUGH:                                           ; Offset_0x0249EA 
Obj_LvL_Res_TIME:                                              ; Offset_0x0249EA
Obj_LvL_Res_BONUS:   ; TIME "BONUS" / RING "BONUS"             ; Offset_0x0249EA
Obj_LvL_Res_RING:                                              ; Offset_0x0249EA
Obj_LvL_Res_TOTAL:                                             ; Offset_0x0249EA 
                jsr     LR_Move_Element(PC)                    ; Offset_0x024A62
                jmp     (DisplaySprite)                        ; Offset_0x011148 
;-------------------------------------------------------------------------------
Obj_LvL_Res_ACT_X:                                             ; Offset_0x0249F4
                tst.b   (Act_Id_2).w                                 ; $FFFFEE55
                beq.s   Offset_0x0249E4
                addq.b  #$01, Obj_Map_Id(A0)                             ; $0022
                bra.s   Offset_0x0249E4        
;-------------------------------------------------------------------------------
Obj_LvL_Res_Time_Bonus:                                        ; Offset_0x024A00
                jsr     LR_Move_Element(PC)                    ; Offset_0x024A62
                move.w  (Level_Results_Time_Bonus).w, D0             ; $FFFFF7D2
                bra.s   LR_Display_Value_D0                    ; Offset_0x024A1C     
;-------------------------------------------------------------------------------    
Obj_LvL_Res_Ring_Bonus:                                        ; Offset_0x024A0A
                jsr     LR_Move_Element(PC)                    ; Offset_0x024A62
                move.w  (Level_Results_Ring_Bonus).w, D0             ; $FFFFF7D4
                bra.s   LR_Display_Value_D0                    ; Offset_0x024A1C              
;-------------------------------------------------------------------------------  
Obj_LvL_Res_Total_Bonus:                                       ; Offset_0x024A14
                jsr     LR_Move_Element(PC)                    ; Offset_0x024A62
                move.w  (Level_Results_Total_Bonus).w, D0            ; $FFFFFF8E  
;-------------------------------------------------------------------------------  
LR_Display_Value_D0:                                           ; Offset_0x024A1C
                bsr.s   LR_Cvt_Hex_To_BCD                      ; Offset_0x024A24
                jmp     (DisplaySprite)                        ; Offset_0x011148 
;------------------------------------------------------------------------------- 
LR_Cvt_Hex_To_BCD:                                             ; Offset_0x024A24
                move.w  #$0007, Obj_Sub_Y(A0)                            ; $0016
                jsr     LR_Get_BCD_Total_Bonus(PC)             ; Offset_0x024AAE
                rol.l   #$04, D1
                lea     Obj_Speed_X(A0), A1                              ; $0018
                move.w  Obj_X(A0), D2                                    ; $0010
                subi.w  #$0038, D2
                move.w  Obj_Y(A0), D3                                    ; $0014
                moveq   #$00, D4
                moveq   #$06, D5
Offset_0x024A44:
                move.w  D2, (A1)+
                move.w  D3, (A1)+
                addq.w  #$01, A1
                rol.l   #$04, D1
                move.w  D1, D0
                andi.w  #$000F, D0
                beq.s   Offset_0x024A56
                moveq   #$01, D4
Offset_0x024A56:
                add.w   D4, D0
                move.b  D0, (A1)+
                addq.w  #$08, D2
                dbra    D5, Offset_0x024A44
                rts      
;-------------------------------------------------------------------------------
LR_Move_Element:                                               ; Offset_0x024A62
                move.w  Obj_Respaw_Ref(A0), A1                           ; $0048
                move.w  Obj_Control_Var_02(A1), D0                       ; $0032
                beq.s   Offset_0x024A96
                tst.b   Obj_Flags(A0)                                    ; $0004
                bmi.s   Offset_0x024A7E
                subq.w  #$01, Obj_Control_Var_00(A1)                     ; $0030
                addq.w  #$04, A7
                jmp     (DeleteObject)                         ; Offset_0x011138
Offset_0x024A7E:
                cmp.b   Obj_Col_Flags(A0), D0                            ; $0028
                bcs.s   Offset_0x024AAC
                move.w  #$FFE0, D0
                tst.b   Obj_Routine(A0)                                  ; $0005
                beq.s   Offset_0x024A90
                neg.w   D0
Offset_0x024A90:
                add.w   Obj_X(A0), D0                                    ; $0010
                bra.s   Offset_0x024AA8
Offset_0x024A96:
                moveq   #$10, D1
                move.w  Obj_X(A0), D0                                    ; $0010
                cmp.w   Obj_Control_Var_16(A0), D0                       ; $0046
                beq.s   Offset_0x024AA8
                blt.s   Offset_0x024AA6
                neg.w   D1
Offset_0x024AA6:
                add.w   D1, D0
Offset_0x024AA8:
                move.w  D0, Obj_X(A0)                                    ; $0010
Offset_0x024AAC:
                rts                  
;-------------------------------------------------------------------------------  
LR_Get_BCD_Total_Bonus:                                        ; Offset_0x024AAE
                clr.l   (Level_Result_BCD_Total_Bonus).w             ; $FFFFEF40
                lea     LR_Decimal_Values(PC), A1              ; Offset_0x024B08
                moveq   #$0F, D2
Offset_0x024AB8:
                ror.w   #$01, D0
                bcs.s   Offset_0x024AC0
                subq.w  #$03, A1
                bra.s   Offset_0x024ACE
Offset_0x024AC0:
                lea     (Level_Result_BCD_Total_Bonus+$04).w, A2     ; $FFFFEF44
                addi.w  #$0000, D0
                abcd    -(A1), -(A2)
                abcd    -(A1), -(A2)
                abcd    -(A1), -(A2)
Offset_0x024ACE:
                dbra    D2, Offset_0x024AB8
                move.l  (Level_Result_BCD_Total_Bonus).w, D1         ; $FFFFEF40
                rts                             
;-------------------------------------------------------------------------------
; Offset_0x024AD8: ; Dados não usados. Left over?
                dc.b    $03, $27, $68, $01, $63, $84, $00, $81
                dc.b    $92, $00, $40, $96, $00, $20, $48, $00
                dc.b    $10, $24, $00, $05, $12, $00, $02, $56
                dc.b    $00, $01, $28, $00, $00, $64, $00, $00
                dc.b    $32, $00, $00, $16, $00, $00, $08, $00
                dc.b    $00, $04, $00, $00, $02, $00, $00, $01  
;------------------------------------------------------------------------------- 
LR_Decimal_Values:                                             ; Offset_0x024B08
                dc.w    $1388  ; 50.000
                dc.w    $1388  ; 50.000
                dc.w    $1388  ; 50.000
                dc.w    $1388  ; 50.000
                dc.w    $1388  ; 50.000
                dc.w    $03E8  ; 10.000
                dc.w    $01F4  ;  4.000
                dc.w    $0190  ;  3.000
                dc.w    $012C  ;  2.000 
                dc.w    $0064  ;  1.000
;-------------------------------------------------------------------------------
Level_Results_Conf:                                            ; Offset_0x024B1C
                dc.l    Obj_Lvl_Res_Sonic_Miles_Knuckles_Tails ; Offset_0x0249A4
                dc.w    $00E0, $FDE0, $00B8
                dc.b    $13, $48
                dc.w    $0001
                dc.l    Obj_LvL_Res_GOT                        ; Offset_0x0249EA 
                dc.w    $0130, $FE30, $00B8
                dc.b    $12, $30
                dc.w    $0001
                dc.l    Obj_LvL_Res_THROUGH                    ; Offset_0x0249EA
                dc.w    $00E8, $0468, $00CC 
                dc.b    $11, $70
                dc.w    $0003
                dc.l    Obj_LvL_Res_ACT_X                      ; Offset_0x0249F4 
                dc.w    $0160, $04E0, $00BC
                dc.b    $0F, $38
                dc.w    $0003
                dc.l    Obj_LvL_Res_TIME                       ; Offset_0x0249EA
                dc.w    $00C0, $04C0, $00F0
                dc.b    $0E, $20
                dc.w    $0005
                dc.l    Obj_LvL_Res_BONUS    ; TIME "BONUS"    ; Offset_0x0249EA 
                dc.w    $00E8, $04E8, $00F0
                dc.b    $0C, $30
                dc.w    $0005
                dc.l    Obj_LvL_Res_Time_Bonus                 ; Offset_0x024A00
                dc.w    $0178, $0578, $00F0 
                dc.b    $01, $40
                dc.w    $0005
                dc.l    Obj_LvL_Res_RING                       ; Offset_0x0249EA 
                dc.w    $00C0, $0500, $0100
                dc.b    $0D, $20
                dc.w    $0007
                dc.l    Obj_LvL_Res_BONUS    ; RING "BONUS"    ; Offset_0x0249EA
                dc.w    $00E8, $0528, $0100 
                dc.b    $0C, $30
                dc.w    $0007
                dc.l    Obj_LvL_Res_Ring_Bonus                 ; Offset_0x024A0A 
                dc.w    $0178, $05B8, $0100
                dc.b    $01, $40
                dc.w    $0007
                dc.l    Obj_LvL_Res_TOTAL                      ; Offset_0x0249EA
                dc.w    $00D4, $0554, $011C
                dc.b    $0B, $30
                dc.w    $0009
                dc.l    Obj_LvL_Res_Total_Bonus                ; Offset_0x024A14 
                dc.w    $0178, $05F8, $011C
                dc.b    $01, $40 
                dc.w    $0009 
;-------------------------------------------------------------------------------
; Tela de resultados das fases
; <<<-
;-------------------------------------------------------------------------------