;===============================================================================
; Objeto Rabos do Miles
; ->>>  
;===============================================================================
; Offset_0x00D11E:
                lea     (Miles_Max_Speed).w, A4                         ; $FFFFFEC0
                lea     (Distance_From_Top_P2).w, A5                 ; $FFFFEE2E
                lea     (Obj_P2_Dust_Water_Splash).w, A6             ; $FFFFCC9E
                cmpi.w  #Miles_Alone, (Player_Selected_Flag).w  ; $0002, $FFFFFF08
                bne.s   Offset_0x00D144
                move.w  (Sonic_Level_Limits_Min_X).w, (Miles_Level_Limits_Min_X).w ; $FFFFEE14, $FFFFEE1C
                move.w  (Sonic_Level_Limits_Max_X).w, (Miles_Level_Limits_Max_X).w ; $FFFFEE16, $FFFFEE1E
                move.w  (Sonic_Level_Limits_Max_Y).w, (Miles_Level_Limits_Max_Y).w ; $FFFFEE1A, $FFFFEE22
Offset_0x00D144:
                moveq   #$00, D0
                move.b  Obj_Routine(A0), D0                              ; $0005
                move.w  Miles_Index(PC, D0), D1                ; Offset_0x00D152
                jmp     Miles_Index(PC, D1)                    ; Offset_0x00D152
;-------------------------------------------------------------------------------                
Miles_Index:                                                   ; Offset_0x00D152
                dc.w    Miles_Main-Miles_Index                 ; Offset_0x00D15E
                dc.w    Miles_Control-Miles_Index              ; Offset_0x00D24A
                dc.w    Miles_Hurt-Miles_Index                 ; Offset_0x00E86E
                dc.w    Miles_Death-Miles_Index                ; Offset_0x00E90A
                dc.w    Miles_ResetLevel-Miles_Index           ; Offset_0x00E922
                dc.w    Miles_Respawning-Miles_Index           ; Offset_0x00E936
;-------------------------------------------------------------------------------
Miles_Main:                                                    ; Offset_0x00D15E
                addq.b  #$02, Obj_Routine(A0)                            ; $0005
                move.b  #$0F, Obj_Height_2(A0)                           ; $001E
                move.b  #$09, Obj_Width_2(A0)                            ; $001F
                move.b  #$0F, Obj_Height_3(A0)                           ; $0044
                move.b  #$09, Obj_Width_3(A0)                            ; $0045
                move.l  #Miles_Mappings, Obj_Map(A0)    ; Offset_0x101FF4, $000C
                move.w  #$0100, Obj_Priority(A0)                         ; $0008
                move.b  #$18, Obj_Width(A0)                              ; $0007
                move.b  #$18, Obj_Height(A0)                             ; $0006
                move.b  #$84, Obj_Flags(A0)                              ; $0004
                move.b  #$01, Obj_Player_Selected(A0)                    ; $0038
                move.w  #$0600, (A4)
                move.w  #$000C, Acceleration(A4)                         ; $0002
                move.w  #$0080, Deceleration(A4)                         ; $0004
                cmpi.w  #$0002, (Player_Selected_Flag).w             ; $FFFFFF08
                bne.s   Offset_0x00D1EA
                tst.b   (Saved_Level_Flag).w                         ; $FFFFFE30
                bne.s   Offset_0x00D202
                move.w  #$06A0, Obj_Art_VRAM(A0)                         ; $000A
                move.b  #$0C, Obj_Player_Top_Solid(A0)                   ; $0046
                move.b  #$0D, Obj_Player_LRB_Solid(A0)                   ; $0047
                move.w  Obj_X(A0), (Saved_Obj_X_P1).w         ; $0010, $FFFFFE32
                move.w  Obj_Y(A0), (Saved_Obj_Y_P1).w         ; $0014, $FFFFFE34
                move.w  Obj_Art_VRAM(A0), (Saved_Obj_Art_VRAM_P1).w ; $000A, $FFFFFE3C
                move.w  Obj_Player_Top_Solid(A0), (Saved_Top_Solid_P1).w ; $0046, $FFFFFE3E
                bra.s   Offset_0x00D202
Offset_0x00D1EA:
                move.w  #$06A0, Obj_Art_VRAM(A0)                         ; $000A
                move.w  (Obj_Player_One+Obj_Player_Top_Solid).w, Obj_Player_Top_Solid(A0) ; $FFFFB046, $0046
                tst.w   (Obj_Player_One+Obj_Art_VRAM).w              ; $FFFFB00A
                bpl.s   Offset_0x00D202
                ori.w   #$8000, Obj_Art_VRAM(A0)                         ; $000A
Offset_0x00D202:
                move.w  Obj_X(A0), (Saved_Obj_X_P2).w         ; $0010, $FFFFFEE2
                move.w  Obj_Y(A0), (Saved_Obj_Y_P2).w         ; $0014, $FFFFFEE4
                move.w  Obj_Art_VRAM(A0), (Saved_Obj_Art_VRAM_P2).w ; $000A, $FFFFFEEC
                move.w  Obj_Player_Top_Solid(A0), (Saved_Top_Solid_P2).w ; $0046, $FFFFFEEE
                move.b  #$00, Obj_P_Flips_Remaining(A0)                  ; $0030
                move.b  #$04, Obj_Player_Flip_Speed(A0)                  ; $0031
                move.b  #$1E, Obj_Subtype(A0)                            ; $002C
                move.w  #$0000, (Miles_CPU_Routine).w                ; $FFFFF708
                move.w  #$0258, (Miles_CPU_Ctrl_Auto_Timer).w        ; $FFFFF702
                move.w  #$0000, (Miles_CPU_Respawn_Timer).w          ; $FFFFF704
                move.l  #Obj_Miles_Tails, (Obj_Miles_Tails_RAM).w ; Offset_0x00F1A6, $FFFFCC0A
                move.w  A0, (Obj_Miles_Tails_RAM+Obj_Control_Var_00).w ; $FFFFCC3A
;-------------------------------------------------------------------------------
Miles_Control:                                                 ; Offset_0x00D24A
                cmpa.w  #Obj_Player_One, A0                              ; $B000
                bne.s   Offset_0x00D26A
                move.w  (Control_Ports_Logical_Data).w, (Control_Ports_Logical_Data_2).w ; $FFFFF602, $FFFFF66A
                tst.b   (Control_Locked_Flag_P1).w                   ; $FFFFF7CC
                bne.s   Offset_0x00D280
                move.w  (Control_Ports_Buffer_Data).w, (Control_Ports_Logical_Data_2).w ; $FFFFF604, $FFFFF66A
                move.w  (Control_Ports_Buffer_Data).w, (Control_Ports_Logical_Data).w ; $FFFFF604, $FFFFF602
                bra.s   Offset_0x00D280
Offset_0x00D26A:
                tst.b   (Control_Locked_Flag_P2).w                   ; $FFFFF7CF
                bne.s   Offset_0x00D276
                move.w  (Control_Ports_Buffer_Data+$0002).w, (Control_Ports_Logical_Data_2).w ; $FFFFF606, $FFFFF66A
Offset_0x00D276:
                tst.w   (Two_Player_Flag).w                          ; $FFFFFFD8
                bne.s   Offset_0x00D280
                bsr     Miles_CPU_Control                      ; Offset_0x00D3BE
Offset_0x00D280:
                btst    #$00, Obj_Player_Control(A0)                     ; $002E
                bne.s   Miles_ControlsLock                     ; Offset_0x00D2A2
                movem.l A4-A6, -(A7)
                moveq   #$00, D0
                move.b  Obj_Status(A0), D0                               ; $002A
                andi.w  #$0006, D0
                move.w  Miles_Modes(PC, D0), D1                ; Offset_0x00D2FC
                jsr     Miles_Modes(PC, D1)                    ; Offset_0x00D2FC
                movem.l (A7)+, A4-A6
;-------------------------------------------------------------------------------                
Miles_ControlsLock:                                            ; Offset_0x00D2A2
                cmpi.w  #$FF00, (Sonic_Level_Limits_Min_Y).w         ; $FFFFEE18
                bne.s   Offset_0x00D2B2
                move.w  (Screen_Wrap_Y).w, D0                        ; $FFFFEEAA
                and.w   D0, Obj_Y(A0)                                    ; $0014
Offset_0x00D2B2:
                bsr.s   Miles_Display                          ; Offset_0x00D304
                bsr     CopySonicMovesForMiles                 ; Offset_0x00ACA2
                bsr     Miles_Water                            ; Offset_0x00DA88
                move.b  (Primary_Angle).w, Obj_Player_Next_Tilt(A0) ; $FFFFF768, $003A
                move.b  (Secondary_Angle).w, Obj_Player_Tilt(A0) ; $FFFFF76A, $003B
                tst.b   (Miles_Wind_Flag).w                          ; $FFFFF7C9
                beq.s   Offset_0x00D2DA
                tst.b   Obj_Ani_Number(A0)                               ; $0020
                bne.s   Offset_0x00D2DA
                move.b  Obj_Ani_Flag(A0), Obj_Ani_Number(A0)      ; $0020, $0021
Offset_0x00D2DA:
                btst    #$01, Obj_Player_Control(A0)                     ; $002E
                bne.s   Offset_0x00D2EA
                bsr     Offset_0x00E966
                bsr     Load_Miles_Dynamic_PLC                 ; Offset_0x00ED7C
Offset_0x00D2EA:
                move.b  Obj_Player_Control(A0), D0                       ; $002E
                andi.b  #$A0, D0
                bne.s   Offset_0x00D2FA
                jsr     (Touch_Response)                       ; Offset_0x00A188
Offset_0x00D2FA:
                rts
;-------------------------------------------------------------------------------
Miles_Modes:                                                   ; Offset_0x00D2FC
                dc.w    Miles_MdNormal-Miles_Modes             ; Offset_0x00DB5A
                dc.w    Miles_MdJump-Miles_Modes               ; Offset_0x00DB92
                dc.w    Miles_MdRoll-Miles_Modes               ; Offset_0x00DC74
                dc.w    Miles_MdJump2-Miles_Modes              ; Offset_0x00DCAA
;-------------------------------------------------------------------------------  
Miles_Display:                                                 ; Offset_0x00D304
                move.b  Obj_P_Invunerblt_Time(A0), D0                    ; $0034
                beq.s   Offset_0x00D312
                subq.b  #$01, Obj_P_Invunerblt_Time(A0)                  ; $0034
                lsr.b   #$03, D0
                bcc.s   Offset_0x00D318
Offset_0x00D312:
                jsr     (DisplaySprite)                        ; Offset_0x011148
Offset_0x00D318:
                btst    #$01, Obj_Player_Status(A0)                      ; $002F
                beq.s   Offset_0x00D354
                tst.b   Obj_P_Invcbility_Time(A0)                        ; $0035
                beq.s   Offset_0x00D354
                move.b  (Level_Frame_Count+$01).w, D0                ; $FFFFFE05
                andi.b  #$07, D0
                bne.s   Offset_0x00D354
                subq.b  #$01, Obj_P_Invcbility_Time(A0)                  ; $0035
                bne.s   Offset_0x00D354
                tst.b   (Boss_Flag).w                                ; $FFFFF7AA
                bne.s   Offset_0x00D34E
                cmpi.b  #$0C, Obj_Subtype(A0)                            ; $002C
                bcs.s   Offset_0x00D34E
                move.w  (Level_Music_Buffer).w, D0                   ; $FFFFFF90
                jsr     (Play_Music)                           ; Offset_0x001176
Offset_0x00D34E:
                bclr    #$01, Obj_Player_Status(A0)                      ; $002F
Offset_0x00D354:
                btst    #$02, Obj_Player_Status(A0)                      ; $002F
                beq.s   Offset_0x00D398
                tst.b   Obj_P_Spd_Shoes_Time(A0)                         ; $0036
                beq.s   Offset_0x00D398
                move.b  (Level_Frame_Count+$01).w, D0                ; $FFFFFE05
                andi.b  #$07, D0
                bne.s   Offset_0x00D398
                subq.b  #$01, Obj_P_Spd_Shoes_Time(A0)                   ; $0036
                bne.s   Offset_0x00D398
                tst.w   (Two_Player_Flag).w                          ; $FFFFFFD8
                bne.s   Offset_0x00D39A
                move.w  #$0600, (A4)
                move.w  #$000C, Acceleration(A4)                         ; $0002
                move.w  #$0080, Deceleration(A4)                         ; $0004
                bclr    #$02, Obj_Player_Status(A0)                      ; $002F
                move.w  #Music_Normal_Speed, D0                          ; $00FC
                jmp     (Play_Music)                           ; Offset_0x001176
Offset_0x00D398:
                rts
Offset_0x00D39A:
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
Miles_CPU_Control:                                             ; Offset_0x00D3BE
                move.b  (Control_Ports_Buffer_Data+$0002).w, D0      ; $FFFFF606
                andi.b  #$7F, D0
                beq.s   Offset_0x00D3CE
                move.w  #$0258, (Miles_CPU_Ctrl_Auto_Timer).w        ; $FFFFF702
Offset_0x00D3CE:
                lea     (Obj_Player_One).w, A1                       ; $FFFFB000
                move.w  (Miles_CPU_Routine).w, D0                    ; $FFFFF708
                move.w  Miles_CPU_States(PC, D0), D0           ; Offset_0x00D3DE
                jmp     Miles_CPU_States(PC, D0)               ; Offset_0x00D3DE
;-------------------------------------------------------------------------------
Miles_CPU_States:                                              ; Offset_0x00D3DE
                dc.w    Miles_CPU_Init-Miles_CPU_States        ; Offset_0x00D3EE
                dc.w    Miles_CPU_Spawning-Miles_CPU_States    ; Offset_0x00D442
                dc.w    Miles_CPU_Flying-Miles_CPU_States      ; Offset_0x00D49C
                dc.w    Miles_CPU_Normal-Miles_CPU_States      ; Offset_0x00D5DC
                dc.w    Miles_CPU_Panic-Miles_CPU_States       ; Offset_0x00D7A4
                dc.w    Miles_CPU_0A-Miles_CPU_States          ; Offset_0x00D824
                dc.w    Miles_CPU_0C-Miles_CPU_States          ; Offset_0x00D868
                dc.w    Miles_CPU_0E-Miles_CPU_States          ; Offset_0x00D8A8
;-------------------------------------------------------------------------------                
Miles_CPU_Init:                                                ; Offset_0x00D3EE
                cmpi.w  #$0000, (Level_Id).w                         ; $FFFFFE10
                bne.s   Offset_0x00D410
                cmpi.w  #$1D00, (Camera_X).w                         ; $FFFFEE78
                bcc.s   Offset_0x00D410
                bsr     Miles_CPU_Despawn                      ; Offset_0x00D730
                move.w  #$000A, (Miles_CPU_Routine).w                ; $FFFFF708
                move.b  #$83, Obj_Player_Control(A0)                     ; $002E
                rts
Offset_0x00D410:
                move.w  #$0006, (Miles_CPU_Routine).w                ; $FFFFF708
                move.b  #$00, Obj_Player_Control(A0)                     ; $002E
                move.b  #$00, Obj_Ani_Number(A0)                         ; $0020
                move.w  #$0000, Obj_Speed_X(A0)                          ; $0018
                move.w  #$0000, Obj_Speed_Y(A0)                          ; $001A
                move.w  #$0000, Obj_Inertia(A0)                          ; $001C
                move.b  #$00, Obj_Status(A0)                             ; $002A
                move.w  #$0000, (Miles_CPU_Respawn_Timer).w          ; $FFFFF704
                rts    
;-------------------------------------------------------------------------------
Miles_CPU_Spawning:                                            ; Offset_0x00D442
                move.b  (Control_Ports_Logical_Data_2).w, D0         ; $FFFFF66A
                andi.b  #$F0, D0
                bne.s   Miles_CPU_Respawn                      ; Offset_0x00D466
                move.w  (Level_Frame_Count).w, D0                    ; $FFFFFE04
                andi.w  #$003F, D0
                bne.s   Offset_0x00D49A
                tst.b   Obj_Player_Control(A1)                           ; $002E
                bne.s   Offset_0x00D49A
                move.b  Obj_Status(A1), D0                               ; $002A
                andi.b  #$D2, D0
                bne.s   Offset_0x00D49A
Miles_CPU_Respawn:                                             ; Offset_0x00D466
                move.w  #$0004, (Miles_CPU_Routine).w                ; $FFFFF708
                move.w  Obj_X(A1), D0                                    ; $0010
                move.w  D0, Obj_X(A0)                                    ; $0010
                move.w  D0, (Miles_CPU_Respawn_X).w                  ; $FFFFF70A
                move.w  Obj_Y(A1), D0                                    ; $0014
                move.w  D0, (Miles_CPU_Respawn_Y).w                  ; $FFFFF70C
                subi.w  #$00C0, D0
                move.w  D0, Obj_Y(A0)                                    ; $0014
                ori.w   #$8000, Obj_Art_VRAM(A0)                         ; $000A
                move.b  #$00, Obj_Player_Spdsh_Flag(A0)                  ; $003D
                move.w  #$0000, Obj_Player_Spdsh_Cnt(A0)                 ; $003E
Offset_0x00D49A:
                rts     
;-------------------------------------------------------------------------------
Miles_CPU_Flying:                                              ; Offset_0x00D49C
                tst.b   Obj_Flags(A0)                                    ; $0004
                bmi.s   Offset_0x00D4DA
                addq.w  #$01, (Miles_CPU_Respawn_Timer).w            ; $FFFFF704
                cmpi.w  #$012C, (Miles_CPU_Respawn_Timer).w          ; $FFFFF704
                bcs.s   Offset_0x00D4E0
                move.w  #$0000, (Miles_CPU_Respawn_Timer).w          ; $FFFFF704
                move.w  #$0002, (Miles_CPU_Routine).w                ; $FFFFF708
                move.b  #$81, Obj_Player_Control(A0)                     ; $002E
                move.b  #$02, Obj_Status(A0)                             ; $002A
                move.w  #$0000, Obj_X(A0)                                ; $0010
                move.w  #$0000, Obj_Y(A0)                                ; $0014
                move.b  #$20, Obj_Ani_Number(A0)                         ; $0020
                rts
Offset_0x00D4DA:
                move.w  #$0000, (Miles_CPU_Respawn_Timer).w          ; $FFFFF704
Offset_0x00D4E0:
                lea     (Position_Table_Data).w, A2                  ; $FFFFE500
                move.w  #$0010, D2
                lsl.b   #$02, D2
                addq.b  #$04, D2
                move.w  (Position_Table_Index).w, D3                 ; $FFFFEE26
                sub.b   D2, D3
                move.w  $00(A2, D3), (Miles_CPU_Respawn_X).w         ; $FFFFF70A
                move.w  $02(A2, D3), (Miles_CPU_Respawn_Y).w         ; $FFFFF70C
                tst.b   (Water_Level_Flag).w                         ; $FFFFF730
                beq.s   Offset_0x00D516
                move.w  (Water_Level_Move).w, D0                     ; $FFFFF646
                subi.w  #$0010, D0
                cmp.w   (Miles_CPU_Respawn_Y).w, D0                  ; $FFFFF70C
                bge.s   Offset_0x00D516
                move.w  D0, (Miles_CPU_Respawn_Y).w                  ; $FFFFF70C
Offset_0x00D516:
                move.w  Obj_X(A0), D0                                    ; $0010
                sub.w   (Miles_CPU_Respawn_X).w, D0                  ; $FFFFF70A
                beq.s   Offset_0x00D566
                move.w  D0, D2
                bpl.s   Offset_0x00D526
                neg.w   D2
Offset_0x00D526:
                lsr.w   #$04, D2
                cmpi.w  #$000C, D2
                bcs.s   Offset_0x00D530
                moveq   #$0C, D2
Offset_0x00D530:
                move.b  Obj_Speed_X(A1), D1                              ; $0018
                bpl.s   Offset_0x00D538
                neg.b   D1
Offset_0x00D538:
                add.b   D1, D2
                addq.w  #$01, D2
                tst.w   D0
                bmi.s   Offset_0x00D552
                bset    #$00, Obj_Status(A0)                             ; $002A
                cmp.w   D0, D2
                bcs.s   Offset_0x00D54E
                move.w  D0, D2
                moveq   #$00, D0
Offset_0x00D54E:
                neg.w   D2
                bra.s   Offset_0x00D562
Offset_0x00D552:
                bclr    #$00, Obj_Status(A0)                             ; $002A
                neg.w   D0
                cmp.w   D0, D2
                bcs.s   Offset_0x00D562
                move.b  D0, D2
                moveq   #$00, D0
Offset_0x00D562:
                add.w   D2, Obj_X(A0)                                    ; $0010
Offset_0x00D566:
                moveq   #$01, D2
                move.w  Obj_Y(A0), D1                                    ; $0014
                sub.w   (Miles_CPU_Respawn_Y).w, D1                  ; $FFFFF70C
                beq.s   Offset_0x00D57A
                bmi.s   Offset_0x00D576
                neg.w   D2
Offset_0x00D576:
                add.w   D2, Obj_Y(A0)                                    ; $0014
Offset_0x00D57A:
                lea     (Status_Table_Data).w, A2                    ; $FFFFE400
                move.b  $02(A2, D3), D2
                andi.b  #$D2, D2
                bne.s   Offset_0x00D5DA
                or.w    D0, D1
                bne.s   Offset_0x00D5DA
                move.w  #$0006, (Miles_CPU_Routine).w                ; $FFFFF708
                move.b  #$00, Obj_Player_Control(A0)                     ; $002E
                move.b  #$00, Obj_Ani_Number(A0)                         ; $0020
                move.w  #$0000, Obj_Speed_X(A0)                          ; $0018
                move.w  #$0000, Obj_Speed_Y(A0)                          ; $001A
                move.w  #$0000, Obj_Inertia(A0)                          ; $001C
                move.b  #$02, Obj_Status(A0)                             ; $002A
                move.w  #$0000, Obj_P_Horiz_Ctrl_Lock(A0)                ; $0032
                andi.w  #$7FFF, Obj_Art_VRAM(A0)                         ; $000A
                tst.b   Obj_Art_VRAM(A1)                                 ; $000A
                bpl.s   Offset_0x00D5CE
                ori.w   #$8000, Obj_Art_VRAM(A0)                         ; $000A
Offset_0x00D5CE:
                move.b  Obj_Player_Top_Solid(A1), Obj_Player_Top_Solid(A0) ; $0046, $0046
                move.b  Obj_Player_LRB_Solid(A1), Obj_Player_LRB_Solid(A0) ; $0047, $0047
Offset_0x00D5DA:
                rts  
;-------------------------------------------------------------------------------
Miles_CPU_Normal:                                              ; Offset_0x00D5DC
                cmpi.b  #$06, (Obj_Player_One+Obj_Routine).w         ; $FFFFB005
                bcs.s   Offset_0x00D60A
                move.w  #$0004, (Miles_CPU_Routine).w                ; $FFFFF708
                move.b  #$00, Obj_Player_Spdsh_Flag(A0)                  ; $003D
                move.w  #$0000, Obj_Player_Spdsh_Cnt(A0)                 ; $003E
                move.b  #$81, Obj_Player_Control(A0)                     ; $002E
                move.b  #$02, Obj_Status(A0)                             ; $002A
                move.b  #$20, Obj_Ani_Number(A0)                         ; $0020
                rts
Offset_0x00D60A:
                bsr     Miles_CPU_Check_Despawn                ; Offset_0x00D768
                tst.w   (Miles_CPU_Ctrl_Auto_Timer).w                ; $FFFFF702
                bne     Offset_0x00D724
                tst.b   Obj_Player_Control(A0)                           ; $002E
                bmi     Offset_0x00D724
                tst.w   Obj_P_Horiz_Ctrl_Lock(A0)                        ; $0032
                beq.s   Offset_0x00D630
                tst.w   Obj_Inertia(A0)                                  ; $001C
                bne.s   Offset_0x00D630
                move.w  #$0008, (Miles_CPU_Routine).w                ; $FFFFF708
Offset_0x00D630:
                lea     (Position_Table_Data).w, A1                  ; $FFFFE500
                move.w  #$0010, D1
                lsl.b   #$02, D1
                addq.b  #$04, D1
                move.w  (Position_Table_Index).w, D0                 ; $FFFFEE26
                sub.b   D1, D0
                move.w  $00(A1, D0), D2
                move.w  $02(A1, D0), D3
                lea     (Status_Table_Data).w, A1                    ; $FFFFE400
                move.w  $00(A1, D0), D1
                move.b  $02(A1, D0), D4
                move.w  D1, D0
                btst    #$05, Obj_Status(A0)                             ; $002A
                beq.s   Offset_0x00D668
                btst    #$05, D4
                beq     Offset_0x00D702
Offset_0x00D668:
                sub.w   Obj_X(A0), D2                                    ; $0010
                beq.s   Offset_0x00D6B6
                bpl.s   Offset_0x00D694
                neg.w   D2
                cmpi.w  #$0010, D2
                bcs.s   Offset_0x00D680
                andi.w  #$F3F3, D1
                ori.w   #$0404, D1
Offset_0x00D680:
                tst.w   Obj_Inertia(A0)                                  ; $001C
                beq.s   Offset_0x00D6CA
                btst    #$00, Obj_Status(A0)                             ; $002A
                beq.s   Offset_0x00D6CA
                subq.w  #$01, Obj_X(A0)                                  ; $0010
                bra.s   Offset_0x00D6CA
Offset_0x00D694:
                cmpi.w  #$0010, D2
                bcs.s   Offset_0x00D6A2
                andi.w  #$F3F3, D1
                ori.w   #$0808, D1
Offset_0x00D6A2:
                tst.w   Obj_Inertia(A0)                                  ; $001C
                beq.s   Offset_0x00D6CA
                btst    #$00, Obj_Status(A0)                             ; $002A
                bne.s   Offset_0x00D6CA
                addq.w  #$01, Obj_X(A0)                                  ; $0010
                bra.s   Offset_0x00D6CA
Offset_0x00D6B6:
                bclr    #$00, Obj_Status(A0)                             ; $002A
                move.b  D4, D0
                andi.b  #$01, D0
                beq.s   Offset_0x00D6CA
                bset    #$00, Obj_Status(A0)                             ; $002A
Offset_0x00D6CA:
                tst.b   (Miles_CPU_Jumping).w                        ; $FFFFF70F
                beq.s   Offset_0x00D6E2
                ori.w   #$7000, D1
                btst    #$01, Obj_Status(A0)                             ; $002A
                bne.s   Offset_0x00D71E
                move.b  #$00, (Miles_CPU_Jumping).w                  ; $FFFFF70F
Offset_0x00D6E2:
                move.w  (Level_Frame_Count).w, D0                    ; $FFFFFE04
                andi.w  #$00FF, D0
                beq.s   Offset_0x00D6F2
                cmpi.w  #$0040, D2
                bcc.s   Offset_0x00D71E
Offset_0x00D6F2:
                sub.w   Obj_Y(A0), D3                                    ; $0014
                beq.s   Offset_0x00D71E
                bpl.s   Offset_0x00D71E
                neg.w   D3
                cmpi.w  #$0020, D3
                bcs.s   Offset_0x00D71E
Offset_0x00D702:
                move.b  (Level_Frame_Count+$01).w, D0                ; $FFFFFE05
                andi.b  #$3F, D0
                bne.s   Offset_0x00D71E
                cmpi.b  #$08, Obj_Ani_Number(A0)                         ; $0020
                beq.s   Offset_0x00D71E
                ori.w   #$7070, D1
                move.b  #$01, (Miles_CPU_Jumping).w                  ; $FFFFF70F
Offset_0x00D71E:
                move.w  D1, (Control_Ports_Logical_Data_2).w         ; $FFFFF66A
                rts
Offset_0x00D724:
                tst.w   (Miles_CPU_Ctrl_Auto_Timer).w                ; $FFFFF702
                beq.s   Offset_0x00D72E
                subq.w  #$01, (Miles_CPU_Ctrl_Auto_Timer).w          ; $FFFFF702
Offset_0x00D72E:
                rts   
;-------------------------------------------------------------------------------  
Miles_CPU_Despawn:                                             ; Offset_0x00D730
                move.w  #$0000, (Miles_CPU_Ctrl_Auto_Timer).w        ; $FFFFF702
                move.w  #$0000, (Miles_CPU_Respawn_Timer).w          ; $FFFFF704
                move.w  #$0002, (Miles_CPU_Routine).w                ; $FFFFF708
                move.b  #$81, Obj_Player_Control(A0)                     ; $002E
                move.b  #$02, Obj_Status(A0)                             ; $002A
                move.w  #$4000, Obj_X(A0)                                ; $0010
                move.w  #$0000, Obj_Y(A0)                                ; $0014
                move.b  #$20, Obj_Ani_Number(A0)                         ; $0020
                move.b  #$00, ($FFFFF668).w
                rts     
;-------------------------------------------------------------------------------  
Miles_CPU_Check_Despawn:                                       ; Offset_0x00D768
                tst.b   Obj_Flags(A0)                                    ; $0004
                bmi.s   Offset_0x00D794
                btst    #$03, Obj_Status(A0)                             ; $002A
                beq.s   Offset_0x00D784
                moveq   #$00, D0
                move.w  Obj_Player_Last(A0), A3                          ; $0042
                move.w  (Miles_Control_Vars).w, D0                   ; $FFFFF700
                cmp.w   (A3), D0
                bne.s   Offset_0x00D790
Offset_0x00D784:
                addq.w  #$01, (Miles_CPU_Respawn_Timer).w            ; $FFFFF704
                cmpi.w  #$012C, (Miles_CPU_Respawn_Timer).w          ; $FFFFF704
                bcs.s   Offset_0x00D79A
Offset_0x00D790:
                bra     Miles_CPU_Despawn                      ; Offset_0x00D730
Offset_0x00D794:
                move.w  #$0000, (Miles_CPU_Respawn_Timer).w          ; $FFFFF704
Offset_0x00D79A:
                move.w  Obj_Player_Last(A0), A3                          ; $0042
                move.w  (A3), (Miles_Control_Vars).w                 ; $FFFFF700
                rts      
;-------------------------------------------------------------------------------
Miles_CPU_Panic:                                               ; Offset_0x00D7A4
                bsr     Miles_CPU_Check_Despawn                ; Offset_0x00D768
                tst.w   (Miles_CPU_Ctrl_Auto_Timer).w                ; $FFFFF702
                bne     Offset_0x00D822
                tst.w   Obj_P_Horiz_Ctrl_Lock(A0)                        ; $0032
                bne.s   Offset_0x00D822
                tst.b   Obj_Player_Spdsh_Flag(A0)                        ; $003D
                bne.s   Offset_0x00D7F8
                tst.w   Obj_Inertia(A0)                                  ; $001C
                bne.s   Offset_0x00D822
                bclr    #$00, Obj_Status(A0)                             ; $002A
                move.w  Obj_X(A0), D0                                    ; $0010
                sub.w   Obj_X(A1), D0                                    ; $0010
                bcs.s   Offset_0x00D7D8
                bset    #$00, Obj_Status(A0)                             ; $002A
Offset_0x00D7D8:
                move.w  #$0202, (Control_Ports_Logical_Data_2).w     ; $FFFFF66A
                move.b  (Level_Frame_Count+$01).w, D0                ; $FFFFFE05
                andi.b  #$7F, D0
                beq.s   Offset_0x00D808
                cmpi.b  #$08, Obj_Ani_Number(A0)                         ; $0020
                bne.s   Offset_0x00D822
                move.w  #$7272, (Control_Ports_Logical_Data_2).w     ; $FFFFF66A
                rts
Offset_0x00D7F8:
                move.w  #$0202, (Control_Ports_Logical_Data_2).w     ; $FFFFF66A
                move.b  (Level_Frame_Count+$01).w, D0                ; $FFFFFE05
                andi.b  #$7F, D0
                bne.s   Offset_0x00D816
Offset_0x00D808:
                move.w  #$0000, (Control_Ports_Logical_Data_2).w     ; $FFFFF66A
                move.w  #$0006, (Miles_CPU_Routine).w                ; $FFFFF708
                rts
Offset_0x00D816:
                andi.b  #$1F, D0
                bne.s   Offset_0x00D822
                ori.w   #$7070, (Control_Ports_Logical_Data_2).w     ; $FFFFF66A
Offset_0x00D822:
                rts  
;-------------------------------------------------------------------------------
Miles_CPU_0A:                                                  ; Offset_0x00D824
                cmpi.w  #$1700, (Obj_Player_One+Obj_X).w             ; $FFFFB010
                bcs.s   Offset_0x00D866
                move.w  #$000C, (Miles_CPU_Routine).w                ; $FFFFF708
                move.w  #$18A0, D0
                move.w  D0, Obj_X(A0)                                    ; $0010
                move.w  #$01A0, D0
                move.w  D0, Obj_Y(A0)                                    ; $0014
                ori.w   #$8000, Obj_Art_VRAM(A0)                         ; $000A
                move.b  #$00, Obj_Player_Spdsh_Flag(A0)                  ; $003D
                move.w  #$0000, Obj_Player_Spdsh_Cnt(A0)                 ; $003E
                move.w  #$0080, Obj_Priority(A0)                         ; $0008
                move.b  #$81, Obj_Player_Control(A0)                     ; $002E
                move.w  #$0000, Obj_Speed_Y(A0)                          ; $001A
Offset_0x00D866:
                rts   
;-------------------------------------------------------------------------------
Miles_CPU_0C:                                                  ; Offset_0x00D868
                moveq   #$02, D0
                cmpi.w  #$02A0, Obj_Y(A0)                                ; $0014
                bcs.s   Offset_0x00D874
                neg.w   D0
Offset_0x00D874:
                add.w   D0, Obj_Speed_Y(A0)                              ; $001A
                move.w  Obj_Speed_Y(A0), D0                              ; $001A
                ext.l   D0
                lsl.l   #$08, D0
                add.l   D0, Obj_Y(A0)                                    ; $0014
                addq.w  #$01, Obj_X(A0)                                  ; $0010
                cmpi.w  #$1C00, Obj_X(A0)                                ; $0010
                bcs.s   Offset_0x00D896
                move.w  #$000E, (Miles_CPU_Routine).w                ; $FFFFF708
Offset_0x00D896:
                lea     (Carrying_Sonic_Data).w, A2                  ; $FFFFF73E
                lea     (Obj_Player_One).w, A1                       ; $FFFFB000
                move.w  (Control_Ports_Buffer_Data).w, D0            ; $FFFFF604
                bsr     Offset_0x00D8C6
                rts    
;-------------------------------------------------------------------------------
Miles_CPU_0E:                                                  ; Offset_0x00D8A8:
                tst.b   Obj_Flags(A0)                                    ; $0004
                bmi.s   Offset_0x00D8B4
                move.w  #$0000, (Miles_CPU_Routine).w                ; $FFFFF708
Offset_0x00D8B4:
                lea     (Carrying_Sonic_Data).w, A2                  ; $FFFFF73E
                lea     (Obj_Player_One).w, A1                       ; $FFFFB000
                move.w  (Control_Ports_Buffer_Data).w, D0            ; $FFFFF604
                bsr     Offset_0x00D8C6
                rts
Offset_0x00D8C6:
                tst.b   (A2)
                beq     Offset_0x00D9D6
                tst.b   Obj_Flags(A1)                                    ; $0004
                bpl.s   Offset_0x00D930
                cmpi.b  #$04, Obj_Routine(A1)                            ; $0005
                bcc.s   Offset_0x00D930
                btst    #$01, Obj_Status(A1)                             ; $002A
                beq.s   Offset_0x00D930
                andi.b  #$70, D0
                beq     Offset_0x00D944
                clr.b   Obj_Player_Control(A1)                           ; $002E
                clr.b   (A2)
                move.b  #$12, $0001(A2)
                andi.w  #$0F00, D0
                beq     Offset_0x00D904
                move.b  #$3C, $0001(A2)
Offset_0x00D904:
                btst    #$0A, D0
                beq.s   Offset_0x00D910
                move.w  #$FE00, Obj_Speed_X(A1)                          ; $0018
Offset_0x00D910:
                btst    #$0B, D0
                beq.s   Offset_0x00D91C
                move.w  #$0200, Obj_Speed_X(A1)                          ; $0018
Offset_0x00D91C:
                move.w  #$FC80, Obj_Speed_Y(A1)                          ; $001A
                bset    #$01, Obj_Status(A1)                             ; $002A
                andi.w  #$7FFF, Obj_Art_VRAM(A1)                         ; $000A
                rts
Offset_0x00D930:
                clr.b   Obj_Player_Control(A1)                           ; $002E
                clr.b   (A2)
                move.b  #$78, $0001(A2)
                andi.w  #$7FFF, Obj_Art_VRAM(A1)                         ; $000A
                rts
Offset_0x00D944:
                move.w  Obj_X(A0), Obj_X(A1)                      ; $0010, $0010
                move.w  Obj_Y(A0), Obj_Y(A1)                      ; $0014, $0014
                addi.w  #$001C, Obj_Y(A1)                                ; $0014
                move.w  Obj_Speed_X(A0), Obj_Speed_X(A1)          ; $0018, $0018
                move.w  Obj_Speed_Y(A0), Obj_Speed_Y(A1)          ; $001A, $001A
                andi.b  #$FC, Obj_Flags(A1)                              ; $0004
                andi.b  #$FE, Obj_Status(A1)                             ; $002A
                move.b  Obj_Status(A0), D0                               ; $002A
                andi.b  #$01, D0
                or.b    D0, Obj_Flags(A1)                                ; $0004
                or.b    D0, Obj_Status(A1)                               ; $002A
                subq.b  #$01, Obj_Ani_Time(A1)                           ; $0024
                bpl.s   Offset_0x00D9BC
                move.b  #$0B, Obj_Ani_Time(A1)                           ; $0024
                moveq   #$00, D1
                move.b  Obj_Ani_Frame(A1), D1                            ; $0023
                addq.b  #$01, Obj_Ani_Frame(A1)                          ; $0023
                move.b  Offset_0x00D9CC(PC, D1), D0
                cmpi.b  #$FF, D0
                bne.s   Offset_0x00D9A8
                move.b  #$00, Obj_Ani_Frame(A1)                          ; $0023
                move.b  Offset_0x00D9CC(PC), D0
Offset_0x00D9A8:
                move.b  D0, Obj_Map_Id(A1)                               ; $0022
                moveq   #$00, D0
                move.b  Obj_Map_Id(A1), D0                               ; $0022
                move.l  A2, -(A7)
                jsr     (Load_Sonic_Dynamic_PLC_D0)            ; Offset_0x00C7F0
                move.l  (A7)+, A2
Offset_0x00D9BC:
                movem.l A0-A6, -(A7)
                move.l  A1, A0
                bsr     Sonic_Floor                            ; Offset_0x00BD7C
                movem.l (A7)+, A0-A6
                rts        
;-------------------------------------------------------------------------------
Offset_0x00D9CC:
                dc.b    $ED, $EE, $EF, $F0, $F1, $F0, $EF, $EE
                dc.b    $FF, $00 
;-------------------------------------------------------------------------------    
Offset_0x00D9D6:
                tst.b   $0001(A2)
                beq.s   Offset_0x00D9E4
                subq.b  #$01, $0001(A2)
                bne     Offset_0x00DA86
Offset_0x00D9E4:
                move.w  Obj_X(A1), D0                                    ; $0010
                sub.w   Obj_X(A0), D0                                    ; $0010
                addi.w  #$0010, D0
                cmpi.w  #$0020, D0
                bcc     Offset_0x00DA86
                move.w  Obj_Y(A1), D1                                    ; $0014
                sub.w   Obj_Y(A0), D1                                    ; $0014
                subi.w  #$0010, D1
                cmpi.w  #$0018, D1
                bcc     Offset_0x00DA86
                tst.b   Obj_Player_Control(A1)                           ; $002E
                bne.s   Offset_0x00DA86
                cmpi.b  #$04, Obj_Routine(A1)                            ; $0005
                bcc.s   Offset_0x00DA86
                tst.w   (Debug_Mode_Flag_Index).w                    ; $FFFFFE08
                bne.s   Offset_0x00DA86
                clr.w   Obj_Speed_X(A1)                                  ; $0018
                clr.w   Obj_Speed_Y(A1)                                  ; $001A
                clr.w   Obj_Inertia(A1)                                  ; $001C
                clr.w   Obj_Angle(A1)                                    ; $0026
                move.w  Obj_X(A0), Obj_X(A1)                      ; $0010, $0010
                move.w  Obj_Y(A0), Obj_Y(A1)                      ; $0014, $0014
                addi.w  #$001C, Obj_Y(A1)                                ; $0014
                move.w  #$2200, Obj_Ani_Number(A1)                       ; $0020
                move.b  #$00, Obj_Ani_Time(A1)                           ; $0024
                move.b  #$00, Obj_Ani_Frame(A1)                          ; $0023
                move.b  #$03, Obj_Player_Control(A1)                     ; $002E
                ori.w   #$8000, Obj_Art_VRAM(A1)                         ; $000A
                bset    #$01, Obj_Status(A1)                             ; $002A
                andi.b  #$FC, Obj_Flags(A1)                              ; $0004
                andi.b  #$FE, Obj_Status(A1)                             ; $002A
                move.b  Obj_Status(A0), D0                               ; $002A
                andi.b  #$01, D0
                or.b    D0, Obj_Flags(A1)                                ; $0004
                or.b    D0, Obj_Status(A1)                               ; $002A
                move.b  #$01, (A2)
Offset_0x00DA86:
                rts   
;-------------------------------------------------------------------------------
Miles_Water:                                                   ; Offset_0x00DA88
                tst.b   (Water_Level_Flag).w                         ; $FFFFF730
                bne.s   Miles_InLevelWithWater                 ; Offset_0x00DA90
Offset_0x00DA8E:
                rts
;-------------------------------------------------------------------------------                
Miles_InLevelWithWater:                                        ; Offset_0x00DA90
                move.w  (Water_Level_Move).w, D0                     ; $FFFFF646
                cmp.w   Obj_Y(A0), D0                                    ; $0014
                bge.s   Miles_NotInWater                       ; Offset_0x00DAEC
                bset    #$06, Obj_Status(A0)                             ; $002A
                bne.s   Offset_0x00DA8E
                addq.b  #$01, (Water_Entered_Counter).w              ; $FFFFF64D
                move.l  A0, A1
                bsr     Resume_Music                           ; Offset_0x00F89E
                move.l  #Obj_Player_Underwater, (Obj_P2_Underwater_Control).w ; Offset_0x00F38C, $FFFFCB76
                move.b  #$81, (Obj_P2_Underwater_Control+Obj_Subtype).w ; $FFFFCBA2
                move.l  A0, (Obj_P2_Underwater_Control+$0040).w      ; $FFFFCBB6
                move.w  #$0300, (A4)
                move.w  #$0006, Acceleration(A4)                         ; $0002  
                move.w  #$0040, Deceleration(A4)                         ; $0004
                asr.w   Obj_Speed_X(A0)                                  ; $0018
                asr.w   Obj_Speed_Y(A0)                                  ; $001A
                asr.w   Obj_Speed_Y(A0)                                  ; $001A
                beq.s   Offset_0x00DA8E
                move.w  #$0100, Obj_Ani_Number(A6)                       ; $0020
                move.w  #Water_Splash_Sfx, D0                            ; $0039
                jmp     (Play_Music)                           ; Offset_0x001176
;-------------------------------------------------------------------------------                
Miles_NotInWater:                                              ; Offset_0x00DAEC
                bclr    #$06, Obj_Status(A0)                             ; $002A
                beq.s   Offset_0x00DA8E
                addq.b  #$01, (Water_Entered_Counter).w              ; $FFFFF64D
                move.l  A0, A1
                bsr     Resume_Music                           ; Offset_0x00F89E
                move.w  #$0600, (A4)
                move.w  #$000C, Acceleration(A4)                         ; $0002
                move.w  #$0080, Deceleration(A4)                         ; $0004
                cmpi.b  #$04, Obj_Routine(A0)                            ; $0005
                beq.s   Offset_0x00DB24
                move.w  Obj_Speed_Y(A0), D0                              ; $001A
                cmpi.w  #$FC00, D0
                blt.s   Offset_0x00DB24
                asl.w   Obj_Speed_Y(A0)                                  ; $001A
Offset_0x00DB24:
                cmpi.b  #$1C, Obj_Ani_Number(A0)                         ; $0020
                beq     Offset_0x00DA8E
                tst.w   Obj_Speed_Y(A0)                                  ; $001A
                beq     Offset_0x00DA8E
                move.w  #$0100, Obj_Ani_Number(A6)                       ; $0020
                move.l  A0, A1
                bsr     Resume_Music                           ; Offset_0x00F89E
                cmpi.w  #$F000, Obj_Speed_Y(A0)                          ; $001A
                bgt.s   Offset_0x00DB50
                move.w  #$F000, Obj_Speed_Y(A0)                          ; $001A
Offset_0x00DB50:
                move.w  #Water_Splash_Sfx, D0                            ; $0039
                jmp     (Play_Music)                           ; Offset_0x001176  
;-------------------------------------------------------------------------------
Miles_MdNormal:                                                ; Offset_0x00DB5A
                bsr     Miles_Spindash                         ; Offset_0x00E39C
                bsr     Miles_Jump                             ; Offset_0x00E238
                bsr     Miles_SlopeResist                      ; Offset_0x00E4DC
                bsr     Miles_Move                             ; Offset_0x00DCD4
                bsr     Miles_Roll                             ; Offset_0x00E1D2
                bsr     Miles_LevelBoundaries                  ; Offset_0x00E17C
                jsr     (SpeedToPos)                           ; Offset_0x01111E
                bsr     Player_AnglePos                        ; Offset_0x009144
                bsr     Miles_SlopeRepel                       ; Offset_0x00E54E
                tst.b   (Background_Collision_Flag).w                ; $FFFFF664
                beq.s   Offset_0x00DB90
                bsr     Offset_0x009C92
                tst.w   D1
                bmi     Kill_Player                            ; Offset_0x00A4A4
Offset_0x00DB90:
                rts   
;-------------------------------------------------------------------------------
Miles_MdJump:                                                  ; Offset_0x00DB92
                tst.b   (Level_Boundaries_Flag).w                    ; $FFFFF668
                bne.s   Offset_0x00DBC2
                bsr     Miles_JumpHeight                       ; Offset_0x00E2F8
                bsr     Miles_ChgJumpDir                       ; Offset_0x00E0EC
                bsr     Miles_LevelBoundaries                  ; Offset_0x00E17C
                jsr     (ObjectFall)                           ; Offset_0x0110FE
                btst    #$06, Obj_Status(A0)                             ; $002A
                beq.s   Offset_0x00DBB8
                subi.w  #$0028, Obj_Speed_Y(A0)                          ; $001A
Offset_0x00DBB8:
                bsr     Miles_JumpAngle                        ; Offset_0x00E590
                bsr     Miles_Floor                            ; Offset_0x00E5F0
                rts
Offset_0x00DBC2:
                bsr     Offset_0x00DBFE
                bsr     Miles_ChgJumpDir                       ; Offset_0x00E0EC
                bsr     Miles_LevelBoundaries                  ; Offset_0x00E17C
                jsr     (SpeedToPos)                           ; Offset_0x01111E
                bsr     Miles_JumpAngle                        ; Offset_0x00E590
                movem.l A4-A6, -(A7)
                bsr     Miles_Floor                            ; Offset_0x00E5F0
                movem.l (A7)+, A4-A6
                cmpi.w  #$0000, (Player_Selected_Flag).w             ; $FFFFFF08
                bne.s   Offset_0x00DBFC
                lea     (Carrying_Sonic_Data).w, A2                  ; $FFFFF73E
                lea     (Obj_Player_One).w, A1                       ; $FFFFB000
                move.w  (Control_Ports_Buffer_Data).w, D0            ; $FFFFF604
                bsr     Offset_0x00D8C6
Offset_0x00DBFC:
                rts
Offset_0x00DBFE:
                cmpi.b  #$01, (Level_Boundaries_Flag).w              ; $FFFFF668
                bne.s   Offset_0x00DC3E
                move.b  (Control_Ports_Logical_Data_2+$01).w, D0     ; $FFFFF66B
                andi.b  #$30, D0
                beq.s   Offset_0x00DC18
                subi.w  #$0040, Obj_Speed_Y(A0)                          ; $001A
                bra.s   Offset_0x00DC28
Offset_0x00DC18:
                move.b  (Control_Ports_Logical_Data_2).w, D0         ; $FFFFF66A
                andi.b  #$40, D0
                beq.s   Offset_0x00DC28
                subi.w  #$0010, Obj_Speed_Y(A0)                          ; $001A
Offset_0x00DC28:
                addi.w  #$0008, Obj_Speed_Y(A0)                          ; $001A
                cmpi.w  #$FF00, Obj_Speed_Y(A0)                          ; $001A
                bge.s   Offset_0x00DC3C
                move.w  #$FF00, Obj_Speed_Y(A0)                          ; $001A
Offset_0x00DC3C:
                rts
Offset_0x00DC3E:
                move.b  (Control_Ports_Logical_Data_2+$01).w, D0     ; $FFFFF66B
                andi.b  #$30, D0
                beq.s   Offset_0x00DC56
                tst.w   Obj_Speed_Y(A0)                                  ; $001A
                bmi.s   Offset_0x00DC6C
                subi.w  #$0300, Obj_Speed_Y(A0)                          ; $001A
                bra.s   Offset_0x00DC6C
Offset_0x00DC56:
                move.b  (Control_Ports_Logical_Data_2).w, D0         ; $FFFFF66A
                andi.b  #$40, D0
                beq.s   Offset_0x00DC6C
                tst.w   Obj_Speed_Y(A0)                                  ; $001A
                bmi.s   Offset_0x00DC6C
                subi.w  #$0200, Obj_Speed_Y(A0)                          ; $001A
Offset_0x00DC6C:
                addi.w  #$0008, Obj_Speed_Y(A0)                          ; $001A
                rts    
;-------------------------------------------------------------------------------
Miles_MdRoll:                                                  ; Offset_0x00DC74
                tst.b   Obj_Player_Spdsh_Flag(A0)                        ; $003D
                bne.s   Offset_0x00DC7E
                bsr     Miles_Jump                             ; Offset_0x00E238
Offset_0x00DC7E:
                bsr     Miles_RollRepel                        ; Offset_0x00E512
                bsr     Miles_RollSpeed                        ; Offset_0x00DFC6
                bsr     Miles_LevelBoundaries                  ; Offset_0x00E17C
                jsr     (SpeedToPos)                           ; Offset_0x01111E
                bsr     Player_AnglePos                        ; Offset_0x009144
                bsr     Miles_SlopeRepel                       ; Offset_0x00E54E
                tst.b   (Background_Collision_Flag).w                ; $FFFFF664
                beq.s   Offset_0x00DCA8
                bsr     Offset_0x009C92
                tst.w   D1
                bmi     Kill_Player                            ; Offset_0x00A4A4
Offset_0x00DCA8:
                rts       
;-------------------------------------------------------------------------------
Miles_MdJump2:                                                 ; Offset_0x00DCAA
                bsr     Miles_JumpHeight                       ; Offset_0x00E2F8
                bsr     Miles_ChgJumpDir                       ; Offset_0x00E0EC
                bsr     Miles_LevelBoundaries                  ; Offset_0x00E17C
                jsr     (ObjectFall)                           ; Offset_0x0110FE
                btst    #$06, Obj_Status(A0)                             ; $002A
                beq.s   Offset_0x00DCCA
                subi.w  #$0028, Obj_Speed_Y(A0)                          ; $001A
Offset_0x00DCCA:
                bsr     Miles_JumpAngle                        ; Offset_0x00E590
                bsr     Miles_Floor                            ; Offset_0x00E5F0
                rts   
;-------------------------------------------------------------------------------                
Miles_Move:                                                    ; Offset_0x00DCD4
                move.w  (A4), D6
                move.w  Acceleration(A4), D5                             ; $0002 
                move.w  Deceleration(A4), D4                             ; $0004
                tst.b   Obj_Player_Status(A0)                            ; $002F
                bmi     Offset_0x00DE20
                tst.w   Obj_P_Horiz_Ctrl_Lock(A0)                        ; $0032
                bne     Offset_0x00DDE2
                btst    #$02, (Control_Ports_Logical_Data_2).w       ; $FFFFF66A
                beq.s   Offset_0x00DCFA
                bsr     Offset_0x00DEC0
Offset_0x00DCFA:
                btst    #$03, (Control_Ports_Logical_Data_2).w       ; $FFFFF66A
                beq.s   Offset_0x00DD06
                bsr     Offset_0x00DF46
Offset_0x00DD06:
                move.b  Obj_Angle(A0), D0                                ; $0026
                addi.b  #$20, D0
                andi.b  #$C0, D0
                bne     Offset_0x00DDE2
                tst.w   Obj_Inertia(A0)                                  ; $001C
                bne     Offset_0x00DDE2
                bclr    #$05, Obj_Status(A0)                             ; $002A
                move.b  #$05, Obj_Ani_Number(A0)                         ; $0020
                btst    #$03, Obj_Status(A0)                             ; $002A
                beq.s   Offset_0x00DD5C
                move.w  Obj_Player_Last(A0), A1                          ; $0042
                tst.b   Obj_Status(A1)                                   ; $002A
                bmi.s   Offset_0x00DD8E
                moveq   #$00, D1
                move.b  Obj_Width(A1), D1                                ; $0007
                move.w  D1, D2
                add.w   D2, D2
                subq.w  #$04, D2
                add.w   Obj_X(A0), D1                                    ; $0010
                sub.w   Obj_X(A1), D1                                    ; $0010
                cmpi.w  #$0004, D1
                blt.s   Offset_0x00DD80
                cmp.w   D2, D1
                bge.s   Offset_0x00DD70
                bra.s   Offset_0x00DD8E
Offset_0x00DD5C:
                jsr     (Player_HitFloor)                      ; Offset_0x009CE0
                cmpi.w  #$000C, D1
                blt.s   Offset_0x00DD8E
                cmpi.b  #$03, Obj_Player_Next_Tilt(A0)                   ; $003A
                bne.s   Offset_0x00DD78
Offset_0x00DD70:
                bclr    #$00, Obj_Status(A0)                             ; $002A
                bra.s   Offset_0x00DD86
Offset_0x00DD78:
                cmpi.b  #$03, Obj_Player_Tilt(A0)                        ; $003B
                bne.s   Offset_0x00DD8E
Offset_0x00DD80:
                bset    #$00, Obj_Status(A0)                             ; $002A
Offset_0x00DD86:
                move.b  #$06, Obj_Ani_Number(A0)                         ; $0020
                bra.s   Offset_0x00DDE2
Offset_0x00DD8E:
                btst    #$00, (Control_Ports_Logical_Data_2).w       ; $FFFFF66A
                beq.s   Offset_0x00DDB8
                move.b  #$07, Obj_Ani_Number(A0)                         ; $0020
                addq.b  #$01, Obj_Look_Up_Down_Time(A0)                  ; $0039
                cmpi.b  #$78, Obj_Look_Up_Down_Time(A0)                  ; $0039
                bcs.s   Offset_0x00DDE8
                move.b  #$78, Obj_Look_Up_Down_Time(A0)                  ; $0039
                cmpi.w  #$00C8, (A5)
                beq.s   Offset_0x00DDF4
                addq.w  #$02, (A5)
                bra.s   Offset_0x00DDF4
Offset_0x00DDB8:
                btst    #$01, (Control_Ports_Logical_Data_2).w       ; $FFFFF66A
                beq.s   Offset_0x00DDE2
                move.b  #$08, Obj_Ani_Number(A0)                         ; $0020
                addq.b  #$01, Obj_Look_Up_Down_Time(A0)                  ; $0039
                cmpi.b  #$78, Obj_Look_Up_Down_Time(A0)                  ; $0039
                bcs.s   Offset_0x00DDE8
                move.b  #$78, Obj_Look_Up_Down_Time(A0)                  ; $0039
                cmpi.w  #$0008, (A5)
                beq.s   Offset_0x00DDF4
                subq.w  #$02, (A5)
                bra.s   Offset_0x00DDF4
Offset_0x00DDE2:
                move.b  #$00, Obj_Look_Up_Down_Time(A0)                  ; $0039
Offset_0x00DDE8:
                cmpi.w  #$0060, (A5)
                beq.s   Offset_0x00DDF4
                bcc.s   Offset_0x00DDF2
                addq.w  #$04, (A5)
Offset_0x00DDF2:
                subq.w  #$02, (A5)
Offset_0x00DDF4:
                move.b  (Control_Ports_Logical_Data_2).w, D0         ; $FFFFF66A
                andi.b  #$0C, D0
                bne.s   Offset_0x00DE20
                move.w  Obj_Inertia(A0), D0                              ; $001C
                beq.s   Offset_0x00DE20
                bmi.s   Offset_0x00DE14
                sub.w   D5, D0
                bcc.s   Offset_0x00DE0E
                move.w  #$0000, D0
Offset_0x00DE0E:
                move.w  D0, Obj_Inertia(A0)                              ; $001C
                bra.s   Offset_0x00DE20
Offset_0x00DE14:
                add.w   D5, D0
                bcc.s   Offset_0x00DE1C
                move.w  #$0000, D0
Offset_0x00DE1C:
                move.w  D0, Obj_Inertia(A0)                              ; $001C
Offset_0x00DE20:
                move.b  Obj_Angle(A0), D0                                ; $0026
                jsr     (CalcSine)                             ; Offset_0x001B20
                muls.w  Obj_Inertia(A0), D1                              ; $001C
                asr.l   #$08, D1
                move.w  D1, Obj_Speed_X(A0)                              ; $0018
                muls.w  Obj_Inertia(A0), D0                              ; $001C
                asr.l   #$08, D0
                move.w  D0, Obj_Speed_Y(A0)                              ; $001A
Offset_0x00DE3E:
                move.b  Obj_Angle(A0), D0                                ; $0026
                addi.b  #$40, D0
                bmi.s   Offset_0x00DEBE
                move.b  #$40, D1
                tst.w   Obj_Inertia(A0)                                  ; $001C
                beq.s   Offset_0x00DEBE
                bmi.s   Offset_0x00DE56
                neg.w   D1
Offset_0x00DE56:
                move.b  Obj_Angle(A0), D0                                ; $0026
                add.b   D1, D0
                move.w  D0, -(A7)
                bsr     Player_WalkSpeed                       ; Offset_0x009B1A
                move.w  (A7)+, D0
                tst.w   D1
                bpl.s   Offset_0x00DEBE
                asl.w   #$08, D1
                addi.b  #$20, D0
                andi.b  #$C0, D0
                beq.s   Offset_0x00DEBA
                cmpi.b  #$40, D0
                beq.s   Offset_0x00DEA0
                cmpi.b  #$80, D0
                beq.s   Offset_0x00DE9A
                add.w   D1, Obj_Speed_X(A0)                              ; $0018
                move.w  #$0000, Obj_Inertia(A0)                          ; $001C
                btst    #$00, Obj_Status(A0)                             ; $002A
                bne.s   Offset_0x00DE98
                bset    #$05, Obj_Status(A0)                             ; $002A
Offset_0x00DE98:
                rts
Offset_0x00DE9A:
                sub.w   D1, Obj_Speed_Y(A0)                              ; $001A
                rts
Offset_0x00DEA0:
                sub.w   D1, Obj_Speed_X(A0)                              ; $0018
                move.w  #$0000, Obj_Inertia(A0)                          ; $001C
                btst    #$00, Obj_Status(A0)                             ; $002A
                beq.s   Offset_0x00DE98
                bset    #$05, Obj_Status(A0)                             ; $002A
                rts
Offset_0x00DEBA:
                add.w   D1, Obj_Speed_Y(A0)                              ; $001A
Offset_0x00DEBE:
                rts
Offset_0x00DEC0:
                move.w  Obj_Inertia(A0), D0                              ; $001C
                beq.s   Offset_0x00DEC8
                bpl.s   Offset_0x00DEFA
Offset_0x00DEC8:
                bset    #$00, Obj_Status(A0)                             ; $002A
                bne.s   Offset_0x00DEDC
                bclr    #$05, Obj_Status(A0)                             ; $002A
                move.b  #$01, Obj_Ani_Flag(A0)                           ; $0021
Offset_0x00DEDC:
                sub.w   D5, D0
                move.w  D6, D1
                neg.w   D1
                cmp.w   D1, D0
                bgt.s   Offset_0x00DEEE
                add.w   D5, D0
                cmp.w   D1, D0
                ble.s   Offset_0x00DEEE
                move.w  D1, D0
Offset_0x00DEEE:
                move.w  D0, Obj_Inertia(A0)                              ; $001C
                move.b  #$00, Obj_Ani_Number(A0)                         ; $0020
                rts
Offset_0x00DEFA:
                sub.w   D4, D0
                bcc.s   Offset_0x00DF02
                move.w  #$FF80, D0
Offset_0x00DF02:
                move.w  D0, Obj_Inertia(A0)                              ; $001C
                move.b  Obj_Angle(A0), D0                                ; $0026
                addi.b  #$20, D0
                andi.b  #$C0, D0
                bne.s   Offset_0x00DF44
                cmpi.w  #$0400, D0
                blt.s   Offset_0x00DF44
                move.b  #$0D, Obj_Ani_Number(A0)                         ; $0020
                bclr    #$00, Obj_Status(A0)                             ; $002A
                move.w  #$0036, D0
                jsr     (Play_Music)                           ; Offset_0x001176
                cmpi.b  #$0C, Obj_Subtype(A0)                            ; $002C
                bcs.s   Offset_0x00DF44
                move.b  #$06, Obj_Routine(A6)                            ; $0005
                move.b  #$15, Obj_Map_Id(A6)                             ; $0022
Offset_0x00DF44:
                rts
Offset_0x00DF46:
                move.w  Obj_Inertia(A0), D0                              ; $001C
                bmi.s   Offset_0x00DF7A
                bclr    #$00, Obj_Status(A0)                             ; $002A
                beq.s   Offset_0x00DF60
                bclr    #$05, Obj_Status(A0)                             ; $002A
                move.b  #$01, Obj_Ani_Flag(A0)                           ; $0021
Offset_0x00DF60:
                add.w   D5, D0
                cmp.w   D6, D0
                blt.s   Offset_0x00DF6E
                sub.w   D5, D0
                cmp.w   D6, D0
                bge.s   Offset_0x00DF6E
                move.w  D6, D0
Offset_0x00DF6E:
                move.w  D0, Obj_Inertia(A0)                              ; $001C
                move.b  #$00, Obj_Ani_Number(A0)                         ; $0020
                rts
Offset_0x00DF7A:
                add.w   D4, D0
                bcc.s   Offset_0x00DF82
                move.w  #$0080, D0
Offset_0x00DF82:
                move.w  D0, Obj_Inertia(A0)                              ; $001C
                move.b  Obj_Angle(A0), D0                                ; $0026
                addi.b  #$20, D0
                andi.b  #$C0, D0
                bne.s   Offset_0x00DFC4
                cmpi.w  #$FC00, D0
                bgt.s   Offset_0x00DFC4
                move.b  #$0D, Obj_Ani_Number(A0)                         ; $0020
                bset    #$00, Obj_Status(A0)                             ; $002A
                move.w  #$0036, D0
                jsr     (Play_Music)                           ; Offset_0x001176
                cmpi.b  #$0C, Obj_Subtype(A0)                            ; $002C
                bcs.s   Offset_0x00DFC4
                move.b  #$06, Obj_Routine(A6)                            ; $0005
                move.b  #$15, Obj_Map_Id(A6)                             ; $0022
Offset_0x00DFC4:
                rts 
;-------------------------------------------------------------------------------                
Miles_RollSpeed:                                               ; Offset_0x00DFC6
                move.w  (A4), D6
                asl.w   #$01, D6
                move.w  Acceleration(A4), D5                             ; $0002
                asr.w   #$01, D5
                move.w  Deceleration(A4), D4                             ; $0004
                asr.w   #$02, D4
                tst.b   Obj_Player_Status(A0)                            ; $002F
                bmi     Offset_0x00E064
                tst.w   Obj_P_Horiz_Ctrl_Lock(A0)                        ; $0032
                bne.s   Offset_0x00DFFC
                btst    #$02, (Control_Ports_Logical_Data_2).w       ; $FFFFF66A
                beq.s   Offset_0x00DFF0
                bsr     Offset_0x00E0A6
Offset_0x00DFF0:
                btst    #$03, (Control_Ports_Logical_Data_2).w       ; $FFFFF66A
                beq.s   Offset_0x00DFFC
                bsr     Offset_0x00E0CA
Offset_0x00DFFC:
                move.w  Obj_Inertia(A0), D0                              ; $001C
                beq.s   Offset_0x00E01E
                bmi.s   Offset_0x00E012
                sub.w   D5, D0
                bcc.s   Offset_0x00E00C
                move.w  #$0000, D0
Offset_0x00E00C:
                move.w  D0, Obj_Inertia(A0)                              ; $001C
                bra.s   Offset_0x00E01E
Offset_0x00E012:
                add.w   D5, D0
                bcc.s   Offset_0x00E01A
                move.w  #$0000, D0
Offset_0x00E01A:
                move.w  D0, Obj_Inertia(A0)                              ; $001C
Offset_0x00E01E:
                tst.w   Obj_Inertia(A0)                                  ; $001C
                bne.s   Offset_0x00E064
                tst.b   Obj_Player_Spdsh_Flag(A0)                        ; $003D
                bne.s   Offset_0x00E052
                bclr    #$02, Obj_Status(A0)                             ; $002A
                move.b  Obj_Height_2(A0), D0                             ; $001E
                move.b  Obj_Height_3(A0), Obj_Height_2(A0)        ; $001E, $0044
                move.b  Obj_Width_3(A0), Obj_Width_2(A0)          ; $001F, $0045
                move.b  #$05, Obj_Ani_Number(A0)                         ; $0020
                sub.b   Obj_Height_3(A0), D0                             ; $0044
                ext.w   D0
                add.w   D0, Obj_Y(A0)                                    ; $0014
                bra.s   Offset_0x00E064
Offset_0x00E052:
                move.w  #$0400, Obj_Inertia(A0)                          ; $001C
                btst    #$00, Obj_Status(A0)                             ; $002A
                beq.s   Offset_0x00E064
                neg.w   Obj_Inertia(A0)                                  ; $001C
Offset_0x00E064:
                cmpi.w  #$0060, (A5)
                beq.s   Offset_0x00E070
                bcc.s   Offset_0x00E06E
                addq.w  #$04, (A5)
Offset_0x00E06E:
                subq.w  #$02, (A5)
Offset_0x00E070:
                move.b  Obj_Angle(A0), D0                                ; $0026
                jsr     (CalcSine)                             ; Offset_0x001B20
                muls.w  Obj_Inertia(A0), D0                              ; $001C
                asr.l   #$08, D0
                move.w  D0, Obj_Speed_Y(A0)                              ; $001A
                muls.w  Obj_Inertia(A0), D1                              ; $001C
                asr.l   #$08, D1
                cmpi.w  #$1000, D1
                ble.s   Offset_0x00E094
                move.w  #$1000, D1
Offset_0x00E094:
                cmpi.w  #$F000, D1
                bge.s   Offset_0x00E09E
                move.w  #$F000, D1
Offset_0x00E09E:
                move.w  D1, Obj_Speed_X(A0)                              ; $0018
                bra     Offset_0x00DE3E
Offset_0x00E0A6:
                move.w  Obj_Inertia(A0), D0                              ; $001C
                beq.s   Offset_0x00E0AE
                bpl.s   Offset_0x00E0BC
Offset_0x00E0AE:
                bset    #$00, Obj_Status(A0)                             ; $002A
                move.b  #$02, Obj_Ani_Number(A0)                         ; $0020
                rts
Offset_0x00E0BC:
                sub.w   D4, D0
                bcc.s   Offset_0x00E0C4
                move.w  #$FF80, D0
Offset_0x00E0C4:
                move.w  D0, Obj_Inertia(A0)                              ; $001C
                rts
Offset_0x00E0CA:
                move.w  Obj_Inertia(A0), D0                              ; $001C
                bmi.s   Offset_0x00E0DE
                bclr    #$00, Obj_Status(A0)                             ; $002A
                move.b  #$02, Obj_Ani_Number(A0)                         ; $0020
                rts
Offset_0x00E0DE:
                add.w   D4, D0
                bcc.s   Offset_0x00E0E6
                move.w  #$0080, D0
Offset_0x00E0E6:
                move.w  D0, Obj_Inertia(A0)                              ; $001C
                rts  
;-------------------------------------------------------------------------------                
Miles_ChgJumpDir:                                              ; Offset_0x00E0EC
                move.w  (A4), D6
                move.w  Acceleration(A4), D5                             ; $0002
                asl.w   #$01, D5
                btst    #$04, Obj_Status(A0)                             ; $002A
                bne.s   Offset_0x00E140
                move.w  Obj_Speed_X(A0), D0                              ; $0018
                btst    #$02, (Control_Ports_Logical_Data_2).w       ; $FFFFF66A
                beq.s   Offset_0x00E120
                bset    #$00, Obj_Status(A0)                             ; $002A
                sub.w   D5, D0
                move.w  D6, D1
                neg.w   D1
                cmp.w   D1, D0
                bgt.s   Offset_0x00E120
                add.w   D5, D0
                cmp.w   D1, D0
                ble.s   Offset_0x00E120
                move.w  D1, D0
Offset_0x00E120:
                btst    #$03, (Control_Ports_Logical_Data_2).w       ; $FFFFF66A
                beq.s   Offset_0x00E13C
                bclr    #$00, Obj_Status(A0)                             ; $002A
                add.w   D5, D0
                cmp.w   D6, D0
                blt.s   Offset_0x00E13C
                sub.w   D5, D0
                cmp.w   D6, D0
                bge.s   Offset_0x00E13C
                move.w  D6, D0
Offset_0x00E13C:
                move.w  D0, Obj_Speed_X(A0)                              ; $0018
Offset_0x00E140:
                cmpi.w  #$0060, (A5)
                beq.s   Offset_0x00E14C
                bcc.s   Offset_0x00E14A
                addq.w  #$04, (A5)
Offset_0x00E14A:
                subq.w  #$02, (A5)
Offset_0x00E14C:
                cmpi.w  #$FC00, Obj_Speed_Y(A0)                          ; $001A
                bcs.s   Offset_0x00E17A
                move.w  Obj_Speed_X(A0), D0                              ; $0018
                move.w  D0, D1
                asr.w   #$05, D1
                beq.s   Offset_0x00E17A
                bmi.s   Offset_0x00E16E
                sub.w   D1, D0
                bcc.s   Offset_0x00E168
                move.w  #$0000, D0
Offset_0x00E168:
                move.w  D0, Obj_Speed_X(A0)                              ; $0018
                rts
Offset_0x00E16E:
                sub.w   D1, D0
                bcs.s   Offset_0x00E176
                move.w  #$0000, D0
Offset_0x00E176:
                move.w  D0, Obj_Speed_X(A0)                              ; $0018
Offset_0x00E17A:
                rts  
;-------------------------------------------------------------------------------                
Miles_LevelBoundaries:                                         ; Offset_0x00E17C
                move.l  Obj_X(A0), D1                                    ; $0010
                move.w  Obj_Speed_X(A0), D0                              ; $0018
                ext.l   D0
                asl.l   #$08, D0
                add.l   D0, D1
                swap.w  D1
                move.w  (Miles_Level_Limits_Min_X).w, D0             ; $FFFFEE1C
                addi.w  #$0010, D0
                cmp.w   D1, D0
                bhi.s   Offset_0x00E1BA
                move.w  (Miles_Level_Limits_Max_X).w, D0             ; $FFFFEE1E
                addi.w  #$0128, D0
                cmp.w   D1, D0
                bls.s   Offset_0x00E1BA
Offset_0x00E1A4:
                move.w  (Miles_Level_Limits_Max_Y).w, D0             ; $FFFFEE22
                addi.w  #$00E0, D0
                cmp.w   Obj_Y(A0), D0                                    ; $0014
                blt.s   Offset_0x00E1B4
                rts
Offset_0x00E1B4:
                jmp     (Kill_Player)                          ; Offset_0x00A4A4
Offset_0x00E1BA:
                move.w  D0, Obj_X(A0)                                    ; $0010
                move.w  #$0000, Obj_Sub_X(A0)                            ; $0012
                move.w  #$0000, Obj_Speed_X(A0)                          ; $0018
                move.w  #$0000, Obj_Inertia(A0)                          ; $001C
                bra.s   Offset_0x00E1A4      
;-------------------------------------------------------------------------------                
Miles_Roll:                                                    ; Offset_0x00E1D2
                tst.b   Obj_Player_Status(A0)                            ; $002F
                bmi.s   Offset_0x00E1F8
                move.w  Obj_Inertia(A0), D0                              ; $001C
                bpl.s   Offset_0x00E1E0
                neg.w   D0
Offset_0x00E1E0:
                cmpi.w  #$0080, D0
                bcs.s   Offset_0x00E1F8
                move.b  (Control_Ports_Logical_Data_2).w, D0         ; $FFFFF66A
                andi.b  #$0C, D0
                bne.s   Offset_0x00E1F8
                btst    #$01, (Control_Ports_Logical_Data_2).w       ; $FFFFF66A
                bne.s   Offset_0x00E1FA
Offset_0x00E1F8:
                rts
Offset_0x00E1FA:
                btst    #$02, Obj_Status(A0)                             ; $002A
                beq.s   Offset_0x00E204
                rts
Offset_0x00E204:
                bset    #$02, Obj_Status(A0)                             ; $002A
                move.b  #$0E, Obj_Height_2(A0)                           ; $001E
                move.b  #$07, Obj_Width_2(A0)                            ; $001F
                move.b  #$02, Obj_Ani_Number(A0)                         ; $0020
                addq.w  #$01, Obj_Y(A0)                                  ; $0014
                move.w  #$003C, D0
                jsr     (Play_Music)                           ; Offset_0x001176
                tst.w   Obj_Inertia(A0)                                  ; $001C
                bne.s   Offset_0x00E236
                move.w  #$0200, Obj_Inertia(A0)                          ; $001C
Offset_0x00E236:
                rts       
;-------------------------------------------------------------------------------                
Miles_Jump:                                                    ; Offset_0x00E238
                move.b  (Control_Ports_Logical_Data_2+$01).w, D0     ; $FFFFF66B
                andi.b  #$70, D0
                beq     Offset_0x00E2EE
                moveq   #$00, D0
                move.b  Obj_Angle(A0), D0                                ; $0026
                addi.b  #$80, D0
                movem.l A4-A6, -(A7)
                bsr     CalcRoomOverHead                       ; Offset_0x009B94
                movem.l (A7)+, A4-A6
                cmpi.w  #$0006, D1
                blt     Offset_0x00E2EE
                move.w  #$0680, D2
                btst    #$06, Obj_Status(A0)                             ; $002A
                beq.s   Offset_0x00E272
                move.w  #$0380, D2
Offset_0x00E272:
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
                move.w  #$0070, D0
                jsr     (Play_Music)                           ; Offset_0x001176
                move.b  Obj_Height_3(A0), Obj_Height_2(A0)        ; $001E, $0044
                move.b  Obj_Width_3(A0), Obj_Width_2(A0)          ; $001F, $0045
                btst    #$02, Obj_Status(A0)                             ; $002A
                bne.s   Offset_0x00E2F0
                move.b  #$0E, Obj_Height_2(A0)                           ; $001E
                move.b  #$07, Obj_Width_2(A0)                            ; $001F
                move.b  #$02, Obj_Ani_Number(A0)                         ; $0020
                bset    #$02, Obj_Status(A0)                             ; $002A
                move.b  Obj_Height_2(A0), D0                             ; $001E
                sub.b   Obj_Height_3(A0), D0                             ; $0044
                ext.w   D0
                sub.w   D0, Obj_Y(A0)                                    ; $0014
Offset_0x00E2EE:
                rts
Offset_0x00E2F0:
                bset    #$04, Obj_Status(A0)                             ; $002A
                rts  
;-------------------------------------------------------------------------------                
Miles_JumpHeight:                                              ; Offset_0x00E2F8
                tst.b   Obj_Player_Jump(A0)                              ; $0040
                beq.s   Offset_0x00E324
                move.w  #$FC00, D1
                btst    #$06, Obj_Status(A0)                             ; $002A
                beq.s   Offset_0x00E30E
                move.w  #$FE00, D1
Offset_0x00E30E:
                cmp.w   Obj_Speed_Y(A0), D1                              ; $001A
                ble.s   Offset_0x00E33A
                move.b  (Control_Ports_Logical_Data_2).w, D0         ; $FFFFF66A
                andi.b  #$70, D0
                bne.s   Offset_0x00E322
                move.w  D1, Obj_Speed_Y(A0)                              ; $001A
Offset_0x00E322:
                rts
Offset_0x00E324:
                tst.b   Obj_Player_Spdsh_Flag(A0)                        ; $003D
                bne.s   Offset_0x00E338
                cmpi.w  #$F040, Obj_Speed_Y(A0)                          ; $001A
                bge.s   Offset_0x00E338
                move.w  #$F040, Obj_Speed_Y(A0)                          ; $001A
Offset_0x00E338:
                rts
Offset_0x00E33A:
                btst    #$02, Obj_Status(A0)                             ; $002A
                beq     Offset_0x00E39A
                move.b  (Control_Ports_Logical_Data_2+$01).w, D0     ; $FFFFF66B
                andi.b  #$70, D0
                beq.s   Offset_0x00E39A
                tst.w   (Miles_CPU_Ctrl_Auto_Timer).w                ; $FFFFF702
                beq.s   Offset_0x00E39A
                btst    #$02, Obj_Status(A0)                             ; $002A
                beq.s   Offset_0x00E382
                bclr    #$02, Obj_Status(A0)                             ; $002A
                move.b  Obj_Height_2(A0), D1                             ; $001E
                move.b  Obj_Height_3(A0), Obj_Height_2(A0)        ; $001E, $0044
                move.b  Obj_Width_3(A0), Obj_Width_2(A0)          ; $001F, $0045
                sub.b   Obj_Height_3(A0), D1                             ; $0044
                ext.w   D1
                add.w   D1, Obj_Y(A0)                                    ; $0014
                move.b  #$00, Obj_Ani_Number(A0)                         ; $0020
Offset_0x00E382:
                move.b  #$01, (Level_Boundaries_Flag).w              ; $FFFFF668
                andi.b  #$30, D0
                beq.s   Offset_0x00E394
                move.b  #$02, (Level_Boundaries_Flag).w              ; $FFFFF668
Offset_0x00E394:
                move.b  #$20, Obj_Ani_Number(A0)                         ; $0020
Offset_0x00E39A:
                rts   
;-------------------------------------------------------------------------------                
Miles_Spindash:                                                ; Offset_0x00E39C
                tst.b   Obj_Player_Spdsh_Flag(A0)                        ; $003D
                bne.s   Offset_0x00E3EC
                cmpi.b  #$08, Obj_Ani_Number(A0)                         ; $0020
                bne.s   Offset_0x00E3EA
                move.b  (Control_Ports_Logical_Data_2+$01).w, D0     ; $FFFFF66B
                andi.b  #$70, D0
                beq     Offset_0x00E3EA
                move.b  #$09, Obj_Ani_Number(A0)                         ; $0020
                move.w  #Rolling_Sfx, D0                                 ; $003C
                jsr     (Play_Music)                           ; Offset_0x001176
                addq.l  #$04, A7
                move.b  #$01, Obj_Player_Spdsh_Flag(A0)                  ; $003D
                move.w  #$0000, Obj_Player_Spdsh_Cnt(A0)                 ; $003E
                cmpi.b  #$0C, Obj_Subtype(A0)                            ; $002C
                bcs.s   Offset_0x00E3E2
                move.b  #$02, Obj_Ani_Number(A6)                         ; $0020
Offset_0x00E3E2:
                bsr     Miles_LevelBoundaries                  ; Offset_0x00E17C
                bsr     Player_AnglePos                        ; Offset_0x009144
Offset_0x00E3EA:
                rts
Offset_0x00E3EC:
                move.b  (Control_Ports_Logical_Data_2).w, D0         ; $FFFFF66A
                btst    #$01, D0
                bne     Offset_0x00E47C
                move.b  #$0E, Obj_Height_2(A0)                           ; $001E
                move.b  #$07, Obj_Width_2(A0)                            ; $001F
                move.b  #$02, Obj_Ani_Number(A0)                         ; $0020
                addq.w  #$01, Obj_Y(A0)                                  ; $0014
                move.b  #$00, Obj_Player_Spdsh_Flag(A0)                  ; $003D
                moveq   #$00, D0
                move.b  Obj_Player_Spdsh_Cnt(A0), D0                     ; $003E
                add.w   D0, D0
                move.w  Miles_Spindash_Speed(PC, D0), Obj_Inertia(A0) ; Offset_0x00E46A, $001C
                move.w  Obj_Inertia(A0), D0                              ; $001C
                subi.w  #$0800, D0
                add.w   D0, D0
                andi.w  #$1F00, D0
                neg.w   D0
                addi.w  #$2000, D0
                lea     (Camera_X_Scroll_Delay).w, A1                ; $FFFFEE24
                cmpa.w  #Obj_Player_One, A0                              ; $B000
                beq.s   Offset_0x00E444
                lea     (Camera_X_Scroll_Delay_2P).w, A1             ; $FFFFEE28
Offset_0x00E444:
                move.w  D0, (A1)
                btst    #$00, Obj_Status(A0)                             ; $002A
                beq.s   Offset_0x00E452
                neg.w   Obj_Inertia(A0)                                  ; $001C
Offset_0x00E452:
                bset    #$02, Obj_Status(A0)                             ; $002A
                move.b  #$00, Obj_Ani_Number(A6)                         ; $0020
                move.w  #Rolling_Sfx, D0                                 ; $003C
                jsr     (Play_Music)                           ; Offset_0x001176
                bra.s   Offset_0x00E4C4   
;-------------------------------------------------------------------------------
Miles_Spindash_Speed:                                          ; Offset_0x00E46A
                dc.w    $0800, $0880, $0900, $0980, $0A00, $0A80, $0B00, $0B80
                dc.w    $0C00  
;-------------------------------------------------------------------------------
Offset_0x00E47C:
                tst.w   Obj_Player_Spdsh_Cnt(A0)                         ; $003E
                beq.s   Offset_0x00E494
                move.w  Obj_Player_Spdsh_Cnt(A0), D0                     ; $003E
                lsr.w   #$05, D0
                sub.w   D0, Obj_Player_Spdsh_Cnt(A0)                     ; $003E
                bcc.s   Offset_0x00E494
                move.w  #$0000, Obj_Player_Spdsh_Cnt(A0)                 ; $003E
Offset_0x00E494:
                move.b  (Control_Ports_Logical_Data_2+$01).w, D0     ; $FFFFF66B
                andi.b  #$70, D0
                beq     Offset_0x00E4C4
                move.w  #$0900, Obj_Ani_Number(A0)                       ; $0020
                move.w  #Rolling_Sfx, D0                                 ; $003C
                jsr     (Play_Music)                           ; Offset_0x001176
                addi.w  #$0200, Obj_Player_Spdsh_Cnt(A0)                 ; $003E
                cmpi.w  #$0800, Obj_Player_Spdsh_Cnt(A0)                 ; $003E
                bcs.s   Offset_0x00E4C4
                move.w  #$0800, Obj_Player_Spdsh_Cnt(A0)                 ; $003E
Offset_0x00E4C4:
                addq.l  #$04, A7
                cmpi.w  #$0060, (A5)
                beq.s   Offset_0x00E4D2
                bcc.s   Offset_0x00E4D0
                addq.w  #$04, (A5)
Offset_0x00E4D0:
                subq.w  #$02, (A5)
Offset_0x00E4D2:
                bsr     Miles_LevelBoundaries                  ; Offset_0x00E17C
                bsr     Player_AnglePos                        ; Offset_0x009144
                rts
;-------------------------------------------------------------------------------
Miles_SlopeResist:                                             ; Offset_0x00E4DC
                move.b  Obj_Angle(A0), D0                                ; $0026
                addi.b  #$60, D0
                cmpi.b  #$C0, D0
                bcc.s   Offset_0x00E510
                move.b  Obj_Angle(A0), D0                                ; $0026
                jsr     (CalcSine)                             ; Offset_0x001B20
                muls.w  #$0020, D0
                asr.l   #$08, D0
                tst.w   Obj_Inertia(A0)                                  ; $001C
                beq.s   Offset_0x00E510
                bmi.s   Offset_0x00E50C
                tst.w   D0
                beq.s   Offset_0x00E50A
                add.w   D0, Obj_Inertia(A0)                              ; $001C
Offset_0x00E50A:
                rts
Offset_0x00E50C:
                add.w   D0, Obj_Inertia(A0)                              ; $001C
Offset_0x00E510:
                rts   
;-------------------------------------------------------------------------------                
Miles_RollRepel:                                               ; Offset_0x00E512
                move.b  Obj_Angle(A0), D0                                ; $0026
                addi.b  #$60, D0
                cmpi.b  #$C0, D0
                bcc.s   Offset_0x00E54C
                move.b  Obj_Angle(A0), D0                                ; $0026
                jsr     (CalcSine)                             ; Offset_0x001B20
                muls.w  #$0050, D0
                asr.l   #$08, D0
                tst.w   Obj_Inertia(A0)                                  ; $001C
                bmi.s   Offset_0x00E542
                tst.w   D0
                bpl.s   Offset_0x00E53C
                asr.l   #$02, D0
Offset_0x00E53C:
                add.w   D0, Obj_Inertia(A0)                              ; $001C
                rts
Offset_0x00E542:
                tst.w   D0
                bmi.s   Offset_0x00E548
                asr.l   #$02, D0
Offset_0x00E548:
                add.w   D0, Obj_Inertia(A0)                              ; $001C
Offset_0x00E54C:
                rts    
;-------------------------------------------------------------------------------                
Miles_SlopeRepel:                                              ; Offset_0x00E54E
                nop
                tst.b   Obj_Player_St_Convex(A0)                         ; $003C
                bne.s   Offset_0x00E588
                tst.w   Obj_P_Horiz_Ctrl_Lock(A0)                        ; $0032
                bne.s   Offset_0x00E58A
                move.b  Obj_Angle(A0), D0                                ; $0026
                addi.b  #$20, D0
                andi.b  #$C0, D0
                beq.s   Offset_0x00E588
                move.w  Obj_Inertia(A0), D0                              ; $001C
                bpl.s   Offset_0x00E572
                neg.w   D0
Offset_0x00E572:
                cmpi.w  #$0280, D0
                bcc.s   Offset_0x00E588
                clr.w   Obj_Inertia(A0)                                  ; $001C
                bset    #$01, Obj_Status(A0)                             ; $002A
                move.w  #$001E, Obj_P_Horiz_Ctrl_Lock(A0)                ; $0032
Offset_0x00E588:
                rts
Offset_0x00E58A:
                subq.w  #$01, Obj_P_Horiz_Ctrl_Lock(A0)                  ; $0032
                rts  
;-------------------------------------------------------------------------------                
Miles_JumpAngle:                                               ; Offset_0x00E590
                move.b  Obj_Angle(A0), D0                                ; $0026
                beq.s   Offset_0x00E5AA
                bpl.s   Offset_0x00E5A0
                addq.b  #$02, D0
                bcc.s   Offset_0x00E59E
                moveq   #$00, D0
Offset_0x00E59E:
                bra.s   Offset_0x00E5A6
Offset_0x00E5A0:
                subq.b  #$02, D0
                bcc.s   Offset_0x00E5A6
                moveq   #$00, D0
Offset_0x00E5A6:
                move.b  D0, Obj_Angle(A0)                                ; $0026
Offset_0x00E5AA:
                move.b  Obj_Flip_Angle(A0), D0                           ; $0027
                beq.s   Offset_0x00E5EE
                tst.w   Obj_Inertia(A0)                                  ; $001C
                bmi.s   Offset_0x00E5CE
Offset_0x00E5B6:
                move.b  Obj_Player_Flip_Speed(A0), D1                    ; $0031
                add.b   D1, D0
                bcc.s   Offset_0x00E5CC
                subq.b  #$01, Obj_P_Flips_Remaining(A0)                  ; $0030
                bcc.s   Offset_0x00E5CC
                move.b  #$00, Obj_P_Flips_Remaining(A0)                  ; $0030
                moveq   #$00, D0
Offset_0x00E5CC:
                bra.s   Offset_0x00E5EA
Offset_0x00E5CE:
                tst.b   Obj_Player_Flip_Flag(A0)                         ; $002D
                bne.s   Offset_0x00E5B6
                move.b  Obj_Player_Flip_Speed(A0), D1                    ; $0031
                sub.b   D1, D0
                bcc.s   Offset_0x00E5EA
                subq.b  #$01, Obj_P_Flips_Remaining(A0)                  ; $0030
                bcc.s   Offset_0x00E5EA
                move.b  #$00, Obj_P_Flips_Remaining(A0)                  ; $0030
                moveq   #$00, D0
Offset_0x00E5EA:
                move.b  D0, Obj_Flip_Angle(A0)                           ; $0027
Offset_0x00E5EE:
                rts     
;-------------------------------------------------------------------------------                
Miles_Floor:                                                   ; Offset_0x00E5F0
                move.l  (Primary_Collision_Ptr).w, (Current_Collision_Ptr).w ; $FFFFF7B4, $FFFFF796
                cmpi.b  #$0C, Obj_Player_Top_Solid(A0)                   ; $0046
                beq.s   Offset_0x00E604
                move.l  (Secondary_Collision_Ptr).w, (Current_Collision_Ptr).w ; $FFFFF7B8, $FFFFF796
Offset_0x00E604:
                move.b  Obj_Player_LRB_Solid(A0), D5                     ; $0047
                move.w  Obj_Speed_X(A0), D1                              ; $0018
                move.w  Obj_Speed_Y(A0), D2                              ; $001A
                jsr     (CalcAngle)                            ; Offset_0x001DB8
                subi.b  #$20, D0
                andi.b  #$C0, D0
                cmpi.b  #$40, D0
                beq     Offset_0x00E6CE
                cmpi.b  #$80, D0
                beq     Offset_0x00E72A
                cmpi.b  #$C0, D0
                beq     Offset_0x00E786
                bsr     Player_HitWall                         ; Offset_0x00A0BC
                tst.w   D1
                bpl.s   Offset_0x00E648
                sub.w   D1, Obj_X(A0)                                    ; $0010
                move.w  #$0000, Obj_Speed_X(A0)                          ; $0018
Offset_0x00E648:
                bsr     Offset_0x009EC6
                tst.w   D1
                bpl.s   Offset_0x00E65A
                add.w   D1, Obj_X(A0)                                    ; $0010
                move.w  #$0000, Obj_Speed_X(A0)                          ; $0018
Offset_0x00E65A:
                bsr     Player_Check_Floor                     ; Offset_0x009BD4
                tst.w   D1
                bpl.s   Offset_0x00E6CC
                move.b  Obj_Speed_Y(A0), D2                              ; $001A
                addq.b  #$08, D2
                neg.b   D2
                cmp.b   D2, D1
                bge.s   Offset_0x00E672
                cmp.b   D2, D0
                blt.s   Offset_0x00E6CC
Offset_0x00E672:
                add.w   D1, Obj_Y(A0)                                    ; $0014
                move.b  D3, Obj_Angle(A0)                                ; $0026
                bsr     Miles_ResetMilesOnFloor                ; Offset_0x00E7E2
                move.b  D3, D0
                addi.b  #$20, D0
                andi.b  #$40, D0
                bne.s   Offset_0x00E6AA
                move.b  D3, D0
                addi.b  #$10, D0
                andi.b  #$20, D0
                beq.s   Offset_0x00E69C
                asr.w   Obj_Speed_Y(A0)                                  ; $001A
                bra.s   Offset_0x00E6BE
Offset_0x00E69C:
                move.w  #$0000, Obj_Speed_Y(A0)                          ; $001A
                move.w  Obj_Speed_X(A0), Obj_Inertia(A0)          ; $0018, $001C
                rts
Offset_0x00E6AA:
                move.w  #$0000, Obj_Speed_X(A0)                          ; $0018
                cmpi.w  #$0FC0, Obj_Speed_Y(A0)                          ; $001A
                ble.s   Offset_0x00E6BE
                move.w  #$0FC0, Obj_Speed_Y(A0)                          ; $001A
Offset_0x00E6BE:
                move.w  Obj_Speed_Y(A0), Obj_Inertia(A0)          ; $001A, $001C
                tst.b   D3
                bpl.s   Offset_0x00E6CC
                neg.w   Obj_Inertia(A0)                                  ; $001C
Offset_0x00E6CC:
                rts
Offset_0x00E6CE:
                bsr     Player_HitWall                         ; Offset_0x00A0BC
                tst.w   D1
                bpl.s   Offset_0x00E6E8
                sub.w   D1, Obj_X(A0)                                    ; $0010
                move.w  #$0000, Obj_Speed_X(A0)                          ; $0018
                move.w  Obj_Speed_Y(A0), Obj_Inertia(A0)          ; $001A, $001C
                rts
Offset_0x00E6E8:
                bsr     Player_DontRunOnWalls                  ; Offset_0x009F1C
                tst.w   D1
                bpl.s   Offset_0x00E702
                sub.w   D1, Obj_Y(A0)                                    ; $0014
                tst.w   Obj_Speed_Y(A0)                                  ; $001A
                bpl.s   Offset_0x00E700
                move.w  #$0000, Obj_Speed_Y(A0)                          ; $001A
Offset_0x00E700:
                rts
Offset_0x00E702:
                tst.w   Obj_Speed_Y(A0)                                  ; $001A
                bmi.s   Offset_0x00E728
                bsr     Player_Check_Floor                     ; Offset_0x009BD4
                tst.w   D1
                bpl.s   Offset_0x00E728
                add.w   D1, Obj_Y(A0)                                    ; $0014
                move.b  D3, Obj_Angle(A0)                                ; $0026
                bsr     Miles_ResetMilesOnFloor                ; Offset_0x00E7E2
                move.w  #$0000, Obj_Speed_Y(A0)                          ; $001A
                move.w  Obj_Speed_X(A0), Obj_Inertia(A0)          ; $0018, $001C
Offset_0x00E728:
                rts
Offset_0x00E72A:
                bsr     Player_HitWall                         ; Offset_0x00A0BC
                tst.w   D1
                bpl.s   Offset_0x00E73C
                sub.w   D1, Obj_X(A0)                                    ; $0010
                move.w  #$0000, Obj_Speed_X(A0)                          ; $0018
Offset_0x00E73C:
                bsr     Offset_0x009EC6
                tst.w   D1
                bpl.s   Offset_0x00E74E
                add.w   D1, Obj_X(A0)                                    ; $0010
                move.w  #$0000, Obj_Speed_X(A0)                          ; $0018
Offset_0x00E74E:
                bsr     Player_DontRunOnWalls                  ; Offset_0x009F1C
                tst.w   D1
                bpl.s   Offset_0x00E784
                sub.w   D1, Obj_Y(A0)                                    ; $0014
                move.b  D3, D0
                addi.b  #$20, D0
                andi.b  #$40, D0
                bne.s   Offset_0x00E76E
                move.w  #$0000, Obj_Speed_Y(A0)                          ; $001A
                rts
Offset_0x00E76E:
                move.b  D3, Obj_Angle(A0)                                ; $0026
                bsr     Miles_ResetMilesOnFloor                ; Offset_0x00E7E2
                move.w  Obj_Speed_Y(A0), Obj_Inertia(A0)          ; $001A, $001C
                tst.b   D3
                bpl.s   Offset_0x00E784
                neg.w   Obj_Inertia(A0)                                  ; $001C
Offset_0x00E784:
                rts
Offset_0x00E786:
                bsr     Offset_0x009EC6
                tst.w   D1
                bpl.s   Offset_0x00E7A0
                add.w   D1, Obj_X(A0)                                    ; $0010
                move.w  #$0000, Obj_Speed_X(A0)                          ; $0018
                move.w  Obj_Speed_Y(A0), Obj_Inertia(A0)          ; $001A, $001C
                rts
Offset_0x00E7A0:
                bsr     Player_DontRunOnWalls                  ; Offset_0x009F1C
                tst.w   D1
                bpl.s   Offset_0x00E7BA
                sub.w   D1, Obj_Y(A0)                                    ; $0014
                tst.w   Obj_Speed_Y(A0)                                  ; $001A
                bpl.s   Offset_0x00E7B8
                move.w  #$0000, Obj_Speed_Y(A0)                          ; $001A
Offset_0x00E7B8:
                rts
Offset_0x00E7BA:
                tst.w   Obj_Speed_Y(A0)                                  ; $001A
                bmi.s   Offset_0x00E7E0
                bsr     Player_Check_Floor                     ; Offset_0x009BD4
                tst.w   D1
                bpl.s   Offset_0x00E7E0
                add.w   D1, Obj_Y(A0)                                    ; $0014
                move.b  D3, Obj_Angle(A0)                                ; $0026
                bsr     Miles_ResetMilesOnFloor                ; Offset_0x00E7E2
                move.w  #$0000, Obj_Speed_Y(A0)                          ; $001A
                move.w  Obj_Speed_X(A0), Obj_Inertia(A0)          ; $0018, $001C
Offset_0x00E7E0:
                rts
;-------------------------------------------------------------------------------
Miles_ResetMilesOnFloor:                                       ; Offset_0x00E7E2
                tst.b   Obj_Player_Spdsh_Flag(A0)                        ; $003D
                bne.s   Offset_0x00E81C
                move.b  #$00, Obj_Ani_Number(A0)                         ; $0020
;-------------------------------------------------------------------------------
Miles_ResetOnFloor:                                            ; Offset_0x00E7EE                 
                move.b  Obj_Height_2(A0), D0                             ; $001E
                move.b  Obj_Height_3(A0), Obj_Height_2(A0)        ; $0044, $001E 
                move.b  Obj_Width_3(A0), Obj_Width_2(A0)          ; $0045, $001F 
                btst    #$02, Obj_Status(A0)                             ; $002A
                beq.s   Offset_0x00E81C
                bclr    #$02, Obj_Status(A0)                             ; $002A
                move.b  #$00, Obj_Ani_Number(A0)                         ; $0020
                sub.b   Obj_Height_3(A0), D0                             ; $0044
                ext.w   D0
                add.w   D0, Obj_Y(A0)                                    ; $0014
Offset_0x00E81C:
                bclr    #$01, Obj_Status(A0)                             ; $002A
                bclr    #$05, Obj_Status(A0)                             ; $002A
                bclr    #$04, Obj_Status(A0)                             ; $002A
                move.b  #$00, Obj_Player_Jump(A0)                        ; $0040
                move.w  #$0000, (Enemy_Hit_Chain_Count).w            ; $FFFFF7D0
                move.b  #$00, Obj_Flip_Angle(A0)                         ; $0027
                move.b  #$00, Obj_Player_Flip_Flag(A0)                   ; $002D
                move.b  #$00, Obj_P_Flips_Remaining(A0)                  ; $0030
                move.b  #$00, Obj_Look_Up_Down_Time(A0)                  ; $0039
                move.b  #$00, (Level_Boundaries_Flag).w              ; $FFFFF668
                move.w  #$0000, (Carrying_Sonic_Data).w              ; $FFFFF73E
                cmpi.b  #$14, Obj_Ani_Number(A0)                         ; $0020
                bne.s   Offset_0x00E86C
                move.b  #$00, Obj_Ani_Number(A0)                         ; $0020
Offset_0x00E86C:
                rts     
;-------------------------------------------------------------------------------
Miles_Hurt:                                                    ; Offset_0x00E86E
                jsr     (SpeedToPos)                           ; Offset_0x01111E
                addi.w  #$0030, Obj_Speed_Y(A0)                          ; $001A
                btst    #$06, Obj_Status(A0)                             ; $002A
                beq.s   Offset_0x00E888
                subi.w  #$0020, Obj_Speed_Y(A0)                          ; $001A
Offset_0x00E888:
                cmpi.w  #$FF00, (Sonic_Level_Limits_Min_Y).w         ; $FFFFEE18
                bne.s   Offset_0x00E898
                move.w  (Screen_Wrap_Y).w, D0                        ; $FFFFEEAA
                and.w   D0, Obj_Y(A0)                                    ; $0014
Offset_0x00E898:
                bsr     Miles_HurtStop                         ; Offset_0x00E8AE
                bsr     Miles_LevelBoundaries                  ; Offset_0x00E17C
                bsr     CopySonicMovesForMiles                 ; Offset_0x00ACA2
                bsr     Miles_Animate                          ; Offset_0x00E952
                jmp     (DisplaySprite)                        ; Offset_0x011148
;-------------------------------------------------------------------------------                
Miles_HurtStop:                                                ; Offset_0x00E8AE
                move.w  (Miles_Level_Limits_Max_Y).w, D0             ; $FFFFEE22
                addi.w  #$00E0, D0
                cmp.w   Obj_Y(A0), D0                                    ; $0014
                blt     Kill_Miles                             ; Offset_0x00E904
                movem.l A4-A6, -(A7)
                bsr     Miles_Floor                            ; Offset_0x00E5F0
                movem.l (A7)+, A4-A6
                btst    #$01, Obj_Status(A0)                             ; $002A
                bne.s   Offset_0x00E902
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
Offset_0x00E902:
                rts
;-------------------------------------------------------------------------------                
Kill_Miles:                                                    ; Offset_0x00E904
                jmp     (Kill_Player)                          ; Offset_0x00A4A4
;-------------------------------------------------------------------------------
Miles_Death:                                                   ; Offset_0x00E90A
                bsr     Player_GameOver                        ; Offset_0x00C126
                jsr     (ObjectFall)                           ; Offset_0x0110FE
                bsr     CopySonicMovesForMiles                 ; Offset_0x00ACA2
                bsr     Miles_Animate                          ; Offset_0x00E952
                jmp     (DisplaySprite)                        ; Offset_0x011148 
;-------------------------------------------------------------------------------  
Miles_ResetLevel:                                              ; Offset_0x00E922
                tst.w   Obj_Player_Spdsh_Cnt(A0)                         ; $003E
                beq.s   Offset_0x00E934
                subq.w  #$01, Obj_Player_Spdsh_Cnt(A0)                   ; $003E
                bne.s   Offset_0x00E934
                move.w  #$0001, (Restart_Level_Flag).w               ; $FFFFFE02
Offset_0x00E934:
                rts  
;-------------------------------------------------------------------------------                
Miles_Respawning:                                              ; Offset_0x00E936
                tst.w   (Horizontal_Scrolling_P2).w                  ; $FFFFEE04
                bne.s   Offset_0x00E948
                tst.w   (Vertical_Scrolling_P2).w                    ; $FFFFEE06
                bne.s   Offset_0x00E948
                move.b  #$02, Obj_Routine(A0)                            ; $0005
Offset_0x00E948:
                bsr     Miles_Animate                          ; Offset_0x00E952
                jmp     (DisplaySprite)                        ; Offset_0x011148
;-------------------------------------------------------------------------------                
Miles_Animate:                                                 ; Offset_0x00E952
                tst.w   (Two_Player_Flag).w                          ; $FFFFFFD8
                bne.s   Offset_0x00E95E
                bsr.s   Offset_0x00E966
                bra     Load_Miles_Dynamic_PLC                 ; Offset_0x00ED7C
Offset_0x00E95E:
                bsr     Miles_Animate_Sprite_2P                ; Offset_0x00EDD0
                bra     Load_Miles_Dynamic_PLC_2P              ; Offset_0x00F150
Offset_0x00E966:
                lea     (Miles_Animate_Data), A1               ; Offset_0x00EC08
Miles_Animate_Sprite:                                          ; Offset_0x00E96C                
                moveq   #$00, D0
                move.b  Obj_Ani_Number(A0), D0                           ; $0020
                cmp.b   Obj_Ani_Flag(A0), D0                             ; $0021
                beq.s   Offset_0x00E98E
                move.b  D0, Obj_Ani_Flag(A0)                             ; $0021
                move.b  #$00, Obj_Ani_Frame(A0)                          ; $0023
                move.b  #$00, Obj_Ani_Time(A0)                           ; $0024
                bclr    #$05, Obj_Status(A0)                             ; $002A
Offset_0x00E98E:
                add.w   D0, D0
                adda.w  $00(A1, D0), A1
                move.b  (A1), D0
                bmi.s   Offset_0x00E9FE
                move.b  Obj_Status(A0), D1                               ; $002A
                andi.b  #$01, D1
                andi.b  #$FC, Obj_Flags(A0)                              ; $0004
                or.b    D1, Obj_Flags(A0)                                ; $0004
                subq.b  #$01, Obj_Ani_Time(A0)                           ; $0024
                bpl.s   Offset_0x00E9CC
                move.b  D0, Obj_Ani_Time(A0)                             ; $0024
Offset_0x00E9B4:
                moveq   #$00, D1
                move.b  Obj_Ani_Frame(A0), D1                            ; $0023
                move.b  $01(A1, D1), D0
                cmpi.b  #$F0, D0
                bcc.s   Offset_0x00E9CE
Offset_0x00E9C4:
                move.b  D0, Obj_Map_Id(A0)                               ; $0022
                addq.b  #$01, Obj_Ani_Frame(A0)                          ; $0023
Offset_0x00E9CC:
                rts
Offset_0x00E9CE:
                addq.b  #$01, D0
                bne.s   Offset_0x00E9DE
                move.b  #$00, Obj_Ani_Frame(A0)                          ; $0023
                move.b  $0001(A1), D0
                bra.s   Offset_0x00E9C4
Offset_0x00E9DE:
                addq.b  #$01, D0
                bne.s   Offset_0x00E9F2
                move.b  $02(A1, D1), D0
                sub.b   D0, Obj_Ani_Frame(A0)                            ; $0023
                sub.b   D0, D1
                move.b  $01(A1, D1), D0
                bra.s   Offset_0x00E9C4
Offset_0x00E9F2:
                addq.b  #$01, D0
                bne.s   Offset_0x00E9FC
                move.b  $02(A1, D1), Obj_Ani_Number(A0)                  ; $0020
Offset_0x00E9FC:
                rts
Offset_0x00E9FE:
                addq.b  #$01, D0
                bne     Offset_0x00EB2E
                moveq   #$00, D0
                move.b  Obj_Flip_Angle(A0), D0                           ; $0027
                bne     Offset_0x00EAC8
                moveq   #$00, D1
                move.b  Obj_Angle(A0), D0                                ; $0026
                bmi.s   Offset_0x00EA1A
                beq.s   Offset_0x00EA1A
                subq.b  #$01, D0
Offset_0x00EA1A:
                move.b  Obj_Status(A0), D2                               ; $002A
                andi.b  #$01, D2
                bne.s   Offset_0x00EA26
                not.b   D0
Offset_0x00EA26:
                addi.b  #$10, D0
                bpl.s   Offset_0x00EA2E
                moveq   #$03, D1
Offset_0x00EA2E:
                andi.b  #$FC, Obj_Flags(A0)                              ; $0004
                eor.b   D1, D2
                or.b    D2, Obj_Flags(A0)                                ; $0004
                btst    #$05, Obj_Status(A0)                             ; $002A
                bne     Offset_0x00EB7A
                lsr.b   #$04, D0
                andi.b  #$06, D0
                move.w  Obj_Inertia(A0), D2                              ; $001C
                bpl.s   Offset_0x00EA52
                neg.w   D2
Offset_0x00EA52:
                tst.b   Obj_Player_Status(A0)                            ; $002F
                bpl     Offset_0x00EA5C
                add.w   D2, D2
Offset_0x00EA5C:
                move.b  D0, D3
                add.b   D3, D3
                add.b   D3, D3
                lea     (Offset_0x00EC4A), A1
                cmpi.w  #$0600, D2
                bcs.s   Offset_0x00EA8A
                lea     (Offset_0x00EC54), A1
                move.b  D0, D1
                lsr.b   #$01, D1
                add.b   D1, D0
                add.b   D0, D0
                move.b  D0, D3
                cmpi.w  #$0700, D2
                bcs.s   Offset_0x00EA8A
                lea     (Offset_0x00ED45), A1
Offset_0x00EA8A:
                moveq   #$00, D1
                move.b  Obj_Ani_Frame(A0), D1                            ; $0023
                move.b  $01(A1, D1), D0
                cmpi.b  #$FF, D0
                bne.s   Offset_0x00EAA4
                move.b  #$00, Obj_Ani_Frame(A0)                          ; $0023
                move.b  $0001(A1), D0
Offset_0x00EAA4:
                move.b  D0, Obj_Map_Id(A0)                               ; $0022
                add.b   D3, Obj_Map_Id(A0)                               ; $0022
                subq.b  #$01, Obj_Ani_Time(A0)                           ; $0024
                bpl.s   Offset_0x00EAC6
                neg.w   D2
                addi.w  #$0800, D2
                bpl.s   Offset_0x00EABC
                moveq   #$00, D2
Offset_0x00EABC:
                lsr.w   #$08, D2
                move.b  D2, Obj_Ani_Time(A0)                             ; $0024
                addq.b  #$01, Obj_Ani_Frame(A0)                          ; $0023
Offset_0x00EAC6:
                rts
Offset_0x00EAC8:
                move.b  Obj_Flip_Angle(A0), D0                           ; $0027
                moveq   #$00, D1
                move.b  Obj_Status(A0), D2                               ; $002A
                andi.b  #$01, D2
                bne.s   Offset_0x00EAF6
                andi.b  #$FC, Obj_Flags(A0)                              ; $0004
                addi.b  #$0B, D0
                divu.w  #$0016, D0
                addi.b  #$75, D0
                move.b  D0, Obj_Map_Id(A0)                               ; $0022
                move.b  #$00, Obj_Ani_Time(A0)                           ; $0024
                rts
Offset_0x00EAF6:
                andi.b  #$FC, Obj_Flags(A0)                              ; $0004
                tst.b   Obj_Player_Flip_Flag(A0)                         ; $002D
                beq.s   Offset_0x00EB0E
                ori.b   #$01, Obj_Flags(A0)                              ; $0004
                addi.b  #$0B, D0
                bra.s   Offset_0x00EB1A
Offset_0x00EB0E:
                ori.b   #$03, Obj_Flags(A0)                              ; $0004
                neg.b   D0
                addi.b  #$8F, D0
Offset_0x00EB1A:
                divu.w  #$0016, D0
                addi.b  #$75, D0
                move.b  D0, Obj_Map_Id(A0)                               ; $0022
                move.b  #$00, Obj_Ani_Time(A0)                           ; $0024
                rts
Offset_0x00EB2E:
                subq.b  #$01, Obj_Ani_Time(A0)                           ; $0024
                bpl     Offset_0x00E9CC
                addq.b  #$01, D0
                bne.s   Offset_0x00EBB4
                move.w  Obj_Inertia(A0), D2                              ; $001C
                bpl.s   Offset_0x00EB42
                neg.w   D2
Offset_0x00EB42:
                lea     (Offset_0x00EC63), A1
                cmpi.w  #$0600, D2
                bcc.s   Offset_0x00EB54
                lea     (Offset_0x00EC5E), A1
Offset_0x00EB54:
                neg.w   D2
                addi.w  #$0400, D2
                bpl.s   Offset_0x00EB5E
                moveq   #$00, D2
Offset_0x00EB5E:
                lsr.w   #$08, D2
                move.b  D2, Obj_Ani_Time(A0)                             ; $0024
                move.b  Obj_Status(A0), D1                               ; $002A
                andi.b  #$01, D1
                andi.b  #$FC, Obj_Flags(A0)                              ; $0004
                or.b    D1, Obj_Flags(A0)                                ; $0004
                bra     Offset_0x00E9B4
Offset_0x00EB7A:
                subq.b  #$01, Obj_Ani_Time(A0)                           ; $0024
                bpl     Offset_0x00E9CC
                move.w  Obj_Inertia(A0), D2                              ; $001C
                bmi.s   Offset_0x00EB8A
                neg.w   D2
Offset_0x00EB8A:
                addi.w  #$0800, D2
                bpl.s   Offset_0x00EB92
                moveq   #$00, D2
Offset_0x00EB92:
                lsr.w   #$06, D2
                move.b  D2, Obj_Ani_Time(A0)                             ; $0024
                lea     (Offset_0x00EC68), A1
                move.b  Obj_Status(A0), D1                               ; $002A
                andi.b  #$01, D1
                andi.b  #$FC, Obj_Flags(A0)                              ; $0004
                or.b    D1, Obj_Flags(A0)                                ; $0004
                bra     Offset_0x00E9B4
Offset_0x00EBB4:
                move.w  Obj_Speed_X(A2), D1                              ; $0018
                move.w  Obj_Speed_Y(A2), D2                              ; $001A
                jsr     (CalcAngle)                            ; Offset_0x001DB8
                moveq   #$00, D1
                move.b  Obj_Status(A0), D2                               ; $002A
                andi.b  #$01, D2
                bne.s   Offset_0x00EBD2
                not.b   D0
                bra.s   Offset_0x00EBD6
Offset_0x00EBD2:
                addi.b  #$80, D0
Offset_0x00EBD6:
                addi.b  #$10, D0
                bpl.s   Offset_0x00EBDE
                moveq   #$03, D1
Offset_0x00EBDE:
                andi.b  #$FC, Obj_Flags(A0)                              ; $0004
                eor.b   D1, D2
                or.b    D2, Obj_Flags(A0)                                ; $0004
                lsr.b   #$03, D0
                andi.b  #$0C, D0
                move.b  D0, D3
                lea     (Offset_0x00F27E), A1
                move.b  #$03, Obj_Ani_Time(A0)                           ; $0024
                bsr     Offset_0x00E9B4
                add.b   D3, Obj_Map_Id(A0)                               ; $0022
                rts       
;-------------------------------------------------------------------------------
Miles_Animate_Data:                                            ; Offset_0x00EC08 
                dc.w    Offset_0x00EC4A-Miles_Animate_Data
                dc.w    Offset_0x00EC54-Miles_Animate_Data
                dc.w    Offset_0x00EC5E-Miles_Animate_Data
                dc.w    Offset_0x00EC63-Miles_Animate_Data
                dc.w    Offset_0x00EC68-Miles_Animate_Data
                dc.w    Offset_0x00EC72-Miles_Animate_Data
                dc.w    Offset_0x00ECB0-Miles_Animate_Data
                dc.w    Offset_0x00ECC8-Miles_Animate_Data
                dc.w    Offset_0x00ECCB-Miles_Animate_Data
                dc.w    Offset_0x00ECCE-Miles_Animate_Data
                dc.w    Offset_0x00ECD3-Miles_Animate_Data
                dc.w    Offset_0x00ECD6-Miles_Animate_Data
                dc.w    Offset_0x00ECDC-Miles_Animate_Data
                dc.w    Offset_0x00ECE0-Miles_Animate_Data
                dc.w    Offset_0x00ECE7-Miles_Animate_Data
                dc.w    Offset_0x00ECEB-Miles_Animate_Data
                dc.w    Offset_0x00ECF2-Miles_Animate_Data
                dc.w    Offset_0x00ED01-Miles_Animate_Data
                dc.w    Offset_0x00ED05-Miles_Animate_Data
                dc.w    Offset_0x00ED0B-Miles_Animate_Data
                dc.w    Offset_0x00ED10-Miles_Animate_Data
                dc.w    Offset_0x00ED14-Miles_Animate_Data
                dc.w    Offset_0x00ED1B-Miles_Animate_Data
                dc.w    Offset_0x00ED1E-Miles_Animate_Data
                dc.w    Offset_0x00ED21-Miles_Animate_Data
                dc.w    Offset_0x00ED24-Miles_Animate_Data
                dc.w    Offset_0x00ED27-Miles_Animate_Data
                dc.w    Offset_0x00ED2A-Miles_Animate_Data
                dc.w    Offset_0x00ED2E-Miles_Animate_Data
                dc.w    Offset_0x00ED31-Miles_Animate_Data
                dc.w    Offset_0x00ED3B-Miles_Animate_Data
                dc.w    Offset_0x00ED45-Miles_Animate_Data
                dc.w    Offset_0x00ED4F-Miles_Animate_Data
Offset_0x00EC4A:
                dc.b    $FF, $10, $11, $12, $13, $14, $15, $0E
                dc.b    $0F, $FF
Offset_0x00EC54:
                dc.b    $FF, $2E, $2F, $30, $31, $FF, $FF, $FF
                dc.b    $FF, $FF
Offset_0x00EC5E:
                dc.b    $01, $48, $47, $46, $FF
Offset_0x00EC63:
                dc.b    $01, $48, $47, $46, $FF
Offset_0x00EC68:
                dc.b    $FD, $63, $64, $65, $66, $FF, $FF, $FF
                dc.b    $FF, $FF
Offset_0x00EC72:
                dc.b    $07, $01, $01, $01, $01, $01, $01, $01
                dc.b    $01, $01, $01, $03, $02, $01, $01, $01
                dc.b    $01, $01, $01, $01, $01, $03, $02, $01
                dc.b    $01, $01, $01, $01, $01, $01, $01, $01
                dc.b    $05, $05, $05, $05, $05, $05, $05, $05
                dc.b    $05, $05, $05, $05, $05, $05, $05, $05
                dc.b    $06, $07, $08, $07, $08, $07, $08, $07
                dc.b    $08, $07, $08, $06, $FE, $1C
Offset_0x00ECB0:
                dc.b    $09, $69, $69, $6A, $6A, $69, $69, $6A
                dc.b    $6A, $69, $69, $6A, $6A, $69, $69, $6A
                dc.b    $6A, $69, $69, $6A, $6A, $69, $6A, $FF
Offset_0x00ECC8:
                dc.b    $3F, $04, $FF
Offset_0x00ECCB:
                dc.b    $3F, $5B, $FF
Offset_0x00ECCE:
                dc.b    $00, $60, $61, $62, $FF
Offset_0x00ECD3:
                dc.b    $3F, $82, $FF
Offset_0x00ECD6:
                dc.b    $07, $08, $08, $09, $FD, $05
Offset_0x00ECDC:
                dc.b    $07, $09, $FD, $05
Offset_0x00ECE0:
                dc.b    $07, $67, $68, $67, $68, $FD, $00
Offset_0x00ECE7:
                dc.b    $09, $6E, $73, $FF
Offset_0x00ECEB:
                dc.b    $09, $6E, $6F, $70, $71, $72, $FF
Offset_0x00ECF2:
                dc.b    $03, $59, $5A, $59, $5A, $59, $5A, $59
                dc.b    $5A, $59, $5A, $59, $5A, $FD, $00
Offset_0x00ED01:
                dc.b    $05, $6C, $6D, $FF
Offset_0x00ED05:
                dc.b    $0F, $01, $02, $03, $FE, $01
Offset_0x00ED0B:
                dc.b    $0F, $01, $02, $FE, $01
Offset_0x00ED10:
                dc.b    $13, $85, $86, $FF
Offset_0x00ED14:
                dc.b    $0B, $74, $74, $12, $13, $FD, $00
Offset_0x00ED1B:
                dc.b    $20, $5D, $FF
Offset_0x00ED1E:
                dc.b    $2F, $5D, $FF
Offset_0x00ED21:
                dc.b    $03, $5D, $FF
Offset_0x00ED24:
                dc.b    $03, $5D, $FF
Offset_0x00ED27:
                dc.b    $03, $5C, $FF
Offset_0x00ED2A:
                dc.b    $09, $6B, $5C, $FF
Offset_0x00ED2E:
                dc.b    $77, $00, $FF
Offset_0x00ED31:
                dc.b    $03, $01, $02, $03, $04, $05, $06, $07
                dc.b    $08, $FF
Offset_0x00ED3B:
                dc.b    $03, $01, $02, $03, $04, $05, $06, $07
                dc.b    $08, $FF
Offset_0x00ED45:
                dc.b    $FF, $32, $33, $FF, $FF, $FF, $FF, $FF
                dc.b    $FF, $FF
Offset_0x00ED4F:
                dc.b    $01, $5E, $5F, $FF, $00   
;-------------------------------------------------------------------------------
Load_Miles_Tails_Dynamic_PLC:                                  ; Offset_0x00ED54
                moveq   #$00, D0
                move.b  Obj_Map_Id(A0), D0                               ; $0022
                cmp.b   (Miles_Tails_Previous_Frame).w, D0           ; $FFFFF7DF
                beq.s   Exit_Load_Miles_Dynamic_PLC            ; Offset_0x00EDCE
                move.b  D0, (Miles_Tails_Previous_Frame).w           ; $FFFFF7DF
                lea     (Miles_Dyn_Script), A2                 ; Offset_0x102866
                add.w   D0, D0
                adda.w  $00(A2, D0), A2
                move.w  (A2)+, D5
                subq.w  #$01, D5
                bmi.s   Exit_Load_Miles_Dynamic_PLC            ; Offset_0x00EDCE
                move.w  #$D600, D4
                bra.s   Loop_Load_Miles_Art                    ; Offset_0x00EDA2  
;-------------------------------------------------------------------------------                
Load_Miles_Dynamic_PLC:                                        ; Offset_0x00ED7C
                moveq   #$00, D0
                move.b  Obj_Map_Id(A0), D0                               ; $0022
                cmp.b   (Miles_Previous_Frame).w, D0                 ; $FFFFF7DE
                beq.s   Exit_Load_Miles_Dynamic_PLC            ; Offset_0x00EDCE
                move.b  D0, (Miles_Previous_Frame).w                 ; $FFFFF7DE
                lea     (Miles_Dyn_Script), A2                 ; Offset_0x102866
                add.w   D0, D0
                adda.w  $00(A2, D0), A2
                move.w  (A2)+, D5
                subq.w  #$01, D5
                bmi.s   Exit_Load_Miles_Dynamic_PLC            ; Offset_0x00EDCE
                move.w  #$D400, D4
Loop_Load_Miles_Art:                                           ; Offset_0x00EDA2
                moveq   #$00, D1
                move.w  (A2)+, D1
                move.w  D1, D3
                lsr.w   #$08, D3
                andi.w  #$00F0, D3
                addi.w  #$0010, D3
                andi.w  #$0FFF, D1
                lsl.l   #$05, D1
                addi.l  #Art_Miles, D1                         ; Offset_0x0676A0
                move.w  D4, D2
                add.w   D3, D4
                add.w   D3, D4
                jsr     (DMA_68KtoVRAM)                        ; Offset_0x0012FC
                dbra    D5, Loop_Load_Miles_Art                ; Offset_0x00EDA2
Exit_Load_Miles_Dynamic_PLC:                                   ; Offset_0x00EDCE
                rts       
;-------------------------------------------------------------------------------
Miles_Animate_Sprite_2P:                                       ; Offset_0x00EDD0
                lea     (Offset_0x00F060), A1
Miles_Animate_Sprite_2P_A1:                                    ; Offset_0x00EDD6                
                moveq   #$00, D0
                move.b  Obj_Ani_Number(A0), D0                           ; $0020
                cmp.b   Obj_Ani_Flag(A0), D0                             ; $0021
                beq.s   Offset_0x00EDF8
                move.b  D0, Obj_Ani_Flag(A0)                             ; $0021
                move.b  #$00, Obj_Ani_Frame(A0)                          ; $0023
                move.b  #$00, Obj_Ani_Time(A0)                           ; $0024
                bclr    #$05, Obj_Status(A0)                             ; $002A
Offset_0x00EDF8:
                add.w   D0, D0
                adda.w  $00(A1, D0), A1
                move.b  (A1), D0
                bmi.s   Offset_0x00EE68
                move.b  Obj_Status(A0), D1                               ; $002A
                andi.b  #$01, D1
                andi.b  #$FC, Obj_Flags(A0)                              ; $0004
                or.b    D1, Obj_Flags(A0)                                ; $0004
                subq.b  #$01, Obj_Ani_Time(A0)                           ; $0024
                bpl.s   Offset_0x00EE36
                move.b  D0, Obj_Ani_Time(A0)                             ; $0024
Offset_0x00EE1E:
                moveq   #$00, D1
                move.b  Obj_Ani_Frame(A0), D1                            ; $0023
                move.b  $01(A1, D1), D0
                cmpi.b  #$F0, D0
                bcc.s   Offset_0x00EE38
Offset_0x00EE2E:
                move.b  D0, Obj_Map_Id(A0)                               ; $0022
                addq.b  #$01, Obj_Ani_Frame(A0)                          ; $0023
Offset_0x00EE36:
                rts
Offset_0x00EE38:
                addq.b  #$01, D0
                bne.s   Offset_0x00EE48
                move.b  #$00, Obj_Ani_Frame(A0)                          ; $0023
                move.b  $0001(A1), D0
                bra.s   Offset_0x00EE2E
Offset_0x00EE48:
                addq.b  #$01, D0
                bne.s   Offset_0x00EE5C
                move.b  $02(A1, D1), D0
                sub.b   D0, Obj_Ani_Frame(A0)                            ; $0023
                sub.b   D0, D1
                move.b  $01(A1, D1), D0
                bra.s   Offset_0x00EE2E
Offset_0x00EE5C:
                addq.b  #$01, D0
                bne.s   Offset_0x00EE66
                move.b  $02(A1, D1), Obj_Ani_Number(A0)                  ; $0020
Offset_0x00EE66:
                rts
Offset_0x00EE68:
                addq.b  #$01, D0
                bne     Offset_0x00EF82
                moveq   #$00, D0
                move.b  Obj_Flip_Angle(A0), D0                           ; $0027
                bne     Offset_0x00EF1C
                moveq   #$00, D1
                move.b  Obj_Angle(A0), D0                                ; $0026
                bmi.s   Offset_0x00EE84
                beq.s   Offset_0x00EE84
                subq.b  #$01, D0
Offset_0x00EE84:
                move.b  Obj_Status(A0), D2                               ; $002A
                andi.b  #$01, D2
                bne.s   Offset_0x00EE90
                not.b   D0
Offset_0x00EE90:
                addi.b  #$10, D0
                bpl.s   Offset_0x00EE98
                moveq   #$03, D1
Offset_0x00EE98:
                andi.b  #$FC, Obj_Flags(A0)                              ; $0004
                eor.b   D1, D2
                or.b    D2, Obj_Flags(A0)                                ; $0004
                btst    #$05, Obj_Status(A0)                             ; $002A
                bne     Offset_0x00EFCE
                lsr.b   #$05, D0
                andi.b  #$03, D0
                move.w  Obj_Inertia(A0), D2                              ; $001C
                bpl.s   Offset_0x00EEBC
                neg.w   D2
Offset_0x00EEBC:
                tst.b   Obj_Player_Status(A0)                            ; $002F
                bpl     Offset_0x00EEC6
                add.w   D2, D2
Offset_0x00EEC6:
                move.b  D0, D3
                lea     (Offset_0x00F0A8), A1
                cmpi.w  #$0600, D2
                bcc.s   Offset_0x00EEDC
                lea     (Offset_0x00F0A2), A1
                add.b   D0, D0
Offset_0x00EEDC:
                add.b   D0, D3
                moveq   #$00, D1
                move.b  Obj_Ani_Frame(A0), D1                            ; $0023
                move.b  $01(A1, D1), D0
                cmpi.b  #$FF, D0
                bne.s   Offset_0x00EEF8
                move.b  #$00, Obj_Ani_Frame(A0)                          ; $0023
                move.b  $0001(A1), D0
Offset_0x00EEF8:
                move.b  D0, Obj_Map_Id(A0)                               ; $0022
                add.b   D3, Obj_Map_Id(A0)                               ; $0022
                subq.b  #$01, Obj_Ani_Time(A0)                           ; $0024
                bpl.s   Offset_0x00EF1A
                neg.w   D2
                addi.w  #$0800, D2
                bpl.s   Offset_0x00EF10
                moveq   #$00, D2
Offset_0x00EF10:
                lsr.w   #$08, D2
                move.b  D2, Obj_Ani_Time(A0)                             ; $0024
                addq.b  #$01, Obj_Ani_Frame(A0)                          ; $0023
Offset_0x00EF1A:
                rts
Offset_0x00EF1C:
                move.b  Obj_Flip_Angle(A0), D0                           ; $0027
                moveq   #$00, D1
                move.b  Obj_Status(A0), D2                               ; $002A
                andi.b  #$01, D2
                bne.s   Offset_0x00EF4A
                andi.b  #$FC, Obj_Flags(A0)                              ; $0004
                addi.b  #$16, D0
                divu.w  #$002C, D0
                addi.b  #$15, D0
                move.b  D0, Obj_Map_Id(A0)                               ; $0022
                move.b  #$00, Obj_Ani_Time(A0)                           ; $0024
                rts
Offset_0x00EF4A:
                andi.b  #$FC, Obj_Flags(A0)                              ; $0004
                tst.b   Obj_Player_Flip_Flag(A0)                         ; $002D
                beq.s   Offset_0x00EF62
                ori.b   #$01, Obj_Flags(A0)                              ; $0004
                addi.b  #$16, D0
                bra.s   Offset_0x00EF6E
Offset_0x00EF62:
                ori.b   #$03, Obj_Flags(A0)                              ; $0004
                neg.b   D0
                addi.b  #$9A, D0
Offset_0x00EF6E:
                divu.w  #$002C, D0
                addi.b  #$15, D0
                move.b  D0, Obj_Map_Id(A0)                               ; $0022
                move.b  #$00, Obj_Ani_Time(A0)                           ; $0024
                rts
Offset_0x00EF82:
                subq.b  #$01, Obj_Ani_Time(A0)                           ; $0024
                bpl     Offset_0x00EE36
                addq.b  #$01, D0
                bne.s   Offset_0x00F008
                move.w  Obj_Inertia(A0), D2                              ; $001C
                bpl.s   Offset_0x00EF96
                neg.w   D2
Offset_0x00EF96:
                lea     (Offset_0x00F0B3), A1
                cmpi.w  #$0600, D2
                bcc.s   Offset_0x00EFA8
                lea     (Offset_0x00F0AE), A1
Offset_0x00EFA8:
                neg.w   D2
                addi.w  #$0400, D2
                bpl.s   Offset_0x00EFB2
                moveq   #$00, D2
Offset_0x00EFB2:
                lsr.w   #$08, D2
                move.b  D2, Obj_Ani_Time(A0)                             ; $0024
                move.b  Obj_Status(A0), D1                               ; $002A
                andi.b  #$01, D1
                andi.b  #$FC, Obj_Flags(A0)                              ; $0004
                or.b    D1, Obj_Flags(A0)                                ; $0004
                bra     Offset_0x00EE1E
Offset_0x00EFCE:
                subq.b  #$01, Obj_Ani_Time(A0)                           ; $0024
                bpl     Offset_0x00EE36
                move.w  Obj_Inertia(A0), D2                              ; $001C
                bmi.s   Offset_0x00EFDE
                neg.w   D2
Offset_0x00EFDE:
                addi.w  #$0800, D2
                bpl.s   Offset_0x00EFE6
                moveq   #$00, D2
Offset_0x00EFE6:
                lsr.w   #$06, D2
                move.b  D2, Obj_Ani_Time(A0)                             ; $0024
                lea     (Offset_0x00F0B8), A1
                move.b  Obj_Status(A0), D1                               ; $002A
                andi.b  #$01, D1
                andi.b  #$FC, Obj_Flags(A0)                              ; $0004
                or.b    D1, Obj_Flags(A0)                                ; $0004
                bra     Offset_0x00EE1E
Offset_0x00F008:
                move.w  Obj_Speed_X(A2), D1                              ; $0018
                move.w  Obj_Speed_Y(A2), D2                              ; $001A
                jsr     (CalcAngle)                            ; Offset_0x001DB8
                moveq   #$00, D1
                move.b  Obj_Status(A0), D2                               ; $002A
                andi.b  #$01, D2
                bne.s   Offset_0x00F026
                not.b   D0
                bra.s   Offset_0x00F02A
Offset_0x00F026:
                addi.b  #$80, D0
Offset_0x00F02A:
                addi.b  #$10, D0
                bpl.s   Offset_0x00F032
                moveq   #$03, D1
Offset_0x00F032:
                andi.b  #$FC, Obj_Flags(A0)                              ; $0004
                eor.b   D1, D2
                or.b    D2, Obj_Flags(A0)                                ; $0004
                lsr.b   #$05, D0
                andi.b  #$03, D0
                move.b  D0, D3
                add.b   D0, D0
                add.b   D0, D3
                lea     (Miles_Tails_2P_Ani_02), A1            ; Offset_0x00F386
                move.b  #$03, Obj_Ani_Time(A0)                           ; $0024
                bsr     Offset_0x00EE1E
                add.b   D3, Obj_Map_Id(A0)                               ; $0022
                rts  
;-------------------------------------------------------------------------------
Offset_0x00F060:
                dc.w    Offset_0x00F0A2-Offset_0x00F060
                dc.w    Offset_0x00F0A8-Offset_0x00F060
                dc.w    Offset_0x00F0AE-Offset_0x00F060
                dc.w    Offset_0x00F0B3-Offset_0x00F060
                dc.w    Offset_0x00F0B8-Offset_0x00F060
                dc.w    Offset_0x00F0BE-Offset_0x00F060
                dc.w    Offset_0x00F0BE-Offset_0x00F060
                dc.w    Offset_0x00F0BE-Offset_0x00F060
                dc.w    Offset_0x00F0D9-Offset_0x00F060
                dc.w    Offset_0x00F0DC-Offset_0x00F060
                dc.w    Offset_0x00F0BE-Offset_0x00F060
                dc.w    Offset_0x00F0BE-Offset_0x00F060
                dc.w    Offset_0x00F0BE-Offset_0x00F060
                dc.w    Offset_0x00F0E0-Offset_0x00F060
                dc.w    Offset_0x00F0E7-Offset_0x00F060
                dc.w    Offset_0x00F0EA-Offset_0x00F060
                dc.w    Offset_0x00F0ED-Offset_0x00F060
                dc.w    Offset_0x00F0F1-Offset_0x00F060
                dc.w    Offset_0x00F0F4-Offset_0x00F060
                dc.w    Offset_0x00F0F7-Offset_0x00F060
                dc.w    Offset_0x00F0FA-Offset_0x00F060
                dc.w    Offset_0x00F0FD-Offset_0x00F060
                dc.w    Offset_0x00F100-Offset_0x00F060
                dc.w    Offset_0x00F103-Offset_0x00F060
                dc.w    Offset_0x00F106-Offset_0x00F060
                dc.w    Offset_0x00F109-Offset_0x00F060
                dc.w    Offset_0x00F109-Offset_0x00F060
                dc.w    Offset_0x00F10C-Offset_0x00F060
                dc.w    Offset_0x00F10F-Offset_0x00F060
                dc.w    Offset_0x00F112-Offset_0x00F060
                dc.w    Offset_0x00F115-Offset_0x00F060
                dc.w    Offset_0x00F118-Offset_0x00F060
                dc.w    Offset_0x00F11E-Offset_0x00F060
Offset_0x00F0A2:
                dc.b    $FF, $01, $02, $03, $02, $FF
Offset_0x00F0A8:
                dc.b    $FF, $0D, $0E, $FF, $FF, $FF
Offset_0x00F0AE:
                dc.b    $01, $28, $29, $2A, $FF
Offset_0x00F0B3:
                dc.b    $01, $28, $29, $2A, $FF
Offset_0x00F0B8:
                dc.b    $FD, $25, $26, $FF, $FF, $FF
Offset_0x00F0BE:
                dc.b    $07, $1B, $1B, $1B, $1B, $1B, $1B, $1B
                dc.b    $1B, $1C, $1C, $1C, $1C, $1C, $1C, $1D
                dc.b    $1E, $1D, $1E, $1D, $1E, $1D, $1E, $1D
                dc.b    $1E, $FE, $10
Offset_0x00F0D9:
                dc.b    $05, $2B, $FF
Offset_0x00F0DC:
                dc.b    $00, $23, $24, $FF
Offset_0x00F0E0:
                dc.b    $05, $22, $22, $22, $22, $FD, $00
Offset_0x00F0E7:
                dc.b    $07, $15, $FF
Offset_0x00F0EA:
                dc.b    $07, $15, $FF
Offset_0x00F0ED:
                dc.b    $2F, $15, $FD, $00
Offset_0x00F0F1:
                dc.b    $01, $15, $FF
Offset_0x00F0F4:
                dc.b    $0F, $1F, $FF
Offset_0x00F0F7:
                dc.b    $0F, $1F, $FF
Offset_0x00F0FA:
                dc.b    $13, $15, $FF
Offset_0x00F0FD:
                dc.b    $0B, $15, $FF
Offset_0x00F100:
                dc.b    $20, $20, $FF
Offset_0x00F103:
                dc.b    $20, $20, $FF
Offset_0x00F106:
                dc.b    $20, $20, $FF
Offset_0x00F109:
                dc.b    $40, $21, $FF
Offset_0x00F10C:
                dc.b    $09, $21, $FF
Offset_0x00F10F:
                dc.b    $77, $00, $FF
Offset_0x00F112:
                dc.b    $03, $1B, $FF
Offset_0x00F115:
                dc.b    $03, $1B, $FF
Offset_0x00F118:
                dc.b    $FF, $0D, $0E, $FF, $FF, $FF
Offset_0x00F11E:
                dc.b    $01, $2C, $2D, $FF   
;-------------------------------------------------------------------------------
Load_Miles_Tails_Dynamic_PLC_2P:                               ; Offset_0x00F122
                moveq   #$00, D0
                move.b  Obj_Map_Id(A0), D0                               ; $0022
                lea     (Miles_Tails_2P_Dyn_Script), A2        ; Offset_0x103282
                add.w   D0, D0
                adda.w  $00(A2, D0), A2
                move.w  (A2)+, D5
                subq.w  #$01, D5
                bmi.s   Offset_0x00F1A4
                move.l  #Art_Miles_Tails_2P, D6                ; Offset_0x07D3C0
                move.w  #$D600, D4
                cmpa.w  #$CC0A, A0
                beq.s   Offset_0x00F17C
                move.w  #$D200, D4
                bra.s   Offset_0x00F17C   
;-------------------------------------------------------------------------------
Load_Miles_Dynamic_PLC_2P:                                     ; Offset_0x00F150
                moveq   #$00, D0
                move.b  Obj_Map_Id(A0), D0                               ; $0022
                lea     (Miles_Dyn_Script_2P), A2              ; Offset_0x103174
                add.w   D0, D0
                adda.w  $00(A2, D0), A2
                move.w  (A2)+, D5
                subq.w  #$01, D5
                bmi.s   Offset_0x00F1A4
                move.l  #Art_Miles_2P, D6                      ; Offset_0x07A620
                move.w  #$D000, D4
                cmpa.w  #$B000, A0
                beq.s   Offset_0x00F17C
                move.w  #$D400, D4
Offset_0x00F17C:
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
                dbra    D5, Offset_0x00F17C
Offset_0x00F1A4:
                rts                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            
;===============================================================================
; Objeto Miles
; <<<-  
;===============================================================================  