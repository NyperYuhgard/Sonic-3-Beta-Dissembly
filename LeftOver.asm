;-------------------------------------------------------------------------------
; C�digo compilado incompleto
; ->>>
;-------------------------------------------------------------------------------
Offset_0x002484 equ $002484
Offset_0x0024C4 equ $0024C4
Offset_0x002546 equ $002546    
Offset_0x002576 equ $002576   
Offset_0x0026B6 equ $0026B6                        
                jsr     (Compiler_Place_Holder).l                ; Offset_0x000000
                tst.w   (Compiler_Place_Holder)                ; Offset_0x000000
                bne.s   Offset_0x0EF223
                move.w  (Compiler_Place_Holder), D0            ; Offset_0x000000
                cmpi.w  #$FFFF, D0
                bne     Offset_0x0EF223
                move.l  (Compiler_Place_Holder), D7            ; Offset_0x000000
                sub.l   (Compiler_Place_Holder), D7            ; Offset_0x000000
                asl.w   #$02, D7
                subq.w  #$01, D7
                bmi.s   Offset_0x0EF223
                jsr     (Compiler_Place_Holder)                ; Offset_0x000000
Offset_0x0EF211:
                bsr     Offset_0x0EF225
                dbra    D7, Offset_0x0EF211
                move.l  (Compiler_Place_Holder), (Compiler_Place_Holder) ; Offset_0x000000, Offset_0x000000
Offset_0x0EF223:
                rts
Offset_0x0EF225:
                move.w  (Compiler_Place_Holder), D0            ; Offset_0x000000
                sub.w   (Compiler_Place_Holder), D0            ; Offset_0x000000
                bne.s   Offset_0x0EF23B
                move.w  #$0000, (Compiler_Place_Holder)        ; Offset_0x000000
Offset_0x0EF23B:
                move.w  (Compiler_Place_Holder), D1            ; Offset_0x000000
                sub.w   (Compiler_Place_Holder), D1            ; Offset_0x000000
                bne.s   Offset_0x0EF251
                move.w  #$0000, (Compiler_Place_Holder)        ; Offset_0x000000
Offset_0x0EF251:
                move.w  (Compiler_Place_Holder), D2            ; Offset_0x000000
                sub.w   (Compiler_Place_Holder), D2            ; Offset_0x000000
                bne.s   Offset_0x0EF267
                move.w  #$0000, (Compiler_Place_Holder)        ; Offset_0x000000
Offset_0x0EF267:
                tst.w   D0
                bne.s   Offset_0x0EF27F
                tst.w   D1
                bne.s   Offset_0x0EF27F
                tst.w   D2
                bne.s   Offset_0x0EF27F
                move.w  #$0001, (Compiler_Place_Holder)        ; Offset_0x000000
                bra     Offset_0x0EF2A9
Offset_0x0EF27F:
                move.w  (Compiler_Place_Holder), D0            ; Offset_0x000000
                ext.l   D0
                add.l   D0, (Compiler_Place_Holder)            ; Offset_0x000000
                move.w  (Compiler_Place_Holder), D0            ; Offset_0x000000
                ext.l   D0
                add.l   D0, (Compiler_Place_Holder)            ; Offset_0x000000
                move.w  (Compiler_Place_Holder), D0            ; Offset_0x000000
                ext.l   D0
                add.l   D0, (Compiler_Place_Holder)            ; Offset_0x000000
Offset_0x0EF2A9:
                rts     
;-------------------------------------------------------------------------------
; Offset_0x0EF2AB:
                move.w  (Compiler_Place_Holder), D0            ; Offset_0x000000
                andi.w  #$C000, D0
                cmpi.w  #$0000, D0
                beq     Offset_0x0EF2D1
                cmpi.w  #$4000, D0
                beq     Offset_0x0EF2F3
                cmpi.w  #$8000, D0
                beq     Offset_0x0EF2FB
                bra     Offset_0x0EF309
Offset_0x0EF2D1:
                move.w  (Compiler_Place_Holder), (Compiler_Place_Holder) ; Offset_0x000000, Offset_0x000000
                move.w  (Compiler_Place_Holder), (Compiler_Place_Holder) ; Offset_0x000000, Offset_0x000000
                move.w  (Compiler_Place_Holder), (Compiler_Place_Holder) ; Offset_0x000000, Offset_0x000000
                bra     Offset_0x0EF323
Offset_0x0EF2F3:
                bsr     Offset_0x0EFD93
                bra     Offset_0x0EF323
Offset_0x0EF2FB:
                jsr     (Compiler_Place_Holder)                ; Offset_0x000000
                bsr     (Left_Over_Code_End+$0091)             ; Offset_0x0F0091
                bra     Offset_0x0EF323
Offset_0x0EF309:
                tst.w   (Compiler_Place_Holder)                ; Offset_0x000000
                bne     Offset_0x0EF31F
                bsr     Offset_0x0EFF77
                bsr     (Left_Over_Code_End+$01A5)             ; Offset_0x0F01A5
                bra     Offset_0x0EF323
Offset_0x0EF31F:
                bsr     (Left_Over_Code_End+$0277)             ; Offset_0x0F0277
Offset_0x0EF323:
                rts                   
;-------------------------------------------------------------------------------
; Offset_0x0EF325:
                move.w  (Compiler_Place_Holder), D0            ; Offset_0x000000
                andi.w  #$C000, D0
                cmpi.w  #$4000, D0
                bhi     Offset_0x0EF48D
                tst.w   (Compiler_Place_Holder)                ; Offset_0x000000
                bne.s   Offset_0x0EF37D
                jsr     (Compiler_Place_Holder)                ; Offset_0x000000
                move.w  (Compiler_Place_Holder), D0            ; Offset_0x000000
                lsr.w   #$07, D0
                cmpi.w  #$0168, D0
                bge.s   Offset_0x0EF357
                move.w  #$0168, D0
Offset_0x0EF357:
                move.w  #$0010, (Compiler_Place_Holder)        ; Offset_0x000000
                jsr     (Compiler_Place_Holder)                ; Offset_0x000000
                tst.w   (Compiler_Place_Holder)                ; Offset_0x000000
                bpl     Offset_0x0EF377
                move.w  #$FFF0, (Compiler_Place_Holder)        ; Offset_0x000000
Offset_0x0EF377:
                move.w  D0, (Compiler_Place_Holder)            ; Offset_0x000000
Offset_0x0EF37D:
                move.w  (Compiler_Place_Holder), D0            ; Offset_0x000000
                add.w   (Compiler_Place_Holder), D0            ; Offset_0x000000
                bpl     Offset_0x0EF391
                move.w  #$1670, D0
Offset_0x0EF391:
                cmpi.w  #$1680, D0
                blt     Offset_0x0EF39B
                moveq   #$00, D0
Offset_0x0EF39B:
                move.w  D0, (Compiler_Place_Holder)            ; Offset_0x000000
                subq.w  #$01, (Compiler_Place_Holder)          ; Offset_0x000000
                tst.w   (Compiler_Place_Holder)                ; Offset_0x000000
                bne.s   Offset_0x0EF3ED
                jsr     (Compiler_Place_Holder)                ; Offset_0x000000
                move.w  (Compiler_Place_Holder), D0            ; Offset_0x000000
                lsr.w   #$07, D0
                cmpi.w  #$0168, D0
                bge.s   Offset_0x0EF3C7
                move.w  #$0168, D0
Offset_0x0EF3C7:
                move.w  #$0010, (Compiler_Place_Holder)        ; Offset_0x000000
                jsr     (Compiler_Place_Holder)                ; Offset_0x000000
                tst.w   (Compiler_Place_Holder)                ; Offset_0x000000
                bpl     Offset_0x0EF3E7
                move.w  #$FFF0, (Compiler_Place_Holder)        ; Offset_0x000000
Offset_0x0EF3E7:
                move.w  D0, (Compiler_Place_Holder)            ; Offset_0x000000
Offset_0x0EF3ED:
                move.w  (Compiler_Place_Holder), D0            ; Offset_0x000000
                add.w   (Compiler_Place_Holder), D0            ; Offset_0x000000
                bpl     Offset_0x0EF401
                move.w  #$1670, D0
Offset_0x0EF401:
                cmpi.w  #$1680, D0
                blt     Offset_0x0EF40B
                moveq   #$00, D0
Offset_0x0EF40B:
                move.w  D0, (Compiler_Place_Holder)            ; Offset_0x000000
                subq.w  #$01, (Compiler_Place_Holder)          ; Offset_0x000000
                tst.w   (Compiler_Place_Holder)                ; Offset_0x000000
                bne.s   Offset_0x0EF45D
                jsr     (Compiler_Place_Holder)                ; Offset_0x000000
                move.w  (Compiler_Place_Holder), D0            ; Offset_0x000000
                lsr.w   #$07, D0
                cmpi.w  #$0168, D0
                bge.s   Offset_0x0EF437
                move.w  #$0168, D0
Offset_0x0EF437:
                move.w  #$0010, (Compiler_Place_Holder)        ; Offset_0x000000
                jsr     (Compiler_Place_Holder)                ; Offset_0x000000
                tst.w   (Compiler_Place_Holder)                ; Offset_0x000000
                bpl     Offset_0x0EF457
                move.w  #$FFF0, (Compiler_Place_Holder)        ; Offset_0x000000
Offset_0x0EF457:
                move.w  D0, (Compiler_Place_Holder)            ; Offset_0x000000
Offset_0x0EF45D:
                move.w  (Compiler_Place_Holder), D0            ; Offset_0x000000
                add.w   (Compiler_Place_Holder), D0            ; Offset_0x000000
                bpl     Offset_0x0EF471
                move.w  #$1670, D0
Offset_0x0EF471:
                cmpi.w  #$1680, D0
                blt     Offset_0x0EF47B
                moveq   #$00, D0
Offset_0x0EF47B:
                move.w  D0, (Compiler_Place_Holder)            ; Offset_0x000000
                subq.w  #$01, (Compiler_Place_Holder)          ; Offset_0x000000
                jmp     (Compiler_Place_Holder)                ; Offset_0x000000
Offset_0x0EF48D:
                lea     (Compiler_Place_Holder), A0            ; Offset_0x000000
                lea     (Compiler_Place_Holder), A1            ; Offset_0x000000
                moveq   #$0F, D7
Offset_0x0EF49B:
                move.w  (A0), D0
                add.w   (A1)+, D0
                bpl     Offset_0x0EF4A7
                addi.w  #$1680, D0
Offset_0x0EF4A7:
                cmpi.w  #$1680, D0
                blt     Offset_0x0EF4B3
                subi.w  #$1680, D0
Offset_0x0EF4B3:
                move.w  D0, (A0)+
                dbra    D7, Offset_0x0EF49B
                jmp     (Compiler_Place_Holder)                ; Offset_0x000000  
;-------------------------------------------------------------------------------
; Offset_0x0EF4BF:
                move.w  (Compiler_Place_Holder), D0            ; Offset_0x000000
                beq.s   Offset_0x0EF4D1
                cmpi.w  #$0010, D0
                beq.s   Offset_0x0EF4D1
                bra     Offset_0x0EF4F9
Offset_0x0EF4D1:
                move.w  (Compiler_Place_Holder), D0            ; Offset_0x000000
                addq.w  #$02, D0
                andi.w  #$001E, D0
                move.w  D0, (Compiler_Place_Holder)            ; Offset_0x000000
                lea     (Compiler_Place_Holder), A0            ; Offset_0x000000
                move.w  $00(A0, D0), (Compiler_Place_Holder)   ; Offset_0x000000
                move.w  $00(A0, D0), (Compiler_Place_Holder)   ; Offset_0x000000
Offset_0x0EF4F9:
                rts
;-------------------------------------------------------------------------------
; Offset_0x0EF4FB:
                move.w  (Compiler_Place_Holder), D0            ; Offset_0x000000
                beq.s   Offset_0x0EF54F
                subq.w  #$01, (Compiler_Place_Holder)          ; Offset_0x000000
                bpl.s   Offset_0x0EF52B
                move.w  #$0002, (Compiler_Place_Holder)        ; Offset_0x000000
                addq.w  #$02, (Compiler_Place_Holder)          ; Offset_0x000000
                cmpi.w  #$000C, (Compiler_Place_Holder)        ; Offset_0x000000
                bne.s   Offset_0x0EF52B
                move.w  #$0000, (Compiler_Place_Holder)        ; Offset_0x000000
Offset_0x0EF52B:
                subq.w  #$01, D0
                add.w   D0, D0
                add.w   D0, D0
                lea     (Compiler_Place_Holder), A1            ; Offset_0x000000
                move.l  $00(A1, D0), A1
                adda.w  (Compiler_Place_Holder), A1            ; Offset_0x000000
                lea     (Compiler_Place_Holder), A0            ; Offset_0x000000
                moveq   #$05, D0
Offset_0x0EF549:
                move.w  (A1)+, (A0)+
                dbra    D0, Offset_0x0EF549
Offset_0x0EF54F:
                rts
;-------------------------------------------------------------------------------
; Offset_0x0EF551:
                tst.w   (Compiler_Place_Holder)                ; Offset_0x000000
                bmi     Offset_0x0EF605
                tst.w   (Compiler_Place_Holder)                ; Offset_0x000000
                bne     Offset_0x0EF605
                lea     (Compiler_Place_Holder), A1            ; Offset_0x000000
                lea     (Compiler_Place_Holder), A4            ; Offset_0x000000
                lea     (Compiler_Place_Holder), A5            ; Offset_0x000000
                lea     (Compiler_Place_Holder), A3            ; Offset_0x000000
                moveq   #$00, D7
Offset_0x0EF57F:
                move.w  #$0000, $0002(A1)
                cmp.w   (Compiler_Place_Holder), D7            ; Offset_0x000000
                bne     Offset_0x0EF5C3
                tst.w   (Compiler_Place_Holder)                ; Offset_0x000000
                beq     Offset_0x0EF5BB
                move.w  #$0000, $0004(A1)
                move.w  (A4), D0
                addi.w  #$00D3, D0
                move.w  (A5), D1
                addi.w  #$00BF, D1
                move.w  D0, $0006(A1)
                move.w  D1, (A1)
                jsr     (Compiler_Place_Holder)                ; Offset_0x000000
                bra     Offset_0x0EF5C3
Offset_0x0EF5BB:
                move.w  #$0000, D0
                bra     Offset_0x0EF5DD
Offset_0x0EF5C3:
                move.w  #$0000, D0
                move.w  D7, D1
                add.w   D1, D1
                move.w  $00(A3, D1), D1
                cmp.w   (Compiler_Place_Holder), D1            ; Offset_0x000000
                bne     Offset_0x0EF5DD
                move.w  #$0000, D0
Offset_0x0EF5DD:
                move.w  D0, $0004(A1)
                move.w  (A4)+, D0
                addi.w  #$00D3, D0
                move.w  (A5)+, D1
                addi.w  #$00BF, D1
                move.w  D0, $0006(A1)
                move.w  D1, (A1)
                jsr     (Compiler_Place_Holder)                ; Offset_0x000000
                addq.w  #$01, D7
                cmp.w   (Compiler_Place_Holder), D7            ; Offset_0x000000
                ble     Offset_0x0EF57F
Offset_0x0EF605:
                tst.w   (Compiler_Place_Holder)                ; Offset_0x000000
                beq     Offset_0x0EF631
                lea     (Compiler_Place_Holder), A1            ; Offset_0x000000
                move.w  #$00BF, (A1)
                move.w  #$0000, $0002(A1)
                move.w  #$0000, $0004(A1)
                move.w  #$00D3, $0006(A1)
                jsr     (Compiler_Place_Holder)                ; Offset_0x000000
Offset_0x0EF631:
                rts
;-------------------------------------------------------------------------------
; Offset_0x0EF633:
                lea     (Compiler_Place_Holder), A1            ; Offset_0x000000
                lea     (Compiler_Place_Holder), A2            ; Offset_0x000000
                moveq   #$1D, D0
Offset_0x0EF641:
                move.w  #$0000, (A1)+
                move.w  #$0000, (A2)+
                dbra    D0, Offset_0x0EF641
                cmpi.w  #$FFFF, (Compiler_Place_Holder)        ; Offset_0x000000
                beq.s   Offset_0x0EF67F
                lea     (Compiler_Place_Holder), A0            ; Offset_0x000000
                lea     (Compiler_Place_Holder), A1            ; Offset_0x000000
                jsr     (Compiler_Place_Holder)                ; Offset_0x000000
                lea     (Compiler_Place_Holder), A0            ; Offset_0x000000
                move.w  (Compiler_Place_Holder), D1            ; Offset_0x000000
                jsr     (Compiler_Place_Holder)                ; Offset_0x000000
                bra     Offset_0x0EF6A3
Offset_0x0EF67F:
                lea     (Compiler_Place_Holder), A0            ; Offset_0x000000
                lea     (Compiler_Place_Holder), A1            ; Offset_0x000000
                jsr     (Compiler_Place_Holder)                ; Offset_0x000000
                lea     (Compiler_Place_Holder), A0            ; Offset_0x000000
                move.w  (Compiler_Place_Holder), D1            ; Offset_0x000000
                jsr     (Compiler_Place_Holder)                ; Offset_0x000000
Offset_0x0EF6A3:
                moveq   #$02, D2
                lea     (Compiler_Place_Holder), A0            ; Offset_0x000000
                lea     (Offset_0x002484), A1
                move.l  #$00004000, D1
                move.w  #$001D, D0
                jsr     (Compiler_Place_Holder)                ; Offset_0x000000
                lea     (Compiler_Place_Holder), A0            ; Offset_0x000000
                lea     (Offset_0x0024C4), A1
                move.w  #$001D, D0
                jmp     (Compiler_Place_Holder)                ; Offset_0x000000
;-------------------------------------------------------------------------------
; Offset_0x0EF6D7:
                lea     (Compiler_Place_Holder), A0            ; Offset_0x000000
                move.w  #$01BF, D0
Offset_0x0EF6E1:
                move.w  #$0000, (A0)+
                dbra    D0, Offset_0x0EF6E1
                lea     (Compiler_Place_Holder), A0            ; Offset_0x000000
                moveq   #$1D, D0
Offset_0x0EF6F1:
                move.w  #$0000, (A0)+
                dbra    D0, Offset_0x0EF6F1
                lea     (Compiler_Place_Holder), A0            ; Offset_0x000000
                lea     (Compiler_Place_Holder), A6            ; Offset_0x000000
                move.w  (Compiler_Place_Holder), D1            ; Offset_0x000000
Offset_0x0EF70B:
                cmpi.w  #$FFFF, (A6)
                beq.s   Offset_0x0EF749
                move.w  $0006(A6), D0
                cmp.w   (Compiler_Place_Holder), D0            ; Offset_0x000000
                bne.s   Offset_0x0EF727
                move.w  (A6)+, D2
                cmp.w   D1, D2
                beq.s   Offset_0x0EF72B
Offset_0x0EF723:
                addq.w  #$06, A6
                bra.s   Offset_0x0EF70B
Offset_0x0EF727:
                addq.w  #$08, A6
                bra.s   Offset_0x0EF70B
Offset_0x0EF72B:
                tst.w   D0
                beq.s   Offset_0x0EF73D
                andi.w  #$3800, D2
                rol.w   #$05, D2
                cmp.w   (Compiler_Place_Holder), D2            ; Offset_0x000000
                bne.s   Offset_0x0EF723
Offset_0x0EF73D:
                move.l  (A6), A1
                jsr     (Compiler_Place_Holder)                ; Offset_0x000000
                bra     Offset_0x0EF83D
Offset_0x0EF749:
                tst.w   (Compiler_Place_Holder)                ; Offset_0x000000
                beq.s   Offset_0x0EF761
                lea     (Compiler_Place_Holder), A1            ; Offset_0x000000
                jsr     (Compiler_Place_Holder)                ; Offset_0x000000
                bra     Offset_0x0EF7B3
Offset_0x0EF761:
                andi.w  #$C000, D1
                cmpi.w  #$C000, D1
                beq.s   Offset_0x0EF7A7
                cmpi.w  #$8000, D1
                beq.s   Offset_0x0EF797
                cmpi.w  #$4000, D1
                beq.s   Offset_0x0EF787
                lea     (Compiler_Place_Holder), A1            ; Offset_0x000000
                jsr     (Compiler_Place_Holder)                ; Offset_0x000000
                bra     Offset_0x0EF7B3
Offset_0x0EF787:
                lea     (Compiler_Place_Holder), A1            ; Offset_0x000000
                jsr     (Compiler_Place_Holder)                ; Offset_0x000000
                bra     Offset_0x0EF7B3
Offset_0x0EF797:
                lea     (Compiler_Place_Holder), A1            ; Offset_0x000000
                jsr     (Compiler_Place_Holder)                ; Offset_0x000000
                bra     Offset_0x0EF7B3
Offset_0x0EF7A7:
                lea     (Compiler_Place_Holder), A1            ; Offset_0x000000
                jsr     (Compiler_Place_Holder)                ; Offset_0x000000
Offset_0x0EF7B3:
                cmpi.w  #$0000, D1
                beq     Offset_0x0EF83D
                lea     (Compiler_Place_Holder), A1            ; Offset_0x000000
                move.w  (Compiler_Place_Holder), D7            ; Offset_0x000000
                add.w   D7, D7
                add.w   D7, D7
                move.l  $00(A1, D7), A1
                jsr     (Compiler_Place_Holder)                ; Offset_0x000000
                cmpi.w  #$4000, D1
                beq     Offset_0x0EF83D
                addq.w  #$02, A0
                lea     (Compiler_Place_Holder), A1            ; Offset_0x000000
                move.w  (Compiler_Place_Holder), D7            ; Offset_0x000000
                add.w   D7, D7
                add.w   D7, D7
                move.l  $00(A1, D7), A1
                jsr     (Compiler_Place_Holder)                ; Offset_0x000000
                cmpi.w  #$8000, D1
                beq.s   Offset_0x0EF83D
                addq.w  #$02, A0
                lea     (Compiler_Place_Holder), A1            ; Offset_0x000000
                move.w  (Compiler_Place_Holder), D7            ; Offset_0x000000
                add.w   D7, D7
                add.w   D7, D7
                move.l  $00(A1, D7), A1
                jsr     (Compiler_Place_Holder)                ; Offset_0x000000
                tst.w   (Compiler_Place_Holder)                ; Offset_0x000000
                beq.s   Offset_0x0EF83D
                lea     (Compiler_Place_Holder), A1            ; Offset_0x000000
                move.w  (Compiler_Place_Holder), D7            ; Offset_0x000000
                add.w   D7, D7
                add.w   D7, D7
                move.l  $00(A1, D7), A1
                jsr     (Compiler_Place_Holder)                ; Offset_0x000000
Offset_0x0EF83D:
                tst.w   (Compiler_Place_Holder)                ; Offset_0x000000
                bne     Offset_0x0EFA2B
                lea     (Compiler_Place_Holder), A0            ; Offset_0x000000
                moveq   #$00, D0
                move.w  (Compiler_Place_Holder), D1            ; Offset_0x000000
                move.w  D1, D6
                andi.w  #$C000, D1
                cmpi.w  #$C000, D1
                beq     Offset_0x0EF997
                cmpi.w  #$8000, D1
                beq     Offset_0x0EF90D
                cmpi.w  #$4000, D1
                beq     Offset_0x0EF8A7
                andi.w  #$0007, D6
                move.w  D6, (Compiler_Place_Holder)            ; Offset_0x000000
                moveq   #$00, D2
Offset_0x0EF87F:
                move.w  #$0000, D1
                cmp.w   (Compiler_Place_Holder), D2            ; Offset_0x000000
                bne     Offset_0x0EF891
                move.w  #$0000, D1
Offset_0x0EF891:
                jsr     (Compiler_Place_Holder)                ; Offset_0x000000
                adda.w  #$0038, A0
                moveq   #$00, D0
                addq.w  #$01, D2
                cmp.w   D6, D2
                ble.s   Offset_0x0EF87F
                bra     Offset_0x0EFA2B
Offset_0x0EF8A7:
                move.w  D6, D2
                andi.w  #$0007, D2
                andi.w  #$0078, D6
                lsr.w   #$03, D6
                move.w  (Compiler_Place_Holder), D7            ; Offset_0x000000
                jsr     (Compiler_Place_Holder)                ; Offset_0x000000
                move.w  D6, (Compiler_Place_Holder)            ; Offset_0x000000
                moveq   #$00, D3
Offset_0x0EF8C7:
                move.w  (Compiler_Place_Holder), D7            ; Offset_0x000000
                andi.w  #$FF87, D7
                move.w  D3, D1
                asl.w   #$03, D1
                or.w    D1, D7
                move.w  #$0000, D1
                cmp.w   (Compiler_Place_Holder), D3            ; Offset_0x000000
                bne     Offset_0x0EF8E9
                move.w  #$0000, D1
Offset_0x0EF8E9:
                jsr     (Compiler_Place_Holder)                ; Offset_0x000000
                bne.s   Offset_0x0EF8FD
                jsr     (Compiler_Place_Holder)                ; Offset_0x000000
                jsr     (Compiler_Place_Holder)                ; Offset_0x000000
Offset_0x0EF8FD:
                adda.w  #$0038, A0
                moveq   #$00, D0
                addq.w  #$01, D3
                cmp.w   D6, D3
                ble.s   Offset_0x0EF8C7
                bra     Offset_0x0EFA2B
Offset_0x0EF90D:
                tst.w   (Compiler_Place_Holder)                ; Offset_0x000000
                beq     Offset_0x0EF923
                move.w  #$FFFF, (Compiler_Place_Holder)        ; Offset_0x000000
                bra     Offset_0x0EFA2B
Offset_0x0EF923:
                move.w  D6, D2
                move.w  D6, D3
                andi.w  #$0007, D2
                andi.w  #$0078, D3
                lsr.w   #$03, D3
                andi.w  #$0780, D6
                lsr.w   #$07, D6
                move.w  (Compiler_Place_Holder), D7            ; Offset_0x000000
                jsr     (Compiler_Place_Holder)                ; Offset_0x000000
                move.w  D6, (Compiler_Place_Holder)            ; Offset_0x000000
                moveq   #$00, D4
Offset_0x0EF94B:
                move.w  (Compiler_Place_Holder), D7            ; Offset_0x000000
                andi.w  #$F87F, D7
                move.w  D4, D1
                asl.w   #$07, D1
                or.w    D1, D7
                move.w  #$0000, D1
                cmp.w   (Compiler_Place_Holder), D4            ; Offset_0x000000
                bne     Offset_0x0EF96D
                move.w  #$0000, D1
Offset_0x0EF96D:
                jsr     (Compiler_Place_Holder)                ; Offset_0x000000
                bne.s   Offset_0x0EF987
                jsr     (Compiler_Place_Holder)                ; Offset_0x000000
                jsr     (Compiler_Place_Holder)                ; Offset_0x000000
                jsr     (Compiler_Place_Holder)                ; Offset_0x000000
Offset_0x0EF987:
                adda.w  #$0038, A0
                moveq   #$00, D0
                addq.w  #$01, D4
                cmp.w   D6, D4
                ble.s   Offset_0x0EF94B
                bra     Offset_0x0EFA2B
Offset_0x0EF997:
                tst.w   (Compiler_Place_Holder)                ; Offset_0x000000
                beq     Offset_0x0EF9AD
                move.w  #$FFFF, (Compiler_Place_Holder)        ; Offset_0x000000
                bra     Offset_0x0EFA2B
Offset_0x0EF9AD:
                move.w  D6, D2
                move.w  D6, D3
                move.w  D6, D4
                andi.w  #$0007, D2
                andi.w  #$0078, D3
                lsr.w   #$03, D3
                andi.w  #$0780, D4
                lsr.w   #$07, D4
                andi.w  #$3800, D6
                rol.w   #$05, D6
                move.w  (Compiler_Place_Holder), D7            ; Offset_0x000000
                jsr     (Compiler_Place_Holder)                ; Offset_0x000000
                move.w  D6, (Compiler_Place_Holder)            ; Offset_0x000000
                moveq   #$00, D5
Offset_0x0EF9DD:
                move.w  (Compiler_Place_Holder), D7            ; Offset_0x000000
                andi.w  #$C7FF, D7
                move.w  D5, D1
                ror.w   #$05, D1
                or.w    D1, D7
                move.w  #$0000, D1
                cmp.w   (Compiler_Place_Holder), D5            ; Offset_0x000000
                bne     Offset_0x0EF9FF
                move.w  #$0000, D1
Offset_0x0EF9FF:
                jsr     (Compiler_Place_Holder)                ; Offset_0x000000
                bne.s   Offset_0x0EFA1F
                jsr     (Compiler_Place_Holder)                ; Offset_0x000000
                jsr     (Compiler_Place_Holder)                ; Offset_0x000000
                jsr     (Compiler_Place_Holder)                ; Offset_0x000000
                jsr     (Compiler_Place_Holder)                ; Offset_0x000000
Offset_0x0EFA1F:
                adda.w  #$0038, A0
                moveq   #$00, D0
                addq.w  #$01, D5
                cmp.w   D6, D5
                ble.s   Offset_0x0EF9DD
Offset_0x0EFA2B:
                move.w  (Compiler_Place_Holder), D0            ; Offset_0x000000
                sub.w   (Compiler_Place_Holder), D0            ; Offset_0x000000
                bpl     Offset_0x0EFA49
                move.w  (Compiler_Place_Holder), (Compiler_Place_Holder) ; Offset_0x000000, Offset_0x000000
                bra     Offset_0x0EFA5F
Offset_0x0EFA49:
                cmpi.w  #$0006, D0
                blt     Offset_0x0EFA5F
                move.w  (Compiler_Place_Holder), D0            ; Offset_0x000000
                subq.w  #$05, D0
                move.w  D0, (Compiler_Place_Holder)            ; Offset_0x000000
Offset_0x0EFA5F:
                moveq   #$02, D2
                lea     (Compiler_Place_Holder), A0            ; Offset_0x000000
                move.w  (Compiler_Place_Holder), D0            ; Offset_0x000000
                muls.w  #$0038, D0
                adda.w  D0, A0
                lea     (Offset_0x002546), A1
                move.l  #$00004000, D1
                move.w  #$001C, D0
                moveq   #$05, D3
Offset_0x0EFA85:
                jsr     (Compiler_Place_Holder)                ; Offset_0x000000
                adda.w  #$0038, A0
                adda.w  #$0040, A1
                dbra    D3, Offset_0x0EFA85
                rts
;-------------------------------------------------------------------------------
; Offset_0x0EFA99:
                lea     (Compiler_Place_Holder), A6            ; Offset_0x000000
                move.w  D2, D7
                add.w   D7, D7
                add.w   D7, D7
                move.l  $00(A6, D7), A6
Offset_0x0EFAA9:
                moveq   #$00, D7
                move.b  (A6)+, D7
                cmpi.w  #$0000, D7
                beq     Offset_0x0EFABF
                add.w   D1, D7
                move.w  D7, $00(A0, D0)
                addq.w  #$02, D0
                bra.s   Offset_0x0EFAA9
Offset_0x0EFABF:
                addq.w  #$02, D0
                rts  
;-------------------------------------------------------------------------------
; Offset_0x0EFAC3:
                move.w  D3, D7
                add.w   D7, D7
                add.w   D7, D7
                lea     (Compiler_Place_Holder), A6            ; Offset_0x000000
                move.l  $00(A6, D7), A6
Offset_0x0EFAD3:
                moveq   #$00, D7
                move.b  (A6)+, D7
                cmpi.w  #$0000, D7
                beq     Offset_0x0EFAE9
                add.w   D1, D7
                move.w  D7, $00(A0, D0)
                addq.w  #$02, D0
                bra.s   Offset_0x0EFAD3
Offset_0x0EFAE9:
                addq.w  #$02, D0
                rts  
;-------------------------------------------------------------------------------
; Offset_0x0EFAED:
                move.w  D4, D7
                add.w   D7, D7
                add.w   D7, D7
                lea     (Compiler_Place_Holder), A6            ; Offset_0x000000
                move.l  $00(A6, D7), A6
Offset_0x0EFAFD:
                moveq   #$00, D7
                move.b  (A6)+, D7
                cmpi.w  #$0000, D7
                beq     Offset_0x0EFB13
                add.w   D1, D7
                move.w  D7, $00(A0, D0)
                addq.w  #$02, D0
                bra.s   Offset_0x0EFAFD
Offset_0x0EFB13:
                rts 
;------------------------------------------------------------------------------- 
; Offset_0x0EFB15:
                move.w  D5, D7
                add.w   D7, D7
                add.w   D7, D7
                lea     (Compiler_Place_Holder), A6            ; Offset_0x000000
                move.l  $00(A6, D7), A6
Offset_0x0EFB25:
                moveq   #$00, D7
                move.b  (A6)+, D7
                cmpi.w  #$0000, D7
                beq     Offset_0x0EFB3B
                add.w   D1, D7
                move.w  D7, $00(A0, D0)
                addq.w  #$02, D0
                bra.s   Offset_0x0EFB25
Offset_0x0EFB3B:
                rts
;-------------------------------------------------------------------------------
; Offset_0x0EFB3D:
                lea     (Compiler_Place_Holder), A6            ; Offset_0x000000
Offset_0x0EFB43:
                cmpi.w  #$FFFF, (A6)
                beq.s   Offset_0x0EFB6D
                move.w  (A6)+, A5
                cmpa.w  D7, A5
                beq.s   Offset_0x0EFB53
                addq.w  #$04, A6
                bra.s   Offset_0x0EFB43
Offset_0x0EFB53:
                move.l  (A6), A6
Offset_0x0EFB55:
                moveq   #$00, D7
                move.b  (A6)+, D7
                cmpi.w  #$0000, D7
                beq.s   Offset_0x0EFB69
                add.w   D1, D7
                move.w  D7, $00(A0, D0)
                addq.w  #$02, D0
                bra.s   Offset_0x0EFB55
Offset_0x0EFB69:
                moveq   #$01, D7
                rts
Offset_0x0EFB6D:
                moveq   #$00, D7
                rts 
;-------------------------------------------------------------------------------
; Offset_0x0EFB71:
                lea     (Compiler_Place_Holder), A6            ; Offset_0x000000
                moveq   #$00, D1
Offset_0x0EFB79:
                cmpi.w  #$FFFF, (A6)
                beq.s   Offset_0x0EFB97
                move.w  (A6)+, A5
                cmpa.w  D7, A5
                beq.s   Offset_0x0EFB89
                addq.w  #$01, D1
                bra.s   Offset_0x0EFB79
Offset_0x0EFB89:
                lea     (Compiler_Place_Holder), A6            ; Offset_0x000000
                tst.b   $00(A6, D1)
                beq.s   Offset_0x0EFB97
                subq.w  #$01, D6
Offset_0x0EFB97:
                rts  
;-------------------------------------------------------------------------------
; Offset_0x0EFB99:
                lea     (Compiler_Place_Holder), A6            ; Offset_0x000000
Offset_0x0EFB9F:
                cmpi.w  #$FFFF, (A6)
                beq.s   Offset_0x0EFBBB
                move.w  (A6)+, D2
                cmp.w   D1, D2
                beq.s   Offset_0x0EFBAF
                addq.w  #$04, A6
                bra.s   Offset_0x0EFB9F
Offset_0x0EFBAF:
                move.l  (A6), A1
                jsr     (Compiler_Place_Holder)                ; Offset_0x000000
                bra     Offset_0x0EFC3F
Offset_0x0EFBBB:
                move.w  D1, D6
                andi.w  #$C000, D6
                lea     (Compiler_Place_Holder), A1            ; Offset_0x000000
                move.w  D1, D7
                andi.w  #$0007, D7
                add.w   D7, D7
                add.w   D7, D7
                move.l  $00(A1, D7), A1
                jsr     (Compiler_Place_Holder)                ; Offset_0x000000
                addq.w  #$02, A0
                lea     (Compiler_Place_Holder), A1            ; Offset_0x000000
                move.w  D1, D7
                andi.w  #$0078, D7
                lsr.w   #$03, D7
                add.w   D7, D7
                add.w   D7, D7
                move.l  $00(A1, D7), A1
                jsr     (Compiler_Place_Holder)                ; Offset_0x000000
                cmpi.w  #$4000, D6
                beq.s   Offset_0x0EFC3F
                addq.w  #$02, A0
                lea     (Compiler_Place_Holder), A1            ; Offset_0x000000
                move.w  D1, D7
                andi.w  #$0780, D7
                lsr.w   #$07, D7
                add.w   D7, D7
                add.w   D7, D7
                move.l  $00(A1, D7), A1
                jsr     (Compiler_Place_Holder)                ; Offset_0x000000
                cmpi.w  #$8000, D6
                beq.s   Offset_0x0EFC3F
                lea     (Compiler_Place_Holder), A1            ; Offset_0x000000
                move.w  D1, D7
                andi.w  #$3800, D7
                rol.w   #$05, D7
                add.w   D7, D7
                add.w   D7, D7
                move.l  $00(A1, D7), A1
                jsr     (Compiler_Place_Holder)                ; Offset_0x000000
Offset_0x0EFC3F:
                rts  
;-------------------------------------------------------------------------------
Offset_0x0EFC41:
                moveq   #$00, D0
                move.b  (A1)+, D0
                cmpi.b  #$00, D0
                beq.s   Offset_0x0EFC53
                addi.w  #$0000, D0
                move.w  D0, (A0)+
                bra.s   Offset_0x0EFC41
Offset_0x0EFC53:
                rts  
;-------------------------------------------------------------------------------
; Offset_0x0EFC55:
                subq.w  #$01, (Compiler_Place_Holder)          ; Offset_0x000000
                bne.s   Offset_0x0EFC6D
                move.w  #$000F, (Compiler_Place_Holder)        ; Offset_0x000000
                eori.w  #$0001, (Compiler_Place_Holder)        ; Offset_0x000000
Offset_0x0EFC6D:
                tst.w   (Compiler_Place_Holder)                ; Offset_0x000000
                beq.s   Offset_0x0EFCB1
                lea     (Compiler_Place_Holder), A0            ; Offset_0x000000
                lea     (Offset_0x002576), A1
                move.w  #$0001, D0
                move.l  #$00004000, D1
                moveq   #$02, D2
                jsr     (Compiler_Place_Holder)                ; Offset_0x000000
                lea     (Compiler_Place_Holder), A0            ; Offset_0x000000
                lea     (Offset_0x0026B6), A1
                move.w  #$0001, D0
                move.l  #$00004000, D1
                moveq   #$02, D2
                jmp     (Compiler_Place_Holder)                ; Offset_0x000000
Offset_0x0EFCB1:
                lea     (Compiler_Place_Holder), A0            ; Offset_0x000000
                lea     (Offset_0x002576), A1
                move.w  #$0001, D0
                move.l  #$00004000, D1
                moveq   #$02, D2
                jsr     (Compiler_Place_Holder)                ; Offset_0x000000
                lea     (Compiler_Place_Holder), A0            ; Offset_0x000000
                lea     (Offset_0x0026B6), A1
                move.w  #$0001, D0
                move.l  #$00004000, D1
                moveq   #$02, D2
                jmp     (Compiler_Place_Holder)                ; Offset_0x000000      
;-------------------------------------------------------------------------------
; Offset_0x0EFCED:
                move.w  #$0000, (Compiler_Place_Holder)        ; Offset_0x000000
                move.w  #$0000, (Compiler_Place_Holder)        ; Offset_0x000000
                tst.w   (Compiler_Place_Holder)                ; Offset_0x000000
                beq.s   Offset_0x0EFD0D
                move.w  #$0000, (Compiler_Place_Holder)        ; Offset_0x000000
Offset_0x0EFD0D:
                move.w  (Compiler_Place_Holder), D0            ; Offset_0x000000
                sub.w   (Compiler_Place_Holder), D0            ; Offset_0x000000
                cmpi.w  #$0006, D0
                blt.s   Offset_0x0EFD27
                move.w  #$0000, (Compiler_Place_Holder)        ; Offset_0x000000
Offset_0x0EFD27:
                rts  
;-------------------------------------------------------------------------------
; Offset_0x0EFD29:
                lea     (Compiler_Place_Holder), A0            ; Offset_0x000000
                lea     (Compiler_Place_Holder), A1            ; Offset_0x000000
                lea     (Compiler_Place_Holder), A2            ; Offset_0x000000
                lea     (Compiler_Place_Holder), A3            ; Offset_0x000000
                lea     (Compiler_Place_Holder), A4            ; Offset_0x000000
                move.w  (Compiler_Place_Holder), (A1)+         ; Offset_0x000000
                move.w  (Compiler_Place_Holder), (A2)+         ; Offset_0x000000
                move.w  (Compiler_Place_Holder), (A3)+         ; Offset_0x000000
                move.w  #$FFFF, (A4)+
                move.w  #$0000, (Compiler_Place_Holder)        ; Offset_0x000000
                moveq   #$3B, D0
Offset_0x0EFD67:
                move.w  (A0)+, (A1)+
                move.w  (A0)+, (A2)+
                move.w  (A0)+, (A3)+
                move.w  (A0)+, (A4)+
                dbra    D0, Offset_0x0EFD67
                move.w  #$003C, (Compiler_Place_Holder)        ; Offset_0x000000
                tst.b   (Compiler_Place_Holder)                ; Offset_0x000000
                beq.s   Offset_0x0EFD89
                subq.w  #$01, (Compiler_Place_Holder)          ; Offset_0x000000
Offset_0x0EFD89:
                move.w  #$0000, (Compiler_Place_Holder)        ; Offset_0x000000
                rts
;-------------------------------------------------------------------------------                
Offset_0x0EFD93:
                move.w  #$FFFF, (Compiler_Place_Holder)        ; Offset_0x000000
                lea     (Compiler_Place_Holder), A0            ; Offset_0x000000
                lea     (Compiler_Place_Holder), A1            ; Offset_0x000000
                lea     (Compiler_Place_Holder), A5            ; Offset_0x000000
                move.w  (Compiler_Place_Holder), D0            ; Offset_0x000000
                add.w   D0, D0
                move.w  (Compiler_Place_Holder), D7            ; Offset_0x000000
                move.w  D7, (Compiler_Place_Holder)            ; Offset_0x000000
                add.w   D0, D0
                move.l  $00(A0, D0), A0
                add.w   D0, D0
                adda.w  D0, A5
                lea     (Compiler_Place_Holder), A1            ; Offset_0x000000
                lea     (Compiler_Place_Holder), A2            ; Offset_0x000000
                lea     (Compiler_Place_Holder), A3            ; Offset_0x000000
                lea     (Compiler_Place_Holder), A4            ; Offset_0x000000
                moveq   #$00, D2
Offset_0x0EFDE5:
                move.w  (A0)+, D1
                add.w   (A5), D1
                muls.w  $0006(A5), D1
                asr.l   #$08, D1
                move.w  D1, (A1)+
                move.w  (A0)+, D1
                add.w   $0002(A5), D1
                muls.w  $0006(A5), D1
                asr.l   #$08, D1
                move.w  D1, (A2)+
                move.w  (A0)+, D1
                add.w   $0004(A5), D1
                muls.w  $0006(A5), D1
                asr.l   #$08, D1
                move.w  D1, (A3)+
                addq.w  #$02, A0
                move.w  D2, (A4)+
                addq.w  #$01, D2
                dbra    D7, Offset_0x0EFDE5
                moveq   #$00, D1
                move.w  (Compiler_Place_Holder), D0            ; Offset_0x000000
                asl.w   #$01, D0
                roxl.w  #$01, D1
                move.w  (Compiler_Place_Holder), D0            ; Offset_0x000000
                asl.w   #$01, D0
                roxl.w  #$01, D1
                move.w  (Compiler_Place_Holder), D0            ; Offset_0x000000
                asl.w   #$01, D0
                roxl.w  #$01, D1
                cmp.w   (Compiler_Place_Holder), D1            ; Offset_0x000000
                bne.s   Offset_0x0EFE8B
                move.w  (Compiler_Place_Holder), D1            ; Offset_0x000000
                add.w   (A5), D1
                muls.w  $0006(A5), D1
                asr.l   #$08, D1
                move.w  D1, (A1)
                move.w  (Compiler_Place_Holder), D1            ; Offset_0x000000
                add.w   $0002(A5), D1
                muls.w  $0006(A5), D1
                asr.l   #$08, D1
                move.w  D1, (A2)
                move.w  (Compiler_Place_Holder), D1            ; Offset_0x000000
                add.w   $0004(A5), D1
                muls.w  $0006(A5), D1
                asr.l   #$08, D1
                move.w  D1, (A3)
                move.w  #$FFFF, (A4)
                move.w  (Compiler_Place_Holder), D0            ; Offset_0x000000
                addq.w  #$01, D0
                move.w  D0, (Compiler_Place_Holder)            ; Offset_0x000000
                move.w  D0, (Compiler_Place_Holder)            ; Offset_0x000000
Offset_0x0EFE8B:
                move.w  #$0000, (Compiler_Place_Holder)        ; Offset_0x000000
                rts 
;-------------------------------------------------------------------------------
; Offset_0x0EFE95:
                move.w  #$FFFF, (Compiler_Place_Holder)        ; Offset_0x000000
                lea     (Compiler_Place_Holder), A0            ; Offset_0x000000
                lea     (Compiler_Place_Holder), A1            ; Offset_0x000000
                lea     (Compiler_Place_Holder), A2            ; Offset_0x000000
                lea     (Compiler_Place_Holder), A3            ; Offset_0x000000
                lea     (Compiler_Place_Holder), A4            ; Offset_0x000000
                lea     (Compiler_Place_Holder), A5            ; Offset_0x000000
                lea     (Compiler_Place_Holder), A6            ; Offset_0x000000
                moveq   #$00, D2
                moveq   #$00, D0
                move.b  $0001(A0), D0
                subq.w  #$01, D0
                bmi     Offset_0x0EFF19
                addq.w  #$02, A0
Offset_0x0EFED7:
                moveq   #$00, D7
                move.b  $0003(A0), D7
                add.w   D7, D7
                move.w  $00(A5, D7), (A1)+
                move.w  #$0000, (A2)+
                move.w  #$0000, (A3)+
                move.w  D2, (A4)+
                addq.w  #$01, D2
                move.b  $0002(A0), D7
                ext.w   D7
                move.w  D7, (A6)+
                adda.w  #$0025, A0
                dbra    D0, Offset_0x0EFED7
                lea     (Compiler_Place_Holder), A0            ; Offset_0x000000
                lea     (Compiler_Place_Holder), A2            ; Offset_0x000000
                moveq   #$0F, D7
Offset_0x0EFF0D:
                move.w  #$0200, (A0)+
                move.w  #$0000, (A2)+
                dbra    D7, Offset_0x0EFF0D
Offset_0x0EFF19:
                move.w  (Compiler_Place_Holder), (Compiler_Place_Holder) ; Offset_0x000000, Offset_0x000000
                move.w  (Compiler_Place_Holder), D0            ; Offset_0x000000
                cmpi.w  #$FFFF, D0
                beq     Offset_0x0EFF6D
                move.w  D0, D1
                move.w  D0, D2
                move.w  D0, D7
                andi.w  #$C000, D7
                cmpi.w  #$8000, D7
                bcs     Offset_0x0EFF6D
                andi.w  #$0007, D0
                cmp.w   (Compiler_Place_Holder), D0            ; Offset_0x000000
                bne     Offset_0x0EFF6D
                andi.w  #$0078, D1
                lsr.w   #$03, D1
                cmp.w   (Compiler_Place_Holder), D1            ; Offset_0x000000
                bne     Offset_0x0EFF6D
                andi.w  #$0780, D2
                lsr.w   #$07, D2
                move.w  D2, (Compiler_Place_Holder)            ; Offset_0x000000
Offset_0x0EFF6D:
                move.w  #$0001, (Compiler_Place_Holder)        ; Offset_0x000000
                rts
Offset_0x0EFF77:
                move.w  #$FFFF, (Compiler_Place_Holder)        ; Offset_0x000000
                lea     (Compiler_Place_Holder), A0            ; Offset_0x000000
                addq.w  #$02, A0
                move.w  (Compiler_Place_Holder), D1            ; Offset_0x000000
                muls.w  #$0025, D1
                adda.w  D1, A0
                lea     (Compiler_Place_Holder), A1            ; Offset_0x000000
                lea     (Compiler_Place_Holder), A2            ; Offset_0x000000
                lea     (Compiler_Place_Holder), A3            ; Offset_0x000000
                lea     (Compiler_Place_Holder), A4            ; Offset_0x000000
                lea     (Compiler_Place_Holder), A5            ; Offset_0x000000
                lea     (Compiler_Place_Holder), A6            ; Offset_0x000000
                moveq   #$00, D2
                moveq   #$00, D0
                move.b  $0004(A0), D0
                subq.w  #$01, D0
                bmi     (Left_Over_Code_End+$0007)             ; Offset_0x0F0007
                addq.w  #$05, A0
Offset_0x0EFFC7:
                moveq   #$00, D7
                move.b  $0003(A0), D7
                add.w   D7, D7
                move.w  $00(A5, D7), (A1)+
                move.w  #$0000, (A2)+
                move.w  #$0000, (A3)+
                move.w  D2, (A4)+
                addq.w  #$01, D2
                move.b  $0002(A0), D7
                ext.w   D7
                move.w  D7, (A6)+
                addq.w  #$04, A0
                dbra    D0, Offset_0x0EFFC7
                lea     (Compiler_Place_Holder), A0            ; Offset_0x000000
                lea     (Compiler_Place_Holder), A2            ; Offset_0x000000
                moveq   #$07, D7
                move.w  #$0200, (A0)+  
                dc.b    $34           ; move.w ???
Left_Over_Code_End:                                        
;-------------------------------------------------------------------------------   
; C�digo compilado incompleto
; <<<-
;-------------------------------------------------------------------------------