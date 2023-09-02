;===============================================================================
; Objeto 0xC7 - Knuckles nas cenas de introdução
; ->>>          
;===============================================================================
; Offset_0x034BAA:
                move.w  A0, (Obj_Knuckles_Mem_Address).w             ; $FFFFFAA4
                moveq   #$00, D0
                move.b  Obj_Subtype(A0), D0                              ; $002C
                move.l  Offset_0x034BBC(PC, D0), A1
                move.l  A1, (A0)
                jmp     (A1)     
;-------------------------------------------------------------------------------
Offset_0x034BBC:
                dc.l    Knuckles_In_Angel_Island_2             ; Offset_0x034BD4
                dc.l    Knuckles_In_Hydrocity_2                ; Offset_0x034C32
                dc.l    Knuckles_In_Carnival_Night_2_Lamp      ; Offset_0x034D76
                dc.l    Knuckles_In_Carnival_Night_2_Boss      ; Offset_0x034EA0
                dc.l    Knuckles_In_Launch_Base_1              ; Offset_0x03508E
                dc.l    Knuckles_In_Launch_Base_2              ; Offset_0x0352D0   
;------------------------------------------------------------------------------- 
Knuckles_In_Angel_Island_2:                                    ; Offset_0x034BD4
                moveq   #$00, D0
                move.b  Obj_Routine(A0), D0                              ; $0005
                move.w  Offset_0x034BF6(PC, D0), D1
                jsr     Offset_0x034BF6(PC, D1)
                bsr     Offset_0x035538
                lea     Knuckles_PLC_Data(PC), A2              ; Offset_0x0355A4
                jsr     (Load_Dynamic_PLC_A2)                  ; Offset_0x042A0A
                jmp     (DisplaySprite)                        ; Offset_0x011148   
;-------------------------------------------------------------------------------
Offset_0x034BF6:
                dc.w    Offset_0x034BFA-Offset_0x034BF6
                dc.w    Offset_0x034C26-Offset_0x034BF6   
;-------------------------------------------------------------------------------
Offset_0x034BFA:
                lea     Knuckles_Setup_Data(PC), A1            ; Offset_0x035548
                jsr     (Object_Settings_Slotted)              ; Offset_0x04298C
                move.b  #$08, Obj_Map_Id(A0)                             ; $0022
                move.w  #$1400, Obj_X(A0)                                ; $0010
                move.w  #$0430, Obj_Y(A0)                                ; $0014
                moveq   #Volume_Down, D0                                  ; -$20
                jsr     (Play_Music)                           ; Offset_0x001176
                move.w  #$0077, Obj_Height_3(A0)                         ; $0044
                rts
Offset_0x034C26:
                rts
;-------------------------------------------------------------------------------  
; Offset_0x034C28:
                lea     Knuckles_Palette(PC), A1               ; Offset_0x0355EE
                jmp     (Pal_Load_Line_1)                      ; Offset_0x04314C
;-------------------------------------------------------------------------------
Knuckles_In_Hydrocity_2:                                       ; Offset_0x034C32
                moveq   #$00, D0
                move.b  Obj_Routine(A0), D0                              ; $0005
                move.w  Offset_0x034C50(PC, D0), D1
                jsr     Offset_0x034C50(PC, D1)
                lea     Knuckles_PLC_Data(PC), A2              ; Offset_0x0355A4
                jsr     (Load_Dynamic_PLC_A2)                  ; Offset_0x042A0A
                jmp     (Check_Delete_Touch_Slotted)           ; Offset_0x042C1E  
;-------------------------------------------------------------------------------
Offset_0x034C50:
                dc.w    Offset_0x034C5C-Offset_0x034C50
                dc.w    Offset_0x034C98-Offset_0x034C50
                dc.w    Offset_0x034CAE-Offset_0x034C50
                dc.w    Offset_0x034CFA-Offset_0x034C50
                dc.w    Offset_0x034D36-Offset_0x034C50
                dc.w    Offset_0x034D70-Offset_0x034C50   
;-------------------------------------------------------------------------------
Offset_0x034C5C:
                lea     Knuckles_Setup_Data(PC), A1            ; Offset_0x035548
                jsr     (Object_Settings_Slotted)              ; Offset_0x04298C
                move.w  #$4B8E, Obj_X(A0)                                ; $0010
                move.w  #$017D, Obj_Y(A0)                                ; $0014
                bset    #$00, Obj_Flags(A0)                              ; $0004
                moveq   #Volume_Down, D0                                  ; -$20
                jsr     (Play_Music)                           ; Offset_0x001176
                move.w  #$0077, Obj_Timer(A0)                            ; $002E
                move.l  #Offset_0x034C9E, Obj_Child(A0)                  ; $0034
                lea     Knuckles_Palette(PC), A1               ; Offset_0x0355EE
                jmp     (Pal_Load_Line_1)                      ; Offset_0x04314C    
;-------------------------------------------------------------------------------
Offset_0x034C98:
                jmp     (Run_Object_Wait_Timer_A0)             ; Offset_0x0423D2   
;-------------------------------------------------------------------------------
Offset_0x034C9E:
                move.b  #$04, Obj_Routine(A0)                            ; $0005
                moveq   #Knuckles_Theme_Snd, D0                            ; $1F
                jsr     (Play_Music)                           ; Offset_0x001176
                rts        
;-------------------------------------------------------------------------------
Offset_0x034CAE:
                move.w  Obj_X(A0), D0                                    ; $0010
                subq.w  #$02, D0
                cmpi.w  #$4B3C, D0
                bcs.s   Offset_0x034CC8
                move.w  D0, Obj_X(A0)                                    ; $0010
                lea     Offset_0x0355B1(PC), A1
                jmp     (Animate_Raw_A1)                       ; Offset_0x042092
Offset_0x034CC8:
                move.b  #$06, Obj_Routine(A0)                            ; $0005
                bclr    #$00, Obj_Flags(A0)                              ; $0004
                move.w  #$005F, Obj_Timer(A0)                            ; $002E
                move.l  #Offset_0x034D06, Obj_Child(A0)                  ; $0034
Offset_0x034CE2:                
                move.l  #Offset_0x0355C5, Obj_Child_Data(A0)             ; $0030
                clr.b   Obj_Ani_Time(A0)                                 ; $0024
                clr.b   Obj_Ani_Frame(A0)                                ; $0023
                move.b  #$1C, Obj_Map_Id(A0)                             ; $0022
Offset_0x034CF8:                
                rts
Offset_0x034CFA:
                jsr     (Animate_Raw)                          ; Offset_0x04208E
                jmp     (Run_Object_Wait_Timer_A0)             ; Offset_0x0423D2
;-------------------------------------------------------------------------------    
Offset_0x034D06:
                move.b  #$08, Obj_Routine(A0)                            ; $0005
Offset_0x034D0C:                
                move.w  #$FF00, Obj_Speed_X(A0)                          ; $0018
                move.w  #$FC00, Obj_Speed_Y(A0)                          ; $001A
Offset_0x034D18:                
                move.l  #Offset_0x0355BB, Obj_Child_Data(A0)             ; $0030
                clr.b   Obj_Ani_Time(A0)                                 ; $0024
                clr.b   Obj_Ani_Frame(A0)                                ; $0023
                move.b  #$08, Obj_Map_Id(A0)                             ; $0022
                move.b  #$13, Obj_Height_2(A0)                           ; $001E
                rts 
;-------------------------------------------------------------------------------  
Offset_0x034D36:
                jsr     (Animate_Raw)                          ; Offset_0x04208E
                jsr     (ObjectFall)                           ; Offset_0x0110FE
                tst.w   Obj_Speed_Y(A0)                                  ; $001A
                bmi.s   Offset_0x034D62
                jsr     (ObjHitFloor)                          ; Offset_0x009D84
                tst.w   D1
                bpl.s   Offset_0x034D62
                bset    #$02, Obj_Control_Var_08(A0)                     ; $0038
                bne.s   Offset_0x034D64
                neg.w   Obj_Speed_X(A0)                                  ; $0018
                neg.w   Obj_Speed_Y(A0)                                  ; $001A
Offset_0x034D62:
                rts
Offset_0x034D64:
                addq.b  #$02, Obj_Routine(A0)                            ; $0005
                add.w   D1, Obj_Y(A0)                                    ; $0014
                bra     Offset_0x034CE2            
;-------------------------------------------------------------------------------  
Offset_0x034D70:
                jmp     (Animate_Raw)                          ; Offset_0x04208E 
;------------------------------------------------------------------------------- 
Knuckles_In_Carnival_Night_2_Lamp:                             ; Offset_0x034D76
                lea     Offset_0x034DAE(PC), A1
                jsr     (Check_Camera_In_Range)                ; Offset_0x043392
                moveq   #$00, D0
                move.b  Obj_Routine(A0), D0                              ; $0005
                move.w  Offset_0x034DA2(PC, D0), D1
                jsr     Offset_0x034DA2(PC, D1)
                bsr     Offset_0x035538
                lea     Knuckles_PLC_Data(PC), A2              ; Offset_0x0355A4
                jsr     (Load_Dynamic_PLC_A2)                  ; Offset_0x042A0A
                jmp     (Check_Delete_Touch_Slotted)           ; Offset_0x042C1E   
;-------------------------------------------------------------------------------
Offset_0x034DA2:
                dc.w    Offset_0x034DB6-Offset_0x034DA2
                dc.w    Offset_0x034DE2-Offset_0x034DA2
                dc.w    Offset_0x034E2E-Offset_0x034DA2
                dc.w    Offset_0x034C98-Offset_0x034DA2
                dc.w    Offset_0x034D36-Offset_0x034DA2
                dc.w    Offset_0x034E6A-Offset_0x034DA2 
;-------------------------------------------------------------------------------               
Offset_0x034DAE:
                dc.w    $0540, $0600, $3900, $3940                   
;-------------------------------------------------------------------------------
Offset_0x034DB6:
                lea     Knuckles_Setup_Data(PC), A1            ; Offset_0x035548
                jsr     (Object_Settings_Slotted)              ; Offset_0x04298C
                move.w  #$0078, Obj_Height_3(A0)                         ; $0044
                moveq   #Volume_Down, D0                                  ; -$20
                jsr     (Play_Music)                           ; Offset_0x001176
                move.w  (Sonic_Level_Limits_Min_Y).w, (Target_Camera_Min_Y).w ; $FFFFEE18, $FFFFFA96
                move.w  (Sonic_Level_Limits_Max_X).w, (Target_Camera_Max_X).w ; $FFFFEE16, $FFFFFA92
                move.w  #$3940, (Sonic_Level_Limits_Max_X).w         ; $FFFFEE16
                rts    
;-------------------------------------------------------------------------------
Offset_0x034DE2:
                lea     (Obj_Player_One).w, A1                       ; $FFFFB000
                cmpi.w  #$3990, Obj_X(A1)                                ; $0010
                bcs.s   Offset_0x034DFC
                tst.b   Obj_Timer(A1)                                    ; $002E
                bne.s   Offset_0x034DFC
                btst    #$03, Obj_Status(A1)                             ; $002A
                bne.s   Offset_0x034E04
Offset_0x034DFC:
                move.w  (Camera_X).w, (Sonic_Level_Limits_Min_X).w ; $FFFFEE78, $FFFFEE14
                rts
Offset_0x034E04:
                move.b  #$04, Obj_Routine(A0)                            ; $0005
                bset    #$00, Obj_Flags(A0)                              ; $0004
                move.w  #$001F, Obj_Timer(A0)                            ; $002E
                move.l  #Offset_0x034E44, Obj_Child(A0)                  ; $0034
                move.w  #$05C0, (Sonic_Level_Limits_Min_Y).w         ; $FFFFEE18
                lea     Knuckles_Palette(PC), A1               ; Offset_0x0355EE
                jmp     (Pal_Load_Line_1)                      ; Offset_0x04314C  
;-------------------------------------------------------------------------------
Offset_0x034E2E:
                subq.w  #$04, Obj_X(A0)                                  ; $0010
                lea     (Offset_0x0355B1), A1
                jsr     (Animate_Raw_A1)                       ; Offset_0x042092
                jmp     (Run_Object_Wait_Timer_A0)             ; Offset_0x0423D2   
;-------------------------------------------------------------------------------
Offset_0x034E44:
                move.b  #$06, Obj_Routine(A0)                            ; $0005
                move.b  #$20, Obj_Map_Id(A0)                             ; $0022
                move.w  #$001F, Obj_Timer(A0)                            ; $002E
                move.l  #Offset_0x034E60, Obj_Child(A0)                  ; $0034
                rts            
;-------------------------------------------------------------------------------
Offset_0x034E60:
                move.b  #$08, Obj_Routine(A0)                            ; $0005
                bra     Offset_0x034D0C        
;-------------------------------------------------------------------------------
Offset_0x034E6A:
                tst.b   Obj_Flags(A0)                                    ; $0004
                bmi     Offset_0x034CF8
                lea     Knuckles_Palette_CNz_Lamp(PC), A1      ; Offset_0x03560E
                jsr     (Pal_Load_Line_1)                      ; Offset_0x04314C
                lea     Offset_0x034E92(PC), A2
                jsr     (Load_Child_Object_A2)                 ; Offset_0x041D9A
                jsr     (Remove_From_Tracking_Slot)            ; Offset_0x042BFA
                jmp     (Go_Delete_Object_A0)                  ; Offset_0x042D3E
;-------------------------------------------------------------------------------
Offset_0x034E92:
                dc.w    $0001
                dc.l    Inc_Level_Gradual_Min_Y                ; Offset_0x0425C0
                dc.b    $00, $00
                dc.l    Inc_Level_Gradual_Max_X                ; Offset_0x042564
                dc.b    $00, $00                    
;------------------------------------------------------------------------------- 
Knuckles_In_Carnival_Night_2_Boss:                             ; Offset_0x034EA0
                lea     Offset_0x034ED4(PC), A1
                jsr     (Check_Camera_In_Range)                ; Offset_0x043392
                moveq   #$00, D0
                move.b  Obj_Routine(A0), D0                              ; $0005
                move.w  Offset_0x034EC8(PC, D0), D1
                jsr     Offset_0x034EC8(PC, D1)
                lea     Knuckles_PLC_Data(PC), A2              ; Offset_0x0355A4
                jsr     (Load_Dynamic_PLC_A2)                  ; Offset_0x042A0A
                jmp     (Check_Delete_Touch_Slotted)           ; Offset_0x042C1E  
;-------------------------------------------------------------------------------
Offset_0x034EC8:
                dc.w    Offset_0x034EDC-Offset_0x034EC8
                dc.w    Offset_0x034F48-Offset_0x034EC8
                dc.w    Offset_0x034F6A-Offset_0x034EC8
                dc.w    Offset_0x034F92-Offset_0x034EC8
                dc.w    Offset_0x034F6A-Offset_0x034EC8
                dc.w    Offset_0x035014-Offset_0x034EC8
;-------------------------------------------------------------------------------
Offset_0x034ED4:
                dc.w    $0176, $0300, $1B00, $1D00                
;-------------------------------------------------------------------------------
Offset_0x034EDC:
                lea     Knuckles_Setup_Data(PC), A1            ; Offset_0x035548
                jsr     (Object_Settings_Slotted)              ; Offset_0x04298C
                move.l  #Offset_0x0355CB, Obj_Child_Data(A0)             ; $0030
                moveq   #Volume_Down, D0                                  ; -$20
                jsr     (Play_Music)                           ; Offset_0x001176
                move.w  #$0078, Obj_Timer(A0)                            ; $002E
                move.b  #$1F, Obj_Angle(A0)                              ; $0026
                move.w  (Sonic_Level_Limits_Min_Y).w, (Target_Camera_Min_Y).w ; $FFFFEE18, $FFFFFA96
                move.w  (Level_Limits_Max_Y).w, (Target_Camera_Max_Y).w ; $FFFFEE12, $FFFFFA98
                move.w  (Sonic_Level_Limits_Min_X).w, (Target_Camera_Min_X).w ; $FFFFEE14, $FFFFFA94
                move.w  (Sonic_Level_Limits_Max_X).w, (Target_Camera_Max_X).w ; $FFFFEE16, $FFFFFA92
                move.w  #$0280, (Level_Limits_Max_Y).w               ; $FFFFEE12
                move.w  #$1D00, Obj_Inertia(A0)                          ; $001C
                move.w  #$1D00, (Sonic_Level_Limits_Max_X).w         ; $FFFFEE16
                move.l  #Offset_0x034F54, Obj_Child(A0)                  ; $0034
                lea     Knuckles_Palette(PC), A1               ; Offset_0x0355EE
                jsr     (Pal_Load_Line_1)                      ; Offset_0x04314C
                lea     Offset_0x03557E(PC), A2
                jmp     (Load_Child_Object_A2)                 ; Offset_0x041D9A  
;------------------------------------------------------------------------------- 
Offset_0x034F48:
                jsr     (Animate_Raw)                          ; Offset_0x04208E
                jmp     (Update_Sonic_Level_Limits_X_Y_Play_Music) ; Offset_0x0433DE   
;-------------------------------------------------------------------------------
Offset_0x034F54:
                move.b  #$04, Obj_Routine(A0)                            ; $0005
                move.w  #$003F, Obj_Timer(A0)                            ; $002E
                move.l  #Offset_0x034F76, Obj_Child(A0)                  ; $0034
                rts         
;-------------------------------------------------------------------------------
Offset_0x034F6A:
                jsr     (Animate_Raw)                          ; Offset_0x04208E
                jmp     (Run_Object_Wait_Timer_A0)             ; Offset_0x0423D2  
;-------------------------------------------------------------------------------
Offset_0x034F76:
                move.b  #$06, Obj_Routine(A0)                            ; $0005
                bset    #$00, Obj_Flags(A0)                              ; $0004
                move.w  #$FA00, Obj_Speed_Y(A0)                          ; $001A
                move.w  #$0140, Obj_Speed_X(A0)                          ; $0018
                bra     Offset_0x034D18           
;-------------------------------------------------------------------------------
Offset_0x034F92:
                jsr     (Animate_Raw)                          ; Offset_0x04208E
                jsr     (ObjectFall)                           ; Offset_0x0110FE
                tst.w   Obj_Speed_Y(A0)                                  ; $001A
                bmi.s   Offset_0x034FCC
                jsr     (ObjHitFloor)                          ; Offset_0x009D84
                tst.w   D1
                bpl.s   Offset_0x034FCC
                moveq   #$00, D0
                move.b  Obj_Control_Var_09(A0), D0                       ; $0039
                cmpi.b  #$08, D0
                bcc.s   Offset_0x034FCE
                move.l  Offset_0x034FF0(PC, D0), Obj_Speed_X(A0)         ; $0018
                addq.b  #$04, D0
                move.b  D0, Obj_Control_Var_09(A0)                       ; $0039
                bchg    #00, Obj_Flags(A0)                               ; $0004
Offset_0x034FCC:
                rts
Offset_0x034FCE:
                move.b  #$08, Obj_Routine(A0)                            ; $0005
                bclr    #$00, Obj_Flags(A0)                              ; $0004
                add.w   D1, Obj_Y(A0)                                    ; $0014
                move.w  #$003F, Obj_Timer(A0)                            ; $002E
                move.l  #Offset_0x034FF8, Obj_Child(A0)                  ; $0034
                bra     Offset_0x034CE2                  
;-------------------------------------------------------------------------------
Offset_0x034FF0:
                dc.w    $FF00, $FC00, $0100, $FC00      
;-------------------------------------------------------------------------------
Offset_0x034FF8:
                move.b  #$0A, Obj_Routine(A0)                            ; $0005
                bset    #$00, Obj_Flags(A0)                              ; $0004
                move.w  #$FA00, Obj_Speed_Y(A0)                          ; $001A
                move.w  #$0400, Obj_Speed_X(A0)                          ; $0018
                bra     Offset_0x034D18  
;-------------------------------------------------------------------------------
Offset_0x035014:
                jsr     (Animate_Raw)                          ; Offset_0x04208E
                jsr     (ObjectFall)                           ; Offset_0x0110FE
                tst.b   Obj_Flags(A0)                                    ; $0004
                bmi     Offset_0x034CF8
                lea     Knuckles_Palette_CNz_Boss(PC), A1      ; Offset_0x03562E
                jsr     (Pal_Load_Line_1)                      ; Offset_0x04314C
                lea     Offset_0x03504E(PC), A2
                jsr     (Load_Child_Object_A2)                 ; Offset_0x041D9A
                move.w  (Target_Camera_Max_Y).w, (Level_Limits_Max_Y).w ; $FFFFFA98, $FFFFEE12
                jsr     (Remove_From_Tracking_Slot)            ; Offset_0x042BFA
                jmp     (Go_Delete_Object_A0)                  ; Offset_0x042D3E  
;-------------------------------------------------------------------------------
Offset_0x03504E:
                dc.w    $0002
                dc.l    Inc_Level_Gradual_Min_Y                ; Offset_0x0425C0
                dc.b    $00, $00
                dc.l    Inc_Level_Gradual_Min_X                ; Offset_0x042592
                dc.b    $00, $00
                dc.l    Inc_Level_Gradual_Max_X                ; Offset_0x042564
                dc.b    $00, $00   
;-------------------------------------------------------------------------------
Offset_0x035062:
                move.w  Obj_Child_Ref(A0), A1                            ; $0046
                btst    #$07, Obj_Status(A1)                             ; $002A
                bne.s   Offset_0x035088
                move.b  #$08, Obj_Width(A0)                              ; $0007
                moveq   #$13, D1
                move.w  #$0100, D2
                move.w  #$0200, D3
                move.w  Obj_X(A0), D4                                    ; $0010
                jmp     (Solid_Object_2)                       ; Offset_0x0135B6
Offset_0x035088:
                jmp     (DeleteObject)                         ; Offset_0x011138
;------------------------------------------------------------------------------- 
Knuckles_In_Launch_Base_1:                                     ; Offset_0x03508E
                moveq   #$00, D0
                move.b  Obj_Routine(A0), D0                              ; $0005
                move.w  Offset_0x0350AC(PC, D0), D1
                jsr     Offset_0x0350AC(PC, D1)
                lea     Knuckles_PLC_Data(PC), A2              ; Offset_0x0355A4
                jsr     (Load_Dynamic_PLC_A2)                  ; Offset_0x042A0A
                jmp     (Check_Delete_Touch_Slotted)           ; Offset_0x042C1E   
;-------------------------------------------------------------------------------
Offset_0x0350AC:
                dc.w    Offset_0x0350BC-Offset_0x0350AC
                dc.w    Offset_0x0350E6-Offset_0x0350AC
                dc.w    Offset_0x034C98-Offset_0x0350AC
                dc.w    Offset_0x03512E-Offset_0x0350AC
                dc.w    Offset_0x034C98-Offset_0x0350AC
                dc.w    Offset_0x034F6A-Offset_0x0350AC
                dc.w    Offset_0x034F6A-Offset_0x0350AC
                dc.w    Offset_0x0351AC-Offset_0x0350AC     
;-------------------------------------------------------------------------------
Offset_0x0350BC:
                lea     Knuckles_Setup_Data(PC), A1            ; Offset_0x035548
                jsr     (Object_Settings_Slotted)              ; Offset_0x04298C
                move.b  #$16, Obj_Map_Id(A0)                             ; $0022
                move.w  #$00A0, (Sonic_Level_Limits_Min_Y).w         ; $FFFFEE18
                lea     Knuckles_Palette(PC), A1               ; Offset_0x0355EE
                jsr     (Pal_Load_Line_1)                      ; Offset_0x04314C
                lea     Offset_0x035586(PC), A2
                jsr     (Load_Child_Object_A2)                 ; Offset_0x041D9A   
;-------------------------------------------------------------------------------
Offset_0x0350E6:
                btst    #$03, Obj_Control_Var_08(A0)                     ; $0038
                bne.s   Offset_0x0350F0
                rts
Offset_0x0350F0:
                move.b  #$04, Obj_Routine(A0)                            ; $0005
                moveq   #Volume_Down, D0                                  ; -$20
                jsr     (Play_Music)                           ; Offset_0x001176
                move.w  #$0077, Obj_Timer(A0)                            ; $002E
                move.l  #Offset_0x03510E, Obj_Child(A0)                  ; $0034
                rts       
;-------------------------------------------------------------------------------
Offset_0x03510E:
                move.b  #$06, Obj_Routine(A0)                            ; $0005
                moveq   #Knuckles_Theme_Snd, D0                            ; $1F
                jsr     (Play_Music)                           ; Offset_0x001176
                move.l  #Offset_0x0355CF, Obj_Child_Data(A0)             ; $0030
                move.l  #Offset_0x035134, Obj_Child(A0)                  ; $0034
                rts  
;-------------------------------------------------------------------------------
Offset_0x03512E:
                jmp     (Animate_Raw_Multi_Delay)              ; Offset_0x04215C 
;-------------------------------------------------------------------------------
Offset_0x035134:
                move.b  #$08, Obj_Routine(A0)                            ; $0005
                move.w  #$000F, Obj_Timer(A0)                            ; $002E
                move.l  #Offset_0x03515E, Obj_Child(A0)                  ; $0034
                lea     Offset_0x03558E(PC), A2
                jsr     (Load_Child_Object_A2)                 ; Offset_0x041D9A
                lea     (PLC_After_Knuckles_LBz_1), A1         ; Offset_0x041BBA
                jmp     (LoadPLC_A1)                           ; Offset_0x001502  
;-------------------------------------------------------------------------------
Offset_0x03515E:
                move.b  #$0A, Obj_Routine(A0)                            ; $0005
                move.w  #$007F, Obj_Timer(A0)                            ; $002E
                move.l  #Offset_0x035176, Obj_Child(A0)                  ; $0034
                bra     Offset_0x034CE2                  
;-------------------------------------------------------------------------------
Offset_0x035176:
                move.b  #$0C, Obj_Routine(A0)                            ; $0005
                move.w  #$005F, Obj_Timer(A0)                            ; $002E
                move.l  #Offset_0x035194, Obj_Child(A0)                  ; $0034
                lea     Offset_0x035596(PC), A2
                jmp     (Load_Child_Object_Simple_A2)          ; Offset_0x041F5A  
;-------------------------------------------------------------------------------
Offset_0x035194:
                move.b  #$0E, Obj_Routine(A0)                            ; $0005
                move.l  #Offset_0x0355B1, Obj_Child_Data(A0)             ; $0030
                clr.b   Obj_Ani_Time(A0)                                 ; $0024
                clr.b   Obj_Ani_Frame(A0)                                ; $0023
                rts         
;-------------------------------------------------------------------------------
Offset_0x0351AC:
                tst.b   Obj_Flags(A0)                                    ; $0004
                bpl     Offset_0x0351BE
                addq.w  #$02, Obj_X(A0)                                  ; $0010
                jmp     (Animate_Raw)                          ; Offset_0x04208E
Offset_0x0351BE:
                clr.b   (Knuckles_Control_Lock_Flag).w               ; $FFFFFAA9
                jsr     (Restore_Player_Control)               ; Offset_0x0432EE
                lea     (Obj_Player_Two).w, A1                       ; $FFFFB04A
                jsr     (Restore_Player_Control_A1)            ; Offset_0x0432F2
                move.w  #$3B20, (Target_Camera_Max_X).w              ; $FFFFFA92
                lea     (Level_Resize_Max_X), A2               ; Offset_0x04261C
                jsr     (Load_Child_Object_Simple_A2)          ; Offset_0x041F5A
                move.w  #$0148, (Level_Limits_Max_Y).w               ; $FFFFEE12
                jsr     (Remove_From_Tracking_Slot)            ; Offset_0x042BFA
                lea     Knuckles_Palette_LBz(PC), A1           ; Offset_0x03564E
                jsr     (Pal_Load_Line_1)                      ; Offset_0x04314C
                jmp     (Go_Delete_Object_A0)                  ; Offset_0x042D3E  
;-------------------------------------------------------------------------------
Offset_0x035200:
                move.w  Obj_Child_Ref(A0), A1                            ; $0046
                btst    #$07, Obj_Status(A1)                             ; $002A
                bne.s   Offset_0x035238
                lea     Offset_0x035258(PC), A1
                jsr     (Check_Player_In_Range)                ; Offset_0x043104
                tst.l   D0
                beq.s   Offset_0x035236
                tst.w   D0
                beq.s   Offset_0x03522C
                move.w  Obj_Child_Ref(A0), A2                            ; $0046
                bset    #$03, Obj_Control_Var_08(A2)                     ; $0038
                bsr     Offset_0x03523E
Offset_0x03522C:
                swap.w  D0
                tst.w   D0
                beq.s   Offset_0x035236
                bsr     Offset_0x03523E
Offset_0x035236:
                rts
Offset_0x035238:
                jmp     (DeleteObject)                         ; Offset_0x011138
Offset_0x03523E:
                st      (Knuckles_Control_Lock_Flag).w               ; $FFFFFAA9
                move.w  D0, A1
                move.b  #$81, Obj_Timer(A1)                              ; $002E
                bclr    #$00, Obj_Flags(A1)                              ; $0004
                bclr    #$00, Obj_Status(A1)                             ; $002A
                rts
;-------------------------------------------------------------------------------
Offset_0x035258:
                dc.w    $FFC0, $0080, $FFD0, $0060       
;-------------------------------------------------------------------------------
Offset_0x035260:
                lea     Offset_0x035566(PC), A1
                jsr     (Object_Settings)                      ; Offset_0x041D72
                move.l  #Offset_0x03527C, (A0)
                move.w  #$FE00, Obj_Speed_X(A0)                          ; $0018
                move.w  #$FC00, Obj_Speed_Y(A0)                          ; $001A
Offset_0x03527C:                
                jsr     (Move_Light_Gravity)                   ; Offset_0x0426C2
                jmp     (Delete_Sprite_Check_X_Y)              ; Offset_0x042AD0   
;-------------------------------------------------------------------------------
Offset_0x035288:
                move.l  #Offset_0x0352C6, (A0)
                move.l  #Obj_Normal_Explode, Obj_Child(A0) ; Offset_0x041C30, $0034
                moveq   #$00, D0
                move.b  Obj_Subtype(A0), D0                              ; $002C
                add.w   D0, D0
                lea     Offset_0x0352B6(PC, D0), A1
                move.w  (A1)+, Obj_X(A0)                                 ; $0010
                move.w  (A1)+, Obj_Y(A0)                                 ; $0014
                move.b  #$0A, Obj_Subtype(A0)                            ; $002C
                jmp     (Offset_0x041C9A)
;-------------------------------------------------------------------------------
Offset_0x0352B6:
                dc.w    $3BC0, $01A0, $3B80, $01A0, $3B40, $01A0, $3B00, $01A0 
;-------------------------------------------------------------------------------
Offset_0x0352C6:
                subq.w  #$04, Obj_Y(A0)                                  ; $0014
                jmp     (Run_Object_Wait_Timer_A0)             ; Offset_0x0423D2 
;------------------------------------------------------------------------------- 
Knuckles_In_Launch_Base_2:                                     ; Offset_0x0352D0
                moveq   #$00, D0
                move.b  Obj_Routine(A0), D0                              ; $0005
                move.w  Offset_0x0352F2(PC, D0), D1
                jsr     Offset_0x0352F2(PC, D1)
                bsr     Offset_0x035538
                lea     Knuckles_PLC_Data(PC), A2              ; Offset_0x0355A4
                jsr     (Load_Dynamic_PLC_A2)                  ; Offset_0x042A0A
                jmp     (Check_Delete_Touch_Slotted)           ; Offset_0x042C1E     
;-------------------------------------------------------------------------------
Offset_0x0352F2:
                dc.w    Offset_0x0352FE-Offset_0x0352F2
                dc.w    Offset_0x03532E-Offset_0x0352F2
                dc.w    Offset_0x035348-Offset_0x0352F2
                dc.w    Offset_0x035362-Offset_0x0352F2
                dc.w    Offset_0x035384-Offset_0x0352F2
                dc.w    Offset_0x0353B2-Offset_0x0352F2    
;-------------------------------------------------------------------------------
Offset_0x0352FE:
                lea     Knuckles_Setup_Data(PC), A1            ; Offset_0x035548
                jsr     (Object_Settings_Slotted)              ; Offset_0x04298C
                bset    #$00, Obj_Flags(A0)                              ; $0004
                move.b  #$20, Obj_Map_Id(A0)                             ; $0022
                move.w  #$0078, Obj_Height_3(A0)                         ; $0044
                lea     Knuckles_Palette(PC), A1               ; Offset_0x0355EE
                jsr     (Pal_Load_Line_1)                      ; Offset_0x04314C
                lea     Offset_0x03559C(PC), A2
                jmp     (Load_Child_Object_Repeat_A2)          ; Offset_0x041E4E  
;-------------------------------------------------------------------------------
Offset_0x03532E:
                btst    #$01, Obj_Control_Var_08(A0)                     ; $0038
                bne.s   Offset_0x035338
                rts
Offset_0x035338:
                move.b  #$04, Obj_Routine(A0)                            ; $0005
                move.l  #Offset_0x035352, Obj_Child(A0)                  ; $0034
                rts      
;-------------------------------------------------------------------------------
Offset_0x035348:
                lea     Offset_0x0355DE(PC), A1
                jmp     (Animate_Raw_Multi_Delay_A1)           ; Offset_0x042160    
;-------------------------------------------------------------------------------
Offset_0x035352:
                move.b  #$06, Obj_Routine(A0)                            ; $0005
                bclr    #$00, Obj_Flags(A0)                              ; $0004
                bra     Offset_0x034CE2           
;-------------------------------------------------------------------------------
Offset_0x035362:
                tst.b   (Boss_Attack_Started).w                      ; $FFFFFAA2
                beq.s   Offset_0x03537E
                move.b  #$08, Obj_Routine(A0)                            ; $0005
                move.l  #Offset_0x0355AC, Obj_Child_Data(A0)             ; $0030
                clr.b   Obj_Ani_Time(A0)                                 ; $0024
                clr.b   Obj_Ani_Frame(A0)                                ; $0023
Offset_0x03537E:
                jmp     (Animate_Raw)                          ; Offset_0x04208E    
;-------------------------------------------------------------------------------
Offset_0x035384:
                btst    #$03, Obj_Control_Var_08(A0)                     ; $0038
                bne.s   Offset_0x035392
                jmp     (Animate_Raw)                          ; Offset_0x04208E
Offset_0x035392:
                move.b  #$0A, Obj_Routine(A0)                            ; $0005
                bset    #$00, Obj_Flags(A0)                              ; $0004
                move.b  #$09, Obj_Map_Id(A0)                             ; $0022
                move.w  #$0200, Obj_Speed_X(A0)                          ; $0018
                move.w  #$FF00, Obj_Speed_Y(A0)                          ; $001A
                rts     
;-------------------------------------------------------------------------------
Offset_0x0353B2:
                jmp     (Move_Light_Gravity)                   ; Offset_0x0426C2 
;-------------------------------------------------------------------------------
Offset_0x0353B8:
                lea     Offset_0x035572(PC), A1
                jsr     (Object_Settings)                      ; Offset_0x041D72
                move.l  #Offset_0x035400, (A0)
                moveq   #$00, D0
                move.b  Obj_Subtype(A0), D0                              ; $002C
                add.w   D0, D0
                move.l  Offset_0x0353E4(PC, D0), Obj_Control_Var_0E(A0)  ; $003E
                lsl.w   #$02, D0
                add.w   D0, Obj_Y(A0)                                    ; $0014
                move.w  Obj_X(A0), Obj_Control_Var_0A(A0)         ; $0010, $003A
                rts                                     
;-------------------------------------------------------------------------------
Offset_0x0353E4:
                dc.w    $0200, $0020, $0180, $0018, $0100, $0010, $0080, $0008
                dc.w    $0040, $0004, $0000, $0000, $0000, $0000
;-------------------------------------------------------------------------------  
Offset_0x035400:
                tst.b   (Boss_Attack_Started).w                      ; $FFFFFAA2
                beq.s   Offset_0x035418
                move.l  #Offset_0x03541E, (A0)
                move.w  Obj_Control_Var_0E(A0), Obj_Speed_X(A0)   ; $003E, $0018
                move.b  #$04, Obj_Control_Var_09(A0)                     ; $0039
Offset_0x035418:
                jmp     (Delete_Sprite_Check_X_Y)              ; Offset_0x042AD0
;-------------------------------------------------------------------------------
Offset_0x03541E:
                move.w  Obj_X(A0), D0                                    ; $0010
                move.w  Obj_Control_Var_10(A0), D1                       ; $0040
                cmp.w   Obj_Control_Var_0A(A0), D0                       ; $003A
                scs     D2
                bcs.s   Offset_0x035430
                neg.w   D1
Offset_0x035430:
                add.w   D1, Obj_Speed_X(A0)                              ; $0018
                cmpi.b  #$0A, Obj_Subtype(A0)                            ; $002C
                bcc.s   Offset_0x03545C
                cmp.b   Obj_Control_Var_0C(A0), D2                       ; $003C
                beq.s   Offset_0x03545C
                move.b  D2, Obj_Control_Var_0C(A0)                       ; $003C
                subq.b  #$01, Obj_Control_Var_09(A0)                     ; $0039
                bne.s   Offset_0x03545C
                move.l  #Offset_0x035478, (A0)
                move.w  Obj_Child_Ref(A0), A1                            ; $0046
                bset    #$03, Obj_Control_Var_08(A1)                     ; $0038
Offset_0x03545C:
                jsr     (SpeedToPos)                           ; Offset_0x01111E
                tst.b   Obj_Subtype(A0)                                  ; $002C
                bne.s   Offset_0x035472
                move.w  Obj_Child_Ref(A0), A1                            ; $0046
                move.w  Obj_X(A0), Obj_X(A1)                      ; $0010, $0010
Offset_0x035472:
                jmp     (Delete_Sprite_Check_X_Y)              ; Offset_0x042AD0  
;-------------------------------------------------------------------------------
Offset_0x035478:
                jsr     (Move_Light_Gravity)                   ; Offset_0x0426C2
                jmp     (Delete_Sprite_Check_X_Y)              ; Offset_0x042AD0  
;===============================================================================
; Objeto 0xC7 - Knuckles nas cenas de introdução
; <<<- 
;===============================================================================  