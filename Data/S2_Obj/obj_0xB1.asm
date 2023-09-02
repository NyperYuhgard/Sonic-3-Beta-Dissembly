;===============================================================================
; Objeto 0xB1 - Sonic correndo na tela SEGA
; ->>>
;===============================================================================    
Offset_0x0346BC:
                moveq   #$00, D0
                move.b  Obj_Routine(A0), D0                              ; $0005
                move.w  Offset_0x0346CA(PC, D0), D1
                jmp     Offset_0x0346CA(PC, D1)    
;-------------------------------------------------------------------------------                                             
Offset_0x0346CA:
                dc.w    Offset_0x0346CE-Offset_0x0346CA
                dc.w    Offset_0x0346F2-Offset_0x0346CA
;-------------------------------------------------------------------------------
Offset_0x0346CE:
                lea     S2_Obj_0xB1_Setup_Data(PC), A1                ; Offset_0x034864
                jsr     (Object_Settings)                      ; Offset_0x041D72
                move.b  #$00, Obj_Flags(A0)                              ; $0004
                move.b  #$04, Obj_Map_Id(A0)                             ; $0022
                move.w  #$0174, Obj_X(A0)                                ; $0010
                move.w  #$00D8, Obj_Y(A0)                                ; $0014
                rts
;-------------------------------------------------------------------------------                
Offset_0x0346F2:
                jmp     (DisplaySprite)                        ; Offset_0x011148
;-------------------------------------------------------------------------------                 
Offset_0x0346F8: ; Usado pelo objeto 0xB0  
                lea     (Horizontal_Scroll_Buffer+$0138).w, A1       ; $FFFFE138
                move.w  #$0022, D6
Offset_0x034700:
                subi.w  #$0020, (A1)
                addq.w  #$08, A1
                dbra    D6, Offset_0x034700
                rts
;-------------------------------------------------------------------------------                
Offset_0x03470C: ; Usado pelo objeto 0xB0
                lea     (Horizontal_Scroll_Buffer+$013C).w, A1       ; $FFFFE13C
                move.w  #$0022, D6
Offset_0x034714:
                addi.w  #$0020, (A1)
                addq.w  #$08, A1
                dbra    D6, Offset_0x034714
                rts
;-------------------------------------------------------------------------------                
Offset_0x034720: ; Usado pelo objeto 0xB0
                subq.b  #$01, Obj_Control_Var_00(A0)                     ; $0030
                bne.s   Offset_0x034766
                moveq   #$00, D0
                move.b  Obj_Control_Var_01(A0), D0                       ; $0031
                addq.b  #$01, D0
                cmp.b   $0001(A1), D0
                bcs.s   Offset_0x03473A
                tst.b   $0003(A1)
                bne.s   Offset_0x03476A
Offset_0x03473A:
                move.b  D0, Obj_Control_Var_01(A0)                       ; $0031
                move.b  (A1), Obj_Control_Var_00(A0)                     ; $0030
                lea     $0006(A1), A2 
                moveq   #$00, D1
                move.b  $0002(A1), D1
                move.w  D1, D2
                tst.w   D0
                beq.s   Offset_0x03475C
Offset_0x034752:
                subq.b  #$01, D0
                beq.s   Offset_0x03475A
                add.w   D2, D1
                bra.s   Offset_0x034752
Offset_0x03475A:
                adda.w  D1, A2
Offset_0x03475C:
                move.w  $0004(A1), A3
Offset_0x034760:
                move.w  (A2)+, (A3)+
                subq.w  #$02, D2
                bne.s   Offset_0x034760
Offset_0x034766:
                moveq   #$00, D0
                rts
Offset_0x03476A:
                moveq   #$01, D0
                rts 
;-------------------------------------------------------------------------------
Offset_0x03476E:
                dc.b    $04, $07, $10, $FF
                dc.w    Palette_Buffer+$0010                             ; $ED10                  
                dc.w    $0E60, $0E60, $0E60, $0E60, $0E60, $0E60, $0E60, $0EEE
                dc.w    $0E62, $0EEE, $0EEE, $0EEE, $0EEE, $0EEE, $0EEE, $0EEE
                dc.w    $0E84, $0E62, $0E60, $0E60, $0E60, $0E60, $0E60, $0EEE
                dc.w    $0EA6, $0E84, $0E62, $0E60, $0E60, $0E60, $0E60, $0EEE
                dc.w    $0EC8, $0EA6, $0E84, $0E62, $0E60, $0E60, $0E60, $0EEE
                dc.w    $0EEC, $0EC8, $0EA6, $0E84, $0E62, $0E60, $0E60, $0EEE
                dc.w    $0EEE, $0EEC, $0EC8, $0EA6, $0E84, $0E62, $0E60, $0EEE  
;-------------------------------------------------------------------------------
Offset_0x0347E4:
                dc.b    $04, $07, $10, $FF
                dc.w    Palette_Buffer                                   ; $ED00                    
                dc.w    $0EEE, $0E60, $0E60, $0E60, $0E60, $0E60, $0E60, $0E60
                dc.w    $0EEE, $0E62, $0E60, $0E60, $0E60, $0E60, $0E60, $0E60
                dc.w    $0EEE, $0E84, $0E62, $0E60, $0E60, $0E60, $0E60, $0E60
                dc.w    $0EEE, $0EA6, $0E84, $0E62, $0E60, $0E60, $0E60, $0E60
                dc.w    $0EEE, $0EC8, $0EA6, $0E84, $0E62, $0E60, $0E60, $0E60
                dc.w    $0EEE, $0EEC, $0EC8, $0EA6, $0E84, $0E62, $0E60, $0E60
                dc.w    $0EEE, $0EEE, $0EEC, $0EC8, $0EA6, $0E84, $0E62, $0E60 
;-------------------------------------------------------------------------------
S2_Obj_0xB0_Setup_Data:                                        ; Offset_0x03485A
                dc.l    Sonic_Sega_Logo_Mappings               ; Offset_0x034876
                dc.w    $C088
                dc.b    $00, $80, $10, $00      
;-------------------------------------------------------------------------------                  
S2_Obj_0xB1_Setup_Data:                                        ; Offset_0x034864
                dc.l    Sonic_Sega_Logo_Mappings               ; Offset_0x034876
                dc.w    $0003
                dc.b    $01, $00, $08, $00      
;-------------------------------------------------------------------------------
Sonic_SEGA_Logo_Animate_Data:                                  ; Offset_0x03486E
                dc.w    Offset_0x034870-Sonic_SEGA_Logo_Animate_Data
Offset_0x034870:
                dc.b    $00, $00, $01, $02, $03, $FF    
;-------------------------------------------------------------------------------   
Sonic_Sega_Logo_Mappings:                                      ; Offset_0x034876
                dc.w    Offset_0x034880-Sonic_Sega_Logo_Mappings
                dc.w    Offset_0x0348A6-Sonic_Sega_Logo_Mappings
                dc.w    Offset_0x0348CC-Sonic_Sega_Logo_Mappings
                dc.w    Offset_0x0348F2-Sonic_Sega_Logo_Mappings
                dc.w    Offset_0x034918-Sonic_Sega_Logo_Mappings
Offset_0x034880:
                dc.w    $0006
                dc.w    $D80F, $0000, $FFF0
                dc.w    $D807, $0010, $0010
                dc.w    $F80F, $0018, $FFE0
                dc.w    $180F, $0028, $FFE0
                dc.w    $F80F, $0038, $0000
                dc.w    $180F, $0048, $0000
Offset_0x0348A6:
                dc.w    $0006
                dc.w    $D80F, $0058, $FFF0
                dc.w    $D807, $0068, $0010
                dc.w    $F80F, $0070, $FFE0
                dc.w    $180F, $0080, $FFE0
                dc.w    $F80F, $0090, $0000
                dc.w    $180F, $00A0, $0000
Offset_0x0348CC:
                dc.w    $0006
                dc.w    $D80F, $00B0, $FFF0
                dc.w    $D807, $00C0, $0010
                dc.w    $F80F, $00C8, $FFE0
                dc.w    $180F, $00D8, $FFE0
                dc.w    $F80F, $00E8, $0000
                dc.w    $180F, $00F8, $0000
Offset_0x0348F2:
                dc.w    $0006
                dc.w    $D80F, $0108, $FFF0
                dc.w    $D807, $0118, $0010
                dc.w    $F80F, $0120, $FFE0
                dc.w    $180F, $0130, $FFE0
                dc.w    $F80F, $0140, $0000
                dc.w    $180F, $0150, $0000
Offset_0x034918:
                dc.w    $0002
                dc.w    $FC00, $0000, $FFF8
                dc.w    $FC00, $0000, $0000                                                                              
;===============================================================================
; Objeto 0xB1 - Sonic correndo na tela SEGA
; <<<-
;===============================================================================                                                      