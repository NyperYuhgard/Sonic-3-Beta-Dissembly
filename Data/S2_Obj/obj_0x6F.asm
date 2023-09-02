;===============================================================================
; Objeto 0x6F - Resultados do Special Stage
; ->>>
;===============================================================================    
; Offset_0x024BCC:
                moveq   #$00, D0
                moveq   #$00, D6
                move.b  Obj_Routine(A0), D0                              ; $0005
                move.w  Offset_0x024BDC(PC, D0), D1
                jmp     Offset_0x024BDC(PC, D1)        
;-------------------------------------------------------------------------------
Offset_0x024BDC:
                dc.w    Offset_0x024C12-Offset_0x024BDC
                dc.w    Offset_0x024C52-Offset_0x024BDC
                dc.w    Offset_0x024C86-Offset_0x024BDC
                dc.w    Offset_0x024CC4-Offset_0x024BDC
                dc.w    Offset_0x024CC2-Offset_0x024BDC
                dc.w    Offset_0x024CC0-Offset_0x024BDC
                dc.w    Offset_0x024CBE-Offset_0x024BDC
                dc.w    Offset_0x024CBC-Offset_0x024BDC
                dc.w    Offset_0x024CBA-Offset_0x024BDC
                dc.w    Offset_0x024CB8-Offset_0x024BDC
                dc.w    Offset_0x024D56-Offset_0x024BDC
                dc.w    Offset_0x024CFE-Offset_0x024BDC
                dc.w    Offset_0x024CE0-Offset_0x024BDC
                dc.w    Offset_0x024D5A-Offset_0x024BDC
                dc.w    Offset_0x024D64-Offset_0x024BDC
                dc.w    Offset_0x024D74-Offset_0x024BDC
                dc.w    Offset_0x024D64-Offset_0x024BDC
                dc.w    Offset_0x024E12-Offset_0x024BDC
                dc.w    Offset_0x024D64-Offset_0x024BDC
                dc.w    Offset_0x024D64-Offset_0x024BDC
                dc.w    Offset_0x024E1E-Offset_0x024BDC
                dc.w    Offset_0x024E8C-Offset_0x024BDC
                dc.w    Offset_0x024D64-Offset_0x024BDC
                dc.w    Offset_0x024E12-Offset_0x024BDC
                dc.w    Offset_0x024EA2-Offset_0x024BDC
                dc.w    Offset_0x024F04-Offset_0x024BDC
                dc.w    Offset_0x024F28-Offset_0x024BDC        
;-------------------------------------------------------------------------------
Offset_0x024C12:
                tst.l   (PLC_Data_Buffer).w                          ; $FFFFF680
                beq.s   Offset_0x024C1A
                rts
Offset_0x024C1A:
                move.l  A0, A1
                lea     Special_Stage_Screen_Pos(PC), A2       ; Offset_0x024F6A
                moveq   #$0C, D1
;-------------------------------------------------------------------------------                  
Offset_0x024C22:
                move.l  (A0), (A1)
                move.w  (A2), Obj_X(A1)                                  ; $0010
                move.w  (A2)+, Obj_Control_Var_02(A1)                    ; $0032
                move.w  (A2)+, Obj_Control_Var_00(A1)                    ; $0030
                move.w  (A2)+, Obj_Y(A1)                                 ; $0014
                move.b  (A2)+, Obj_Routine(A1)                           ; $0005
                move.b  (A2)+, Obj_Map_Id(A1)                            ; $0022
                move.l  #Special_Stage_Results_Mappings, Obj_Map(A1) ; Offset_0x02540C, $000C
                move.b  #$78, Obj_Width(A1)                              ; $0007
                lea     Obj_Size(A1), A1                                 ; $004A
                dbra    D1, Offset_0x024C22
Offset_0x024C52:
                tst.b   (SS_Completed_Flag).w                        ; $FFFFFFB0
                beq.s   Offset_0x024C5E
                move.b  #$04, Obj_Map_Id(A0)                             ; $0022
Offset_0x024C5E:
                cmpi.b  #$07, (Emeralds_Count).w                     ; $FFFFFFB1
                bne.s   Offset_0x024C6C
                move.b  #$19, Obj_Map_Id(A0)                             ; $0022
Offset_0x024C6C:
                move.w  Obj_Control_Var_00(A0), D0                       ; $0030
                cmp.w   Obj_X(A0), D0                                    ; $0010
                bne.s   Offset_0x024C82
                move.b  #$1C, Obj_Routine(A0)                            ; $0005
                move.w  #$00B4, Obj_Ani_Time(A0)                         ; $0024
Offset_0x024C82:
                bra     S2_Rev_2_Obj_0x34_Offset_0x013DB8      ; Offset_0x024BCA
;-------------------------------------------------------------------------------                  
Offset_0x024C86:
                cmpi.b  #$07, (Emeralds_Count).w                     ; $FFFFFFB1
                bne.s   Offset_0x024C92
                moveq   #$16, D0
                bra.s   Offset_0x024C9C
Offset_0x024C92:
                tst.b   (SS_Completed_Flag).w                        ; $FFFFFFB0
                beq     Offset_0x024BC4
                moveq   #$01, D0
Offset_0x024C9C:
                cmpi.w  #$0002, (Player_Selected_Flag).w             ; $FFFFFF08
                bne.s   Offset_0x024CB0
                addq.w  #$01, D0
                btst    #$07, (Hardware_Id).w                        ; $FFFFFFF8
                beq.s   Offset_0x024CB0
                addq.w  #$01, D0
Offset_0x024CB0:
                move.b  D0, Obj_Map_Id(A0)                               ; $0022
                bra     S2_Rev_2_Obj_0x34_Offset_0x013DB8      ; Offset_0x024BCA
;-------------------------------------------------------------------------------                  
Offset_0x024CB8:
                addq.w  #$01, D6
;-------------------------------------------------------------------------------                  
Offset_0x024CBA:
                addq.w  #$01, D6
;-------------------------------------------------------------------------------                  
Offset_0x024CBC:
                addq.w  #$01, D6
;-------------------------------------------------------------------------------                  
Offset_0x024CBE:
                addq.w  #$01, D6
;-------------------------------------------------------------------------------                  
Offset_0x024CC0:
                addq.w  #$01, D6
;-------------------------------------------------------------------------------                  
Offset_0x024CC2:
                addq.w  #$01, D6
;-------------------------------------------------------------------------------                  
Offset_0x024CC4:
                lea     (Emerald_Collected_Flag_List).w, A1          ; $FFFFFFB2
                tst.b   $00(A1, D6)
                beq     Offset_0x024BC4
                btst    #$00, (Vertical_Interrupt_Count+$03).w       ; $FFFFFE0F
                beq.s   Offset_0x024CDE
                jsr     (DisplaySprite)                        ; Offset_0x011148
Offset_0x024CDE:
                rts
;-------------------------------------------------------------------------------                  
Offset_0x024CE0:
                tst.w   (Player_Selected_Flag).w                     ; $FFFFFF08
                bne     Offset_0x024BC4
                beq     Offset_0x024BC4
                moveq   #$0E, D0
                btst    #$07, (Hardware_Id).w                        ; $FFFFFFF8
                beq.s   Offset_0x024CF8
                addq.w  #$01, D0
Offset_0x024CF8:
                lea     (Level_Results_Ring_Bonus).w, A1             ; $FFFFF7D4
                bra.s   Offset_0x024D4C
;-------------------------------------------------------------------------------                  
Offset_0x024CFE:
                bne.s   Offset_0x024D24
                move.w  #$1388, (Level_Results_Time_Bonus).w         ; $FFFFF7D2
                move.b  #$2A, Obj_Routine(A0)                            ; $0005
                move.w  #$0120, Obj_Y(A0)                                ; $0014
                st      (HUD_Results_Refresh_Flag).w                 ; $FFFFF7D6
                move.w  #S2_Panel_Spinning_Sfx, D0                       ; $00CF
                jsr     (Play_Music)                           ; Offset_0x001176
                bra     Offset_0x024E8C
Offset_0x024D24:
                move.w  (Player_Selected_Flag).w, D0                 ; $FFFFFF08
                beq.s   Offset_0x024D46
                move.w  #$0120, Obj_Y(A0)                                ; $0014
                subq.w  #$01, D0
                beq.s   Offset_0x024D46
                moveq   #$0E, D0
                btst    #$07, (Hardware_Id).w                        ; $FFFFFFF8
                beq.s   Offset_0x024D40
                addq.w  #$01, D0
Offset_0x024D40:
                lea     (Level_Results_Ring_Bonus).w, A1             ; $FFFFF7D4
                bra.s   Offset_0x024D4C
Offset_0x024D46:
                moveq   #$0D, D0
                lea     (Level_Results_Time_Bonus).w, A1             ; $FFFFF7D2
Offset_0x024D4C:
                tst.w   (A1)
                bne.s   Offset_0x024D52
                addq.w  #$05, D0
Offset_0x024D52:
                move.b  D0, Obj_Map_Id(A0)                               ; $0022
;-------------------------------------------------------------------------------                  
Offset_0x024D56:
                bra     S2_Rev_2_Obj_0x34_Offset_0x013DB8      ; Offset_0x024BCA
;-------------------------------------------------------------------------------                  
Offset_0x024D5A:
                tst.b   (SS_Completed_Flag).w                        ; $FFFFFFB0
                beq     Offset_0x024BC4
                bra.s   Offset_0x024D56
;-------------------------------------------------------------------------------                  
Offset_0x024D64:
                subq.w  #$01, Obj_Ani_Time(A0)                           ; $0024
                bne.s   Offset_0x024D6E
                addq.b  #$02, Obj_Routine(A0)                            ; $0005
Offset_0x024D6E:
                jmp     (DisplaySprite)                        ; Offset_0x011148
;-------------------------------------------------------------------------------                  
Offset_0x024D74:
                jsr     (DisplaySprite)                        ; Offset_0x011148
                move.b  #$01, (HUD_Results_Refresh_Flag).w           ; $FFFFF7D6
                moveq   #$00, D0
                tst.w   (Level_Results_Time_Bonus).w                 ; $FFFFF7D2
                beq.s   Offset_0x024D90
                addi.w  #$000A, D0
                subq.w  #$01, (Level_Results_Time_Bonus).w           ; $FFFFF7D2
Offset_0x024D90:
                tst.w   (Level_Results_Ring_Bonus).w                 ; $FFFFF7D4
                beq.s   Offset_0x024D9E
                addi.w  #$000A, D0
                subq.w  #$01, (Level_Results_Ring_Bonus).w           ; $FFFFF7D4
Offset_0x024D9E:
                tst.w   (Level_Results_Total_Bonus).w                ; $FFFFFF8E
                beq.s   Offset_0x024DAE
                addi.w  #$000A, D0
                subi.w  #$000A, (Level_Results_Total_Bonus).w        ; $FFFFFF8E
Offset_0x024DAE:
                tst.w   D0
                bne.s   Offset_0x024DF8
                move.w  #S2_Cha_Ching_Sfx, D0                            ; $00C5
                jsr     (Play_Music)                           ; Offset_0x001176
                addq.b  #$02, Obj_Routine(A0)                            ; $0005
                move.w  #$0078, Obj_Ani_Time(A0)                         ; $0024
                tst.w   (Perfect_Bonus_Rings_Flag).w                 ; $FFFFFF06
                bne.s   Offset_0x024DEA
                cmpi.w  #$0002, (Player_Selected_Flag).w             ; $FFFFFF08
                beq.s   Offset_0x024DF6
                tst.b   (SS_Completed_Flag).w                        ; $FFFFFFB0
                beq.s   Offset_0x024DF6
                cmpi.b  #$07, (Emeralds_Count).w                     ; $FFFFFFB1
                bne.s   Offset_0x024DF6
                move.b  #$30, Obj_Routine(A0)                            ; $0005
                rts
Offset_0x024DEA:
                move.b  #$24, Obj_Routine(A0)                            ; $0005
                move.w  #$005A, Obj_Ani_Time(A0)                         ; $0024
Offset_0x024DF6:
                rts
Offset_0x024DF8:
                jsr     (Add_Points_P1)                        ; Offset_0x007AB0
                move.b  (Vertical_Interrupt_Count+$03).w, D0         ; $FFFFFE0F
                andi.b  #$03, D0
                bne.s   Offset_0x024DF6
                move.w  #S2_Add_Points_Blip_Sfx, D0                      ; $00CD
                jmp     (Play_Music)                           ; Offset_0x001176
;-------------------------------------------------------------------------------                  
Offset_0x024E12:
                move.w  #$0001, (Restart_Level_Flag).w               ; $FFFFFE02
                jmp     (DisplaySprite)                        ; Offset_0x011148
;-------------------------------------------------------------------------------                  
Offset_0x024E1E:
                jsr     (DisplaySprite)                        ; Offset_0x011148
                move.b  #$01, (HUD_Results_Refresh_Flag).w           ; $FFFFF7D6
                moveq   #$00, D0
                tst.w   (Level_Results_Time_Bonus).w                 ; $FFFFF7D2
                beq.s   Offset_0x024E3C
                addi.w  #$0014, D0
                subi.w  #$0014, (Level_Results_Time_Bonus).w         ; $FFFFF7D2
Offset_0x024E3C:
                tst.w   D0
                beq.s   Offset_0x024E5A
                jsr     (Add_Points_P1)                        ; Offset_0x007AB0
                move.b  (Vertical_Interrupt_Count+$03).w, D0         ; $FFFFFE0F
                andi.b  #$03, D0
                bne.s   Offset_0x024E8A
                move.w  #S2_Add_Points_Blip_Sfx, D0                      ; $00CD
                jmp     (Play_Music)                           ; Offset_0x001176
Offset_0x024E5A:
                move.w  #S2_Cha_Ching_Sfx, D0                            ; $00C5
                jsr     (Play_Music)                           ; Offset_0x001176
                addq.b  #$04, Obj_Routine(A0)                            ; $0005
                move.w  #$0078, Obj_Ani_Time(A0)                         ; $0024
                cmpi.w  #$0002, (Player_Selected_Flag).w             ; $FFFFFF08
                beq.s   Offset_0x024E8A
                tst.b   (SS_Completed_Flag).w                        ; $FFFFFFB0
                beq.s   Offset_0x024E8A
                cmpi.b  #$07, (Emeralds_Count).w                     ; $FFFFFFB1
                bne.s   Offset_0x024E8A
                move.b  #$30, Obj_Routine(A0)                            ; $0005
Offset_0x024E8A:
                rts
;-------------------------------------------------------------------------------                  
Offset_0x024E8C:
                moveq   #$11, D0
                btst    #$03, (Vertical_Interrupt_Count+$03).w       ; $FFFFFE0F
                beq.s   Offset_0x024E98
                moveq   #$15, D0
Offset_0x024E98:
                move.b  D0, Obj_Map_Id(A0)                               ; $0022
                jmp     (DisplaySprite)                        ; Offset_0x011148
;-------------------------------------------------------------------------------                  
Offset_0x024EA2:
                move.b  #$32, Obj_Size+Obj_Routine(A0)                   ; $004F
                move.w  Obj_X(A0), D0                                    ; $0010
                cmp.w   Obj_Control_Var_02(A0), D0                       ; $0032
                bne.s   Offset_0x024F04
                move.b  #$14, Obj_Size+Obj_Routine(A0)                   ; $004F
                subq.w  #$08, Obj_Size+Obj_Y(A0)                         ; $005E
                move.b  #$1A, Obj_Size+Obj_Map_Id(A0)                    ; $006C
                move.b  #$34, Obj_Routine(A0)                            ; $0005
                subq.w  #$08, Obj_Y(A0)                                  ; $0014
                move.b  #$1B, Obj_Map_Id(A0)                             ; $0022
                move.l  (A0), (A1)
                clr.w   Obj_X(A1)                                        ; $0010
                move.w  #$0120, Obj_Control_Var_00(A1)                   ; $0030
                move.w  #$00B4, Obj_Y(A1)                                ; $0014
                move.b  #$14, Obj_Routine(A1)                            ; $0005
                move.b  #$1C, Obj_Map_Id(A1)                             ; $0022
                move.l  #Special_Stage_Results_Mappings, Obj_Map(A1) ; Offset_0x02540C, $000C
                move.b  #$78, Obj_Width(A1)                              ; $0007
                jmp     (DisplaySprite)                        ; Offset_0x011148
;-------------------------------------------------------------------------------                  
Offset_0x024F04:
                moveq   #$20, D0
                move.w  Obj_X(A0), D1                                    ; $0010
                cmp.w   Obj_Control_Var_02(A0), D1                       ; $0032
                beq.s   Offset_0x024F20
                bhi.s   Offset_0x024F14
                neg.w   D0
Offset_0x024F14:
                sub.w   D0, Obj_X(A0)                                    ; $0010
                cmpi.w  #$0200, Obj_X(A0)                                ; $0010
                bhi.s   Offset_0x024F26
Offset_0x024F20:
                jmp     (DisplaySprite)                        ; Offset_0x011148
Offset_0x024F26:
                rts
;-------------------------------------------------------------------------------                  
Offset_0x024F28:
                move.w  Obj_X(A0), D0                                    ; $0010
                cmp.w   Obj_Control_Var_00(A0), D0                       ; $0030
                bne     S2_Rev_2_Obj_0x34_Offset_0x013DB8      ; Offset_0x024BCA
                move.w  #$00B4, Obj_Ani_Time(A0)                         ; $0024
                move.b  #$20, Obj_Routine(A0)                            ; $0005
                jmp     (DisplaySprite)                        ; Offset_0x011148     
;===============================================================================
; Objeto 0x6F - Resultados do Special Stage
; <<<-
;===============================================================================                                                      