;===============================================================================
; Objeto 0x34 - Poste de reinício, utilizado para salvar sua posição na fase
; ->>>  
;===============================================================================  
; Offset_0x023F76:
                moveq   #$00, D0
                move.b  Obj_Routine(A0), D0                              ; $0005
                move.w  Offset_0x023F84(PC, D0), D1
                jmp     Offset_0x023F84(PC, D1) 
;-------------------------------------------------------------------------------
Offset_0x023F84:
                dc.w    Offset_0x023F8E-Offset_0x023F84
                dc.w    Offset_0x023FE4-Offset_0x023F84
                dc.w    Offset_0x0240E4-Offset_0x023F84
                dc.w    Offset_0x0240F6-Offset_0x023F84
                dc.w    Offset_0x024372-Offset_0x023F84 
;-------------------------------------------------------------------------------    
Offset_0x023F8E:
                addq.b  #$02, Obj_Routine(A0)                            ; $0005
                move.l  #Star_Post_Mappings, Obj_Map(A0) ; Offset_0x024282, $000C
                move.w  #$05EC, Obj_Art_VRAM(A0)                         ; $000A
                move.b  #$04, Obj_Flags(A0)                              ; $0004
                move.b  #$08, Obj_Width(A0)                              ; $0007
                move.b  #$28, Obj_Height(A0)                             ; $0006
                move.w  #$0280, Obj_Priority(A0)                         ; $0008
                move.w  Obj_Respaw_Ref(A0), A2                           ; $0048
                bclr    #$07, (A2)
                btst    #$00, (A2)
                bne.s   Offset_0x023FDA
                move.b  (Saved_Level_Flag).w, D1                     ; $FFFFFE30
                andi.b  #$7F, D1
                move.b  Obj_Subtype(A0), D2                              ; $002C
                andi.b  #$7F, D2
                cmp.b   D2, D1
                bcs.s   Offset_0x023FE4
Offset_0x023FDA:
                bset    #$00, (A2)
                move.b  #$02, Obj_Ani_Number(A0)                         ; $0020
;-------------------------------------------------------------------------------                
Offset_0x023FE4:
                tst.w   (Debug_Mode_Flag_Index).w                    ; $FFFFFE08
                bne     Offset_0x0240E4
                lea     (Obj_Player_One).w, A3                       ; $FFFFB000
                move.b  (Saved_Level_Flag).w, D1                     ; $FFFFFE30
                bsr.s   Offset_0x02400C
                tst.w   (Two_Player_Flag).w                          ; $FFFFFFD8
                beq     Offset_0x0240E4
                lea     (Obj_Player_Two).w, A3                       ; $FFFFB04A
                move.b  (Saved_Level_Flag_P2).w, D1                  ; $FFFFFEE0
                bsr.s   Offset_0x02400C
                bra     Offset_0x0240E4
Offset_0x02400C:
                andi.b  #$7F, D1
                move.b  Obj_Subtype(A0), D2                              ; $002C
                andi.b  #$7F, D2
                cmp.b   D2, D1
                bcc     Offset_0x0240D6
                move.w  Obj_X(A3), D0                                    ; $0010
                sub.w   Obj_X(A0), D0                                    ; $0010
                addi.w  #$0008, D0
                cmpi.w  #$0010, D0
                bcc     Offset_0x0240D4
                move.w  Obj_Y(A3), D0                                    ; $0014
                sub.w   Obj_Y(A0), D0                                    ; $0014
                addi.w  #$0040, D0
                cmpi.w  #$0068, D0
                bcc     Offset_0x0240D4
                moveq   #Check_Point_Sfx, D0                              ; -$32
                jsr     (Play_Music)                           ; Offset_0x001176
                jsr     (SingleObjectLoad)                     ; Offset_0x011DD8
                bne.s   Offset_0x0240C2
                move.l  #Obj_0x34_Star_Post, (A1)              ; Offset_0x023F76
                move.b  #$06, Obj_Routine(A1)                            ; $0005
                move.w  Obj_X(A0), Obj_Control_Var_00(A1)         ; $0010, $0030
                move.w  Obj_Y(A0), Obj_Control_Var_02(A1)         ; $0014, $0032
                subi.w  #$0014, Obj_Control_Var_02(A1)                   ; $0032
                move.l  Obj_Map(A0), Obj_Map(A1)                  ; $000C, $000C
                move.w  Obj_Art_VRAM(A0), Obj_Art_VRAM(A1)        ; $000A, $000A
                move.b  #$04, Obj_Flags(A1)                              ; $0004
                move.b  #$08, Obj_Width(A1)                              ; $0007
                move.b  #$08, Obj_Height(A1)                             ; $0006
                move.w  #$0200, Obj_Priority(A1)                         ; $0008
                move.b  #$02, Obj_Map_Id(A1)                             ; $0022
                move.w  #$0020, Obj_Control_Var_06(A1)                   ; $0036
                move.w  A0, Obj_Control_Var_0E(A1)                       ; $003E
                tst.w   (Two_Player_Flag).w                          ; $FFFFFFD8
                bne.s   Offset_0x0240C2
                cmpi.b  #$07, (Emeralds_Count).w                     ; $FFFFFFB1
                beq.s   Offset_0x0240C2
                cmpi.w  #$0032, (Ring_Count_Address).w               ; $FFFFFE20
                bcs.s   Offset_0x0240C2
                bsr     Load_Star_Post_Stars                   ; Offset_0x024302
Offset_0x0240C2:
                move.b  #$01, Obj_Ani_Number(A0)                         ; $0020
                bsr     Star_Post_Save_Info                    ; Offset_0x024150
                move.w  Obj_Respaw_Ref(A0), A2                           ; $0048
                bset    #$00, (A2)
Offset_0x0240D4:
                rts
Offset_0x0240D6:
                tst.b   Obj_Ani_Number(A0)                               ; $0020
                bne.s   Offset_0x0240E2
                move.b  #$02, Obj_Ani_Number(A0)                         ; $0020
Offset_0x0240E2:
                rts
;-------------------------------------------------------------------------------                
Offset_0x0240E4:
                lea     (Star_Post_Animate_Data), A1           ; Offset_0x024272
                jsr     (AnimateSprite)                        ; Offset_0x01115E
                jmp     (MarkObjGone)                          ; Offset_0x011AF2  
;-------------------------------------------------------------------------------  
Offset_0x0240F6:
                subq.w  #$01, Obj_Control_Var_06(A0)                     ; $0036
                bpl.s   Offset_0x02411A
                move.w  Obj_Control_Var_0E(A0), A1                       ; $003E
                cmpi.l  #Obj_0x34_Star_Post, (A1)              ; Offset_0x023F76
                bne.s   Offset_0x024114
                move.b  #$02, Obj_Ani_Number(A1)                         ; $0020
                move.b  #$00, Obj_Map_Id(A1)                             ; $0022
Offset_0x024114:
                jmp     (DeleteObject)                         ; Offset_0x011138
Offset_0x02411A:
                move.b  Obj_Angle(A0), D0                                ; $0026
                subi.b  #$10, Obj_Angle(A0)                              ; $0026
                subi.b  #$40, D0
                jsr     (CalcSine)                             ; Offset_0x001B20
                muls.w  #$0C00, D1
                swap.w  D1
                add.w   Obj_Control_Var_00(A0), D1                       ; $0030
                move.w  D1, Obj_X(A0)                                    ; $0010
                muls.w  #$0C00, D0
                swap.w  D0
                add.w   Obj_Control_Var_02(A0), D0                       ; $0032
                move.w  D0, Obj_Y(A0)                                    ; $0014
                jmp     (MarkObjGone)                          ; Offset_0x011AF2  
;-------------------------------------------------------------------------------    
; Rotina para salvar localização atual do jogador. 
; ->>>
;-------------------------------------------------------------------------------  
Star_Post_Save_Info:                                           ; Offset_0x024150
                cmpa.w  #Obj_Player_One, A3                              ; $B000
                bne     Star_Post_Save_Info_P2                 ; Offset_0x0241B4
                move.b  Obj_Subtype(A0), (Saved_Level_Flag).w ; $002C, $FFFFFE30
                move.b  (Saved_Level_Flag).w, (Saved_Last_Start_Post_Hit).w ; $FFFFFE30, $FFFFFE31
                move.w  Obj_X(A0), (Saved_Obj_X_P1).w         ; $0010, $FFFFFE32
                move.w  Obj_Y(A0), (Saved_Obj_Y_P1).w         ; $0014, $FFFFFE34
                move.w  (Obj_Player_One+Obj_Art_VRAM).w, (Saved_Obj_Art_VRAM_P1).w ; $FFFFB00A, $FFFFFE3C
                move.w  (Obj_Player_One+Obj_Player_Top_Solid).w, (Saved_Top_Solid_P1).w ; $FFFFB046, $FFFFFE3E
                move.w  (Ring_Count_Address).w, (Saved_Ring_Count_Address).w ; $FFFFFE20, $FFFFFE36
                move.b  (Ring_Status_Flag).w, (Saved_Ring_Status_Flag).w ; $FFFFFE1B, $FFFFFE54
                move.l  (Time_Count_Address).w, (Saved_Time).w ; $FFFFFE22, $FFFFFE38
                move.b  (Dynamic_Resize_Routine).w, (Saved_Dynamic_Resize_Routine).w ; $FFFFEE33, $FFFFFE58
                move.w  (Sonic_Level_Limits_Max_Y).w, (Saved_Sonic_Level_Limits_Max_Y).w ; $FFFFEE1A, $FFFFFE56
                move.w  (Camera_X).w, (Saved_Camera_X).w  ; $FFFFEE78, $FFFFFE40
                move.w  (Camera_Y).w, (Saved_Camera_Y).w  ; $FFFFEE7C, $FFFFFE42
                move.w  (Current_Water_Level).w, (Saved_Current_Water_Level).w ; $FFFFF648, $FFFFFE50
                move.b  (Underwater_Flag).w, (Saved_Underwater_Flag).w ; $FFFFF64E, $FFFFFE53
                rts
;-------------------------------------------------------------------------------                
Star_Post_Save_Info_P2:                                        ; Offset_0x0241B4
                move.b  Obj_Subtype(A0), (Saved_Level_Flag_P2).w ; $002C, $FFFFFEE0
                move.b  (Saved_Level_Flag_P2).w, (Saved_Last_Start_Post_Hit_P2).w ; $FFFFFEE0, $FFFFFEE1
                move.w  Obj_X(A0), (Saved_Obj_X_P2).w         ; $0010, $FFFFFEE2
                move.w  Obj_Y(A0), (Saved_Obj_Y_P2).w         ; $0014, $FFFFFEE4
                move.w  (Obj_Player_Two+Obj_Art_VRAM).w, (Saved_Obj_Art_VRAM_P2).w ; $FFFFB054, $FFFFFEEC
                move.w  (Obj_Player_Two+Obj_Player_Top_Solid).w, (Saved_Top_Solid_P2).w ; $FFFFB090, $FFFFFEEE
                move.w  (Ring_Count_Address_P2).w, (Saved_Ring_Count_Address_P2).w ; $FFFFFED0, $FFFFFEE6
                move.b  (Ring_Status_Flag_P2).w, (Saved_Ring_Status_Flag_P2).w ; $FFFFFEC7, $FFFFFE55
                move.l  (Time_Count_Address_P2).w, (Saved_Time_Count_Address_P2).w ; $FFFFFED2, $FFFFFEE8
                rts                
;-------------------------------------------------------------------------------    
; Rotina para salvar localização atual do jogador. 
; <<<-
;-------------------------------------------------------------------------------     

;-------------------------------------------------------------------------------   
; Rotina para carregar a última localização salva do jogador. 
; ->>>   Referência externa.  
;-------------------------------------------------------------------------------   
Star_Post_Load_Info:                                           ; Offset_0x0241EC
                move.b  (Saved_Last_Start_Post_Hit).w, (Saved_Level_Flag).w ; $FFFFFE31, $FFFFFE30
                move.w  (Saved_Obj_X_P1).w, (Obj_Player_One+Obj_X).w ; $FFFFFE32, $FFFFB010
                move.w  (Saved_Obj_Y_P1).w, (Obj_Player_One+Obj_Y).w ; $FFFFFE34, $FFFFB014
                move.w  (Saved_Ring_Count_Address).w, (Ring_Count_Address).w ; $FFFFFE36, $FFFFFE20
                move.b  (Saved_Ring_Status_Flag).w, (Ring_Status_Flag).w ; $FFFFFE54, $FFFFFE1B
                clr.w   (Ring_Count_Address).w                       ; $FFFFFE20
                clr.b   (Ring_Status_Flag).w                         ; $FFFFFE1B
                move.l  (Saved_Time).w, (Time_Count_Address).w ; $FFFFFE38, $FFFFFE22
                move.b  #$3B, (Timer_Centiseconds_Count_Address).w   ; $FFFFFE25
                subq.b  #$01, (Timer_Second_Count_Address).w         ; $FFFFFE24
                move.w  (Saved_Obj_Art_VRAM_P1).w, (Obj_Player_One+Obj_Art_VRAM).w ; $FFFFFE3C, $FFFFB00A
                move.w  (Saved_Top_Solid_P1).w, (Obj_Player_One+Obj_Player_Top_Solid).w ; $FFFFFE3E, $FFFFB046
                move.b  (Saved_Dynamic_Resize_Routine).w, (Dynamic_Resize_Routine).w ; $FFFFFE58, $FFFFEE33
                move.w  (Saved_Sonic_Level_Limits_Max_Y).w, (Sonic_Level_Limits_Max_Y).w ; $FFFFFE56, $FFFFEE1A
                move.w  (Saved_Sonic_Level_Limits_Max_Y).w, (Level_Limits_Max_Y).w ; $FFFFFE56, $FFFFEE12
                move.w  (Saved_Camera_X).w, (Camera_X).w  ; $FFFFFE40, $FFFFEE78
                move.w  (Saved_Camera_Y).w, (Camera_Y).w  ; $FFFFFE42, $FFFFEE7C
                tst.b   (Water_Level_Flag).w                         ; $FFFFF730
                beq.s   Offset_0x02425E
                move.w  (Saved_Current_Water_Level).w, (Current_Water_Level).w ; $FFFFFE50, $FFFFF648
                move.b  (Saved_Underwater_Flag).w, (Underwater_Flag).w ; $FFFFFE53, $FFFFF64E
Offset_0x02425E:
                tst.b   (Saved_Level_Flag).w                         ; $FFFFFE30
                bpl.s   Offset_0x024270
                move.w  (Saved_Obj_X_P1).w, D0                       ; $FFFFFE32
                subi.w  #$00A0, D0
                move.w  D0, (Sonic_Level_Limits_Min_X).w             ; $FFFFEE14
Offset_0x024270:
                rts
;-------------------------------------------------------------------------------   
; Rotina para carregar a última localização salva do jogador. 
; <<<-   Referência externa.  
;------------------------------------------------------------------------------- 
Star_Post_Animate_Data:                                        ; Offset_0x024272
                dc.w    Offset_0x024278-Star_Post_Animate_Data
                dc.w    Offset_0x02427B-Star_Post_Animate_Data
                dc.w    Offset_0x02427E-Star_Post_Animate_Data
Offset_0x024278:
                dc.b    $0F, $00, $FF
Offset_0x02427B:
                dc.b    $0F, $01, $FF
Offset_0x02427E:
                dc.b    $03, $00, $04, $FF 
;-------------------------------------------------------------------------------                                                         
Star_Post_Mappings:                                            ; Offset_0x024282
                dc.w    Offset_0x02428C-Star_Post_Mappings
                dc.w    Offset_0x0242A6-Star_Post_Mappings
                dc.w    Offset_0x0242BA-Star_Post_Mappings
                dc.w    Offset_0x0242C2-Star_Post_Mappings
                dc.w    Offset_0x0242CA-Star_Post_Mappings
Offset_0x02428C:
                dc.w    $0004
                dc.w    $E801, $000E, $FFFC
                dc.w    $F803, $0010, $FFF8
                dc.w    $F803, $0810, $0000
                dc.w    $D805, $0006, $FFF8
Offset_0x0242A6:
                dc.w    $0003
                dc.w    $E801, $000E, $FFFC
                dc.w    $F803, $0010, $FFF8
                dc.w    $F803, $0810, $0000
Offset_0x0242BA:
                dc.w    $0001
                dc.w    $F805, $0006, $FFF8
Offset_0x0242C2:
                dc.w    $0001
                dc.w    $F805, $000A, $FFF8
Offset_0x0242CA:
                dc.w    $0004
                dc.w    $E801, $000E, $FFFC
                dc.w    $F803, $0010, $FFF8
                dc.w    $F803, $0810, $0000
                dc.w    $D805, $000A, $FFF8     
;-------------------------------------------------------------------------------
Star_Post_Stars_Mappings:                                      ; Offset_0x0242E4
                dc.w    Offset_0x0242EA-Star_Post_Stars_Mappings
                dc.w    Offset_0x0242F2-Star_Post_Stars_Mappings
                dc.w    Offset_0x0242FA-Star_Post_Stars_Mappings
Offset_0x0242EA:
                dc.w    $0001
                dc.w    $F805, $0000, $FFF8
Offset_0x0242F2:
                dc.w    $0001
                dc.w    $FC00, $0004, $FFFC
Offset_0x0242FA:
                dc.w    $0001
                dc.w    $FC00, $0005, $FFFC  
;-------------------------------------------------------------------------------
Load_Star_Post_Stars:                                          ; Offset_0x024302
                moveq   #$03, D1
                moveq   #$00, D2
Offset_0x024306:
                jsr     (SingleObjectLoad_A0)                  ; Offset_0x011DE0
                bne.s   Offset_0x024370
                move.l  (A0), (A1)
                move.l  #Star_Post_Stars_Mappings, Obj_Map(A1) ; Offset_0x0242E4, $000C
                move.w  #$05EC, Obj_Art_VRAM(A1)                         ; $000A
                move.b  #$04, Obj_Flags(A1)                              ; $0004
                move.b  #$08, Obj_Routine(A1)                            ; $0005
                move.w  Obj_X(A0), D0                                    ; $0010
                move.w  D0, Obj_X(A1)                                    ; $0010
                move.w  D0, Obj_Control_Var_00(A1)                       ; $0030
                move.w  Obj_Y(A0), D0                                    ; $0014
                subi.w  #$0030, D0
                move.w  D0, Obj_Y(A1)                                    ; $0014
                move.w  D0, Obj_Control_Var_02(A1)                       ; $0032
                move.w  Obj_Priority(A0), Obj_Priority(A1)        ; $0008, $0008
                move.b  #$08, Obj_Width(A1)                              ; $0007
                move.b  #$01, Obj_Map_Id(A1)                             ; $0022
                move.w  #$FC00, Obj_Speed_X(A1)                          ; $0018
                move.w  #$0000, Obj_Speed_Y(A1)                          ; $001A
                move.w  D2, Obj_Control_Var_04(A1)                       ; $0034
                addi.w  #$0040, D2
                dbra    D1, Offset_0x024306
Offset_0x024370:
                rts  
;-------------------------------------------------------------------------------
Offset_0x024372:
                move.b  Obj_Col_Prop(A0), D0                             ; $0029
                beq     Offset_0x024390
                andi.b  #$01, D0
                beq.s   Offset_0x02438C
                move.b  #$01, (Special_Stage_Entry_Flag).w           ; $FFFFF7CD
                move.b  #gm_S2_SpecialStage, (Game_Mode).w      ; $10, $FFFFF600
Offset_0x02438C:
                clr.b   Obj_Col_Prop(A0)                                 ; $0029
Offset_0x024390:
                addi.w  #$000A, Obj_Control_Var_04(A0)                   ; $0034
                move.w  Obj_Control_Var_04(A0), D0                       ; $0034
                andi.w  #$00FF, D0
                jsr     (CalcSine)                             ; Offset_0x001B20
                asr.w   #$05, D0
                asr.w   #$03, D1
                move.w  D1, D3
                move.w  Obj_Control_Var_04(A0), D2                       ; $0034
                andi.w  #$03E0, D2
                lsr.w   #$05, D2
                moveq   #$02, D5
                moveq   #$00, D4
                cmpi.w  #$0010, D2
                ble.s   Offset_0x0243C0
                neg.w   D1
Offset_0x0243C0:
                andi.w  #$000F, D2
                cmpi.w  #$0008, D2
                ble.s   Offset_0x0243D0
                neg.w   D2
                andi.w  #$0007, D2
Offset_0x0243D0:
                lsr.w   #$01, D2
                beq.s   Offset_0x0243D6
                add.w   D1, D4
Offset_0x0243D6:
                asl.w   #$01, D1
                dbra    D5, Offset_0x0243D0
                asr.w   #$04, D4
                add.w   D4, D0
                addq.w  #$01, Obj_Control_Var_06(A0)                     ; $0036
                move.w  Obj_Control_Var_06(A0), D1                       ; $0036
                cmpi.w  #$0080, D1
                beq.s   Offset_0x0243FA
                bgt.s   Offset_0x024400
Offset_0x0243F0:
                muls.w  D1, D0
                muls.w  D1, D3
                asr.w   #$07, D0
                asr.w   #$07, D3
                bra.s   Offset_0x024412
Offset_0x0243FA:
                move.b  #$D8, Obj_Col_Flags(A0)                          ; $0028
Offset_0x024400:
                cmpi.w  #$0180, D1
                ble.s   Offset_0x024412
                neg.w   D1
                addi.w  #$0200, D1
                bmi     Offset_0x024446
                bra.s   Offset_0x0243F0
Offset_0x024412:
                move.w  Obj_Control_Var_00(A0), D2                       ; $0030
                add.w   D3, D2
                move.w  D2, Obj_X(A0)                                    ; $0010
                move.w  Obj_Control_Var_02(A0), D2                       ; $0032
                add.w   D0, D2
                move.w  D2, Obj_Y(A0)                                    ; $0014
                addq.b  #$01, Obj_Ani_Frame(A0)                          ; $0023
                move.b  Obj_Ani_Frame(A0), D0                            ; $0023
                andi.w  #$0006, D0
                lsr.w   #$01, D0
                cmpi.b  #$03, D0
                bne.s   Offset_0x02443C
                moveq   #$01, D0
Offset_0x02443C:
                move.b  D0, Obj_Map_Id(A0)                               ; $0022
                jmp     (MarkObjGone)                          ; Offset_0x011AF2
Offset_0x024446:
                jmp     (DeleteObject)                         ; Offset_0x011138                                                                                                                                                                                      
;===============================================================================
; Objeto 0x34 - Poste de reinício, utilizado para salvar sua posição na fase
; <<<-  
;===============================================================================  