;===============================================================================
; Objeto 0x2C - Ponte que desmorona na Angel Island
; ->>>           
;===============================================================================
; Offset_0x021F0C:
                move.b  Obj_Subtype(A0), D0                              ; $002C
                bmi     Offset_0x021FD8
                move.b  D0, Obj_Control_Var_06(A0)                       ; $0036
                addi.b  #$30, D0
                move.b  D0, Obj_Control_Var_05(A0)                       ; $0035
                move.b  #$08, Obj_Control_Var_07(A0)                     ; $0037
                move.l  #Collapsing_Bridge_Mappings, Obj_Map(A0) ; Offset_0x0222A2, $000C
                move.w  #$42F0, Obj_Art_VRAM(A0)                         ; $000A
                move.b  #$5A, Obj_Width(A0)                              ; $0007
                move.b  #$08, Obj_Height(A0)                             ; $0006
                move.b  #$04, Obj_Flags(A0)                              ; $0004
                move.w  #$0200, Obj_Priority(A0)                         ; $0008
                jsr     (AllocateObjectAfterCurrent)                  ; Offset_0x011DE0
                bne     Offset_0x021FCE
                move.l  #Offset_0x0220E4, (A1)
                move.l  #Collapsing_Bridge_Mappings, Obj_Map(A1) ; Offset_0x0222A2, $000C
                move.w  #$42F0, Obj_Art_VRAM(A1)                         ; $000A
                ori.b   #$04, Obj_Flags(A1)                              ; $0004
                move.b  #$5A, Obj_Width(A1)                              ; $0007
                move.b  #$08, Obj_Height(A1)                             ; $0006
                move.w  #$0200, Obj_Priority(A1)                         ; $0008
                move.w  Obj_X(A0), Obj_X(A1)                      ; $0010, $0010
                move.w  Obj_Y(A0), Obj_Y(A1)                      ; $0014, $0014
                bset    #$06, Obj_Flags(A1)                              ; $0004
                move.w  #$0006, Obj_Sub_Y(A1)                            ; $0016
                move.w  Obj_Y(A0), D2                                    ; $0014
                move.w  Obj_X(A0), D3                                    ; $0010
                subi.w  #$004B, D3
                lea     Obj_Speed_X(A1), A2                              ; $0018
                move.w  Obj_Sub_Y(A1), D6                                ; $0016
                subq.w  #$01, D6
                move.w  #$0001, Obj_Flags(A2)                            ; $0004
Offset_0x021FB6:
                move.w  D3, (A2)+
                move.w  D2, (A2)+
                addq.w  #$02, A2
                addi.w  #$001E, D3
                dbra    D6, Offset_0x021FB6
                move.w  #$0002, -2(A2)
                move.w  A1, Obj_Control_Var_0C(A0)                       ; $003C
Offset_0x021FCE:
                move.l  #Offset_0x0220A0, (A0)
                bra     Offset_0x0220A0
Offset_0x021FD8:
                andi.b  #$7F, D0
                move.b  D0, Obj_Control_Var_06(A0)                       ; $0036
                addi.b  #$30, D0
                move.b  D0, Obj_Control_Var_05(A0)                       ; $0035
                move.b  #$08, Obj_Control_Var_07(A0)                     ; $0037
                move.l  #Collapsing_Bridge_Mappings_2, Obj_Map(A0) ; Offset_0x0222C4, $000C
                move.w  #$C2F0, Obj_Art_VRAM(A0)                         ; $000A
                move.b  #$60, Obj_Width(A0)                              ; $0007
                move.b  #$08, Obj_Height(A0)                             ; $0006
                move.b  #$04, Obj_Flags(A0)                              ; $0004
                move.w  #$0200, Obj_Priority(A0)                         ; $0008
                jsr     (AllocateObjectAfterCurrent)                  ; Offset_0x011DE0
                bne     Offset_0x022096
                move.l  #Offset_0x0220E4, (A1)
                move.l  #Collapsing_Bridge_Mappings_2, Obj_Map(A1) ; Offset_0x0222C4, $000C
                move.w  #$C2F0, Obj_Art_VRAM(A1)                         ; $000A
                ori.b   #$04, Obj_Flags(A1)                              ; $0004
                move.b  #$60, Obj_Width(A1)                              ; $0007
                move.b  #$08, Obj_Height(A1)                             ; $0006
                move.w  #$0200, Obj_Priority(A1)                         ; $0008
                move.w  Obj_X(A0), Obj_X(A1)                      ; $0010, $0010
                move.w  Obj_Y(A0), Obj_Y(A1)                      ; $0014, $0014
                bset    #$06, Obj_Flags(A1)                              ; $0004
                move.w  #$0006, Obj_Sub_Y(A1)                            ; $0016
                move.w  Obj_Y(A0), D2                                    ; $0014
                move.w  Obj_X(A0), D3                                    ; $0010
                subi.w  #$0050, D3
                lea     Obj_Speed_X(A1), A2                              ; $0018
                move.w  Obj_Sub_Y(A1), D6                                ; $0016
                subq.w  #$01, D6
                move.w  #$0001, Obj_Flags(A2)                            ; $0004
Offset_0x02207E:
                move.w  D3, (A2)+
                move.w  D2, (A2)+
                addq.w  #$02, A2
                addi.w  #$0020, D3
                dbra    D6, Offset_0x02207E
                move.w  #$0002, -2(A2)
                move.w  A1, Obj_Control_Var_0C(A0)                       ; $003C
Offset_0x022096:
                move.l  #Offset_0x022112, (A0)
                bra     Offset_0x022112
Offset_0x0220A0:
                move.b  Obj_Status(A0), D0                               ; $002A
                andi.b  #$18, D0
                beq.s   Offset_0x0220C8
                move.b  Obj_Control_Var_05(A0), Obj_Control_Var_04(A0) ; $0035, $0034
                move.b  Obj_Control_Var_06(A0), D2                       ; $0036
                move.b  Obj_Control_Var_07(A0), D3                       ; $0037
                move.l  #Offset_0x0221A0, (A0)
                move.l  #Offset_0x0220EA, D4
                bsr     Offset_0x02222E
Offset_0x0220C8:
                moveq   #$00, D1
                move.b  Obj_Width(A0), D1                                ; $0007
                moveq   #$00, D3
                move.b  Obj_Height(A0), D3                               ; $0006
                move.w  Obj_X(A0), D4                                    ; $0010
                jsr     (Platform_Object)                      ; Offset_0x013AF6
                jmp     (MarkObjGone_3)                        ; Offset_0x011B3E 
;-------------------------------------------------------------------------------
Offset_0x0220E4:
                jmp     (MarkObjGone)                          ; Offset_0x011AF2  
;-------------------------------------------------------------------------------
Offset_0x0220EA:
                tst.b   Obj_Control_Var_04(A0)                           ; $0034
                beq.s   Offset_0x0220FA
                subq.b  #$01, Obj_Control_Var_04(A0)                     ; $0034
                jmp     (DisplaySprite)                        ; Offset_0x011148
Offset_0x0220FA:
                jsr     (ObjectFall)                           ; Offset_0x0110FE
                tst.b   Obj_Flags(A0)                                    ; $0004
                bpl.s   Offset_0x02210C
                jmp     (DisplaySprite)                        ; Offset_0x011148
Offset_0x02210C:
                jmp     (DeleteObject)                         ; Offset_0x011138
Offset_0x022112:
                tst.b   (Boss_Attack_Started).w                      ; $FFFFFAA2
                beq.s   Offset_0x022136
                move.b  Obj_Control_Var_05(A0), Obj_Control_Var_04(A0) ; $0035, $0034
                move.b  Obj_Control_Var_06(A0), D2                       ; $0036
                move.b  Obj_Control_Var_07(A0), D3                       ; $0037
                move.l  #Offset_0x0221A0, (A0)
                move.l  #Offset_0x022152, D4
                bsr     Offset_0x02222E
Offset_0x022136:
                moveq   #$00, D1
                move.b  Obj_Width(A0), D1                                ; $0007
                moveq   #$00, D3
                move.b  Obj_Height(A0), D3                               ; $0006
                move.w  Obj_X(A0), D4                                    ; $0010
                jsr     (Platform_Object)                      ; Offset_0x013AF6
                jmp     (MarkObjGone_3)                        ; Offset_0x011B3E    
;-------------------------------------------------------------------------------
Offset_0x022152:
                tst.b   Obj_Control_Var_04(A0)                           ; $0034
                beq.s   Offset_0x02216A
                subq.b  #$01, Obj_Control_Var_04(A0)                     ; $0034
                bne.s   Offset_0x022164
                move.b  #$03, Obj_Map_Id(A0)                             ; $0022
Offset_0x022164:
                jmp     (DisplaySprite)                        ; Offset_0x011148
Offset_0x02216A:
                subq.b  #$01, Obj_Ani_Time(A0)                           ; $0024
                bpl.s   Offset_0x022188
                move.b  #$03, Obj_Ani_Time(A0)                           ; $0024
                addq.b  #$01, Obj_Map_Id(A0)                             ; $0022
                cmpi.b  #$08, Obj_Map_Id(A0)                             ; $0022
                bcs.s   Offset_0x022188
                move.b  #$03, Obj_Map_Id(A0)                             ; $0022
Offset_0x022188:
                jsr     (ObjectFall)                           ; Offset_0x0110FE
                tst.b   Obj_Flags(A0)                                    ; $0004
                bpl.s   Offset_0x02219A
                jmp     (DisplaySprite)                        ; Offset_0x011148
Offset_0x02219A:
                jmp     (DeleteObject)                         ; Offset_0x011138
;-------------------------------------------------------------------------------
Offset_0x0221A0:
                subq.b  #$01, Obj_Control_Var_04(A0)                     ; $0034
                bne.s   Offset_0x0221AC
                move.l  #Offset_0x022684, (A0)
Offset_0x0221AC:
                move.b  Obj_Control_Var_04(A0), D3                       ; $0034
                moveq   #$00, D1
                move.b  Obj_Width(A0), D1                                ; $0007
                lea     (Obj_Player_One).w, A1                       ; $FFFFB000
                moveq   #$03, D6
                bsr.s   Offset_0x0221CC
                lea     (Obj_Player_Two).w, A1                       ; $FFFFB04A
                moveq   #$04, D6
                bsr.s   Offset_0x0221CC
                jmp     (MarkObjGone_3)                        ; Offset_0x011B3E
Offset_0x0221CC:
                btst    D6, Obj_Status(A0)                               ; $002A
                beq.s   Offset_0x02222C
                move.w  D1, D2
                add.w   D2, D2
                btst    #$01, Obj_Status(A1)                             ; $002A
                bne.s   Offset_0x022210
                move.w  Obj_X(A1), D0                                    ; $0010
                sub.w   Obj_X(A0), D0                                    ; $0010
                add.w   D1, D0
                bmi.s   Offset_0x022210
                cmp.w   D2, D0
                bcc.s   Offset_0x022210
                btst    #$00, Obj_Status(A0)                             ; $002A
                beq.s   Offset_0x0221FA
                neg.w   D0
                add.w   D2, D0
Offset_0x0221FA:
                lsr.w   #$05, D0
                add.w   D0, D0
                add.w   D0, D0
                add.w   D0, D0
                add.b   Obj_Control_Var_06(A0), D0                       ; $0036
                move.b  Obj_Control_Var_05(A0), D2                       ; $0035
                sub.b   D0, D2
                cmp.b   D2, D3
                bhi.s   Offset_0x02222C
Offset_0x022210:
                bclr    D6, Obj_Status(A0)                               ; $002A
                bclr    #$03, Obj_Status(A1)                             ; $002A
                bclr    #$05, Obj_Status(A1)                             ; $002A
                bset    #$01, Obj_Status(A1)                             ; $002A
                move.b  #$01, Obj_Ani_Flag(A1)                           ; $0021
Offset_0x02222C:
                rts
Offset_0x02222E:
                move.w  Obj_Control_Var_0C(A0), A3                       ; $003C
                lea     $0018(A3), A2
                move.w  Obj_Sub_Y(A3), D6                                ; $0016
                subq.w  #$01, D6
                bclr    #$06, Obj_Flags(A3)                              ; $0004
                move.l  A3, A1
                bra.s   Offset_0x02224E   
;-------------------------------------------------------------------------------
Offset_0x022246:
                jsr     (AllocateObjectAfterCurrent)                  ; Offset_0x011DE0
                bne.s   Offset_0x02228C
Offset_0x02224E:
                move.l  D4, (A1)
                move.l  Obj_Map(A3), Obj_Map(A1)                  ; $000C, $000C
                move.b  Obj_Flags(A3), Obj_Flags(A1)              ; $0004, $0004
                move.w  Obj_Art_VRAM(A3), Obj_Art_VRAM(A1)        ; $000A, $000A
                move.w  Obj_Priority(A3), Obj_Priority(A1)        ; $0008, $0008
                move.b  Obj_Width(A3), Obj_Width(A1)              ; $0007, $0007
                move.b  Obj_Height(A3), Obj_Height(A1)            ; $0006, $0006
                move.w  (A2)+, Obj_X(A1)                                 ; $0010
                move.w  (A2)+, Obj_Y(A1)                                 ; $0014
                move.w  (A2)+, D0
                move.b  D0, Obj_Map_Id(A1)                               ; $0022
                move.b  D2, Obj_Control_Var_04(A1)                       ; $0034
                add.b   D3, D2
                dbra    D6, Offset_0x022246
Offset_0x02228C:
                move.w  #$0000, Obj_Speed_X(A3)                          ; $0018
                move.w  #$0000, Obj_Speed_Y(A3)                          ; $001A
                move.w  #S2_Smash_Sfx, D0                                ; $00B9
                jmp     (Play_Music)                           ; Offset_0x001176   
;-------------------------------------------------------------------------------
Collapsing_Bridge_Mappings:                                    ; Offset_0x0222A2
                dc.w    Offset_0x0222A8-Collapsing_Bridge_Mappings
                dc.w    Offset_0x0222A8-Collapsing_Bridge_Mappings
                dc.w    Offset_0x0222B0-Collapsing_Bridge_Mappings
Offset_0x0222A8:
                dc.w    $0001
                dc.w    $F80D, $002D, $FFF0
Offset_0x0222B0:
                dc.w    $0003
                dc.w    $F80D, $002D, $FFF0
                dc.w    $0808, $012D, $FFF8
                dc.w    $1004, $0130, $0000     
;-------------------------------------------------------------------------------   
Collapsing_Bridge_Mappings_2:                                  ; Offset_0x0222C4
                dc.w    Offset_0x0222D4-Collapsing_Bridge_Mappings_2
                dc.w    Offset_0x0222E2-Collapsing_Bridge_Mappings_2
                dc.w    Offset_0x0222FC-Collapsing_Bridge_Mappings_2
                dc.w    Offset_0x022316-Collapsing_Bridge_Mappings_2
                dc.w    Offset_0x022324-Collapsing_Bridge_Mappings_2
                dc.w    Offset_0x022332-Collapsing_Bridge_Mappings_2
                dc.w    Offset_0x022340-Collapsing_Bridge_Mappings_2
                dc.w    Offset_0x02234E-Collapsing_Bridge_Mappings_2
Offset_0x0222D4:
                dc.w    $0002
                dc.w    $F805, $0122, $FFF0
                dc.w    $F805, $0122, $0000
Offset_0x0222E2:
                dc.w    $0004
                dc.w    $F805, $0122, $FFF0
                dc.w    $F805, $0122, $0000
                dc.w    $0808, $092D, $FFF0
                dc.w    $1004, $0930, $FFF0
Offset_0x0222FC:
                dc.w    $0004
                dc.w    $F805, $0122, $FFF0
                dc.w    $F805, $0122, $0000
                dc.w    $0808, $012D, $FFF8
                dc.w    $1004, $0130, $0000
Offset_0x022316:
                dc.w    $0002
                dc.w    $F006, $20EA, $FFF0
                dc.w    $F006, $20EA, $0000
Offset_0x022324:
                dc.w    $0002
                dc.w    $F006, $20F0, $FFF0
                dc.w    $F006, $20F0, $0000
Offset_0x022332:
                dc.w    $0002
                dc.w    $F006, $20F6, $FFF0
                dc.w    $F006, $20F6, $0000
Offset_0x022340:
                dc.w    $0002
                dc.w    $F006, $20FC, $FFF0
                dc.w    $F006, $20FC, $0000
Offset_0x02234E:
                dc.w    $0002
                dc.w    $F006, $28F0, $FFF0
                dc.w    $F006, $28F0, $0000                                                                                                  
;===============================================================================
; Objeto 0x2C - Ponte que desmorona na Angel Island
; <<<-  
;===============================================================================  