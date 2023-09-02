;===============================================================================
; Objeto 0x01 - Monitores
; ->>>
;===============================================================================      
; Offset_0x012F44:
                moveq   #$00, D0
                move.b  Obj_Routine(A0), D0                              ; $0005
                move.w  Offset_0x012F52(PC, D0), D1
                jmp     Offset_0x012F52(PC, D1)   
;-------------------------------------------------------------------------------
Offset_0x012F52:
                dc.w    Offset_0x012F5C-Offset_0x012F52
                dc.w    Offset_0x012FC6-Offset_0x012F52
                dc.w    Offset_0x013094-Offset_0x012F52
                dc.w    Offset_0x013020-Offset_0x012F52
                dc.w    Offset_0x01302A-Offset_0x012F52  
;-------------------------------------------------------------------------------
Offset_0x012F5C:
                addq.b  #$02, Obj_Routine(A0)                            ; $0005
                move.b  #$0F, Obj_Height_2(A0)                           ; $001E
                move.b  #$0F, Obj_Width_2(A0)                            ; $001F
                move.l  #Monitors_Mappings, Obj_Map(A0) ; Offset_0x0134A2, $000C
                move.w  #$04C4, Obj_Art_VRAM(A0)                         ; $000A
                move.b  #$04, Obj_Flags(A0)                              ; $0004
                move.w  #$0180, Obj_Priority(A0)                         ; $0008
                move.b  #$0E, Obj_Width(A0)                              ; $0007
                move.b  #$10, Obj_Height(A0)                             ; $0006
                move.w  Obj_Respaw_Ref(A0), A2                           ; $0048
                bclr    #$07, (A2)
                btst    #$00, (A2)
                beq.s   Offset_0x012FAE
                move.b  #$08, Obj_Routine(A0)                            ; $0005
                move.b  #$0B, Obj_Map_Id(A0)                             ; $0022
                rts
Offset_0x012FAE:
                move.b  #$46, Obj_Col_Flags(A0)                          ; $0028
                move.b  Obj_Subtype(A0), Obj_Ani_Number(A0)       ; $002C, $0020
                tst.w   (Two_Player_Flag).w                          ; $FFFFFFD8
                beq.s   Offset_0x012FC6
                move.b  #$09, Obj_Ani_Number(A0)                         ; $0020
;-------------------------------------------------------------------------------                
Offset_0x012FC6:
                move.b  Obj_Control_Var_0C(A0), D0                       ; $003C
                beq.s   Offset_0x012FEE
                bsr     ObjectFall                             ; Offset_0x0110FE
                tst.w   Obj_Speed_Y(A0)                                  ; $001A
                bmi.s   Offset_0x012FEE
                jsr     (ObjHitFloor)                          ; Offset_0x009D84
                tst.w   D1
                bpl     Offset_0x012FEE
                add.w   D1, Obj_Y(A0)                                    ; $0014
                clr.w   Obj_Speed_Y(A0)                                  ; $001A
                clr.b   Obj_Control_Var_0C(A0)                           ; $003C
Offset_0x012FEE:
                move.w  #$0019, D1
                move.w  #$0010, D2
                move.w  D2, D3
                addq.w  #$01, D3
                move.w  Obj_X(A0), D4                                    ; $0010
                lea     (Obj_Player_One).w, A1                       ; $FFFFB000
                moveq   #$03, D6
                movem.l D1-D4, -(A7)
                bsr     Offset_0x01302E
                movem.l (A7)+, D1-D4
                lea     (Obj_Player_Two).w, A1                       ; $FFFFB04A
                moveq   #$04, D6
                bsr     Offset_0x013040
                jsr     (Add_To_Collision_Response_List)       ; Offset_0x00A540
;-------------------------------------------------------------------------------                
Offset_0x013020:                
                lea     (Monitors_Animate_Data), A1            ; Offset_0x01343A
                bsr     AnimateSprite                          ; Offset_0x01115E
;-------------------------------------------------------------------------------                
Offset_0x01302A:                
                bra     MarkObjGone                            ; Offset_0x011AF2
Offset_0x01302E:
                btst    D6, Obj_Status(A0)                               ; $002A
                bne.s   Offset_0x01305A
                cmpi.b  #$02, Obj_Ani_Number(A1)                         ; $0020
                bne     Solid_Object_Monitors                  ; Offset_0x013890
                rts
Offset_0x013040:
                btst    D6, Obj_Status(A0)                               ; $002A
                bne.s   Offset_0x01305A
                tst.w   (Two_Player_Flag).w                          ; $FFFFFFD8
                beq     Solid_Object_Monitors                  ; Offset_0x013890
                cmpi.b  #$02, Obj_Ani_Number(A1)                         ; $0020
                bne     Solid_Object_Monitors                  ; Offset_0x013890
                rts
Offset_0x01305A:
                move.w  D1, D2
                add.w   D2, D2
                btst    #$01, Obj_Status(A1)                             ; $002A
                bne.s   Offset_0x013076
                move.w  Obj_X(A1), D0                                    ; $0010
                sub.w   Obj_X(A0), D0                                    ; $0010
                add.w   D1, D0
                bmi.s   Offset_0x013076
                cmp.w   D2, D0
                bcs.s   Offset_0x01308A
Offset_0x013076:
                bclr    #$03, Obj_Status(A1)                             ; $002A
                bset    #$01, Obj_Status(A1)                             ; $002A
                bclr    D6, Obj_Status(A0)                               ; $002A
                moveq   #$00, D4
                rts
Offset_0x01308A:
                move.w  D4, D2
                bsr     Player_On_Platform                     ; Offset_0x013A56
                moveq   #$00, D4
                rts    
;-------------------------------------------------------------------------------
Offset_0x013094:
                move.b  Obj_Status(A0), D0                               ; $002A
                andi.b  #$78, D0
                beq.s   Offset_0x0130C4
                move.b  D0, D1
                andi.b  #$28, D1
                beq.s   Offset_0x0130B2
                andi.b  #$D7, (Obj_Player_One+Obj_Status).w          ; $FFFFB02A
                ori.b   #$02, (Obj_Player_One+Obj_Status).w          ; $FFFFB02A
Offset_0x0130B2:
                andi.b  #$50, D0
                beq.s   Offset_0x0130C4
                andi.b  #$D7, (Obj_Player_Two+Obj_Status).w          ; $FFFFB074
                ori.b   #$02, (Obj_Player_Two+Obj_Status).w          ; $FFFFB074
Offset_0x0130C4:
                clr.b   Obj_Status(A0)                                   ; $002A
                addq.b  #$02, Obj_Routine(A0)                            ; $0005
                move.b  #$00, Obj_Col_Flags(A0)                          ; $0028
                bsr     SingleObjectLoad                       ; Offset_0x011DD8
                bne.s   Offset_0x0130F6
                move.l  #Monitors_Contents, (A1)               ; Offset_0x013124
                move.w  Obj_X(A0), Obj_X(A1)                      ; $0010, $0010
                move.w  Obj_Y(A0), Obj_Y(A1)                      ; $0014, $0014
                move.b  Obj_Ani_Number(A0), Obj_Ani_Number(A1)    ; $0020, $0020
                move.w  Obj_Player_Last(A0), Obj_Player_Last(A1)  ; $0042, $0042
Offset_0x0130F6:
                bsr     SingleObjectLoad                       ; Offset_0x011DD8
                bne.s   Offset_0x013112
                move.l  #Object_Hit, (A1) ; Toque dos objetos (Explosão) ; Offset_0x013D7C
                addq.b  #$02, Obj_Routine(A1)                            ; $0005
                move.w  Obj_X(A0), Obj_X(A1)                      ; $0010, $0010
                move.w  Obj_Y(A0), Obj_Y(A1)                      ; $0014, $0014
Offset_0x013112:
                move.w  Obj_Respaw_Ref(A0), A2                           ; $0048
                bset    #$00, (A2)
                move.b  #$0A, Obj_Ani_Number(A0)                         ; $0020
                bra     DisplaySprite                          ; Offset_0x011148
;------------------------------------------------------------------------------- 
; Sub-objeto dos monitores 
Monitors_Contents:                                             ; Offset_0x013124
                moveq   #$00, D0
                move.b  Obj_Routine(A0), D0                              ; $0005
                move.w  Offset_0x013132(PC, D0), D1
                jmp     Offset_0x013132(PC, D1)                 
;-------------------------------------------------------------------------------
Offset_0x013132:
                dc.w    Offset_0x013138-Offset_0x013132
                dc.w    Offset_0x0131AA-Offset_0x013132
                dc.w    Monitor_Delete_Object-Offset_0x013132  ; Offset_0x01342E
;-------------------------------------------------------------------------------
Offset_0x013138:
                addq.b  #$02, Obj_Routine(A0)                            ; $0005
                move.w  #$84C4, Obj_Art_VRAM(A0)                         ; $000A
                move.b  #$24, Obj_Flags(A0)                              ; $0004
                move.w  #$0180, Obj_Priority(A0)                         ; $0008
                move.b  #$08, Obj_Width(A0)                              ; $0007
                move.w  #$FD00, Obj_Speed_Y(A0)                          ; $001A
                moveq   #$00, D0
                move.b  Obj_Ani_Number(A0), D0                           ; $0020
                tst.w   (Two_Player_Flag).w                          ; $FFFFFFD8
                beq.s   Offset_0x013192
                move.w  (Level_Frame_Count).w, D0                    ; $FFFFFE04
                andi.w  #$0007, D0
                addq.w  #$01, D0
                tst.w   (Two_Player_Items_Mode).w                    ; $FFFFFF0C
                beq.s   Offset_0x013178
                moveq   #$08, D0
Offset_0x013178:
                cmpi.w  #$0008, D0
                bne.s   Offset_0x01318E
                move.b  (HUD_Timer_Refresh_Flag).w, D1               ; $FFFFFE1E
                add.b   (HUD_Timer_Refresh_Flag_P2).w, D1            ; $FFFFFECA
                cmpi.b  #$02, D1
                beq.s   Offset_0x01318E
                moveq   #$07, D0
Offset_0x01318E:
                move.b  D0, Obj_Ani_Number(A0)                           ; $0020
Offset_0x013192:
                addq.b  #$01, D0
                move.b  D0, Obj_Map_Id(A0)                               ; $0022
                move.l  #Monitors_Mappings, A1                 ; Offset_0x0134A2
                add.b   D0, D0
                adda.w  $00(A1, D0), A1
                addq.w  #$02, A1
                move.l  A1, Obj_Map(A0)                                  ; $000C
;-------------------------------------------------------------------------------                
Offset_0x0131AA:
                bsr.s   Offset_0x0131B0
                bra     DisplaySprite                          ; Offset_0x011148
Offset_0x0131B0:
                tst.w   Obj_Speed_Y(A0)                                  ; $001A
                bpl     Offset_0x0131C4
                bsr     SpeedToPos                             ; Offset_0x01111E
                addi.w  #$0018, Obj_Speed_Y(A0)                          ; $001A
                rts
Offset_0x0131C4:
                addq.b  #$02, Obj_Routine(A0)                            ; $0005
                move.w  #$001D, Obj_Ani_Time(A0)                         ; $0024
                move.w  Obj_Player_Last(A0), A1                          ; $0042
                lea     (Monitors_Broken).w, A2                      ; $FFFFFEF4
                cmpa.w  #Obj_Player_One, A1                              ; $B000
                beq.s   Offset_0x0131E0
                lea     (Monitors_Broken_P2).w, A2                   ; $FFFFFEF6
Offset_0x0131E0:
                moveq   #$00, D0
                move.b  Obj_Ani_Number(A0), D0                           ; $0020
                add.w   D0, D0
                move.w  Offset_0x0131F0(PC, D0), D0
                jmp     Offset_0x0131F0(PC, D0)       
;-------------------------------------------------------------------------------
Offset_0x0131F0:
                dc.w    Monitor_Static-Offset_0x0131F0         ; Offset_0x013204
                dc.w    Monitor_Sonic_Life-Offset_0x0131F0     ; Offset_0x01320A
                dc.w    Monitor_Robotnik-Offset_0x0131F0       ; Offset_0x013204
                dc.w    Monitor_Rings-Offset_0x0131F0          ; Offset_0x01321E
                dc.w    Monitor_Shoes-Offset_0x0131F0          ; Offset_0x013292
                dc.w    Monitor_Fire_Shield-Offset_0x0131F0    ; Offset_0x0132DC
                dc.w    Monitor_Lightning_Shield-Offset_0x0131F0 ; Offset_0x013314
                dc.w    Monitor_Water_Shield-Offset_0x0131F0   ; Offset_0x01334C
                dc.w    Monitor_Invincibility-Offset_0x0131F0  ; Offset_0x013384
                dc.w    Monitor_Super_Sonic-Offset_0x0131F0    ; Offset_0x0133D0
;-------------------------------------------------------------------------------  
Monitor_Static:                                                ; Offset_0x013204
Monitor_Robotnik:
S2_Monitor_Miles_Life: ; Referência inválida - Sonic 2 Left over
                addq.w  #$01, (A2)
                bra     Hurt_Player_A1                         ; Offset_0x01A71C    
;-------------------------------------------------------------------------------
Monitor_Sonic_Life:                                            ; Offset_0x01320A
                addq.w  #$01, (Monitors_Broken).w                    ; $FFFFFEF4
                addq.b  #$01, (Life_Count).w                         ; $FFFFFE12
                addq.b  #$01, (HUD_Life_Refresh_Flag).w              ; $FFFFFE1C
                moveq   #Extra_Life_Snd, D0                                ; $2A
                jmp     (Play_Music)                           ; Offset_0x001176  
;-------------------------------------------------------------------------------  
Monitor_Rings:                                                 ; Offset_0x01321E
                addq.w  #$01, (A2)
                lea     (Ring_Count_Address).w, A2                   ; $FFFFFE20
                lea     (HUD_Rings_Refresh_Flag).w, A3               ; $FFFFFE1D
                lea     (Ring_Status_Flag).w, A4                     ; $FFFFFE1B
                lea     (Total_Ring_Count_Address).w, A5             ; $FFFFFEF0
                cmpa.w  #Obj_Player_One, A1                              ; $B000
                beq.s   Offset_0x013246
                lea     (Ring_Count_Address_P2).w, A2                ; $FFFFFED0
                lea     (HUD_Rings_Refresh_Flag_P2).w, A3            ; $FFFFFEC9
                lea     (Ring_Status_Flag_P2).w, A4                  ; $FFFFFEC7
                lea     (Total_Ring_Count_Address_P2).w, A5          ; $FFFFFEF2
Offset_0x013246:
                addi.w  #$000A, (A5)
                cmpi.w  #$03E7, (A5)
                bcs.s   Offset_0x013254
                move.w  #$03E7, (A5)
Offset_0x013254:
                addi.w  #$000A, (A2)
                cmpi.w  #$03E7, (A2)
                bcs.s   Offset_0x013262
                move.w  #$03E7, (A2)
Offset_0x013262:
                ori.b   #$01, (A3)
                cmpi.w  #$0064, (A2)
                bcs.s   Offset_0x01327E
                bset    #$01, (A4)
                beq.s   Monitor_Add_Life_To_P1_Or_P2           ; Offset_0x013286
                cmpi.w  #$00C8, (A2)
                bcs.s   Offset_0x01327E
                bset    #$02, (A4)
                beq.s   Monitor_Add_Life_To_P1_Or_P2           ; Offset_0x013286
Offset_0x01327E:
                moveq   #Ring_Sfx, D0                                      ; $32
                jmp     (Play_Music)                           ; Offset_0x001176
Monitor_Add_Life_To_P1_Or_P2:                                  ; Offset_0x013286
                cmpa.w  #Obj_Player_One, A1                              ; $B000
                beq     Monitor_Sonic_Life                     ; Offset_0x01320A
                bra     S2_Monitor_Miles_Life                  ; Offset_0x013204   
;------------------------------------------------------------------------------- 
Monitor_Shoes:                                                 ; Offset_0x013292
                addq.w  #$01, (A2)
                bset    #Speed_Type, Obj_Player_Status(A1)          ; $02, $002F
                move.b  #$96, Obj_P_Spd_Shoes_Time(A1)                   ; $0036
                cmpa.w  #Obj_Player_One, A1                              ; $B000
                bne.s   Offset_0x0132C2
                cmpi.w  #$0002, (Player_Selected_Flag).w             ; $FFFFFF08
                beq.s   Offset_0x0132C2
                move.w  #$0C00, (Sonic_Max_Speed).w                  ; $FFFFF760
                move.w  #$0018, (Sonic_Acceleration).w               ; $FFFFF762
                move.w  #$0080, (Sonic_Deceleration).w               ; $FFFFF764
                bra.s   Offset_0x0132D4
Offset_0x0132C2:
                move.w  #$0C00, (Miles_Max_Speed).w                  ; $FFFFFEC0
                move.w  #$0018, (Miles_Acceleration).w               ; $FFFFFEC2
                move.w  #$0080, (Miles_Deceleration).w               ; $FFFFFEC4
Offset_0x0132D4:
                moveq   #Invincibility_Snd, D0                             ; $2C
                jmp     (Play_Music)                           ; Offset_0x001176    
;-------------------------------------------------------------------------------
Monitor_Fire_Shield:                                           ; Offset_0x0132DC
                addq.w  #$01, (A2)
                bset    #Classic_Type, Obj_Player_Status(A1)        ; $00, $002F
                bset    #Fire_Type, Obj_Player_Status(A1)           ; $04, $002F
                moveq   #Got_Fire_Shield_Sfx, D0                           ; $3E
                jsr     (Play_Music)                           ; Offset_0x001176
                tst.b   Obj_Player_One_Or_Two_2(A0)                      ; $0043
                bne.s   Offset_0x013306
                move.l  #Obj_Fire_Shield, (Obj_P1_Shield).w ; Offset_0x0103C6, $FFFFCCE8
                move.w  A1, (Obj_P1_Shield+Obj_Player_Last).w        ; $FFFFCD2A
                rts
Offset_0x013306:
                move.l  #Obj_Fire_Shield, (Obj_P2_Shield).w ; Offset_0x0103C6, $FFFFCD32
                move.w  A1, (Obj_P2_Shield+Obj_Player_Last).w        ; $FFFFCD74
                rts                 
;-------------------------------------------------------------------------------
Monitor_Lightning_Shield:                                      ; Offset_0x013314
                addq.w  #$01, (A2)
                bset    #Classic_Type, Obj_Player_Status(A1)        ; $00, $002F
                bset    #Lightning_Type, Obj_Player_Status(A1)      ; $05, $002F
                moveq   #Got_Lightning_Shield_Sfx, D0                      ; $41
                jsr     (Play_Music)                           ; Offset_0x001176
                tst.b   Obj_Player_One_Or_Two_2(A0)                      ; $0043
                bne.s   Offset_0x01333E
                move.l  #Obj_Lightning_Shield, (Obj_P1_Shield).w ; Offset_0x01046C, $FFFFCCE8
                move.w  A1, (Obj_P1_Shield+Obj_Player_Last).w        ; $FFFFCD2A
                rts
Offset_0x01333E:
                move.l  #Obj_Lightning_Shield, (Obj_P2_Shield).w ; Offset_0x01046C, $FFFFCD32
                move.w  A1, (Obj_P2_Shield+Obj_Player_Last).w        ; $FFFFCD74
                rts 
;-------------------------------------------------------------------------------
Monitor_Water_Shield:                                          ; Offset_0x01334C
                addq.w  #$01, (A2)
                bset    #Classic_Type, Obj_Player_Status(A1)        ; $00, $002F
                bset    #Water_Type, Obj_Player_Status(A1)          ; $06, $002F
                moveq   #Got_Water_Shield_Sfx, D0                          ; $3F
                jsr     (Play_Music)                           ; Offset_0x001176
                tst.b   Obj_Player_One_Or_Two_2(A0)                      ; $0043
                bne.s   Offset_0x013376
                move.l  #Obj_Water_Shield, (Obj_P1_Shield).w ; Offset_0x010512, $FFFFCCE8
                move.w  A1, (Obj_P1_Shield+Obj_Player_Last).w        ; $FFFFCD2A
                rts
Offset_0x013376:
                move.l  #Obj_Water_Shield, (Obj_P2_Shield).w ; Offset_0x010512, $FFFFCD32
                move.w  A1, (Obj_P2_Shield+Obj_Player_Last).w        ; $FFFFCD74
                rts     
;-------------------------------------------------------------------------------
Monitor_Invincibility:                                         ; Offset_0x013384
                addq.w  #$01, (A2)
                tst.b   (Super_Sonic_Flag).w                         ; $FFFFFE19
                bne.s   Offset_0x0133CE
                bset    #Invincibility_Type, Obj_Player_Status(A1)  ; $01, $002F
                move.b  #$96, Obj_P_Invcbility_Time(A1)                  ; $0035
                tst.b   (Boss_Flag).w                                ; $FFFFF7AA
                bne.s   Offset_0x0133AE
                cmpi.b  #$0C, Obj_Subtype(A1)                            ; $002C
                bls.s   Offset_0x0133AE
                moveq   #Invincibility_Snd, D0                             ; $2C
                jsr     (Play_Music)                           ; Offset_0x001176
Offset_0x0133AE:
                tst.b   Obj_Player_One_Or_Two_2(A0)                      ; $0043
                bne.s   Offset_0x0133C2
                move.l  #Obj_Invincibility, (Obj_P1_Invincibility).w ; Offset_0x00F9FA, $FFFFCD7C
                move.w  A1, (Obj_P1_Invincibility+Obj_Player_Last).w ; $FFFFCDBE
                rts
Offset_0x0133C2:
                move.l  #Obj_Invincibility, (Obj_P2_Invincibility).w ; Offset_0x00F9FA, $FFFFCEA4
                move.w  A1, (Obj_P2_Invincibility+Obj_Player_Last).w ; $FFFFCEE6
Offset_0x0133CE:
                rts        
;-------------------------------------------------------------------------------   
Monitor_Super_Sonic:                                           ; Offset_0x0133D0
                addq.w  #$01, (A2)
                addi.w  #$0032, (Ring_Count_Address).w               ; $FFFFFE20
                move.b  #$01, (Super_Sonic_Palette_Status).w         ; $FFFFF65F
                move.b  #$0F, (Super_Sonic_Palette_Timer).w          ; $FFFFF65E
                move.b  #$01, (Super_Sonic_Flag).w                   ; $FFFFFE19
                move.b  #$81, (Obj_Player_One+Obj_Timer).w           ; $FFFFB02E
                move.b  #$1F, (Obj_Player_One+Obj_Ani_Number).w      ; $FFFFB020
                move.l  #Obj_Super_Sonic_Stars, (Obj_Super_Sonic_Stars_RAM).w ; Offset_0x0102AA, $FFFFCBC0
                move.w  #$0A00, (Sonic_Max_Speed).w                  ; $FFFFF760
                move.w  #$0030, (Sonic_Acceleration).w               ; $FFFFF762
                move.w  #$0100, (Sonic_Deceleration).w               ; $FFFFF764
                move.b  #$00, (Obj_Player_One+Obj_P_Invcbility_Time).w ; $FFFFB035
                bset    #Invincibility_Type, Obj_Player_Status(A1)  ; $01, $002F
                moveq   #Hyper_Form_Change_Sfx, D0                         ; $46
                jsr     (Play_Music)                           ; Offset_0x001176
                moveq   #Invincibility_Snd, D0                             ; $2C
                jmp     (Play_Music)                           ; Offset_0x001176    
;-------------------------------------------------------------------------------
; Offset_0x01342C:
                rts
;-------------------------------------------------------------------------------                
Monitor_Delete_Object:                                         ; Offset_0x01342E
                subq.w  #$01, Obj_Ani_Time(A0)                           ; $0024
                bmi     DeleteObject                           ; Offset_0x011138
                bra     DisplaySprite                          ; Offset_0x011148   
;-------------------------------------------------------------------------------                  
Monitors_Animate_Data:                                         ; Offset_0x01343A
                dc.w    Offset_0x013450-Monitors_Animate_Data
                dc.w    Offset_0x013454-Monitors_Animate_Data
                dc.w    Offset_0x01345C-Monitors_Animate_Data
                dc.w    Offset_0x013464-Monitors_Animate_Data
                dc.w    Offset_0x01346C-Monitors_Animate_Data
                dc.w    Offset_0x013474-Monitors_Animate_Data
                dc.w    Offset_0x01347C-Monitors_Animate_Data
                dc.w    Offset_0x013484-Monitors_Animate_Data
                dc.w    Offset_0x01348C-Monitors_Animate_Data
                dc.w    Offset_0x013494-Monitors_Animate_Data
                dc.w    Offset_0x01349C-Monitors_Animate_Data
Offset_0x013450:
                dc.b    $01, $00, $01, $FF
Offset_0x013454:
                dc.b    $01, $00, $02, $02, $01, $02, $02, $FF
Offset_0x01345C:
                dc.b    $01, $00, $03, $03, $01, $03, $03, $FF
Offset_0x013464:
                dc.b    $01, $00, $04, $04, $01, $04, $04, $FF
Offset_0x01346C:
                dc.b    $01, $00, $05, $05, $01, $05, $05, $FF
Offset_0x013474:
                dc.b    $01, $00, $06, $06, $01, $06, $06, $FF
Offset_0x01347C:
                dc.b    $01, $00, $07, $07, $01, $07, $07, $FF
Offset_0x013484:
                dc.b    $01, $00, $08, $08, $01, $08, $08, $FF
Offset_0x01348C:
                dc.b    $01, $00, $09, $09, $01, $09, $09, $FF
Offset_0x013494:
                dc.b    $01, $00, $0A, $0A, $01, $0A, $0A, $FF
Offset_0x01349C:
                dc.b    $02, $00, $01, $0B, $FE, $01      
;-------------------------------------------------------------------------------  
Monitors_Mappings:                                             ; Offset_0x0134A2
                dc.w    Offset_0x0134BA-Monitors_Mappings
                dc.w    Offset_0x0134C2-Monitors_Mappings
                dc.w    Offset_0x0134D0-Monitors_Mappings
                dc.w    Offset_0x0134DE-Monitors_Mappings
                dc.w    Offset_0x0134EC-Monitors_Mappings
                dc.w    Offset_0x0134FA-Monitors_Mappings
                dc.w    Offset_0x013508-Monitors_Mappings
                dc.w    Offset_0x013516-Monitors_Mappings
                dc.w    Offset_0x013524-Monitors_Mappings
                dc.w    Offset_0x013532-Monitors_Mappings
                dc.w    Offset_0x013540-Monitors_Mappings
                dc.w    Offset_0x01354E-Monitors_Mappings
Offset_0x0134BA:
                dc.w    $0001
                dc.w    $F00F, $0000, $FFF0
Offset_0x0134C2:
                dc.w    $0002
                dc.w    $F305, $0018, $FFF8
                dc.w    $F00F, $0000, $FFF0
Offset_0x0134D0:
                dc.w    $0002
                dc.w    $F305, $0310, $FFF8
                dc.w    $F00F, $0000, $FFF0
Offset_0x0134DE:
                dc.w    $0002
                dc.w    $F305, $001C, $FFF8
                dc.w    $F00F, $0000, $FFF0
Offset_0x0134EC:
                dc.w    $0002
                dc.w    $F305, $2020, $FFF8
                dc.w    $F00F, $0000, $FFF0
Offset_0x0134FA:
                dc.w    $0002
                dc.w    $F305, $0024, $FFF8
                dc.w    $F00F, $0000, $FFF0
Offset_0x013508:
                dc.w    $0002
                dc.w    $F305, $0030, $FFF8
                dc.w    $F00F, $0000, $FFF0
Offset_0x013516:
                dc.w    $0002
                dc.w    $F305, $002C, $FFF8
                dc.w    $F00F, $0000, $FFF0
Offset_0x013524:
                dc.w    $0002
                dc.w    $F305, $0034, $FFF8
                dc.w    $F00F, $0000, $FFF0
Offset_0x013532:
                dc.w    $0002
                dc.w    $F305, $0028, $FFF8
                dc.w    $F00F, $0000, $FFF0
Offset_0x013540:
                dc.w    $0002
                dc.w    $F305, $0038, $FFF8
                dc.w    $F00F, $0000, $FFF0
Offset_0x01354E:
                dc.w    $0001
                dc.w    $FF0D, $0010, $FFF0                                                                                                                         
;===============================================================================
; Objeto 0x01 - Monitores
; <<<-
;===============================================================================  