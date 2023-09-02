;===============================================================================
; Objeto 0x1A - Objeto desconhecido que pode ser girado usando o 2º controle
; ->>>           
;===============================================================================
; Offset_0x01DFCE:
                move.l  #Unknow_Controled_By_P2_Mappings, Obj_Map(A0) ; Offset_0x01E2AC, $000C
                move.w  #$43C3, Obj_Art_VRAM(A0)                         ; $000A
                ori.b   #$04, Obj_Flags(A0)                              ; $0004
                move.b  #$40, Obj_Width(A0)                              ; $0007
                move.b  #$40, Obj_Height(A0)                             ; $0006
                move.w  #$0200, Obj_Priority(A0)                         ; $0008
                move.b  #$80, Obj_Control_Var_12(A0)                     ; $0042
                move.b  #$01, Obj_Map_Id(A0)                             ; $0022
                jsr     (SingleObjectLoad_A0)                  ; Offset_0x011DE0
                bne     Offset_0x01E058
                move.l  #Offset_0x01E0A8, (A1)
                move.l  #Unknow_Controled_By_P2_Mappings, Obj_Map(A1) ; Offset_0x01E2AC, $000C
                move.w  #$43C3, Obj_Art_VRAM(A1)                         ; $000A
                ori.b   #$04, Obj_Flags(A1)                              ; $0004
                move.b  #$40, Obj_Width(A1)                              ; $0007
                move.b  #$40, Obj_Height(A1)                             ; $0006
                move.w  #$0200, Obj_Priority(A1)                         ; $0008
                move.w  Obj_X(A0), Obj_X(A1)                      ; $0010, $0010
                move.w  Obj_Y(A0), Obj_Y(A1)                      ; $0014, $0014
                move.b  #$80, Obj_Control_Var_12(A1)                     ; $0042
                bset    #$06, Obj_Flags(A1)                              ; $0004
                move.w  #$0006, Obj_Sub_Y(A1)                            ; $0016
                move.w  A0, Obj_Control_Var_0C(A1)                       ; $003C
Offset_0x01E058:
                move.b  #$10, Obj_Control_Var_12(A0)                     ; $0042
                move.l  #Offset_0x01E064, (A0)
Offset_0x01E064:                
                btst    #$04, (Control_Ports_Buffer_Data+$02).w      ; $FFFFF606
                beq.s   Offset_0x01E072
                move.b  #$00, Obj_Control_Var_12(A0)                     ; $0042
Offset_0x01E072:
                btst    #$05, (Control_Ports_Buffer_Data+$02).w      ; $FFFFF606
                beq.s   Offset_0x01E080
                addi.b  #$01, Obj_Control_Var_12(A0)                     ; $0042
Offset_0x01E080:
                btst    #$06, (Control_Ports_Buffer_Data+$02).w      ; $FFFFF606
                beq.s   Offset_0x01E08E
                subi.b  #$01, Obj_Control_Var_12(A0)                     ; $0042
Offset_0x01E08E:
                moveq   #$00, D1
                move.b  Obj_Width(A0), D1                                ; $0007
                moveq   #$08, D2
                move.w  D2, D3
                addq.w  #$01, D3
                move.w  Obj_X(A0), D4                                    ; $0010
                bsr     Offset_0x01E138
                jmp     (MarkObjGone)                          ; Offset_0x011AF2
;-------------------------------------------------------------------------------
Offset_0x01E0A8:
                move.w  Obj_Control_Var_0C(A0), A1                       ; $003C
                move.b  Obj_Control_Var_12(A1), Obj_Control_Var_12(A0) ; $0042, $0042
                bsr     Offset_0x01E0BC
                jmp     (MarkObjGone)                          ; Offset_0x011AF2
Offset_0x01E0BC:
                move.b  Obj_Control_Var_12(A0), D0                       ; $0042
                jsr     (CalcSine)                             ; Offset_0x001B20
                move.w  Obj_Y(A0), D2                                    ; $0014
                move.w  Obj_X(A0), D3                                    ; $0010
                swap.w  D0
                swap.w  D1
                asr.l   #$05, D0
                asr.l   #$05, D1
                move.l  D0, D4
                move.l  D1, D5
                add.l   D0, D0
                add.l   D1, D1
                movem.l D0-D5, -(A7)
                add.l   D0, D4
                add.l   D1, D5
                lea     Obj_Speed_X(A0), A2                              ; $0018
                moveq   #$02, D6
Offset_0x01E0EC:
                movem.l D4/D5, -(A7)
                swap.w  D4
                swap.w  D5
                add.w   D2, D4
                add.w   D3, D5
                move.w  D5, (A2)+
                move.w  D4, (A2)+
                movem.l (A7)+, D4/D5
                add.l   D0, D4
                add.l   D1, D5
                addq.w  #$02, A2
                dbra    D6, Offset_0x01E0EC
                movem.l (A7)+, D0-D5
                neg.l   D4
                neg.l   D5
                sub.l   D0, D4
                sub.l   D1, D5
                moveq   #$02, D6
Offset_0x01E118:
                movem.l D4/D5, -(A7)
                swap.w  D4
                swap.w  D5
                add.w   D2, D4
                add.w   D3, D5
                move.w  D5, (A2)+
                move.w  D4, (A2)+
                movem.l (A7)+, D4/D5
                sub.l   D0, D4
                sub.l   D1, D5
                addq.w  #$02, A2
                dbra    D6, Offset_0x01E118
                rts
Offset_0x01E138:
                lea     (Interrupt_0C).w, A2                   ; Offset_0x000030
                lea     (Obj_Player_One).w, A1                       ; $FFFFB000
                moveq   #$03, D6
                movem.l D1-D3, -(A7)
                bsr.s   Offset_0x01E156
                movem.l (A7)+, D1-D3
                lea     (Interrupt_0D).w, A2                   ; Offset_0x000034
                lea     (Obj_Player_Two).w, A1                       ; $FFFFB04A
                addq.b  #$01, D6
Offset_0x01E156:
                btst    D6, Obj_Status(A0)                               ; $002A
                beq     Offset_0x01E214
                move.w  Obj_Inertia(A1), D0                              ; $001C
                move.b  Obj_Control_Var_12(A0), D4                       ; $0042
                addi.b  #$40, D4
                bpl.s   Offset_0x01E16E
                neg.w   D0
Offset_0x01E16E:
                add.w   D0, (A2)
                btst    #$01, Obj_Status(A1)                             ; $002A
                bne.s   Offset_0x01E19C
                move.b  Obj_Control_Var_12(A0), D0                       ; $0042
                jsr     (CalcSine)                             ; Offset_0x001B20
                tst.w   D1
                bmi.s   Offset_0x01E188
                neg.w   D1
Offset_0x01E188:
                asr.w   #$02, D1
                move.w  Obj_X(A1), D0                                    ; $0010
                sub.w   Obj_X(A0), D0                                    ; $0010
                cmp.w   D1, D0
                blt.s   Offset_0x01E19C
                neg.w   D1
                cmp.w   D1, D0
                blt.s   Offset_0x01E1B0
Offset_0x01E19C:
                bclr    #$03, Obj_Status(A1)                             ; $002A
                bset    #$01, Obj_Status(A1)                             ; $002A
                bclr    D6, Obj_Status(A0)                               ; $002A
                moveq   #$00, D4
                rts
Offset_0x01E1B0:
                bsr     Offset_0x01E1B8
                moveq   #$00, D4
                rts
Offset_0x01E1B8:
                move.w  D3, D5
                move.b  Obj_Control_Var_12(A0), D0                       ; $0042
                jsr     (CalcSine)                             ; Offset_0x001B20
                move.w  Obj_Y(A0), D2                                    ; $0014
                move.w  Obj_X(A0), D3                                    ; $0010
                move.w  (A2), D4
                muls.w  D4, D0
                muls.w  D4, D1
                swap.w  D0
                swap.w  D1
                add.w   D0, D2
                add.w   D1, D3
                move.b  Obj_Control_Var_12(A0), D0                       ; $0042
                move.b  D0, D1
                addi.b  #$40, D1
                bpl.s   Offset_0x01E1EA
                addi.b  #$80, D0
Offset_0x01E1EA:
                move.b  D0, Obj_Angle(A1)                                ; $0026
                moveq   #$00, D1
                move.b  Obj_Height_2(A1), D1                             ; $001E
                add.w   D1, D5
                lsl.w   #$08, D5
                jsr     (CalcSine)                             ; Offset_0x001B20
                muls.w  D5, D0
                muls.w  D5, D1
                swap.w  D0
                swap.w  D1
                add.w   D0, D3
                sub.w   D1, D2
                move.w  D2, Obj_Y(A1)                                    ; $0014
                move.w  D3, Obj_X(A1)                                    ; $0010
                rts
Offset_0x01E214:
                tst.w   Obj_Speed_Y(A1)                                  ; $001A
                bmi     Offset_0x01E2AA
                move.b  Obj_Control_Var_12(A0), D0                       ; $0042
                jsr     (CalcSine)                             ; Offset_0x001B20
                move.w  D0, D4
                move.w  D1, D2
                tst.w   D1
                bmi.s   Offset_0x01E230
                neg.w   D1
Offset_0x01E230:
                asr.w   #$02, D1
                move.w  Obj_X(A1), D0                                    ; $0010
                sub.w   Obj_X(A0), D0                                    ; $0010
                cmp.w   D1, D0
                blt.s   Offset_0x01E2AA
                neg.w   D1
                cmp.w   D1, D0
                bge.s   Offset_0x01E2AA
                swap.w  D0
                divs.w  D2, D0
                move.w  D0, (A2)
                neg.w   D4
                muls.w  D4, D0
                swap.w  D0
                move.w  D3, D5
                add.w   D0, D3
                move.w  Obj_Y(A0), D0                                    ; $0014
                sub.w   D3, D0
                move.w  Obj_Y(A1), D2                                    ; $0014
                move.b  Obj_Height_2(A1), D1                             ; $001E
                ext.w   D1
                add.w   D2, D1
                addq.w  #$04, D1
                sub.w   D1, D0
                bhi.s   Offset_0x01E2AA
                cmpi.w  #$FFF0, D0
                bcs.s   Offset_0x01E2AA
                tst.b   Obj_Timer(A1)                                    ; $002E
                bmi.s   Offset_0x01E2AA
                cmpi.b  #$06, Obj_Routine(A1)                            ; $0005
                bcc.s   Offset_0x01E2AA
                move.b  Obj_Control_Var_12(A0), D0                       ; $0042
                move.b  D0, D1
                addi.b  #$40, D1
                bpl.s   Offset_0x01E290
                addi.b  #$80, D0
Offset_0x01E290:
                jsr     (CalcSine)                             ; Offset_0x001B20
                muls.w  #$1B00, D0
                swap.w  D0
                sub.w   D0, (A2)
                move.w  D5, D3
                bsr     Offset_0x01E1B8
                jmp     (Ride_Object_Set_Ride)                 ; Offset_0x013C80
Offset_0x01E2AA:
                rts      
;-------------------------------------------------------------------------------
Unknow_Controled_By_P2_Mappings:                               ; Offset_0x01E2AC
                dc.w    Offset_0x01E2B0-Unknow_Controled_By_P2_Mappings
                dc.w    Offset_0x01E2B8-Unknow_Controled_By_P2_Mappings
Offset_0x01E2B0:
                dc.w    $0001
                dc.w    $F805, $0037, $FFF8
Offset_0x01E2B8:
                dc.w    $0002
                dc.w    $F007, $002F, $FFF0
                dc.w    $F007, $082F, $0000                                                                                                                                                                 
;===============================================================================
; Objeto 0x1A - Objeto desconhecido que pode ser girado usando o 2º controle
; <<<-  
;===============================================================================  