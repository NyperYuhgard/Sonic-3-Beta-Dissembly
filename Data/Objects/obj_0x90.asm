;===============================================================================
; Objeto 0x90 - Inimigo Fireworm usado na Lava Reef
; ->>>          
;===============================================================================
; Offset_0x049FB6:
                jsr     (Object_Check_Range)                   ; Offset_0x04326E
                moveq   #$00, D0
                move.b  Obj_Routine(A0), D0                              ; $0005
                move.w  Offset_0x049FD0(PC, D0), D1
                jsr     Offset_0x049FD0(PC, D1)
                jmp     (Delete_Sprite_Check_X)                ; Offset_0x042A58
;-------------------------------------------------------------------------------
Offset_0x049FD0:
                dc.w    Offset_0x049FD6-Offset_0x049FD0
                dc.w    Offset_0x049FE0-Offset_0x049FD0
                dc.w    Offset_0x04A008-Offset_0x049FD0  
;-------------------------------------------------------------------------------
Offset_0x049FD6:
                lea     Fireworm_Setup_Data(PC), A1            ; Offset_0x04A226
                jmp     (Object_Settings)                      ; Offset_0x041D72  
;-------------------------------------------------------------------------------
Offset_0x049FE0:
                jsr     (Find_Player)                          ; Offset_0x042634
                cmpi.w  #$0080, D2
                bcs.s   Offset_0x049FEE
                rts
Offset_0x049FEE:
                move.b  #$04, Obj_Routine(A0)                            ; $0005
                lea     Offset_0x04A256(PC), A2
                jsr     (Load_Child_Object_A2)                 ; Offset_0x041D9A
                bne.s   Offset_0x04A006
                move.b  Obj_Subtype(A0), Obj_Subtype(A1)          ; $002C, $002C
Offset_0x04A006:
                rts   
;-------------------------------------------------------------------------------
Offset_0x04A008:
                rts   
;-------------------------------------------------------------------------------
Offset_0x04A00A:
                moveq   #$00, D0
                move.b  Obj_Routine(A0), D0                              ; $0005
                move.w  Offset_0x04A028(PC, D0), D1
                jsr     Offset_0x04A028(PC, D1)
                lea     Fireworm_PLC_Data(PC), A2              ; Offset_0x04A280
                jsr     (Load_Dynamic_PLC_A2)                  ; Offset_0x042A0A
                jmp     (Display_Sprite_Check_X)               ; Offset_0x042D0C
;-------------------------------------------------------------------------------
Offset_0x04A028:
                dc.w    Offset_0x04A032-Offset_0x04A028
                dc.w    Offset_0x04A03C-Offset_0x04A028
                dc.w    Offset_0x04A060-Offset_0x04A028
                dc.w    Offset_0x04A0B0-Offset_0x04A028
                dc.w    Offset_0x04A0E8-Offset_0x04A028   
;-------------------------------------------------------------------------------    
Offset_0x04A032:
                lea     Fireworm_Setup_Data_2(PC), A1          ; Offset_0x04A232
                jsr     (Object_Settings_Slotted)              ; Offset_0x04298C  
;-------------------------------------------------------------------------------  
Offset_0x04A03C:
                jmp     (Run_Object_Wait_Timer_A0)             ; Offset_0x0423D2  
;-------------------------------------------------------------------------------
; Offset_0x04A042:
                move.b  #$04, Obj_Routine(A0)                            ; $0005
                move.w  #$0003, Obj_Timer(A0)                            ; $002E
                move.l  #Offset_0x04A06C, Obj_Child(A0)                  ; $0034
                move.w  #$FF00, D4
                jmp     (Set_Velocity_X_Track_Player_One)      ; Offset_0x042E4C 
;-------------------------------------------------------------------------------
Offset_0x04A060:
                jsr     (SpeedToPos)                           ; Offset_0x01111E
                jmp     (Run_Object_Wait_Timer_A0)             ; Offset_0x0423D2 
;-------------------------------------------------------------------------------
Offset_0x04A06C:
                move.b  #$01, Obj_Map_Id(A0)                             ; $0022
                lea     Offset_0x04A25E(PC), A2
                jsr     (Load_Child_Object_A2)                 ; Offset_0x041D9A
Offset_0x04A07C:                
                move.b  #$06, Obj_Routine(A0)                            ; $0005
                move.w  #$FF00, Obj_Control_Var_12(A0)                   ; $0042
                move.l  #Offset_0x04A280, Obj_Child_Data(A0)             ; $0030
Offset_0x04A090:
                move.b  #$08, Obj_Control_Var_09(A0)                     ; $0039
Offset_0x04A096: ; Referência usada pelo objeto 0x9F - Catakiller Jr.                
                move.w  #$0080, D0
                move.w  D0, Obj_Control_Var_0E(A0)                       ; $003E
                move.w  D0, Obj_Speed_Y(A0)                              ; $001A
                move.w  #$0008, Obj_Control_Var_10(A0)                   ; $0040
                bclr    #$00, Obj_Control_Var_08(A0)                     ; $0038
                rts  
;-------------------------------------------------------------------------------
Offset_0x04A0B0:
                jsr     (Swing_Up_And_Down_Count)              ; Offset_0x0423B6
                bne.s   Offset_0x04A0C4
                jsr     (SpeedToPos)                           ; Offset_0x01111E
                jmp     (Animate_Raw_Multi_Delay)              ; Offset_0x04215C
Offset_0x04A0C4:
                move.b  #$08, Obj_Routine(A0)                            ; $0005
                move.w  Obj_Speed_X(A0), Obj_Height_3(A0)         ; $0018, $0044
                move.w  Obj_Control_Var_12(A0), Obj_Speed_Y(A0)   ; $0042, $001A
                neg.w   Obj_Control_Var_12(A0)                           ; $0042
                clr.w   Obj_Timer(A0)                                    ; $002E
                clr.b   Obj_Ani_Frame(A0)                                ; $0023
                clr.b   Obj_Ani_Time(A0)                                 ; $0024
                rts  
;-------------------------------------------------------------------------------
Offset_0x04A0E8:
                lea     Offset_0x04A28D(PC), A1
                jsr     (Animate_Raw_Multi_Delay_Flip_X_A1)    ; Offset_0x0421D2
                addq.w  #$01, Obj_Timer(A0)                              ; $002E
                tst.w   Obj_Height_3(A0)                                 ; $0044
                bmi.s   Offset_0x04A114
                move.w  Obj_Speed_X(A0), D0                              ; $0018
                subi.w  #$0010, D0
                cmpi.w  #$FF00, D0
                ble.s   Offset_0x04A12C
                move.w  D0, Obj_Speed_X(A0)                              ; $0018
                jmp     (SpeedToPos)                           ; Offset_0x01111E
Offset_0x04A114:
                move.w  Obj_Speed_X(A0), D0                              ; $0018
                addi.w  #$0010, D0
                cmpi.w  #$0100, D0
                bge.s   Offset_0x04A12C
                move.w  D0, Obj_Speed_X(A0)                              ; $0018
                jmp     (SpeedToPos)                           ; Offset_0x01111E
Offset_0x04A12C:
                move.b  #$06, Obj_Routine(A0)                            ; $0005
                clr.b   Obj_Ani_Frame(A0)                                ; $0023
                clr.b   Obj_Ani_Time(A0)                                 ; $0024
                bra     Offset_0x04A090                                
;-------------------------------------------------------------------------------
Offset_0x04A13E:
                moveq   #$00, D0
                move.b  Obj_Routine(A0), D0                              ; $0005
                move.w  Offset_0x04A154(PC, D0), D1
                jsr     Offset_0x04A154(PC, D1)
                moveq   #$00, D0
                jmp     (Child_Display_Touch_Or_Flicker_Move)  ; Offset_0x042520  
;-------------------------------------------------------------------------------
Offset_0x04A154:
                dc.w    Offset_0x04A15E-Offset_0x04A154
                dc.w    Offset_0x04A196-Offset_0x04A154
                dc.w    Offset_0x04A196-Offset_0x04A154
                dc.w    Offset_0x04A0B0-Offset_0x04A154
                dc.w    Offset_0x04A0E8-Offset_0x04A154 
;-------------------------------------------------------------------------------
Offset_0x04A15E:
                lea     Fireworm_Setup_Data_3(PC), A1          ; Offset_0x04A244
                jsr     (Object_Settings)                      ; Offset_0x041D72
                moveq   #$00, D0
                move.b  Obj_Subtype(A0), D0                              ; $002C
                move.w  Offset_0x04A18E(PC, D0), Obj_Timer(A0)           ; $002E
                move.l  #Offset_0x04A19C, Obj_Child(A0)                  ; $0034
                move.w  Obj_Child_Ref(A0), A1                            ; $0046
                move.w  Obj_Speed_X(A1), Obj_Speed_X(A0)          ; $0018, $0018
                move.b  Obj_Flags(A1), Obj_Flags(A0)              ; $0004, $0004
                rts          
;-------------------------------------------------------------------------------
Offset_0x04A18E:
                dc.w    $000B, $0016, $0021, $002C     
;-------------------------------------------------------------------------------
Offset_0x04A196:
                jmp     (Run_Object_Wait_Timer_A0)             ; Offset_0x0423D2   
;-------------------------------------------------------------------------------  
Offset_0x04A19C:
                lea     Offset_0x04A278(PC), A2
                jsr     (Load_Child_Object_A2)                 ; Offset_0x041D9A
                bra     Offset_0x04A07C                     
;-------------------------------------------------------------------------------    
Offset_0x04A1AA:
                jsr     (Refresh_Child_Position_Adjusted)      ; Offset_0x04203C
                moveq   #$00, D0
                move.b  Obj_Routine(A0), D0                              ; $0005
                move.w  Offset_0x04A1C4(PC, D0), D1
                jsr     Offset_0x04A1C4(PC, D1)
                jmp     (Child_Display_Touch_Or_Delete)        ; Offset_0x042472  
;-------------------------------------------------------------------------------
Offset_0x04A1C4:
                dc.w    Offset_0x04A1CA-Offset_0x04A1C4
                dc.w    Offset_0x04A1E6-Offset_0x04A1C4
                dc.w    Offset_0x04A210-Offset_0x04A1C4   
;-------------------------------------------------------------------------------
Offset_0x04A1CA:
                lea     Fireworm_Setup_Data_4(PC), A1          ; Offset_0x04A250
                jsr     (Object_Settings_3)                    ; Offset_0x041D7A
                move.l  #Offset_0x04A296, Obj_Child_Data(A0)             ; $0030
                move.l  #Offset_0x04A1EC, Obj_Child(A0)                  ; $0034
                rts 
;-------------------------------------------------------------------------------
Offset_0x04A1E6:
                jmp     (Animate_Raw)                          ; Offset_0x04208E  
;-------------------------------------------------------------------------------
Offset_0x04A1EC:
                move.b  #$04, Obj_Routine(A0)                            ; $0005
                move.b  #$07, Obj_Map_Id(A0)                             ; $0022
                jsr     (PseudoRandomNumber)                   ; Offset_0x001AFA
                andi.w  #$003F, D0
                move.w  D0, Obj_Timer(A0)                                ; $002E
                move.l  #Offset_0x04A216, Obj_Child(A0)                  ; $0034
                rts 
;-------------------------------------------------------------------------------
Offset_0x04A210:
                jmp     (Run_Object_Wait_Timer_A0)             ; Offset_0x0423D2  
;-------------------------------------------------------------------------------
Offset_0x04A216:
                move.b  #$02, Obj_Routine(A0)                            ; $0005
                move.l  #Offset_0x04A1EC, Obj_Child(A0)                  ; $0034
                rts                                              
;-------------------------------------------------------------------------------
Fireworm_Setup_Data:                                           ; Offset_0x04A226
                dc.l    Fireworm_Segments_Mappings             ; Offset_0x10E274
                dc.w    $E518, $0280
                dc.b    $0C, $0C, $00, $00      
;-------------------------------------------------------------------------------  
Fireworm_Setup_Data_2:                                         ; Offset_0x04A232
                dc.w    $0003, $A580, $0009, $0000
                dc.l    Fireworm_Mappings                      ; Offset_0x10E2DC
                dc.w    $0180
                dc.b    $0C, $0C, $00, $0B
;------------------------------------------------------------------------------- 
Fireworm_Setup_Data_3:                                         ; Offset_0x04A244
                dc.l    Fireworm_Segments_Mappings             ; Offset_0x10E274
                dc.w    $A518, $0200
                dc.b    $08, $08, $01, $87 
;------------------------------------------------------------------------------- 
Fireworm_Setup_Data_4:                                         ; Offset_0x04A250
                dc.w    $0180
                dc.b    $08, $08, $03, $98  
;------------------------------------------------------------------------------- 
Offset_0x04A256:
                dc.w    $0000
                dc.l    Offset_0x04A00A
                dc.b    $00, $00       
;-------------------------------------------------------------------------------
Offset_0x04A25E:
                dc.w    $0003
                dc.l    Offset_0x04A13E
                dc.b    $00, $00
                dc.l    Offset_0x04A13E
                dc.b    $00, $00
                dc.l    Offset_0x04A13E 
                dc.b    $00, $00
                dc.l    Offset_0x04A13E
                dc.b    $00, $00            
;-------------------------------------------------------------------------------
Offset_0x04A278:
                dc.w    $0000
                dc.l    Offset_0x04A1AA
                dc.b    $00, $F2
;-------------------------------------------------------------------------------
Fireworm_PLC_Data:                                             ; Offset_0x04A280 
              ; dc.l    Art_Fireworm
              ; dc.l    Fireworm_Dyn_Script                    ; Offset_0x10E2C4
;-------------------------------------------------------------------------------                 
Offset_0x04A280:
                dc.b    $01, $03, $01, $06, $02, $08, $03, $01
                dc.b    $F8, $0A, $03, $7F, $FC   
;-------------------------------------------------------------------------------
Offset_0x04A28D:
                dc.b    $03, $07, $02, $07, $42, $07, $03, $7F
                dc.b    $FC     
;-------------------------------------------------------------------------------
Offset_0x04A296:
                dc.b    $03, $04, $04, $05, $06, $F4                                       
;===============================================================================
; Objeto 0x90 - Inimigo Fireworm usado na Lava Reef
; <<<- 
;===============================================================================  