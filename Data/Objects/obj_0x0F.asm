;===============================================================================
; Objeto 0x0F - Plataformas que desmoronam ao serem tocadas 
; ->>>
;===============================================================================
; Offset_0x01595E:
                move.l  #Offset_0x015B62, (A0)
                ori.b   #$04, Obj_Flags(A0)                              ; $0004
                move.w  #$0200, Obj_Priority(A0)                         ; $0008
                cmpi.b  #LBz_Id, (Level_Id).w                   ; $06, $FFFFFE10
                bne.s   Offset_0x0159E6
                move.b  Obj_Subtype(A0), D0                              ; $002C
                andi.w  #$003F, D0
                add.w   D0, D0
                add.w   D0, D0
                addq.w  #$08, D0
                bcc.s   Offset_0x01598C
                move.b  #$FF, D0
Offset_0x01598C:
                move.b  D0, Obj_Control_Var_08(A0)                       ; $0038
                btst    #$06, Obj_Subtype(A0)                            ; $002C
                bne.s   Offset_0x0159C4
                move.l  #LBz_Collapsing_Platforms_Mappings, Obj_Map(A0) ; Offset_0x0161E2, $000C
                move.w  #$4001, Obj_Art_VRAM(A0)                         ; $000A
                move.b  #$40, Obj_Width(A0)                              ; $0007
                move.b  #$10, Obj_Height(A0)                             ; $0006
                move.l  #Offset_0x015E26, Obj_Control_Var_00(A0)         ; $0030
                move.l  #Offset_0x015E36, Obj_Control_Var_04(A0)         ; $0034
                bra.s   Offset_0x0159E6
Offset_0x0159C4:
                move.l  #LBz_Collapsing_Platforms_Mappings_2, Obj_Map(A0) ; Offset_0x0162DE, $000C
                move.w  #$4001, Obj_Art_VRAM(A0)                         ; $000A
                move.b  #$20, Obj_Width(A0)                              ; $0007
                move.b  #$30, Obj_Height(A0)                             ; $0006
                move.l  #Offset_0x015E46, Obj_Control_Var_00(A0)         ; $0030
Offset_0x0159E6:
                cmpi.b  #Hz_Id, (Level_Id).w                    ; $01, $FFFFFE10
                bne     Offset_0x015A80
                move.l  #Hz_Collapsing_Platform_Mappings, Obj_Map(A0) ; Offset_0x016366, $000C
                move.w  #$C001, Obj_Art_VRAM(A0)                         ; $000A
                move.b  Obj_Subtype(A0), D0                              ; $002C
                bpl.s   Offset_0x015A18
                move.b  D0, D1
                andi.b  #$0F, D1
                move.b  D1, Obj_Control_Var_10(A0)                       ; $0040
                move.l  #Offset_0x015C44, (A0)
                andi.b  #$70, D0
Offset_0x015A18:
                move.b  D0, D1
                andi.w  #$000F, D0
                lsl.w   #$04, D0
                addq.w  #$08, D0
                move.b  D0, Obj_Control_Var_08(A0)                       ; $0038
                andi.w  #$00F0, D1
                lsr.w   #$02, D1
                lea     Offset_0x015A50(PC, D1), A1
                move.b  (A1)+, Obj_Width(A0)                             ; $0007
                move.b  (A1)+, Obj_Height(A0)                            ; $0006
                move.b  (A1)+, Obj_Map_Id(A0)                            ; $0022
                move.b  (A1)+, Obj_Subtype(A0)                           ; $002C
                add.w   D1, D1
                lea     Offset_0x015A60(PC, D1), A1
                move.l  (A1)+, Obj_Control_Var_00(A0)                    ; $0030
                move.l  (A1)+, Obj_Control_Var_04(A0)                    ; $0034
                bra.s   Offset_0x015A80    
;-------------------------------------------------------------------------------
Offset_0x015A50:
                dc.b    $40, $10, $00, $80, $50, $10, $03, $80
                dc.b    $40, $10, $06, $00, $50, $20, $09, $80  
;-------------------------------------------------------------------------------  
Offset_0x015A60:
                dc.l    Offset_0x015E54
                dc.l    Offset_0x015E64
                dc.l    Offset_0x015E74
                dc.l    Offset_0x015E88
                dc.l    Offset_0x015E9C
                dc.l    Offset_0x015E9C
                dc.l    Offset_0x015EAB
                dc.l    Offset_0x015EC3   
;-------------------------------------------------------------------------------
Offset_0x015A80:
                cmpi.b  #MGz_Id, (Level_Id).w                   ; $02, $FFFFFE10
                bne.s   Offset_0x015B02
                move.l  #MGz_Collapsing_Platform_Mappings, Obj_Map(A0) ; Offset_0x0167B4, $000C
                move.w  #$4001, Obj_Art_VRAM(A0)                         ; $000A
                move.b  Obj_Subtype(A0), D0                              ; $002C
                move.b  D0, D1
                andi.w  #$000F, D0
                lsl.w   #$04, D0
                addq.w  #$08, D0
                move.b  D0, Obj_Control_Var_08(A0)                       ; $0038
                andi.w  #$00F0, D1
                lsr.w   #$02, D1
                lea     Offset_0x015ADE(PC, D1), A1
                move.b  (A1)+, Obj_Width(A0)                             ; $0007
                move.b  (A1)+, Obj_Height(A0)                            ; $0006
                move.b  (A1)+, Obj_Map_Id(A0)                            ; $0022
                move.b  (A1)+, Obj_Subtype(A0)                           ; $002C
                add.w   D1, D1
                lea     Offset_0x015AEA(PC, D1), A1
                move.l  (A1)+, Obj_Control_Var_00(A0)                    ; $0030
                move.l  (A1)+, Obj_Control_Var_04(A0)                    ; $0034
                cmpi.w  #$0010, D1
                bne.s   Offset_0x015B02
                move.l  #Offset_0x015BD4, (A0)
                rts    
;-------------------------------------------------------------------------------
Offset_0x015ADE:
                dc.b    $40, $20, $00, $80, $30, $20, $03, $80
                dc.b    $40, $20, $06, $80 
;-------------------------------------------------------------------------------
Offset_0x015AEA:
                dc.l    Offset_0x015EDB
                dc.l    Offset_0x015EFB
                dc.l    Offset_0x015F1B
                dc.l    Offset_0x015F33
                dc.l    Offset_0x015EDB
                dc.l    Offset_0x015EFB   
;-------------------------------------------------------------------------------
Offset_0x015B02:
                cmpi.b  #Iz_Id, (Level_Id).w                    ; $05, $FFFFFE10
                bne.s   Offset_0x015B62
                move.b  Obj_Subtype(A0), D0                              ; $002C
                bpl.s   Offset_0x015B24
                move.b  D0, D1
                andi.b  #$0F, D1
                move.b  D1, Obj_Control_Var_10(A0)                       ; $0040
                move.l  #Offset_0x015C44, (A0)
                andi.b  #$70, D0
Offset_0x015B24:
                move.b  D0, D1
                andi.w  #$000F, D0
                lsl.w   #$04, D0
                addq.w  #$08, D0
                move.b  D0, Obj_Control_Var_08(A0)                       ; $0038
                move.l  #Iz_Collapsing_Platform_Mappings, Obj_Map(A0) ; Offset_0x016D00, $000C
                move.w  #$4001, Obj_Art_VRAM(A0)                         ; $000A
                move.b  #$50, Obj_Width(A0)                              ; $0007
                move.b  #$38, Obj_Height(A0)                             ; $0006
                move.l  #Offset_0x015F4B, Obj_Control_Var_00(A0)               ; $0030
                move.l  #Offset_0x015F77, Obj_Control_Var_04(A0)               ; $0034
                move.b  #$03, Obj_Map_Id(A0)                             ; $0022
Offset_0x015B62:
                tst.b   Obj_Control_Var_0A(A0)                           ; $003A
                beq.s   Offset_0x015BAC
                tst.b   Obj_Control_Var_08(A0)                           ; $0038
                bne.s   Offset_0x015BA8
                move.l  Obj_Control_Var_00(A0), A4                       ; $0030
                tst.b   Obj_Subtype(A0)                                  ; $002C
                bpl.s   Offset_0x015BA4
                move.b  Obj_Status(A0), D0                               ; $002A
                andi.b  #$18, D0
                beq.s   Offset_0x015BA4
                move.w  (Obj_Player_One+Obj_X).w, D1                 ; $FFFFB010
                andi.b  #$08, D0
                bne.s   Offset_0x015B90
                move.w  (Obj_Player_Two+Obj_X).w, D1                 ; $FFFFB05A
Offset_0x015B90:
                cmp.w   Obj_X(A0), D1                                    ; $0010
                bcc.s   Offset_0x015BA4
                move.l  Obj_Control_Var_04(A0), A4                       ; $0034
                bchg    #00, Obj_Status(A0)                              ; $002A
                addq.b  #$01, Obj_Map_Id(A0)                             ; $0022
Offset_0x015BA4:
                bra     Offset_0x015D5E
Offset_0x015BA8:
                subq.b  #$01, Obj_Control_Var_08(A0)                     ; $0038
Offset_0x015BAC:
                move.b  Obj_Status(A0), D0                               ; $002A
                andi.b  #$18, D0
                beq.s   Offset_0x015BBC
                move.b  #$01, Obj_Control_Var_0A(A0)                     ; $003A
Offset_0x015BBC:
                moveq   #$00, D1
                move.b  Obj_Width(A0), D1                                ; $0007
                move.w  #$0010, D3
                move.w  Obj_X(A0), D4                                    ; $0010
                jsr     (Platform_Object)                      ; Offset_0x013AF6
                bra     MarkObjGone                            ; Offset_0x011AF2
;-------------------------------------------------------------------------------
Offset_0x015BD4:
                tst.b   Obj_Control_Var_0A(A0)                           ; $003A
                beq.s   Offset_0x015C1E
                tst.b   Obj_Control_Var_08(A0)                           ; $0038
                bne.s   Offset_0x015C1A
                move.l  Obj_Control_Var_00(A0), A4                       ; $0030
                tst.b   Obj_Subtype(A0)                                  ; $002C
                bpl.s   Offset_0x015C16
                move.b  Obj_Status(A0), D0                               ; $002A
                andi.b  #$18, D0
                beq.s   Offset_0x015C16
                move.w  (Obj_Player_One+Obj_X).w, D1                 ; $FFFFB010
                andi.b  #$08, D0
                bne.s   Offset_0x015C02
                move.w  (Obj_Player_Two+Obj_X).w, D1                 ; $FFFFB05A
Offset_0x015C02:
                cmp.w   Obj_X(A0), D1                                    ; $0010
                bcc.s   Offset_0x015C16
                move.l  Obj_Control_Var_04(A0), A4                       ; $0034
                bchg    #00, Obj_Status(A0)                              ; $002A
                addq.b  #$01, Obj_Map_Id(A0)                             ; $0022
Offset_0x015C16:
                bra     Offset_0x015D5E
Offset_0x015C1A:
                subq.b  #$01, Obj_Control_Var_08(A0)                     ; $0038
Offset_0x015C1E:
                move.b  Obj_Status(A0), D0                               ; $002A
                andi.b  #$18, D0
                beq.s   Offset_0x015C40
                move.b  (Obj_Player_One+Obj_Player_Hit_Flag).w, D1   ; $FFFFB037
                andi.b  #$08, D0
                bne.s   Offset_0x015C36
                move.b  (Obj_Player_Two+Obj_Player_Hit_Flag).w, D1   ; $FFFFB081
Offset_0x015C36:
                tst.b   D1
                bpl.s   Offset_0x015C40
                move.b  #$01, Obj_Control_Var_0A(A0)                     ; $003A
Offset_0x015C40:
                bra     Offset_0x015BBC       
;-------------------------------------------------------------------------------
Offset_0x015C44:
                tst.b   Obj_Control_Var_0A(A0)                           ; $003A
                beq.s   Offset_0x015C8E
                tst.b   Obj_Control_Var_08(A0)                           ; $0038
                bne.s   Offset_0x015C8A
                move.l  Obj_Control_Var_00(A0), A4                       ; $0030
                tst.b   Obj_Subtype(A0)                                  ; $002C
                bpl.s   Offset_0x015C86
                move.b  Obj_Status(A0), D0                               ; $002A
                andi.b  #$18, D0
                beq.s   Offset_0x015C86
                move.w  (Obj_Player_One+Obj_X).w, D1                 ; $FFFFB010
                andi.b  #$08, D0
                bne.s   Offset_0x015C72
                move.w  (Obj_Player_Two+Obj_X).w, D1                 ; $FFFFB05A
Offset_0x015C72:
                cmp.w   Obj_X(A0), D1                                    ; $0010
                bcc.s   Offset_0x015C86
                move.l  Obj_Control_Var_04(A0), A4                       ; $0034
                bchg    #00, Obj_Status(A0)                              ; $002A
                addq.b  #$01, Obj_Map_Id(A0)                             ; $0022
Offset_0x015C86:
                bra     Offset_0x015D5E
Offset_0x015C8A:
                subq.b  #$01, Obj_Control_Var_08(A0)                     ; $0038
Offset_0x015C8E:
                move.b  Obj_Control_Var_10(A0), D0                       ; $0040
                andi.w  #$000F, D0
                lea     (Level_Trigger_Array).w, A3                  ; $FFFFF7E0
                lea     $00(A3, D0), A3
                tst.b   (A3)
                beq.s   Offset_0x015CAC
                move.b  #$01, Obj_Control_Var_0A(A0)                     ; $003A
                clr.w   Obj_Respaw_Ref(A0)                               ; $0048
Offset_0x015CAC:
                bra     Offset_0x015BBC   
;-------------------------------------------------------------------------------
Offset_0x015CB0:
                tst.b   Obj_Control_Var_08(A0)                           ; $0038
                beq     Offset_0x015CC8
                tst.b   Obj_Control_Var_0A(A0)                           ; $003A
                bne.s   Offset_0x015CE0
                subq.b  #$01, Obj_Control_Var_08(A0)                     ; $0038
                jmp     (DisplaySprite)                        ; Offset_0x011148
Offset_0x015CC8:
                jsr     (ObjectFall)                           ; Offset_0x0110FE
                tst.b   Obj_Flags(A0)                                    ; $0004
                bpl.s   Offset_0x015CDA
                jmp     (DisplaySprite)                        ; Offset_0x011148
Offset_0x015CDA:
                jmp     (DeleteObject)                         ; Offset_0x011138
Offset_0x015CE0:
                subq.b  #$01, Obj_Control_Var_08(A0)                     ; $0038
                move.b  Obj_Control_Var_08(A0), D3                       ; $0038
                move.l  Obj_Control_Var_00(A0), A2                       ; $0030
                moveq   #$00, D1
                move.b  Obj_Width(A0), D1                                ; $0007
                lea     (Obj_Player_One).w, A1                       ; $FFFFB000
                moveq   #$03, D6
                bsr.s   Offset_0x015D06
                lea     (Obj_Player_Two).w, A1                       ; $FFFFB04A
                moveq   #$04, D6
                bsr.s   Offset_0x015D06
                bra     MarkObjGone                            ; Offset_0x011AF2
Offset_0x015D06:
                btst    D6, Obj_Status(A0)                               ; $002A
                beq.s   Offset_0x015D5C
                move.w  D1, D2
                add.w   D2, D2
                btst    #$01, Obj_Status(A1)                             ; $002A
                bne.s   Offset_0x015D40
                move.w  Obj_X(A1), D0                                    ; $0010
                sub.w   Obj_X(A0), D0                                    ; $0010
                add.w   D1, D0
                bmi.s   Offset_0x015D40
                cmp.w   D2, D0
                bcc.s   Offset_0x015D40
                btst    #$00, Obj_Status(A0)                             ; $002A
                beq.s   Offset_0x015D34
                neg.w   D0
                add.w   D2, D0
Offset_0x015D34:
                lsr.w   #$04, D0
                move.b  (A2), D2
                sub.b   $00(A2, D0), D2
                cmp.b   D2, D3
                bhi.s   Offset_0x015D5C
Offset_0x015D40:
                bclr    D6, Obj_Status(A0)                               ; $002A
                bclr    #$03, Obj_Status(A1)                             ; $002A
                bclr    #$05, Obj_Status(A1)                             ; $002A
                bset    #$01, Obj_Status(A1)                             ; $002A
                move.b  #$01, Obj_Ani_Flag(A1)                           ; $0021
Offset_0x015D5C:
                rts
;-------------------------------------------------------------------------------                
Offset_0x015D5E:
                move.l  #Offset_0x015CB0, (A0)
                addq.b  #$01, Obj_Map_Id(A0)                             ; $0022
                bra.s   Offset_0x015D78     
;------------------------------------------------------------------------------- 
Offset_0x015D6A: ; Usado pelo objeto 0x04
                move.l  #Offset_0x0158FE, (A0)
                addq.b  #$02, Obj_Map_Id(A0)                             ; $0022
                move.l  Obj_Control_Var_00(A0), A4                       ; $0030
;-------------------------------------------------------------------------------                 
Offset_0x015D78:
                moveq   #$00, D0
                move.b  Obj_Map_Id(A0), D0                               ; $0022
                add.w   D0, D0
                move.l  Obj_Map(A0), A3                                  ; $000C
                adda.w  $00(A3, D0), A3
                move.w  (A3)+, D1
                subq.w  #$01, D1
                bset    #$05, Obj_Flags(A0)                              ; $0004
                move.l  (A0), D4
                move.b  Obj_Flags(A0), D5                                ; $0004
                move.l  A0, A1
                bra.s   Offset_0x015DA4              
;-------------------------------------------------------------------------------
Offset_0x015D9C:
                bsr     SingleObjectLoad_A0                    ; Offset_0x011DE0
                bne.s   Offset_0x015DDA
                addq.w  #$06, A3
;-------------------------------------------------------------------------------                
Offset_0x015DA4:
                move.l  D4, (A1)
                move.l  A3, Obj_Map(A1)                                  ; $000C
                move.b  D5, Obj_Flags(A1)                                ; $0004
                move.w  Obj_X(A0), Obj_X(A1)                      ; $0010, $0010
                move.w  Obj_Y(A0), Obj_Y(A1)                      ; $0014, $0014
                move.w  Obj_Art_VRAM(A0), Obj_Art_VRAM(A1)        ; $000A, $000A
                move.w  Obj_Priority(A0), Obj_Priority(A1)        ; $0008, $0008
                move.b  Obj_Width(A0), Obj_Width(A1)              ; $0007, $0007
                move.b  Obj_Height(A0), Obj_Height(A1)            ; $0006, $0006
                move.b  (A4)+, Obj_Control_Var_08(A1)                    ; $0038
                dbra    D1, Offset_0x015D9C
Offset_0x015DDA:
                jsr     (DisplaySprite)                        ; Offset_0x011148
                moveq   #Smash_Sfx, D0                                     ; $62
                jmp     (Play_Music)                           ; Offset_0x001176  
;-------------------------------------------------------------------------------  
Offset_0x015DE8:
                dc.b    $30, $2C, $28, $24, $20, $1C, $2E, $2A
                dc.b    $26, $22, $1E, $1A, $2C, $28, $24, $20
                dc.b    $1C, $18, $2A, $26, $22, $1E, $1A, $16
                dc.b    $28, $24, $20, $1C, $18, $14                                                             
;------------------------------------------------------------------------------- 
Offset_0x015E06:    
                dc.b    $30, $2C, $28, $24, $20, $1C, $2E, $2A
                dc.b    $26, $22, $1E, $1A, $2C, $28, $24, $20
                dc.b    $1C, $18, $2A, $26, $22, $1E, $1A, $16
                dc.b    $28, $24, $20, $1C, $18, $14, $12, $10                                                         
;-------------------------------------------------------------------------------
Offset_0x015E26:    
                dc.b    $20, $1C, $18, $14, $10, $0C, $08, $04
                dc.b    $1E, $1A, $16, $12, $0E, $0A, $06, $02                                                
;-------------------------------------------------------------------------------
Offset_0x015E36   
                dc.b    $20, $04, $08, $0C, $10, $14, $18, $1C
                dc.b    $02, $06, $0A, $0E, $12, $16, $1A, $1E
;------------------------------------------------------------------------------- 
Offset_0x015E46:  
                dc.b    $20, $18, $10, $08, $1E, $16, $0E, $06
                dc.b    $1C, $14, $0C, $04, $1A, $12
;-------------------------------------------------------------------------------  
Offset_0x015E54:   
                dc.b    $20, $1C, $18, $14, $10, $0C, $08, $04
                dc.b    $1E, $1A, $16, $12, $0E, $0A, $06, $02
;------------------------------------------------------------------------------- 
Offset_0x015E64:     
                dc.b    $20, $04, $08, $0C, $10, $14, $18, $1C
                dc.b    $02, $06, $0A, $0E, $12, $16, $1A, $1E                                      
;-------------------------------------------------------------------------------  
Offset_0x015E74:  
                dc.b    $28, $24, $20, $1C, $18, $14, $10, $0C
                dc.b    $08, $04, $26, $22, $1E, $1A, $16, $12
                dc.b    $0E, $0A, $06, $02                                                  
;------------------------------------------------------------------------------- 
Offset_0x015E88: 
                dc.b    $28, $04, $08, $0C, $10, $14, $18, $1C
                dc.b    $20, $24, $02, $06, $0A, $0E, $12, $16
                dc.b    $1A, $1E, $22, $26                                                      
;-------------------------------------------------------------------------------
Offset_0x015E9C:   
                dc.b    $1C, $04, $08, $0C, $10, $14, $18, $02
                dc.b    $06, $0A, $0E, $12, $16, $1A, $1E
;------------------------------------------------------------------------------- 
Offset_0x015EAB:   
                dc.b    $30, $2A, $24, $1E, $18, $12, $0C, $06
                dc.b    $2E, $28, $22, $1C, $16, $10, $0A, $04
                dc.b    $2C, $26, $20, $1A, $14, $0E, $08, $02
;------------------------------------------------------------------------------- 
Offset_0x015EC3:  
                dc.b    $30, $06, $0C, $12, $18, $1E, $24, $2A
                dc.b    $04, $0A, $10, $16, $1C, $22, $28, $2E
                dc.b    $02, $08, $0E, $14, $1A, $20, $26, $2C
;-------------------------------------------------------------------------------  
Offset_0x015EDB:   
                dc.b    $40, $38, $30, $28, $20, $18, $10, $08
                dc.b    $3E, $36, $2E, $26, $1E, $16, $0E, $06
                dc.b    $3C, $34, $2C, $24, $1C, $14, $0C, $04
                dc.b    $3A, $32, $2A, $22, $1A, $12, $0A, $02
;-------------------------------------------------------------------------------  
Offset_0x015EFB:  
                dc.b    $40, $08, $10, $18, $20, $28, $30, $38
                dc.b    $06, $0E, $16, $1E, $26, $2E, $36, $3E
                dc.b    $04, $0C, $14, $1C, $24, $2C, $34, $3C
                dc.b    $02, $0A, $12, $1A, $22, $2A, $32, $3A
;------------------------------------------------------------------------------- 
Offset_0x015F1B: 
                dc.b    $30, $28, $20, $18, $10, $08, $2E, $26
                dc.b    $1E, $16, $0E, $06, $2C, $24, $1C, $14
                dc.b    $0C, $04, $2A, $22, $1A, $12, $0A, $02
;-------------------------------------------------------------------------------  
Offset_0x015F33:     
                dc.b    $30, $08, $10, $18, $20, $28, $06, $0E
                dc.b    $16, $1E, $26, $2E, $04, $0C, $14, $1C
                dc.b    $24, $2C, $02, $0A, $12, $1A, $22, $2A
;-------------------------------------------------------------------------------  
Offset_0x015F4B: 
                dc.b    $28, $24, $20, $1C, $18, $14, $10, $0C
                dc.b    $08, $04, $27, $23, $1F, $1B, $17, $13
                dc.b    $0F, $0B, $07, $03, $26, $22, $1E, $1A
                dc.b    $16, $12, $0E, $0A, $06, $02, $25, $21
                dc.b    $1D, $19, $15, $11, $0D, $09, $05, $01
                dc.b    $04, $03, $02, $01
;-------------------------------------------------------------------------------  
Offset_0x015F77:
                dc.b    $28, $04, $08, $0C, $10, $14, $18, $1C
                dc.b    $20, $24, $03, $07, $0B, $0F, $13, $17
                dc.b    $1B, $1F, $23, $27, $02, $06, $0A, $0E
                dc.b    $12, $16, $1A, $1E, $22, $26, $01, $05
                dc.b    $09, $0D, $11, $15, $19, $1D, $21, $25
                dc.b    $01, $02, $03, $04, $00
;-------------------------------------------------------------------------------
Offset_0x015FA4:  
                dc.b    $1F, $1F, $1F, $1F, $1F, $1F, $1F, $1F
                dc.b    $1F, $1F, $1F, $1F, $1F, $1F, $1F, $1F
                dc.b    $1F, $1F, $1F, $1F, $1F, $1F, $1E, $1E
                dc.b    $1D, $1D, $1C, $1C, $1B, $1B, $1A, $1A
                dc.b    $19, $19, $18, $18, $17, $17, $16, $16
                dc.b    $15, $15, $14, $14, $13, $13, $12, $12
                dc.b    $11, $11, $10, $10, $0F, $0F, $0E, $0E
                dc.b    $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E                                                       
;-------------------------------------------------------------------------------
Offset_0x015FE4:
                dc.b    $30, $30, $30, $30, $30, $30, $30, $30
                dc.b    $30, $30, $30, $30, $2F, $2F, $2F, $2F
                dc.b    $2F, $2F, $2F, $2F, $2F, $2F, $2F, $2F
                dc.b    $2E, $2E, $2E, $2E, $2E, $2E, $2E, $2E
                dc.b    $2D, $2D, $2D, $2D, $2D, $2D, $2D, $2D
                dc.b    $2D, $2D, $2D, $2D, $2D, $2C, $2B, $2A                                                        
;------------------------------------------------------------------------------- 
Collapsing_Platform_Mappings:                                  ; Offset_0x016014
                dc.w    Offset_0x01601C-Collapsing_Platform_Mappings
                dc.w    Offset_0x01601C-Collapsing_Platform_Mappings
                dc.w    Offset_0x016066-Collapsing_Platform_Mappings
                dc.w    Offset_0x016066-Collapsing_Platform_Mappings
Offset_0x01601C:
                dc.w    $000C
                dc.w    $E00D, $0000, $FFD0
                dc.w    $E00D, $0008, $FFF0
                dc.w    $E80C, $0010, $0010
                dc.w    $F00D, $0014, $FFD0
                dc.w    $F00D, $0814, $FFF0
                dc.w    $F00D, $001C, $0010
                dc.w    $000D, $0024, $FFD0
                dc.w    $000D, $0824, $FFF0
                dc.w    $000D, $0824, $0010
                dc.w    $100D, $002C, $FFD0
                dc.w    $100D, $082C, $FFF0
                dc.w    $100D, $002C, $0010
Offset_0x016066:
                dc.w    $0018
                dc.w    $E005, $0000, $FFD0
                dc.w    $E005, $0004, $FFE0
                dc.w    $E005, $0008, $FFF0
                dc.w    $E005, $000C, $0000
                dc.w    $E804, $0010, $0010
                dc.w    $E804, $0012, $0020
                dc.w    $F005, $0014, $FFD0
                dc.w    $F005, $0018, $FFE0
                dc.w    $F005, $0818, $FFF0
                dc.w    $F005, $0814, $0000
                dc.w    $F005, $001C, $0010
                dc.w    $F005, $0020, $0020
                dc.w    $0005, $0024, $FFD0
                dc.w    $0005, $0028, $FFE0
                dc.w    $0005, $0828, $FFF0
                dc.w    $0005, $0824, $0000
                dc.w    $0005, $0828, $0010
                dc.w    $0005, $0824, $0020
                dc.w    $1005, $002C, $FFD0
                dc.w    $1005, $0030, $FFE0
                dc.w    $1005, $0830, $FFF0
                dc.w    $1005, $082C, $0000
                dc.w    $1005, $002C, $0010
                dc.w    $1005, $0030, $0020 
;------------------------------------------------------------------------------- 
AIz_2_Collapsing_Platform_Mappings:                            ; Offset_0x0160F8
                dc.w    Offset_0x016100-AIz_2_Collapsing_Platform_Mappings
                dc.w    Offset_0x016100-AIz_2_Collapsing_Platform_Mappings
                dc.w    Offset_0x016150-AIz_2_Collapsing_Platform_Mappings
                dc.w    Offset_0x016150-AIz_2_Collapsing_Platform_Mappings
Offset_0x016100:
                dc.w    $000D
                dc.w    $E00D, $0000, $FFD0
                dc.w    $E00D, $0800, $FFF0
                dc.w    $E005, $0008, $0010
                dc.w    $E804, $000C, $0020
                dc.w    $F00D, $000E, $FFD0
                dc.w    $F00D, $000E, $FFF0
                dc.w    $F00D, $080E, $0010
                dc.w    $000D, $0016, $FFD0
                dc.w    $000D, $0816, $FFF0
                dc.w    $000D, $0016, $0010
                dc.w    $100D, $001E, $FFD0
                dc.w    $100D, $081E, $FFF0
                dc.w    $100D, $001E, $0010
Offset_0x016150:
                dc.w    $0018
                dc.w    $E005, $0000, $FFD0
                dc.w    $E005, $0004, $FFE0
                dc.w    $E005, $0804, $FFF0
                dc.w    $E005, $0800, $0000
                dc.w    $E005, $0008, $0010
                dc.w    $E804, $000C, $0020
                dc.w    $F005, $000E, $FFD0
                dc.w    $F005, $0012, $FFE0
                dc.w    $F005, $000E, $FFF0
                dc.w    $F005, $0012, $0000
                dc.w    $F005, $0812, $0010
                dc.w    $F005, $080E, $0020
                dc.w    $0005, $0016, $FFD0
                dc.w    $0005, $001A, $FFE0
                dc.w    $0005, $081A, $FFF0
                dc.w    $0005, $0816, $0000
                dc.w    $0005, $0016, $0010
                dc.w    $0005, $001A, $0020
                dc.w    $1005, $001E, $FFD0
                dc.w    $1005, $0022, $FFE0
                dc.w    $1005, $0822, $FFF0
                dc.w    $1005, $081E, $0000
                dc.w    $1005, $001E, $0010
                dc.w    $1005, $0022, $0020
;------------------------------------------------------------------------------- 
LBz_Collapsing_Platforms_Mappings:                             ; Offset_0x0161E2
                dc.w    Offset_0x0161E8-LBz_Collapsing_Platforms_Mappings
                dc.w    Offset_0x01621A-LBz_Collapsing_Platforms_Mappings
                dc.w    Offset_0x01627C-LBz_Collapsing_Platforms_Mappings
Offset_0x0161E8:
                dc.w    $0008
                dc.w    $F00D, $0000, $FFC0
                dc.w    $F00D, $0000, $FFE0
                dc.w    $F00D, $0000, $0000
                dc.w    $F00D, $0000, $0020
                dc.w    $000D, $0008, $FFC0
                dc.w    $000D, $0008, $FFE0
                dc.w    $000D, $0008, $0000
                dc.w    $000D, $0008, $0020
Offset_0x01621A:
                dc.w    $0010
                dc.w    $F005, $0000, $FFC0
                dc.w    $F005, $0000, $FFD0
                dc.w    $F005, $0000, $FFE0
                dc.w    $F005, $0000, $FFF0
                dc.w    $F005, $0000, $0000
                dc.w    $F005, $0000, $0010
                dc.w    $F005, $0000, $0020
                dc.w    $F005, $0000, $0030
                dc.w    $0005, $0008, $FFC0
                dc.w    $0005, $0808, $FFD0
                dc.w    $0005, $0008, $FFE0
                dc.w    $0005, $0808, $FFF0
                dc.w    $0005, $0008, $0000
                dc.w    $0005, $0808, $0010
                dc.w    $0005, $0008, $0020
                dc.w    $0005, $0808, $0030
Offset_0x01627C:
                dc.w    $0010
                dc.w    $F005, $0000, $0030
                dc.w    $F005, $0000, $FFC0
                dc.w    $F005, $0000, $FFD0
                dc.w    $F005, $0000, $FFE0
                dc.w    $F005, $0000, $FFF0
                dc.w    $F005, $0000, $0000
                dc.w    $F005, $0000, $0010
                dc.w    $F005, $0000, $0020
                dc.w    $0005, $0008, $FFC0
                dc.w    $0005, $0808, $FFD0
                dc.w    $0005, $0008, $FFE0
                dc.w    $0005, $0808, $FFF0
                dc.w    $0005, $0008, $0000
                dc.w    $0005, $0808, $0010
                dc.w    $0005, $0008, $0020
                dc.w    $0005, $0808, $0030  
;-------------------------------------------------------------------------------  
LBz_Collapsing_Platforms_Mappings_2:                           ; Offset_0x0162DE
                dc.w    Offset_0x0162E4-LBz_Collapsing_Platforms_Mappings_2
                dc.w    Offset_0x016310-LBz_Collapsing_Platforms_Mappings_2
                dc.w    Offset_0x016310-LBz_Collapsing_Platforms_Mappings_2
Offset_0x0162E4:
                dc.w    $0007
                dc.w    $F00D, $0000, $FFE0
                dc.w    $F00D, $0010, $0000
                dc.w    $000D, $0018, $FFE0
                dc.w    $000D, $0020, $0000
                dc.w    $100D, $0028, $FFE0
                dc.w    $100D, $0030, $0000
                dc.w    $200D, $0030, $FFE0
Offset_0x016310:
                dc.w    $000E
                dc.w    $F005, $0000, $FFE0
                dc.w    $F005, $0000, $FFF0
                dc.w    $F005, $0000, $0000
                dc.w    $F005, $0014, $0010
                dc.w    $0005, $0018, $FFE0
                dc.w    $0005, $001C, $FFF0
                dc.w    $0005, $0020, $0000
                dc.w    $0005, $0024, $0010
                dc.w    $1005, $0028, $FFE0
                dc.w    $1005, $002C, $FFF0
                dc.w    $1005, $0030, $0000
                dc.w    $1005, $0034, $0010
                dc.w    $2005, $0030, $FFE0
                dc.w    $2005, $0034, $FFF0 
;-------------------------------------------------------------------------------  
Hz_Collapsing_Platform_Mappings:                               ; Offset_0x016366
                dc.w    Offset_0x01637E-Hz_Collapsing_Platform_Mappings
                dc.w    Offset_0x0163B6-Hz_Collapsing_Platform_Mappings
                dc.w    Offset_0x016418-Hz_Collapsing_Platform_Mappings
                dc.w    Offset_0x01647A-Hz_Collapsing_Platform_Mappings
                dc.w    Offset_0x0164BE-Hz_Collapsing_Platform_Mappings
                dc.w    Offset_0x016538-Hz_Collapsing_Platform_Mappings
                dc.w    Offset_0x0165B2-Hz_Collapsing_Platform_Mappings
                dc.w    Offset_0x0165EA-Hz_Collapsing_Platform_Mappings
                dc.w    Offset_0x0165EA-Hz_Collapsing_Platform_Mappings
                dc.w    Offset_0x016646-Hz_Collapsing_Platform_Mappings
                dc.w    Offset_0x016690-Hz_Collapsing_Platform_Mappings
                dc.w    Offset_0x016722-Hz_Collapsing_Platform_Mappings
Offset_0x01637E:
                dc.w    $0009
                dc.w    $F00D, $0000, $FFC0
                dc.w    $F00D, $0000, $FFE0
                dc.w    $F00D, $0000, $0000
                dc.w    $F00D, $0000, $0020
                dc.w    $0005, $0008, $FFC0
                dc.w    $000D, $000C, $FFD0
                dc.w    $000D, $000C, $FFF0
                dc.w    $000D, $000C, $0010
                dc.w    $0005, $000C, $0030
Offset_0x0163B6:
                dc.w    $0010
                dc.w    $F005, $0000, $FFC0
                dc.w    $F005, $0004, $FFD0
                dc.w    $F005, $0000, $FFE0
                dc.w    $F005, $0004, $FFF0
                dc.w    $F005, $0000, $0000
                dc.w    $F005, $0004, $0010
                dc.w    $F005, $0000, $0020
                dc.w    $F005, $0004, $0030
                dc.w    $0005, $0008, $FFC0
                dc.w    $0005, $000C, $FFD0
                dc.w    $0005, $0010, $FFE0
                dc.w    $0005, $000C, $FFF0
                dc.w    $0005, $0010, $0000
                dc.w    $0005, $000C, $0010
                dc.w    $0005, $0010, $0020
                dc.w    $0005, $000C, $0030
Offset_0x016418:
                dc.w    $0010
                dc.w    $F005, $0004, $0030
                dc.w    $F005, $0000, $FFC0
                dc.w    $F005, $0004, $FFD0
                dc.w    $F005, $0000, $FFE0
                dc.w    $F005, $0004, $FFF0
                dc.w    $F005, $0000, $0000
                dc.w    $F005, $0004, $0010
                dc.w    $F005, $0000, $0020
                dc.w    $0005, $0008, $FFC0
                dc.w    $0005, $000C, $FFD0
                dc.w    $0005, $0010, $FFE0
                dc.w    $0005, $000C, $FFF0
                dc.w    $0005, $0010, $0000
                dc.w    $0005, $000C, $0010
                dc.w    $0005, $0010, $0020
                dc.w    $0005, $000C, $0030
Offset_0x01647A:
                dc.w    $000B
                dc.w    $F00D, $0000, $FFB0
                dc.w    $F00D, $0000, $FFD0
                dc.w    $F00D, $0000, $FFF0
                dc.w    $F00D, $0000, $0010
                dc.w    $F00D, $0000, $0030
                dc.w    $0005, $0008, $FFB0
                dc.w    $000D, $000C, $FFC0
                dc.w    $000D, $000C, $FFE0
                dc.w    $000D, $000C, $0000
                dc.w    $000D, $000C, $0020
                dc.w    $0005, $000C, $0040
Offset_0x0164BE:
                dc.w    $0014
                dc.w    $F005, $0000, $FFB0
                dc.w    $F005, $0004, $FFC0
                dc.w    $F005, $0000, $FFD0
                dc.w    $F005, $0004, $FFE0
                dc.w    $F005, $0000, $FFF0
                dc.w    $F005, $0004, $0000
                dc.w    $F005, $0000, $0010
                dc.w    $F005, $0004, $0020
                dc.w    $F005, $0000, $0030
                dc.w    $F005, $0004, $0040
                dc.w    $0005, $0008, $FFB0
                dc.w    $0005, $000C, $FFC0
                dc.w    $0005, $0010, $FFD0
                dc.w    $0005, $000C, $FFE0
                dc.w    $0005, $0010, $FFF0
                dc.w    $0005, $000C, $0000
                dc.w    $0005, $0010, $0010
                dc.w    $0005, $000C, $0020
                dc.w    $0005, $0010, $0030
                dc.w    $0005, $000C, $0040
Offset_0x016538:
                dc.w    $0014
                dc.w    $F005, $0004, $0040
                dc.w    $F005, $0000, $FFB0
                dc.w    $F005, $0004, $FFC0
                dc.w    $F005, $0000, $FFD0
                dc.w    $F005, $0004, $FFE0
                dc.w    $F005, $0000, $FFF0
                dc.w    $F005, $0004, $0000
                dc.w    $F005, $0000, $0010
                dc.w    $F005, $0004, $0020
                dc.w    $F005, $0000, $0030
                dc.w    $0005, $0008, $FFB0
                dc.w    $0005, $000C, $FFC0
                dc.w    $0005, $0010, $FFD0
                dc.w    $0005, $000C, $FFE0
                dc.w    $0005, $0010, $FFF0
                dc.w    $0005, $000C, $0000
                dc.w    $0005, $0010, $0010
                dc.w    $0005, $000C, $0020
                dc.w    $0005, $0010, $0030
                dc.w    $0005, $000C, $0040
Offset_0x0165B2:
                dc.w    $0009
                dc.w    $F005, $0014, $FFC0
                dc.w    $F00D, $0000, $FFD0
                dc.w    $F00D, $0000, $FFF0
                dc.w    $F00D, $0000, $0010
                dc.w    $0005, $0018, $FFC0
                dc.w    $0005, $0010, $FFD0
                dc.w    $000D, $000C, $FFE0
                dc.w    $000D, $000C, $0000
                dc.w    $000D, $001C, $0020
Offset_0x0165EA:
                dc.w    $000F
                dc.w    $F005, $0004, $0020
                dc.w    $F005, $0014, $FFC0
                dc.w    $F005, $0000, $FFD0
                dc.w    $F005, $0004, $FFE0
                dc.w    $F005, $0000, $FFF0
                dc.w    $F005, $0004, $0000
                dc.w    $F005, $0000, $0010
                dc.w    $0005, $0018, $FFC0
                dc.w    $0005, $0010, $FFD0
                dc.w    $0005, $000C, $FFE0
                dc.w    $0005, $0010, $FFF0
                dc.w    $0005, $000C, $0000
                dc.w    $0005, $0010, $0010
                dc.w    $0005, $001C, $0020
                dc.w    $0005, $0020, $0030
Offset_0x016646:
                dc.w    $000C
                dc.w    $F00D, $0024, $FFC0
                dc.w    $F00D, $0024, $FFE0
                dc.w    $F00D, $0024, $0000
                dc.w    $F00D, $0024, $0020
                dc.w    $000D, $002C, $FFC0
                dc.w    $000D, $0034, $FFE0
                dc.w    $000D, $002C, $0000
                dc.w    $000D, $0034, $0020
                dc.w    $100E, $003C, $FFC0
                dc.w    $100D, $0048, $FFE0
                dc.w    $100E, $003C, $0000
                dc.w    $100D, $0048, $0020
Offset_0x016690:
                dc.w    $0018
                dc.w    $F005, $0024, $FFC0
                dc.w    $F005, $0028, $FFD0
                dc.w    $F005, $0024, $FFE0
                dc.w    $F005, $0028, $FFF0
                dc.w    $F005, $0024, $0000
                dc.w    $F005, $0028, $0010
                dc.w    $F005, $0024, $0020
                dc.w    $F005, $0028, $0030
                dc.w    $0005, $002C, $FFC0
                dc.w    $0005, $0030, $FFD0
                dc.w    $0005, $0034, $FFE0
                dc.w    $0005, $0038, $FFF0
                dc.w    $0005, $002C, $0000
                dc.w    $0005, $0030, $0010
                dc.w    $0005, $0034, $0020
                dc.w    $0005, $0038, $0030
                dc.w    $1006, $003C, $FFC0
                dc.w    $1006, $0042, $FFD0
                dc.w    $1005, $0048, $FFE0
                dc.w    $1005, $004C, $FFF0
                dc.w    $1006, $003C, $0000
                dc.w    $1006, $0042, $0010
                dc.w    $1005, $0048, $0020
                dc.w    $1005, $004C, $0030
Offset_0x016722:
                dc.w    $0018
                dc.w    $F005, $0028, $0030
                dc.w    $F005, $0024, $FFC0
                dc.w    $F005, $0028, $FFD0
                dc.w    $F005, $0024, $FFE0
                dc.w    $F005, $0028, $FFF0
                dc.w    $F005, $0024, $0000
                dc.w    $F005, $0028, $0010
                dc.w    $F005, $0024, $0020
                dc.w    $0005, $002C, $FFC0
                dc.w    $0005, $0030, $FFD0
                dc.w    $0005, $0034, $FFE0
                dc.w    $0005, $0038, $FFF0
                dc.w    $0005, $002C, $0000
                dc.w    $0005, $0030, $0010
                dc.w    $0005, $0034, $0020
                dc.w    $0005, $0038, $0030
                dc.w    $1006, $003C, $FFC0
                dc.w    $1006, $0042, $FFD0
                dc.w    $1005, $0048, $FFE0
                dc.w    $1005, $004C, $FFF0
                dc.w    $1006, $003C, $0000
                dc.w    $1006, $0042, $0010
                dc.w    $1005, $0048, $0020
                dc.w    $1005, $004C, $0030             
;-------------------------------------------------------------------------------  
MGz_Collapsing_Platform_Mappings:                              ; Offset_0x0167B4
                dc.w    Offset_0x0167C6-MGz_Collapsing_Platform_Mappings
                dc.w    Offset_0x016828-MGz_Collapsing_Platform_Mappings
                dc.w    Offset_0x0168EA-MGz_Collapsing_Platform_Mappings
                dc.w    Offset_0x0169AC-MGz_Collapsing_Platform_Mappings
                dc.w    Offset_0x0169F6-MGz_Collapsing_Platform_Mappings
                dc.w    Offset_0x016A88-MGz_Collapsing_Platform_Mappings
                dc.w    Offset_0x016B1A-MGz_Collapsing_Platform_Mappings
                dc.w    Offset_0x016B7C-MGz_Collapsing_Platform_Mappings
                dc.w    Offset_0x016C3E-MGz_Collapsing_Platform_Mappings
Offset_0x0167C6:
                dc.w    $0010
                dc.w    $EC0D, $0018, $FFC0
                dc.w    $EC0D, $0018, $FFE0
                dc.w    $EC0D, $0018, $0000
                dc.w    $EC0D, $0018, $0020
                dc.w    $FC0D, $0020, $FFC0
                dc.w    $FC0D, $0020, $FFE0
                dc.w    $FC0D, $0020, $0000
                dc.w    $FC0D, $0020, $0020
                dc.w    $0C0D, $0028, $FFC0
                dc.w    $0C0D, $0030, $FFE0
                dc.w    $0C0D, $0030, $0000
                dc.w    $0C0D, $0028, $0020
                dc.w    $1C0D, $0010, $FFC0
                dc.w    $1C0D, $0028, $FFE0
                dc.w    $1C0D, $0028, $0000
                dc.w    $1C0D, $0810, $0020
Offset_0x016828:
                dc.w    $0020
                dc.w    $EC05, $0018, $FFC0
                dc.w    $EC05, $001C, $FFD0
                dc.w    $EC05, $0018, $FFE0
                dc.w    $EC05, $001C, $FFF0
                dc.w    $EC05, $0018, $0000
                dc.w    $EC05, $001C, $0010
                dc.w    $EC05, $0018, $0020
                dc.w    $EC05, $001C, $0030
                dc.w    $FC05, $0020, $FFC0
                dc.w    $FC05, $0024, $FFD0
                dc.w    $FC05, $0020, $FFE0
                dc.w    $FC05, $0024, $FFF0
                dc.w    $FC05, $0020, $0000
                dc.w    $FC05, $0024, $0010
                dc.w    $FC05, $0020, $0020
                dc.w    $FC05, $0024, $0030
                dc.w    $0C05, $000C, $FFC0
                dc.w    $0C05, $080C, $FFD0
                dc.w    $0C05, $0030, $FFE0
                dc.w    $0C05, $0034, $FFF0
                dc.w    $0C05, $0030, $0000
                dc.w    $0C05, $0034, $0010
                dc.w    $0C05, $000C, $0020
                dc.w    $0C05, $080C, $0030
                dc.w    $1C05, $0010, $FFC0
                dc.w    $1C05, $0014, $FFD0
                dc.w    $1C05, $000C, $FFE0
                dc.w    $1C05, $080C, $FFF0
                dc.w    $1C05, $000C, $0000
                dc.w    $1C05, $080C, $0010
                dc.w    $1C05, $0814, $0020
                dc.w    $1C05, $0010, $0030
Offset_0x0168EA:
                dc.w    $0020
                dc.w    $EC05, $001C, $0030
                dc.w    $EC05, $0018, $FFC0
                dc.w    $EC05, $001C, $FFD0
                dc.w    $EC05, $0018, $FFE0
                dc.w    $EC05, $001C, $FFF0
                dc.w    $EC05, $0018, $0000
                dc.w    $EC05, $001C, $0010
                dc.w    $EC05, $0018, $0020
                dc.w    $FC05, $0020, $FFC0
                dc.w    $FC05, $0024, $FFD0
                dc.w    $FC05, $0020, $FFE0
                dc.w    $FC05, $0024, $FFF0
                dc.w    $FC05, $0020, $0000
                dc.w    $FC05, $0024, $0010
                dc.w    $FC05, $0020, $0020
                dc.w    $FC05, $0024, $0030
                dc.w    $0C05, $000C, $FFC0
                dc.w    $0C05, $080C, $FFD0
                dc.w    $0C05, $0030, $FFE0
                dc.w    $0C05, $0034, $FFF0
                dc.w    $0C05, $0030, $0000
                dc.w    $0C05, $0034, $0010
                dc.w    $0C05, $000C, $0020
                dc.w    $0C05, $080C, $0030
                dc.w    $1C05, $0010, $FFC0
                dc.w    $1C05, $0014, $FFD0
                dc.w    $1C05, $000C, $FFE0
                dc.w    $1C05, $080C, $FFF0
                dc.w    $1C05, $000C, $0000
                dc.w    $1C05, $080C, $0010
                dc.w    $1C05, $0814, $0020
                dc.w    $1C05, $0010, $0030
Offset_0x0169AC:
                dc.w    $000C
                dc.w    $EC0D, $0018, $FFD0
                dc.w    $EC0D, $0018, $FFF0
                dc.w    $EC0D, $0018, $0010
                dc.w    $FC0D, $0020, $FFD0
                dc.w    $FC0D, $0020, $FFF0
                dc.w    $FC0D, $0020, $0010
                dc.w    $0C0D, $0028, $FFD0
                dc.w    $0C0D, $0030, $FFF0
                dc.w    $0C0D, $0028, $0010
                dc.w    $1C0D, $0010, $FFD0
                dc.w    $1C0D, $0028, $FFF0
                dc.w    $1C0D, $0810, $0010
Offset_0x0169F6:
                dc.w    $0018
                dc.w    $EC05, $0018, $FFD0
                dc.w    $EC05, $001C, $FFE0
                dc.w    $EC05, $0018, $FFF0
                dc.w    $EC05, $001C, $0000
                dc.w    $EC05, $0018, $0010
                dc.w    $EC05, $001C, $0020
                dc.w    $FC05, $0020, $FFD0
                dc.w    $FC05, $0024, $FFE0
                dc.w    $FC05, $0020, $FFF0
                dc.w    $FC05, $0024, $0000
                dc.w    $FC05, $0020, $0010
                dc.w    $FC05, $0024, $0020
                dc.w    $0C05, $000C, $FFD0
                dc.w    $0C05, $080C, $FFE0
                dc.w    $0C05, $0030, $FFF0
                dc.w    $0C05, $0034, $0000
                dc.w    $0C05, $000C, $0010
                dc.w    $0C05, $080C, $0020
                dc.w    $1C05, $0010, $FFD0
                dc.w    $1C05, $0014, $FFE0
                dc.w    $1C05, $000C, $FFF0
                dc.w    $1C05, $080C, $0000
                dc.w    $1C05, $0814, $0010
                dc.w    $1C05, $0010, $0020
Offset_0x016A88:
                dc.w    $0018
                dc.w    $EC05, $001C, $0020
                dc.w    $EC05, $0018, $FFD0
                dc.w    $EC05, $001C, $FFE0
                dc.w    $EC05, $0018, $FFF0
                dc.w    $EC05, $001C, $0000
                dc.w    $EC05, $0018, $0010
                dc.w    $FC05, $0020, $FFD0
                dc.w    $FC05, $0024, $FFE0
                dc.w    $FC05, $0020, $FFF0
                dc.w    $FC05, $0024, $0000
                dc.w    $FC05, $0020, $0010
                dc.w    $FC05, $0024, $0020
                dc.w    $0C05, $000C, $FFD0
                dc.w    $0C05, $080C, $FFE0
                dc.w    $0C05, $0030, $FFF0
                dc.w    $0C05, $0034, $0000
                dc.w    $0C05, $000C, $0010
                dc.w    $0C05, $080C, $0020
                dc.w    $1C05, $0010, $FFD0
                dc.w    $1C05, $0014, $FFE0
                dc.w    $1C05, $000C, $FFF0
                dc.w    $1C05, $080C, $0000
                dc.w    $1C05, $0814, $0010
                dc.w    $1C05, $0010, $0020
Offset_0x016B1A:
                dc.w    $0010
                dc.w    $EC0D, $0018, $FFC0
                dc.w    $EC0D, $0018, $FFE0
                dc.w    $EC0D, $0018, $0000
                dc.w    $EC0D, $0018, $0020
                dc.w    $FC0D, $004E, $FFC0
                dc.w    $FC0D, $004E, $FFE0
                dc.w    $FC0D, $004E, $0000
                dc.w    $FC0D, $004E, $0020
                dc.w    $0C0D, $0056, $FFC0
                dc.w    $0C0D, $0056, $FFE0
                dc.w    $0C0D, $0056, $0000
                dc.w    $0C0D, $0056, $0020
                dc.w    $1C0D, $005E, $FFC0
                dc.w    $1C0D, $005E, $FFE0
                dc.w    $1C0D, $005E, $0000
                dc.w    $1C0D, $005E, $0020
Offset_0x016B7C:
                dc.w    $0020
                dc.w    $EC05, $0018, $FFC0
                dc.w    $EC05, $001C, $FFD0
                dc.w    $EC05, $0018, $FFE0
                dc.w    $EC05, $001C, $FFF0
                dc.w    $EC05, $0018, $0000
                dc.w    $EC05, $001C, $0010
                dc.w    $EC05, $0018, $0020
                dc.w    $EC05, $001C, $0030
                dc.w    $FC05, $004E, $FFC0
                dc.w    $FC05, $0052, $FFD0
                dc.w    $FC05, $004E, $FFE0
                dc.w    $FC05, $0052, $FFF0
                dc.w    $FC05, $004E, $0000
                dc.w    $FC05, $0052, $0010
                dc.w    $FC05, $004E, $0020
                dc.w    $FC05, $0052, $0030
                dc.w    $0C05, $0056, $FFC0
                dc.w    $0C05, $005A, $FFD0
                dc.w    $0C05, $0056, $FFE0
                dc.w    $0C05, $005A, $FFF0
                dc.w    $0C05, $0056, $0000
                dc.w    $0C05, $005A, $0010
                dc.w    $0C05, $0056, $0020
                dc.w    $0C05, $005A, $0030
                dc.w    $1C05, $005A, $FFC0
                dc.w    $1C05, $0056, $FFD0
                dc.w    $1C05, $005A, $FFE0
                dc.w    $1C05, $0056, $FFF0
                dc.w    $1C05, $005A, $0000
                dc.w    $1C05, $0056, $0010
                dc.w    $1C05, $005A, $0020
                dc.w    $1C05, $0056, $0030
Offset_0x016C3E:
                dc.w    $0020
                dc.w    $EC05, $001C, $0030
                dc.w    $EC05, $0018, $FFC0
                dc.w    $EC05, $001C, $FFD0
                dc.w    $EC05, $0018, $FFE0
                dc.w    $EC05, $001C, $FFF0
                dc.w    $EC05, $0018, $0000
                dc.w    $EC05, $001C, $0010
                dc.w    $EC05, $0018, $0020
                dc.w    $FC05, $004E, $FFC0
                dc.w    $FC05, $0052, $FFD0
                dc.w    $FC05, $004E, $FFE0
                dc.w    $FC05, $0052, $FFF0
                dc.w    $FC05, $004E, $0000
                dc.w    $FC05, $0052, $0010
                dc.w    $FC05, $004E, $0020
                dc.w    $FC05, $0052, $0030
                dc.w    $0C05, $0056, $FFC0
                dc.w    $0C05, $005A, $FFD0
                dc.w    $0C05, $0056, $FFE0
                dc.w    $0C05, $005A, $FFF0
                dc.w    $0C05, $0056, $0000
                dc.w    $0C05, $005A, $0010
                dc.w    $0C05, $0056, $0020
                dc.w    $0C05, $005A, $0030
                dc.w    $1C05, $005A, $FFC0
                dc.w    $1C05, $0056, $FFD0
                dc.w    $1C05, $005A, $FFE0
                dc.w    $1C05, $0056, $FFF0
                dc.w    $1C05, $005A, $0000
                dc.w    $1C05, $0056, $0010
                dc.w    $1C05, $005A, $0020
                dc.w    $1C05, $0056, $0030  
;-------------------------------------------------------------------------------
Iz_Collapsing_Platform_Mappings:                               ; Offset_0x016D00  
                dc.w    Offset_0x016D0C-Iz_Collapsing_Platform_Mappings
                dc.w    Offset_0x016D6E-Iz_Collapsing_Platform_Mappings
                dc.w    Offset_0x016D6E-Iz_Collapsing_Platform_Mappings
                dc.w    Offset_0x016E30-Iz_Collapsing_Platform_Mappings
                dc.w    Offset_0x016EB6-Iz_Collapsing_Platform_Mappings
                dc.w    Offset_0x016FC0-Iz_Collapsing_Platform_Mappings
Offset_0x016D0C:
                dc.w    $0010
                dc.w    $D00D, $0000, $FFD0
                dc.w    $D00D, $0008, $FFF0
                dc.w    $D00D, $0010, $0010
                dc.w    $E00D, $0018, $FFD0
                dc.w    $E00D, $0018, $FFF0
                dc.w    $E00D, $0020, $0010
                dc.w    $F00D, $0028, $FFD0
                dc.w    $F00D, $1828, $FFF0
                dc.w    $F00D, $0030, $0010
                dc.w    $000D, $0828, $FFD0
                dc.w    $000D, $0028, $FFF0
                dc.w    $000D, $0030, $0010
                dc.w    $100D, $0038, $FFD0
                dc.w    $100D, $0040, $FFF0
                dc.w    $100C, $0048, $0010
                dc.w    $200C, $0048, $FFD0
Offset_0x016D6E:
                dc.w    $0020
                dc.w    $D005, $0000, $FFD0
                dc.w    $D005, $0004, $FFE0
                dc.w    $D005, $0008, $FFF0
                dc.w    $D005, $000C, $0000
                dc.w    $D005, $0010, $0010
                dc.w    $D005, $0014, $0020
                dc.w    $E005, $0018, $FFD0
                dc.w    $E005, $001C, $FFE0
                dc.w    $E005, $0018, $FFF0
                dc.w    $E005, $001C, $0000
                dc.w    $E005, $0020, $0010
                dc.w    $E005, $0024, $0020
                dc.w    $F005, $0028, $FFD0
                dc.w    $F005, $002C, $FFE0
                dc.w    $F005, $182C, $FFF0
                dc.w    $F005, $1828, $0000
                dc.w    $F005, $0030, $0010
                dc.w    $F005, $0034, $0020
                dc.w    $0005, $082C, $FFD0
                dc.w    $0005, $0828, $FFE0
                dc.w    $0005, $0028, $FFF0
                dc.w    $0005, $002C, $0000
                dc.w    $0005, $0030, $0010
                dc.w    $0005, $0034, $0020
                dc.w    $1005, $0038, $FFD0
                dc.w    $1005, $003C, $FFE0
                dc.w    $1005, $0040, $FFF0
                dc.w    $1005, $0044, $0000
                dc.w    $1004, $0048, $0010
                dc.w    $1004, $004A, $0020
                dc.w    $2004, $0048, $FFD0
                dc.w    $2004, $004A, $FFE0
Offset_0x016E30:
                dc.w    $0016
                dc.w    $EF0D, $0000, $FFB0
                dc.w    $EF0D, $0008, $FFD0
                dc.w    $EF0D, $0808, $FFF0
                dc.w    $EF0D, $0800, $0010
                dc.w    $EF0D, $0000, $0030
                dc.w    $FF0D, $0018, $FFB0
                dc.w    $FF0D, $0018, $FFD0
                dc.w    $FF0D, $0018, $FFF0
                dc.w    $FF0D, $0018, $0010
                dc.w    $FF0D, $0818, $0030
                dc.w    $0F0D, $0028, $FFB0
                dc.w    $0F0D, $0028, $FFD0
                dc.w    $0F0D, $0828, $FFF0
                dc.w    $0F0D, $0828, $0010
                dc.w    $0F0D, $0028, $0030
                dc.w    $1F0D, $0840, $FFB0
                dc.w    $1F0D, $0838, $FFD0
                dc.w    $1F0D, $0038, $FFF0
                dc.w    $1F0D, $0040, $0010
                dc.w    $1F0D, $0840, $0030
                dc.w    $2F0C, $0848, $FFD0
                dc.w    $2F0C, $0048, $FFF0
Offset_0x016EB6:
                dc.w    $002C
                dc.w    $EF05, $0000, $FFB0
                dc.w    $EF05, $0004, $FFC0
                dc.w    $EF05, $0008, $FFD0
                dc.w    $EF05, $000C, $FFE0
                dc.w    $EF05, $080C, $FFF0
                dc.w    $EF05, $0808, $0000
                dc.w    $EF05, $0804, $0010
                dc.w    $EF05, $0800, $0020
                dc.w    $EF05, $0000, $0030
                dc.w    $EF05, $0004, $0040
                dc.w    $FF05, $0018, $FFB0
                dc.w    $FF05, $001C, $FFC0
                dc.w    $FF05, $0018, $FFD0
                dc.w    $FF05, $001C, $FFE0
                dc.w    $FF05, $0018, $FFF0
                dc.w    $FF05, $001C, $0000
                dc.w    $FF05, $0018, $0010
                dc.w    $FF05, $001C, $0020
                dc.w    $FF05, $081C, $0030
                dc.w    $FF05, $0818, $0040
                dc.w    $0F05, $0028, $FFB0
                dc.w    $0F05, $002C, $FFC0
                dc.w    $0F05, $0028, $FFD0
                dc.w    $0F05, $002C, $FFE0
                dc.w    $0F05, $082C, $FFF0
                dc.w    $0F05, $0828, $0000
                dc.w    $0F05, $082C, $0010
                dc.w    $0F05, $0828, $0020
                dc.w    $0F05, $0028, $0030
                dc.w    $0F05, $002C, $0040
                dc.w    $1F05, $0844, $FFB0
                dc.w    $1F05, $0840, $FFC0
                dc.w    $1F05, $083C, $FFD0
                dc.w    $1F05, $0838, $FFE0
                dc.w    $1F05, $0038, $FFF0
                dc.w    $1F05, $003C, $0000
                dc.w    $1F05, $0040, $0010
                dc.w    $1F05, $0044, $0020
                dc.w    $1F05, $0844, $0030
                dc.w    $1F05, $0840, $0040
                dc.w    $2F04, $084A, $FFD0
                dc.w    $2F04, $0848, $FFE0
                dc.w    $2F04, $0048, $FFF0
                dc.w    $2F04, $004A, $0000
Offset_0x016FC0:
                dc.w    $002C
                dc.w    $EF05, $0004, $0040
                dc.w    $EF05, $0000, $FFB0
                dc.w    $EF05, $0004, $FFC0
                dc.w    $EF05, $0008, $FFD0
                dc.w    $EF05, $000C, $FFE0
                dc.w    $EF05, $080C, $FFF0
                dc.w    $EF05, $0808, $0000
                dc.w    $EF05, $0804, $0010
                dc.w    $EF05, $0800, $0020
                dc.w    $EF05, $0000, $0030
                dc.w    $FF05, $0018, $FFB0
                dc.w    $FF05, $001C, $FFC0
                dc.w    $FF05, $0018, $FFD0
                dc.w    $FF05, $001C, $FFE0
                dc.w    $FF05, $0018, $FFF0
                dc.w    $FF05, $001C, $0000
                dc.w    $FF05, $0018, $0010
                dc.w    $FF05, $001C, $0020
                dc.w    $FF05, $081C, $0030
                dc.w    $FF05, $0818, $0040
                dc.w    $0F05, $0028, $FFB0
                dc.w    $0F05, $002C, $FFC0
                dc.w    $0F05, $0028, $FFD0
                dc.w    $0F05, $002C, $FFE0
                dc.w    $0F05, $082C, $FFF0
                dc.w    $0F05, $0828, $0000
                dc.w    $0F05, $082C, $0010
                dc.w    $0F05, $0828, $0020
                dc.w    $0F05, $0028, $0030
                dc.w    $0F05, $002C, $0040
                dc.w    $1F05, $0844, $FFB0
                dc.w    $1F05, $0840, $FFC0
                dc.w    $1F05, $083C, $FFD0
                dc.w    $1F05, $0838, $FFE0
                dc.w    $1F05, $0038, $FFF0
                dc.w    $1F05, $003C, $0000
                dc.w    $1F05, $0040, $0010
                dc.w    $1F05, $0044, $0020
                dc.w    $1F05, $0844, $0030
                dc.w    $1F05, $0840, $0040
                dc.w    $2F04, $084A, $FFD0
                dc.w    $2F04, $0848, $FFE0
                dc.w    $2F04, $0048, $FFF0
                dc.w    $2F04, $004A, $0000                                                                                                                                                                                                                                                                                                              
;===============================================================================
; Objeto 0x0F - Plataformas que desmoronam ao serem tocadas
; <<<- 
;===============================================================================