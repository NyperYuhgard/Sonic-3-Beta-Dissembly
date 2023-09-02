;===============================================================================
; Objeto 0xCA - Super Sonic na introdução da Angel Island
; ->>>                  
;===============================================================================
; Offset_0x035AD2:
                moveq   #$00, D0
                move.b  Obj_Routine(A0), D0                              ; $0005
                move.w  Offset_0x035AF0(PC, D0), D1
                jsr     Offset_0x035AF0(PC, D1)
                jsr     (Load_Sonic_Dynamic_PLC)               ; Offset_0x00C7EA
                bsr     Offset_0x035F0C
                jmp     (DisplaySprite)                        ; Offset_0x011148
;-------------------------------------------------------------------------------
Offset_0x035AF0:
                dc.w    Offset_0x035B0C-Offset_0x035AF0
                dc.w    Offset_0x035B74-Offset_0x035AF0
                dc.w    Offset_0x035B96-Offset_0x035AF0
                dc.w    Offset_0x035B74-Offset_0x035AF0
                dc.w    Offset_0x035BDC-Offset_0x035AF0
                dc.w    Offset_0x035C04-Offset_0x035AF0
                dc.w    Offset_0x035C54-Offset_0x035AF0
                dc.w    Offset_0x035C64-Offset_0x035AF0
                dc.w    Offset_0x035C8E-Offset_0x035AF0
                dc.w    Offset_0x035CB4-Offset_0x035AF0
                dc.w    Offset_0x035CEC-Offset_0x035AF0
                dc.w    Offset_0x035D06-Offset_0x035AF0
                dc.w    Offset_0x035D28-Offset_0x035AF0
                dc.w    Offset_0x035D44-Offset_0x035AF0  
;-------------------------------------------------------------------------------
Offset_0x035B0C:
                addq.b  #$02, Obj_Routine(A0)                            ; $0005
                move.l  #Sonic_Mappings, Obj_Map(A0)    ; Offset_0x100000, $000C
                move.w  #$0680, Obj_Art_VRAM(A0)                         ; $000A
                move.w  #$0280, Obj_Priority(A0)                         ; $0008
                move.b  #$01, Obj_Map_Id(A0)                             ; $0022
                move.b  #$40, Obj_Width(A0)                              ; $0007
                move.b  #$20, Obj_Width(A0)                              ; $0007
                move.w  #$0060, Obj_X(A0)                                ; $0010
                move.w  #$0030, Obj_Y(A0)                                ; $0014
                move.w  #$0040, Obj_Timer(A0)                            ; $002E
                move.l  #Offset_0x035B7A, Obj_Child(A0)                  ; $0034
                move.w  #$0008, Obj_Control_Var_10(A0)                   ; $0040
                move.w  #$E918, (Level_Events_Buffer_1).w            ; $FFFFEEB6
                move.b  #$FF, (Sonic_Previous_Frame).w               ; $FFFFF766
                lea     (Obj_Player_One).w, A1                       ; $FFFFB000
                move.b  #$00, Obj_Map_Id(A1)                             ; $0022
                move.b  #$53, Obj_Timer(A1)                              ; $002E
Offset_0x035B72:                
                rts   
;-------------------------------------------------------------------------------
Offset_0x035B74:
                jmp     (Run_Object_Wait_Timer_A0)             ; Offset_0x0423D2   
;-------------------------------------------------------------------------------
Offset_0x035B7A:
                move.b  #$04, Obj_Routine(A0)                            ; $0005
                move.w  #$0300, Obj_Speed_X(A0)                          ; $0018
                move.w  #$0600, Obj_Speed_Y(A0)                          ; $001A
                lea     Offset_0x035F24(PC), A2
                jmp     (Load_Child_Object_A2)                 ; Offset_0x041D9A     
;-------------------------------------------------------------------------------
Offset_0x035B96:
                subi.w  #$0018, Obj_Speed_Y(A0)                          ; $001A
                beq.s   Offset_0x035BA4
                jmp     (SpeedToPos)                           ; Offset_0x01111E
Offset_0x035BA4:
                move.b  #$06, Obj_Routine(A0)                            ; $0005
                move.w  #$005F, Obj_Timer(A0)                            ; $002E
                move.l  #Offset_0x035BBA, Obj_Child(A0)                  ; $0034
                rts      
;-------------------------------------------------------------------------------
Offset_0x035BBA:
                move.b  #$08, Obj_Routine(A0)                            ; $0005
                move.w  #$0400, Obj_Speed_X(A0)                          ; $0018
                move.w  #$FC00, Obj_Speed_Y(A0)                          ; $001A
                move.l  #Offset_0x035F48, Obj_Child_Data(A0)             ; $0030
                bset    #$03, Obj_Control_Var_08(A0)                     ; $0038
                rts    
;-------------------------------------------------------------------------------
Offset_0x035BDC:
                subi.w  #$0040, Obj_Speed_X(A0)                          ; $0018
                jsr     (ObjectFall)                           ; Offset_0x0110FE
                cmpi.w  #$0130, Obj_Y(A0)                                ; $0014
                bcc.s   Offset_0x035BF6
                jmp     (Animate_Raw)                          ; Offset_0x04208E
Offset_0x035BF6:
                move.b  #$0A, Obj_Routine(A0)                            ; $0005
                move.w  #$0130, Obj_Y(A0)                                ; $0014
                rts    
;-------------------------------------------------------------------------------
Offset_0x035C04:
                move.w  Obj_X(A0), D0                                    ; $0010
                subq.w  #$04, D0
                cmpi.w  #$0040, D0
                bcs.s   Offset_0x035C16
                move.w  D0, Obj_X(A0)                                    ; $0010
                rts
Offset_0x035C16:
                move.b  #$0C, Obj_Routine(A0)                            ; $0005
                move.w  #$0040, Obj_X(A0)                                ; $0010
                move.w  #$0005, Obj_Timer(A0)                            ; $002E
                move.l  #Offset_0x035C3A, Obj_Child(A0)                  ; $0034
                move.w  #$003F, Obj_Control_Var_0A(A0)                   ; $003A
                bra     Offset_0x035EBC                  
;-------------------------------------------------------------------------------
Offset_0x035C3A:
                move.w  #$0005, Obj_Timer(A0)                            ; $002E
                cmpi.w  #$0080, Obj_X(A0)                                ; $0010
                bcs     Offset_0x035B72
                lea     Offset_0x035F3A(PC), A2
                jmp     (Load_Child_Object_A2)                 ; Offset_0x041D9A  
;-------------------------------------------------------------------------------
Offset_0x035C54:
                subq.w  #$01, Obj_Control_Var_0A(A0)                     ; $003A
                bpl     Offset_0x035B72
                move.b  #$0E, Obj_Routine(A0)                            ; $0005
                rts        
;-------------------------------------------------------------------------------
Offset_0x035C64:
                bsr     Offset_0x035ED6
                jsr     (Run_Object_Wait_Timer_A0)             ; Offset_0x0423D2
                move.w  Obj_X(A0), D0                                    ; $0010
                addq.w  #$04, D0
                move.w  D0, Obj_X(A0)                                    ; $0010
                cmpi.w  #$0200, D0
                bcc.s   Offset_0x035C80
                rts
Offset_0x035C80:
                move.b  #$10, Obj_Routine(A0)                            ; $0005
                move.w  #$001F, Obj_Control_Var_0A(A0)                   ; $003A
                rts 
;-------------------------------------------------------------------------------
Offset_0x035C8E:
                bsr     Offset_0x035ED6
                jsr     (Run_Object_Wait_Timer_A0)             ; Offset_0x0423D2
                subq.w  #$01, Obj_Control_Var_0A(A0)                     ; $003A
                bpl     Offset_0x035B72
                move.b  #$12, Obj_Routine(A0)                            ; $0005
                bset    #$02, Obj_Control_Var_08(A0)                     ; $0038
                move.w  #$000C, Obj_Control_Var_10(A0)                   ; $0040
                rts    
;-------------------------------------------------------------------------------
Offset_0x035CB4:
                bsr     Offset_0x035ED6
                jsr     (Run_Object_Wait_Timer_A0)             ; Offset_0x0423D2
                move.w  Obj_X(A0), D0                                    ; $0010
                subi.w  #$0004, D0
                move.w  D0, Obj_X(A0)                                    ; $0010
                cmpi.w  #$0120, D0
                bls.s   Offset_0x035CD2
                rts
Offset_0x035CD2:
                move.b  #$14, Obj_Routine(A0)                            ; $0005
                bset    #$02, Obj_Control_Var_08(A0)                     ; $0038
                move.w  #$003F, Obj_Control_Var_0A(A0)                   ; $003A
                move.w  #$0010, Obj_Control_Var_10(A0)                   ; $0040
                rts     
;-------------------------------------------------------------------------------
Offset_0x035CEC:
                bsr     Offset_0x035ED6
                jsr     (Run_Object_Wait_Timer_A0)             ; Offset_0x0423D2
                subq.w  #$01, Obj_Control_Var_0A(A0)                     ; $003A
                bpl     Offset_0x035B72
                move.b  #$16, Obj_Routine(A0)                            ; $0005
                rts    
;-------------------------------------------------------------------------------
Offset_0x035D06:
                bsr     Offset_0x035ED6
                cmpi.w  #$0918, (Obj_Player_One+Obj_X).w             ; $FFFFB010
                bcc.s   Offset_0x035D18
                jmp     (Run_Object_Wait_Timer_A0)             ; Offset_0x0423D2
Offset_0x035D18:
                move.b  #$18, Obj_Routine(A0)                            ; $0005
                lea     Offset_0x035F42(PC), A2
                jmp     (Load_Child_Object_Simple_A2)          ; Offset_0x041F5A   
;-------------------------------------------------------------------------------
Offset_0x035D28:
                bsr     Offset_0x035ED6
                cmpi.w  #$1240, (Obj_Player_One+Obj_X).w             ; $FFFFB010
                bcc.s   Offset_0x035D36
                rts
Offset_0x035D36:
                move.b  #$1A, Obj_Routine(A0)                            ; $0005
                subi.w  #$0020, Obj_Y(A0)                                ; $0014
                rts  
;-------------------------------------------------------------------------------
Offset_0x035D44:
                bsr     Offset_0x035ED6
                cmpi.w  #$13D0, (Obj_Player_One+Obj_X).w             ; $FFFFB010
                bcc.s   Offset_0x035D52
                rts
Offset_0x035D52:
                lea     (Obj_Player_One).w, A1                       ; $FFFFB000
                clr.b   Obj_Timer(A1)                                    ; $002E
                st      (Control_Locked_Flag_P1).w                   ; $FFFFF7CC
                move.b  #$02, (Super_Sonic_Palette_Status).w         ; $FFFFF65F
                move.w  #$0028, (Super_Sonic_Palette_Frame).w        ; $FFFFF65C
                jmp     (Go_Delete_Object_A0)                  ; Offset_0x042D3E 
;-------------------------------------------------------------------------------
Offset_0x035D70:
                move.l  #Offset_0x035DB0, (A0)
                move.l  #Tornado_Mappings, Obj_Map(A0)   ; Offset_0x035F6C $000C
                move.w  #$0529, Obj_Art_VRAM(A0)                         ; $000A
                move.w  #$0280, Obj_Priority(A0)                         ; $0008
                move.b  #$40, Obj_Width(A0)                              ; $0007
                move.b  #$20, Obj_Width(A0)                              ; $0007
                lea     (Art_Tornado), A1                      ; Offset_0x12C208
                move.w  #$A520, D2
                jsr     (Kosinski_Moduled_Dec)                 ; Offset_0x0018A8
                lea     Offset_0x035F2C(PC), A2
                jmp     (Load_Child_Object_A2)                 ; Offset_0x041D9A   
;-------------------------------------------------------------------------------
Offset_0x035DB0:
                move.w  Obj_Child_Ref(A0), A1                            ; $0046
                btst    #$02, Obj_Control_Var_08(A1)                     ; $0038
                beq.s   Offset_0x035DC2
                move.l  #Offset_0x035DD6, (A0)
Offset_0x035DC2:
                btst    #$03, Obj_Control_Var_08(A1)                     ; $0038
                bne.s   Offset_0x035DD0
                jsr     (Refresh_Child_Position)               ; Offset_0x042016
Offset_0x035DD0:
                jmp     (DisplaySprite)                        ; Offset_0x011148   
;-------------------------------------------------------------------------------
Offset_0x035DD6:
                subq.w  #$04, Obj_X(A0)                                  ; $0010
                cmpi.w  #$0020, Obj_X(A0)                                ; $0010
                bcs.s   Offset_0x035DE8
                jmp     (DisplaySprite)                        ; Offset_0x011148
Offset_0x035DE8:
                jmp     (Go_Delete_Object_A0)                  ; Offset_0x042D3E   
;-------------------------------------------------------------------------------
Offset_0x035DEE:
                move.l  #Tornado_Mappings, Obj_Map(A0)  ; Offset_0x035F6C, $000C
                move.w  #$0529, Obj_Art_VRAM(A0)                         ; $000A
                move.w  #$0280, Obj_Priority(A0)                         ; $0008
                move.b  #$04, Obj_Width(A0)                              ; $0007
                move.b  #$0C, Obj_Width(A0)                              ; $0007
                move.l  #Offset_0x035E14, (A0)
Offset_0x035E14:                
                lea     (Offset_0x035F52), A1
                jsr     (Animate_Raw_A1)                       ; Offset_0x042092
                jsr     (Refresh_Child_Position)               ; Offset_0x042016
                jmp     (Child_Display_Or_Delete)              ; Offset_0x04245C   
;-------------------------------------------------------------------------------
Offset_0x035E2C:
                move.l  #Tornado_Mappings, Obj_Map(A0)  ; Offset_0x035F6C, $000C
                move.w  #$0529, Obj_Art_VRAM(A0)                         ; $000A
                move.w  #$0280, Obj_Priority(A0)                         ; $0008
                move.b  #$04, Obj_Width(A0)                              ; $0007
                move.b  #$0C, Obj_Width(A0)                              ; $0007
                move.l  #Offset_0x035E52, (A0)
Offset_0x035E52:                
                lea     (Offset_0x035F5A), A1
                jsr     (Animate_Raw_A1)                       ; Offset_0x042092
                jsr     (Refresh_Child_Position)               ; Offset_0x042016
                jmp     (Child_Display_Or_Delete)              ; Offset_0x04245C  
;-------------------------------------------------------------------------------
Offset_0x035E6A:
                move.l  #Offset_0x035EA4, (A0)
                move.l  #Surfboard_Waves_Mappings, Obj_Map(A0) ; Offset_0x018C62, $000C
                move.w  #$03D1, Obj_Art_VRAM(A0)                         ; $000A
                move.w  #$0100, Obj_Priority(A0)                         ; $0008
                move.b  #$10, Obj_Width(A0)                              ; $0007
                bset    #$00, Obj_Flags(A0)                              ; $0004
                move.w  Obj_Child_Ref(A0), A1                            ; $0046
                move.l  #Offset_0x035F5E, Obj_Child_Data(A0)             ; $0030
                move.l  #Go_Delete_Object_A0, Obj_Child(A0) ; Offset_0x042D3E, $0034
Offset_0x035EA4:                
                move.w  Obj_Child_Ref(A0), A1                            ; $0046
                move.w  Obj_Control_Var_10(A1), D0                       ; $0040
                sub.w   D0, Obj_X(A0)                                    ; $0010
                jsr     (Animate_Raw_Multi_Delay)              ; Offset_0x04215C
                jmp     (DisplaySprite)                        ; Offset_0x011148
Offset_0x035EBC:
                move.b  #$B5, Obj_Map_Id(A0)                             ; $0022
                move.b  #$00, (Super_Sonic_Palette_Timer).w          ; $FFFFF65E
                move.w  #$0030, (Super_Sonic_Palette_Frame).w        ; $FFFFF65C
                move.w  #$7FFF, (Super_Sonic_Frame_Count).w          ; $FFFFF670
                rts
Offset_0x035ED6:
                subq.b  #$01, (Super_Sonic_Palette_Timer).w          ; $FFFFF65E
                bpl.s   Offset_0x035F0A
                move.b  #$07, (Super_Sonic_Palette_Timer).w          ; $FFFFF65E
                lea     (Pal_SuperSonic_Cyc), A1               ; Offset_0x002BA0
                move.w  (Super_Sonic_Palette_Frame).w, D0            ; $FFFFF65C
                addq.w  #$08, (Super_Sonic_Palette_Frame).w          ; $FFFFF65C
                cmpi.w  #$0078, (Super_Sonic_Palette_Frame).w        ; $FFFFF65C
                bcs.s   Offset_0x035EFE
                move.w  #$0030, (Super_Sonic_Palette_Frame).w        ; $FFFFF65C
Offset_0x035EFE:
                lea     (Palette_Row_0_Offset+$04).w, A2             ; $FFFFED04
                move.l  $00(A1, D0), (A2)+
                move.w  $04(A1, D0), (A2)
Offset_0x035F0A:
                rts
Offset_0x035F0C:
                move.w  Obj_Control_Var_10(A0), D1                       ; $0040
                move.w  (Level_Events_Buffer_1).w, D0                ; $FFFFEEB6
                bpl.s   Offset_0x035F1E
                add.w   D1, D0
                move.w  D0, (Level_Events_Buffer_1).w                ; $FFFFEEB6
                rts
Offset_0x035F1E:
                add.w   D1, (Obj_Player_One+Obj_X).w                 ; $FFFFB010
                rts   
;-------------------------------------------------------------------------------    
Offset_0x035F24:
                dc.w    $0000
                dc.l    Offset_0x035D70
                dc.b    $DE, $2C   
;-------------------------------------------------------------------------------  
Offset_0x035F2C:
                dc.w    $0001
                dc.l    Offset_0x035DEE
                dc.b    $38, $04
                dc.l    Offset_0x035E2C
                dc.b    $18, $18    
;-------------------------------------------------------------------------------
Offset_0x035F3A:
                dc.w    $0000
                dc.l    Offset_0x035E6A
                dc.b    $F8, $18   
;-------------------------------------------------------------------------------      
Offset_0x035F42:
                dc.w    $0000
                dc.l    Obj_0xC7_Knuckles                      ; Offset_0x034BAA                 
;-------------------------------------------------------------------------------
Offset_0x035F48:
                dc.b    $03, $3D, $41, $3E, $41, $3F, $41, $40
                dc.b    $41, $FC                          
;-------------------------------------------------------------------------------
Offset_0x035F52:
                dc.b    $00, $01, $02, $03, $04, $03, $02, $FC   
;-------------------------------------------------------------------------------
Offset_0x035F5A:
                dc.b    $00, $05, $06, $FC        
;-------------------------------------------------------------------------------
Offset_0x035F5E:
                dc.b    $00, $01, $01, $02, $02, $03, $03, $03
                dc.b    $04, $02, $05, $02, $F4, $00  
;-------------------------------------------------------------------------------
Tornado_Mappings:                                              ; Offset_0x035F6C
                dc.w    Offset_0x035F82-Tornado_Mappings
                dc.w    Offset_0x035FBA-Tornado_Mappings
                dc.w    Offset_0x035FC2-Tornado_Mappings
                dc.w    Offset_0x035FCA-Tornado_Mappings
                dc.w    Offset_0x035FD2-Tornado_Mappings
                dc.w    Offset_0x035FDA-Tornado_Mappings
                dc.w    Offset_0x035FEE-Tornado_Mappings
                dc.w    Offset_0x036002-Tornado_Mappings
                dc.w    Offset_0x036022-Tornado_Mappings
                dc.w    Offset_0x03603C-Tornado_Mappings
                dc.w    Offset_0x036050-Tornado_Mappings
Offset_0x035F82:
                dc.w    $0009
                dc.w    $E009, $0000, $FFC4
                dc.w    $F00E, $0006, $FFC4
                dc.w    $F007, $0012, $FFE4
                dc.w    $E80F, $001A, $FFF4
                dc.w    $080C, $002A, $FFF4
                dc.w    $E80C, $002E, $0014
                dc.w    $F00B, $0032, $0014
                dc.w    $1005, $003E, $001C
                dc.w    $F802, $0042, $002C
Offset_0x035FBA:
                dc.w    $0001
                dc.w    $F402, $0045, $FFFC
Offset_0x035FC2:
                dc.w    $0001
                dc.w    $F402, $0048, $FFFC
Offset_0x035FCA:
                dc.w    $0001
                dc.w    $F402, $004B, $FFFC
Offset_0x035FD2:
                dc.w    $0001
                dc.w    $F402, $004E, $FFFC
Offset_0x035FDA:
                dc.w    $0003
                dc.w    $F80D, $0051, $FFE4
                dc.w    $F809, $0059, $0004
                dc.w    $F80D, $005F, $FFC4
Offset_0x035FEE:
                dc.w    $0003
                dc.w    $F80D, $0051, $FFE4
                dc.w    $F809, $0059, $0004
                dc.w    $F805, $0067, $FFD4
Offset_0x036002:
                dc.w    $0005
                dc.w    $F80D, $006B, $FFC4
                dc.w    $F80D, $086B, $001C
                dc.w    $F809, $0073, $FFE4
                dc.w    $F809, $006F, $0004
                dc.w    $F801, $006F, $FFFC
Offset_0x036022:
                dc.w    $0004
                dc.w    $F80D, $0079, $FFD0
                dc.w    $F80D, $0879, $0010
                dc.w    $F805, $007D, $FFF0
                dc.w    $F805, $007D, $0000
Offset_0x03603C:
                dc.w    $0003
                dc.w    $FC0C, $0081, $FFDC
                dc.w    $FC0C, $0881, $0004
                dc.w    $FC00, $0082, $FFFC
Offset_0x036050:
                dc.w    $0002
                dc.w    $FC08, $0085, $FFE8
                dc.w    $FC08, $0885, $0000
;===============================================================================
; Objeto 0xCA - Super Sonic na introdução da Angel Island
; <<<- 
;===============================================================================  