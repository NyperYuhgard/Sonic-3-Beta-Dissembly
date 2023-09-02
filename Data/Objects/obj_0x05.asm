;===============================================================================
; Objeto 0x05 - Pedra na Angel Island / Endless Mine
; ->>>
;===============================================================================
Offset_0x0150F4:
                dc.b    $18, $27, $18, $17, $18, $0F, $0E, $0F
;-------------------------------------------------------------------------------
Obj_0x05_Rock:                                                 ; Offset_0x0150FC
                moveq   #$00, D0
                move.b  Obj_Subtype(A0), D0                              ; $002C
                lsr.w   #$04, D0
                move.b  D0, Obj_Map_Id(A0)                               ; $0022
                add.w   D0, D0
                move.b  Offset_0x0150F4(PC, D0), Obj_Width(A0)           ; $0007
                move.b  Offset_0x0150F4+$01(PC, D0), D1
                move.b  D1, Obj_Height(A0)                               ; $0006
                move.b  D1, Obj_Height_2(A0)                             ; $001E
                move.l  #Rock_Mappings, Obj_Map(A0)     ; Offset_0x0156EE, $000C
                move.w  #$2333, Obj_Art_VRAM(A0)                         ; $000A
                ori.b   #$04, Obj_Flags(A0)                              ; $0004
                move.w  #$0200, Obj_Priority(A0)                         ; $0008
                move.w  #$0040, Obj_Control_Var_12(A0)                   ; $0042
                cmpi.w  #AIz_Act_2, (Level_Id).w              ; $0001, $FFFFFE10
                bne.s   Offset_0x015152
                move.l  #AIz_2_Rock_Mappings, Obj_Map(A0) ; Offset_0x015776, $000C
                move.w  #$42F0, Obj_Art_VRAM(A0)                         ; $000A
Offset_0x015152:
                cmpi.w  #EMz_Act_1, (Level_Id).w              ; $1200, $FFFFFE10
                bne.s   Offset_0x01516E
                move.l  #EMz_Rock_Mappings, Obj_Map(A0) ; Offset_0x0157FE, $000C
                move.w  #$E300, Obj_Art_VRAM(A0)                         ; $000A
                move.b  #$00, Obj_Map_Id(A0)                             ; $0022
Offset_0x01516E:
                move.l  #Offset_0x015186, (A0)
                btst    #$02, Obj_Subtype(A0)                            ; $002C
                beq.s   Offset_0x015186
                move.l  #Offset_0x015350, (A0)
                bra     Offset_0x015350
Offset_0x015186:
                move.w  (Enemy_Hit_Chain_Count).w, Obj_Control_Var_08(A0) ; $FFFFF7D0, $0038
                move.b  (Obj_Player_One+Obj_Ani_Number).w, Obj_Control_Var_02(A0) ; $FFFFB020, $0032
                move.b  (Obj_Player_Two+Obj_Ani_Number).w, Obj_Control_Var_03(A0) ; $FFFFB06A, $0033
                move.b  (Obj_Player_One+Obj_Status).w, Obj_Control_Var_0A(A0) ; $FFFFB02A, $003A
                move.b  (Obj_Player_Two+Obj_Status).w, Obj_Control_Var_0B(A0) ; $FFFFB074, $003B
                moveq   #$00, D1
                move.b  Obj_Width(A0), D1                                ; $0007
                addi.w  #$000B, D1
                moveq   #$00, D2
                move.b  Obj_Height(A0), D2                               ; $0006
                move.w  D2, D3
                addq.w  #$01, D3
                move.w  Obj_X(A0), D4                                    ; $0010
                jsr     (Solid_Object)                         ; Offset_0x013556
                btst    #$01, Obj_Subtype(A0)                            ; $002C
                beq.s   Offset_0x0151CE
                bsr     Offset_0x015500
Offset_0x0151CE:
                btst    #$00, Obj_Subtype(A0)                            ; $002C
                beq.s   Offset_0x0151E0
                move.b  Obj_Status(A0), D0                               ; $002A
                andi.b  #$18, D0
                bne.s   Offset_0x0151F2
Offset_0x0151E0:
                tst.w   (Two_Player_Flag).w                          ; $FFFFFFD8
                bne.s   Offset_0x0151EC
                jmp     (MarkObjGone)                          ; Offset_0x011AF2
Offset_0x0151EC:
                jmp     (DisplaySprite)                        ; Offset_0x011148
Offset_0x0151F2:
                cmpi.b  #$18, D0
                bne.s   Offset_0x015220
                cmpi.b  #$02, Obj_Control_Var_02(A0)                     ; $0032
                beq.s   Offset_0x015208
                cmpi.b  #$02, Obj_Control_Var_03(A0)                     ; $0033
                bne.s   Offset_0x0151E0
Offset_0x015208:
                lea     (Obj_Player_One).w, A1                       ; $FFFFB000
                move.b  Obj_Control_Var_02(A0), D0                       ; $0032
                bsr.s   Offset_0x015238
                lea     (Obj_Player_Two).w, A1                       ; $FFFFB04A
                move.b  Obj_Control_Var_03(A0), D0                       ; $0033
                bsr.s   Offset_0x015238
                bra     Offset_0x015288
Offset_0x015220:
                move.b  D0, D1
                andi.b  #$08, D1
                beq.s   Offset_0x015270
                cmpi.b  #$02, Obj_Control_Var_02(A0)                     ; $0032
                bne.s   Offset_0x0151E0
                lea     (Obj_Player_One).w, A1                       ; $FFFFB000
                bsr.s   Offset_0x01523E
                bra.s   Offset_0x015288
Offset_0x015238:
                cmpi.b  #$02, D0
                bne.s   Offset_0x01525C
Offset_0x01523E:
                bset    #$02, Obj_Status(A1)                             ; $002A
                move.b  #$0E, Obj_Height_2(A1)                           ; $001E
                move.b  #$07, Obj_Width_2(A1)                            ; $001F
                move.b  #$02, Obj_Ani_Number(A1)                         ; $0020
                move.w  #$FD00, Obj_Speed_Y(A1)                          ; $001A
Offset_0x01525C:
                bset    #$01, Obj_Status(A1)                             ; $002A
                bclr    #$03, Obj_Status(A1)                             ; $002A
                move.b  #$02, Obj_Routine(A1)                            ; $0005
                rts
Offset_0x015270:
                andi.b  #$10, D0
                beq     Offset_0x0151E0
                cmpi.b  #$02, Obj_Control_Var_03(A0)                     ; $0033
                bne     Offset_0x0151E0
                lea     (Obj_Player_Two).w, A1                       ; $FFFFB04A
                bsr.s   Offset_0x01523E
Offset_0x015288:
                move.w  Obj_Control_Var_08(A0), (Enemy_Hit_Chain_Count).w ; $0038, $FFFFF7D0
                andi.b  #$E7, Obj_Status(A0)                             ; $002A
                tst.w   (Two_Player_Flag).w                          ; $FFFFFFD8
                bne     Offset_0x0152E4
                move.l  #Offset_0x0152A6, (A0)
                bsr     Offset_0x015564
;-------------------------------------------------------------------------------                
Offset_0x0152A6:                
                subq.b  #$01, Obj_Ani_Time(A0)                           ; $0024
                bpl.s   Offset_0x0152C4
                move.b  #$02, Obj_Ani_Time(A0)                           ; $0024
                move.b  Obj_Map_Id(A0), D0                               ; $0022
                addq.b  #$01, D0
                cmpi.b  #$07, D0
                bcs.s   Offset_0x0152C0
                moveq   #$03, D0
Offset_0x0152C0:
                move.b  D0, Obj_Map_Id(A0)                               ; $0022
Offset_0x0152C4:
                jsr     (SpeedToPos)                           ; Offset_0x01111E
                addi.w  #$0018, Obj_Speed_Y(A0)                          ; $001A
                tst.b   Obj_Flags(A0)                                    ; $0004
                bpl     Offset_0x0152DE
                jmp     (DisplaySprite)                        ; Offset_0x011148
Offset_0x0152DE:
                jmp     (DeleteObject)                         ; Offset_0x011138
Offset_0x0152E4:
                bsr.s   Offset_0x015310
                move.b  #$03, Obj_Map_Id(A0)                             ; $0022
                move.l  #Offset_0x0152F6, (A0)
                bsr     Offset_0x015564
;-------------------------------------------------------------------------------                
Offset_0x0152F6:                
                jsr     (SpeedToPos)                           ; Offset_0x01111E
                addi.w  #$0018, Obj_Speed_Y(A0)                          ; $001A
                tst.b   Obj_Flags(A0)                                    ; $0004
                bpl     Offset_0x0152DE
                jmp     (DisplaySprite)                        ; Offset_0x011148
Offset_0x015310:
                jsr     (SingleObjectLoad_A0)                  ; Offset_0x011DE0
                bne     Offset_0x015338
                moveq   #$48, D0
Offset_0x01531C:
                move.w  $00(A0, D0), $00(A1, D0)
                subq.w  #$02, D0
                bcc.s   Offset_0x01531C
                move.l  (A0), Obj_Height_3(A1)                           ; $0044
                move.l  #Offset_0x01533A, (A1)
                move.b  #$07, Obj_Map_Id(A1)                             ; $0022
                moveq   #$00, D0
Offset_0x015338:
                rts                                                             
;-------------------------------------------------------------------------------
Offset_0x01533A:
                tst.b   Obj_Flags(A0)                                    ; $0004
                bmi.s   Offset_0x01534A
                move.l  Obj_Height_3(A0), (A0)                           ; $0044
                move.b  #$00, Obj_Map_Id(A0)                             ; $0022
Offset_0x01534A:
                jmp     (DisplaySprite)                        ; Offset_0x011148  
;-------------------------------------------------------------------------------
Offset_0x015350:
                move.w  (Obj_Player_One+Obj_Speed_X).w, Obj_Control_Var_00(A0) ; $FFFFB018, $0030
                move.w  (Obj_Player_Two+Obj_Speed_X).w, Obj_Control_Var_06(A0) ; $FFFFB062, $0036
                moveq   #$00, D1
                move.b  Obj_Width(A0), D1                                ; $0007
                addi.w  #$000B, D1
                moveq   #$00, D2
                move.b  Obj_Height(A0), D2                               ; $0006
                move.w  D2, D3
                addq.w  #$01, D3
                move.w  Obj_X(A0), D4                                    ; $0010
                bsr     Solid_Object                           ; Offset_0x013556
                move.b  Obj_Status(A0), D0                               ; $002A
                andi.b  #$60, D0
                bne.s   Offset_0x015394
Offset_0x015382:
                tst.w   (Two_Player_Flag).w                          ; $FFFFFFD8
                bne.s   Offset_0x01538E
                jmp     (MarkObjGone)                          ; Offset_0x011AF2
Offset_0x01538E:
                jmp     (DisplaySprite)                        ; Offset_0x011148
Offset_0x015394:
                lea     (Obj_Player_One).w, A1                       ; $FFFFB000
                move.w  Obj_Control_Var_00(A0), D1                       ; $0030
                btst    #$05, Obj_Status(A0)                             ; $002A
                beq.s   Offset_0x0153FE
                cmpi.b  #$02, Obj_Control_Var_08(A1)                     ; $0038
                beq.s   Offset_0x0153C0
                cmpi.b  #$02, Obj_Ani_Number(A1)                         ; $0020
                bne.s   Offset_0x0153FE
                move.w  D1, D0
                bpl.s   Offset_0x0153BA
                neg.w   D0
Offset_0x0153BA:
                cmpi.w  #$0480, D0
                bcs.s   Offset_0x0153FE
Offset_0x0153C0:
                bclr    #$05, Obj_Status(A0)                             ; $002A
                bsr.s   Offset_0x015436
                btst    #$06, Obj_Status(A0)                             ; $002A
                beq.s   Offset_0x015382
                lea     (Obj_Player_Two).w, A1                       ; $FFFFB04A
                cmpi.b  #$02, Obj_Control_Var_08(A1)                     ; $0038
                beq.s   Offset_0x0153E4
                cmpi.b  #$02, Obj_Ani_Number(A1)                         ; $0020
                bne.s   Offset_0x015382
Offset_0x0153E4:
                move.w  Obj_Control_Var_06(A0), Obj_Speed_X(A1)   ; $0036, $0018
                move.w  Obj_Speed_X(A1), Obj_Inertia(A1)          ; $0018, $001C
                bclr    #$06, Obj_Status(A0)                             ; $002A
                bclr    #$05, Obj_Status(A1)                             ; $002A
                bra.s   Offset_0x015382
Offset_0x0153FE:
                lea     (Obj_Player_Two).w, A1                       ; $FFFFB04A
                move.w  Obj_Control_Var_06(A0), D1                       ; $0036
                btst    #$06, Obj_Status(A0)                             ; $002A
                beq     Offset_0x015382
                cmpi.b  #$02, Obj_Control_Var_08(A1)                     ; $0038
                beq.s   Offset_0x015430
                cmpi.b  #$02, Obj_Ani_Number(A1)                         ; $0020
                bne     Offset_0x015382
                move.w  D1, D0
                bpl.s   Offset_0x015428
                neg.w   D0
Offset_0x015428:
                cmpi.w  #$0480, D0
                bcs     Offset_0x015382
Offset_0x015430:
                bclr    #$06, Obj_Status(A0)                             ; $002A
Offset_0x015436:
                bsr     Offset_0x0154D6
                tst.w   (Two_Player_Flag).w                          ; $FFFFFFD8
                bne.s   Offset_0x015486
                move.w  D1, Obj_Speed_X(A1)                              ; $0018
                addq.w  #$04, Obj_X(A1)                                  ; $0010
                lea     (Offset_0x015642), A4
                move.w  Obj_X(A0), D0                                    ; $0010
                cmp.w   Obj_X(A1), D0                                    ; $0010
                bcs.s   Offset_0x015464
                subi.w  #$0008, Obj_X(A1)                                ; $0010
                lea     (Offset_0x015662), A4
Offset_0x015464:
                move.w  Obj_Speed_X(A1), Obj_Inertia(A1)          ; $0018, $001C
                bclr    #$05, Obj_Status(A1)                             ; $002A
                move.l  #Offset_0x0152A6, (A0)
                moveq   #$00, D0
                move.b  Obj_Map_Id(A0), D0                               ; $0022
                add.w   D0, D0
                bsr     Offset_0x015576
                bra     Offset_0x0152A6
Offset_0x015486:
                move.w  D1, Obj_Speed_X(A1)                              ; $0018
                addq.w  #$04, Obj_X(A1)                                  ; $0010
                lea     (Offset_0x0156BE), A4
                move.w  Obj_X(A0), D0                                    ; $0010
                cmp.w   Obj_X(A1), D0                                    ; $0010
                bcs.s   Offset_0x0154AA
                subi.w  #$0008, Obj_X(A1)                                ; $0010
                lea     (Offset_0x0156D6), A4
Offset_0x0154AA:
                move.w  Obj_Speed_X(A1), Obj_Inertia(A1)          ; $0018, $001C
                bclr    #$05, Obj_Status(A1)                             ; $002A
                bsr     Offset_0x015310
                move.l  #Offset_0x0152F6, (A0)
                move.b  #$03, Obj_Map_Id(A0)                             ; $0022
                moveq   #$00, D0
                move.b  Obj_Map_Id(A0), D0                               ; $0022
                add.w   D0, D0
                bsr     Offset_0x015576
                bra     Offset_0x0152F6
Offset_0x0154D6:
                bclr    #$03, Obj_Status(A0)                             ; $002A
                beq.s   Offset_0x0154EA
                bset    #$01, (Obj_Player_One+Obj_Status).w          ; $FFFFB02A
                bclr    #$03, (Obj_Player_One+Obj_Status).w          ; $FFFFB02A
Offset_0x0154EA:
                bclr    #$04, Obj_Status(A0)                             ; $002A
                beq.s   Offset_0x0154FE
                bset    #$01, (Obj_Player_Two+Obj_Status).w          ; $FFFFB074
                bclr    #$03, (Obj_Player_Two+Obj_Status).w          ; $FFFFB074
Offset_0x0154FE:
                rts                     
;-------------------------------------------------------------------------------
Offset_0x015500:
                move.b  Obj_Status(A0), D3                               ; $002A
                andi.b  #$60, D3
                beq     Offset_0x015528
                move.w  Obj_X(A0), D2                                    ; $0010
                lea     (Obj_Player_One).w, A1                       ; $FFFFB000
                move.b  Obj_Control_Var_0A(A0), D0                       ; $003A
                moveq   #$05, D6
                bsr.s   Offset_0x01552A
                lea     (Obj_Player_Two).w, A1                       ; $FFFFB04A
                move.b  Obj_Control_Var_0B(A0), D0                       ; $003B
                moveq   #$06, D6
                bsr.s   Offset_0x01552A
Offset_0x015528:
                rts
Offset_0x01552A:
                btst    D6, D3
                beq.s   Offset_0x015562
                cmp.w   Obj_X(A1), D2                                    ; $0010
                bcc.s   Offset_0x015562
                btst    #$05, D0
                beq.s   Offset_0x015562
                subq.w  #$01, Obj_Control_Var_10(A0)                     ; $0040
                bpl.s   Offset_0x015562
                move.w  #$0010, Obj_Control_Var_10(A0)                   ; $0040
                tst.w   Obj_Control_Var_12(A0)                           ; $0042
                beq.s   Offset_0x015562
                subq.w  #$01, Obj_Control_Var_12(A0)                     ; $0042
                subq.w  #$01, Obj_X(A0)                                  ; $0010
                subq.w  #$01, Obj_X(A1)                                  ; $0010
                jsr     (ObjHitFloor)                          ; Offset_0x009D84
                add.w   D1, Obj_Y(A0)                                    ; $0014
Offset_0x015562:
                rts                           
;-------------------------------------------------------------------------------    
Offset_0x015564:
                moveq   #$00, D0
                move.b  Obj_Map_Id(A0), D0                               ; $0022
                add.w   D0, D0
                lea     (Offset_0x01563A), A4
                adda.w  $00(A4, D0), A4
Offset_0x015576:
                lea     (Offset_0x0155FC), A3
                adda.w  $00(A3, D0), A3
                move.w  (A3)+, D1
                move.l  (A0), D4
                move.b  Obj_Flags(A0), D5                                ; $0004
                move.w  Obj_X(A0), D2                                    ; $0010
                move.w  Obj_Y(A0), D3                                    ; $0014
                moveq   #$03, D6
                move.l  A0, A1
                bra.s   Offset_0x01559C
;-------------------------------------------------------------------------------
Offset_0x015596:
                bsr     SingleObjectLoad_A0                    ; Offset_0x011DE0
                bne.s   Offset_0x0155F4
Offset_0x01559C:
                move.l  D4, (A1)
                move.l  Obj_Map(A0), Obj_Map(A1)                  ; $000C, $000C
                move.b  D5, Obj_Flags(A1)                                ; $0004
                move.b  (A3)+, D0
                ext.w   D0
                add.w   D2, D0
                move.w  D0, Obj_X(A1)                                    ; $0010
                move.b  (A3)+, D0
                ext.w   D0
                add.w   D3, D0
                move.w  D0, Obj_Y(A1)                                    ; $0014
                move.w  Obj_Art_VRAM(A0), Obj_Art_VRAM(A1)        ; $000A, $000A
                ori.w   #$8000, Obj_Art_VRAM(A1)                         ; $000A
                move.w  #$0080, Obj_Priority(A1)                         ; $0008
                move.b  #$18, Obj_Width(A1)                              ; $0007
                move.b  #$18, Obj_Width(A1)                              ; $0007
                move.w  (A4)+, Obj_Speed_X(A1)                           ; $0018
                move.w  (A4)+, Obj_Speed_Y(A1)                           ; $001A
                move.b  D6, Obj_Map_Id(A1)                               ; $0022
                addq.b  #$01, D6
                cmpi.b  #$07, D6
                bcs.s   Offset_0x0155F0
                moveq   #$03, D6
Offset_0x0155F0:
                dbra    D1, Offset_0x015596
Offset_0x0155F4:
                moveq   #Smash_Sfx, D0                                     ; $62
                jmp     (Play_Music)                           ; Offset_0x001176     
;-------------------------------------------------------------------------------   
Offset_0x0155FC:
                dc.w    Offset_0x015604-Offset_0x0155FC
                dc.w    Offset_0x015616-Offset_0x0155FC
                dc.w    Offset_0x015622-Offset_0x0155FC
                dc.w    Offset_0x01562C-Offset_0x0155FC
Offset_0x015604:
                dc.b    $00, $07, $F8, $E8, $0B, $E4, $FC, $F4
                dc.b    $0C, $FC, $F4, $04, $04, $0C, $F4, $1C
                dc.b    $0C, $1C
Offset_0x015616:
                dc.b    $00, $04, $FC, $F4, $0B, $F4, $FC, $FC
                dc.b    $F4, $0C, $0C, $0C
Offset_0x015622:
                dc.b    $00, $03, $FC, $FC, $0C, $FC, $F4, $04
                dc.b    $0C, $04
Offset_0x01562C:
                dc.b    $00, $05, $F8, $F8, $08, $F8, $F8, $00
                dc.b    $08, $00, $F8, $08, $08, $08                                                                     
;-------------------------------------------------------------------------------  
Offset_0x01563A:    
                dc.w    $0008, $0048, $005C, $006C
;-------------------------------------------------------------------------------  
Offset_0x015642:
                dc.w    $FD00, $FD00, $FD40, $FD80, $FD40, $FD80, $FD80, $FE00
                dc.w    $FD80, $FE80, $FDC0, $FE80, $FDC0, $FF00, $FE00, $FF00                                                                
;-------------------------------------------------------------------------------
Offset_0x015662:  
                dc.w    $0300, $FD00, $02C0, $FD80, $02C0, $FD80, $0280, $FE00
                dc.w    $0280, $FE80, $0240, $FE80, $0240, $FF00, $0200, $FF00
                dc.w    $FE00, $FE00, $0200, $FE00, $FF00, $FE20, $FE50, $FE40
                dc.w    $01C0, $FE40, $FF00, $FE00, $0100, $FE20, $FE50, $FE40
                dc.w    $01C0, $FE40, $FF50, $FE20, $00B0, $FE30, $FF80, $FE00
                dc.w    $0080, $FE20, $FF28, $FE40, $00E0, $FE40
;-------------------------------------------------------------------------------  
Offset_0x0156BE:      
                dc.w    $FD40, $FD80, $FD80, $FE00, $FD80, $FE80, $FDC0, $FE80
                dc.w    $FDC0, $FF00, $FE00, $FF00
;-------------------------------------------------------------------------------  
Offset_0x0156D6:    
                dc.w    $02C0, $FD80, $0280, $FE00, $0280, $FE80, $0240, $FE80
                dc.w    $0240, $FF00, $0200, $FF00
;-------------------------------------------------------------------------------
Rock_Mappings:                                                 ; Offset_0x0156EE
                dc.w    Offset_0x0156FC-Rock_Mappings
                dc.w    Offset_0x015722-Rock_Mappings
                dc.w    Offset_0x01573C-Rock_Mappings
                dc.w    Offset_0x015756-Rock_Mappings
                dc.w    Offset_0x01575E-Rock_Mappings
                dc.w    Offset_0x015766-Rock_Mappings
                dc.w    Offset_0x01576E-Rock_Mappings
Offset_0x0156FC:
                dc.w    $0006
                dc.w    $D80B, $0000, $FFE8
                dc.w    $D80B, $000C, $0000
                dc.w    $F80B, $0018, $FFE8
                dc.w    $F80B, $0024, $0000
                dc.w    $1809, $0030, $FFE8
                dc.w    $1809, $0036, $0000
Offset_0x015722:
                dc.w    $0004
                dc.w    $E80B, $0000, $FFE8
                dc.w    $E80B, $000C, $0000
                dc.w    $0809, $003C, $FFE8
                dc.w    $0809, $0042, $0000
Offset_0x01573C:
                dc.w    $0004
                dc.w    $F009, $0048, $FFF0
                dc.w    $F005, $004E, $0008
                dc.w    $0009, $003C, $FFE8
                dc.w    $0009, $0042, $0000
Offset_0x015756:
                dc.w    $0001
                dc.w    $F40A, $0052, $FFF4
Offset_0x01575E:
                dc.w    $0001
                dc.w    $F40A, $005B, $FFF4
Offset_0x015766:
                dc.w    $0001
                dc.w    $F20A, $0852, $FFF4
Offset_0x01576E:
                dc.w    $0001
                dc.w    $F40A, $085B, $FFF4
;-------------------------------------------------------------------------------
AIz_2_Rock_Mappings:                                           ; Offset_0x015776
                dc.w    Offset_0x015784-AIz_2_Rock_Mappings
                dc.w    Offset_0x0157AA-AIz_2_Rock_Mappings
                dc.w    Offset_0x0157C4-AIz_2_Rock_Mappings
                dc.w    Offset_0x0157DE-AIz_2_Rock_Mappings
                dc.w    Offset_0x0157E6-AIz_2_Rock_Mappings
                dc.w    Offset_0x0157EE-AIz_2_Rock_Mappings
                dc.w    Offset_0x0157F6-AIz_2_Rock_Mappings
Offset_0x015784:
                dc.w    $0006
                dc.w    $D80B, $0072, $FFE8
                dc.w    $D80B, $007E, $0000
                dc.w    $F80B, $008A, $FFE8
                dc.w    $F80B, $0096, $0000
                dc.w    $1809, $00A2, $FFE8
                dc.w    $1809, $00A8, $0000
Offset_0x0157AA:
                dc.w    $0004
                dc.w    $E80B, $0072, $FFE8
                dc.w    $E80B, $007E, $0000
                dc.w    $0809, $00AE, $FFE8
                dc.w    $0809, $00B4, $0000
Offset_0x0157C4:
                dc.w    $0004
                dc.w    $F009, $00BA, $FFF0
                dc.w    $F005, $00C0, $0008
                dc.w    $0009, $00AE, $FFE8
                dc.w    $0009, $00B4, $0000
Offset_0x0157DE:
                dc.w    $0001
                dc.w    $F40A, $00C4, $FFF4
Offset_0x0157E6:
                dc.w    $0001
                dc.w    $F40A, $00CD, $FFF4
Offset_0x0157EE:
                dc.w    $0001
                dc.w    $F20A, $08C4, $FFF4
Offset_0x0157F6:
                dc.w    $0001
                dc.w    $F40A, $08CD, $FFF4 
;-------------------------------------------------------------------------------   
EMz_Rock_Mappings:                                             ; Offset_0x0157FE
                dc.w    Offset_0x01580E-EMz_Rock_Mappings
                dc.w    Offset_0x015816-EMz_Rock_Mappings
                dc.w    Offset_0x01581E-EMz_Rock_Mappings
                dc.w    Offset_0x015816-EMz_Rock_Mappings
                dc.w    Offset_0x01581E-EMz_Rock_Mappings
                dc.w    Offset_0x015816-EMz_Rock_Mappings
                dc.w    Offset_0x01581E-EMz_Rock_Mappings
                dc.w    Offset_0x015826-EMz_Rock_Mappings
Offset_0x01580E:
                dc.w    $0001
                dc.w    $F00F, $000E, $FFF0
Offset_0x015816:
                dc.w    $0001
                dc.w    $F805, $001E, $FFF8
Offset_0x01581E:
                dc.w    $0001
                dc.w    $F805, $0022, $FFF8
Offset_0x015826:
                dc.w    $0001
                dc.w    $FC00, $FD00, $FFFC                                                                                                                                                                                                                                                                                                                                                                                                                                                                    
;===============================================================================
; Objeto 0x05 - Pedra na Angel Island / Endless Mine
; <<<- 
;===============================================================================