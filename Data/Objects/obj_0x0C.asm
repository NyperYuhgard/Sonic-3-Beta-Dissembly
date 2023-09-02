;===============================================================================
; Objeto 0x0C - Raiz em que o Sonic segura temporariamente e é lançado para 
; ->>>          esquerda ou para direita  
;===============================================================================      
; Offset_0x0180FE:
                move.l  A0, A1
                move.l  #Offset_0x0181C2, (A1)
                bsr     Offset_0x01819A
                move.b  #$21, Obj_Map_Id(A1)                             ; $0022
                move.w  Obj_X(A0), D2                                    ; $0010
                move.w  Obj_Y(A0), D3                                    ; $0014
                move.b  Obj_Subtype(A0), D1                              ; $002C
                andi.w  #$000F, D1
                jsr     (SingleObjectLoad_A0)                  ; Offset_0x011DE0
                bne     Offset_0x018198
                move.w  #$FE50, Obj_Height_3(A1)                         ; $0044
                move.w  #$0800, Obj_Control_Var_08(A1)                   ; $0038
                move.w  A1, Obj_Control_Var_0E(A0)                       ; $003E
                move.l  #Offset_0x0181FE, (A1)
                move.w  A0, Obj_Control_Var_0C(A1)                       ; $003C
                move.b  Obj_Subtype(A0), D0                              ; $002C
                andi.b  #$F0, D0
                move.b  D0, Obj_Control_Var_12(A1)                       ; $0042
                bra.s   Offset_0x01816A  
;-------------------------------------------------------------------------------
Offset_0x018152:
                jsr     (SingleObjectLoad_A0)                  ; Offset_0x011DE0
                bne     Offset_0x018198
                move.l  #Offset_0x018292, (A1)
                move.w  A2, Obj_Control_Var_0C(A1)                       ; $003C
                move.w  A1, Obj_Control_Var_0E(A2)                       ; $003E
Offset_0x01816A:
                move.l  A1, A2
                bsr.s   Offset_0x01819A
                move.w  D2, Obj_X(A1)                                    ; $0010
                move.w  D3, Obj_Y(A1)                                    ; $0014
                addi.w  #$0010, D3
                addq.w  #$01, Obj_Control_Var_06(A0)                     ; $0036
                move.w  Obj_Control_Var_06(A0), Obj_Control_Var_06(A1) ; $0036, $0036
                dbra    D1, Offset_0x018152
                move.l  #Offset_0x0182F2, (A1)
                move.b  #$20, Obj_Map_Id(A1)                             ; $0022
                move.w  A1, Obj_Control_Var_10(A0)                       ; $0040
Offset_0x018198:
                bra.s   Offset_0x0181C2
Offset_0x01819A:
                move.b  #$04, Obj_Flags(A1)                              ; $0004
                move.b  #$08, Obj_Width(A1)                              ; $0007
                move.b  #$08, Obj_Height(A1)                             ; $0006
                move.w  #$0200, Obj_Priority(A1)                         ; $0008
                move.l  #Ride_Vine_Mappings, Obj_Map(A1) ; Offset_0x018482, $000C
                move.w  #$0422, Obj_Art_VRAM(A1)                         ; $000A
                rts
Offset_0x0181C2:
                move.w  Obj_X(A0), D0                                    ; $0010
                andi.w  #$FF80, D0
                sub.w   (Camera_X_Left).w, D0                        ; $FFFFF7DA
                cmpi.w  #$0280, D0
                bhi     Offset_0x0181DC
                jmp     (DisplaySprite)                        ; Offset_0x011148
Offset_0x0181DC:
                move.w  Obj_Control_Var_06(A0), D2                       ; $0036
                subq.w  #$01, D2
                bcs.s   Offset_0x0181F8
                move.w  Obj_Control_Var_0E(A0), A2                       ; $003E
Offset_0x0181E8:
                move.l  A2, A1
                move.w  Obj_Control_Var_0E(A1), A2                       ; $003E
                jsr     (Delete_A1_Object)                     ; Offset_0x01113A
                dbra    D2, Offset_0x0181E8
Offset_0x0181F8:
                jmp     (DeleteObject)                         ; Offset_0x011138
;-------------------------------------------------------------------------------
Offset_0x0181FE:
                tst.b   (A0)
                bne.s   Offset_0x018230
                move.b  (Object_Frame_Angle).w, D0                   ; $FFFFFEAA
                add.b   Obj_Control_Var_12(A0), D0                       ; $0042
                jsr     (CalcSine)                             ; Offset_0x001B20
                muls.w  #$002C, D0
                move.w  D0, Obj_Angle(A0)                                ; $0026
                asr.w   #$03, D0
                move.w  D0, Obj_Control_Var_0A(A0)                       ; $003A
                move.b  Obj_Angle(A0), D0                                ; $0026
                addq.b  #$04, D0
                lsr.b   #$03, D0
                move.b  D0, Obj_Map_Id(A0)                               ; $0022
                jmp     (DisplaySprite)                        ; Offset_0x011148
Offset_0x018230:
                moveq   #$00, D2
                move.b  Obj_Control_Var_08(A0), D2                       ; $0038
                move.w  Obj_Height_3(A0), D0                             ; $0044
                move.w  #$0000, D1
                tst.w   Obj_Timer(A0)                                    ; $002E
                bne.s   Offset_0x01825C
                add.w   D2, D0
                move.w  D0, Obj_Height_3(A0)                             ; $0044
                add.w   D0, Obj_Control_Var_12(A0)                       ; $0042
                cmp.b   Obj_Control_Var_12(A0), D1                       ; $0042
                bgt.s   Offset_0x018272
                move.w  #$0001, Obj_Timer(A0)                            ; $002E
                bra.s   Offset_0x018272
Offset_0x01825C:
                sub.w   D2, D0
                move.w  D0, Obj_Height_3(A0)                             ; $0044
                add.w   D0, Obj_Control_Var_12(A0)                       ; $0042
                cmp.b   Obj_Control_Var_12(A0), D1                       ; $0042
                ble.s   Offset_0x018272
                move.w  #$0000, Obj_Timer(A0)                            ; $002E
Offset_0x018272:
                move.w  Obj_Control_Var_12(A0), D0                       ; $0042
                move.w  D0, Obj_Angle(A0)                                ; $0026
                asr.w   #$03, D0
                move.w  D0, Obj_Control_Var_0A(A0)                       ; $003A
                move.b  Obj_Angle(A0), D0                                ; $0026
                addq.b  #$04, D0
                lsr.b   #$03, D0
                move.b  D0, Obj_Map_Id(A0)                               ; $0022
                jmp     (DisplaySprite)                        ; Offset_0x011148   
;-------------------------------------------------------------------------------
Offset_0x018292:
                move.w  Obj_Control_Var_0C(A0), A1                       ; $003C
                move.w  Obj_Control_Var_0A(A1), Obj_Control_Var_0A(A0) ; $003A, $003A
                move.w  Obj_Angle(A1), D0                                ; $0026
                add.w   Obj_Control_Var_0A(A0), D0                       ; $003A
                move.w  D0, Obj_Angle(A0)                                ; $0026
                move.b  Obj_Angle(A0), D0                                ; $0026
                addq.b  #$04, D0
                lsr.b   #$03, D0
                move.b  D0, Obj_Map_Id(A0)                               ; $0022
                bsr     Offset_0x0182BE
                jmp     (DisplaySprite)                        ; Offset_0x011148
Offset_0x0182BE:
                move.w  Obj_Control_Var_0C(A0), A1                       ; $003C
                move.b  Obj_Angle(A1), D0                                ; $0026
                addq.b  #$04, D0
                andi.b  #$F8, D0
                jsr     (CalcSine)                             ; Offset_0x001B20
                neg.w   D0
                addi.w  #$0008, D0
                addi.w  #$0008, D1
                asr.w   #$04, D0
                asr.w   #$04, D1
                add.w   Obj_X(A1), D0                                    ; $0010
                move.w  D0, Obj_X(A0)                                    ; $0010
                add.w   Obj_Y(A1), D1                                    ; $0014
                move.w  D1, Obj_Y(A0)                                    ; $0014
                rts           
;-------------------------------------------------------------------------------
Offset_0x0182F2:
                move.w  Obj_X(A0), D4                                    ; $0010
                move.w  Obj_Y(A0), D5                                    ; $0014
                bsr     Offset_0x0182BE
                cmp.w   Obj_X(A0), D4                                    ; $0010
                beq.s   Offset_0x018308
                move.w  D4, Obj_Control_Var_12(A0)                       ; $0042
Offset_0x018308:
                cmp.w   Obj_Y(A0), D5                                    ; $0014
                beq.s   Offset_0x018312
                move.w  D5, Obj_Height_3(A0)                             ; $0044
Offset_0x018312:
                lea     Obj_Control_Var_02(A0), A2                       ; $0032
                lea     (Obj_Player_One).w, A1                       ; $FFFFB000
                move.w  (Control_Ports_Buffer_Data).w, D0            ; $FFFFF604
                bsr     Offset_0x017ECA
                tst.w   Obj_Control_Var_02(A0)                           ; $0032
                beq.s   Offset_0x01832E
                tst.w   Obj_Control_Var_00(A0)                           ; $0030
                bne.s   Offset_0x018334
Offset_0x01832E:
                jmp     (DisplaySprite)                        ; Offset_0x011148
Offset_0x018334:
                rts     
;-------------------------------------------------------------------------------
; Offset_0x018336:
                tst.b   (A2)
                beq     Offset_0x01840C
                tst.b   Obj_Flags(A1)                                    ; $0004
                bpl     Offset_0x0183AC
                cmpi.b  #$04, Obj_Routine(A1)                            ; $0005
                bcc.s   Offset_0x0183AC
                andi.b  #$70, D0
                beq     Offset_0x0183BA
                clr.b   Obj_Timer(A1)                                    ; $002E
                clr.b   (A2)
                move.w  Obj_X(A0), D1                                    ; $0010
                sub.w   D4, D1
                asl.w   #$07, D1
                move.w  D1, Obj_Speed_X(A1)                              ; $0018
                move.w  Obj_Y(A0), D1                                    ; $0014
                sub.w   D5, D1
                asl.w   #$07, D1
                move.w  D1, Obj_Speed_Y(A1)                              ; $001A
                move.b  #$12, $0002(A2)
                andi.w  #$0F00, D0
                beq     Offset_0x018386
                move.b  #$3C, $0002(A2)
Offset_0x018386:
                btst    #$0A, D0
                beq.s   Offset_0x018392
                move.w  #$FE00, Obj_Speed_X(A1)                          ; $0018
Offset_0x018392:
                btst    #$0B, D0
                beq.s   Offset_0x01839E
                move.w  #$0200, Obj_Speed_X(A1)                          ; $0018
Offset_0x01839E:
                addi.w  #$FC80, Obj_Speed_Y(A1)                          ; $001A
                bset    #$01, Obj_Status(A1)                             ; $002A
                rts
Offset_0x0183AC:
                clr.b   Obj_Timer(A1)                                    ; $002E
                clr.b   (A2)
                move.b  #$3C, $0002(A2)
                rts
Offset_0x0183BA:
                move.w  Obj_X(A0), Obj_X(A1)                      ; $0010, $0010
                move.w  Obj_Y(A0), Obj_Y(A1)                      ; $0014, $0014
                addi.w  #$0014, Obj_Y(A1)                                ; $0014
                move.w  Obj_Control_Var_0C(A0), A3                       ; $003C
                moveq   #$00, D0
                move.b  Obj_Angle(A3), D0                                ; $0026
                btst    #$00, Obj_Status(A1)                             ; $002A
                beq.s   Offset_0x0183E0
                neg.b   D0
Offset_0x0183E0:
                addq.b  #$08, D0
                lsr.w   #$04, D0
                move.b  Offset_0x0183FC(PC, D0), Obj_Map_Id(A1)          ; $0022
                moveq   #$00, D0
                move.b  Obj_Map_Id(A1), D0                               ; $0022
                move.l  A2, -(A7)
                jsr     (Load_Sonic_Dynamic_PLC_D0)            ; Offset_0x00C7F0
                move.l  (A7)+, A2
                rts    
;-------------------------------------------------------------------------------
Offset_0x0183FC:
                dc.b    $EF, $EE, $ED, $ED, $ED, $ED, $ED, $EE
                dc.b    $EF, $F0, $F1, $F1, $F1, $F1, $F1, $F0  
;-------------------------------------------------------------------------------
Offset_0x01840C:
                tst.b   $0002(A2)
                beq.s   Offset_0x01841A
                subq.b  #$01, $0002(A2)
                bne     Offset_0x018480
Offset_0x01841A:
                move.w  Obj_X(A1), D0                                    ; $0010
                sub.w   Obj_X(A0), D0                                    ; $0010
                addi.w  #$0010, D0
                cmpi.w  #$0020, D0
                bcc     Offset_0x018480
                move.w  Obj_Y(A1), D1                                    ; $0014
                sub.w   Obj_Y(A0), D1                                    ; $0014
                cmpi.w  #$0018, D1
                bcc     Offset_0x018480
                tst.b   Obj_Timer(A1)                                    ; $002E
                bmi.s   Offset_0x018480
                cmpi.b  #$04, Obj_Routine(A1)                            ; $0005
                bcc.s   Offset_0x018480
                tst.w   (Debug_Mode_Flag_Index).w                    ; $FFFFFE08
                bne.s   Offset_0x018480
                clr.w   Obj_Speed_X(A1)                                  ; $0018
                clr.w   Obj_Speed_Y(A1)                                  ; $001A
                clr.w   Obj_Inertia(A1)                                  ; $001C
                move.w  Obj_X(A0), Obj_X(A1)                      ; $0010, $0010
                move.w  Obj_Y(A0), Obj_Y(A1)                      ; $0014, $0014
                addi.w  #$0014, Obj_Y(A1)                                ; $0014
                move.b  #$23, Obj_Ani_Number(A1)                         ; $0020
                move.b  #$03, Obj_Timer(A1)                              ; $002E
                move.b  #$01, (A2)
Offset_0x018480:
                rts  
;-------------------------------------------------------------------------------
Ride_Vine_Mappings:                                            ; Offset_0x018482
                dc.w    Offset_0x0184C6-Ride_Vine_Mappings
                dc.w    Offset_0x0184CE-Ride_Vine_Mappings
                dc.w    Offset_0x0184D6-Ride_Vine_Mappings
                dc.w    Offset_0x0184DE-Ride_Vine_Mappings
                dc.w    Offset_0x0184E6-Ride_Vine_Mappings
                dc.w    Offset_0x0184EE-Ride_Vine_Mappings
                dc.w    Offset_0x0184F6-Ride_Vine_Mappings
                dc.w    Offset_0x0184FE-Ride_Vine_Mappings
                dc.w    Offset_0x018506-Ride_Vine_Mappings
                dc.w    Offset_0x01850E-Ride_Vine_Mappings
                dc.w    Offset_0x018516-Ride_Vine_Mappings
                dc.w    Offset_0x01851E-Ride_Vine_Mappings
                dc.w    Offset_0x018526-Ride_Vine_Mappings
                dc.w    Offset_0x01852E-Ride_Vine_Mappings
                dc.w    Offset_0x018536-Ride_Vine_Mappings
                dc.w    Offset_0x01853E-Ride_Vine_Mappings
                dc.w    Offset_0x018546-Ride_Vine_Mappings
                dc.w    Offset_0x01854E-Ride_Vine_Mappings
                dc.w    Offset_0x018556-Ride_Vine_Mappings
                dc.w    Offset_0x01855E-Ride_Vine_Mappings
                dc.w    Offset_0x018566-Ride_Vine_Mappings
                dc.w    Offset_0x01856E-Ride_Vine_Mappings
                dc.w    Offset_0x018576-Ride_Vine_Mappings
                dc.w    Offset_0x01857E-Ride_Vine_Mappings
                dc.w    Offset_0x018586-Ride_Vine_Mappings
                dc.w    Offset_0x01858E-Ride_Vine_Mappings
                dc.w    Offset_0x018596-Ride_Vine_Mappings
                dc.w    Offset_0x01859E-Ride_Vine_Mappings
                dc.w    Offset_0x0185A6-Ride_Vine_Mappings
                dc.w    Offset_0x0185AE-Ride_Vine_Mappings
                dc.w    Offset_0x0185B6-Ride_Vine_Mappings
                dc.w    Offset_0x0185BE-Ride_Vine_Mappings
                dc.w    Offset_0x0185C6-Ride_Vine_Mappings
                dc.w    Offset_0x0185CE-Ride_Vine_Mappings
Offset_0x0184C6:
                dc.w    $0001
                dc.w    $0001, $001B, $FFF8
Offset_0x0184CE:
                dc.w    $0001
                dc.w    $0001, $0019, $FFF8
Offset_0x0184D6:
                dc.w    $0001
                dc.w    $0001, $0017, $FFF8
Offset_0x0184DE:
                dc.w    $0001
                dc.w    $0005, $0013, $FFF0
Offset_0x0184E6:
                dc.w    $0001
                dc.w    $0005, $000F, $FFF0
Offset_0x0184EE:
                dc.w    $0001
                dc.w    $0005, $000B, $FFF0
Offset_0x0184F6:
                dc.w    $0001
                dc.w    $0004, $0009, $FFF0
Offset_0x0184FE:
                dc.w    $0001
                dc.w    $0004, $0007, $FFF0
Offset_0x018506:
                dc.w    $0001
                dc.w    $0004, $0005, $FFF0
Offset_0x01850E:
                dc.w    $0001
                dc.w    $F904, $1007, $FFF0
Offset_0x018516:
                dc.w    $0001
                dc.w    $F904, $1009, $FFF0
Offset_0x01851E:
                dc.w    $0001
                dc.w    $F105, $100B, $FFF0
Offset_0x018526:
                dc.w    $0001
                dc.w    $F105, $100F, $FFF0
Offset_0x01852E:
                dc.w    $0001
                dc.w    $F105, $1013, $FFF0
Offset_0x018536:
                dc.w    $0001
                dc.w    $F101, $1017, $FFF8
Offset_0x01853E:
                dc.w    $0001
                dc.w    $F101, $1019, $FFF8
Offset_0x018546:
                dc.w    $0001
                dc.w    $F101, $101B, $FFF8
Offset_0x01854E:
                dc.w    $0001
                dc.w    $F101, $1819, $FFFF
Offset_0x018556:
                dc.w    $0001
                dc.w    $F101, $1817, $FFFF
Offset_0x01855E:
                dc.w    $0001
                dc.w    $F105, $1813, $FFFF
Offset_0x018566:
                dc.w    $0001
                dc.w    $F105, $180F, $FFFF
Offset_0x01856E:
                dc.w    $0001
                dc.w    $F105, $180B, $FFFF
Offset_0x018576:
                dc.w    $0001
                dc.w    $F904, $1809, $FFFF
Offset_0x01857E:
                dc.w    $0001
                dc.w    $F904, $1807, $FFFF
Offset_0x018586:
                dc.w    $0001
                dc.w    $0004, $0805, $FFFF
Offset_0x01858E:
                dc.w    $0001
                dc.w    $0004, $0807, $FFFF
Offset_0x018596:
                dc.w    $0001
                dc.w    $0004, $0809, $FFFF
Offset_0x01859E:
                dc.w    $0001
                dc.w    $0005, $080B, $FFFF
Offset_0x0185A6:
                dc.w    $0001
                dc.w    $0005, $080F, $FFFF
Offset_0x0185AE:
                dc.w    $0001
                dc.w    $0005, $0813, $FFFF
Offset_0x0185B6:
                dc.w    $0001
                dc.w    $0001, $0817, $FFFF
Offset_0x0185BE:
                dc.w    $0001
                dc.w    $0001, $0819, $FFFF
Offset_0x0185C6:
                dc.w    $0001
                dc.w    $FC08, $0000, $FFF4
Offset_0x0185CE:
                dc.w    $0001
                dc.w    $FC04, $0003, $FFF8                                                                                                                                         
;===============================================================================
; Objeto 0x0C - Raiz em que o Sonic segura temporariamente e é lançado para 
; <<<-          esquerda ou para direita  
;===============================================================================  