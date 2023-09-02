;===============================================================================
; Objeto Sonic
; ->>>  
;===============================================================================
; Offset_0x00AA36:
                lea     (Sonic_Max_Speed).w, A4                      ; $FFFFF760
                lea     (Distance_From_Top).w, A5                    ; $FFFFEE2C
                lea     (Obj_P1_Dust_Water_Splash).w, A6             ; $FFFFCC54
                tst.w   (Debug_Mode_Flag_Index).w                    ; $FFFFFE08
                beq.s   Offset_0x00AA4E
                jmp     (Debug_Mode)                           ; Offset_0x04B1B2
Offset_0x00AA4E:
                moveq   #$00, D0
                move.b  Obj_Routine(A0), D0                              ; $0005
                move.w  Sonic_Index(PC, D0), D1                ; Offset_0x00AA5C
                jmp     Sonic_Index(PC, D1)                    ; Offset_0x00AA5C
;-------------------------------------------------------------------------------
Sonic_Index:                                                   ; Offset_0x00AA5C
                dc.w    Sonic_Main-Sonic_Index                 ; Offset_0x00AA68
                dc.w    Sonic_Control-Sonic_Index              ; Offset_0x00AB24
                dc.w    Sonic_Hurt-Sonic_Index                 ; Offset_0x00C03E
                dc.w    Sonic_Death-Sonic_Index                ; Offset_0x00C0F4
                dc.w    Sonic_ResetLevel-Sonic_Index           ; Offset_0x00C29C
                dc.w    Sonic_Animate-Sonic_Index              ; Offset_0x00C2B0
;-------------------------------------------------------------------------------
Sonic_Main:                                                    ; Offset_0x00AA68  
                addq.b  #$02, Obj_Routine(A0)                            ; $0005
                move.b  #$13, Obj_Height_2(A0)                           ; $001E
                move.b  #$09, Obj_Width_2(A0)                            ; $001F
                move.b  #$13, Obj_Height_3(A0)                           ; $0044
                move.b  #$09, Obj_Width_3(A0)                            ; $0045
                move.l  #Sonic_Mappings, Obj_Map(A0)     ; Offset_0x100000,$000C
                move.w  #$0100, Obj_Priority(A0)                         ; $0008
                move.b  #$18, Obj_Width(A0)                              ; $0007
                move.b  #$18, Obj_Height(A0)                             ; $0006
                move.b  #$04, Obj_Flags(A0)                              ; $0004
                move.b  #$00, Obj_Player_Selected(A0)                    ; $0038
                move.w  #$0600, (A4)
                move.w  #$000C, Acceleration(A4)                         ; $0002
                move.w  #$0080, Deceleration(A4)                         ; $0004       
                tst.b   (Saved_Level_Flag).w                         ; $FFFFFE30
                bne.s   Offset_0x00AAEA
                move.w  #$0680, Obj_Art_VRAM(A0)                         ; $000A
                move.b  #$0C, Obj_Player_Top_Solid(A0)                   ; $0046
                move.b  #$0D, Obj_Player_LRB_Solid(A0)                   ; $0047
                move.w  Obj_X(A0), (Saved_Obj_X_P1).w                ; $FFFFFE32; $0010
                move.w  Obj_Y(A0), (Saved_Obj_Y_P1).w                ; $FFFFFE34; $0014
                move.w  Obj_Art_VRAM(A0), (Saved_Obj_Art_VRAM_P1).w         ; $FFFFFE3C; $000A
                move.w  Obj_Player_Top_Solid(A0), (Saved_Top_Solid_P1).w            ; $FFFFFE3E; $0046
Offset_0x00AAEA:
                move.b  #$00, Obj_P_Flips_Remaining(A0)                  ; $0030
                move.b  #$04, Obj_Player_Flip_Speed(A0)                  ; $0031
                move.b  #$00, (Super_Sonic_Flag).w                   ; $FFFFFE19
                move.b  #$1E, Obj_Subtype(A0)                            ; $002C
                subi.w  #$0020, Obj_X(A0)                                ; $0010
                addi.w  #$0004, Obj_Y(A0)                                ; $0014
                bsr     Reset_Player_Position_Array            ; Offset_0x00ACEC
                addi.w  #$0020, Obj_X(A0)                                ; $0010
                subi.w  #$0004, Obj_Y(A0)                                ; $0014
                move.w  #$0000, (CopySonicMovesForMilesIndex).w      ; $FFFFFE5A
;-------------------------------------------------------------------------------
Sonic_Control:                                                 ; Offset_0x00AB24                
                tst.w   (Debug_Mode_Active).w                        ; $FFFFFFFA
                beq.s   Offset_0x00AB3E
                btst    #$04, (Control_Ports_Buffer_Data+$0001).w    ; $FFFFF605
                beq.s   Offset_0x00AB3E
                move.w  #$0001, (Debug_Mode_Flag_Index).w            ; $FFFFFE08
                clr.b   (Control_Locked_Flag_P1).w                   ; $FFFFF7CC
                rts
Offset_0x00AB3E:
                tst.b   (Control_Locked_Flag_P1).w                   ; $FFFFF7CC
                bne.s   Offset_0x00AB4A
                move.w  (Control_Ports_Buffer_Data).w, (Control_Ports_Logical_Data).w ; $FFFFF604
Offset_0x00AB4A:
                btst    #$00, Obj_Player_Control(A0)                     ; $002E
                bne.s   Offset_0x00AB6C
                movem.l A4-A6, -(A7)
                moveq   #$00, D0
                move.b  Obj_Status(A0), D0                               ; $002A
                andi.w  #$0006, D0
                move.w  Sonic_Modes(PC, D0), D1                ; Offset_0x00ABCA
                jsr     Sonic_Modes(PC, D1)                    ; Offset_0x00ABCA
                movem.l (A7)+, A4-A6
Offset_0x00AB6C:
                cmpi.w  #$FF00, (Sonic_Level_Limits_Min_Y).w         ; $FFFFEE18
                bne.s   Offset_0x00AB7C
                move.w  (Screen_Wrap_Y).w, D0                        ; $FFFFEEAA
                and.w   D0, Obj_Y(A0)                                    ; $0014
Offset_0x00AB7C:
                bsr.s   Sonic_Display                          ; Offset_0x00ABD2
                bsr     Offset_0x00BA46
                bsr     CopySonicMovesForMiles                 ; Offset_0x00ACA2
                bsr     Sonic_Water                            ; Offset_0x00AD34
                move.b  (Primary_Angle).w, Obj_Player_Next_Tilt(A0)  ; $FFFFF768, $003A
                move.b  (Secondary_Angle).w, Obj_Player_Tilt(A0) ; $FFFFF76A, $003B
                tst.b   (Sonic_Wind_Flag).w                          ; $FFFFF7C8
                beq.s   Offset_0x00ABA8
                tst.b   Obj_Ani_Number(A0)                               ; $0020
                bne.s   Offset_0x00ABA8
                move.b  Obj_Ani_Flag(A0), Obj_Ani_Number(A0)      ; $0020, $0021
Offset_0x00ABA8:
                btst    #$01, Obj_Player_Control(A0)                     ; $002E
                bne.s   Offset_0x00ABB8
                bsr     Sonic_Animate_2                        ; Offset_0x00C2E0
                bsr     Load_Sonic_Dynamic_PLC                 ; Offset_0x00C7EA
Offset_0x00ABB8:
                move.b  Obj_Player_Control(A0), D0                       ; $002E
                andi.b  #$A0, D0
                bne.s   Offset_0x00ABC8
                jsr     (Touch_Response)                       ; Offset_0x00A188
Offset_0x00ABC8:
                rts    
;-------------------------------------------------------------------------------
Sonic_Modes:                                                   ; Offset_0x00ABCA
                dc.w    Sonic_MdNormal-Sonic_Modes             ; Offset_0x00AE32
                dc.w    Sonic_MdJump-Sonic_Modes               ; Offset_0x00AEB8
                dc.w    Sonic_MdRoll-Sonic_Modes               ; Offset_0x00AEE2
                dc.w    Sonic_MdJump2-Sonic_Modes              ; Offset_0x00AF18
;-------------------------------------------------------------------------------                
Sonic_Display:                                                 ; Offset_0x00ABD2
                move.b  Obj_P_Invunerblt_Time(A0), D0                    ; $0034
                beq.s   Offset_0x00ABE0
                subq.b  #$01, Obj_P_Invunerblt_Time(A0)                  ; $0034
                lsr.b   #$03, D0
                bcc.s   Offset_0x00ABE6
Offset_0x00ABE0:
                jsr     (DisplaySprite)                        ; Offset_0x011148
Offset_0x00ABE6:
                btst    #$01, Obj_Player_Status(A0)                      ; $002F
                beq.s   Offset_0x00AC22
                tst.b   Obj_P_Invcbility_Time(A0)                        ; $0035
                beq.s   Offset_0x00AC22
                move.b  (Level_Frame_Count+$01).w, D0                ; $FFFFFE05
                andi.b  #$07, D0
                bne.s   Offset_0x00AC22
                subq.b  #$01, Obj_P_Invcbility_Time(A0)                  ; $0035
                bne.s   Offset_0x00AC22
                tst.b   (Boss_Flag).w                                ; $FFFFF7AA
                bne.s   Offset_0x00AC1C
                cmpi.b  #$0C, Obj_Subtype(A0)                            ; $002C
                bcs.s   Offset_0x00AC1C
                move.w  (Level_Music_Buffer).w, D0                   ; $FFFFFF90
                jsr     (Play_Music)                           ; Offset_0x001176
Offset_0x00AC1C:
                bclr    #$01, Obj_Player_Status(A0)                      ; $002F
Offset_0x00AC22:
                btst    #$02, Obj_Player_Status(A0)                      ; $002F
                beq.s   Offset_0x00AC7C
                tst.b   Obj_P_Spd_Shoes_Time(A0)                         ; $0036
                beq.s   Offset_0x00AC7C
                move.b  (Level_Frame_Count+$01).w, D0                ; $FFFFFE05
                andi.b  #$07, D0
                bne.s   Offset_0x00AC7C
                subq.b  #$01, Obj_P_Spd_Shoes_Time(A0)                   ; $0036
                bne.s   Offset_0x00AC7C
                tst.w   (Two_Player_Flag).w                          ; $FFFFFFD8
                bne.s   Offset_0x00AC7E
                move.w  #$0600, (A4)
                move.w  #$000C, Acceleration(A4)                         ; $0002
                move.w  #$0080, Deceleration(A4)                         ; $0004
                tst.b   (Super_Sonic_Flag).w                         ; $FFFFFE19
                beq.s   Offset_0x00AC6C
                move.w  #$0A00, (A4)
                move.w  #$0030, Acceleration(A4)                         ; $0002
                move.w  #$0100, Deceleration(A4)                         ; $0004
Offset_0x00AC6C:
                bclr    #$02, Obj_Player_Status(A0)                      ; $002F
                move.w  #Music_Normal_Speed, D0                          ; $00FC
                jmp     (Play_Music)                           ; Offset_0x001176
Offset_0x00AC7C:
                rts
Offset_0x00AC7E:
                lea     (Player_Start_Speed_Array), A1         ; Offset_0x1F7000
                moveq   #$00, D0
                move.b  Obj_Player_Selected(A0), D0                      ; $0038
                lsl.w   #$03, D0
                lea     $00(A1, D0), A1
                move.w  (A1)+, (A4)
                move.w  (A1)+, Acceleration(A4)                          ; $0002
                move.w  (A1)+, Deceleration(A4)                          ; $0004
                bclr    #$02, Obj_Player_Status(A0)                      ; $002F
                rts 
;-------------------------------------------------------------------------------
CopySonicMovesForMiles:                                        ; Offset_0x00ACA2
                cmpa.w  #Obj_Player_One, A0                              ; $B000
                bne.s   Offset_0x00ACD2
                move.w  (Position_Table_Index).w, D0                 ; $FFFFEE26
                lea     (Position_Table_Data).w, A1                  ; $FFFFE500
                lea     $00(A1, D0), A1
                move.w  Obj_X(A0), (A1)+                                 ; $0010
                move.w  Obj_Y(A0), (A1)+                                 ; $0014
                addq.b  #$04, (Position_Table_Index+$01).w           ; $FFFFEE27
                lea     (Status_Table_Data).w, A1                    ; $FFFFE400
                lea     $00(A1, D0), A1
                move.w  (Control_Ports_Logical_Data).w, (A1)+        ; $FFFFF602
                move.w  Obj_Status(A0), (A1)+                            ; $002A
                rts
Offset_0x00ACD2:
                move.w  (Position_Table_Index_2P).w, D0              ; $FFFFEE2A
                lea     (Position_Table_Data_P2).w, A1               ; $FFFFE600
                lea     $00(A1, D0), A1
                move.w  Obj_X(A0), (A1)+                                 ; $0010
                move.w  Obj_Y(A0), (A1)+                                 ; $0014
                addq.b  #$04, (Position_Table_Index_2P+$01).w        ; $FFFFEE2B
                rts 
;-------------------------------------------------------------------------------
Reset_Player_Position_Array:                                   ; Offset_0x00ACEC
                cmpa.w  #Obj_Player_One, A0                              ; $B000
                bne.s   Reset_Player_Position_Array_P2         ; Offset_0x00AD18
                lea     (Position_Table_Data).w, A1                  ; $FFFFE500
                lea     (Status_Table_Data).w, A2                    ; $FFFFE400
                move.w  #$003F, D0
Offset_0x00ACFE:
                move.w  Obj_X(A0), (A1)+                                 ; $0010
                move.w  Obj_Y(A0), (A1)+                                 ; $0014
                move.l  #$00000000, (A2)+
                dbra    D0, Offset_0x00ACFE
                move.w  #$0000, (Position_Table_Index).w             ; $FFFFEE26
                rts
Reset_Player_Position_Array_P2:                                ; Offset_0x00AD18
                lea     (Position_Table_Data_P2).w, A1               ; $FFFFE600
                move.w  #$003F, D0
Offset_0x00AD20:
                move.w  Obj_X(A0), (A1)+                                 ; $0010
                move.w  Obj_Y(A0), (A1)+                                 ; $0014
                dbra    D0, Offset_0x00AD20
                move.w  #$0000, (Position_Table_Index_2P).w          ; $FFFFEE2A
                rts
;-------------------------------------------------------------------------------
Sonic_Water:                                                   ; Offset_0x00AD34
                tst.b   (Water_Level_Flag).w                         ; $FFFFF730
                bne.s   Sonic_InLevelWithWater                 ; Offset_0x00AD3C
Offset_0x00AD3A:
                rts
;-------------------------------------------------------------------------------                
Sonic_InLevelWithWater:                                        ; Offset_0x00AD3C
                move.w  (Water_Level_Move).w, D0                     ; $FFFFF646
                cmp.w   Obj_Y(A0), D0                                    ; $0014
                bge.s   Sonic_NotInWater                       ; Offset_0x00ADAE
                bset    #$06, Obj_Status(A0)                             ; $002A
                bne.s   Offset_0x00AD3A
                addq.b  #$01, (Water_Entered_Counter).w              ; $FFFFF64D
                move.l  A0, A1
                bsr     Resume_Music                           ; Offset_0x00F89E
                move.l  #Obj_Player_Underwater, (Obj_P1_Underwater_Control).w  ; Offset_0x00F38C, $FFFFCB2C
                move.b  #$81, (Obj_P1_Underwater_Control+Obj_Subtype).w ; $FFFFCB58
                move.l  A0, (Obj_P1_Underwater_Control+$0040).w      ; $FFFFCB6C
                move.w  #$0300, (A4)
                move.w  #$0006, Acceleration(A4)                         ; $0002
                move.w  #$0040, Deceleration(A4)                         ; $0004
                tst.b   (Super_Sonic_Flag).w                         ; $FFFFFE19
                beq.s   Offset_0x00AD90
                move.w  #$0500, (A4)
                move.w  #$0018, Acceleration(A4)                         ; $0002
                move.w  #$0080, Deceleration(A4)                         ; $0004
Offset_0x00AD90:
                asr.w   Obj_Speed_X(A0)                                  ; $0018
                asr.w   Obj_Speed_Y(A0)                                  ; $001A
                asr.w   Obj_Speed_Y(A0)                                  ; $001A
                beq.s   Offset_0x00AD3A
                move.w  #$0100, Obj_Ani_Number(A6)                       ; $0020
                move.w  #Water_Splash_Sfx, D0                            ; $0039
                jmp     (Play_Music)                           ; Offset_0x001176
;-------------------------------------------------------------------------------
Sonic_NotInWater:                                              ; Offset_0x00ADAE
                bclr    #$06, Obj_Status(A0)                             ; $002A
                beq.s   Offset_0x00AD3A
                addq.b  #$01, (Water_Entered_Counter).w              ; $FFFFF64D
                move.l  A0, A1
                bsr     Resume_Music                           ; Offset_0x00F89E
                move.w  #$0600, (A4)
                move.w  #$000C, Acceleration(A4)                         ; $0002
                move.w  #$0080, Deceleration(A4)                         ; $0004
                tst.b   (Super_Sonic_Flag).w                         ; $FFFFFE19
                beq.s   Offset_0x00ADE6
                move.w  #$0A00, (A4)
                move.w  #$0030, Acceleration(A4)                         ; $0002
                move.w  #$0100, Deceleration(A4)                         ; $0004
Offset_0x00ADE6:
                cmpi.b  #$04, Obj_Routine(A0)                            ; $0005
                beq.s   Offset_0x00ADFC
                move.w  Obj_Speed_Y(A0), D0                              ; $001A
                cmpi.w  #$FC00, D0
                blt.s   Offset_0x00ADFC
                asl.w   Obj_Speed_Y(A0)                                  ; $001A
Offset_0x00ADFC:
                cmpi.b  #$1C, Obj_Ani_Number(A0)                         ; $0020
                beq     Offset_0x00AD3A
                tst.w   Obj_Speed_Y(A0)                                  ; $001A
                beq     Offset_0x00AD3A
                move.w  #$0100, Obj_Ani_Number(A6)                       ; $0020
                move.l  A0, A1
                bsr     Resume_Music                           ; Offset_0x00F89E
                cmpi.w  #$F000, Obj_Speed_Y(A0)                          ; $001A
                bgt.s   Offset_0x00AE28
                move.w  #$F000, Obj_Speed_Y(A0)                          ; $001A
Offset_0x00AE28:
                move.w  #Water_Splash_Sfx, D0                            ; $0039
                jmp     (Play_Music)                           ; Offset_0x001176 
;-------------------------------------------------------------------------------
Sonic_MdNormal:                                                ; Offset_0x00AE32
                move.b  (Control_Ports_Logical_Data+$001).w, D0      ; $FFFFF603
                andi.b  #$70, D0
                bne.s   Offset_0x00AE80
                cmpi.b  #$0A, Obj_Ani_Number(A0)                         ; $0020
                beq.s   Offset_0x00AEB6
                cmpi.b  #$0B, Obj_Ani_Number(A0)                         ; $0020
                beq.s   Offset_0x00AEB6
                cmpi.b  #$05, Obj_Ani_Number(A0)                         ; $0020
                bne.s   Offset_0x00AE80
                cmpi.b  #$1E, Obj_Ani_Frame(A0)                          ; $0023
                bcs.s   Offset_0x00AE80
                bsr     Sonic_SlopeResist                      ; Offset_0x00BC36
                move.b  (Control_Ports_Logical_Data).w, D0           ; $FFFFF602
                andi.b  #$7F, D0
                beq.s   Offset_0x00AE9E
                move.b  #$0A, Obj_Ani_Number(A0)                         ; $0020
                cmpi.b  #$AC, Obj_Ani_Frame(A0)                          ; $0023
                bcs.s   Offset_0x00AE9E
                move.b  #$0B, Obj_Ani_Number(A0)                         ; $0020
                bra.s   Offset_0x00AE9E
Offset_0x00AE80:
                bsr     Sonic_Spindash                         ; Offset_0x00BADA
                bsr     Sonic_Jump                             ; Offset_0x00B61C
                bsr     Sonic_SlopeResist                      ; Offset_0x00BC36
                bsr     Sonic_Move                             ; Offset_0x00AF42
                bsr     Sonic_Roll                             ; Offset_0x00B5B6
                bsr     Sonic_LevelBoundaries                  ; Offset_0x00B560
                jsr     (SpeedToPos)                           ; Offset_0x01111E
Offset_0x00AE9E:
                bsr     Player_AnglePos                        ; Offset_0x009144
                bsr     Sonic_SlopeRepel                       ; Offset_0x00BCBA
                tst.b   (Background_Collision_Flag).w                ; $FFFFF664
                beq.s   Offset_0x00AEB6
                bsr     Offset_0x009C92
                tst.w   D1
                bmi     Kill_Player                            ; Offset_0x00A4A4
Offset_0x00AEB6:
                rts 
;-------------------------------------------------------------------------------
Sonic_MdJump:                                                  ; Offset_0x00AEB8
                bsr     Sonic_JumpHeight                       ; Offset_0x00B6FA
                bsr     Sonic_ChgJumpDir                       ; Offset_0x00B4D0
                bsr     Sonic_LevelBoundaries                  ; Offset_0x00B560
                jsr     (ObjectFall)                           ; Offset_0x0110FE
                btst    #$06, Obj_Status(A0)                             ; $002A
                beq.s   Offset_0x00AED8
                subi.w  #$0028, Obj_Speed_Y(A0)                          ; $001A
Offset_0x00AED8:
                bsr     Sonic_JumpAngle                        ; Offset_0x00BD1C
                bsr     Sonic_Floor                            ; Offset_0x00BD7C
                rts 
;-------------------------------------------------------------------------------    
Sonic_MdRoll:                                                  ; Offset_0x00AEE2
                tst.b   Obj_Player_Spdsh_Flag(A0)                        ; $003D
                bne.s   Offset_0x00AEEC
                bsr     Sonic_Jump                             ; Offset_0x00B61C
Offset_0x00AEEC:
                bsr     Sonic_RollRepel                        ; Offset_0x00BC7E
                bsr     Sonic_RollSpeed                        ; Offset_0x00B3AC
                bsr     Sonic_LevelBoundaries                  ; Offset_0x00B560
                jsr     (SpeedToPos)                           ; Offset_0x01111E
                bsr     Player_AnglePos                        ; Offset_0x009144
                bsr     Sonic_SlopeRepel                       ; Offset_0x00BCBA
                tst.b   (Background_Collision_Flag).w                ; $FFFFF664
                beq.s   Offset_0x00AF16
                bsr     Offset_0x009C92
                tst.w   D1
                bmi     Kill_Player                            ; Offset_0x00A4A4
Offset_0x00AF16:
                rts 
;-------------------------------------------------------------------------------      
Sonic_MdJump2:                                                 ; Offset_0x00AF18
                bsr     Sonic_JumpHeight                       ; Offset_0x00B6FA
                bsr     Sonic_ChgJumpDir                       ; Offset_0x00B4D0
                bsr     Sonic_LevelBoundaries                  ; Offset_0x00B560
                jsr     (ObjectFall)                           ; Offset_0x0110FE
                btst    #$06, Obj_Status(A0)                             ; $002A
                beq.s   Offset_0x00AF38
                subi.w  #$0028, Obj_Speed_Y(A0)                          ; $001A
Offset_0x00AF38:
                bsr     Sonic_JumpAngle                        ; Offset_0x00BD1C
                bsr     Sonic_Floor                            ; Offset_0x00BD7C
                rts 
;-------------------------------------------------------------------------------  
Sonic_Move:                                                    ; Offset_0x00AF42
                move.w  (A4), D6
                move.w  Acceleration(A4), D5                             ; $0002
                move.w  Deceleration(A4), D4                             ; $0004
                tst.b   Obj_Player_Status(A0)                            ; $002F
                bmi     Offset_0x00B1FC
                tst.w   Obj_P_Horiz_Ctrl_Lock(A0)                        ; $0032
                bne     Offset_0x00B1B2
                btst    #$02, (Control_Ports_Logical_Data).w         ; $FFFFF602
                beq.s   Offset_0x00AF68
                bsr     Offset_0x00B2A6
Offset_0x00AF68:
                btst    #$03, (Control_Ports_Logical_Data).w         ; $FFFFF602
                beq.s   Offset_0x00AF74
                bsr     Offset_0x00B32C
Offset_0x00AF74:
                move.b  Obj_Angle(A0), D0                                ; $0026
                addi.b  #$20, D0
                andi.b  #$C0, D0
                bne     Offset_0x00B1B2
                tst.w   Obj_Inertia(A0)                                  ; $001C
                bne     Offset_0x00B1B2
                bclr    #$05, Obj_Status(A0)                             ; $002A
                move.b  #$05, Obj_Ani_Number(A0)                         ; $0020
                btst    #$03, Obj_Status(A0)                             ; $002A
                beq     Offset_0x00B066
                move.w  Obj_Player_Last(A0), A1                          ; $0042
                tst.b   Obj_Status(A1)                                   ; $002A
                bmi     Offset_0x00B15E
                moveq   #$00, D1
                move.b  Obj_Width(A1), D1                                ; $0007
                move.w  D1, D2
                add.w   D2, D2
                subq.w  #$02, D2
                add.w   Obj_X(A0), D1                                    ; $0010
                sub.w   Obj_X(A1), D1                                    ; $0010
                tst.b   (Super_Sonic_Flag).w                         ; $FFFFFE19
                bne     Offset_0x00AFD8
                cmpi.w  #$0002, D1
                blt.s   Offset_0x00B028
                cmp.w   D2, D1
                bge.s   Offset_0x00AFEA
                bra     Offset_0x00B15E
Offset_0x00AFD8:
                cmpi.w  #$0002, D1
                blt     Offset_0x00B150
                cmp.w   D2, D1
                bge     Offset_0x00B140
                bra     Offset_0x00B15E
Offset_0x00AFEA:
                btst    #$00, Obj_Status(A0)                             ; $002A
                bne.s   Offset_0x00B00A
                move.b  #$06, Obj_Ani_Number(A0)                         ; $0020
                addq.w  #$06, D2
                cmp.w   D2, D1
                blt     Offset_0x00B1B2
                move.b  #$0C, Obj_Ani_Number(A0)                         ; $0020
                bra     Offset_0x00B1B2
Offset_0x00B00A:
                move.b  #$1D, Obj_Ani_Number(A0)                         ; $0020
                addq.w  #$06, D2
                cmp.w   D2, D1
                blt     Offset_0x00B1B2
                move.b  #$1E, Obj_Ani_Number(A0)                         ; $0020
                bclr    #$00, Obj_Status(A0)                             ; $002A
                bra     Offset_0x00B1B2
Offset_0x00B028:
                btst    #$00, Obj_Status(A0)                             ; $002A
                beq.s   Offset_0x00B048
                move.b  #$06, Obj_Ani_Number(A0)                         ; $0020
                cmpi.w  #$FFFC, D1
                bge     Offset_0x00B1B2
                move.b  #$0C, Obj_Ani_Number(A0)                         ; $0020
                bra     Offset_0x00B1B2
Offset_0x00B048:
                move.b  #$1D, Obj_Ani_Number(A0)                         ; $0020
                cmpi.w  #$FFFC, D1
                bge     Offset_0x00B1B2
                move.b  #$1E, Obj_Ani_Number(A0)                         ; $0020
                bset    #$00, Obj_Status(A0)                             ; $002A
                bra     Offset_0x00B1B2
Offset_0x00B066:
                jsr     (Player_HitFloor)                      ; Offset_0x009CE0
                cmpi.w  #$000C, D1
                blt     Offset_0x00B15E
                tst.b   (Super_Sonic_Flag).w                         ; $FFFFFE19
                bne     Offset_0x00B138
                cmpi.b  #$03, Obj_Player_Next_Tilt(A0)                   ; $003A
                bne.s   Offset_0x00B0DA
                btst    #$00, Obj_Status(A0)                             ; $002A
                bne.s   Offset_0x00B0B0
                move.b  #$06, Obj_Ani_Number(A0)                         ; $0020
                move.w  Obj_X(A0), D3                                    ; $0010
                subq.w  #$06, D3
                jsr     (Player_HitFloor_D3)                   ; Offset_0x009CE4
                cmpi.w  #$000C, D1
                blt     Offset_0x00B1B2
                move.b  #$0C, Obj_Ani_Number(A0)                         ; $0020
                bra     Offset_0x00B1B2
Offset_0x00B0B0:
                move.b  #$1D, Obj_Ani_Number(A0)                         ; $0020
                move.w  Obj_X(A0), D3                                    ; $0010
                subq.w  #$06, D3
                jsr     (Player_HitFloor_D3)                   ; Offset_0x009CE4
                cmpi.w  #$000C, D1
                blt     Offset_0x00B1B2
                move.b  #$1E, Obj_Ani_Number(A0)                         ; $0020
                bclr    #$00, Obj_Status(A0)                             ; $002A
                bra     Offset_0x00B1B2
Offset_0x00B0DA:
                cmpi.b  #$03, Obj_Player_Tilt(A0)                        ; $003B
                bne.s   Offset_0x00B15E
                btst    #$00, Obj_Status(A0)                             ; $002A
                beq.s   Offset_0x00B10E
                move.b  #$06, Obj_Ani_Number(A0)                         ; $0020
                move.w  Obj_X(A0), D3                                    ; $0010
                addq.w  #$06, D3
                jsr     (Player_HitFloor_D3)                   ; Offset_0x009CE4
                cmpi.w  #$000C, D1
                blt     Offset_0x00B1B2
                move.b  #$0C, Obj_Ani_Number(A0)                         ; $0020
                bra     Offset_0x00B1B2
Offset_0x00B10E:
                move.b  #$1D, Obj_Ani_Number(A0)                         ; $0020
                move.w  Obj_X(A0), D3                                    ; $0010
                addq.w  #$06, D3
                jsr     (Player_HitFloor_D3)                   ; Offset_0x009CE4
                cmpi.w  #$000C, D1
                blt     Offset_0x00B1B2
                move.b  #$1E, Obj_Ani_Number(A0)                         ; $0020
                bset    #$00, Obj_Status(A0)                             ; $002A
                bra     Offset_0x00B1B2
Offset_0x00B138:
                cmpi.b  #$03, Obj_Player_Next_Tilt(A0)                   ; $003A
                bne.s   Offset_0x00B148
Offset_0x00B140:
                bclr    #$00, Obj_Status(A0)                             ; $002A
                bra.s   Offset_0x00B156
Offset_0x00B148:
                cmpi.b  #$03, Obj_Player_Tilt(A0)                        ; $003B
                bne.s   Offset_0x00B15E
Offset_0x00B150:
                bset    #$00, Obj_Status(A0)                             ; $002A
Offset_0x00B156:
                move.b  #$06, Obj_Ani_Number(A0)                         ; $0020
                bra.s   Offset_0x00B1B2
Offset_0x00B15E:
                btst    #$00, (Control_Ports_Logical_Data).w         ; $FFFFF602
                beq.s   Offset_0x00B188
                move.b  #$07, Obj_Ani_Number(A0)                         ; $0020
                addq.b  #$01, Obj_Look_Up_Down_Time(A0)                  ; $0039
                cmpi.b  #$78, Obj_Look_Up_Down_Time(A0)                  ; $0039
                bcs.s   Offset_0x00B1B8
                move.b  #$78, Obj_Look_Up_Down_Time(A0)                  ; $0039
                cmpi.w  #$00C8, (A5)
                beq.s   Offset_0x00B1C4
                addq.w  #$02, (A5)
                bra.s   Offset_0x00B1C4
Offset_0x00B188:
                btst    #$01, (Control_Ports_Logical_Data).w         ; $FFFFF602
                beq.s   Offset_0x00B1B2
                move.b  #$08, Obj_Ani_Number(A0)                         ; $0020
                addq.b  #$01, Obj_Look_Up_Down_Time(A0)                  ; $0039
                cmpi.b  #$78, Obj_Look_Up_Down_Time(A0)                  ; $0039
                bcs.s   Offset_0x00B1B8
                move.b  #$78, Obj_Look_Up_Down_Time(A0)                  ; $0039
                cmpi.w  #$0008, (A5)
                beq.s   Offset_0x00B1C4
                subq.w  #$02, (A5)
                bra.s   Offset_0x00B1C4
Offset_0x00B1B2:
                move.b  #$00, Obj_Look_Up_Down_Time(A0)                  ; $0039
Offset_0x00B1B8:
                cmpi.w  #$0060, (A5)
                beq.s   Offset_0x00B1C4
                bcc.s   Offset_0x00B1C2
                addq.w  #$04, (A5)
Offset_0x00B1C2:
                subq.w  #$02, (A5)
Offset_0x00B1C4:
                tst.b   (Super_Sonic_Flag).w                         ; $FFFFFE19
                beq     Offset_0x00B1D0
                move.w  #$000C, D5
Offset_0x00B1D0:
                move.b  (Control_Ports_Logical_Data).w, D0           ; $FFFFF602
                andi.b  #$0C, D0
                bne.s   Offset_0x00B1FC
                move.w  Obj_Inertia(A0), D0                              ; $001C
                beq.s   Offset_0x00B1FC
                bmi.s   Offset_0x00B1F0
                sub.w   D5, D0
                bcc.s   Offset_0x00B1EA
                move.w  #$0000, D0
Offset_0x00B1EA:
                move.w  D0, Obj_Inertia(A0)                              ; $001C
                bra.s   Offset_0x00B1FC
Offset_0x00B1F0:
                add.w   D5, D0
                bcc.s   Offset_0x00B1F8
                move.w  #$0000, D0
Offset_0x00B1F8:
                move.w  D0, Obj_Inertia(A0)                              ; $001C
Offset_0x00B1FC:
                move.b  Obj_Angle(A0), D0                                ; $0026
                jsr     (CalcSine)                             ; Offset_0x001B20
                muls.w  Obj_Inertia(A0), D1                              ; $001C
                asr.l   #$08, D1
                move.w  D1, Obj_Speed_X(A0)                              ; $0018
                muls.w  Obj_Inertia(A0), D0                              ; $001C
                asr.l   #$08, D0
                move.w  D0, Obj_Speed_Y(A0)                              ; $001A
Offset_0x00B21A:
                btst    #$06, Obj_Player_Control(A0)                     ; $002E
                bne     Offset_0x00B2A4
                move.b  Obj_Angle(A0), D0                                ; $0026
                addi.b  #$40, D0
                bmi.s   Offset_0x00B2A4
                move.b  #$40, D1
                tst.w   Obj_Inertia(A0)                                  ; $001C
                beq.s   Offset_0x00B2A4
                bmi.s   Offset_0x00B23C
                neg.w   D1
Offset_0x00B23C:
                move.b  Obj_Angle(A0), D0                                ; $0026
                add.b   D1, D0
                move.w  D0, -(A7)
                bsr     Player_WalkSpeed                       ; Offset_0x009B1A
                move.w  (A7)+, D0
                tst.w   D1
                bpl.s   Offset_0x00B2A4
                asl.w   #$08, D1
                addi.b  #$20, D0
                andi.b  #$C0, D0
                beq.s   Offset_0x00B2A0
                cmpi.b  #$40, D0
                beq.s   Offset_0x00B286
                cmpi.b  #$80, D0
                beq.s   Offset_0x00B280
                add.w   D1, Obj_Speed_X(A0)                              ; $0018
                move.w  #$0000, Obj_Inertia(A0)                          ; $001C
                btst    #$00, Obj_Status(A0)                             ; $002A
                bne.s   Offset_0x00B27E
                bset    #$05, Obj_Status(A0)                             ; $002A
Offset_0x00B27E:
                rts
Offset_0x00B280:
                sub.w   D1, Obj_Speed_Y(A0)                              ; $001A
                rts
Offset_0x00B286:
                sub.w   D1, Obj_Speed_X(A0)                              ; $0018
                move.w  #$0000, Obj_Inertia(A0)                          ; $001C
                btst    #$00, Obj_Status(A0)                             ; $002A
                beq.s   Offset_0x00B27E
                bset    #$05, Obj_Status(A0)                             ; $002A
                rts
Offset_0x00B2A0:
                add.w   D1, Obj_Speed_Y(A0)                              ; $001A
Offset_0x00B2A4:
                rts
Offset_0x00B2A6:
                move.w  Obj_Inertia(A0), D0                              ; $001C
                beq.s   Offset_0x00B2AE
                bpl.s   Offset_0x00B2E0
Offset_0x00B2AE:
                bset    #$00, Obj_Status(A0)                             ; $002A
                bne.s   Offset_0x00B2C2
                bclr    #$05, Obj_Status(A0)                             ; $002A
                move.b  #$01, Obj_Ani_Flag(A0)                           ; $0021
Offset_0x00B2C2:
                sub.w   D5, D0
                move.w  D6, D1
                neg.w   D1
                cmp.w   D1, D0
                bgt.s   Offset_0x00B2D4
                add.w   D5, D0
                cmp.w   D1, D0
                ble.s   Offset_0x00B2D4
                move.w  D1, D0
Offset_0x00B2D4:
                move.w  D0, Obj_Inertia(A0)                              ; $001C
                move.b  #$00, Obj_Ani_Number(A0)                         ; $0020
                rts
Offset_0x00B2E0:
                sub.w   D4, D0
                bcc.s   Offset_0x00B2E8
                move.w  #$FF80, D0
Offset_0x00B2E8:
                move.w  D0, Obj_Inertia(A0)                              ; $001C
                move.b  Obj_Angle(A0), D0                                ; $0026
                addi.b  #$20, D0
                andi.b  #$C0, D0
                bne.s   Offset_0x00B32A
                cmpi.w  #$0400, D0
                blt.s   Offset_0x00B32A
                move.b  #$0D, Obj_Ani_Number(A0)                         ; $0020
                bclr    #$00, Obj_Status(A0)                             ; $002A
                move.w  #Skidding_Sfx, D0                                ; $0036
                jsr     (Play_Music)                           ; Offset_0x001176
                cmpi.b  #$0C, Obj_Subtype(A0)                            ; $002C
                bcs.s   Offset_0x00B32A
                move.b  #$06, Obj_Routine(A6)                            ; $0005
                move.b  #$15, Obj_Map_Id(A6)                             ; $0022
Offset_0x00B32A:
                rts
Offset_0x00B32C:
                move.w  Obj_Inertia(A0), D0                              ; $001C
                bmi.s   Offset_0x00B360
                bclr    #$00, Obj_Status(A0)                             ; $002A
                beq.s   Offset_0x00B346
                bclr    #$05, Obj_Status(A0)                             ; $002A
                move.b  #$01, Obj_Ani_Flag(A0)                           ; $0021
Offset_0x00B346:
                add.w   D5, D0
                cmp.w   D6, D0
                blt.s   Offset_0x00B354
                sub.w   D5, D0
                cmp.w   D6, D0
                bge.s   Offset_0x00B354
                move.w  D6, D0
Offset_0x00B354:
                move.w  D0, Obj_Inertia(A0)                              ; $001C
                move.b  #$00, Obj_Ani_Number(A0)                         ; $0020
                rts
Offset_0x00B360:
                add.w   D4, D0
                bcc.s   Offset_0x00B368
                move.w  #$0080, D0
Offset_0x00B368:
                move.w  D0, Obj_Inertia(A0)                              ; $001C
                move.b  Obj_Angle(A0), D0                                ; $0026
                addi.b  #$20, D0
                andi.b  #$C0, D0
                bne.s   Offset_0x00B3AA
                cmpi.w  #$FC00, D0
                bgt.s   Offset_0x00B3AA
                move.b  #$0D, Obj_Ani_Number(A0)                         ; $0020
                bset    #$00, Obj_Status(A0)                             ; $002A
                move.w  #Skidding_Sfx, D0                                ; $0036
                jsr     (Play_Music)                           ; Offset_0x001176
                cmpi.b  #$0C, Obj_Subtype(A0)                            ; $002C
                bcs.s   Offset_0x00B3AA
                move.b  #$06, Obj_Routine(A6)                            ; $0005
                move.b  #$15, Obj_Map_Id(A6)                             ; $0022
Offset_0x00B3AA:
                rts
;-------------------------------------------------------------------------------                
Sonic_RollSpeed:                                               ; Offset_0x00B3AC
                move.w  (A4), D6
                asl.w   #$01, D6
                move.w  Acceleration(A4), D5                             ; $0002
                asr.w   #$01, D5
                move.w  #$0020, D4
                tst.b   Obj_Player_Status(A0)                            ; $002F
                bmi     Offset_0x00B448
                tst.w   Obj_P_Horiz_Ctrl_Lock(A0)                        ; $0032
                bne.s   Offset_0x00B3E0
                btst    #$02, (Control_Ports_Logical_Data).w         ; $FFFFF602
                beq.s   Offset_0x00B3D4
                bsr     Offset_0x00B48A
Offset_0x00B3D4:
                btst    #$03, (Control_Ports_Logical_Data).w         ; $FFFFF602
                beq.s   Offset_0x00B3E0
                bsr     Offset_0x00B4AE
Offset_0x00B3E0:
                move.w  Obj_Inertia(A0), D0                              ; $001C
                beq.s   Offset_0x00B402
                bmi.s   Offset_0x00B3F6
                sub.w   D5, D0
                bcc.s   Offset_0x00B3F0
                move.w  #$0000, D0
Offset_0x00B3F0:
                move.w  D0, Obj_Inertia(A0)                              ; $001C
                bra.s   Offset_0x00B402
Offset_0x00B3F6:
                add.w   D5, D0
                bcc.s   Offset_0x00B3FE
                move.w  #$0000, D0
Offset_0x00B3FE:
                move.w  D0, Obj_Inertia(A0)                              ; $001C
Offset_0x00B402:
                tst.w   Obj_Inertia(A0)                                  ; $001C
                bne.s   Offset_0x00B448
                tst.b   Obj_Player_Spdsh_Flag(A0)                        ; $003D
                bne.s   Offset_0x00B436
                bclr    #$02, Obj_Status(A0)                             ; $002A
                move.b  Obj_Height_2(A0), D0                             ; $001E
                move.b  Obj_Height_3(A0), Obj_Height_2(A0)        ; $001E, $0044
                move.b  Obj_Width_3(A0), Obj_Width_2(A0)          ; $001F, $0045
                move.b  #$05, Obj_Ani_Number(A0)                         ; $0020
                sub.b   Obj_Height_3(A0), D0                             ; $0044
                ext.w   D0
                add.w   D0, Obj_Y(A0)                                    ; $0014
                bra.s   Offset_0x00B448
Offset_0x00B436:
                move.w  #$0400, Obj_Inertia(A0)                          ; $001C
                btst    #$00, Obj_Status(A0)                             ; $002A
                beq.s   Offset_0x00B448
                neg.w   Obj_Inertia(A0)                                  ; $001C
Offset_0x00B448:
                cmpi.w  #$0060, (A5)
                beq.s   Offset_0x00B454
                bcc.s   Offset_0x00B452
                addq.w  #$04, (A5)
Offset_0x00B452:
                subq.w  #$02, (A5)
Offset_0x00B454:
                move.b  Obj_Angle(A0), D0                                ; $0026
                jsr     (CalcSine)                             ; Offset_0x001B20
                muls.w  Obj_Inertia(A0), D0                              ; $001C
                asr.l   #$08, D0
                move.w  D0, Obj_Speed_Y(A0)                              ; $001A
                muls.w  Obj_Inertia(A0), D1                              ; $001C
                asr.l   #$08, D1
                cmpi.w  #$1000, D1
                ble.s   Offset_0x00B478
                move.w  #$1000, D1
Offset_0x00B478:
                cmpi.w  #$F000, D1
                bge.s   Offset_0x00B482
                move.w  #$F000, D1
Offset_0x00B482:
                move.w  D1, Obj_Speed_X(A0)                              ; $0018
                bra     Offset_0x00B21A
Offset_0x00B48A:
                move.w  Obj_Inertia(A0), D0                              ; $001C
                beq.s   Offset_0x00B492
                bpl.s   Offset_0x00B4A0
Offset_0x00B492:
                bset    #$00, Obj_Status(A0)                             ; $002A
                move.b  #$02, Obj_Ani_Number(A0)                         ; $0020
                rts
Offset_0x00B4A0:
                sub.w   D4, D0
                bcc.s   Offset_0x00B4A8
                move.w  #$FF80, D0
Offset_0x00B4A8:
                move.w  D0, Obj_Inertia(A0)                              ; $001C
                rts
Offset_0x00B4AE:
                move.w  Obj_Inertia(A0), D0                              ; $001C
                bmi.s   Offset_0x00B4C2
                bclr    #$00, Obj_Status(A0)                             ; $002A
                move.b  #$02, Obj_Ani_Number(A0)                         ; $0020
                rts
Offset_0x00B4C2:
                add.w   D4, D0
                bcc.s   Offset_0x00B4CA
                move.w  #$0080, D0
Offset_0x00B4CA:
                move.w  D0, Obj_Inertia(A0)                              ; $001C
                rts
;-------------------------------------------------------------------------------                
Sonic_ChgJumpDir:                                              ; Offset_0x00B4D0
                move.w  (A4), D6
                move.w  Acceleration(A4), D5                             ; $0002
                asl.w   #$01, D5
                btst    #$04, Obj_Status(A0)                             ; $002A
                bne.s   Offset_0x00B524
                move.w  Obj_Speed_X(A0), D0                              ; $0018
                btst    #$02, (Control_Ports_Logical_Data).w         ; $FFFFF602
                beq.s   Offset_0x00B504
                bset    #$00, Obj_Status(A0)                             ; $002A
                sub.w   D5, D0
                move.w  D6, D1
                neg.w   D1
                cmp.w   D1, D0
                bgt.s   Offset_0x00B504
                add.w   D5, D0
                cmp.w   D1, D0
                ble.s   Offset_0x00B504
                move.w  D1, D0
Offset_0x00B504:
                btst    #$03, (Control_Ports_Logical_Data).w         ; $FFFFF602
                beq.s   Offset_0x00B520
                bclr    #$00, Obj_Status(A0)                             ; $002A
                add.w   D5, D0
                cmp.w   D6, D0
                blt.s   Offset_0x00B520
                sub.w   D5, D0
                cmp.w   D6, D0
                bge.s   Offset_0x00B520
                move.w  D6, D0
Offset_0x00B520:
                move.w  D0, Obj_Speed_X(A0)                              ; $0018
Offset_0x00B524:
                cmpi.w  #$0060, (A5)
                beq.s   Offset_0x00B530
                bcc.s   Offset_0x00B52E
                addq.w  #$04, (A5)
Offset_0x00B52E:
                subq.w  #$02, (A5)
Offset_0x00B530:
                cmpi.w  #$FC00, Obj_Speed_Y(A0)                          ; $001A
                bcs.s   Offset_0x00B55E
                move.w  Obj_Speed_X(A0), D0                              ; $0018
                move.w  D0, D1
                asr.w   #$05, D1
                beq.s   Offset_0x00B55E
                bmi.s   Offset_0x00B552
                sub.w   D1, D0
                bcc.s   Offset_0x00B54C
                move.w  #$0000, D0
Offset_0x00B54C:
                move.w  D0, Obj_Speed_X(A0)                              ; $0018
                rts
Offset_0x00B552:
                sub.w   D1, D0
                bcs.s   Offset_0x00B55A
                move.w  #$0000, D0
Offset_0x00B55A:
                move.w  D0, Obj_Speed_X(A0)                              ; $0018
Offset_0x00B55E:
                rts
;-------------------------------------------------------------------------------                
Sonic_LevelBoundaries:                                         ; Offset_0x00B560
                move.l  Obj_X(A0), D1                                    ; $0010
                move.w  Obj_Speed_X(A0), D0                              ; $0018
                ext.l   D0
                asl.l   #$08, D0
                add.l   D0, D1
                swap.w  D1
                move.w  (Sonic_Level_Limits_Min_X).w, D0             ; $FFFFEE14
                addi.w  #$0010, D0
                cmp.w   D1, D0
                bhi.s   Offset_0x00B59E
                move.w  (Sonic_Level_Limits_Max_X).w, D0             ; $FFFFEE16
                addi.w  #$0128, D0
                cmp.w   D1, D0
                bls.s   Offset_0x00B59E
Offset_0x00B588:
                move.w  (Sonic_Level_Limits_Max_Y).w, D0             ; $FFFFEE1A
                addi.w  #$00E0, D0
                cmp.w   Obj_Y(A0), D0                                    ; $0014
                blt.s   Offset_0x00B598
                rts
Offset_0x00B598:
                jmp     (Kill_Player)                          ; Offset_0x00A4A4
Offset_0x00B59E:
                move.w  D0, Obj_X(A0)                                    ; $0010
                move.w  #$0000, Obj_Sub_X(A0)                            ; $0012
                move.w  #$0000, Obj_Speed_X(A0)                          ; $0018
                move.w  #$0000, Obj_Inertia(A0)                          ; $001C
                bra.s   Offset_0x00B588 
;-------------------------------------------------------------------------------                
Sonic_Roll:                                                    ; Offset_0x00B5B6
                tst.b   Obj_Player_Status(A0)                            ; $002F
                bmi.s   Offset_0x00B5DC
                move.w  Obj_Inertia(A0), D0                              ; $001C
                bpl.s   Offset_0x00B5C4
                neg.w   D0
Offset_0x00B5C4:
                cmpi.w  #$0080, D0
                bcs.s   Offset_0x00B5DC
                move.b  (Control_Ports_Logical_Data).w, D0           ; $FFFFF602
                andi.b  #$0C, D0
                bne.s   Offset_0x00B5DC
                btst    #$01, (Control_Ports_Logical_Data).w         ; $FFFFF602
                bne.s   Offset_0x00B5DE
Offset_0x00B5DC:
                rts
Offset_0x00B5DE:
                btst    #$02, Obj_Status(A0)                             ; $002A
                beq.s   Offset_0x00B5E8
                rts
Offset_0x00B5E8:
                bset    #$02, Obj_Status(A0)                             ; $002A
                move.b  #$0E, Obj_Height_2(A0)                           ; $001E
                move.b  #$07, Obj_Width_2(A0)                            ; $001F
                move.b  #$02, Obj_Ani_Number(A0)                         ; $0020
                addq.w  #$05, Obj_Y(A0)                                  ; $0014
                move.w  #Rolling_Sfx, D0                                 ; $003C
                jsr     (Play_Music)                           ; Offset_0x001176
                tst.w   Obj_Inertia(A0)                                  ; $001C
                bne.s   Offset_0x00B61A
                move.w  #$0200, Obj_Inertia(A0)                          ; $001C
Offset_0x00B61A:
                rts 
;-------------------------------------------------------------------------------                
Sonic_Jump:                                                    ; Offset_0x00B61C
                move.b  (Control_Ports_Logical_Data+$001).w, D0      ; $FFFFF603
                andi.b  #$70, D0
                beq     Offset_0x00B6F0
                move.b  (Control_Ports_Logical_Data).w, D0           ; $FFFFF602
                andi.b  #$0D, D0
                cmpi.b  #$01, D0
                bne.s   Offset_0x00B63C
                move.w  #$FFFF, (CopySonicMovesForMilesIndex).w      ; $FFFFFE5A
Offset_0x00B63C:
                moveq   #$00, D0
                move.b  Obj_Angle(A0), D0                                ; $0026
                addi.b  #$80, D0
                movem.l A4-A6, -(A7)
                bsr     CalcRoomOverHead                       ; Offset_0x009B94
                movem.l (A7)+, A4-A6
                cmpi.w  #$0006, D1
                blt     Offset_0x00B6F0
                move.w  #$0680, D2
                tst.b   (Super_Sonic_Flag).w                         ; $FFFFFE19
                beq.s   Offset_0x00B668
                move.w  #$0800, D2
Offset_0x00B668:
                btst    #$06, Obj_Status(A0)                             ; $002A
                beq.s   Offset_0x00B674
                move.w  #$0380, D2
Offset_0x00B674:
                moveq   #$00, D0
                move.b  Obj_Angle(A0), D0                                ; $0026
                subi.b  #$40, D0
                jsr     (CalcSine)                             ; Offset_0x001B20
                muls.w  D2, D1
                asr.l   #$08, D1
                add.w   D1, Obj_Speed_X(A0)                              ; $0018
                muls.w  D2, D0
                asr.l   #$08, D0
                add.w   D0, Obj_Speed_Y(A0)                              ; $001A
                bset    #$01, Obj_Status(A0)                             ; $002A
                bclr    #$05, Obj_Status(A0)                             ; $002A
                addq.l  #$04, A7
                move.b  #$01, Obj_Player_Jump(A0)                        ; $0040
                clr.b   Obj_Player_St_Convex(A0)                         ; $003C
                move.w  #Jump_Sfx, D0                                    ; $0070
                jsr     (Play_Music)                           ; Offset_0x001176
                move.b  Obj_Height_3(A0), Obj_Height_2(A0)        ; $001E, $0044
                move.b  Obj_Width_3(A0), Obj_Width_2(A0)          ; $001F, $0045
                btst    #$02, Obj_Status(A0)                             ; $002A
                bne.s   Offset_0x00B6F2
                move.b  #$0E, Obj_Height_2(A0)                           ; $001E
                move.b  #$07, Obj_Width_2(A0)                            ; $001F
                move.b  #$02, Obj_Ani_Number(A0)                         ; $0020
                bset    #$02, Obj_Status(A0)                             ; $002A
                move.b  Obj_Height_2(A0), D0                             ; $001E
                sub.b   Obj_Height_3(A0), D0                             ; $0044
                ext.w   D0
                sub.w   D0, Obj_Y(A0)                                    ; $0014
Offset_0x00B6F0:
                rts
Offset_0x00B6F2:
                bset    #$04, Obj_Status(A0)                             ; $002A
                rts 
;-------------------------------------------------------------------------------                
Sonic_JumpHeight:                                              ; Offset_0x00B6FA
                tst.b   Obj_Player_Jump(A0)                              ; $0040
                beq.s   Offset_0x00B72E
                move.w  #$FC00, D1
                btst    #$06, Obj_Status(A0)                             ; $002A
                beq.s   Offset_0x00B710
                move.w  #$FE00, D1
Offset_0x00B710:
                cmp.w   Obj_Speed_Y(A0), D1                              ; $001A
                ble     Offset_0x00B7B8
                move.b  (Control_Ports_Logical_Data).w, D0           ; $FFFFF602
                andi.b  #$70, D0
                bne.s   Offset_0x00B726
                move.w  D1, Obj_Speed_Y(A0)                              ; $001A
Offset_0x00B726:
                tst.b   Obj_Speed_Y(A0)                                  ; $001A
                beq.s   Offset_0x00B744
                rts
Offset_0x00B72E:
                tst.b   Obj_Player_Spdsh_Flag(A0)                        ; $003D
                bne.s   Offset_0x00B742
                cmpi.w  #$F040, Obj_Speed_Y(A0)                          ; $001A
                bge.s   Offset_0x00B742
                move.w  #$F040, Obj_Speed_Y(A0)                          ; $001A
Offset_0x00B742:
                rts
;-------------------------------------------------------------------------------                
Offset_0x00B744:
                tst.b   (Super_Sonic_Flag).w                         ; $FFFFFE19
                bne.s   Offset_0x00B7B6
                cmpi.b  #$07, (Emeralds_Count).w                     ; $FFFFFFB1
                bne.s   Offset_0x00B7B6
                cmpi.w  #$0032, (Ring_Count_Address).w               ; $FFFFFE20
                bcs.s   Offset_0x00B7B6
                tst.b   (HUD_Timer_Refresh_Flag).w                   ; $FFFFFE1E
                beq.s   Offset_0x00B7B6
                move.b  #$01, (Super_Sonic_Palette_Status).w         ; $FFFFF65F
                move.b  #$0F, (Super_Sonic_Palette_Timer).w          ; $FFFFF65E
                move.b  #$01, (Super_Sonic_Flag).w                   ; $FFFFFE19
                move.b  #$81, Obj_Player_Control(A0)                     ; $002E
                move.b  #$1F, Obj_Ani_Number(A0)                         ; $0020
                move.l  #Obj_Super_Sonic_Stars, (Obj_Super_Sonic_Stars_RAM).w ; Offset_0x0102AA, $FFFFCBC0
                move.w  #$0A00, (A4)
                move.w  #$0030, Acceleration(A4)                         ; $0002
                move.w  #$0100, Deceleration(A4)                         ; $0004
                move.b  #$00, Obj_P_Invcbility_Time(A0)                  ; $0035
                bset    #$01, Obj_Player_Status(A0)                      ; $002F
                move.w  #Super_Form_Change_Sfx, D0                       ; $FFBB
                jsr     (Play_Music)                           ; Offset_0x001176
                move.w  #Super_Sonic_Snd, D0                             ; $000A
                jmp     (Play_Music)                           ; Offset_0x001176
Offset_0x00B7B6:
                rts
Offset_0x00B7B8:
                bra     Offset_0x00B8B6 
;-------------------------------------------------------------------------------                
Offset_0x00B7BC:
                btst    #$02, Obj_Status(A0)                             ; $002A
                beq     Offset_0x00B8B6
                move.b  (Control_Ports_Logical_Data+$001).w, D0      ; $FFFFF603
                andi.b  #$20, D0
                beq.s   Offset_0x00B83A
                move.w  Obj_Speed_X(A0), D2                              ; $0018
                bsr     SingleObjectLoad                       ; Offset_0x011DD8
                bne     Offset_0x00B80C
                bsr     Offset_0x00B994
                move.w  #$0800, Obj_Speed_X(A1)                          ; $0018
                move.w  #$0000, Obj_Speed_Y(A1)                          ; $001A
                add.w   D2, Obj_Speed_X(A1)                              ; $0018
                bsr     SingleObjectLoad                       ; Offset_0x011DD8
                bne     Offset_0x00B80C
                bsr     Offset_0x00B994
                move.w  #$F800, Obj_Speed_X(A1)                          ; $0018
                move.w  #$0000, Obj_Speed_Y(A1)                          ; $001A
                add.w   D2, Obj_Speed_X(A1)                              ; $0018
Offset_0x00B80C:
                btst    #$02, Obj_Status(A0)                             ; $002A
                beq.s   Offset_0x00B83A
                bclr    #$02, Obj_Status(A0)                             ; $002A
                move.b  Obj_Height_2(A0), D0                             ; $001E
                move.b  Obj_Height_3(A0), Obj_Height_2(A0)        ; $001E, $0044
                move.b  Obj_Width_3(A0), Obj_Width_2(A0)          ; $001F, $0045
                move.b  #$00, Obj_Ani_Number(A0)                         ; $0020
                sub.b   Obj_Height_3(A0), D0                             ; $0044
                ext.w   D0
                add.w   D0, Obj_Y(A0)                                    ; $0014
Offset_0x00B83A:
                move.b  (Control_Ports_Logical_Data+$001).w, D0      ; $FFFFF603
                andi.b  #$10, D0
                beq.s   Offset_0x00B8B6
                move.w  Obj_Speed_X(A0), D2                              ; $0018
                bsr     SingleObjectLoad                       ; Offset_0x011DD8
                bne     Offset_0x00B870
                bsr     Offset_0x00B994
                move.w  #$0800, Obj_Speed_X(A1)                          ; $0018
                btst    #$00, Obj_Status(A0)                             ; $002A
                beq.s   Offset_0x00B866
                neg.w   Obj_Speed_X(A1)                                  ; $0018
Offset_0x00B866:
                move.w  #$0000, Obj_Speed_Y(A1)                          ; $001A
                add.w   D2, Obj_Speed_X(A1)                              ; $0018
Offset_0x00B870:
                btst    #$02, Obj_Status(A0)                             ; $002A
                beq.s   Offset_0x00B89E
                bclr    #$02, Obj_Status(A0)                             ; $002A
                move.b  Obj_Height_2(A0), D0                             ; $001E
                move.b  Obj_Height_3(A0), Obj_Height_2(A0)        ; $001E, $0044
                move.b  Obj_Width_3(A0), Obj_Width_2(A0)          ; $001F, $0045
                move.b  #$00, Obj_Ani_Number(A0)                         ; $0020
                sub.b   Obj_Height_3(A0), D0                             ; $0044
                ext.w   D0
                add.w   D0, Obj_Y(A0)                                    ; $0014
Offset_0x00B89E:
                move.w  #$0000, Obj_Speed_Y(A0)                          ; $001A
                move.w  #$0200, D0
                btst    #$00, Obj_Status(A0)                             ; $002A
                bne.s   Offset_0x00B8B2
                neg.w   D0
Offset_0x00B8B2:
                add.w   D0, Obj_Speed_X(A0)                              ; $0018
Offset_0x00B8B6:
                rts 
;-------------------------------------------------------------------------------
Offset_0x00B8B8:
                tst.w   (CopySonicMovesForMilesIndex).w              ; $FFFFFE5A
                bne     Offset_0x00B952
                move.b  (Control_Ports_Logical_Data+$001).w, D0      ; $FFFFF603
                andi.b  #$40, D0
                beq     Offset_0x00B952
                move.b  (Control_Ports_Logical_Data).w, D0           ; $FFFFF602
                andi.w  #$000F, D0
                beq.s   Offset_0x00B912
                lsl.w   #$02, D0
                lea     Offset_0x00B954(PC, D0), A1
                move.w  (A1)+, D0
                move.w  D0, Obj_Speed_X(A0)                              ; $0018
                move.w  D0, Obj_Inertia(A0)                              ; $001C
                move.w  (A1)+, D0
                move.w  D0, Obj_Speed_Y(A0)                              ; $001A
                lea     (Camera_X_Scroll_Delay).w, A1                ; $FFFFEE24
                cmpa.w  #Obj_Player_One, A0                              ; $B000
                beq.s   Offset_0x00B8FA
                lea     (Camera_X_Scroll_Delay_2P).w, A1             ; $FFFFEE28
Offset_0x00B8FA:
                move.w  D0, (A1)
                bsr     Reset_Player_Position_Array            ; Offset_0x00ACEC
                move.w  #$0001, (CopySonicMovesForMilesIndex).w      ; $FFFFFE5A
                move.w  #Rolling_Sfx, D0                                 ; $003C
                jsr     (Play_Music)                           ; Offset_0x001176
                rts
Offset_0x00B912:
                move.w  #$0800, D0
                btst    #$00, Obj_Status(A0)                             ; $002A
                beq.s   Offset_0x00B920
                neg.w   D0
Offset_0x00B920:
                move.w  D0, Obj_Speed_X(A0)                              ; $0018
                move.w  D0, Obj_Inertia(A0)                              ; $001C
                move.w  #$0000, Obj_Speed_Y(A0)                          ; $001A
                lea     (Camera_X_Scroll_Delay).w, A1                ; $FFFFEE24
                cmpa.w  #Obj_Player_One, A0                              ; $B000
                beq.s   Offset_0x00B93C
                lea     (Camera_X_Scroll_Delay_2P).w, A1             ; $FFFFEE28
Offset_0x00B93C:
                move.w  D0, (A1)
                bsr     Reset_Player_Position_Array            ; Offset_0x00ACEC
                move.w  #$0001, (CopySonicMovesForMilesIndex).w      ; $FFFFFE5A
                move.w  #Rolling_Sfx, D0                                 ; $003C
                jsr     (Play_Music)                           ; Offset_0x001176
Offset_0x00B952:
                rts
;-------------------------------------------------------------------------------
Offset_0x00B954:
                dc.w    $0000, $0000, $0000, $F800, $0000, $0800, $0000, $0000
                dc.w    $F800, $0000, $F800, $F800, $F800, $0800, $0000, $0000
                dc.w    $0800, $0000, $0800, $F800, $0800, $0800, $0000, $0000
                dc.w    $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
;-------------------------------------------------------------------------------
Offset_0x00B994:
                move.l  #Offset_0x00B9C8, (A1)
                move.w  Obj_X(A0), Obj_X(A1)                      ; $0010, $0010
                move.w  Obj_Y(A0), Obj_Y(A1)                      ; $0014, $0014
                move.l  #Rings_Mappings, Obj_Map(A1)    ; Offset_0x010DE2, $000C
                move.w  #$26BC, Obj_Art_VRAM(A1)                         ; $000A
                move.b  #$84, Obj_Flags(A1)                              ; $0004
                move.w  #$0180, Obj_Priority(A1)                         ; $0008
                move.b  #$08, Obj_Width(A1)                              ; $0007
                rts
;-------------------------------------------------------------------------------
Offset_0x00B9C8:
                moveq   #$00, D0
                move.b  Obj_Routine(A0), D0                              ; $0005
                move.w  Offset_0x00B9D6(PC, D0), D1
                jmp     Offset_0x00B9D6(PC, D1)
;-------------------------------------------------------------------------------                
Offset_0x00B9D6:
                dc.w    Offset_0x00B9DA-Offset_0x00B9D6
                dc.w    Offset_0x00B9F6-Offset_0x00B9D6
;-------------------------------------------------------------------------------
Offset_0x00B9DA:
                addq.b  #$02, Obj_Routine(A0)                            ; $0005
                move.b  #$02, Obj_Ani_Number(A0)                         ; $0020
                move.b  #$08, Obj_Height_2(A0)                           ; $001E
                move.b  #$08, Obj_Width_2(A0)                            ; $001F
                bset    #$01, Obj_Player_Status(A0)                      ; $002F
;-------------------------------------------------------------------------------                
Offset_0x00B9F6:
                move.l  A0, A2
                jsr     (Touch_Response)                       ; Offset_0x00A188
                cmpi.b  #$02, Obj_Routine(A0)                            ; $0005
                beq.s   Offset_0x00BA10
                nop
                nop
                nop
                nop
                nop
Offset_0x00BA10:
                cmpi.b  #$02, Obj_Ani_Number(A0)                         ; $0020
                beq.s   Offset_0x00BA22
                nop
                nop
                nop
                nop
                nop
Offset_0x00BA22:
                move.b  (Vertical_Interrupt_Count+$03).w, D0         ; $FFFFFE0F
                andi.w  #$0003, D0
                bne.s   Offset_0x00BA36
                addq.b  #$01, Obj_Map_Id(A0)                             ; $0022
                andi.b  #$03, Obj_Map_Id(A0)                             ; $0022
Offset_0x00BA36:
                bsr     SpeedToPos                             ; Offset_0x01111E
                tst.b   Obj_Flags(A0)                                    ; $0004
                bpl     DeleteObject                           ; Offset_0x011138
                bra     DisplaySprite                          ; Offset_0x011148                
;-------------------------------------------------------------------------------                
Offset_0x00BA46:
                tst.b   (Super_Sonic_Flag).w                         ; $FFFFFE19
                beq     Offset_0x00BAD8
                tst.b   (HUD_Timer_Refresh_Flag).w                   ; $FFFFFE1E
                beq.s   Offset_0x00BA92
                subq.w  #$01, ($FFFFF670).w
                bpl     Offset_0x00BAD8
                move.w  #$003C, ($FFFFF670).w
                tst.w   (Ring_Count_Address).w                       ; $FFFFFE20
                beq.s   Offset_0x00BA92
                ori.b   #$01, (HUD_Rings_Refresh_Flag).w             ; $FFFFFE1D
                cmpi.w  #$0001, (Ring_Count_Address).w               ; $FFFFFE20
                beq.s   Offset_0x00BA86
                cmpi.w  #$000A, (Ring_Count_Address).w               ; $FFFFFE20
                beq.s   Offset_0x00BA86
                cmpi.w  #$0064, (Ring_Count_Address).w               ; $FFFFFE20
                bne.s   Offset_0x00BA8C
Offset_0x00BA86:
                ori.b   #$80, (HUD_Rings_Refresh_Flag).w             ; $FFFFFE1D
Offset_0x00BA8C:
                subq.w  #$01, (Ring_Count_Address).w                 ; $FFFFFE20
                bne.s   Offset_0x00BAD8
Offset_0x00BA92:
                move.b  #$02, (Super_Sonic_Palette_Status).w         ; $FFFFF65F
                move.w  #$0028, (Super_Sonic_Palette_Frame).w        ; $FFFFF65C
                move.b  #$00, (Super_Sonic_Flag).w                   ; $FFFFFE19
                move.b  #$01, Obj_Ani_Flag(A0)                           ; $0021
                move.b  #$01, Obj_P_Invcbility_Time(A0)                  ; $0035
                move.w  #$0600, (A4)
                move.w  #$000C, Acceleration(A4)                         ; $0002
                move.w  #$0080, Deceleration(A4)                         ; $0004
                btst    #$06, Obj_Status(A0)                             ; $002A
                beq.s   Offset_0x00BAD8
                move.w  #$0300, (A4)
                move.w  #$0006, Acceleration(A4)                         ; $0002
                move.w  #$0040, Deceleration(A4)                         ; $0004
Offset_0x00BAD8:
                rts
;-------------------------------------------------------------------------------                
Sonic_Spindash:                                                ; Offset_0x00BADA
                tst.b   Obj_Player_Spdsh_Flag(A0)                        ; $003D
                bne.s   Offset_0x00BB2A
                cmpi.b  #$08, Obj_Ani_Number(A0)                         ; $0020
                bne.s   Offset_0x00BB28
                move.b  (Control_Ports_Logical_Data+$001).w, D0      ; $FFFFF603
                andi.b  #$70, D0
                beq     Offset_0x00BB28
                move.b  #$09, Obj_Ani_Number(A0)                         ; $0020
                move.w  #Rolling_Sfx, D0                                 ; $003C
                jsr     (Play_Music)                           ; Offset_0x001176
                addq.l  #$04, A7
                move.b  #$01, Obj_Player_Spdsh_Flag(A0)                  ; $003D
                move.w  #$0000, Obj_Player_Spdsh_Cnt(A0)                 ; $003E
                cmpi.b  #$0C, Obj_Subtype(A0)                            ; $002C
                bcs.s   Offset_0x00BB20
                move.b  #$02, Obj_Ani_Number(A6)                         ; $0020
Offset_0x00BB20:
                bsr     Sonic_LevelBoundaries                  ; Offset_0x00B560
                bsr     Player_AnglePos                        ; Offset_0x009144
Offset_0x00BB28:
                rts
Offset_0x00BB2A:
                move.b  (Control_Ports_Logical_Data).w, D0           ; $FFFFF602
                btst    #$01, D0
                bne     Offset_0x00BBD6
                move.b  #$0E, Obj_Height_2(A0)                           ; $001E
                move.b  #$07, Obj_Width_2(A0)                            ; $001F
                move.b  #$02, Obj_Ani_Number(A0)                         ; $0020
                addq.w  #$05, Obj_Y(A0)                                  ; $0014
                move.b  #$00, Obj_Player_Spdsh_Flag(A0)                  ; $003D
                moveq   #$00, D0
                move.b  Obj_Player_Spdsh_Cnt(A0), D0                     ; $003E
                add.w   D0, D0
                move.w  Sonic_Spindash_Speed(PC, D0), Obj_Inertia(A0) ; Offset_0x00BBB2, $001C
                tst.b   (Super_Sonic_Flag).w                         ; $FFFFFE19
                beq.s   Offset_0x00BB6C
                move.w  Super_Sonic_Spindash_Speed(PC, D0), Obj_Inertia(A0) ; Offset_0x00BBC4, $001C
Offset_0x00BB6C:
                move.w  Obj_Inertia(A0), D0                              ; $001C
                subi.w  #$0800, D0
                add.w   D0, D0
                andi.w  #$1F00, D0
                neg.w   D0
                addi.w  #$2000, D0
                lea     (Camera_X_Scroll_Delay).w, A1                ; $FFFFEE24
                cmpa.w  #Obj_Player_One, A0                              ; $B000
                beq.s   Offset_0x00BB8E
                lea     (Camera_X_Scroll_Delay_2P).w, A1             ; $FFFFEE28
Offset_0x00BB8E:
                move.w  D0, (A1)
                btst    #$00, Obj_Status(A0)                             ; $002A
                beq.s   Offset_0x00BB9C
                neg.w   Obj_Inertia(A0)                                  ; $001C
Offset_0x00BB9C:
                bset    #$02, Obj_Status(A0)                             ; $002A
                move.b  #$00, Obj_Ani_Number(A6)                         ; $0020
                moveq   #Rolling_Sfx, D0                                   ; $3C
                jsr     (Play_Music)                           ; Offset_0x001176
                bra.s   Offset_0x00BC1E                 
;-------------------------------------------------------------------------------
Sonic_Spindash_Speed:                                          ; Offset_0x00BBB2
                dc.w    $0800, $0880, $0900, $0980, $0A00, $0A80, $0B00, $0B80
                dc.w    $0C00                                                
;-------------------------------------------------------------------------------
Super_Sonic_Spindash_Speed:                                    ; Offset_0x00BBC4
                dc.w    $0B00, $0B80, $0C00, $0C80, $0D00, $0D80, $0E00, $0E80
                dc.w    $0F00
;-------------------------------------------------------------------------------
Offset_0x00BBD6:
                tst.w   Obj_Player_Spdsh_Cnt(A0)                         ; $003E
                beq.s   Offset_0x00BBEE
                move.w  Obj_Player_Spdsh_Cnt(A0), D0                     ; $003E
                lsr.w   #$05, D0
                sub.w   D0, Obj_Player_Spdsh_Cnt(A0)                     ; $003E
                bcc.s   Offset_0x00BBEE
                move.w  #$0000, Obj_Player_Spdsh_Cnt(A0)                 ; $003E
Offset_0x00BBEE:
                move.b  (Control_Ports_Logical_Data+$001).w, D0      ; $FFFFF603
                andi.b  #$70, D0
                beq     Offset_0x00BC1E
                move.w  #$0900, Obj_Ani_Number(A0)                       ; $0020
                move.w  #Rolling_Sfx, D0                                 ; $003C
                jsr     (Play_Music)                           ; Offset_0x001176
                addi.w  #$0200, Obj_Player_Spdsh_Cnt(A0)                 ; $003E
                cmpi.w  #$0800, Obj_Player_Spdsh_Cnt(A0)                 ; $003E
                bcs.s   Offset_0x00BC1E
                move.w  #$0800, Obj_Player_Spdsh_Cnt(A0)                 ; $003E
Offset_0x00BC1E:
                addq.l  #$04, A7
                cmpi.w  #$0060, (A5)
                beq.s   Offset_0x00BC2C
                bcc.s   Offset_0x00BC2A
                addq.w  #$04, (A5)
Offset_0x00BC2A:
                subq.w  #$02, (A5)
Offset_0x00BC2C:
                bsr     Sonic_LevelBoundaries                  ; Offset_0x00B560
                bsr     Player_AnglePos                        ; Offset_0x009144
                rts
;-------------------------------------------------------------------------------                
Sonic_SlopeResist:                                             ; Offset_0x00BC36
                move.b  Obj_Angle(A0), D0                                ; $0026
                addi.b  #$60, D0
                cmpi.b  #$C0, D0
                bcc.s   Offset_0x00BC6A
                move.b  Obj_Angle(A0), D0                                ; $0026
                jsr     (CalcSine)                             ; Offset_0x001B20
                muls.w  #$0020, D0
                asr.l   #$08, D0
                tst.w   Obj_Inertia(A0)                                  ; $001C
                beq.s   Offset_0x00BC6C
                bmi.s   Offset_0x00BC66
                tst.w   D0
                beq.s   Offset_0x00BC64
                add.w   D0, Obj_Inertia(A0)                              ; $001C
Offset_0x00BC64:
                rts
Offset_0x00BC66:
                add.w   D0, Obj_Inertia(A0)                              ; $001C
Offset_0x00BC6A:
                rts
Offset_0x00BC6C:
                move.w  D0, D1
                bpl.s   Offset_0x00BC72
                neg.w   D1
Offset_0x00BC72:
                cmpi.w  #$000D, D1
                bcs.s   Offset_0x00BC6A
                add.w   D0, Obj_Inertia(A0)                              ; $001C
                rts 
;-------------------------------------------------------------------------------                
Sonic_RollRepel:                                               ; Offset_0x00BC7E
                move.b  Obj_Angle(A0), D0                                ; $0026
                addi.b  #$60, D0
                cmpi.b  #$C0, D0
                bcc.s   Offset_0x00BCB8
                move.b  Obj_Angle(A0), D0                                ; $0026
                jsr     (CalcSine)                             ; Offset_0x001B20
                muls.w  #$0050, D0
                asr.l   #$08, D0
                tst.w   Obj_Inertia(A0)                                  ; $001C
                bmi.s   Offset_0x00BCAE
                tst.w   D0
                bpl.s   Offset_0x00BCA8
                asr.l   #$02, D0
Offset_0x00BCA8:
                add.w   D0, Obj_Inertia(A0)                              ; $001C
                rts
Offset_0x00BCAE:
                tst.w   D0
                bmi.s   Offset_0x00BCB4
                asr.l   #$02, D0
Offset_0x00BCB4:
                add.w   D0, Obj_Inertia(A0)                              ; $001C
Offset_0x00BCB8:
                rts 
;-------------------------------------------------------------------------------                
Sonic_SlopeRepel:                                              ; Offset_0x00BCBA
                nop
                tst.b   Obj_Player_St_Convex(A0)                         ; $003C
                bne.s   Offset_0x00BCFE
                tst.w   Obj_P_Horiz_Ctrl_Lock(A0)                        ; $0032
                bne.s   Offset_0x00BD16
                move.b  Obj_Angle(A0), D0                                ; $0026
                addi.b  #$18, D0
                cmpi.b  #$30, D0
                bcs.s   Offset_0x00BCFE
                move.w  Obj_Inertia(A0), D0                              ; $001C
                bpl.s   Offset_0x00BCDE
                neg.w   D0
Offset_0x00BCDE:
                cmpi.w  #$0280, D0
                bcc.s   Offset_0x00BCFE
                move.w  #$001E, Obj_P_Horiz_Ctrl_Lock(A0)                ; $0032
                move.b  Obj_Angle(A0), D0                                ; $0026
                addi.b  #$30, D0
                cmpi.b  #$60, D0
                bcs.s   Offset_0x00BD00
                bset    #$01, Obj_Status(A0)                             ; $002A
Offset_0x00BCFE:
                rts
Offset_0x00BD00:
                cmpi.b  #$30, D0
                bcs.s   Offset_0x00BD0E
                addi.w  #$0080, Obj_Inertia(A0)                          ; $001C
                rts
Offset_0x00BD0E:
                subi.w  #$0080, Obj_Inertia(A0)                          ; $001C
                rts
Offset_0x00BD16:
                subq.w  #$01, Obj_P_Horiz_Ctrl_Lock(A0)                  ; $0032
                rts 
;-------------------------------------------------------------------------------                 
Sonic_JumpAngle:                                               ; Offset_0x00BD1C
                move.b  Obj_Angle(A0), D0                                ; $0026
                beq.s   Offset_0x00BD36
                bpl.s   Offset_0x00BD2C
                addq.b  #$02, D0
                bcc.s   Offset_0x00BD2A
                moveq   #$00, D0
Offset_0x00BD2A:
                bra.s   Offset_0x00BD32
Offset_0x00BD2C:
                subq.b  #$02, D0
                bcc.s   Offset_0x00BD32
                moveq   #$00, D0
Offset_0x00BD32:
                move.b  D0, Obj_Angle(A0)                                ; $0026
Offset_0x00BD36:
                move.b  Obj_Flip_Angle(A0), D0                           ; $0027
                beq.s   Offset_0x00BD7A
                tst.w   Obj_Inertia(A0)                                  ; $001C
                bmi.s   Offset_0x00BD5A
Offset_0x00BD42:
                move.b  Obj_Player_Flip_Speed(A0), D1                    ; $0031
                add.b   D1, D0
                bcc.s   Offset_0x00BD58
                subq.b  #$01, Obj_P_Flips_Remaining(A0)                  ; $0030
                bcc.s   Offset_0x00BD58
                move.b  #$00, Obj_P_Flips_Remaining(A0)                  ; $0030
                moveq   #$00, D0
Offset_0x00BD58:
                bra.s   Offset_0x00BD76
Offset_0x00BD5A:
                tst.b   Obj_Player_Flip_Flag(A0)                         ; $002D
                bne.s   Offset_0x00BD42
                move.b  Obj_Player_Flip_Speed(A0), D1                    ; $0031
                sub.b   D1, D0
                bcc.s   Offset_0x00BD76
                subq.b  #$01, Obj_P_Flips_Remaining(A0)                  ; $0030
                bcc.s   Offset_0x00BD76
                move.b  #$00, Obj_P_Flips_Remaining(A0)                  ; $0030
                moveq   #$00, D0
Offset_0x00BD76:
                move.b  D0, Obj_Flip_Angle(A0)                           ; $0027
Offset_0x00BD7A:
                rts 
;-------------------------------------------------------------------------------                
Sonic_Floor:                                                   ; Offset_0x00BD7C
                move.l  (Primary_Collision_Ptr).w, (Current_Collision_Ptr).w ; $FFFFF7B4, $FFFFF796
                cmpi.b  #$0C, Obj_Player_Top_Solid(A0)                   ; $0046
                beq.s   Offset_0x00BD90
                move.l  (Secondary_Collision_Ptr).w, (Current_Collision_Ptr).w ; $FFFFF7B8, $FFFFF796
Offset_0x00BD90:
                move.b  Obj_Player_LRB_Solid(A0), D5                     ; $0047
                move.w  Obj_Speed_X(A0), D1                              ; $0018
                move.w  Obj_Speed_Y(A0), D2                              ; $001A
                jsr     (CalcAngle)                            ; Offset_0x001DB8
                subi.b  #$20, D0
                andi.b  #$C0, D0
                cmpi.b  #$40, D0
                beq     Offset_0x00BE5A
                cmpi.b  #$80, D0
                beq     Offset_0x00BEB4
                cmpi.b  #$C0, D0
                beq     Offset_0x00BF10
                bsr     Player_HitWall                         ; Offset_0x00A0BC
                tst.w   D1
                bpl.s   Offset_0x00BDD4
                sub.w   D1, Obj_X(A0)                                    ; $0010
                move.w  #$0000, Obj_Speed_X(A0)                          ; $0018
Offset_0x00BDD4:
                bsr     Offset_0x009EC6
                tst.w   D1
                bpl.s   Offset_0x00BDE6
                add.w   D1, Obj_X(A0)                                    ; $0010
                move.w  #$0000, Obj_Speed_X(A0)                          ; $0018
Offset_0x00BDE6:
                bsr     Player_Check_Floor                     ; Offset_0x009BD4
                tst.w   D1
                bpl.s   Offset_0x00BE58
                move.b  Obj_Speed_Y(A0), D2                              ; $001A
                addq.b  #$08, D2
                neg.b   D2
                cmp.b   D2, D1
                bge.s   Offset_0x00BDFE
                cmp.b   D2, D0
                blt.s   Offset_0x00BE58
Offset_0x00BDFE:
                add.w   D1, Obj_Y(A0)                                    ; $0014
                move.b  D3, Obj_Angle(A0)                                ; $0026
                bsr     Offset_0x00BF6A
                move.b  D3, D0
                addi.b  #$20, D0
                andi.b  #$40, D0
                bne.s   Offset_0x00BE36
                move.b  D3, D0
                addi.b  #$10, D0
                andi.b  #$20, D0
                beq.s   Offset_0x00BE28
                asr.w   Obj_Speed_Y(A0)                                  ; $001A
                bra.s   Offset_0x00BE4A
Offset_0x00BE28:
                move.w  #$0000, Obj_Speed_Y(A0)                          ; $001A
                move.w  Obj_Speed_X(A0), Obj_Inertia(A0)          ; $0018, $001C
                rts
Offset_0x00BE36:
                move.w  #$0000, Obj_Speed_X(A0)                          ; $0018
                cmpi.w  #$0FC0, Obj_Speed_Y(A0)                          ; $001A
                ble.s   Offset_0x00BE4A
                move.w  #$0FC0, Obj_Speed_Y(A0)                          ; $001A
Offset_0x00BE4A:
                move.w  Obj_Speed_Y(A0), Obj_Inertia(A0)          ; $001A, $001C
                tst.b   D3
                bpl.s   Offset_0x00BE58
                neg.w   Obj_Inertia(A0)                                  ; $001C
Offset_0x00BE58:
                rts
Offset_0x00BE5A:
                bsr     Player_HitWall                         ; Offset_0x00A0BC
                tst.w   D1
                bpl.s   Offset_0x00BE72
                sub.w   D1, Obj_X(A0)                                    ; $0010
                move.w  #$0000, Obj_Speed_X(A0)                          ; $0018
                move.w  Obj_Speed_Y(A0), Obj_Inertia(A0)          ; $001A, $001C
Offset_0x00BE72:
                bsr     Player_DontRunOnWalls                  ; Offset_0x009F1C
                tst.w   D1
                bpl.s   Offset_0x00BE8C
                sub.w   D1, Obj_Y(A0)                                    ; $0014
                tst.w   Obj_Speed_Y(A0)                                  ; $001A
                bpl.s   Offset_0x00BE8A
                move.w  #$0000, Obj_Speed_Y(A0)                          ; $001A
Offset_0x00BE8A:
                rts
Offset_0x00BE8C:
                tst.w   Obj_Speed_Y(A0)                                  ; $001A
                bmi.s   Offset_0x00BEB2
                bsr     Player_Check_Floor                     ; Offset_0x009BD4
                tst.w   D1
                bpl.s   Offset_0x00BEB2
                add.w   D1, Obj_Y(A0)                                    ; $0014
                move.b  D3, Obj_Angle(A0)                                ; $0026
                bsr     Offset_0x00BF6A
                move.w  #$0000, Obj_Speed_Y(A0)                          ; $001A
                move.w  Obj_Speed_X(A0), Obj_Inertia(A0)          ; $0018, $001C
Offset_0x00BEB2:
                rts
Offset_0x00BEB4:
                bsr     Player_HitWall                         ; Offset_0x00A0BC
                tst.w   D1
                bpl.s   Offset_0x00BEC6
                sub.w   D1, Obj_X(A0)                                    ; $0010
                move.w  #$0000, Obj_Speed_X(A0)                          ; $0018
Offset_0x00BEC6:
                bsr     Offset_0x009EC6
                tst.w   D1
                bpl.s   Offset_0x00BED8
                add.w   D1, Obj_X(A0)                                    ; $0010
                move.w  #$0000, Obj_Speed_X(A0)                          ; $0018
Offset_0x00BED8:
                bsr     Player_DontRunOnWalls                  ; Offset_0x009F1C
                tst.w   D1
                bpl.s   Offset_0x00BF0E
                sub.w   D1, Obj_Y(A0)                                    ; $0014
                move.b  D3, D0
                addi.b  #$20, D0
                andi.b  #$40, D0
                bne.s   Offset_0x00BEF8
                move.w  #$0000, Obj_Speed_Y(A0)                          ; $001A
                rts
Offset_0x00BEF8:
                move.b  D3, Obj_Angle(A0)                                ; $0026
                bsr     Offset_0x00BF6A
                move.w  Obj_Speed_Y(A0), Obj_Inertia(A0)          ; $001A, $001C
                tst.b   D3
                bpl.s   Offset_0x00BF0E
                neg.w   Obj_Inertia(A0)                                  ; $001C
Offset_0x00BF0E:
                rts
Offset_0x00BF10:
                bsr     Offset_0x009EC6
                tst.w   D1
                bpl.s   Offset_0x00BF28
                add.w   D1, Obj_X(A0)                                    ; $0010
                move.w  #$0000, Obj_Speed_X(A0)                          ; $0018
                move.w  Obj_Speed_Y(A0), Obj_Inertia(A0)          ; $001A, $001C
Offset_0x00BF28:
                bsr     Player_DontRunOnWalls                  ; Offset_0x009F1C
                tst.w   D1
                bpl.s   Offset_0x00BF42
                sub.w   D1, Obj_Y(A0)                                    ; $0014
                tst.w   Obj_Speed_Y(A0)                                  ; $001A
                bpl.s   Offset_0x00BF40
                move.w  #$0000, Obj_Speed_Y(A0)                          ; $001A
Offset_0x00BF40:
                rts
Offset_0x00BF42:
                tst.w   Obj_Speed_Y(A0)                                  ; $001A
                bmi.s   Offset_0x00BF68
                bsr     Player_Check_Floor                     ; Offset_0x009BD4
                tst.w   D1
                bpl.s   Offset_0x00BF68
                add.w   D1, Obj_Y(A0)                                    ; $0014
                move.b  D3, Obj_Angle(A0)                                ; $0026
                bsr     Offset_0x00BF6A
                move.w  #$0000, Obj_Speed_Y(A0)                          ; $001A
                move.w  Obj_Speed_X(A0), Obj_Inertia(A0)          ; $0018, $001C
Offset_0x00BF68:
                rts
Offset_0x00BF6A:
                tst.b   Obj_Player_Spdsh_Flag(A0)                        ; $003D
                bne.s   Offset_0x00BFAE
                move.b  #$00, Obj_Ani_Number(A0)                         ; $0020
;-------------------------------------------------------------------------------                
Sonic_ResetOnFloor:                                            ; Offset_0x00BF76
                cmpi.l  #Obj_Miles, (A0)                       ; Offset_0x00D11E
                beq     Miles_ResetOnFloor                     ; Offset_0x00E7EE
                move.b  Obj_Height_2(A0), D0                             ; $001E
                move.b  Obj_Height_3(A0), Obj_Height_2(A0)        ; $001E, $0044
                move.b  Obj_Width_3(A0), Obj_Width_2(A0)          ; $001F, $0045
                btst    #$02, Obj_Status(A0)                             ; $002A
                beq.s   Offset_0x00BFAE
                bclr    #$02, Obj_Status(A0)                             ; $002A
                move.b  #$00, Obj_Ani_Number(A0)                         ; $0020
                sub.b   Obj_Height_3(A0), D0                             ; $0044
                ext.w   D0
                add.w   D0, Obj_Y(A0)                                    ; $0014
Offset_0x00BFAE:
                bclr    #$01, Obj_Status(A0)                             ; $002A
                bclr    #$05, Obj_Status(A0)                             ; $002A
                bclr    #$04, Obj_Status(A0)                             ; $002A
                move.b  #$00, Obj_Player_Jump(A0)                        ; $0040
                move.w  #$0000, (Enemy_Hit_Chain_Count).w            ; $FFFFF7D0
                move.b  #$00, Obj_Flip_Angle(A0)                         ; $0027
                move.b  #$00, Obj_Player_Flip_Flag(A0)                   ; $002D
                move.b  #$00, Obj_P_Flips_Remaining(A0)                  ; $0030
                move.b  #$00, Obj_Look_Up_Down_Time(A0)                  ; $0039
                cmpi.b  #$14, Obj_Ani_Number(A0)                         ; $0020
                bne.s   Offset_0x00BFF2
                move.b  #$00, Obj_Ani_Number(A0)                         ; $0020
Offset_0x00BFF2:
                tst.w   (CopySonicMovesForMilesIndex).w              ; $FFFFFE5A
                beq.s   Offset_0x00C00E
                bmi.s   Offset_0x00C010
                asr.w   Obj_Inertia(A0)                                  ; $001C
                asr.w   Obj_Speed_X(A0)                                  ; $0018
                move.w  #$0000, Obj_Speed_Y(A0)                          ; $001A
                move.w  #$0000, (CopySonicMovesForMilesIndex).w      ; $FFFFFE5A
Offset_0x00C00E:
                rts
Offset_0x00C010:
                move.w  #$0000, Obj_Speed_Y(A0)                          ; $001A
                move.w  #$0000, (CopySonicMovesForMilesIndex).w      ; $FFFFFE5A
                bsr     Reset_Player_Position_Array            ; Offset_0x00ACEC
                move.b  #$09, Obj_Ani_Number(A0)                         ; $0020
                move.w  #Rolling_Sfx, D0                                 ; $003C
                jsr     (Play_Music)                           ; Offset_0x001176
                move.b  #$01, Obj_Player_Spdsh_Flag(A0)                  ; $003D
                move.w  #$0000, Obj_Player_Spdsh_Cnt(A0)                 ; $003E
                rts  
;-------------------------------------------------------------------------------   
Sonic_Hurt:                                                    ; Offset_0x00C03E
                tst.w   (Debug_Mode_Active).w                        ; $FFFFFFFA
                beq.s   Sonic_Hurt_Normal                      ; Offset_0x00C058
                btst    #$04, (Control_Ports_Buffer_Data+$0001).w    ; $FFFFF605
                beq.s   Sonic_Hurt_Normal                      ; Offset_0x00C058
                move.w  #$0001, (Debug_Mode_Flag_Index).w            ; $FFFFFE08
                clr.b   (Control_Locked_Flag_P1).w                   ; $FFFFF7CC
                rts
;-------------------------------------------------------------------------------                
Sonic_Hurt_Normal:                                             ; Offset_0x00C058
                jsr     (SpeedToPos)                           ; Offset_0x01111E
                addi.w  #$0030, Obj_Speed_Y(A0)                          ; $001A
                btst    #$06, Obj_Status(A0)                             ; $002A
                beq.s   Offset_0x00C072
                subi.w  #$0020, Obj_Speed_Y(A0)                          ; $001A
Offset_0x00C072:
                cmpi.w  #$FF00, (Sonic_Level_Limits_Min_Y).w         ; $FFFFEE18
                bne.s   Offset_0x00C082
                move.w  (Screen_Wrap_Y).w, D0                        ; $FFFFEEAA
                and.w   D0, Obj_Y(A0)                                    ; $0014
Offset_0x00C082:
                bsr     Sonic_HurtStop                         ; Offset_0x00C098
                bsr     Sonic_LevelBoundaries                  ; Offset_0x00B560
                bsr     CopySonicMovesForMiles                 ; Offset_0x00ACA2
                bsr     Sonic_Animate_Check_2P                 ; Offset_0x00C2CC
                jmp     (DisplaySprite)                        ; Offset_0x011148
;-------------------------------------------------------------------------------
Sonic_HurtStop:                                                ; Offset_0x00C098
                move.w  (Sonic_Level_Limits_Max_Y).w, D0             ; $FFFFEE1A
                addi.w  #$00E0, D0
                cmp.w   Obj_Y(A0), D0                                    ; $0014
                blt     Kill_Sonic                             ; Offset_0x00C0EE
                movem.l A4-A6, -(A7)
                bsr     Sonic_Floor                            ; Offset_0x00BD7C
                movem.l (A7)+, A4-A6
                btst    #$01, Obj_Status(A0)                             ; $002A
                bne.s   Offset_0x00C0EC
                moveq   #$00, D0
                move.w  D0, Obj_Speed_Y(A0)                              ; $001A
                move.w  D0, Obj_Speed_X(A0)                              ; $0018
                move.w  D0, Obj_Inertia(A0)                              ; $001C
                move.b  D0, Obj_Player_Control(A0)                       ; $002E
                move.b  #$00, Obj_Ani_Number(A0)                         ; $0020
                move.w  #$0100, Obj_Priority(A0)                         ; $0008
                move.b  #$02, Obj_Routine(A0)                            ; $0005
                move.b  #$78, Obj_P_Invunerblt_Time(A0)                  ; $0034
                move.b  #$00, Obj_Player_Spdsh_Flag(A0)                  ; $003D
Offset_0x00C0EC:
                rts
;-------------------------------------------------------------------------------                
Kill_Sonic:                                                    ; Offset_0x00C0EE
                jmp     (Kill_Player)                          ; Offset_0x00A4A4                
;-------------------------------------------------------------------------------
Sonic_Death:                                                   ; Offset_0x00C0F4
                tst.w   (Debug_Mode_Active).w                        ; $FFFFFFFA
                beq.s   Offset_0x00C10E
                btst    #$04, (Control_Ports_Buffer_Data+$0001).w    ; $FFFFF605
                beq.s   Offset_0x00C10E
                move.w  #$0001, (Debug_Mode_Flag_Index).w            ; $FFFFFE08
                clr.b   (Control_Locked_Flag_P1).w                   ; $FFFFF7CC
                rts
Offset_0x00C10E:
                bsr     Player_GameOver                        ; Offset_0x00C126
                jsr     (ObjectFall)                           ; Offset_0x0110FE
                bsr     CopySonicMovesForMiles                 ; Offset_0x00ACA2
                bsr     Sonic_Animate_Check_2P                 ; Offset_0x00C2CC
                jmp     (DisplaySprite)                        ; Offset_0x011148
;-------------------------------------------------------------------------------                
Player_GameOver:                                               ; Offset_0x00C126
                cmpa.w  #Obj_Player_One, A0                              ; $B000
                bne.s   Offset_0x00C138
                move.w  (Camera_Y).w, D0                             ; $FFFFEE7C
                move.b  #$01, (Sonic_Scroll_Lock_Flag).w             ; $FFFFEE0A
                bra.s   Offset_0x00C142
Offset_0x00C138:
                move.w  (Camera_Y_P2).w, D0                          ; $FFFFEE64
                move.b  #$01, (Miles_Scroll_Lock_Flag).w             ; $FFFFEE0B
Offset_0x00C142:
                move.b  #$00, Obj_Player_Spdsh_Flag(A0)                  ; $003D
                addi.w  #$0100, D0
                tst.w   (Two_Player_Flag).w                          ; $FFFFFFD8
                beq.s   Offset_0x00C156
                subi.w  #$0070, D0
Offset_0x00C156:
                cmp.w   Obj_Y(A0), D0                                    ; $0014
                bge     Offset_0x00C20E
                tst.w   (Two_Player_Flag).w                          ; $FFFFFFD8
                bne     Offset_0x00C210
                cmpi.b  #$01, Obj_Player_Selected(A0)                    ; $0038
                bne.s   Offset_0x00C180
                cmpi.w  #$0002, (Player_Selected_Flag).w             ; $FFFFFF08
                beq.s   Offset_0x00C180
                move.b  #$02, Obj_Routine(A0)                            ; $0005
                bra     Miles_CPU_Despawn                      ; Offset_0x00D730
Offset_0x00C180:
                move.b  #$08, Obj_Routine(A0)                            ; $0005
                move.w  #$003C, Obj_Player_Spdsh_Cnt(A0)                 ; $003E
                addq.b  #$01, (HUD_Life_Refresh_Flag).w              ; $FFFFFE1C
                subq.b  #$01, (Life_Count).w                         ; $FFFFFE12
                bne.s   Offset_0x00C1E0
                move.w  #$0000, Obj_Player_Spdsh_Cnt(A0)                 ; $003E
                move.l  #Obj_Time_Over_Game_Over, (Obj_02_Mem_Address).w ; Offset_0x02444C, $FFFFB094
                move.l  #Obj_Time_Over_Game_Over, (Obj_Dynamic_RAM).w ; Offset_0x02444C, $FFFFB0DE
                move.b  #$00, (Obj_02_Mem_Address+Obj_Map_Id).w      ; $FFFFB0B6
                move.b  #$01, (Obj_Dynamic_RAM+Obj_Map_Id).w         ; $FFFFB100
                move.w  A0, (Obj_02_Mem_Address+Obj_Parent_Ref).w    ; $FFFFB0D2
                clr.b   (Time_Over_Flag).w                           ; $FFFFFE1A
Offset_0x00C1C0:
                clr.b   (HUD_Timer_Refresh_Flag).w                   ; $FFFFFE1E
                clr.b   (HUD_Timer_Refresh_Flag_P2).w                ; $FFFFFECA
                move.b  #$08, Obj_Routine(A0)                            ; $0005
                move.w  #Game_Over_Time_Over_Snd, D0                     ; $0027
                jsr     (Play_Music)                           ; Offset_0x001176
                moveq   #$03, D0
                jmp     (LoadPLC)                              ; Offset_0x0014D0
Offset_0x00C1E0:
                tst.b   (Time_Over_Flag).w                           ; $FFFFFE1A
                beq.s   Offset_0x00C20E
                move.w  #$0000, Obj_Player_Spdsh_Cnt(A0)                 ; $003E
                move.l  #Obj_Time_Over_Game_Over, (Obj_02_Mem_Address).w ; Offset_0x02444C, $FFFFB094
                move.l  #Obj_Time_Over_Game_Over, (Obj_Dynamic_RAM).w    ; Offset_0x02444C, $FFFFB0DE
                move.b  #$02, (Obj_02_Mem_Address+Obj_Map_Id).w      ; $FFFFB0B6
                move.b  #$03, (Obj_Dynamic_RAM+Obj_Map_Id).w         ; $FFFFB100
                move.w  A0, (Obj_02_Mem_Address+Obj_Parent_Ref).w    ; $FFFFB0D2
                bra.s   Offset_0x00C1C0
Offset_0x00C20E:
                rts
Offset_0x00C210:
                move.b  #$02, Obj_Routine(A0)                            ; $0005
                cmpa.w  #Obj_Player_One, A0                              ; $B000
                bne.s   Offset_0x00C244
                move.b  #$00, (Sonic_Scroll_Lock_Flag).w             ; $FFFFEE0A
                move.w  (Saved_Obj_X_P1).w, Obj_X(A0)         ; $FFFFFE32, $0010
                move.w  (Saved_Obj_Y_P1).w, Obj_Y(A0)         ; $FFFFFE34, $0014
                move.w  (Saved_Obj_Art_VRAM_P1).w, Obj_Art_VRAM(A0) ; $FFFFFE3C, $000A
                move.w  (Saved_Top_Solid_P1).w, Obj_Player_Top_Solid(A0) ; $FFFFFE3E, $0046
                clr.w   (Ring_Count_Address).w                       ; $FFFFFE20
                clr.b   (Ring_Status_Flag).w                         ; $FFFFFE1B
                bra.s   Offset_0x00C26A
Offset_0x00C244:
                move.b  #$00, (Miles_Scroll_Lock_Flag).w             ; $FFFFEE0B
                move.w  (Saved_Obj_X_P2).w, Obj_X(A0)         ; $FFFFFEE2, $0010
                move.w  (Saved_Obj_Y_P2).w, Obj_Y(A0)         ; $FFFFFEE4, $0014
                move.w  (Saved_Obj_Art_VRAM_P2).w, Obj_Art_VRAM(A0) ; $FFFFFEEC, $000A
                move.w  (Saved_Top_Solid_P2).w, Obj_Player_Top_Solid(A0) ; $FFFFFEEE, $0046
                clr.w   (Ring_Count_Address_P2).w                    ; $FFFFFED0
                clr.b   (Ring_Status_Flag_P2).w                      ; $FFFFFEC7
Offset_0x00C26A:
                move.b  #$00, Obj_Player_Control(A0)                     ; $002E
                move.b  #$05, Obj_Ani_Number(A0)                         ; $0020
                move.w  #$0000, Obj_Speed_X(A0)                          ; $0018
                move.w  #$0000, Obj_Speed_Y(A0)                          ; $001A
                move.w  #$0000, Obj_Inertia(A0)                          ; $001C
                move.b  #$02, Obj_Status(A0)                             ; $002A
                move.w  #$0000, Obj_P_Horiz_Ctrl_Lock(A0)                ; $0032
                move.w  #$0000, Obj_Player_Spdsh_Cnt(A0)                 ; $003E
                rts  
;-------------------------------------------------------------------------------
Sonic_ResetLevel:                                              ; Offset_0x00C29C
                tst.w   Obj_Player_Spdsh_Cnt(A0)                         ; $003E
                beq.s   Offset_0x00C2AE
                subq.w  #$01, Obj_Player_Spdsh_Cnt(A0)                   ; $003E
                bne.s   Offset_0x00C2AE
                move.w  #$0001, (Restart_Level_Flag).w               ; $FFFFFE02
Offset_0x00C2AE:
                rts   
;-------------------------------------------------------------------------------
Sonic_Animate:                                                 ; Offset_0x00C2B0
                tst.w   (Camera_RAM).w                               ; $FFFFEE00
                bne.s   Offset_0x00C2C2
                tst.w   (Vertical_Scrolling).w                       ; $FFFFEE02
                bne.s   Offset_0x00C2C2
                move.b  #$02, Obj_Routine(A0)                            ; $0005
Offset_0x00C2C2:
                bsr     Sonic_Animate_Check_2P                 ; Offset_0x00C2CC
                jmp     (DisplaySprite)                        ; Offset_0x011148
Sonic_Animate_Check_2P:                                        ; Offset_0x00C2CC
                tst.w   (Two_Player_Flag).w                          ; $FFFFFFD8
                bne.s   Offset_0x00C2D8
                bsr.s   Sonic_Animate_2                        ; Offset_0x00C2E0
                bra     Load_Sonic_Dynamic_PLC                 ; Offset_0x00C7EA
Offset_0x00C2D8:
                bsr     Sonic_Or_Knuckles_Animate_Sprite_2P    ; Offset_0x00C83E
                bra     Load_Sonic_2P_Dynamic_PLC              ; Offset_0x00CBA2
;-------------------------------------------------------------------------------
Sonic_Animate_2:                                               ; Offset_0x00C2E0
                lea     (Sonic_Animate_Data), A1               ; Offset_0x00C5A4
                tst.b   (Super_Sonic_Flag).w                         ; $FFFFFE19
                beq.s   Sonic_Animate_Sprite                   ; Offset_0x00C2F2
                lea     (Super_Sonic_Animate_Data), A1         ; Offset_0x00C768
Sonic_Animate_Sprite:                                          ; Offset_0x00C2F2
                moveq   #$00, D0
                move.b  Obj_Ani_Number(A0), D0                           ; $0020
                cmp.b   Obj_Ani_Flag(A0), D0                             ; $0021
                beq.s   Offset_0x00C314
                move.b  D0, Obj_Ani_Flag(A0)                             ; $0021
                move.b  #$00, Obj_Ani_Frame(A0)                          ; $0023
                move.b  #$00, Obj_Ani_Time(A0)                           ; $0024
                bclr    #$05, Obj_Status(A0)                             ; $002A
Offset_0x00C314:
                add.w   D0, D0
                adda.w  $00(A1, D0), A1
                move.b  (A1), D0
                bmi.s   Offset_0x00C384
                move.b  Obj_Status(A0), D1                               ; $002A
                andi.b  #$01, D1
                andi.b  #$FC, Obj_Flags(A0)                              ; $0004
                or.b    D1, Obj_Flags(A0)                                ; $0004
                subq.b  #$01, Obj_Ani_Time(A0)                           ; $0024
                bpl.s   Offset_0x00C352
                move.b  D0, Obj_Ani_Time(A0)                             ; $0024
Offset_0x00C33A:
                moveq   #$00, D1
                move.b  Obj_Ani_Frame(A0), D1                            ; $0023
                move.b  $01(A1, D1), D0
                cmpi.b  #$FC, D0
                bcc.s   Offset_0x00C354
Offset_0x00C34A:
                move.b  D0, Obj_Map_Id(A0)                               ; $0022
                addq.b  #$01, Obj_Ani_Frame(A0)                          ; $0023
Offset_0x00C352:
                rts
Offset_0x00C354:
                addq.b  #$01, D0
                bne.s   Offset_0x00C364
                move.b  #$00, Obj_Ani_Frame(A0)                          ; $0023
                move.b  $0001(A1), D0
                bra.s   Offset_0x00C34A
Offset_0x00C364:
                addq.b  #$01, D0
                bne.s   Offset_0x00C378
                move.b  $02(A1, D1), D0
                sub.b   D0, Obj_Ani_Frame(A0)                            ; $0023
                sub.b   D0, D1
                move.b  $01(A1, D1), D0
                bra.s   Offset_0x00C34A
Offset_0x00C378:
                addq.b  #$01, D0
                bne.s   Offset_0x00C382
                move.b  $02(A1, D1), Obj_Ani_Number(A0)                  ; $0020
Offset_0x00C382:
                rts
Offset_0x00C384:
                addq.b  #$01, D0
                bne     Offset_0x00C516
                moveq   #$00, D0
                move.b  Obj_Flip_Angle(A0), D0                           ; $0027
                bne     Offset_0x00C4B0
                moveq   #$00, D1
                move.b  Obj_Angle(A0), D0                                ; $0026
                bmi.s   Offset_0x00C3A0
                beq.s   Offset_0x00C3A0
                subq.b  #$01, D0
Offset_0x00C3A0:
                move.b  Obj_Status(A0), D2                               ; $002A
                andi.b  #$01, D2
                bne.s   Offset_0x00C3AC
                not.b   D0
Offset_0x00C3AC:
                addi.b  #$10, D0
                bpl.s   Offset_0x00C3B4
                moveq   #$03, D1
Offset_0x00C3B4:
                andi.b  #$FC, Obj_Flags(A0)                              ; $0004
                eor.b   D1, D2
                or.b    D2, Obj_Flags(A0)                                ; $0004
                btst    #$05, Obj_Status(A0)                             ; $002A
                bne     Offset_0x00C55E
                lsr.b   #$04, D0
                andi.b  #$06, D0
                move.w  Obj_Inertia(A0), D2                              ; $001C
                bpl.s   Offset_0x00C3D8
                neg.w   D2
Offset_0x00C3D8:
                tst.b   Obj_Player_Status(A0)                            ; $002F
                bpl     Offset_0x00C3E2
                add.w   D2, D2
Offset_0x00C3E2:
                tst.b   (Super_Sonic_Flag).w                         ; $FFFFFE19
                bne.s   Offset_0x00C43E
                lea     (Offset_0x00C5F6), A1
                cmpi.w  #$0600, D2
                bcc.s   Offset_0x00C3FC
                lea     (Offset_0x00C5EC), A1
                add.b   D0, D0
Offset_0x00C3FC:
                add.b   D0, D0
                move.b  D0, D3
                moveq   #$00, D1
                move.b  Obj_Ani_Frame(A0), D1                            ; $0023
                move.b  $01(A1, D1), D0
                cmpi.b  #$FF, D0
                bne.s   Offset_0x00C41A
                move.b  #$00, Obj_Ani_Frame(A0)                          ; $0023
                move.b  $0001(A1), D0
Offset_0x00C41A:
                move.b  D0, Obj_Map_Id(A0)                               ; $0022
                add.b   D3, Obj_Map_Id(A0)                               ; $0022
                subq.b  #$01, Obj_Ani_Time(A0)                           ; $0024
                bpl.s   Offset_0x00C43C
                neg.w   D2
                addi.w  #$0800, D2
                bpl.s   Offset_0x00C432
                moveq   #$00, D2
Offset_0x00C432:
                lsr.w   #$08, D2
                move.b  D2, Obj_Ani_Time(A0)                             ; $0024
                addq.b  #$01, Obj_Ani_Frame(A0)                          ; $0023
Offset_0x00C43C:
                rts
Offset_0x00C43E:
                lea     (Offset_0x00C7B2), A1
                cmpi.w  #$0800, D2
                bcc.s   Offset_0x00C456
                lea     (Offset_0x00C7A8), A1
                add.b   D0, D0
                add.b   D0, D0
                bra.s   Offset_0x00C458
Offset_0x00C456:
                lsr.b   #$01, D0
Offset_0x00C458:
                move.b  D0, D3
                moveq   #$00, D1
                move.b  Obj_Ani_Frame(A0), D1                            ; $0023
                move.b  $01(A1, D1), D0
                cmpi.b  #$FF, D0
                bne.s   Offset_0x00C474
                move.b  #$00, Obj_Ani_Frame(A0)                          ; $0023
                move.b  $0001(A1), D0
Offset_0x00C474:
                move.b  D0, Obj_Map_Id(A0)                               ; $0022
                add.b   D3, Obj_Map_Id(A0)                               ; $0022
                move.b  (Level_Frame_Count+$01).w, D1                ; $FFFFFE05
                andi.b  #$03, D1
                bne.s   Offset_0x00C494
                cmpi.b  #$B5, Obj_Map_Id(A0)                             ; $0022
                bcc.s   Offset_0x00C494
                addi.b  #$20, Obj_Map_Id(A0)                             ; $0022
Offset_0x00C494:
                subq.b  #$01, Obj_Ani_Time(A0)                           ; $0024
                bpl.s   Offset_0x00C4AE
                neg.w   D2
                addi.w  #$0800, D2
                bpl.s   Offset_0x00C4A4
                moveq   #$00, D2
Offset_0x00C4A4:
                lsr.w   #$08, D2
                move.b  D2, Obj_Ani_Time(A0)                             ; $0024
                addq.b  #$01, Obj_Ani_Frame(A0)                          ; $0023
Offset_0x00C4AE:
                rts
Offset_0x00C4B0:
                move.b  Obj_Flip_Angle(A0), D0                           ; $0027
                moveq   #$00, D1
                move.b  Obj_Status(A0), D2                               ; $002A
                andi.b  #$01, D2
                bne.s   Offset_0x00C4DE
                andi.b  #$FC, Obj_Flags(A0)                              ; $0004
                addi.b  #$0B, D0
                divu.w  #$0016, D0
                addi.b  #$5F, D0
                move.b  D0, Obj_Map_Id(A0)                               ; $0022
                move.b  #$00, Obj_Ani_Time(A0)                           ; $0024
                rts
Offset_0x00C4DE:
                andi.b  #$FC, Obj_Flags(A0)                              ; $0004
                tst.b   Obj_Player_Flip_Flag(A0)                         ; $002D
                beq.s   Offset_0x00C4F6
                ori.b   #$01, Obj_Flags(A0)                              ; $0004
                addi.b  #$0B, D0
                bra.s   Offset_0x00C502
Offset_0x00C4F6:
                ori.b   #$03, Obj_Flags(A0)                              ; $0004
                neg.b   D0
                addi.b  #$8F, D0
Offset_0x00C502:
                divu.w  #$0016, D0
                addi.b  #$5F, D0
                move.b  D0, Obj_Map_Id(A0)                               ; $0022
                move.b  #$00, Obj_Ani_Time(A0)                           ; $0024
                rts
Offset_0x00C516:
                subq.b  #$01, Obj_Ani_Time(A0)                           ; $0024
                bpl     Offset_0x00C352
                move.w  Obj_Inertia(A0), D2                              ; $001C
                bpl.s   Offset_0x00C526
                neg.w   D2
Offset_0x00C526:
                lea     (Offset_0x00C60A), A1
                cmpi.w  #$0600, D2
                bcc.s   Offset_0x00C538
                lea     (Offset_0x00C600), A1
Offset_0x00C538:
                neg.w   D2
                addi.w  #$0400, D2
                bpl.s   Offset_0x00C542
                moveq   #$00, D2
Offset_0x00C542:
                lsr.w   #$08, D2
                move.b  D2, Obj_Ani_Time(A0)                             ; $0024
                move.b  Obj_Status(A0), D1                               ; $002A
                andi.b  #$01, D1
                andi.b  #$FC, Obj_Flags(A0)                              ; $0004
                or.b    D1, Obj_Flags(A0)                                ; $0004
                bra     Offset_0x00C33A
Offset_0x00C55E:
                subq.b  #$01, Obj_Ani_Time(A0)                           ; $0024
                bpl     Offset_0x00C352
                move.w  Obj_Inertia(A0), D2                              ; $001C
                bmi.s   Offset_0x00C56E
                neg.w   D2
Offset_0x00C56E:
                addi.w  #$0800, D2
                bpl.s   Offset_0x00C576
                moveq   #$00, D2
Offset_0x00C576:
                lsr.w   #$06, D2
                move.b  D2, Obj_Ani_Time(A0)                             ; $0024
                lea     (Offset_0x00C614), A1
                tst.b   (Super_Sonic_Flag).w                         ; $FFFFFE19
                beq.s   Offset_0x00C58E
                lea     (Offset_0x00C7BC), A1
Offset_0x00C58E:
                move.b  Obj_Status(A0), D1                               ; $002A
                andi.b  #$01, D1
                andi.b  #$FC, Obj_Flags(A0)                              ; $0004
                or.b    D1, Obj_Flags(A0)                                ; $0004
                bra     Offset_0x00C33A      
;-------------------------------------------------------------------------------
Sonic_Animate_Data:                                            ; Offset_0x00C5A4
                dc.w    Offset_0x00C5EC-Sonic_Animate_Data
                dc.w    Offset_0x00C5F6-Sonic_Animate_Data
                dc.w    Offset_0x00C600-Sonic_Animate_Data
                dc.w    Offset_0x00C60A-Sonic_Animate_Data
                dc.w    Offset_0x00C614-Sonic_Animate_Data
                dc.w    Offset_0x00C61E-Sonic_Animate_Data
                dc.w    Offset_0x00C6D4-Sonic_Animate_Data
                dc.w    Offset_0x00C6DA-Sonic_Animate_Data
                dc.w    Offset_0x00C6DF-Sonic_Animate_Data
                dc.w    Offset_0x00C6E4-Sonic_Animate_Data
                dc.w    Offset_0x00C6F0-Sonic_Animate_Data
                dc.w    Offset_0x00C6F4-Sonic_Animate_Data
                dc.w    Offset_0x00C6F8-Sonic_Animate_Data
                dc.w    Offset_0x00C6FE-Sonic_Animate_Data
                dc.w    Offset_0x00C705-Sonic_Animate_Data
                dc.w    Offset_0x00C709-Sonic_Animate_Data
                dc.w    Offset_0x00C710-Sonic_Animate_Data
                dc.w    Offset_0x00C714-Sonic_Animate_Data
                dc.w    Offset_0x00C718-Sonic_Animate_Data
                dc.w    Offset_0x00C71E-Sonic_Animate_Data
                dc.w    Offset_0x00C723-Sonic_Animate_Data
                dc.w    Offset_0x00C727-Sonic_Animate_Data
                dc.w    Offset_0x00C72E-Sonic_Animate_Data
                dc.w    Offset_0x00C731-Sonic_Animate_Data
                dc.w    Offset_0x00C734-Sonic_Animate_Data
                dc.w    Offset_0x00C737-Sonic_Animate_Data
                dc.w    Offset_0x00C737-Sonic_Animate_Data
                dc.w    Offset_0x00C73A-Sonic_Animate_Data
                dc.w    Offset_0x00C73E-Sonic_Animate_Data
                dc.w    Offset_0x00C741-Sonic_Animate_Data
                dc.w    Offset_0x00C745-Sonic_Animate_Data
                dc.w    Offset_0x00C7D9-Sonic_Animate_Data
                dc.w    Offset_0x00C74D-Sonic_Animate_Data
                dc.w    Offset_0x00C751-Sonic_Animate_Data
                dc.w    Offset_0x00C755-Sonic_Animate_Data
                dc.w    Offset_0x00C75F-Sonic_Animate_Data
Offset_0x00C5EC:
                dc.b    $FF, $0F, $10, $11, $12, $13, $14, $0D
                dc.b    $0E, $FF
Offset_0x00C5F6:
                dc.b    $FF, $2D, $2E, $2F, $30, $FF, $FF, $FF
                dc.b    $FF, $FF
Offset_0x00C600:
                dc.b    $FE, $3D, $41, $3E, $41, $3F, $41, $40
                dc.b    $41, $FF
Offset_0x00C60A:
                dc.b    $FE, $3D, $41, $3E, $41, $3F, $41, $40
                dc.b    $41, $FF
Offset_0x00C614:
                dc.b    $FD, $48, $49, $4A, $4B, $FF, $FF, $FF
                dc.b    $FF, $FF
Offset_0x00C61E:
                dc.b    $05, $01, $01, $01, $01, $01, $01, $01
                dc.b    $01, $01, $01, $01, $01, $01, $01, $01
                dc.b    $01, $01, $01, $01, $01, $01, $01, $01
                dc.b    $01, $01, $01, $01, $01, $01, $01, $02
                dc.b    $03, $03, $03, $03, $03, $04, $04, $04
                dc.b    $05, $05, $05, $04, $04, $04, $05, $05
                dc.b    $05, $04, $04, $04, $05, $05, $05, $04
                dc.b    $04, $04, $05, $05, $05, $06, $06, $06
                dc.b    $06, $06, $06, $06, $06, $06, $06, $04
                dc.b    $04, $04, $05, $05, $05, $04, $04, $04
                dc.b    $05, $05, $05, $04, $04, $04, $05, $05
                dc.b    $05, $04, $04, $04, $05, $05, $05, $06
                dc.b    $06, $06, $06, $06, $06, $06, $06, $06
                dc.b    $06, $04, $04, $04, $05, $05, $05, $04
                dc.b    $04, $04, $05, $05, $05, $04, $04, $04
                dc.b    $05, $05, $05, $04, $04, $04, $05, $05
                dc.b    $05, $06, $06, $06, $06, $06, $06, $06
                dc.b    $06, $06, $06, $04, $04, $04, $05, $05
                dc.b    $05, $04, $04, $04, $05, $05, $05, $04
                dc.b    $04, $04, $05, $05, $05, $04, $04, $04
                dc.b    $05, $05, $05, $06, $06, $06, $06, $06
                dc.b    $06, $06, $06, $06, $06, $07, $08, $08
                dc.b    $08, $09, $09, $09, $FE, $06
Offset_0x00C6D4:
                dc.b    $09, $CC, $CD, $CE, $CD, $FF
Offset_0x00C6DA:
                dc.b    $05, $0B, $0C, $FE, $01
Offset_0x00C6DF:
                dc.b    $05, $4C, $4D, $FE, $01
Offset_0x00C6E4:
                dc.b    $00, $42, $43, $42, $44, $42, $45, $42
                dc.b    $46, $42, $47, $FF
Offset_0x00C6F0:
                dc.b    $01, $02, $FD, $00
Offset_0x00C6F4:
                dc.b    $03, $0A, $FD, $00
Offset_0x00C6F8:
                dc.b    $03, $C8, $C9, $CA, $CB, $FF
Offset_0x00C6FE:
                dc.b    $05, $D2, $D3, $D4, $D5, $FD, $00
Offset_0x00C705:
                dc.b    $07, $54, $59, $FF
Offset_0x00C709:
                dc.b    $07, $54, $55, $56, $57, $58, $FF
Offset_0x00C710:
                dc.b    $2F, $5B, $FD, $00
Offset_0x00C714:
                dc.b    $01, $50, $51, $FF
Offset_0x00C718:
                dc.b    $0F, $43, $43, $43, $FE, $01
Offset_0x00C71E:
                dc.b    $0F, $43, $44, $FE, $01
Offset_0x00C723:
                dc.b    $13, $6B, $6C, $FF
Offset_0x00C727:
                dc.b    $0B, $5A, $5A, $11, $12, $FD, $00
Offset_0x00C72E:
                dc.b    $20, $5E, $FF
Offset_0x00C731:
                dc.b    $20, $5D, $FF
Offset_0x00C734:
                dc.b    $20, $5C, $FF
Offset_0x00C737:
                dc.b    $40, $4E, $FF
Offset_0x00C73A:
                dc.b    $09, $4E, $4F, $FF
Offset_0x00C73E:
                dc.b    $77, $00, $FF
Offset_0x00C741:
                dc.b    $13, $D0, $D1, $FF
Offset_0x00C745:
                dc.b    $03, $CF, $C8, $C9, $CA, $CB, $FE, $04
Offset_0x00C74D:
                dc.b    $09, $08, $09, $FF
Offset_0x00C751:
                dc.b    $03, $07, $FD, $00
Offset_0x00C755:
                dc.b    $0B, $ED, $EE, $EF, $F0, $F1, $F0, $EF
                dc.b    $EE, $FF
Offset_0x00C75F:
                dc.b    $0B, $ED, $EE, $EF, $F0, $F1, $FD, $00
                dc.b    $00
;-------------------------------------------------------------------------------
Super_Sonic_Animate_Data:                                      ; Offset_0x00C768
                dc.w    Offset_0x00C7A8-Super_Sonic_Animate_Data
                dc.w    Offset_0x00C7B2-Super_Sonic_Animate_Data
                dc.w    Offset_0x00C600-Super_Sonic_Animate_Data
                dc.w    Offset_0x00C60A-Super_Sonic_Animate_Data
                dc.w    Offset_0x00C7BC-Super_Sonic_Animate_Data
                dc.w    Offset_0x00C7C6-Super_Sonic_Animate_Data
                dc.w    Offset_0x00C7CC-Super_Sonic_Animate_Data
                dc.w    Offset_0x00C6DA-Super_Sonic_Animate_Data
                dc.w    Offset_0x00C7D6-Super_Sonic_Animate_Data
                dc.w    Offset_0x00C6E4-Super_Sonic_Animate_Data
                dc.w    Offset_0x00C6F0-Super_Sonic_Animate_Data
                dc.w    Offset_0x00C6F4-Super_Sonic_Animate_Data
                dc.w    Offset_0x00C6F8-Super_Sonic_Animate_Data
                dc.w    Offset_0x00C6FE-Super_Sonic_Animate_Data
                dc.w    Offset_0x00C705-Super_Sonic_Animate_Data
                dc.w    Offset_0x00C709-Super_Sonic_Animate_Data
                dc.w    Offset_0x00C710-Super_Sonic_Animate_Data
                dc.w    Offset_0x00C714-Super_Sonic_Animate_Data
                dc.w    Offset_0x00C718-Super_Sonic_Animate_Data
                dc.w    Offset_0x00C71E-Super_Sonic_Animate_Data
                dc.w    Offset_0x00C723-Super_Sonic_Animate_Data
                dc.w    Offset_0x00C727-Super_Sonic_Animate_Data
                dc.w    Offset_0x00C72E-Super_Sonic_Animate_Data
                dc.w    Offset_0x00C731-Super_Sonic_Animate_Data
                dc.w    Offset_0x00C734-Super_Sonic_Animate_Data
                dc.w    Offset_0x00C737-Super_Sonic_Animate_Data
                dc.w    Offset_0x00C737-Super_Sonic_Animate_Data
                dc.w    Offset_0x00C73A-Super_Sonic_Animate_Data
                dc.w    Offset_0x00C73E-Super_Sonic_Animate_Data
                dc.w    Offset_0x00C741-Super_Sonic_Animate_Data
                dc.w    Offset_0x00C745-Super_Sonic_Animate_Data
                dc.w    Offset_0x00C7D9-Super_Sonic_Animate_Data
Offset_0x00C7A8:
                dc.b    $FF, $77, $78, $79, $7A, $7B, $7C, $75
                dc.b    $76, $FF
Offset_0x00C7B2:
                dc.b    $FF, $B5, $B9, $FF, $FF, $FF, $FF, $FF
                dc.b    $FF, $FF
Offset_0x00C7BC:
                dc.b    $FD, $BD, $BE, $BF, $C0, $FF, $FF, $FF
                dc.b    $FF, $FF
Offset_0x00C7C6:
                dc.b    $07, $72, $73, $74, $73, $FF
Offset_0x00C7CC:
                dc.b    $09, $C2, $C3, $C4, $C3, $C5, $C6, $C7
                dc.b    $C6, $FF
Offset_0x00C7D6:
                dc.b    $05, $C1, $FF
Offset_0x00C7D9:
                dc.b    $02, $6D, $6D, $6E, $6E, $6F, $70, $71
                dc.b    $70, $71, $70, $71, $70, $71, $FD, $00
                dc.b    $00   
;-------------------------------------------------------------------------------
Load_Sonic_Dynamic_PLC:                                        ; Offset_0x00C7EA
                moveq   #$00, D0
                move.b  Obj_Map_Id(A0), D0                               ; $0022
Load_Sonic_Dynamic_PLC_D0:                                     ; Offset_0x00C7F0
                cmp.b   (Sonic_Previous_Frame).w, D0                 ; $FFFFF766
                beq.s   Offset_0x00C83C
                move.b  D0, (Sonic_Previous_Frame).w                 ; $FFFFF766
                lea     (Sonic_Dyn_Script), A2                 ; Offset_0x101622
                add.w   D0, D0
                adda.w  $00(A2, D0), A2
                move.w  (A2)+, D5
                subq.w  #$01, D5
                bmi.s   Offset_0x00C83C
                move.w  #$D000, D4
Loop_Load_Sonic_Art:                                           ; Offset_0x00C810
                moveq   #$00, D1
                move.w  (A2)+, D1
                move.w  D1, D3
                lsr.w   #$08, D3
                andi.w  #$00F0, D3
                addi.w  #$0010, D3
                andi.w  #$0FFF, D1
                lsl.l   #$05, D1
                addi.l  #Art_Sonic, D1                         ; Offset_0x050000
                move.w  D4, D2
                add.w   D3, D4
                add.w   D3, D4
                jsr     (DMA_68KtoVRAM)                        ; Offset_0x0012FC
                dbra    D5, Loop_Load_Sonic_Art                ; Offset_0x00C810
Offset_0x00C83C:
                rts 
;-------------------------------------------------------------------------------  
Sonic_Or_Knuckles_Animate_Sprite_2P:                           ; Offset_0x00C83E
                lea     (Sonic_2P_AnimateData), A1             ; Offset_0x00CA8C
                tst.b   Obj_Player_Selected(A0)                          ; $0038
                beq.s   Sonic_Or_Knuckles_Animate_Sprite_2P_A1 ; Offset_0x00C850
                lea     (Knuckles_2P_AnimateData), A1          ; Offset_0x00CAD4
Sonic_Or_Knuckles_Animate_Sprite_2P_A1:                        ; Offset_0x00C850
                moveq   #$00, D0
                move.b  Obj_Ani_Number(A0), D0                           ; $0020
                cmp.b   Obj_Ani_Flag(A0), D0                             ; $0021
                beq.s   Offset_0x00C872
                move.b  D0, Obj_Ani_Flag(A0)                             ; $0021
                move.b  #$00, Obj_Ani_Frame(A0)                          ; $0023
                move.b  #$00, Obj_Ani_Time(A0)                           ; $0024
                bclr    #$05, Obj_Status(A0)                             ; $002A
Offset_0x00C872:
                add.w   D0, D0
                adda.w  $00(A1, D0), A1
                move.b  (A1), D0
                bmi.s   Offset_0x00C8E2
                move.b  Obj_Status(A0), D1                               ; $002A
                andi.b  #$01, D1
                andi.b  #$FC, Obj_Flags(A0)                              ; $0004
                or.b    D1, Obj_Flags(A0)                                ; $0004
                subq.b  #$01, Obj_Ani_Time(A0)                           ; $0024
                bpl.s   Offset_0x00C8B0
                move.b  D0, Obj_Ani_Time(A0)                             ; $0024
Offset_0x00C898:
                moveq   #$00, D1
                move.b  Obj_Ani_Frame(A0), D1                            ; $0023
                move.b  $01(A1, D1), D0
                cmpi.b  #$FC, D0
                bcc.s   Offset_0x00C8B2
Offset_0x00C8A8:
                move.b  D0, Obj_Map_Id(A0)                               ; $0022
                addq.b  #$01, Obj_Ani_Frame(A0)                          ; $0023
Offset_0x00C8B0:
                rts
Offset_0x00C8B2:
                addq.b  #$01, D0
                bne.s   Offset_0x00C8C2
                move.b  #$00, Obj_Ani_Frame(A0)                          ; $0023
                move.b  $0001(A1), D0
                bra.s   Offset_0x00C8A8
Offset_0x00C8C2:
                addq.b  #$01, D0
                bne.s   Offset_0x00C8D6
                move.b  $02(A1, D1), D0
                sub.b   D0, Obj_Ani_Frame(A0)                            ; $0023
                sub.b   D0, D1
                move.b  $01(A1, D1), D0
                bra.s   Offset_0x00C8A8
Offset_0x00C8D6:
                addq.b  #$01, D0
                bne.s   Offset_0x00C8E0
                move.b  $02(A1, D1), Obj_Ani_Number(A0)                  ; $0020
Offset_0x00C8E0:
                rts
Offset_0x00C8E2:
                addq.b  #$01, D0
                bne     Offset_0x00C9FC
                moveq   #$00, D0
                move.b  Obj_Flip_Angle(A0), D0                           ; $0027
                bne     Offset_0x00C996
                moveq   #$00, D1
                move.b  Obj_Angle(A0), D0                                ; $0026
                bmi.s   Offset_0x00C8FE
                beq.s   Offset_0x00C8FE
                subq.b  #$01, D0
Offset_0x00C8FE:
                move.b  Obj_Status(A0), D2                               ; $002A
                andi.b  #$01, D2
                bne.s   Offset_0x00C90A
                not.b   D0
Offset_0x00C90A:
                addi.b  #$10, D0
                bpl.s   Offset_0x00C912
                moveq   #$03, D1
Offset_0x00C912:
                andi.b  #$FC, Obj_Flags(A0)                              ; $0004
                eor.b   D1, D2
                or.b    D2, Obj_Flags(A0)                                ; $0004
                btst    #$05, Obj_Status(A0)                             ; $002A
                bne     Offset_0x00CA44
                lsr.b   #$05, D0
                andi.b  #$03, D0
                move.w  Obj_Inertia(A0), D2                              ; $001C
                bpl.s   Offset_0x00C936
                neg.w   D2
Offset_0x00C936:
                tst.b   Obj_Player_Status(A0)                            ; $002F
                bpl     Offset_0x00C940
                add.w   D2, D2
Offset_0x00C940:
                move.b  D0, D3
                lea     (Offset_0x00CB22), A1
                cmpi.w  #$0600, D2
                bcc.s   Offset_0x00C956
                lea     (Offset_0x00CB1C), A1
                add.b   D0, D0
Offset_0x00C956:
                add.b   D0, D3
                moveq   #$00, D1
                move.b  Obj_Ani_Frame(A0), D1                            ; $0023
                move.b  $01(A1, D1), D0
                cmpi.b  #$FF, D0
                bne.s   Offset_0x00C972
                move.b  #$00, Obj_Ani_Frame(A0)                          ; $0023
                move.b  $0001(A1), D0
Offset_0x00C972:
                move.b  D0, Obj_Map_Id(A0)                               ; $0022
                add.b   D3, Obj_Map_Id(A0)                               ; $0022
                subq.b  #$01, Obj_Ani_Time(A0)                           ; $0024
                bpl.s   Offset_0x00C994
                neg.w   D2
                addi.w  #$0800, D2
                bpl.s   Offset_0x00C98A
                moveq   #$00, D2
Offset_0x00C98A:
                lsr.w   #$08, D2
                move.b  D2, Obj_Ani_Time(A0)                             ; $0024
                addq.b  #$01, Obj_Ani_Frame(A0)                          ; $0023
Offset_0x00C994:
                rts
Offset_0x00C996:
                move.b  Obj_Flip_Angle(A0), D0                           ; $0027
                moveq   #$00, D1
                move.b  Obj_Status(A0), D2                               ; $002A
                andi.b  #$01, D2
                bne.s   Offset_0x00C9C4
                andi.b  #$FC, Obj_Flags(A0)                              ; $0004
                addi.b  #$16, D0
                divu.w  #$002C, D0
                addi.b  #$15, D0
                move.b  D0, Obj_Map_Id(A0)                               ; $0022
                move.b  #$00, Obj_Ani_Time(A0)                           ; $0024
                rts
Offset_0x00C9C4:
                andi.b  #$FC, Obj_Flags(A0)                              ; $0004
                tst.b   Obj_Player_Flip_Flag(A0)                         ; $002D
                beq.s   Offset_0x00C9DC
                ori.b   #$01, Obj_Flags(A0)                              ; $0004
                addi.b  #$16, D0
                bra.s   Offset_0x00C9E8
Offset_0x00C9DC:
                ori.b   #$03, Obj_Flags(A0)                              ; $0004
                neg.b   D0
                addi.b  #$9A, D0
Offset_0x00C9E8:
                divu.w  #$002C, D0
                addi.b  #$15, D0
                move.b  D0, Obj_Map_Id(A0)                               ; $0022
                move.b  #$00, Obj_Ani_Time(A0)                           ; $0024
                rts
Offset_0x00C9FC:
                subq.b  #$01, Obj_Ani_Time(A0)                           ; $0024
                bpl     Offset_0x00C8B0
                move.w  Obj_Inertia(A0), D2                              ; $001C
                bpl.s   Offset_0x00CA0C
                neg.w   D2
Offset_0x00CA0C:
                lea     (Offset_0x00CB2E), A1
                cmpi.w  #$0600, D2
                bcc.s   Offset_0x00CA1E
                lea     (Offset_0x00CB28), A1
Offset_0x00CA1E:
                neg.w   D2
                addi.w  #$0400, D2
                bpl.s   Offset_0x00CA28
                moveq   #$00, D2
Offset_0x00CA28:
                lsr.w   #$08, D2
                move.b  D2, Obj_Ani_Time(A0)                             ; $0024
                move.b  Obj_Status(A0), D1                               ; $002A
                andi.b  #$01, D1
                andi.b  #$FC, Obj_Flags(A0)                              ; $0004
                or.b    D1, Obj_Flags(A0)                                ; $0004
                bra     Offset_0x00C898
Offset_0x00CA44:
                subq.b  #$01, Obj_Ani_Time(A0)                           ; $0024
                bpl     Offset_0x00C8B0
                move.w  Obj_Inertia(A0), D2                              ; $001C
                bmi.s   Offset_0x00CA54
                neg.w   D2
Offset_0x00CA54:
                addi.w  #$0800, D2
                bpl.s   Offset_0x00CA5C
                moveq   #$00, D2
Offset_0x00CA5C:
                lsr.w   #$06, D2
                lea     (Offset_0x00CB34), A1
                tst.b   Obj_Player_Selected(A0)                          ; $0038
                beq.s   Offset_0x00CA72
                lea     (Offset_0x00CB3A), A1
                lsr.w   #$02, D2
Offset_0x00CA72:
                move.b  D2, Obj_Ani_Time(A0)                             ; $0024
                move.b  Obj_Status(A0), D1                               ; $002A
                andi.b  #$01, D1
                andi.b  #$FC, Obj_Flags(A0)                              ; $0004
                or.b    D1, Obj_Flags(A0)                                ; $0004
                bra     Offset_0x00C898   
;-------------------------------------------------------------------------------
Sonic_2P_AnimateData:                                          ; Offset_0x00CA8C
                dc.w    Offset_0x00CB1C-Sonic_2P_AnimateData
                dc.w    Offset_0x00CB22-Sonic_2P_AnimateData
                dc.w    Offset_0x00CB28-Sonic_2P_AnimateData
                dc.w    Offset_0x00CB2E-Sonic_2P_AnimateData
                dc.w    Offset_0x00CB34-Sonic_2P_AnimateData
                dc.w    Offset_0x00CB40-Sonic_2P_AnimateData
                dc.w    Offset_0x00CB40-Sonic_2P_AnimateData
                dc.w    Offset_0x00CB40-Sonic_2P_AnimateData
                dc.w    Offset_0x00CB5B-Sonic_2P_AnimateData
                dc.w    Offset_0x00CB5E-Sonic_2P_AnimateData
                dc.w    Offset_0x00CB40-Sonic_2P_AnimateData
                dc.w    Offset_0x00CB40-Sonic_2P_AnimateData
                dc.w    Offset_0x00CB40-Sonic_2P_AnimateData
                dc.w    Offset_0x00CB62-Sonic_2P_AnimateData
                dc.w    Offset_0x00CB69-Sonic_2P_AnimateData
                dc.w    Offset_0x00CB6C-Sonic_2P_AnimateData
                dc.w    Offset_0x00CB6F-Sonic_2P_AnimateData
                dc.w    Offset_0x00CB73-Sonic_2P_AnimateData
                dc.w    Offset_0x00CB76-Sonic_2P_AnimateData
                dc.w    Offset_0x00CB79-Sonic_2P_AnimateData
                dc.w    Offset_0x00CB7C-Sonic_2P_AnimateData
                dc.w    Offset_0x00CB7F-Sonic_2P_AnimateData
                dc.w    Offset_0x00CB82-Sonic_2P_AnimateData
                dc.w    Offset_0x00CB85-Sonic_2P_AnimateData
                dc.w    Offset_0x00CB88-Sonic_2P_AnimateData
                dc.w    Offset_0x00CB8B-Sonic_2P_AnimateData
                dc.w    Offset_0x00CB8B-Sonic_2P_AnimateData
                dc.w    Offset_0x00CB8E-Sonic_2P_AnimateData
                dc.w    Offset_0x00CB91-Sonic_2P_AnimateData
                dc.w    Offset_0x00CB40-Sonic_2P_AnimateData
                dc.w    Offset_0x00CB40-Sonic_2P_AnimateData
                dc.w    Offset_0x00C7D9-Sonic_2P_AnimateData
                dc.w    Offset_0x00CB94-Sonic_2P_AnimateData
                dc.w    Offset_0x00CB97-Sonic_2P_AnimateData
                dc.w    Offset_0x00CB9B-Sonic_2P_AnimateData
                dc.w    Offset_0x00CB9E-Sonic_2P_AnimateData
;-------------------------------------------------------------------------------
Knuckles_2P_AnimateData:                                       ; Offset_0x00CAD4
                dc.w    Offset_0x00CB1C-Knuckles_2P_AnimateData
                dc.w    Offset_0x00CB22-Knuckles_2P_AnimateData
                dc.w    Offset_0x00CB28-Knuckles_2P_AnimateData
                dc.w    Offset_0x00CB2E-Knuckles_2P_AnimateData
                dc.w    Offset_0x00CB3A-Knuckles_2P_AnimateData
                dc.w    Offset_0x00CB40-Knuckles_2P_AnimateData
                dc.w    Offset_0x00CB40-Knuckles_2P_AnimateData
                dc.w    Offset_0x00CB40-Knuckles_2P_AnimateData
                dc.w    Offset_0x00CB5B-Knuckles_2P_AnimateData
                dc.w    Offset_0x00CB5E-Knuckles_2P_AnimateData
                dc.w    Offset_0x00CB40-Knuckles_2P_AnimateData
                dc.w    Offset_0x00CB40-Knuckles_2P_AnimateData
                dc.w    Offset_0x00CB40-Knuckles_2P_AnimateData
                dc.w    Offset_0x00CB62-Knuckles_2P_AnimateData
                dc.w    Offset_0x00CB69-Knuckles_2P_AnimateData
                dc.w    Offset_0x00CB6C-Knuckles_2P_AnimateData
                dc.w    Offset_0x00CB6F-Knuckles_2P_AnimateData
                dc.w    Offset_0x00CB73-Knuckles_2P_AnimateData
                dc.w    Offset_0x00CB76-Knuckles_2P_AnimateData
                dc.w    Offset_0x00CB79-Knuckles_2P_AnimateData
                dc.w    Offset_0x00CB7C-Knuckles_2P_AnimateData
                dc.w    Offset_0x00CB7F-Knuckles_2P_AnimateData
                dc.w    Offset_0x00CB82-Knuckles_2P_AnimateData
                dc.w    Offset_0x00CB85-Knuckles_2P_AnimateData
                dc.w    Offset_0x00CB88-Knuckles_2P_AnimateData
                dc.w    Offset_0x00CB8B-Knuckles_2P_AnimateData
                dc.w    Offset_0x00CB8B-Knuckles_2P_AnimateData
                dc.w    Offset_0x00CB8E-Knuckles_2P_AnimateData
                dc.w    Offset_0x00CB91-Knuckles_2P_AnimateData
                dc.w    Offset_0x00CB40-Knuckles_2P_AnimateData
                dc.w    Offset_0x00CB40-Knuckles_2P_AnimateData
                dc.w    Offset_0x00C7D9-Knuckles_2P_AnimateData
                dc.w    Offset_0x00CB94-Knuckles_2P_AnimateData
                dc.w    Offset_0x00CB97-Knuckles_2P_AnimateData
                dc.w    Offset_0x00CB9B-Knuckles_2P_AnimateData
                dc.w    Offset_0x00CB9E-Knuckles_2P_AnimateData
;-------------------------------------------------------------------------------
Offset_0x00CB1C:
                dc.b    $FF, $01, $02, $03, $02, $FF
Offset_0x00CB22:
                dc.b    $FF, $0D, $0E, $FF, $FF, $FF
Offset_0x00CB28:
                dc.b    $FE, $29, $28, $2A, $28, $FF
Offset_0x00CB2E:
                dc.b    $FE, $29, $28, $2A, $28, $FF
Offset_0x00CB34:
                dc.b    $FD, $25, $26, $FF, $FF, $FF
Offset_0x00CB3A:                
                dc.b    $FD, $25, $26, $27, $26, $FF
Offset_0x00CB40:
                dc.b    $07, $1B, $1B, $1B, $1B, $1B, $1B, $1B
                dc.b    $1B, $1C, $1C, $1C, $1C, $1C, $1C, $1D
                dc.b    $1E, $1D, $1E, $1D, $1E, $1D, $1E, $1D
                dc.b    $1E, $FE, $10
Offset_0x00CB5B:
                dc.b    $05, $2B, $FF
Offset_0x00CB5E:
                dc.b    $00, $23, $24, $FF
Offset_0x00CB62:
                dc.b    $05, $22, $22, $22, $22, $FD, $00
Offset_0x00CB69:
                dc.b    $07, $15, $FF
Offset_0x00CB6C:
                dc.b    $07, $15, $FF
Offset_0x00CB6F:
                dc.b    $2F, $15, $FD, $00
Offset_0x00CB73:
                dc.b    $01, $15, $FF
Offset_0x00CB76:
                dc.b    $0F, $15, $FF
Offset_0x00CB79:
                dc.b    $0F, $1F, $FF
Offset_0x00CB7C:
                dc.b    $13, $15, $FF
Offset_0x00CB7F:
                dc.b    $0B, $15, $FF
Offset_0x00CB82:
                dc.b    $20, $20, $FF
Offset_0x00CB85:
                dc.b    $20, $20, $FF
Offset_0x00CB88:
                dc.b    $20, $20, $FF
Offset_0x00CB8B:
                dc.b    $40, $21, $FF
Offset_0x00CB8E:
                dc.b    $09, $21, $FF
Offset_0x00CB91:
                dc.b    $77, $00, $FF
Offset_0x00CB94:
                dc.b    $09, $1B, $FF
Offset_0x00CB97:
                dc.b    $03, $1B, $FD, $00
Offset_0x00CB9B:
                dc.b    $0B, $1B, $FF
Offset_0x00CB9E:
                dc.b    $0B, $1B, $FF, $00   
;-------------------------------------------------------------------------------
Load_Sonic_2P_Dynamic_PLC:                                     ; Offset_0x00CBA2
                moveq   #$00, D0
                move.b  Obj_Map_Id(A0), D0                               ; $0022
                lea     (Sonic_Dyn_Script_2P), A2              ; Offset_0x102E1A
                move.l  #Art_Sonic_2P, D6                      ; Offset_0x077560     
                tst.b   Obj_Player_Selected(A0)                          ; $0038
                beq.s   Offset_0x00CBC6
                lea     (Knuckles_Dyn_Script_2P), A2           ; Offset_0x1034CE
                move.l  #Art_Knuckles_2P, D6                   ; Offset_0x07D960
Offset_0x00CBC6:
                add.w   D0, D0
                adda.w  $00(A2, D0), A2
                move.w  (A2)+, D5
                subq.w  #$01, D5
                bmi.s   Offset_0x00CC08
                move.w  #$D000, D4
                cmpa.w  #Obj_Player_One, A0                              ; $B000
                beq.s   Offset_0x00CBE0
                move.w  #$D400, D4
Offset_0x00CBE0:
                moveq   #$00, D1
                move.w  (A2)+, D1
                move.w  D1, D3
                lsr.w   #$08, D3
                andi.w  #$00F0, D3
                addi.w  #$0010, D3
                andi.w  #$0FFF, D1
                lsl.l   #$05, D1
                add.l   D6, D1
                move.w  D4, D2
                add.w   D3, D4
                add.w   D3, D4
                jsr     (DMA_68KtoVRAM)                        ; Offset_0x0012FC
                dbra    D5, Offset_0x00CBE0
Offset_0x00CC08:
                rts                                                                                                                                                                                                        
;===============================================================================
; Objeto Sonic
; <<<-  
;===============================================================================  