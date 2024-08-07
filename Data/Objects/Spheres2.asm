;-------------------------------------------------------------------------------
; Esferas no modo de teste do est�gio especial 
; ->>>
;------------------------------------------------------------------------------- 
; Offset_0x007256:
                lea     (Offset_0x0075C8), A6
                move.l  A0, A1
                move.l  #Branch_To_SS_Obj_Sphere_Test_Main_2, (A1) ; Offset_0x00733E
                move.w  #$0000, (Art_Scaling_Data_Buffer+$16).w      ; $FFFFF756
                move.w  #$0000, (Art_Scaling_Data_Buffer+$18).w      ; $FFFFF758
                move.w  #$0100, (Art_Scaling_Data_Buffer+$1A).w      ; $FFFFF75A
                move.w  #$0000, (Screen_Pos_Buffer_Y).w              ; $FFFFEE84
                move.w  #$FFFF, (Screen_Wrap_Y).w                    ; $FFFFEEAA
                move.w  #$002B, (Art_Scaling_Index_0).w              ; $FFFFF744
                move.w  #$0000, (Art_Scaling_Index_1).w              ; $FFFFF746
                move.w  #$0000, (Art_Scaling_Index_2).w              ; $FFFFF748
                move.w  #$2B00, Obj_Control_Var_10(A1)                   ; $0040
                move.w  #$0000, Obj_Control_Var_12(A1)                   ; $0042
                move.w  #$0000, Obj_Control_Var_14(A1)                   ; $0044
                move.w  #$FF90, D3
                moveq   #$07, D1
                move.w  #$FF90, D4
                moveq   #$07, D2
                bra.s   Offset_0x0072D0            
;-------------------------------------------------------------------------------
; Offset_0x0072B4:
                move.w  #$FF90, D3
                moveq   #$07, D1
Offset_0x0072BA:
                move.w  #$FF90, D4
                moveq   #$07, D2
Offset_0x0072C0:
                jsr     (SS_AllocateObject)                  ; Offset_0x0067D0
                bne     Offset_0x0072FA
                move.l  #SS_Obj_Eosian_Sphere_2, (A1)          ; Offset_0x00753A
Offset_0x0072D0:
                bsr     Offset_0x0072FE
                move.w  D3, Obj_Control_Var_04(A1)                       ; $0034
                move.w  D4, Obj_Control_Var_06(A1)                       ; $0036
                move.w  #$0000, Obj_Control_Var_08(A1)                   ; $0038
                move.l  A6, Obj_Control_Var_0A(A1)                       ; $003A
                adda.w  #$0002, A6
                addi.w  #$0020, D4
                dbra    D2, Offset_0x0072C0
                addi.w  #$0020, D3
                dbra    D1, Offset_0x0072BA
Offset_0x0072FA:
                bra     Branch_To_SS_Obj_Sphere_Test_Main_2    ; Offset_0x00733E
;-------------------------------------------------------------------------------                
Offset_0x0072FE:
                move.b  #$04, Obj_Flags(A1)                              ; $0004
                move.b  #$10, Obj_Width(A1)                              ; $0007
                move.b  #$10, Obj_Height(A1)                             ; $0006
                move.w  #$0200, Obj_Priority(A1)                         ; $0008
                move.l  #Spheres_2_Mappings, Obj_Map(A1) ; Offset_0x0078EC, $000C
                move.w  #$A400, Obj_Art_VRAM(A1)                         ; $000A
                move.w  Obj_X(A0), Obj_X(A1)                      ; $0010, $0010
                move.w  Obj_X(A0), Obj_Control_Var_00(A1)         ; $0010, $0030
                move.w  Obj_Y(A0), Obj_Y(A1)                      ; $0014, $0014
                move.w  Obj_Y(A0), Obj_Control_Var_02(A1)         ; $0014, $0032
                rts
;-------------------------------------------------------------------------------                
Branch_To_SS_Obj_Sphere_Test_Main_2:                           ; Offset_0x00733E
                bra     SS_Obj_Sphere_Test_Main_2              ; Offset_0x0073CA
;-------------------------------------------------------------------------------
; Offset_0x007342:
                move.b  (Control_Ports_Buffer_Data).w, D2            ; $FFFFF604
                move.w  Obj_Control_Var_16(A0), D0                       ; $0046
                btst    #$00, D2
                beq.s   Offset_0x00735E
                subi.w  #$0010, D0
                cmpi.w  #$FE00, D0
                bge.s   Offset_0x00735E
                move.w  #$FE00, D0
Offset_0x00735E:
                btst    #$01, D2
                beq.s   Offset_0x007372
                addi.w  #$0020, D0
                cmpi.w  #$0100, D0
                blt.s   Offset_0x007372
                move.w  #$0100, D0
Offset_0x007372:
                move.w  D0, Obj_Control_Var_16(A0)                       ; $0046
                move.w  Obj_Control_Var_16(A0), D0                       ; $0046
                add.w   D0, Obj_Control_Var_10(A0)                       ; $0040
                move.b  Obj_Control_Var_10(A0), (Art_Scaling_Index_0+$01).w ; $0040, $FFFFF745
                move.w  (Art_Scaling_Index_0).w, D0                  ; $FFFFF744
                bsr     CalcSine                               ; Offset_0x001B20
                add.w   D0, D0
                add.w   D1, D1
                btst    #$02, D2
                beq.s   Offset_0x0073AA
                add.w   D1, Obj_Control_Var_12(A0)                       ; $0042
                add.w   D0, Obj_Control_Var_14(A0)                       ; $0044
                move.b  Obj_Control_Var_12(A0), (Art_Scaling_Index_1+$01).w ; $0042, $FFFFF747
                move.b  Obj_Control_Var_14(A0), (Art_Scaling_Index_2+$01).w ; $0044, $FFFFF749
Offset_0x0073AA:
                btst    #$03, D2
                beq.s   Offset_0x0073C4
                sub.w   D1, Obj_Control_Var_12(A0)                       ; $0042
                sub.w   D0, Obj_Control_Var_14(A0)                        ; $0044
                move.b  Obj_Control_Var_12(A0), (Art_Scaling_Index_1+$01).w ; $0042, $FFFFF747
                move.b  Obj_Control_Var_14(A0), (Art_Scaling_Index_2+$01).w ; $0044, $FFFFF749
Offset_0x0073C4:
                move.b  (Control_Ports_Buffer_Data).w, D1            ; $FFFFF604
                bra.s   Offset_0x0073F6
;-------------------------------------------------------------------------------                
SS_Obj_Sphere_Test_Main_2:                                     ; Offset_0x0073CA
                move.b  (Control_Ports_Buffer_Data).w, D1            ; $FFFFF604
                btst    #$00, D1
                beq.s   Offset_0x0073D8
                subq.w  #$01, (Art_Scaling_Index_0).w                ; $FFFFF744
Offset_0x0073D8:
                btst    #$01, D1
                beq.s   Offset_0x0073E2
                addq.w  #$01, (Art_Scaling_Index_0).w                ; $FFFFF744
Offset_0x0073E2:
                btst    #$02, D1
                beq.s   Offset_0x0073EC
                subq.w  #$01, (Art_Scaling_Index_1).w                ; $FFFFF746
Offset_0x0073EC:
                btst    #$03, D1
                beq.s   Offset_0x0073F6
                addq.w  #$01, (Art_Scaling_Index_1).w                ; $FFFFF746
Offset_0x0073F6:
                btst    #$05, D1
                beq.s   Offset_0x007400
                subq.w  #$01, (Art_Scaling_Index_2).w                ; $FFFFF748
Offset_0x007400:
                btst    #$06, D1
                beq.s   Offset_0x00740A
                addq.w  #$01, (Art_Scaling_Index_2).w                ; $FFFFF748
Offset_0x00740A:
                move.b  (Control_Ports_Buffer_Data+$01).w, D1        ; $FFFFF605
                btst    #$04, D1
                beq.s   Offset_0x007444
                eori.w  #$FFFF, (Art_Scaling_Address).w              ; $FFFFF75C
                move.w  #$002B, (Art_Scaling_Index_0).w              ; $FFFFF744
                move.w  #$0000, (Art_Scaling_Index_1).w              ; $FFFFF746
                move.w  #$0000, (Art_Scaling_Index_2).w              ; $FFFFF748
                move.w  #$2B00, Obj_Control_Var_10(A0)                   ; $0040
                move.w  #$0000, Obj_Control_Var_12(A0)                   ; $0042
                move.w  #$0000, Obj_Control_Var_14(A0)                   ; $0044
                move.w  #$0000, Obj_Control_Var_16(A0)                   ; $0046
Offset_0x007444:
                move.b  (Control_Ports_Buffer_Data+$02).w, D1        ; $FFFFF606
                btst    #$06, D1
                beq.s   Offset_0x00745A
                cmpi.w  #$0800, (Art_Scaling_Data_Buffer+$1A).w      ; $FFFFF75A
                bcc.s   Offset_0x00745A
                addq.w  #$08, (Art_Scaling_Data_Buffer+$1A).w        ; $FFFFF75A
Offset_0x00745A:
                btst    #$05, D1
                beq.s   Offset_0x00746C
                cmpi.w  #$0081, (Art_Scaling_Data_Buffer+$1A).w      ; $FFFFF75A
                bcs.s   Offset_0x00746C
                subq.w  #$08, (Art_Scaling_Data_Buffer+$1A).w        ; $FFFFF75A
Offset_0x00746C:
                tst.w   Obj_Control_Var_0E(A0)                           ; $003E
                bne.s   Offset_0x007490
                btst    #$00, D1
                beq.s   Offset_0x00747C
                addq.w  #$02, (Art_Scaling_Index_0).w                ; $FFFFF744
Offset_0x00747C:
                btst    #$03, D1
                beq.s   Offset_0x007486
                addq.w  #$02, (Art_Scaling_Index_1).w                ; $FFFFF746
Offset_0x007486:
                btst    #$04, D1
                bne.s   Offset_0x007490
                addq.w  #$02, (Art_Scaling_Index_2).w                ; $FFFFF748
Offset_0x007490:
                btst    #$07, (Control_Ports_Buffer_Data+$01).w      ; $FFFFF605
                bne.s   Offset_0x0074A0
                btst    #$07, (Control_Ports_Buffer_Data+$03).w      ; $FFFFF607
                beq.s   Offset_0x0074DE
Offset_0x0074A0:
                eori.w  #$FFFF, Obj_Control_Var_0E(A0)                   ; $003E
                move.w  #$002B, (Art_Scaling_Index_0).w              ; $FFFFF744
                move.w  #$0000, (Art_Scaling_Index_1).w              ; $FFFFF746
                move.w  #$0000, (Art_Scaling_Index_2).w              ; $FFFFF748
                move.w  #$2B00, Obj_Control_Var_10(A0)                   ; $0040
                move.w  #$0000, Obj_Control_Var_12(A0)                   ; $0042
                move.w  #$0000, Obj_Control_Var_14(A0)                   ; $0044
                move.w  #$0000, Obj_Control_Var_16(A0)                   ; $0046
                btst    #$06, (Control_Ports_Buffer_Data).w          ; $FFFFF604
                beq.s   Offset_0x0074DE
                move.b  #$04, (Game_Mode).w                          ; $FFFFF600
Offset_0x0074DE:
                btst    #$01, D1
                bne.s   Offset_0x0074E8
                addq.w  #$08, (Art_Scaling_Data_Buffer+$18).w        ; $FFFFF758
Offset_0x0074E8:
                btst    #$00, D1
                bne.s   Offset_0x0074F2
                subq.w  #$08, (Art_Scaling_Data_Buffer+$18).w        ; $FFFFF758
Offset_0x0074F2:
                btst    #$02, D1
                bne.s   Offset_0x0074FC
                addq.w  #$08, (Screen_Pos_Buffer_Y).w                ; $FFFFEE84
Offset_0x0074FC:
                btst    #$03, D1
                bne.s   Offset_0x007506
                subq.w  #$08, (Screen_Pos_Buffer_Y).w                ; $FFFFEE84
Offset_0x007506:
                move.w  (Art_Scaling_Index_2).w, D0                  ; $FFFFF748
                lea     (Art_Scaling_Result_2).w, A1                 ; $FFFFF752
                bsr     SS_2_Get_Scalars                       ; Offset_0x0076D4
                move.w  (Art_Scaling_Index_1).w, D0                  ; $FFFFF746
                lea     (Art_Scaling_Result_1).w, A1                 ; $FFFFF74E
                bsr     SS_2_Get_Scalars                       ; Offset_0x0076D4
                move.w  (Art_Scaling_Index_0).w, D0                  ; $FFFFF744
                lea     (Art_Scaling_Result_0).w, A1                 ; $FFFFF74A
                bsr     SS_2_Get_Scalars                       ; Offset_0x0076D4
                move.w  Obj_Timer(A0), D0                                ; $002E
                bsr     CalcSine                               ; Offset_0x001B20
                move.w  D0, (Art_Scaling_Address+$02).w              ; $FFFFF75E
                addq.w  #$04, Obj_Timer(A0)                              ; $002E
;-------------------------------------------------------------------------------                
SS_Obj_Eosian_Sphere_2:                                        ; Offset_0x00753A                
                move.l  Obj_Control_Var_0A(A0), A6                       ; $003A
                move.w  (A6), D0
                move.w  (Art_Scaling_Address+$02).w, D3              ; $FFFFF75E
                muls.w  D3, D0
                asr.w   #$08, D0
                move.w  Obj_Control_Var_04(A0), D1                       ; $0034
                move.w  Obj_Control_Var_06(A0), D2                       ; $0036
                tst.w   (Art_Scaling_Address).w                      ; $FFFFF75C
                beq.s   Offset_0x00755E
                muls.w  D3, D2
                asr.w   #$08, D2
                muls.w  D3, D1
                asr.w   #$08, D1
Offset_0x00755E:
                bsr     Offset_0x007680
                bsr     Offset_0x007656
                bsr     Offset_0x0076AA
                bclr    #$07, Obj_Art_VRAM(A0)                           ; $000A
                cmpi.w  #$0080, D0
                bge.s   Offset_0x00757C
                bset    #$07, Obj_Art_VRAM(A0)                           ; $000A
Offset_0x00757C:
                add.w   (Art_Scaling_Data_Buffer+$1A).w, D0          ; $FFFFF75A
                cmpi.w  #$0080, D0
                blt.s   Offset_0x0075C6
                add.w   (Art_Scaling_Data_Buffer+$18).w, D2          ; $FFFFF758
                bsr     Offset_0x007648
                add.w   Obj_Control_Var_00(A0), D1                       ; $0030
                move.w  D1, Obj_X(A0)                                    ; $0010
                add.w   Obj_Control_Var_02(A0), D2                       ; $0032
                move.w  D2, Obj_Y(A0)                                    ; $0014
                subi.w  #$0080, D0
                lsr.w   #$05, D0
                addi.w  #$0006, D0
                cmpi.w  #$0010, D0
                bcs.s   Offset_0x0075B2
                move.w  #$000F, D0
Offset_0x0075B2:
                move.b  D0, Obj_Map_Id(A0)                               ; $0022
                lsl.w   #$06, D0
                andi.w  #$0380, D0
                move.w  D0, Obj_Priority(A0)                             ; $0008
                jsr     (DisplaySprite)                        ; Offset_0x011148
Offset_0x0075C6:
                rts    
;-------------------------------------------------------------------------------
Offset_0x0075C8:
                dc.w    $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
                dc.w    $0000, $0010, $0010, $0010, $0010, $0010, $0010, $0000
                dc.w    $0000, $0010, $0020, $0020, $0020, $0020, $0010, $0000
                dc.w    $0000, $0010, $0020, $0030, $0030, $0020, $0010, $0000
                dc.w    $0000, $0010, $0020, $0030, $0030, $0020, $0010, $0000
                dc.w    $0000, $0010, $0020, $0020, $0020, $0020, $0010, $0000
                dc.w    $0000, $0010, $0010, $0010, $0010, $0010, $0010, $0000
                dc.w    $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000  
;-------------------------------------------------------------------------------
Offset_0x007648:
                ext.l   D1
                lsl.l   #$08, D1
                divs.w  D0, D1
                ext.l   D2
                lsl.l   #$08, D2
                divs.w  D0, D2
                rts
Offset_0x007656:
                swap.w  D0
                move.w  D1, D3
                move.w  D2, D4
                move.w  (Art_Scaling_Result_2).w, D0                 ; $FFFFF752
                muls.w  D0, D3
                muls.w  D0, D4
                move.w  (Art_Scaling_Result_2+$02).w, D0             ; $FFFFF754
                muls.w  D0, D1
                muls.w  D0, D2
                sub.l   D4, D1
                add.l   D1, D1
                add.l   D1, D1
                swap.w  D1
                add.l   D3, D2
                add.l   D2, D2
                add.l   D2, D2
                swap.w  D2
                swap.w  D0
                rts
Offset_0x007680:
                swap.w  D2
                move.w  D0, D3
                move.w  D1, D4
                move.w  (Art_Scaling_Result_1).w, D2                 ; $FFFFF74E
                muls.w  D2, D3
                muls.w  D2, D4
                move.w  (Art_Scaling_Result_1+$02).w, D2             ; $FFFFF750
                muls.w  D2, D0
                muls.w  D2, D1
                sub.l   D4, D0
                add.l   D0, D0
                add.l   D0, D0
                swap.w  D0
                add.l   D3, D1
                add.l   D1, D1
                add.l   D1, D1
                swap.w  D1
                swap.w  D2
                rts
Offset_0x0076AA:
                swap.w  D1
                move.w  D0, D3
                move.w  D2, D4
                move.w  (Art_Scaling_Result_0).w, D1                 ; $FFFFF74A
                muls.w  D1, D3
                muls.w  D1, D4
                move.w  (Art_Scaling_Result_0+$02).w, D1             ; $FFFFF74C
                muls.w  D1, D0
                muls.w  D1, D2
                sub.l   D4, D0
                add.l   D0, D0
                add.l   D0, D0
                swap.w  D0
                add.l   D3, D2
                add.l   D2, D2
                add.l   D2, D2
                swap.w  D2
                swap.w  D1
                rts   
;-------------------------------------------------------------------------------
SS_2_Get_Scalars:                                              ; Offset_0x0076D4
                add.w   D0, D0
                andi.w  #$01FE, D0
                move.w  SS_2_Scalar_Table(PC, D0), (A1)+       ; Offset_0x0076EC
                addi.w  #$0080, D0
                andi.w  #$01FE, D0
                move.w  SS_2_Scalar_Table(PC, D0), (A1)+       ; Offset_0x0076EC
                rts   
;-------------------------------------------------------------------------------
SS_2_Scalar_Table:                                             ; Offset_0x0076EC
                dc.w    $0000, $0192, $0324, $04B5, $0646, $07D6, $0964, $0AF1
                dc.w    $0C7C, $0E06, $0F8D, $1112, $1294, $1413, $1590, $1709
                dc.w    $187E, $19EF, $1B5D, $1CC6, $1E2B, $1F8C, $20E7, $223D
                dc.w    $238E, $24DA, $2620, $2760, $289A, $29CE, $2AFB, $2C21
                dc.w    $2D41, $2E5A, $2F6C, $3076, $3179, $3274, $3368, $3453
                dc.w    $3537, $3612, $36E5, $37B0, $3871, $392B, $39DB, $3A82
                dc.w    $3B21, $3BB6, $3C42, $3CC5, $3D3F, $3DAF, $3E15, $3E72
                dc.w    $3EC5, $3F0F, $3F4F, $3F85, $3FB1, $3FD4, $3FEC, $3FFB
                dc.w    $4000, $3FFB, $3FEC, $3FD4, $3FB1, $3F85, $3F4F, $3F0F
                dc.w    $3EC5, $3E72, $3E15, $3DAF, $3D3F, $3CC5, $3C42, $3BB6
                dc.w    $3B21, $3A82, $39DB, $392B, $3871, $37B0, $36E5, $3612
                dc.w    $3537, $3453, $3368, $3274, $3179, $3076, $2F6C, $2E5A
                dc.w    $2D41, $2C21, $2AFB, $29CE, $289A, $2760, $2620, $24DA
                dc.w    $238E, $223D, $20E7, $1F8C, $1E2B, $1CC6, $1B5D, $19EF
                dc.w    $187E, $1709, $1590, $1413, $1294, $1112, $0F8D, $0E06
                dc.w    $0C7C, $0AF1, $0964, $07D6, $0646, $04B5, $0324, $0192
                dc.w    $0000, $FE6E, $FCDC, $FB4B, $F9BA, $F82A, $F69C, $F50F
                dc.w    $F384, $F1FA, $F073, $EEEE, $ED6C, $EBED, $EA70, $E8F7
                dc.w    $E782, $E611, $E4A3, $E33A, $E1D5, $E074, $DF19, $DDC3
                dc.w    $DC72, $DB26, $D9E0, $D8A0, $D766, $D632, $D505, $D3DF
                dc.w    $D2BF, $D1A6, $D094, $CF8A, $CE87, $CD8C, $CC98, $CBAD
                dc.w    $CAC9, $C9EE, $C91B, $C850, $C78F, $C6D5, $C625, $C57E
                dc.w    $C4DF, $C44A, $C3BE, $C33B, $C2C1, $C251, $C1EB, $C18E
                dc.w    $C13B, $C0F1, $C0B1, $C07B, $C04F, $C02C, $C014, $C005
                dc.w    $C000, $C005, $C014, $C02C, $C04F, $C07B, $C0B1, $C0F1
                dc.w    $C13B, $C18E, $C1EB, $C251, $C2C1, $C33B, $C3BE, $C44A
                dc.w    $C4DF, $C57E, $C625, $C6D5, $C78F, $C850, $C91B, $C9EE
                dc.w    $CAC9, $CBAD, $CC98, $CD8C, $CE87, $CF8A, $D094, $D1A6
                dc.w    $D2BF, $D3DF, $D505, $D632, $D766, $D8A0, $D9E0, $DB26
                dc.w    $DC72, $DDC3, $DF19, $E074, $E1D5, $E33A, $E4A3, $E611
                dc.w    $E782, $E8F7, $EA70, $EBED, $ED6C, $EEEE, $F073, $F1FA
                dc.w    $F384, $F50F, $F69C, $F82A, $F9BA, $FB4B, $FCDC, $FE6E  
;-------------------------------------------------------------------------------
Spheres_2_Mappings:                                            ; Offset_0x0078EC
                dc.w    Offset_0x00790C-Spheres_2_Mappings
                dc.w    Offset_0x007914-Spheres_2_Mappings
                dc.w    Offset_0x00791C-Spheres_2_Mappings
                dc.w    Offset_0x007924-Spheres_2_Mappings
                dc.w    Offset_0x00792C-Spheres_2_Mappings
                dc.w    Offset_0x007934-Spheres_2_Mappings
                dc.w    Offset_0x00793C-Spheres_2_Mappings
                dc.w    Offset_0x007944-Spheres_2_Mappings
                dc.w    Offset_0x00794C-Spheres_2_Mappings
                dc.w    Offset_0x007954-Spheres_2_Mappings
                dc.w    Offset_0x00795C-Spheres_2_Mappings
                dc.w    Offset_0x007964-Spheres_2_Mappings
                dc.w    Offset_0x00796C-Spheres_2_Mappings
                dc.w    Offset_0x007974-Spheres_2_Mappings
                dc.w    Offset_0x00797C-Spheres_2_Mappings
                dc.w    Offset_0x007984-Spheres_2_Mappings
Offset_0x00790C:
                dc.w    $0001
                dc.w    $F00F, $0000, $FFF0
Offset_0x007914:
                dc.w    $0001
                dc.w    $F00F, $0010, $FFF0
Offset_0x00791C:
                dc.w    $0001
                dc.w    $F00F, $0020, $FFF0
Offset_0x007924:
                dc.w    $0001
                dc.w    $F00F, $0030, $FFF0
Offset_0x00792C:
                dc.w    $0001
                dc.w    $F00F, $0040, $FFF0
Offset_0x007934:
                dc.w    $0001
                dc.w    $F00F, $0050, $FFF0
Offset_0x00793C:
                dc.w    $0001
                dc.w    $F00F, $0060, $FFF0
Offset_0x007944:
                dc.w    $0001
                dc.w    $F00F, $0070, $FFF0
Offset_0x00794C:
                dc.w    $0001
                dc.w    $F805, $0080, $FFF8
Offset_0x007954:
                dc.w    $0001
                dc.w    $F805, $0084, $FFF8
Offset_0x00795C:
                dc.w    $0001
                dc.w    $F805, $0088, $FFF8
Offset_0x007964:
                dc.w    $0001
                dc.w    $F805, $008C, $FFF8
Offset_0x00796C:
                dc.w    $0001
                dc.w    $F805, $0090, $FFF8
Offset_0x007974:
                dc.w    $0001
                dc.w    $F805, $0094, $FFF8
Offset_0x00797C:
                dc.w    $0001
                dc.w    $F805, $0098, $FFF8
Offset_0x007984:
                dc.w    $0001
                dc.w    $F805, $009C, $FFF8
;-------------------------------------------------------------------------------
; Esferas no modo de teste do est�gio especial
; <<<-
;-------------------------------------------------------------------------------