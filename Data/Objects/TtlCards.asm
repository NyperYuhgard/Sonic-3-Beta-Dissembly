;-------------------------------------------------------------------------------
; Tela com o nome das fases conhecido também conhecido como: 
; ->>>     - Splash Screen, Title Cards, etc... 
;------------------------------------------------------------------------------- 
; Offset_0x024546:
                moveq   #$00, D0
                move.b  Obj_Routine(A0), D0                              ; $0005
                move.w  Offset_0x024554(PC, D0), D1
                jmp     Offset_0x024554(PC, D1)                                 
;-------------------------------------------------------------------------------
Offset_0x024554:
                dc.w    Offset_0x02455C-Offset_0x024554
                dc.w    Offset_0x0245B8-Offset_0x024554
                dc.w    Offset_0x024620-Offset_0x024554
                dc.w    Offset_0x024636-Offset_0x024554   
;-------------------------------------------------------------------------------   
Offset_0x02455C:
                lea     (Title_Card_ZONE_ACT), A1              ; Offset_0x13AD10
                move.w  #$A000, D2
                jsr     (Kosinski_Moduled_Dec)                 ; Offset_0x0018A8
                lea     (Title_Card_Number_1), A1              ; Offset_0x13AB6C
                tst.b   (Act_Id_2).w                                 ; $FFFFEE55
                beq.s   Offset_0x02457E
                lea     (Title_Card_Number_2), A1              ; Offset_0x13AC2E
Offset_0x02457E:
                move.w  #$A7A0, D2
                jsr     (Kosinski_Moduled_Dec)                 ; Offset_0x0018A8
                lea     Title_Card_Letters_Ptr(PC), A1         ; Offset_0x024764
                moveq   #$00, D0
                move.b  (Level_Id_2).w, D0                           ; $FFFFEE54
                lsl.w   #$02, D0
                move.l  $00(A1, D0), A1
                move.w  #$A9A0, D2
                jsr     (Kosinski_Moduled_Dec)                 ; Offset_0x0018A8
                move.w  #$005A, Obj_Timer(A0)                            ; $002E
                move.w  #$0004, Obj_Control_Var_00(A0)                   ; $0030
                clr.w   Obj_Control_Var_02(A0)                           ; $0032
                addq.b  #$02, Obj_Routine(A0)                            ; $0005
                rts
Offset_0x0245B8:
                tst.b   (Kosinski_Modules_Left).w                    ; $FFFFFF60
                bne.s   Offset_0x02461E
                jsr     (SingleObjectLoad_A0)                  ; Offset_0x011DE0
                bne.s   Offset_0x02461E
                lea     Title_Cards_Conf_Ptr(PC), A2           ; Offset_0x024798
                moveq   #$03, D1
Offset_0x0245CC:
                move.l  (A2)+, (A1)
                move.w  (A2)+, Obj_Control_Var_16(A1)                    ; $0046
                move.w  (A2)+, Obj_X(A1)                                 ; $0010
                move.w  (A2)+, Obj_Y(A1)                                 ; $0014
                move.b  (A2)+, Obj_Map_Id(A1)                            ; $0022
                move.b  (A2)+, Obj_Width(A1)                             ; $0007
                move.w  (A2)+, D2
                move.b  D2, Obj_Col_Flags(A1)                            ; $0028
                move.b  #$40, Obj_Flags(A1)                              ; $0004
                move.l  #Title_Cards_Mappings, Obj_Map(A1) ; Offset_0x025012, $000C
                move.w  A0, Obj_Respaw_Ref(A1)                           ; $0048
                jsr     (SingleObjectLoad_A1_D0)               ; Offset_0x011DC8
                dbne    D1, Offset_0x0245CC
                tst.w   Obj_Control_Var_0E(A0)                           ; $003E
                beq.s   Offset_0x02461A
                move.b  (Level_Id_2).w, D0                           ; $FFFFEE54
                beq.s   Offset_0x02461A
                cmpi.b  #Iz_Id, D0                                         ; $05
                beq.s   Offset_0x02461A
                st      (Level_Events_Buffer_5).w                    ; $FFFFEEC6
Offset_0x02461A:
                addq.b  #$02, Obj_Routine(A0)                            ; $0005
Offset_0x02461E:
                rts
Offset_0x024620:
                tst.w   Obj_Control_Var_04(A0)                           ; $0034
                beq.s   Offset_0x02462C
                clr.w   Obj_Control_Var_04(A0)                           ; $0034
                rts
Offset_0x02462C:
                st      Obj_Respaw_Ref(A0)                               ; $0048
                addq.b  #$02, Obj_Routine(A0)                            ; $0005
                rts
Offset_0x024636:
                tst.w   Obj_Timer(A0)                                    ; $002E
                beq.s   Offset_0x024642
                subq.w  #$01, Obj_Timer(A0)                              ; $002E
                rts
Offset_0x024642:
                tst.w   Obj_Control_Var_00(A0)                           ; $0030
                beq.s   Offset_0x02464E
                addq.w  #$01, Obj_Control_Var_02(A0)                     ; $0032
                rts
Offset_0x02464E:
                tst.w   Obj_Control_Var_0E(A0)                           ; $003E
                beq.s   Offset_0x024682
                clr.l   (Time_Count_Address).w                       ; $FFFFFE22
                clr.w   (Ring_Count_Address).w                       ; $FFFFFE20
                clr.w   (Total_Ring_Count_Address).w                 ; $FFFFFEF0
                clr.b   (Ring_Status_Flag).w                         ; $FFFFFE1B
                clr.l   (Time_Count_Address_P2).w                    ; $FFFFFED2
                clr.w   (Ring_Count_Address_P2).w                    ; $FFFFFED0
                clr.w   (Total_Ring_Count_Address_P2).w              ; $FFFFFEF2
                clr.b   (Ring_Status_Flag_P2).w                      ; $FFFFFEC7
                st      (HUD_Timer_Refresh_Flag).w                   ; $FFFFFE1E
                st      (HUD_Rings_Refresh_Flag).w                   ; $FFFFFE1D
                st      (End_Level_Flag).w                           ; $FFFFFAAA
                bra.s   Offset_0x02468E
Offset_0x024682:
                lea     (PLC_Spikes_Springs), A1               ; Offset_0x04192C
                jsr     (LoadPLC_A1)                           ; Offset_0x001502
Offset_0x02468E:
                move.w  (Level_Id_2).w, D0                           ; $FFFFEE54
                jsr     Level_Load_Enemies_Art(PC)             ; Offset_0x024F46
                moveq   #$02, D0
                jsr     (LoadPLC)                              ; Offset_0x0014D0
                jmp     (DeleteObject)                         ; Offset_0x011138   
;-------------------------------------------------------------------------------
Title_Card_Red_Bar:                                            ; Offset_0x0246A4
                move.w  Obj_Respaw_Ref(A0), A1                           ; $0048
                move.w  Obj_Control_Var_02(A1), D0                       ; $0032
                beq.s   Offset_0x0246CC
                tst.b   Obj_Flags(A0)                                    ; $0004
                bmi.s   Offset_0x0246BE
                subq.w  #$01, Obj_Control_Var_00(A1)                     ; $0030
                jmp     (DeleteObject)                         ; Offset_0x011138
Offset_0x0246BE:
                cmp.b   Obj_Col_Flags(A0), D0                            ; $0028
                bcs.s   Offset_0x0246E2
                subi.w  #$0020, Obj_Y(A0)                                ; $0014
                bra.s   Offset_0x0246E2
Offset_0x0246CC:
                move.w  Obj_Y(A0), D0                                    ; $0014
                cmp.w   Obj_Control_Var_16(A0), D0                       ; $0046
                beq.s   Offset_0x0246E2
                addi.w  #$0010, D0
                move.w  D0, Obj_Y(A0)                                    ; $0014
                st      Obj_Control_Var_04(A1)                           ; $0034
Offset_0x0246E2:
                move.b  #$70, Obj_Height(A0)                             ; $0006
                jmp     (DisplaySprite)                        ; Offset_0x011148
;-------------------------------------------------------------------------------  
Title_Card_Level_Name:                                         ; Offset_0x0246EE
                move.b  (Level_Id_2).w, D0                           ; $FFFFEE54
                add.b   D0, Obj_Map_Id(A0)                               ; $0022
                move.l  #Title_Card_Zone, (A0)                 ; Offset_0x0246FC
Title_Card_Zone:                                               ; Offset_0x0246FC                
                move.w  Obj_Respaw_Ref(A0), A1                           ; $0048
                move.w  Obj_Control_Var_02(A1), D0                       ; $0032
                beq.s   Offset_0x024724
                tst.b   Obj_Flags(A0)                                    ; $0004
                bmi.s   Offset_0x024716
                subq.w  #$01, Obj_Control_Var_00(A1)                     ; $0030
                jmp     (DeleteObject)                         ; Offset_0x011138
Offset_0x024716:
                cmp.b   Obj_Col_Flags(A0), D0                            ; $0028
                bcs.s   Offset_0x02473A
                addi.w  #$0020, Obj_X(A0)                                ; $0010
                bra.s   Offset_0x02473A
Offset_0x024724:
                move.w  Obj_X(A0), D0                                    ; $0010
                cmp.w   Obj_Control_Var_16(A0), D0                       ; $0046
                beq.s   Offset_0x02473A
                subi.w  #$0010, D0
                move.w  D0, Obj_X(A0)                                    ; $0010
                st      Obj_Control_Var_04(A1)                           ; $0034
Offset_0x02473A:
                jmp     (DisplaySprite)                        ; Offset_0x011148
;-------------------------------------------------------------------------------
Title_Card_Act_Number:                                         ; Offset_0x024740
                move.l  #Title_Card_Zone, (A0)                 ; Offset_0x0246FC
                move.b  (Level_Id_2).w, D0                           ; $FFFFEE54
                cmpi.b  #$0A, D0
                beq.s   Offset_0x024756
                cmpi.b  #$0C, D0
                bne.s   Title_Card_Zone                        ; Offset_0x0246FC
Offset_0x024756:
                move.w  Obj_Respaw_Ref(A0), A1                           ; $0048
                subq.w  #$01, Obj_Control_Var_00(A1)                     ; $0030
                jmp     (DeleteObject)                         ; Offset_0x011138                                                                                
;-------------------------------------------------------------------------------
Title_Card_Letters_Ptr:                                        ; Offset_0x024764
                dc.l    TC_Angel_Island                        ; Offset_0x13AEF2
                dc.l    TC_Hidrocity                           ; Offset_0x13B004
                dc.l    TC_Marble_Garden                       ; Offset_0x13B156
                dc.l    TC_Carnival_Night                      ; Offset_0x13B318
                dc.l    TC_Flying_Battery                      ; Offset_0x13B4AA
                dc.l    TC_Icecap                              ; Offset_0x13B60C
                dc.l    TC_Launch_Base                         ; Offset_0x13B6DE
                dc.l    TC_Mushroom_Valley                     ; Offset_0x13B6DE
                dc.l    TC_Sandopolis                          ; Offset_0x13B6DE
                dc.l    TC_Lava_Reef                           ; Offset_0x13B6DE
                dc.l    TC_Sky_Sanctuary                       ; Offset_0x13B6DE
                dc.l    TC_Death_Egg                           ; Offset_0x13B6DE
                dc.l    TC_The_Doomsday                        ; Offset_0x13B6DE 
;-------------------------------------------------------------------------------
Title_Cards_Conf_Ptr:                                          ; Offset_0x024798
                dc.l    Title_Card_Level_Name                  ; Offset_0x0246EE
                dc.w    $0120, $0260, $00E0
                dc.b    $04, $80
                dc.w    $0003
                dc.l    Title_Card_Zone                        ; Offset_0x0246FC
                dc.w    $017C, $02FC, $0100
                dc.b    $03, $24
                dc.w    $0005
                dc.l    Title_Card_Act_Number                  ; Offset_0x024740
                dc.w    $0184, $0344, $0120
                dc.b    $02, $1C
                dc.w    $0007
                dc.l    Title_Card_Red_Bar                     ; Offset_0x0246A4
                dc.w    $00C0, $00E0, $0010
                dc.b    $01, $00
                dc.w    $0001                                                   
;-------------------------------------------------------------------------------
; Tela com o nome das fases conhecido também conhecido como: 
; <<<-     - Splash Screen, Title Cards, etc... 
;-------------------------------------------------------------------------------