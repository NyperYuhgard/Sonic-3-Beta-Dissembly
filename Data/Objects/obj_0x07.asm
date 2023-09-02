;===============================================================================
; Objeto 0x07 - Molas amarelas / vermelhas - diagonal / horizontal / vertical 
; ->>>           
;===============================================================================
; Offset_0x01921A:
                move.l  #Springs_Mappings, Obj_Map(A0)  ; Offset_0x019C1A, $000C
                move.w  #$04A4, Obj_Art_VRAM(A0)                         ; $000A
                ori.b   #$04, Obj_Flags(A0)                              ; $0004
                move.b  #$10, Obj_Width(A0)                              ; $0007
                move.b  #$10, Obj_Height(A0)                             ; $0006
                move.w  #$0200, Obj_Priority(A0)                         ; $0008
                move.w  Obj_X(A0), Obj_Control_Var_02(A0)         ; $0010, $0032
                move.w  Obj_Y(A0), Obj_Control_Var_04(A0)         ; $0014, $0034
                move.b  Obj_Subtype(A0), D0                              ; $002C
                lsr.w   #$03, D0
                andi.w  #$000E, D0
                move.w  Offset_0x01925E(PC, D0), D0
                jmp     Offset_0x01925E(PC, D0) 
;-------------------------------------------------------------------------------
Offset_0x01925E:
                dc.w    Offset_0x01938A-Offset_0x01925E
                dc.w    Offset_0x0192C4-Offset_0x01925E
                dc.w    Offset_0x019302-Offset_0x01925E
                dc.w    Offset_0x019334-Offset_0x01925E
                dc.w    Offset_0x01935C-Offset_0x01925E   
;-------------------------------------------------------------------------------    
Obj_0x07_Springs_2P:                                           ; Offset_0x019268
                move.l  #Springs_Mappings, Obj_Map(A0)  ; Offset_0x019C1A, $000C
                move.w  #$04A4, Obj_Art_VRAM(A0)                         ; $000A
                ori.b   #$04, Obj_Flags(A0)                              ; $0004
                move.b  #$10, Obj_Width(A0)                              ; $0007
                move.b  #$10, Obj_Height(A0)                             ; $0006
                move.w  #$0200, Obj_Priority(A0)                         ; $0008
                move.w  Obj_X(A0), Obj_Control_Var_02(A0)         ; $0010, $0032
                move.w  Obj_Y(A0), Obj_Control_Var_04(A0)         ; $0014, $0034
                move.b  Obj_Subtype(A0), D0                              ; $002C
                lsr.w   #$03, D0
                andi.w  #$000E, D0
                move.w  Offset_0x0192B4(PC, D0), D0
                jsr     Offset_0x0192B4(PC, D0)
                move.w  #$F800, Obj_Control_Var_00(A0)                   ; $0030
                rts    
;-------------------------------------------------------------------------------   
Offset_0x0192B4:
                dc.w    Offset_0x01938A-Offset_0x0192B4
                dc.w    Offset_0x0192C4-Offset_0x0192B4
                dc.w    Offset_0x019302-Offset_0x0192B4
                dc.w    Offset_0x0192C4-Offset_0x0192B4
                dc.w    Offset_0x01938A-Offset_0x0192B4
                dc.w    Offset_0x019302-Offset_0x0192B4
                dc.w    Offset_0x01938A-Offset_0x0192B4
                dc.w    Offset_0x019302-Offset_0x0192B4
;-------------------------------------------------------------------------------
Offset_0x0192C4:
                move.b  #$02, Obj_Ani_Number(A0)                         ; $0020
                move.b  #$03, Obj_Map_Id(A0)                             ; $0022
                move.w  #$04B4, Obj_Art_VRAM(A0)                         ; $000A
                move.b  #$08, Obj_Width(A0)                              ; $0007
                move.l  #Offset_0x019534, (A0)
                tst.w   (Two_Player_Flag).w                          ; $FFFFFFD8
                beq     Offset_0x0193B8
                move.l  #Springs_Mappings_2P, Obj_Map(A0) ; Offset_0x019DC2, $000C
                move.w  #$03AD, Obj_Art_VRAM(A0)                         ; $000A
                move.l  #Offset_0x0195C2, (A0)
                bra     Offset_0x0193B8   
;-------------------------------------------------------------------------------
Offset_0x019302:
                move.b  #$06, Obj_Map_Id(A0)                             ; $0022
                bset    #$01, Obj_Status(A0)                             ; $002A
                move.l  #Offset_0x019804, (A0)
                tst.w   (Two_Player_Flag).w                          ; $FFFFFFD8
                beq     Offset_0x0193B8
                move.l  #Offset_0x019852, (A0)
                move.l  #Springs_Mappings_2P, Obj_Map(A0) ; Offset_0x019DC2, $000C
                move.w  #$0391, Obj_Art_VRAM(A0)                         ; $000A
                bra     Offset_0x0193B8   
;-------------------------------------------------------------------------------
Offset_0x019334:
                move.b  #$04, Obj_Ani_Number(A0)                         ; $0020
                move.b  #$07, Obj_Map_Id(A0)                             ; $0022
                move.w  #$043A, Obj_Art_VRAM(A0)                         ; $000A
                cmpi.b  #$02, (Level_Id).w                           ; $FFFFFE10
                bne.s   Offset_0x019354
                move.w  #$0478, Obj_Art_VRAM(A0)                         ; $000A
Offset_0x019354:
                move.l  #Offset_0x01994E, (A0)
                bra.s   Offset_0x0193B8     
;-------------------------------------------------------------------------------
Offset_0x01935C:
                move.b  #$04, Obj_Ani_Number(A0)                         ; $0020
                move.b  #$0A, Obj_Map_Id(A0)                             ; $0022
                move.w  #$043A, Obj_Art_VRAM(A0)                         ; $000A
                cmpi.b  #$02, (Level_Id).w                           ; $FFFFFE10
                bne.s   Offset_0x01937C
                move.w  #$0478, Obj_Art_VRAM(A0)                         ; $000A
Offset_0x01937C:
                bset    #$01, Obj_Status(A0)                             ; $002A
                move.l  #Offset_0x019A90, (A0)
                bra.s   Offset_0x0193B8     
;-------------------------------------------------------------------------------
Offset_0x01938A:
                move.l  #Offset_0x0193E8, (A0)
                tst.w   (Two_Player_Flag).w                          ; $FFFFFFD8
                beq.s   Offset_0x0193B8
                move.l  #Offset_0x01943A, (A0)
                move.l  #Springs_Mappings_2P, Obj_Map(A0) ; Offset_0x019DC2, $000C
                move.w  #$0391, Obj_Art_VRAM(A0)                         ; $000A
                cmpi.b  #$12, (Level_Id).w                           ; $FFFFFE10
                bne.s   Offset_0x0193B8
                ori.w   #$8000, Obj_Art_VRAM(A0)                         ; $000A
Offset_0x0193B8:
                move.b  Obj_Subtype(A0), D0                              ; $002C
                andi.w  #$0002, D0
                move.w  Offset_0x0193E4(PC, D0), Obj_Control_Var_00(A0)  ; $0030
                btst    #$01, D0
                beq.s   Offset_0x0193E2
                move.l  #Springs_Mappings_01, Obj_Map(A0) ; Offset_0x019C30, $000C
                tst.w   (Two_Player_Flag).w                          ; $FFFFFFD8
                beq.s   Offset_0x0193E2
                move.l  #Springs_Mappings_01_2P, Obj_Map(A0) ; Offset_0x019DD0, $000C
Offset_0x0193E2:
                rts   
;-------------------------------------------------------------------------------
Offset_0x0193E4:
                dc.w    $F000, $F600    
;------------------------------------------------------------------------------- 
Offset_0x0193E8:
                move.w  #$001B, D1
                move.w  #$0008, D2
                move.w  #$0010, D3
                move.w  Obj_X(A0), D4                                    ; $0010
                lea     (Obj_Player_One).w, A1                       ; $FFFFB000
                moveq   #$03, D6
                movem.l D1-D4, -(A7)
                bsr     Solid_Object_2_A1                      ; Offset_0x0135CC
                btst    #$03, Obj_Status(A0)                             ; $002A
                beq.s   Offset_0x019410
                bsr.s   Offset_0x01948C
Offset_0x019410:
                movem.l (A7)+, D1-D4
                lea     (Obj_Player_Two).w, A1                       ; $FFFFB04A
                moveq   #$04, D6
                bsr     Solid_Object_2_A1                      ; Offset_0x0135CC
                btst    #$04, Obj_Status(A0)                             ; $002A
                beq.s   Offset_0x019428
                bsr.s   Offset_0x01948C
Offset_0x019428:
                lea     (Springs_Animate_Data), A1             ; Offset_0x019BE0
                jsr     (AnimateSprite)                        ; Offset_0x01115E
                jmp     (MarkObjGone)                          ; Offset_0x011AF2  
;-------------------------------------------------------------------------------
Offset_0x01943A:
                move.w  #$0013, D1
                move.w  #$0008, D2
                move.w  #$0010, D3
                move.w  Obj_X(A0), D4                                    ; $0010
                lea     (Obj_Player_One).w, A1                       ; $FFFFB000
                moveq   #$03, D6
                movem.l D1-D4, -(A7)
                bsr     Solid_Object_2_A1                      ; Offset_0x0135CC
                btst    #$03, Obj_Status(A0)                             ; $002A
                beq.s   Offset_0x019462
                bsr.s   Offset_0x01948C
Offset_0x019462:
                movem.l (A7)+, D1-D4
                lea     (Obj_Player_Two).w, A1                       ; $FFFFB04A
                moveq   #$04, D6
                bsr     Solid_Object_2_A1                      ; Offset_0x0135CC
                btst    #$04, Obj_Status(A0)                             ; $002A
                beq.s   Offset_0x01947A
                bsr.s   Offset_0x01948C
Offset_0x01947A:
                lea     (Springs_Animate_Data), A1             ; Offset_0x019BE0
                jsr     (AnimateSprite)                        ; Offset_0x01115E
                jmp     (DisplaySprite)                        ; Offset_0x011148
Offset_0x01948C:
                move.w  #$0100, Obj_Ani_Number(A0)                       ; $0020
                addq.w  #$08, Obj_Y(A1)                                  ; $0014
                move.w  Obj_P_Flips_Remaining(A0), Obj_Speed_Y(A1) ; $0030, $001A
                bset    #$01, Obj_Status(A1)                             ; $002A
                bclr    #$03, Obj_Status(A1)                             ; $002A
                clr.b   Obj_Player_Jump(A1)                              ; $0040
                move.b  #$10, Obj_Ani_Number(A1)                         ; $0020
                move.b  #$02, Obj_Routine(A1)                            ; $0005
                move.b  Obj_Subtype(A0), D0                              ; $002C
                bpl.s   Offset_0x0194C4
                move.w  #$0000, Obj_Speed_X(A1)                          ; $0018
Offset_0x0194C4:
                btst    #$00, D0
                beq.s   Offset_0x019504
                move.w  #$0001, Obj_Inertia(A1)                          ; $001C
                move.b  #$01, Obj_Flip_Angle(A1)                         ; $0027
                move.b  #$00, Obj_Ani_Number(A1)                         ; $0020
                move.b  #$00, Obj_P_Flips_Remaining(A1)                  ; $0030
                move.b  #$04, Obj_Player_Flip_Speed(A1)                  ; $0031
                btst    #$01, D0
                bne.s   Offset_0x0194F4
                move.b  #$01, Obj_P_Flips_Remaining(A1)                  ; $0030
Offset_0x0194F4:
                btst    #$00, Obj_Status(A1)                             ; $002A
                beq.s   Offset_0x019504
                neg.b   Obj_Flip_Angle(A1)                               ; $0027
                neg.w   Obj_Inertia(A1)                                  ; $001C
Offset_0x019504:
                andi.b  #$0C, D0
                cmpi.b  #$04, D0
                bne.s   Offset_0x01951A
                move.b  #$0C, Obj_Player_Top_Solid(A1)                   ; $0046
                move.b  #$0D, Obj_Player_LRB_Solid(A1)                   ; $0047
Offset_0x01951A:
                cmpi.b  #$08, D0
                bne.s   Offset_0x01952C
                move.b  #$0E, Obj_Player_Top_Solid(A1)                   ; $0046
                move.b  #$0F, Obj_Player_LRB_Solid(A1)                   ; $0047
Offset_0x01952C:
                moveq   #Spring_Sfx, D0                                   ; -$2E
                jmp     (Play_Music)                           ; Offset_0x001176  
;-------------------------------------------------------------------------------  
Offset_0x019534:
                move.w  #$0013, D1
                move.w  #$000E, D2
                move.w  #$000F, D3
                move.w  Obj_X(A0), D4                                    ; $0010
                lea     (Obj_Player_One).w, A1                       ; $FFFFB000
                moveq   #$03, D6
                movem.l D1-D4, -(A7)
                bsr     Solid_Object_2_A1                      ; Offset_0x0135CC
                swap.w  D6
                andi.w  #$0001, D6
                beq.s   Offset_0x019576
                move.b  Obj_Status(A0), D1                               ; $002A
                move.w  Obj_X(A0), D0                                    ; $0010
                sub.w   Obj_X(A1), D0                                    ; $0010
                bcs.s   Offset_0x01956C
                eori.b  #$01, D1
Offset_0x01956C:
                andi.b  #$01, D1
                bne.s   Offset_0x019576
                bsr     Offset_0x019674
Offset_0x019576:
                movem.l (A7)+, D1-D4
                lea     (Obj_Player_Two).w, A1                       ; $FFFFB04A
                moveq   #$04, D6
                bsr     Solid_Object_2_A1                      ; Offset_0x0135CC
                swap.w  D6
                andi.w  #$0002, D6
                beq.s   Offset_0x0195A8
                move.b  Obj_Status(A0), D1                               ; $002A
                move.w  Obj_X(A0), D0                                    ; $0010
                sub.w   Obj_X(A1), D0                                    ; $0010
                bcs.s   Offset_0x01959E
                eori.b  #$01, D1
Offset_0x01959E:
                andi.b  #$01, D1
                bne.s   Offset_0x0195A8
                bsr     Offset_0x019674
Offset_0x0195A8:
                bsr     Offset_0x01974A
                lea     (Springs_Animate_Data), A1             ; Offset_0x019BE0
                jsr     (AnimateSprite)                        ; Offset_0x01115E
                move.w  Obj_Control_Var_02(A0), D0                       ; $0032
                jmp     (MarkObjGone_2)                        ; Offset_0x011B1A  
;-------------------------------------------------------------------------------
Offset_0x0195C2:
                move.w  #$000F, D1
                move.w  #$000C, D2
                move.w  #$000D, D3
                move.w  Obj_X(A0), D4                                    ; $0010
                lea     (Obj_Player_One).w, A1                       ; $FFFFB000
                moveq   #$03, D6
                movem.l D1-D4, -(A7)
                bsr     Solid_Object_2_A1                      ; Offset_0x0135CC
                swap.w  D6
                andi.w  #$0001, D6
                beq.s   Offset_0x019602
                move.b  Obj_Status(A0), D1                               ; $002A
                move.w  Obj_X(A0), D0                                    ; $0010
                sub.w   Obj_X(A1), D0                                    ; $0010
                bcs.s   Offset_0x0195FA
                eori.b  #$01, D1
Offset_0x0195FA:
                andi.b  #$01, D1
                bne.s   Offset_0x019602
                bsr.s   Offset_0x019644
Offset_0x019602:
                movem.l (A7)+, D1-D4
                lea     (Obj_Player_Two).w, A1                       ; $FFFFB04A
                moveq   #$04, D6
                bsr     Solid_Object_2_A1                      ; Offset_0x0135CC
                swap.w  D6
                andi.w  #$0002, D6
                beq.s   Offset_0x019632
                move.b  Obj_Status(A0), D1                               ; $002A
                move.w  Obj_X(A0), D0                                    ; $0010
                sub.w   Obj_X(A1), D0                                    ; $0010
                bcs.s   Offset_0x01962A
                eori.b  #$01, D1
Offset_0x01962A:
                andi.b  #$01, D1
                bne.s   Offset_0x019632
                bsr.s   Offset_0x019644
Offset_0x019632:
                lea     (Springs_Animate_Data), A1             ; Offset_0x019BE0
                jsr     (AnimateSprite)                        ; Offset_0x01115E
                jmp     (DisplaySprite)                        ; Offset_0x011148
Offset_0x019644:
                move.w  #$0300, Obj_Ani_Number(A0)                       ; $0020
                move.w  Obj_Control_Var_00(A0), Obj_Speed_X(A1)   ; $0030, $0018
                addq.w  #$04, Obj_X(A1)                                  ; $0010
                bset    #$00, Obj_Status(A1)                             ; $002A
                btst    #$00, Obj_Status(A0)                             ; $002A
                bne.s   Offset_0x019672
                bclr    #$00, Obj_Status(A1)                             ; $002A
                subi.w  #$0008, Obj_X(A1)                                ; $0010
                neg.w   Obj_Speed_X(A1)                                  ; $0018
Offset_0x019672:
                bra.s   Offset_0x0196A2
;-------------------------------------------------------------------------------                
Offset_0x019674:
                move.w  #$0300, Obj_Ani_Number(A0)                       ; $0020
                move.w  Obj_Control_Var_00(A0), Obj_Speed_X(A1)   ; $0030, $0018
                addq.w  #$08, Obj_X(A1)                                  ; $0010
                bset    #$00, Obj_Status(A1)                             ; $002A
                btst    #$00, Obj_Status(A0)                             ; $002A
                bne.s   Offset_0x0196A2
                bclr    #$00, Obj_Status(A1)                             ; $002A
                subi.w  #$0010, Obj_X(A1)                                ; $0010
                neg.w   Obj_Speed_X(A1)                                  ; $0018
Offset_0x0196A2:
                move.w  #$000F, Obj_P_Horiz_Ctrl_Lock(A1)                ; $0032
                move.w  Obj_Speed_X(A1), Obj_Inertia(A1)          ; $0018, $001C
                btst    #$02, Obj_Status(A1)                             ; $002A
                bne.s   Offset_0x0196BC
                move.b  #$00, Obj_Ani_Number(A1)                         ; $0020
Offset_0x0196BC:
                move.b  Obj_Subtype(A0), D0                              ; $002C
                bpl.s   Offset_0x0196C8
                move.w  #$0000, Obj_Speed_Y(A1)                          ; $001A
Offset_0x0196C8:
                btst    #$00, D0
                beq.s   Offset_0x019708
                move.w  #$0001, Obj_Inertia(A1)                          ; $001C
                move.b  #$01, Obj_Flip_Angle(A1)                         ; $0027
                move.b  #$00, Obj_Ani_Number(A1)                         ; $0020
                move.b  #$01, Obj_P_Flips_Remaining(A1)                  ; $0030
                move.b  #$08, Obj_Player_Flip_Speed(A1)                  ; $0031
                btst    #$01, D0
                bne.s   Offset_0x0196F8
                move.b  #$03, Obj_P_Flips_Remaining(A1)                  ; $0030
Offset_0x0196F8:
                btst    #$00, Obj_Status(A1)                             ; $002A
                beq.s   Offset_0x019708
                neg.b   Obj_Flip_Angle(A1)                               ; $0027
                neg.w   Obj_Inertia(A1)                                  ; $001C
Offset_0x019708:
                andi.b  #$0C, D0
                cmpi.b  #$04, D0
                bne.s   Offset_0x01971E
                move.b  #$0C, Obj_Player_Top_Solid(A1)                   ; $0046
                move.b  #$0D, Obj_Player_LRB_Solid(A1)                   ; $0047
Offset_0x01971E:
                cmpi.b  #$08, D0
                bne.s   Offset_0x019730
                move.b  #$0E, Obj_Player_Top_Solid(A1)                   ; $0046
                move.b  #$0F, Obj_Player_LRB_Solid(A1)                   ; $0047
Offset_0x019730:
                bclr    #$05, Obj_Status(A0)                             ; $002A
                bclr    #$06, Obj_Status(A0)                             ; $002A
                bclr    #$05, Obj_Status(A1)                             ; $002A
                moveq   #Spring_Sfx, D0                                   ; -$2E
                jmp     (Play_Music)                           ; Offset_0x001176   
;-------------------------------------------------------------------------------
Offset_0x01974A:
                cmpi.b  #$03, Obj_Ani_Number(A0)                         ; $0020
                beq     Offset_0x019802
                move.w  Obj_X(A0), D0                                    ; $0010
                move.w  D0, D1
                addi.w  #$0028, D1
                btst    #$00, Obj_Status(A0)                             ; $002A
                beq.s   Offset_0x01976C
                move.w  D0, D1
                subi.w  #$0028, D0
Offset_0x01976C:
                move.w  Obj_Y(A0), D2                                    ; $0014
                move.w  D2, D3
                subi.w  #$0018, D2
                addi.w  #$0018, D3
                lea     (Obj_Player_One).w, A1                       ; $FFFFB000
                btst    #$01, Obj_Status(A1)                             ; $002A
                bne.s   Offset_0x0197C0
                move.w  Obj_Inertia(A1), D4                              ; $001C
                btst    #$00, Obj_Status(A0)                             ; $002A
                beq.s   Offset_0x019794
                neg.w   D4
Offset_0x019794:
                tst.w   D4
                bmi.s   Offset_0x0197C0
                move.w  Obj_X(A1), D4                                    ; $0010
                cmp.w   D0, D4
                bcs     Offset_0x0197C0
                cmp.w   D1, D4
                bcc     Offset_0x0197C0
                move.w  Obj_Y(A1), D4                                    ; $0014
                cmp.w   D2, D4
                bcs     Offset_0x0197C0
                cmp.w   D3, D4
                bcc     Offset_0x0197C0
                move.w  D0, -(A7)
                bsr     Offset_0x019674
                move.w  (A7)+, D0
Offset_0x0197C0:
                lea     (Obj_Player_Two).w, A1                       ; $FFFFB04A
                btst    #$01, Obj_Status(A1)                             ; $002A
                bne.s   Offset_0x019802
                move.w  Obj_Inertia(A1), D4                              ; $001C
                btst    #$00, Obj_Status(A0)                             ; $002A
                beq.s   Offset_0x0197DA
                neg.w   D4
Offset_0x0197DA:
                tst.w   D4
                bmi.s   Offset_0x019802
                move.w  Obj_X(A1), D4                                    ; $0010
                cmp.w   D0, D4
                bcs     Offset_0x019802
                cmp.w   D1, D4
                bcc     Offset_0x019802
                move.w  Obj_Y(A1), D4                                    ; $0014
                cmp.w   D2, D4
                bcs     Offset_0x019802
                cmp.w   D3, D4
                bcc     Offset_0x019802
                bsr     Offset_0x019674
Offset_0x019802:
                rts       
;-------------------------------------------------------------------------------
Offset_0x019804:
                move.w  #$001B, D1
                move.w  #$0008, D2
                move.w  #$0009, D3
                move.w  Obj_X(A0), D4                                    ; $0010
                lea     (Obj_Player_One).w, A1                       ; $FFFFB000
                moveq   #$03, D6
                movem.l D1-D4, -(A7)
                bsr     Solid_Object_2_A1                      ; Offset_0x0135CC
                cmpi.w  #$FFFE, D4
                bne.s   Offset_0x01982A
                bsr.s   Offset_0x0198A8
Offset_0x01982A:
                movem.l (A7)+, D1-D4
                lea     (Obj_Player_Two).w, A1                       ; $FFFFB04A
                moveq   #$04, D6
                bsr     Solid_Object_2_A1                      ; Offset_0x0135CC
                cmpi.w  #$FFFE, D4
                bne.s   Offset_0x019840
                bsr.s   Offset_0x0198A8
Offset_0x019840:
                lea     (Springs_Animate_Data), A1             ; Offset_0x019BE0
                jsr     (AnimateSprite)                        ; Offset_0x01115E
                jmp     (MarkObjGone)                          ; Offset_0x011AF2 
;-------------------------------------------------------------------------------
Offset_0x019852:
                move.w  #$0013, D1
                move.w  #$0008, D2
                move.w  #$0009, D3
                move.w  Obj_X(A0), D4                                    ; $0010
                lea     (Obj_Player_One).w, A1                       ; $FFFFB000
                moveq   #$03, D6
                movem.l D1-D4, -(A7)
                bsr     Solid_Object_2_A1                      ; Offset_0x0135CC
                cmpi.w  #$FFFE, D4
                bne.s   Offset_0x01987C
                subq.w  #$04, Obj_Y(A1)                                  ; $0014
                bsr.s   Offset_0x0198AC
Offset_0x01987C:
                movem.l (A7)+, D1-D4
                lea     (Obj_Player_Two).w, A1                       ; $FFFFB04A
                moveq   #$04, D6
                bsr     Solid_Object_2_A1                      ; Offset_0x0135CC
                cmpi.w  #$FFFE, D4
                bne.s   Offset_0x019896
                subq.w  #$04, Obj_Y(A1)                                  ; $0014
                bsr.s   Offset_0x0198AC
Offset_0x019896:
                lea     (Springs_Animate_Data), A1             ; Offset_0x019BE0
                jsr     (AnimateSprite)                        ; Offset_0x01115E
                jmp     (DisplaySprite)                        ; Offset_0x011148
;-------------------------------------------------------------------------------                
Offset_0x0198A8:
                subq.w  #$08, Obj_Y(A1)                                  ; $0014
Offset_0x0198AC:
                move.w  #$0100, Obj_Ani_Number(A0)                       ; $0020
                move.w  Obj_P_Flips_Remaining(A0), Obj_Speed_Y(A1) ; $0030, $001A
                neg.w   Obj_Speed_Y(A1)                                  ; $001A
                move.b  Obj_Subtype(A0), D0                              ; $002C
                bpl.s   Offset_0x0198C8
                move.w  #$0000, Obj_Speed_X(A1)                          ; $0018
Offset_0x0198C8:
                btst    #$00, D0
                beq.s   Offset_0x019908
                move.w  #$0001, Obj_Inertia(A1)                          ; $001C
                move.b  #$01, Obj_Flip_Angle(A1)                         ; $0027
                move.b  #$00, Obj_Ani_Number(A1)                         ; $0020
                move.b  #$00, Obj_P_Flips_Remaining(A1)                  ; $0030
                move.b  #$04, Obj_Player_Flip_Speed(A1)                  ; $0031
                btst    #$01, D0
                bne.s   Offset_0x0198F8
                move.b  #$01, Obj_P_Flips_Remaining(A1)                  ; $0030
Offset_0x0198F8:
                btst    #$00, Obj_Status(A1)                             ; $002A
                beq.s   Offset_0x019908
                neg.b   Obj_Flip_Angle(A1)                               ; $0027
                neg.w   Obj_Inertia(A1)                                  ; $001C
Offset_0x019908:
                andi.b  #$0C, D0
                cmpi.b  #$04, D0
                bne.s   Offset_0x01991E
                move.b  #$0C, Obj_Player_Top_Solid(A1)                   ; $0046
                move.b  #$0D, Obj_Player_LRB_Solid(A1)                   ; $0047
Offset_0x01991E:
                cmpi.b  #$08, D0
                bne.s   Offset_0x019930
                move.b  #$0E, Obj_Player_Top_Solid(A1)                   ; $0046
                move.b  #$0F, Obj_Player_LRB_Solid(A1)                   ; $0047
Offset_0x019930:
                bset    #$01, Obj_Status(A1)                             ; $002A
                bclr    #$03, Obj_Status(A1)                             ; $002A
                clr.b   Obj_Player_Jump(A1)                              ; $0040
                move.b  #$02, Obj_Routine(A1)                            ; $0005
                moveq   #Spring_Sfx, D0                                   ; -$2E
                jmp     (Play_Music)                           ; Offset_0x001176 
;-------------------------------------------------------------------------------
Offset_0x01994E:
                move.w  #$001B, D1
                move.w  #$0010, D2
                move.w  Obj_X(A0), D4                                    ; $0010
                lea     Offset_0x019BA8(PC), A2
                lea     (Obj_Player_One).w, A1                       ; $FFFFB000
                moveq   #$03, D6
                movem.l D1-D4, -(A7)
                bsr     Offset_0x013624
                btst    #$03, Obj_Status(A0)                             ; $002A
                beq.s   Offset_0x019976
                bsr.s   Offset_0x0199A4
Offset_0x019976:
                movem.l (A7)+, D1-D4
                lea     (Obj_Player_Two).w, A1                       ; $FFFFB04A
                moveq   #$04, D6
                bsr     Offset_0x013624
                btst    #$04, Obj_Status(A0)                             ; $002A
                beq.s   Offset_0x01998E
                bsr.s   Offset_0x0199A4
Offset_0x01998E:
                lea     (Springs_Animate_Data), A1             ; Offset_0x019BE0
                jsr     (AnimateSprite)                        ; Offset_0x01115E
                move.w  Obj_P_Horiz_Ctrl_Lock(A0), D0                    ; $0032
                jmp     (MarkObjGone_2)                        ; Offset_0x011B1A
Offset_0x0199A4:
                btst    #$00, Obj_Status(A0)                             ; $002A
                bne.s   Offset_0x0199BA
                move.w  Obj_X(A0), D0                                    ; $0010
                subq.w  #$04, D0
                cmp.w   Obj_X(A1), D0                                    ; $0010
                bcs.s   Offset_0x0199C8
                rts
Offset_0x0199BA:
                move.w  Obj_X(A0), D0                                    ; $0010
                addq.w  #$04, D0
                cmp.w   Obj_X(A1), D0                                    ; $0010
                bcc.s   Offset_0x0199C8
                rts
Offset_0x0199C8:
                move.w  #$0500, Obj_Ani_Number(A0)                       ; $0020
                move.w  Obj_P_Flips_Remaining(A0), Obj_Speed_Y(A1) ; $0030, $001A
                move.w  Obj_P_Flips_Remaining(A0), Obj_Speed_X(A1) ; $0030, $0018
                addq.w  #$06, Obj_Y(A1)                                  ; $0014
                addq.w  #$06, Obj_X(A1)                                  ; $0010
                bset    #$00, Obj_Status(A1)                             ; $002A
                btst    #$00, Obj_Status(A0)                             ; $002A
                bne.s   Offset_0x019A00
                bclr    #$00, Obj_Status(A1)                             ; $002A
                subi.w  #$000C, Obj_X(A1)                                ; $0010
                neg.w   Obj_Speed_X(A1)                                  ; $0018
Offset_0x019A00:
                bset    #$01, Obj_Status(A1)                             ; $002A
                bclr    #$03, Obj_Status(A1)                             ; $002A
                clr.b   Obj_Player_Jump(A1)                              ; $0040
                move.b  #$10, Obj_Ani_Number(A1)                         ; $0020
                move.b  #$02, Obj_Routine(A1)                            ; $0005
                move.b  Obj_Subtype(A0), D0                              ; $002C
                btst    #$00, D0
                beq.s   Offset_0x019A60
                move.w  #$0001, Obj_Inertia(A1)                          ; $001C
                move.b  #$01, Obj_Flip_Angle(A1)                         ; $0027
                move.b  #$00, Obj_Ani_Number(A1)                         ; $0020
                move.b  #$01, Obj_P_Flips_Remaining(A1)                  ; $0030
                move.b  #$08, Obj_Player_Flip_Speed(A1)                  ; $0031
                btst    #$01, D0
                bne.s   Offset_0x019A50
                move.b  #$03, Obj_P_Flips_Remaining(A1)                  ; $0030
Offset_0x019A50:
                btst    #$00, Obj_Status(A1)                             ; $002A
                beq.s   Offset_0x019A60
                neg.b   Obj_Flip_Angle(A1)                               ; $0027
                neg.w   Obj_Inertia(A1)                                  ; $001C
Offset_0x019A60:
                andi.b  #$0C, D0
                cmpi.b  #$04, D0
                bne.s   Offset_0x019A76
                move.b  #$0C, Obj_Player_Top_Solid(A1)                   ; $0046
                move.b  #$0D, Obj_Player_LRB_Solid(A1)                   ; $0047
Offset_0x019A76:
                cmpi.b  #$08, D0
                bne.s   Offset_0x019A88
                move.b  #$0E, Obj_Player_Top_Solid(A1)                   ; $0046
                move.b  #$0F, Obj_Player_LRB_Solid(A1)                   ; $0047
Offset_0x019A88:
                moveq   #Spring_Sfx, D0                                   ; -$2E
                jmp     (Play_Music)                           ; Offset_0x001176   
;-------------------------------------------------------------------------------
Offset_0x019A90:
                move.w  #$001B, D1
                move.w  #$0010, D2
                move.w  Obj_X(A0), D4                                    ; $0010
                lea     Offset_0x019BC4(PC), A2
                lea     (Obj_Player_One).w, A1                       ; $FFFFB000
                moveq   #$03, D6
                movem.l D1-D4, -(A7)
                bsr     Offset_0x013624
                cmpi.w  #$FFFE, D4
                bne.s   Offset_0x019AB6
                bsr.s   Offset_0x019AE2
Offset_0x019AB6:
                movem.l (A7)+, D1-D4
                lea     (Obj_Player_Two).w, A1                       ; $FFFFB04A
                moveq   #$04, D6
                bsr     Offset_0x013624
                cmpi.w  #$FFFE, D4
                bne.s   Offset_0x019ACC
                bsr.s   Offset_0x019AE2
Offset_0x019ACC:
                lea     (Springs_Animate_Data), A1             ; Offset_0x019BE0
                jsr     (AnimateSprite)                        ; Offset_0x01115E
                move.w  Obj_Control_Var_02(A0), D0                       ; $0032
                jmp     (MarkObjGone_2)                        ; Offset_0x011B1A
Offset_0x019AE2:
                move.w  #$0500, Obj_Ani_Number(A0)                       ; $0020
                move.w  Obj_P_Flips_Remaining(A0), Obj_Speed_Y(A1) ; $0030, $001A
                neg.w   Obj_Speed_Y(A1)                                  ; $001A
                move.w  Obj_P_Flips_Remaining(A0), Obj_Speed_X(A1) ; $0030, $0018
                subq.w  #$06, Obj_Y(A1)                                  ; $0014
                addq.w  #$06, Obj_X(A1)                                  ; $0010
                bset    #$00, Obj_Status(A1)                             ; $002A
                btst    #$00, Obj_Status(A0)                             ; $002A
                bne.s   Offset_0x019B1E
                bclr    #$00, Obj_Status(A1)                             ; $002A
                subi.w  #$000C, Obj_X(A1)                                ; $0010
                neg.w   Obj_Speed_X(A1)                                  ; $0018
Offset_0x019B1E:
                bset    #$01, Obj_Status(A1)                             ; $002A
                bclr    #$03, Obj_Status(A1)                             ; $002A
                clr.b   Obj_Player_Jump(A1)                              ; $0040
                move.b  #$02, Obj_Routine(A1)                            ; $0005
                move.b  Obj_Subtype(A0), D0                              ; $002C
                btst    #$00, D0
                beq.s   Offset_0x019B78
                move.w  #$0001, Obj_Inertia(A1)                          ; $001C
                move.b  #$01, Obj_Flip_Angle(A1)                         ; $0027
                move.b  #$00, Obj_Ani_Number(A1)                         ; $0020
                move.b  #$01, Obj_P_Flips_Remaining(A1)                  ; $0030
                move.b  #$08, Obj_Player_Flip_Speed(A1)                  ; $0031
                btst    #$01, D0
                bne.s   Offset_0x019B68
                move.b  #$03, Obj_P_Flips_Remaining(A1)                  ; $0030
Offset_0x019B68:
                btst    #$00, Obj_Status(A1)                             ; $002A
                beq.s   Offset_0x019B78
                neg.b   Obj_Flip_Angle(A1)                               ; $0027
                neg.w   Obj_Inertia(A1)                                  ; $001C
Offset_0x019B78:
                andi.b  #$0C, D0
                cmpi.b  #$04, D0
                bne.s   Offset_0x019B8E
                move.b  #$0C, Obj_Player_Top_Solid(A1)                   ; $0046
                move.b  #$0D, Obj_Player_LRB_Solid(A1)                   ; $0047
Offset_0x019B8E:
                cmpi.b  #$08, D0
                bne.s   Offset_0x019BA0
                move.b  #$0E, Obj_Player_Top_Solid(A1)                   ; $0046
                move.b  #$0F, Obj_Player_LRB_Solid(A1)                   ; $0047
Offset_0x019BA0:
                moveq   #Spring_Sfx, D0                                   ; -$2E
                jmp     (Play_Music)                           ; Offset_0x001176   
;-------------------------------------------------------------------------------
Offset_0x019BA8:  
                dc.b    $10, $10, $10, $10, $10, $10, $10, $10
                dc.b    $10, $10, $10, $10, $0E, $0C, $0A, $08
                dc.b    $06, $04, $02, $00, $FE, $FC, $FC, $FC
                dc.b    $FC, $FC, $FC, $FC                                                            
;-------------------------------------------------------------------------------  
Offset_0x019BC4:
                dc.b    $F4, $F0, $F0, $F0, $F0, $F0, $F0, $F0
                dc.b    $F0, $F0, $F0, $F0, $F2, $F4, $F6, $F8
                dc.b    $FA, $FC, $FE, $00, $02, $04, $04, $04
                dc.b    $04, $04, $04, $04                                                  
;------------------------------------------------------------------------------- 
Springs_Animate_Data:                                          ; Offset_0x019BE0
                dc.w    Offset_0x019BEC-Springs_Animate_Data
                dc.w    Offset_0x019BEF-Springs_Animate_Data
                dc.w    Offset_0x019BFB-Springs_Animate_Data
                dc.w    Offset_0x019BFE-Springs_Animate_Data
                dc.w    Offset_0x019C0A-Springs_Animate_Data
                dc.w    Offset_0x019C0D-Springs_Animate_Data
Offset_0x019BEC:
                dc.b    $0F, $00, $FF
Offset_0x019BEF:
                dc.b    $00, $01, $00, $00, $02, $02, $02, $02
                dc.b    $02, $02, $FD, $00
Offset_0x019BFB:
                dc.b    $0F, $03, $FF
Offset_0x019BFE:
                dc.b    $00, $04, $03, $03, $05, $05, $05, $05
                dc.b    $05, $05, $FD, $02
Offset_0x019C0A:
                dc.b    $0F, $07, $FF
Offset_0x019C0D:
                dc.b    $00, $08, $07, $07, $09, $09, $09, $09
                dc.b    $09, $09, $FD, $04, $00  
;------------------------------------------------------------------------------- 
Springs_Mappings:                                              ; Offset_0x019C1A  
                dc.w    Offset_0x019C46-Springs_Mappings
                dc.w    Offset_0x019C54-Springs_Mappings
                dc.w    Offset_0x019C5C-Springs_Mappings
                dc.w    Offset_0x019C8E-Springs_Mappings
                dc.w    Offset_0x019C9C-Springs_Mappings
                dc.w    Offset_0x019CA4-Springs_Mappings
                dc.w    Offset_0x019CD6-Springs_Mappings
                dc.w    Offset_0x019CF2-Springs_Mappings
                dc.w    Offset_0x019D0C-Springs_Mappings
                dc.w    Offset_0x019D20-Springs_Mappings
                dc.w    Offset_0x019D40-Springs_Mappings   
;-------------------------------------------------------------------------------
Springs_Mappings_01:                                           ; Offset_0x019C30 
                dc.w    Offset_0x019C6A-Springs_Mappings_01
                dc.w    Offset_0x019C78-Springs_Mappings_01
                dc.w    Offset_0x019C80-Springs_Mappings_01
                dc.w    Offset_0x019CB2-Springs_Mappings_01
                dc.w    Offset_0x019CC0-Springs_Mappings_01
                dc.w    Offset_0x019CC8-Springs_Mappings_01
                dc.w    Offset_0x019CE4-Springs_Mappings_01
                dc.w    Offset_0x019D5A-Springs_Mappings_01
                dc.w    Offset_0x019D74-Springs_Mappings_01
                dc.w    Offset_0x019D88-Springs_Mappings_01
                dc.w    Offset_0x019DA8-Springs_Mappings_01
Offset_0x019C46:
                dc.w    $0002
                dc.w    $F80C, $0000, $FFF0
                dc.w    $0004, $0008, $FFF8
Offset_0x019C54:
                dc.w    $0001
                dc.w    $000C, $0000, $FFF0
Offset_0x019C5C:
                dc.w    $0002
                dc.w    $E80C, $0000, $FFF0
                dc.w    $F006, $000A, $FFF8
Offset_0x019C6A:
                dc.w    $0002
                dc.w    $F80C, $2004, $FFF0
                dc.w    $0004, $0008, $FFF8   
Offset_0x019C78:
                dc.w    $0001
                dc.w    $000C, $2004, $FFF0      
Offset_0x019C80:
                dc.w    $0002
                dc.w    $E80C, $2004, $FFF0
                dc.w    $F006, $000A, $FFF8                                       
Offset_0x019C8E:
                dc.w    $0002
                dc.w    $F003, $0000, $0000
                dc.w    $F801, $0008, $FFF8
Offset_0x019C9C:
                dc.w    $0001
                dc.w    $F003, $0000, $FFF8
Offset_0x019CA4:
                dc.w    $0002
                dc.w    $F003, $0000, $0010
                dc.w    $F809, $000A, $FFF8
Offset_0x019CB2:
                dc.w    $0002
                dc.w    $F003, $2004, $0000
                dc.w    $F801, $0008, $FFF8 
Offset_0x019CC0:
                dc.w    $0001
                dc.w    $F003, $2004, $FFF8
Offset_0x019CC8:
                dc.w    $0002
                dc.w    $F003, $2004, $0010
                dc.w    $F809, $000A, $FFF8                               
Offset_0x019CD6:
                dc.w    $0002
                dc.w    $000C, $1000, $FFF0
                dc.w    $F804, $1008, $FFF8
Offset_0x019CE4:
                dc.w    $0002
                dc.w    $000C, $3004, $FFF0
                dc.w    $F804, $1008, $FFF8                
Offset_0x019CF2:
                dc.w    $0004
                dc.w    $F108, $0000, $FFEB
                dc.w    $F908, $0003, $FFF3
                dc.w    $0105, $0006, $FFFB
                dc.w    $FB05, $0014, $FFF1
Offset_0x019D0C:
                dc.w    $0003
                dc.w    $F708, $0000, $FFE6
                dc.w    $FF08, $0003, $FFEE
                dc.w    $0705, $0006, $FFF6
Offset_0x019D20:
                dc.w    $0005
                dc.w    $E608, $0000, $FFF6
                dc.w    $EE08, $0003, $FFFE
                dc.w    $F605, $0006, $0006
                dc.w    $F504, $0018, $FFFA
                dc.w    $FD04, $001A, $FFF2
Offset_0x019D40:
                dc.w    $0004
                dc.w    $0708, $1000, $FFEB
                dc.w    $FF08, $1003, $FFF3
                dc.w    $EF05, $1006, $FFFB
                dc.w    $F505, $1014, $FFF1      
Offset_0x019D5A:
                dc.w    $0004
                dc.w    $F108, $200A, $FFEB
                dc.w    $F908, $200D, $FFF3
                dc.w    $0105, $2010, $FFFB
                dc.w    $FB05, $0014, $FFF1
Offset_0x019D74:
                dc.w    $0003
                dc.w    $F708, $200A, $FFE6
                dc.w    $FF08, $200D, $FFEE
                dc.w    $0705, $2010, $FFF6
Offset_0x019D88:
                dc.w    $0005
                dc.w    $E608, $200A, $FFF6
                dc.w    $EE08, $200D, $FFFE
                dc.w    $F605, $2010, $0006
                dc.w    $F504, $0018, $FFFA
                dc.w    $FD04, $001A, $FFF2
Offset_0x019DA8:
                dc.w    $0004
                dc.w    $0708, $300A, $FFEB
                dc.w    $FF08, $300D, $FFF3
                dc.w    $EF05, $3010, $FFFB
                dc.w    $F505, $1014, $FFF1    
;-------------------------------------------------------------------------------   
Springs_Mappings_2P:                                           ; Offset_0x019DC2  
                dc.w    Offset_0x019DDE-Springs_Mappings_2P
                dc.w    Offset_0x019DEC-Springs_Mappings_2P
                dc.w    Offset_0x019DF4-Springs_Mappings_2P
                dc.w    Offset_0x019E08-Springs_Mappings_2P
                dc.w    Offset_0x019E16-Springs_Mappings_2P
                dc.w    Offset_0x019E1E-Springs_Mappings_2P
                dc.w    Offset_0x019E32-Springs_Mappings_2P
;------------------------------------------------------------------------------- 
Springs_Mappings_01_2P:                                        ; Offset_0x019DD0
                dc.w    Offset_0x019E40-Springs_Mappings_01_2P
                dc.w    Offset_0x019E4E-Springs_Mappings_01_2P
                dc.w    Offset_0x019E56-Springs_Mappings_01_2P
                dc.w    Offset_0x019E6A-Springs_Mappings_01_2P
                dc.w    Offset_0x019E78-Springs_Mappings_01_2P
                dc.w    Offset_0x019E80-Springs_Mappings_01_2P
                dc.w    Offset_0x019E94-Springs_Mappings_01_2P
Offset_0x019DDE:
                dc.w    $0002
                dc.w    $F608, $0000, $FFF4
                dc.w    $FB08, $0006, $FFF4
Offset_0x019DEC:
                dc.w    $0001
                dc.w    $FB08, $0000, $FFF4
Offset_0x019DF4:
                dc.w    $0003
                dc.w    $F108, $0000, $FFF4
                dc.w    $F300, $0009, $FFFC
                dc.w    $FB08, $000A, $FFF4
Offset_0x019E08:
                dc.w    $0002
                dc.w    $F402, $0800, $0002
                dc.w    $F402, $0806, $FFFD
Offset_0x019E16:
                dc.w    $0001
                dc.w    $F402, $0800, $FFFD
Offset_0x019E1E:
                dc.w    $0003
                dc.w    $F402, $0800, $0007
                dc.w    $FC00, $0809, $0005
                dc.w    $F402, $080A, $FFFD
Offset_0x019E32:
                dc.w    $0002
                dc.w    $0208, $1000, $FFF4
                dc.w    $FD08, $1006, $FFF4                                                       
Offset_0x019E40:
                dc.w    $0002
                dc.w    $F608, $0003, $FFF4
                dc.w    $FB08, $0006, $FFF4
Offset_0x019E4E:
                dc.w    $0001
                dc.w    $FB08, $0003, $FFF4
Offset_0x019E56:
                dc.w    $0003
                dc.w    $F108, $0003, $FFF4
                dc.w    $F300, $0009, $FFFC
                dc.w    $FB08, $000A, $FFF4
Offset_0x019E6A:
                dc.w    $0002
                dc.w    $F402, $0803, $0002
                dc.w    $F402, $0806, $FFFD
Offset_0x019E78:
                dc.w    $0001
                dc.w    $F402, $0803, $FFFD
Offset_0x019E80:
                dc.w    $0003
                dc.w    $F402, $0803, $0007
                dc.w    $FC00, $0809, $0005
                dc.w    $F402, $080A, $FFFD
Offset_0x019E94:
                dc.w    $0002
                dc.w    $0208, $1003, $FFF4
                dc.w    $FD08, $1006, $FFF4                                                         
;===============================================================================
; Objeto 0x07 - Molas amarelas / vermelhas - diagonal / horizontal / vertical 
; <<<-  
;===============================================================================  