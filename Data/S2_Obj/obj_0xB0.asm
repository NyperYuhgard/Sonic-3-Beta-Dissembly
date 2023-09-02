;===============================================================================
; Objeto 0xB0 - Sonic correndo na tela SEGA
; ->>>
;===============================================================================    
Offset_0x034488:
                moveq   #$00, D0
                move.b  Obj_Routine(A0), D0                              ; $0005
                move.w  Offset_0x034496(PC, D0), D1
                jmp     Offset_0x034496(PC, D1) 
Offset_0x034496:
                dc.w    Offset_0x0344A2-Offset_0x034496
                dc.w    Offset_0x0345AC-Offset_0x034496
                dc.w    Offset_0x0345EA-Offset_0x034496
                dc.w    Offset_0x034654-Offset_0x034496
                dc.w    Offset_0x03468E-Offset_0x034496
                dc.w    Offset_0x0346BA-Offset_0x034496
;-------------------------------------------------------------------------------                     
Offset_0x0344A2:
                lea     S2_Obj_0xB0_Setup_Data(PC), A1         ; Offset_0x03485A
                jsr     (Object_Settings)                      ; Offset_0x041D72
                move.b  #$00, Obj_Flags(A0)                              ; $0004
                move.w  #$01E8, Obj_X(A0)                                ; $0010
                move.w  #$00F0, Obj_Y(A0)                                ; $0014
                move.w  #$000B, Obj_Timer(A0)                            ; $002E
                move.w  #$0002, (VBlank_Subroutine).w                ; $FFFFF662
                bset    #$00, Obj_Flags(A0)                              ; $0004
                bset    #$00, Obj_Status(A0)                             ; $002A
                lea     (Horizontal_Scroll_Buffer+$0138).w, A1       ; $FFFFE138
                lea     Offset_0x034A08(PC), A2
                moveq   #$00, D0
                moveq   #$22, D6
Offset_0x0344E2:
                move.b  (A2)+, D0
                add.w   D0, (A1)
                addq.w  #$08, A1
                dbra    D6, Offset_0x0344E2
                lea     Offset_0x03454C(PC), A1
                lea     (Art_Sonic), A3                        ; Offset_0x050000
                lea     (M68K_RAM_Start), A5                         ; $FFFF0000
                moveq   #$03, D5
Offset_0x0344FE:
                move.l  (A1)+, A2
                move.w  (A2)+, D6
                subq.w  #$01, D6
Offset_0x034504:
                move.w  (A2)+, D0
                move.w  D0, D1
                andi.w  #$0FFF, D0
                lsl.w   #$05, D0
                lea     $00(A3, D0), A4
                andi.w  #$F000, D1
                rol.w   #$04, D1
                addq.w  #$01, D1
                lsl.w   #$03, D1
                subq.w  #$01, D1
Offset_0x03451E:
                move.l  (A4)+, (A5)+
                dbra    D1, Offset_0x03451E
                dbra    D6, Offset_0x034504
                dbra    D5, Offset_0x0344FE
                move.w  D7, -(A7)
                moveq   #$00, D0
                moveq   #$00, D1
                lea     Offset_0x03455C(PC), A6
                moveq   #$07, D7
Offset_0x034538:
                move.l  (A6)+, A1
                move.l  (A6)+, A2
                move.b  (A6)+, D0
                move.b  (A6)+, D1
                bsr     Sub_Sega_Intro                         ; Offset_0x034A2C
                dbra    D7, Offset_0x034538
                move.w  (A7)+, D7
                rts   
Offset_0x03454C:
                dc.l    Offset_0x101994
                dc.l    Offset_0x10199A
                dc.l    Offset_0x1019A0
                dc.l    Offset_0x1019A6   
Offset_0x03455C:
                dc.l    $FFFF0000, $FFFF0B00
                dc.b    $02, $01
                dc.l    $FFFF00C0, $FFFF0E00
                dc.b    $03, $03
                dc.l    $FFFF02C0, $FFFF1600
                dc.b    $02, $01
                dc.l    $FFFF0380, $FFFF1900
                dc.b    $03, $03
                dc.l    $FFFF0580, $FFFF2100
                dc.b    $02, $01
                dc.l    $FFFF0640, $FFFF2400
                dc.b    $03, $03
                dc.l    $FFFF0840, $FFFF2C00
                dc.b    $02, $01
                dc.l    $FFFF0900, $FFFF2F00
                dc.b    $03, $03  
;-------------------------------------------------------------------------------                   
Offset_0x0345AC:
                subi.w  #$0020, Obj_X(A0)                                ; $0010
                subq.w  #$01, Obj_Timer(A0)                              ; $002E
                bmi.s   Offset_0x0345CE
                bsr     Offset_0x0346F8
                lea     (Sonic_SEGA_Logo_Animate_Data), A1     ; Offset_0x03486E
                jsr     (AnimateSprite)                        ; Offset_0x01115E
                jmp     (DisplaySprite)                        ; Offset_0x011148
Offset_0x0345CE:
                addq.b  #$02, Obj_Routine(A0)                            ; $0005
                move.w  #$000C, Obj_Timer(A0)                            ; $002E
                move.b  #$01, Obj_Control_Var_00(A0)                     ; $0030
                move.b  #$FF, Obj_Control_Var_01(A0)                     ; $0031
                jmp     (DisplaySprite)                        ; Offset_0x011148
;-------------------------------------------------------------------------------                
Offset_0x0345EA:
                tst.w   Obj_Timer(A0)                                    ; $002E
                beq.s   Offset_0x0345F8
                subq.w  #$01, Obj_Timer(A0)                              ; $002E
                bsr     Offset_0x0346F8
Offset_0x0345F8:
                lea     Offset_0x03476E(PC), A1
                bsr     Offset_0x034720
                bne.s   Offset_0x034604
                rts
Offset_0x034604:
                addq.b  #$02, Obj_Routine(A0)                            ; $0005
                bchg    #00, Obj_Flags(A0)                               ; $0004
                move.w  #$000B, Obj_Timer(A0)                            ; $002E
                move.w  #$0004, (VBlank_Subroutine).w                ; $FFFFF662
                subi.w  #$0028, Obj_X(A0)                                ; $0010
                bchg    #00, Obj_Flags(A0)                               ; $0004
                bchg    #00, Obj_Status(A0)                              ; $002A
                lea     (Horizontal_Scroll_Buffer).w, A1             ; $FFFFE000
                moveq   #$00, D0
                move.w  #$0400, D1
Offset_0x034636:
                move.l  D0, (A1)+
                dbra    D1, Offset_0x034636
                lea     (Horizontal_Scroll_Buffer+$013C).w, A1       ; $FFFFE13C
                lea     Offset_0x034A08(PC), A2
                moveq   #$00, D0
                moveq   #$22, D6
Offset_0x034648:
                move.b  (A2)+, D0
                sub.w   D0, (A1)
                addq.w  #$08, A1
                dbra    D6, Offset_0x034648
Null_Sub_3:                                                    ; Offset_0x034652
                rts  
;-------------------------------------------------------------------------------
Offset_0x034654:
                subq.w  #$01, Obj_Timer(A0)                              ; $002E
                bmi.s   Offset_0x034676
                addi.w  #$0020, Obj_X(A0)                                ; $0010
                bsr     Offset_0x03470C
                lea     (Sonic_SEGA_Logo_Animate_Data), A1     ; Offset_0x03486E
                jsr     (AnimateSprite)                        ; Offset_0x01115E
                jmp     (DisplaySprite)                        ; Offset_0x011148
Offset_0x034676:
                addq.b  #$02, Obj_Routine(A0)                            ; $0005
                move.w  #$000C, Obj_Timer(A0)                            ; $002E
                move.b  #$01, Obj_Control_Var_00(A0)                     ; $0030
                move.b  #$FF, Obj_Control_Var_01(A0)                     ; $0031
                rts
;-------------------------------------------------------------------------------
Offset_0x03468E:
                tst.w   Obj_Timer(A0)                                    ; $002E
                beq.s   Offset_0x03469C
                subq.w  #$01, Obj_Timer(A0)                              ; $002E
                bsr     Offset_0x03470C
Offset_0x03469C:
                lea     Offset_0x0347E4(PC), A1
                bsr     Offset_0x034720
                bne.s   Offset_0x0346A8
                rts
Offset_0x0346A8:
                addq.b  #$02, Obj_Routine(A0)                            ; $0005
                st      (PalCycle_Done_Flag).w                       ; $FFFFF660
                move.b  #$FA, D0
                jsr     (Play_Music)                           ; Offset_0x001176
;-------------------------------------------------------------------------------                
Offset_0x0346BA:                
                rts                
;===============================================================================
; Objeto 0xB0 - Sonic correndo na tela SEGA
; <<<-
;===============================================================================                                                      