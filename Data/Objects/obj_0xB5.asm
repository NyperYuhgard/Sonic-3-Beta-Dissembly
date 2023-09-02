;===============================================================================
; Objeto 0xB5 - Chefe na Hydrocity
; ->>>          
;===============================================================================
; Offset_0x038B14:
                lea     Offset_0x038B70(PC), A1
                jsr     (Check_Camera_In_Range)                ; Offset_0x043392
                move.l  #Offset_0x038B78, (A0)
                move.b  #$01, (Boss_Flag).w                          ; $FFFFF7AA
                moveq   #Volume_Down, D0                                  ; -$20
                jsr     (Play_Music)                           ; Offset_0x001176
                move.w  #$0078, Obj_Timer(A0)                            ; $002E
                move.b  #$19, Obj_Angle(A0)                              ; $0026
                move.w  (Level_Limits_Max_Y).w, (Target_Camera_Max_Y).w ; $FFFFEE12, $FFFFFA98
                move.w  #$0738, (Level_Limits_Max_Y).w               ; $FFFFEE12
                move.w  #$4100, Obj_Inertia(A0)                          ; $001C
                move.w  #$4150, (Sonic_Level_Limits_Max_X).w         ; $FFFFEE16
                move.l  #Offset_0x038B7E, Obj_Child(A0)                  ; $0034
                moveq   #$6C, D0
                jsr     (LoadPLC)                              ; Offset_0x0014D0
                lea     Pal_Hz_Boss(PC), A1                    ; Offset_0x039900
                jmp     (Pal_Load_Line_1)                      ; Offset_0x04314C    
;-------------------------------------------------------------------------------
Offset_0x038B70:
                dc.b    $07, $00, $08, $00, $3F, $A0, $41, $D0   
;-------------------------------------------------------------------------------
Offset_0x038B78:
                jmp     (Update_Sonic_Level_Limits_X_Y_Play_Music) ; Offset_0x0433DE   
;-------------------------------------------------------------------------------
Offset_0x038B7E:
                move.l  #Offset_0x038B86, (A0)
Offset_0x038B84:                
                rts      
;-------------------------------------------------------------------------------     
Offset_0x038B86:
                moveq   #$00, D0
                move.b  Obj_Routine(A0), D0                              ; $0005
                move.w  Offset_0x038B9E(PC, D0), D1
                jsr     Offset_0x038B9E(PC, D1)
                bsr     Offset_0x039620
                jmp     (Add_To_Response_List_And_Display)     ; Offset_0x042450     
;-------------------------------------------------------------------------------
Offset_0x038B9E:
                dc.w    Offset_0x038BA8-Offset_0x038B9E
                dc.w    Offset_0x038BEA-Offset_0x038B9E
                dc.w    Offset_0x038C1A-Offset_0x038B9E
                dc.w    Offset_0x038C1A-Offset_0x038B9E
                dc.w    Offset_0x038C70-Offset_0x038B9E    
;-------------------------------------------------------------------------------
Offset_0x038BA8:
                lea     Screw_Mobile_Setup_Data(PC), A1        ; Offset_0x039722
                jsr     (Object_Settings)                      ; Offset_0x041D72
                move.b  #$08, Obj_Boss_Hit(A0)                           ; $0029
                move.w  #$0080, Obj_Speed_Y(A0)                          ; $001A
                move.w  #$00AF, Obj_Timer(A0)                            ; $002E
                move.l  #Offset_0x038BF6, Obj_Child(A0)                  ; $0034
                lea     (Offset_0x0397E2), A2
                jsr     (Load_Child_Object_A2)                 ; Offset_0x041D9A
                bne.s   Offset_0x038BE0
                move.b  #$05, Obj_Subtype(A1)                            ; $002C
Offset_0x038BE0:
                lea     Offset_0x039780(PC), A2
                jmp     (Load_Child_Object_A2)                 ; Offset_0x041D9A  
;-------------------------------------------------------------------------------
Offset_0x038BEA:
                jsr     (SpeedToPos)                           ; Offset_0x01111E
                jmp     (Run_Object_Wait_Timer_A0)             ; Offset_0x0423D2  
;-------------------------------------------------------------------------------
Offset_0x038BF6:
                move.b  #$04, Obj_Routine(A0)                            ; $0005
                move.w  #$FF00, Obj_Height_3(A0)                         ; $0044
                move.w  #$009F, Obj_Child_Data(A0)                       ; $0030
                move.w  #$003F, Obj_Timer(A0)                            ; $002E
                move.l  #Offset_0x038C2C, Obj_Child(A0)                  ; $0034
                jmp     Swing_Setup(PC)                        ; Offset_0x03669A   
;-------------------------------------------------------------------------------
Offset_0x038C1A:
                jsr     (Swing_Up_And_Down)                    ; Offset_0x04232E
                jsr     (SpeedToPos)                           ; Offset_0x01111E
                jmp     (Run_Object_Wait_Timer_A0)             ; Offset_0x0423D2  
;-------------------------------------------------------------------------------
Offset_0x038C2C:
                move.b  #$06, Obj_Routine(A0)                            ; $0005
                bset    #$03, Obj_Control_Var_08(A0)                     ; $0038
                move.w  #$01FF, Obj_Timer(A0)                            ; $002E
                move.l  #Offset_0x038C48, Obj_Child(A0)                  ; $0034
                rts                          
;-------------------------------------------------------------------------------
Offset_0x038C48:
                move.b  #$08, Obj_Routine(A0)                            ; $0005
                bclr    #$03, Obj_Control_Var_08(A0)                     ; $0038
                move.w  Obj_Height_3(A0), Obj_Speed_X(A0)         ; $0044, $0018
                move.w  #$00BF, Obj_Timer(A0)                            ; $002E
                move.l  #Offset_0x038C9A, Obj_Child(A0)                  ; $0034
                move.b  #$08, Obj_Control_Var_09(A0)                     ; $0039
                rts   
;-------------------------------------------------------------------------------
Offset_0x038C70:
                jsr     (Swing_Up_And_Down)                    ; Offset_0x04232E
                jsr     (SpeedToPos)                           ; Offset_0x01111E
                jsr     (Run_Object_Wait_Timer_A0)             ; Offset_0x0423D2
                subq.w  #$01, Obj_Child_Data(A0)                         ; $0030
                bpl.s   Offset_0x038C98
                neg.w   Obj_Speed_X(A0)                                  ; $0018
                bchg    #00, Obj_Flags(A0)                               ; $0004
                move.w  #$013F, Obj_Child_Data(A0)                       ; $0030
Offset_0x038C98:
                rts  
;-------------------------------------------------------------------------------
Offset_0x038C9A:
                move.w  #$005F, Obj_Timer(A0)                            ; $002E
                subq.b  #$01, Obj_Control_Var_09(A0)                     ; $0039
                bmi.s   Offset_0x038CAE
                bset    #$01, Obj_Control_Var_08(A0)                     ; $0038
                rts
Offset_0x038CAE:
                move.w  Obj_Speed_X(A0), Obj_Height_3(A0)         ; $0018, $0044
                clr.w   Obj_Speed_X(A0)                                  ; $0018
                bra     Offset_0x038C2C    
;-------------------------------------------------------------------------------
Offset_0x038CBC:
                move.l  #Offset_0x038CE6, (A0)
                bset    #$04, Obj_Control_Var_08(A0)                     ; $0038
                move.w  #$007F, Obj_Timer(A0)                            ; $002E
                move.l  #Offset_0x038D02, Obj_Child(A0)                  ; $0034
                moveq   #Volume_Down, D0                                  ; -$20
                jsr     (Play_Music)                           ; Offset_0x001176
                moveq   #$0C, D0
                jmp     (Set_Indexed_Velocity)                 ; Offset_0x042D5A   
;------------------------------------------------------------------------------- 
Offset_0x038CE6:
                jsr     (ObjectFall)                           ; Offset_0x0110FE
                jsr     (Run_Object_Wait_Timer_A0)             ; Offset_0x0423D2
                btst    #$00, (Vertical_Interrupt_Count+$03).w       ; $FFFFFE0F
                beq     Offset_0x038B84
                jmp     (DisplaySprite)                        ; Offset_0x011148   
;-------------------------------------------------------------------------------    
Offset_0x038D02:
                move.l  #Offset_0x038D28, (A0)
                st      (Player_Control_Lock_Flag).w                 ; $FFFFFAA8
                clr.b   (Boss_Flag).w                                ; $FFFFF7AA
                jsr     (Level_Load_Music)                     ; Offset_0x0432CA
                move.w  #$4330, (Target_Camera_Max_X).w              ; $FFFFFA92
                lea     (Level_Resize_Max_X), A2               ; Offset_0x04261C
                jmp     (Load_Child_Object_Simple_A2)          ; Offset_0x041F5A   
;-------------------------------------------------------------------------------
Offset_0x038D28:
                tst.b   (Control_Ports_Buffer_Data+$03).w            ; $FFFFF607
                bne.s   Offset_0x038D3C
                move.w  (Camera_X).w, (Sonic_Level_Limits_Min_X).w ; $FFFFEE78, $FFFFEE14
                tst.b   (Player_Control_Lock_Flag).w                 ; $FFFFFAA8
                bne     Offset_0x038B84
Offset_0x038D3C:
                clr.b   (Player_Control_Lock_Flag).w                 ; $FFFFFAA8
                jsr     (Restore_Player_Control)               ; Offset_0x0432EE
                move.w  #$0000, (Target_Camera_Min_Y).w              ; $FFFFFA96
                lea     (Level_Resize_Min_Y), A2               ; Offset_0x042628
                jsr     (Load_Child_Object_Simple_A2)          ; Offset_0x041F5A
                jmp     (Go_Delete_Object_A0_2)                ; Offset_0x042D4C  
;-------------------------------------------------------------------------------
Offset_0x038D5E:
                moveq   #$00, D0
                move.b  Obj_Routine(A0), D0                              ; $0005
                move.w  Offset_0x038D7A(PC, D0), D1
                jsr     Offset_0x038D7A(PC, D1)
                jsr     (Refresh_Child_Position)               ; Offset_0x042016
                moveq   #$00, D0
                jmp     (Child_Display_Touch_Or_Flicker_Move_2) ; Offset_0x042538   
;-------------------------------------------------------------------------------
Offset_0x038D7A:
                dc.w    Offset_0x038D84-Offset_0x038D7A
                dc.w    Offset_0x038D8E-Offset_0x038D7A
                dc.w    Offset_0x038DBA-Offset_0x038D7A
                dc.w    Offset_0x038DD8-Offset_0x038D7A
                dc.w    Offset_0x038E04-Offset_0x038D7A   
;-------------------------------------------------------------------------------
Offset_0x038D84:
                lea     Offset_0x039734(PC), A1
                jmp     (Object_Settings_3)                    ; Offset_0x041D7A  
;-------------------------------------------------------------------------------
Offset_0x038D8E:
                move.w  Obj_Child_Ref(A0), A1                            ; $0046
                btst    #$03, Obj_Control_Var_08(A1)                     ; $0038
                bne.s   Offset_0x038D9C
                rts
Offset_0x038D9C:
                move.b  #$04, Obj_Routine(A0)                            ; $0005
                move.b  #$A6, Obj_Col_Flags(A0)                          ; $0028
                move.l  #Offset_0x0397EA, Obj_Child_Data(A0)             ; $0030
                move.l  #Offset_0x038DC0, Obj_Child(A0)                  ; $0034
                rts      
;-------------------------------------------------------------------------------
Offset_0x038DBA:
                jmp     (Animate_Raw_Get_Faster)               ; Offset_0x042248
;-------------------------------------------------------------------------------
Offset_0x038DC0:
                move.b  #$06, Obj_Routine(A0)                            ; $0005
                move.l  #Offset_0x0397F1, Obj_Child_Data(A0)             ; $0030
                lea     Offset_0x0397B0(PC), A2
                jmp     (Load_Child_Object_A2)                 ; Offset_0x041D9A  
;-------------------------------------------------------------------------------
Offset_0x038DD8:
                jsr     (Animate_Raw)                          ; Offset_0x04208E
                move.w  Obj_Child_Ref(A0), A1                            ; $0046
                btst    #$03, Obj_Control_Var_08(A1)                     ; $0038
                beq.s   Offset_0x038DEC
                rts
Offset_0x038DEC:
                move.b  #$08, Obj_Routine(A0)                            ; $0005
                move.l  #Offset_0x0397F7, Obj_Child_Data(A0)             ; $0030
                move.l  #Offset_0x038E0A, Obj_Child(A0)                  ; $0034
                rts    
;-------------------------------------------------------------------------------
Offset_0x038E04:
                jmp     (Animate_Raw_Get_Slower)               ; Offset_0x0422C8     
;-------------------------------------------------------------------------------       
Offset_0x038E0A:
                move.b  #$02, Obj_Routine(A0)                            ; $0005
                clr.b   Obj_Col_Flags(A0)                                ; $0028
                rts
;-------------------------------------------------------------------------------
Offset_0x038E16:
                move.w  Obj_X(A0), -(A7)                                 ; $0010
                moveq   #$00, D0
                move.b  Obj_Routine(A0), D0                              ; $0005
                move.w  Offset_0x038E46(PC, D0), D1
                jsr     Offset_0x038E46(PC, D1)
                move.w  #$001F, D1
                move.w  #$000C, D2
                move.w  #$000C, D3
                move.w  (A7)+, D4
                jsr     (Platform_Object)                      ; Offset_0x013AF6
                bsr     Offset_0x0396B2
                jmp     (DisplaySprite)                        ; Offset_0x011148 
;-------------------------------------------------------------------------------   
Offset_0x038E46:
                dc.w    Offset_0x038E52-Offset_0x038E46
                dc.w    Offset_0x038E9A-Offset_0x038E46
                dc.w    Offset_0x038EC6-Offset_0x038E46
                dc.w    Offset_0x038EDE-Offset_0x038E46
                dc.w    Offset_0x038EC6-Offset_0x038E46
                dc.w    Offset_0x038F3C-Offset_0x038E46   
;-------------------------------------------------------------------------------
Offset_0x038E52:
                lea     Offset_0x039740(PC), A1
                jsr     (Object_Settings_2)                    ; Offset_0x041D76
                move.w  (Water_Level_Move).w, D0                     ; $FFFFF646
                subq.w  #$08, D0
                move.w  D0, Obj_Y(A0)                                    ; $0014
                move.w  D0, Obj_Control_Var_0A(A0)                       ; $003A
                move.l  #Offset_0x039802, Obj_Child_Data(A0)             ; $0030
                move.l  #Offset_0x038EA0, Obj_Child(A0)                  ; $0034
                lea     Offset_0x0397C0(PC), A2
                jsr     (Load_Child_Object_A2)                 ; Offset_0x041D9A
                lea     Offset_0x0397DC(PC), A2
                jsr     (Load_Child_Object_Simple_A2)          ; Offset_0x041F5A
                move.w  Obj_Child_Ref(A0), A1                            ; $0046
                move.w  Obj_Child_Ref(A1), Obj_Height_3(A0)       ; $0046, $0044
                rts      
;-------------------------------------------------------------------------------
Offset_0x038E9A:
                jmp     (Animate_Raw)                          ; Offset_0x04208E  
;-------------------------------------------------------------------------------  
Offset_0x038EA0:
                move.b  #$04, Obj_Routine(A0)                            ; $0005
                move.l  #Offset_0x03980B, Obj_Child_Data(A0)             ; $0030
                move.w  #$FF00, Obj_Speed_Y(A0)                          ; $001A
                move.l  #Offset_0x038ED6, Obj_Child(A0)                  ; $0034
                lea     Offset_0x0397B8(PC), A2
                jmp     (Load_Child_Object_A2)                 ; Offset_0x041D9A   
;-------------------------------------------------------------------------------  
Offset_0x038EC6:
                jsr     (SpeedToPos)                           ; Offset_0x01111E
                jsr     (Animate_Raw)                          ; Offset_0x04208E
                bra     Offset_0x0396FA
;-------------------------------------------------------------------------------  
Offset_0x038ED6:
                move.b  #$06, Obj_Routine(A0)                            ; $0005
                rts    
;-------------------------------------------------------------------------------  
Offset_0x038EDE:
                jsr     (Animate_Raw)                          ; Offset_0x04208E
                move.w  Obj_Height_3(A0), A1                             ; $0044
                btst    #$03, Obj_Control_Var_08(A1)                     ; $0038
                beq.s   Offset_0x038EF2
                rts
Offset_0x038EF2:
                move.b  #$08, Obj_Routine(A0)                            ; $0005
                bset    #$03, Obj_Control_Var_08(A0)                     ; $0038
                move.w  #$0080, Obj_Speed_Y(A0)                          ; $001A
                move.l  #Offset_0x038F22, Obj_Child(A0)                  ; $0034
                move.w  #$0080, Obj_Speed_X(A0)                          ; $0018
                tst.w   Obj_Speed_X(A1)                                  ; $0018
                bpl.s   Offset_0x038F1C
                neg.w   Obj_Speed_X(A0)                                  ; $0018
Offset_0x038F1C:
                rts  
;------------------------------------------------------------------------------- 
; Offset_0x038F1E:
                bra     Offset_0x0396FA   
;------------------------------------------------------------------------------- 
Offset_0x038F22:
                move.l  #Offset_0x038F3C, (A0)
                move.w  #$000F, Obj_Timer(A0)                            ; $002E
                clr.w   Obj_Speed_X(A0)                                  ; $0018
                move.l  #Offset_0x038F64, Obj_Child(A0)                  ; $0034
                rts 
;------------------------------------------------------------------------------- 
Offset_0x038F3C:
                move.w  #$001F, D1
                move.w  #$000C, D2
                move.w  #$000C, D3
                move.w  Obj_X(A0), D4                                    ; $0010
                jsr     (Platform_Object)                      ; Offset_0x013AF6
                jsr     (Animate_Raw)                          ; Offset_0x04208E
                jsr     (Run_Object_Wait_Timer_A0)             ; Offset_0x0423D2
                jmp     (DisplaySprite)                        ; Offset_0x011148  
;-------------------------------------------------------------------------------    
Offset_0x038F64:
                jsr     (Displace_Player_Offset)               ; Offset_0x04315A
                jmp     (Go_Delete_Object_A0_2)                ; Offset_0x042D4C
;-------------------------------------------------------------------------------
Offset_0x038F70:
                jsr     (SpeedToPos)                           ; Offset_0x01111E
                jsr     (Animate_Raw)                          ; Offset_0x04208E
                bsr     Offset_0x0396FA
                jmp     (DisplaySprite)                        ; Offset_0x011148  
;-------------------------------------------------------------------------------
Offset_0x038F86:
                moveq   #$00, D0
                move.b  Obj_Routine(A0), D0                              ; $0005
                move.w  Offset_0x038F9E(PC, D0), D1
                jsr     Offset_0x038F9E(PC, D1)
                bsr     Offset_0x0396E0
                jmp     (Child_Display_Or_Delete_2)            ; Offset_0x0424A8  
;-------------------------------------------------------------------------------
Offset_0x038F9E:
                dc.w    Offset_0x038FA4-Offset_0x038F9E
                dc.w    Offset_0x038FB8-Offset_0x038F9E
                dc.w    Offset_0x038FE8-Offset_0x038F9E   
;-------------------------------------------------------------------------------
Offset_0x038FA4:
                lea     Offset_0x039748(PC), A1
                jsr     (Object_Settings_3)                    ; Offset_0x041D7A
                move.l  #Offset_0x03980F, Obj_Child_Data(A0)             ; $0030
                rts   
;-------------------------------------------------------------------------------
Offset_0x038FB8:
                bsr     Offset_0x03944E
                bsr     Offset_0x039418
                bsr     Offset_0x039382
                jsr     (Animate_Raw)                          ; Offset_0x04208E
                move.w  Obj_Child_Ref(A0), A1                            ; $0046
                btst    #$03, Obj_Control_Var_08(A1)                     ; $0038
                bne.s   Offset_0x038FD8
                rts
Offset_0x038FD8:
                move.b  #$04, Obj_Routine(A0)                            ; $0005
                move.w  Obj_Speed_X(A1), Obj_Speed_X(A0)          ; $0018, $0018
                bra     Offset_0x03957A    
;-------------------------------------------------------------------------------
Offset_0x038FE8:
                bsr     Offset_0x039382
                move.w  Obj_Speed_X(A1), Obj_Speed_X(A0)          ; $0018, $0018
                jsr     (SpeedToPos)                           ; Offset_0x01111E
                jmp     (Animate_Raw)                          ; Offset_0x04208E  
;-------------------------------------------------------------------------------
Offset_0x038FFE:
                lea     Offset_0x03974E(PC), A1
                jsr     (Object_Settings_3)                    ; Offset_0x041D7A
                move.l  #Offset_0x039022, (A0)
                move.l  #Offset_0x039828, Obj_Child_Data(A0)             ; $0030
Offset_0x039016:
                move.w  (Water_Level_Move).w, D0                     ; $FFFFF646
                subq.w  #$04, D0
                move.w  D0, Obj_Y(A0)                                    ; $0014
                rts                                            
;-------------------------------------------------------------------------------
Offset_0x039022:
                jsr     (Animate_Raw)                          ; Offset_0x04208E
                moveq   #$00, D0
                move.b  Obj_Subtype(A0), D0                              ; $002C
                move.w  Offset_0x039046(PC, D0), D0
                move.w  Obj_Child_Ref(A0), A1                            ; $0046
                move.w  Obj_X(A1), D1                                    ; $0010
                add.w   D0, D1
                move.w  D1, Obj_X(A0)                                    ; $0010
                jmp     (Child_Display_Or_Delete_2)            ; Offset_0x0424A8  
;-------------------------------------------------------------------------------
Offset_0x039046:
                dc.w    $FFFC, $0004
;-------------------------------------------------------------------------------   
Offset_0x03904A:
                lea     Offset_0x039754(PC), A1
                jsr     (Object_Settings_2)                    ; Offset_0x041D76
                move.l  #Animate_Raw_Multi_Delay_Touch, (A0)   ; Offset_0x042FAA
                move.l  #Offset_0x03982C, Obj_Child_Data(A0)             ; $0030
                move.l  #Go_Delete_Object_A0, Obj_Child(A0) ; Offset_0x042D3E, $0034
                bra.s   Offset_0x039016
;-------------------------------------------------------------------------------
Offset_0x03906C:
                lea     Offset_0x03975C(PC), A1
                jsr     (Object_Settings)                      ; Offset_0x041D72
                move.l  #Run_Object_Wait_Timer_A0, (A0)        ; Offset_0x0423D2
                move.l  #Offset_0x03909A, Obj_Child(A0)                  ; $0034
                bsr     Offset_0x0393D8
                tst.b   Obj_Subtype(A0)                                  ; $002C
                bne     Offset_0x038B84
                lea     Offset_0x0397C0(PC), A2
                jmp     (Load_Child_Object_A2)                 ; Offset_0x041D9A  
;-------------------------------------------------------------------------------
Offset_0x03909A:
                move.l  #Offset_0x0390AA, (A0)
                move.l  #Go_Delete_Object_A0_2, Obj_Child(A0) ; Offset_0x042D4C, $0034
                rts                                                    
;-------------------------------------------------------------------------------    
Offset_0x0390AA:
                bsr     Offset_0x03959C
                jmp     (Animate_Raw_Multi_Delay_Touch)        ; Offset_0x042FAA
;-------------------------------------------------------------------------------  
Offset_0x0390B4:
                lea     Offset_0x039774(PC), A1
                jsr     (Object_Settings)                      ; Offset_0x041D72
                move.l  #Offset_0x039114, (A0)
                jsr     (PseudoRandomNumber)                   ; Offset_0x001AFA
                andi.w  #$00FF, D0
                ext.w   D0
                add.w   D0, Obj_X(A0)                                    ; $0010
                swap.w  D0
                move.w  (Water_Level_Move).w, D1                     ; $FFFFF646
                andi.w  #$001F, D0
                add.w   D0, D1
                move.w  D1, Obj_Y(A0)                                    ; $0014
                andi.w  #$0003, D0
                move.b  D0, Obj_Map_Id(A0)                               ; $0022
                lsl.w   #$02, D0
                move.l  Offset_0x039104(PC, D0), Obj_Child_Data(A0)      ; $0030
                move.w  #$001F, Obj_Timer(A0)                            ; $002E
                move.l  #Offset_0x03912E, Obj_Child(A0)                  ; $0034
                rts    
;-------------------------------------------------------------------------------
Offset_0x039104:
                dc.l    Offset_0x038AE4
                dc.l    Offset_0x038AE8
                dc.l    Offset_0x038AEC
                dc.l    Offset_0x038AF0 
;-------------------------------------------------------------------------------
Offset_0x039114:
                move.w  Obj_Child_Ref(A0), A3                            ; $0046
                bsr     Offset_0x0395F6
                jsr     (Animate_Raw)                          ; Offset_0x04208E
                jsr     (Run_Object_Wait_Timer_A0)             ; Offset_0x0423D2
                jmp     (Child_Display_Or_Delete_2)            ; Offset_0x0424A8    
;-------------------------------------------------------------------------------
Offset_0x03912E:
                move.l  #Offset_0x039140, (A0)
                move.l  Obj_Child_Data(A0), A1                           ; $0030
                move.b  $0001(A1), Obj_Map_Id(A0)                        ; $0022
                rts                   
;-------------------------------------------------------------------------------
Offset_0x039140:
                move.w  Obj_Child_Ref(A0), A3                            ; $0046
                btst    #$03, Obj_Control_Var_08(A3)                     ; $0038
                bne.s   Offset_0x039156
                bsr     Offset_0x0395F6
                jmp     (Child_Display_Or_Delete_2)            ; Offset_0x0424A8
Offset_0x039156:
                move.l  #Offset_0x039114, (A0)
                move.w  #$001F, Obj_Timer(A0)                            ; $002E
                move.l  #Go_Delete_Object_A0, Obj_Child(A0) ; Offset_0x042D3E, $0034
                rts
;------------------------------------------------------------------------------- 
Offset_0x03916C:
                moveq   #$00, D0
                move.b  Obj_Routine(A0), D0                              ; $0005
                move.w  Offset_0x039180(PC, D0), D1
                jsr     Offset_0x039180(PC, D1)
                jmp     (Child_Display_Touch_Or_Delete)        ; Offset_0x042472  
;-------------------------------------------------------------------------------   
Offset_0x039180:
                dc.w    Offset_0x03918E-Offset_0x039180
                dc.w    Offset_0x0391A8-Offset_0x039180
                dc.w    Offset_0x0391EC-Offset_0x039180
                dc.w    Offset_0x039220-Offset_0x039180
                dc.w    Offset_0x03928E-Offset_0x039180
                dc.w    Offset_0x0392B6-Offset_0x039180
                dc.w    Offset_0x0392DC-Offset_0x039180   
;-------------------------------------------------------------------------------   
Offset_0x03918E:
                lea     Offset_0x03973A(PC), A1
                jsr     (Object_Settings_3)                    ; Offset_0x041D7A
                move.b  #$08, Obj_Height_2(A0)                           ; $001E
                bsr     Offset_0x03935C
                jmp     (Refresh_Child_Position_Adjusted)      ; Offset_0x04203C  
;------------------------------------------------------------------------------- 
Offset_0x0391A8:
                jsr     (Refresh_Child_Position_Adjusted)      ; Offset_0x04203C
                move.w  Obj_Child_Ref(A0), A1                            ; $0046
                btst    #$01, Obj_Control_Var_08(A1)                     ; $0038
                bne.s   Offset_0x0391BC
                rts
Offset_0x0391BC:
                move.b  #$04, Obj_Routine(A0)                            ; $0005
                tst.b   Obj_Subtype(A0)                                  ; $002C
                beq.s   Offset_0x0391CA
                rts
Offset_0x0391CA:
                move.b  #$06, Obj_Routine(A0)                            ; $0005
                move.w  #$0003, Obj_Timer(A0)                            ; $002E
                move.l  #Offset_0x039262, Obj_Child(A0)                  ; $0034
                move.b  #$01, Obj_Control_Var_10(A0)                     ; $0040
                move.b  #$00, Obj_Control_Var_11(A0)                     ; $0041
                rts                             
;------------------------------------------------------------------------------- 
Offset_0x0391EC:
                jsr     (Refresh_Child_Position_Adjusted)      ; Offset_0x04203C
                move.w  Obj_Child_Ref(A0), A1                            ; $0046
                btst    #$01, Obj_Control_Var_08(A1)                     ; $0038
                beq.s   Offset_0x039200
                rts     
;------------------------------------------------------------------------------- 
Offset_0x039200:
                move.b  #$06, Obj_Routine(A0)                            ; $0005
                subq.b  #$02, Obj_Subtype(A0)                            ; $002C
                move.w  #$0007, Obj_Timer(A0)                            ; $002E
                move.l  #Offset_0x03923C, Obj_Child(A0)                  ; $0034
                bsr     Offset_0x03935C
                bra     Offset_0x039370
Offset_0x039220:
                move.b  Obj_Control_Var_10(A0), D0                       ; $0040
                add.b   D0, Obj_Control_Var_12(A0)                       ; $0042
                move.b  Obj_Control_Var_11(A0), D0                       ; $0041
                add.b   D0, Obj_Control_Var_13(A0)                       ; $0043
                jsr     (Refresh_Child_Position_Adjusted)      ; Offset_0x04203C
                jmp     (Run_Object_Wait_Timer_A0)             ; Offset_0x0423D2
;-------------------------------------------------------------------------------   
Offset_0x03923C:
                move.b  #$02, Obj_Routine(A0)                            ; $0005
                tst.b   Obj_Subtype(A0)                                  ; $002C
                bne.s   Offset_0x039260
                lea     Offset_0x0397A0(PC), A2
                jsr     (Load_Child_Object_A2_2)               ; Offset_0x041F86
                bne.s   Offset_0x039260
                move.w  Obj_Child_Ref(A0), Obj_Child_Ref(A1)      ; $0046, $0046
                move.b  #$04, Obj_Subtype(A1)                            ; $002C
Offset_0x039260:
                rts 
;-------------------------------------------------------------------------------
Offset_0x039262:
                move.b  #$08, Obj_Routine(A0)                            ; $0005
                move.l  #Offset_0x0392C4, Obj_Child(A0)                  ; $0034
                move.w  #$0100, Obj_Speed_X(A0)                          ; $0018
                move.w  Obj_Child_Ref(A0), A1                            ; $0046
                bclr    #$01, Obj_Control_Var_08(A1)                     ; $0038
                btst    #$00, Obj_Flags(A1)                              ; $0004
                beq.s   Offset_0x03928C
                neg.w   Obj_Speed_X(A0)                                  ; $0018
Offset_0x03928C:
                rts   
;-------------------------------------------------------------------------------
Offset_0x03928E:
                move.w  Obj_Y(A0), D0                                    ; $0014
                cmp.w   (Water_Level_Move).w, D0                     ; $FFFFF646
                bcc.s   Offset_0x0392A6
                jsr     (Move_Light_Gravity)                   ; Offset_0x0426C2
                jsr     (Run_Object_Hit_Floor_A0)              ; Offset_0x0423E0
                rts
Offset_0x0392A6:
                move.b  #$0A, Obj_Routine(A0)                            ; $0005
                lea     Offset_0x0397CE(PC), A2
                jmp     (Load_Child_Object_A2)                 ; Offset_0x041D9A   
;-------------------------------------------------------------------------------
Offset_0x0392B6:
                jsr     (Move_Light_Gravity)                   ; Offset_0x0426C2
                jsr     (Run_Object_Hit_Floor_A0)              ; Offset_0x0423E0
                rts    
;-------------------------------------------------------------------------------
Offset_0x0392C4:
                move.b  #$0C, Obj_Routine(A0)                            ; $0005
                move.l  #Offset_0x0397FD, Obj_Child_Data(A0)             ; $0030
                move.l  #Offset_0x0392E2, Obj_Child(A0)                  ; $0034
                rts
Offset_0x0392DC:
                jmp     (Animate_Raw_Get_Faster)               ; Offset_0x042248    
;-------------------------------------------------------------------------------
Offset_0x0392E2:
                lea     Offset_0x0397D6(PC), A2
                jsr     (Load_Child_Object_Simple_A2)          ; Offset_0x041F5A
                lea     Offset_0x0397A8(PC), A2
                jsr     (Load_Child_Object_A2)                 ; Offset_0x041D9A
                jmp     (Go_Delete_Object_A0)                  ; Offset_0x042D3E    
;-------------------------------------------------------------------------------  
Offset_0x0392FC:
                lea     Offset_0x03972E(PC), A1
                jsr     (Object_Settings_3)                    ; Offset_0x041D7A
                move.l  #Offset_0x03930E, (A0)
                rts                                                      
;-------------------------------------------------------------------------------
Offset_0x03930E:
                jsr     (Refresh_Child_Position_Adjusted)      ; Offset_0x04203C
                moveq   #$00, D0
                jmp     (Child_Display_Or_Flicker_Move_2)      ; Offset_0x04250E 
;-------------------------------------------------------------------------------
Jawz_Explosion:                                                ; Offset_0x03931C    
                lea     Jawz_Explosion_Setup_Data(PC), A1      ; Offset_0x039768
                jsr     (Object_Settings)                      ; Offset_0x041D72
                move.l  #Offset_0x039342, (A0)
                move.l  #Offset_0x0398F8, Obj_Child_Data(A0)             ; $0030
                move.l  #Go_Delete_Object_A0, Obj_Child(A0) ; Offset_0x042D3E, $0034
                jmp     (Add_To_Response_List_And_Display)     ; Offset_0x042450
;-------------------------------------------------------------------------------  
Offset_0x039342:
                jsr     (Animate_Raw)                          ; Offset_0x04208E
                cmpi.b  #$03, Obj_Map_Id(A0)                             ; $0022
                bcc.s   Offset_0x039356
                jsr     (Add_To_Collision_Response_List)       ; Offset_0x00A540
Offset_0x039356:
                jmp     (DisplaySprite)                        ; Offset_0x011148     
;-------------------------------------------------------------------------------
Offset_0x03935C:
                moveq   #$00, D0
                move.b  Obj_Subtype(A0), D0                              ; $002C
                move.w  Offset_0x03936A(PC, D0), Obj_Priority(A0)        ; $0008
                rts                                             
;-------------------------------------------------------------------------------
Offset_0x03936A:
                dc.w    $0200, $0180, $0100            
;-------------------------------------------------------------------------------
Offset_0x039370:
                moveq   #$00, D0
                move.b  Obj_Subtype(A0), D0                              ; $002C
                move.w  Offset_0x03937E(PC, D0), Obj_Control_Var_10(A0)  ; $0040
                rts                                                
;-------------------------------------------------------------------------------
Offset_0x03937E:
                dc.w    $0101, $0100   
;------------------------------------------------------------------------------- 
Offset_0x039382:
                move.w  Obj_Child_Ref(A0), A1                            ; $0046
                moveq   #$00, D0
                move.b  Obj_Control_Var_09(A1), D0                       ; $0039
                cmp.b   Obj_Control_Var_09(A0), D0                       ; $0039
                beq.s   Offset_0x0393B2
                move.b  D0, Obj_Control_Var_09(A0)                       ; $0039
                move.b  (Offset_0x0393B4+$01)(PC, D0), D1
                ext.w   D1
                move.w  (Water_Level_Move).w, D2                     ; $FFFFF646
                add.w   D1, D2
                move.w  D2, Obj_Y(A0)                                    ; $0014
                lsl.w   #$02, D0
                move.l  (Offset_0x0393BC+$04)(PC, D0), Obj_Child_Data(A0); $0030
                clr.b   Obj_Ani_Time(A0)                                 ; $0024
Offset_0x0393B2:
                rts 
;-------------------------------------------------------------------------------
Offset_0x0393B4:
                dc.b    $F8, $F8, $F0, $E8, $E0, $D8, $D8, $00  
;-------------------------------------------------------------------------------
Offset_0x0393BC:
                dc.l    Offset_0x03980F
                dc.l    Offset_0x03980F
                dc.l    Offset_0x039814
                dc.l    Offset_0x039819
                dc.l    Offset_0x03981E
                dc.l    Offset_0x039823
                dc.l    Offset_0x039823  
;-------------------------------------------------------------------------------
Offset_0x0393D8:
                moveq   #$00, D0
                move.b  Obj_Subtype(A0), D0                              ; $002C
                move.w  D0, Obj_Timer(A0)                                ; $002E
                move.w  Offset_0x0393FA(PC, D0), D1
                move.w  (Water_Level_Move).w, D2                     ; $FFFFF646
                add.w   D1, D2
                move.w  D2, Obj_Y(A0)                                    ; $0014
                add.w   D0, D0
                move.l  Offset_0x039404(PC, D0), Obj_Child_Data(A0)      ; $0030
                rts                                      
;-------------------------------------------------------------------------------
Offset_0x0393FA:
                dc.w    $FFF8, $FFE8, $FFD8, $FFC8, $FFB8   
;------------------------------------------------------------------------------- 
Offset_0x039404:
                dc.l    Offset_0x039835
                dc.l    Offset_0x03986C
                dc.l    Offset_0x03989B
                dc.l    Offset_0x0398C2
                dc.l    Offset_0x0398E1
;-------------------------------------------------------------------------------  
Offset_0x039418:
                move.w  Obj_X(A0), D0                                    ; $0010
                move.w  (Water_Level_Move).w, D1                     ; $FFFFF646
                addq.w  #$08, D1
                move.l  #$00020000, D2
                lea     (Obj_Player_One).w, A1                       ; $FFFFB000
                bsr     Offset_0x039434
                lea     (Obj_Player_Two).w, A1                       ; $FFFFB04A
Offset_0x039434:
                tst.b   Obj_Timer(A1)                                    ; $002E
                bne.s   Offset_0x03944C
                cmp.w   Obj_Y(A1), D1                                    ; $0014
                bcc.s   Offset_0x03944C
                cmp.w   Obj_X(A1), D0                                    ; $0010
                bcc.s   Offset_0x039448
                neg.l   D2
Offset_0x039448:
                add.l   D2, Obj_X(A1)                                    ; $0010
Offset_0x03944C:
                rts
;-------------------------------------------------------------------------------      
Offset_0x03944E:
                move.w  Obj_Child_Ref(A0), A1                            ; $0046
                moveq   #$00, D0
                move.b  Obj_Control_Var_09(A1), D0                       ; $0039
                lsl.w   #$02, D0
                lea     Offset_0x039518(PC), A1
                lea     $00(A1, D0), A1
                moveq   #$42, D4
                lea     (Obj_Player_One).w, A2                       ; $FFFFB000
                bsr     Offset_0x039472
                moveq   #$43, D4
                lea     (Obj_Player_Two).w, A2                       ; $FFFFB04A
Offset_0x039472:
                cmpi.b  #$04, Obj_Routine(A2)                            ; $0005
                beq     Offset_0x039508
                tst.b   Obj_Timer(A2)                                    ; $002E
                beq.s   Offset_0x039488
                tst.b   $00(A0, D4)
                bne.s   Offset_0x0394C2
Offset_0x039488:
                move.w  Obj_Y(A0), D0                                    ; $0014
                move.w  Obj_Y(A2), D2                                    ; $0014
                add.w   (A1), D0
                cmp.w   D0, D2
                bcs     Offset_0x039556
                add.w   $0002(A1), D0
                cmp.w   D0, D2
                bcc     Offset_0x039556
                move.w  Obj_X(A0), D0                                    ; $0010
                move.w  Obj_X(A2), D2                                    ; $0010
                sub.w   D2, D0
                addi.w  #$0010, D0
                cmpi.w  #$0020, D0
                bcc     Offset_0x039556
                tst.b   Obj_Timer(A2)                                    ; $002E
                bne.s   Offset_0x0394C2
                bsr     Offset_0x039530
Offset_0x0394C2:
                move.w  Obj_Y(A0), D0                                    ; $0014
                move.w  Obj_Y(A2), D2                                    ; $0014
                add.w   (A1)+, D0
                cmp.w   D0, D2
                bcs     Offset_0x039558
                move.w  Obj_X(A2), D0                                    ; $0010
                move.w  Obj_Speed_X(A2), D1                              ; $0018
                move.w  #$0080, D2
                sub.w   Obj_X(A0), D0                                    ; $0010
                cmpi.w  #$FFEE, D0
                ble.s   Offset_0x039558
                cmpi.w  #$0012, D0
                bge.s   Offset_0x039558
                tst.w   D0
                bmi.s   Offset_0x0394F4
                neg.w   D2
Offset_0x0394F4:
                add.w   D2, D1
                move.w  D1, Obj_Speed_X(A2)                              ; $0018
                ext.l   D1
                lsl.l   #$08, D1
                add.l   D1, Obj_X(A2)                                    ; $0010
                subq.w  #$02, Obj_Y(A2)                                  ; $0014
                rts
Offset_0x039508:
                jsr     (Displace_Player_Offset)               ; Offset_0x04315A
                clr.b   $00(A0, D4)
                clr.b   Obj_Timer(A2)                                    ; $002E
                rts
;-------------------------------------------------------------------------------
Offset_0x039518:
                dc.w    $FFE8, $0048, $FFE0, $0058, $FFD8, $0068, $FFD0, $0078
                dc.w    $FFC8, $0088, $FFB8, $0088          
;-------------------------------------------------------------------------------
Offset_0x039530:
                st      $00(A0, D4)
                bset    #$01, Obj_Status(A2)                             ; $002A
                move.b  #$01, Obj_Timer(A2)                              ; $002E
                move.b  #$18, Obj_Ani_Number(A2)                         ; $0020
                clr.b   Obj_Control_Var_0D(A2)                           ; $003D
                clr.w   Obj_Speed_X(A2)                                  ; $0018
                clr.w   Obj_Speed_Y(A2)                                  ; $001A
                clr.w   Obj_Inertia(A2)                                  ; $001C
Offset_0x039556:
                rts
Offset_0x039558:
                clr.b   $00(A0, D4)
                bset    #$01, Obj_Status(A2)                             ; $002A
                clr.b   Obj_Timer(A2)                                    ; $002E
                move.b  #$00, Obj_Routine(A2)                            ; $0005
                move.b  #$02, Obj_Ani_Number(A2)                         ; $0020
                move.w  #$FE00, Obj_Speed_Y(A2)                          ; $001A
                rts
;-------------------------------------------------------------------------------   
Offset_0x03957A:
                tst.b   Obj_Control_Var_12(A0)                           ; $0042
                beq.s   Offset_0x03958A
                clr.b   Obj_Control_Var_12(A0)                           ; $0042
                lea     (Obj_Player_One).w, A2                       ; $FFFFB000
                bsr.s   Offset_0x039558
Offset_0x03958A:
                tst.b   Obj_Control_Var_13(A0)                           ; $0043
                beq.s   Offset_0x03959A
                clr.b   Obj_Control_Var_13(A0)                           ; $0043
                lea     (Obj_Player_Two).w, A2                       ; $FFFFB04A
                bsr.s   Offset_0x039558
Offset_0x03959A:
                rts
;-------------------------------------------------------------------------------
Offset_0x03959C:
                cmpi.b  #$30, Obj_Ani_Frame(A0)                          ; $0023
                bcc.s   Offset_0x0395EC
                lea     Offset_0x0395EE(PC), A1
                lea     (Obj_Player_One).w, A2                       ; $FFFFB000
                bsr     Offset_0x0395B8
                lea     Offset_0x0395EE(PC), A1
                lea     (Obj_Player_Two).w, A2                       ; $FFFFB04A
Offset_0x0395B8:
                tst.b   Obj_Timer(A2)                                    ; $002E
                bne.s   Offset_0x0395EC
                move.w  Obj_X(A0), D0                                    ; $0010
                move.w  Obj_X(A2), D1                                    ; $0010
                add.w   (A1)+, D0
                cmp.w   D0, D1
                bcs.s   Offset_0x0395EC
                add.w   (A1)+, D0
                cmp.w   D0, D1
                bcc.s   Offset_0x0395EC
                move.w  Obj_Y(A0), D0                                    ; $0014
                move.w  Obj_Y(A2), D1                                    ; $0014
                add.w   (A1)+, D0
                cmp.w   D0, D1
                bcs.s   Offset_0x0395EC
                add.w   (A1)+, D0
                cmp.w   D0, D1
                bcc.s   Offset_0x0395EC
                move.w  #$F800, Obj_Speed_Y(A2)                          ; $001A
Offset_0x0395EC:
                rts   
;-------------------------------------------------------------------------------  
Offset_0x0395EE:
                dc.w    $FFF4, $0018, $FFC8, $0040         
;------------------------------------------------------------------------------- 
Offset_0x0395F6:
                move.w  Obj_Child_Ref(A0), A1                            ; $0046
                move.w  Obj_X(A0), D0                                    ; $0010
                move.w  Obj_Speed_X(A0), D1                              ; $0018
                move.w  #$0080, D2
                sub.w   Obj_X(A1), D0                                    ; $0010
                tst.w   D0
                bmi.s   Offset_0x039610
                neg.w   D2
Offset_0x039610:
                add.w   D2, D1
                move.w  D1, Obj_Speed_X(A0)                              ; $0018
                ext.l   D1
                lsl.l   #$08, D1
                add.l   D1, Obj_X(A0)                                    ; $0010
                rts       
;-------------------------------------------------------------------------------
Offset_0x039620:
                tst.l   (A0)
                beq.s   Offset_0x039676
                tst.b   Obj_Col_Flags(A0)                                ; $0028
                bne.s   Offset_0x039676
                tst.b   Obj_Boss_Hit(A0)                                 ; $0029
                beq.s   Offset_0x039678
                tst.b   Obj_Ani_Number(A0)                               ; $0020
                bne.s   Offset_0x039644
                move.b  #$20, Obj_Ani_Number(A0)                         ; $0020
                moveq   #Boss_Hit_Sfx, D0                                  ; $7C
                jsr     (Play_Music)                           ; Offset_0x001176
Offset_0x039644:
                bset    #$06, Obj_Status(A0)                             ; $002A
                moveq   #$00, D0
                btst    #$00, Obj_Ani_Number(A0)                         ; $0020
                bne.s   Offset_0x039656
                addq.w  #$06, D0
Offset_0x039656:
                lea     Offset_0x0396A0(PC), A1
                lea     Offset_0x0396A6(PC, D0), A2
                jsr     (Move_0x06_Bytes_A2_A1)                ; Offset_0x043260
                subq.b  #$01, Obj_Ani_Number(A0)                         ; $0020
                bne.s   Offset_0x039676
                bclr    #$06, Obj_Status(A0)                             ; $002A
                move.b  Obj_Ani_Time_2(A0), Obj_Col_Flags(A0)     ; $0025, $0028
Offset_0x039676:
                rts
Offset_0x039678:
                move.l  #Display_Sprite_Wait, (A0)             ; Offset_0x042F8E
                clr.b   (HUD_Timer_Refresh_Flag).w                   ; $FFFFFE1E
                bset    #$07, Obj_Status(A0)                             ; $002A
                clr.b   Obj_Col_Flags(A0)                                ; $0028
                clr.b   Obj_Boss_Hit(A0)                                 ; $0029
                move.w  #$003F, Obj_Timer(A0)                            ; $002E
                move.l  #Offset_0x038CBC, Obj_Child(A0)                  ; $0034
                rts            
;-------------------------------------------------------------------------------
Offset_0x0396A0:
                dc.w    (Palette_Row_1_Offset+$14)                       ; $ED34
                dc.w    (Palette_Row_1_Offset+$16)                       ; $ED36
                dc.w    (Palette_Row_1_Offset+$1C)                       ; $ED3C  
;-------------------------------------------------------------------------------
Offset_0x0396A6:
                dc.w    $0006, $0020, $0624, $0EEE, $0EEE, $0EEE
;-------------------------------------------------------------------------------
Offset_0x0396B2:
                move.w  Obj_Height_3(A0), A1                             ; $0044
                btst    #$07, Obj_Status(A1)                             ; $002A
                beq.s   Offset_0x0396DE
                bset    #$07, Obj_Status(A0)                             ; $002A
                move.l  #Offset_0x038F70, (A0)
                move.w  #$0100, Obj_Speed_Y(A0)                          ; $001A
                move.l  #Go_Delete_Object_A0_2, Obj_Child(A0) ; Offset_0x042D4C, $0034
                jsr     (Displace_Player_Offset)               ; Offset_0x04315A
Offset_0x0396DE:
                rts 
;-------------------------------------------------------------------------------  
Offset_0x0396E0:
                move.w  Obj_Child_Ref(A0), A1                            ; $0046
                btst    #$07, Obj_Status(A1)                             ; $002A
                beq.s   Offset_0x0396F8
                bset    #$07, Obj_Status(A0)                             ; $002A
                move.b  #$04, Obj_Routine(A0)                            ; $0005
Offset_0x0396F8:
                rts
;-------------------------------------------------------------------------------   
Offset_0x0396FA:
                move.w  Obj_Control_Var_0A(A0), D0                       ; $003A
                sub.w   Obj_Y(A0), D0                                    ; $0014
                bcs.s   Offset_0x03971C
                andi.w  #$00F0, D0
                lsr.w   #$04, D0
                move.b  D0, Obj_Control_Var_09(A0)                       ; $0039
                tst.w   Obj_Speed_Y(A0)                                  ; $001A
                bpl.s   Offset_0x03971A
                cmpi.b  #$05, D0
                bcc.s   Offset_0x03971C
Offset_0x03971A:
                rts
Offset_0x03971C:
                move.l  Obj_Child(A0), A2                                ; $0034
                jmp     (A2)
;-------------------------------------------------------------------------------
Screw_Mobile_Setup_Data:                                       ; Offset_0x039722
                dc.l    Screw_Mobile_Mappings                  ; Offset_0x11044C
                dc.w    $A36B, $0100
                dc.b    $2C, $1C, $00, $21  
;-------------------------------------------------------------------------------   
Offset_0x03972E:
                dc.w    $0200
                dc.b    $0C, $04, $01, $00 
;-------------------------------------------------------------------------------  
Offset_0x039734: 
                dc.w    $0200
                dc.b    $1C, $04, $02, $00                                                          
;-------------------------------------------------------------------------------  
Offset_0x03973A:  
                dc.w    $0200
                dc.b    $1C, $04, $06, $00
;------------------------------------------------------------------------------- 
Offset_0x039740:
                dc.w    $836B, $0080
                dc.b    $14, $0C, $17, $00                    
;-------------------------------------------------------------------------------     
Offset_0x039748: 
                dc.w    $0080
                dc.b    $14, $30, $0D, $00     
;-------------------------------------------------------------------------------  
Offset_0x03974E: 
                dc.w    $0000
                dc.b    $10, $04, $1A, $00
;------------------------------------------------------------------------------- 
Offset_0x039754:  
                dc.w    $836B, $0080
                dc.b    $0C, $08, $18, $00  
;-------------------------------------------------------------------------------
Offset_0x03975C: 
                dc.l    Screw_Mobile_Mappings                  ; Offset_0x11044C
                dc.w    $836B, $0100
                dc.b    $0C, $10, $08, $00      
;-------------------------------------------------------------------------------
Jawz_Explosion_Setup_Data:                                     ; Offset_0x039768
                dc.l    Object_Hit_Mappings                    ; Offset_0x013EF2
                dc.w    $85A0, $0080
                dc.b    $0C, $0C, $00, $8B                                                                           
;-------------------------------------------------------------------------------
Offset_0x039774: 
                dc.l    Sonic_Underwater_Mappings              ; Offset_0x025872
                dc.w    $845C, $0280
                dc.b    $10, $10, $00, $00
;------------------------------------------------------------------------------- 
Offset_0x039780:
                dc.w    $0004
                dc.l    Offset_0x03916C
                dc.b    $23, $12
                dc.l    Offset_0x03916C
                dc.b    $1B, $0A
                dc.l    Offset_0x03916C
                dc.b    $13, $0A
                dc.l    Offset_0x0392FC
                dc.b    $00, $1C
                dc.l    Offset_0x038D5E
                dc.b    $00, $24 
;-------------------------------------------------------------------------------   
Offset_0x0397A0:  
                dc.w    $0000
                dc.l    Offset_0x03916C
                dc.b    $13, $0A
;-------------------------------------------------------------------------------
Offset_0x0397A8:
                dc.w    $0000
                dc.l    Jawz_Explosion                         ; Offset_0x03931C
                dc.w    $0000                
;-------------------------------------------------------------------------------   
Offset_0x0397B0:    
                dc.w    $0000
                dc.l    Offset_0x038E16
                dc.b    $00, $00        
;-------------------------------------------------------------------------------
Offset_0x0397B8:  
                dc.w    $0000
                dc.l    Offset_0x038F86
                dc.b    $00, $00
;-------------------------------------------------------------------------------
Offset_0x0397C0:    
                dc.w    $0001
                dc.l    Offset_0x038FFE
                dc.b    $FC, $00
                dc.l    Offset_0x038FFE
                dc.b    $04, $00
;-------------------------------------------------------------------------------  
Offset_0x0397CE:  
                dc.w    $0000
                dc.l    Offset_0x03904A
                dc.b    $00, $00
;-------------------------------------------------------------------------------  
Offset_0x0397D6:    
                dc.w    $0004
                dc.l    Offset_0x03906C    
;-------------------------------------------------------------------------------  
Offset_0x0397DC:
                dc.w    $0013
                dc.l    Offset_0x0390B4
;-------------------------------------------------------------------------------  
Offset_0x0397E2: 
                dc.w    $0000
                dc.l    Hz_Robotnik_Ship                       ; Offset_0x0362B8
                dc.b    $00, $0C   
;-------------------------------------------------------------------------------    
Offset_0x0397EA:   
                dc.b    $07, $08, $02, $03, $04, $05, $FC                                
;------------------------------------------------------------------------------- 
Offset_0x0397F1:   
                dc.b    $00, $02, $03, $04, $05, $FC                                          
;------------------------------------------------------------------------------- 
Offset_0x0397F7:   
                dc.b    $07, $02, $03, $04, $05, $FC
;-------------------------------------------------------------------------------   
Offset_0x0397FD:  
                dc.b    $05, $08, $06, $07, $FC
;-------------------------------------------------------------------------------  
Offset_0x039802:   
                dc.b    $03, $17, $17, $22, $16, $21, $15, $20
                dc.b    $F4
;-------------------------------------------------------------------------------  
Offset_0x03980B:    
                dc.b    $03, $15, $20, $FC       
;------------------------------------------------------------------------------- 
Offset_0x03980F:                
                dc.b    $03, $0D, $0F, $11, $FC      
;------------------------------------------------------------------------------- 
Offset_0x039814:       
                dc.b    $03, $24, $25, $26, $FC      
;------------------------------------------------------------------------------- 
Offset_0x039819:       
                dc.b    $03, $27, $28, $29, $FC      
;------------------------------------------------------------------------------- 
Offset_0x03981E:       
                dc.b    $03, $2A, $2B, $2C, $FC      
;------------------------------------------------------------------------------- 
Offset_0x039823:       
                dc.b    $03, $2D, $2E, $2F, $FC     
;-------------------------------------------------------------------------------  
Offset_0x039828:  
                dc.b    $01, $1A, $23, $FC
;-------------------------------------------------------------------------------  
Offset_0x03982C:    
                dc.b    $18, $02, $18, $02, $30, $03, $19, $04
                dc.b    $F4
;-------------------------------------------------------------------------------  
Offset_0x039835:  
                dc.b    $08, $00, $08, $00, $1B, $00, $09, $00
                dc.b    $1C, $00, $0A, $00, $1D, $00, $0A, $00
                dc.b    $1D, $00, $0A, $00, $1D, $00, $0A, $00
                dc.b    $1D, $00, $0A, $00, $1D, $00, $0A, $00
                dc.b    $1D, $00, $0A, $00, $1D, $00, $0A, $00
                dc.b    $1D, $00, $0A, $00, $1D, $00, $0B, $02
                dc.b    $1E, $02, $0C, $03, $1F, $03, $F4   
;-------------------------------------------------------------------------------  
Offset_0x03986C:     
                dc.b    $08, $00, $08, $00, $1B, $00, $09, $00
                dc.b    $1C, $00, $0A, $00, $1D, $00, $0A, $00
                dc.b    $1D, $00, $0A, $00, $1D, $00, $0A, $00
                dc.b    $1D, $00, $0A, $00, $1D, $00, $0A, $00
                dc.b    $1D, $00, $0A, $00, $1D, $00, $0B, $02
                dc.b    $1E, $02, $0C, $03, $1F, $03, $F4
;-------------------------------------------------------------------------------  
Offset_0x03989B:    
                dc.b    $08, $00, $08, $00, $1B, $00, $09, $00
                dc.b    $1C, $00, $0A, $00, $1D, $00, $0A, $00
                dc.b    $1D, $00, $0A, $00, $1D, $00, $0A, $00
                dc.b    $1D, $00, $0A, $00, $1D, $00, $0B, $02
                dc.b    $1E, $02, $0C, $03, $1F, $03, $F4
;-------------------------------------------------------------------------------  
Offset_0x0398C2:  
                dc.b    $08, $00, $08, $00, $1B, $00, $09, $00
                dc.b    $1C, $00, $0A, $00, $1D, $00, $0A, $00
                dc.b    $1D, $00, $0A, $00, $1D, $00, $0B, $02
                dc.b    $1E, $02, $0C, $03, $1F, $03, $F4
;-------------------------------------------------------------------------------         
Offset_0x0398E1:  
                dc.b    $08, $00, $08, $00, $1B, $00, $09, $00
                dc.b    $1C, $00, $0A, $00, $1D, $00, $0B, $02
                dc.b    $1E, $02, $0C, $03, $1F, $03, $F4 
;-------------------------------------------------------------------------------   
Offset_0x0398F8:
                dc.b    $07, $00, $00, $01, $02, $03, $04, $F4    
;-------------------------------------------------------------------------------  
Pal_Hz_Boss:                                                   ; Offset_0x039900
                dc.w    $0000, $0EEE, $0000, $0000, $0000, $00EE, $0088, $0000
                dc.w    $008E, $004E, $0006, $0020, $0E84, $0A24, $0624, $0044
;===============================================================================
; Objeto 0xB5 - Chefe na Hydrocity
; <<<- 
;===============================================================================  