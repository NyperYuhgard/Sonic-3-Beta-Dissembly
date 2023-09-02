;-------------------------------------------------------------------------------
; Escudo a prova de afogamento nas fases com água do Sonic / Miles / Knuckles
; ->>>
;------------------------------------------------------------------------------- 
; Offset_0x010512:
                move.l  #Water_Shield_Mappings, Obj_Map(A0) ; Offset_0x010874, $000C
                move.l  #Water_Shield_Dyn_Script, Obj_Control_Var_0C(A0) ; Offset_0x010940, $003C
                move.l  #Art_Water_Shield, Obj_Control_Var_08(A0) ; Offset_0x084E80, $0038
                move.b  #$04, Obj_Flags(A0)                              ; $0004
                move.w  #$0080, Obj_Priority(A0)                         ; $0008
                move.b  #$18, Obj_Width(A0)                              ; $0007
                move.b  #$18, Obj_Height(A0)                             ; $0006
                move.w  #$079C, Obj_Art_VRAM(A0)                         ; $000A
                move.w  #$F380, Obj_Control_Var_10(A0)                   ; $0040
                btst    #$07, (Obj_Player_One+Obj_Art_VRAM).w        ; $FFFFB00A
                beq.s   Offset_0x01055C
                bset    #$07, Obj_Art_VRAM(A0)                           ; $000A
Offset_0x01055C:
                move.l  #Offset_0x010562, (A0)
Offset_0x010562:                
                move.w  Obj_Player_Last(A0), A2                          ; $0042
                btst    #Invincibility_Type, Obj_Player_Status(A2)  ; $01, $002F
                bne.s   Offset_0x0105B0
                btst    #Classic_Type, Obj_Player_Status(A2)        ; $00, $002F
                beq.s   Offset_0x0105B2
                move.w  Obj_X(A2), Obj_X(A0)                      ; $0010, $0010
                move.w  Obj_Y(A2), Obj_Y(A0)                      ; $0014, $0014
                move.b  Obj_Status(A2), Obj_Status(A0)            ; $002A, $002A
                andi.w  #$7FFF, Obj_Art_VRAM(A0)                         ; $000A
                tst.w   Obj_Art_VRAM(A2)                                 ; $000A
                bpl.s   Offset_0x01059A
                ori.w   #$8000, Obj_Art_VRAM(A0)                         ; $000A
Offset_0x01059A:
                lea     (Water_Shield_Animate_Data), A1        ; Offset_0x010624
                jsr     (AnimateSprite)                        ; Offset_0x01115E
                bsr     Load_Shield_Dynamic_PLC                ; Offset_0x0105B8
                jmp     (DisplaySprite)                        ; Offset_0x011148
Offset_0x0105B0:
                rts
Offset_0x0105B2:
                jmp     (DeleteObject)                         ; Offset_0x011138    
;-------------------------------------------------------------------------------
Load_Shield_Dynamic_PLC:                                       ; Offset_0x0105B8
                moveq   #$00, D0
                move.b  Obj_Map_Id(A0), D0                               ; $0022
                cmp.b   Obj_Control_Var_04(A0), D0                       ; $0034
                beq.s   Offset_0x010606
                move.b  D0, Obj_Control_Var_04(A0)                       ; $0034
                move.l  Obj_Control_Var_0C(A0), A2                       ; $003C
                add.w   D0, D0
                adda.w  $00(A2, D0), A2
                move.w  (A2)+, D5
                subq.w  #$01, D5
                bmi.s   Offset_0x010606
                move.w  Obj_Control_Var_10(A0), D4                       ; $0040
Loop_Load_Shield_Dynamic_PLC:                                  ; Offset_0x0105DC
                moveq   #$00, D1
                move.w  (A2)+, D1
                move.w  D1, D3
                lsr.w   #$08, D3
                andi.w  #$00F0, D3
                addi.w  #$0010, D3
                andi.w  #$0FFF, D1
                lsl.l   #$05, D1
                add.l   Obj_Control_Var_08(A0), D1                       ; $0038
                move.w  D4, D2
                add.w   D3, D4
                add.w   D3, D4
                jsr     (DMA_68KtoVRAM)                        ; Offset_0x0012FC
                dbra    D5, Loop_Load_Shield_Dynamic_PLC       ; Offset_0x0105DC
Offset_0x010606:
                rts                                           
;-------------------------------------------------------------------------------
; Escudo a prova de afogamento nas fases com água do Sonic / Miles / Knuckles
; <<<-
;-------------------------------------------------------------------------------