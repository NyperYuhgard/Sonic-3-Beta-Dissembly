;===============================================================================
; Objeto 0x08 - Espinhos
; ->>>
;===============================================================================      
Spikes_Conf:                                                   ; Offset_0x01A432
                dc.b    $10, $10  ; Largura / Altura do espinho
                dc.b    $20, $10
                dc.b    $30, $10
                dc.b    $40, $10
                dc.b    $10, $10
                dc.b    $10, $20
                dc.b    $10, $30
                dc.b    $10, $40
;-------------------------------------------------------------------------------                
Obj_0x08_Spikes:                                               ; Offset_0x01A442
                ori.b   #$04, Obj_Flags(A0)                              ; $0004
                move.w  #$0200, Obj_Priority(A0)                         ; $0008
                move.b  Obj_Subtype(A0), D0                              ; $002C
                andi.w  #$00F0, D0
                lsr.w   #$03, D0
                tst.w   (Two_Player_Flag).w                          ; $FFFFFFD8
                bne.s   Obj_0x08_Spikes_2P                     ; Offset_0x01A4D0
                lea     Spikes_Conf(PC, D0), A1                ; Offset_0x01A432
                move.b  (A1)+, Obj_Width(A0)                             ; $0007
                move.b  (A1)+, Obj_Height(A0)                            ; $0006
                move.l  #Offset_0x01A52C, (A0)
                move.l  #Spikes_Mappings, Obj_Map(A0)   ; Offset_0x01A88C, $000C
                move.w  #$049C, Obj_Art_VRAM(A0)                         ; $000A
                lsr.w   #$01, D0
                move.b  D0, Obj_Map_Id(A0)                               ; $0022
                cmpi.b  #$04, D0
                bcs.s   Offset_0x01A496
                move.l  #Offset_0x01A57E, (A0)
                move.w  #$0494, Obj_Art_VRAM(A0)                         ; $000A
Offset_0x01A496:
                btst    #$01, Obj_Status(A0)                             ; $002A
                beq.s   Offset_0x01A4A4
                move.l  #Offset_0x01A5DA, (A0)
Offset_0x01A4A4:
                move.w  Obj_X(A0), Obj_Control_Var_00(A0)         ; $0010, $0030
                move.w  Obj_Y(A0), Obj_Control_Var_02(A0)         ; $0014, $0032
                move.b  Obj_Subtype(A0), D0                              ; $002C
                andi.b  #$0F, D0
                add.b   D0, D0
                move.b  D0, Obj_Subtype(A0)                              ; $002C
                rts      
;-------------------------------------------------------------------------------
Spikes_Conf_2P:                                                ; Offset_0x01A4C0
                dc.b    $0C, $0C  ; Largura / Altura do espinho
                dc.b    $18, $0C
                dc.b    $24, $0C
                dc.b    $30, $0C
                dc.b    $0C, $0C
                dc.b    $0C, $18
                dc.b    $0C, $24
                dc.b    $0C, $30     
;-------------------------------------------------------------------------------
Obj_0x08_Spikes_2P:                                            ; Offset_0x01A4D0
                lea     Spikes_Conf_2P(PC, D0), A1             ; Offset_0x01A4C0
                move.b  (A1)+, Obj_Width(A0)                             ; $0007
                move.b  (A1)+, Obj_Height(A0)                            ; $0006
                move.l  #Offset_0x01A62A, (A0)
                move.l  #Spikes_Mappings_2P, Obj_Map(A0) ; Offset_0x01A99C, $000C
                move.w  #$0391, Obj_Art_VRAM(A0)                         ; $000A
                lsr.w   #$01, D0
                move.b  D0, Obj_Map_Id(A0)                               ; $0022
                cmpi.b  #$04, D0
                bcs.s   Offset_0x01A502
                move.l  #Offset_0x01A678, (A0)
Offset_0x01A502:
                btst    #$01, Obj_Status(A0)                             ; $002A
                beq.s   Offset_0x01A510
                move.l  #Offset_0x01A6D0, (A0)
Offset_0x01A510:
                move.w  Obj_X(A0), Obj_Control_Var_00(A0)         ; $0010, $0030
                move.w  Obj_Y(A0), Obj_Control_Var_02(A0)         ; $0014, $0032
                move.b  Obj_Subtype(A0), D0                              ; $002C
                andi.b  #$0F, D0
                add.b   D0, D0
                move.b  D0, Obj_Subtype(A0)                              ; $002C
                rts  
;-------------------------------------------------------------------------------
Offset_0x01A52C:
                bsr     Offset_0x01A752
                moveq   #$00, D1
                move.b  Obj_Width(A0), D1                                ; $0007
                addi.w  #$000B, D1
                moveq   #$00, D2
                move.b  Obj_Height(A0), D2                               ; $0006
                move.w  D2, D3
                addq.w  #$01, D3
                move.w  Obj_X(A0), D4                                    ; $0010
                bsr     Solid_Object                           ; Offset_0x013556
                move.b  Obj_Status(A0), D6                               ; $002A
                andi.b  #$18, D6
                beq.s   Offset_0x01A574
                move.b  D6, D0
                andi.b  #$08, D0
                beq.s   Offset_0x01A566
                lea     (Obj_Player_One).w, A1                       ; $FFFFB000
                bsr     Hurt_Player_A1                         ; Offset_0x01A71C
Offset_0x01A566:
                andi.b  #$10, D6
                beq.s   Offset_0x01A574
                lea     (Obj_Player_Two).w, A1                       ; $FFFFB04A
                bsr     Hurt_Player_A1                         ; Offset_0x01A71C
Offset_0x01A574:
                move.w  Obj_Control_Var_00(A0), D0                       ; $0030
                jmp     (MarkObjGone_2)                        ; Offset_0x011B1A   
;-------------------------------------------------------------------------------
Offset_0x01A57E:
                bsr     Offset_0x01A752
                moveq   #$00, D1
                move.b  Obj_Width(A0), D1                                ; $0007
                addi.w  #$000B, D1
                moveq   #$00, D2
                move.b  Obj_Height(A0), D2                               ; $0006
                move.w  D2, D3
                addq.w  #$01, D3
                move.w  Obj_X(A0), D4                                    ; $0010
                bsr     Solid_Object                           ; Offset_0x013556
                swap.w  D6
                andi.w  #$0003, D6
                beq.s   Offset_0x01A5D0
                move.b  D6, D0
                andi.b  #$01, D0
                beq.s   Offset_0x01A5BC
                lea     (Obj_Player_One).w, A1                       ; $FFFFB000
                bsr     Hurt_Player_A1                         ; Offset_0x01A71C
                bclr    #$05, Obj_Status(A0)                             ; $002A
Offset_0x01A5BC:
                andi.b  #$02, D6
                beq.s   Offset_0x01A5D0
                lea     (Obj_Player_Two).w, A1                       ; $FFFFB04A
                bsr     Hurt_Player_A1                         ; Offset_0x01A71C
                bclr    #$06, Obj_Status(A0)                             ; $002A
Offset_0x01A5D0:
                move.w  Obj_Control_Var_00(A0), D0                       ; $0030
                jmp     (MarkObjGone_2)                        ; Offset_0x011B1A  
;-------------------------------------------------------------------------------
Offset_0x01A5DA:
                bsr     Offset_0x01A752
                moveq   #$00, D1
                move.b  Obj_Width(A0), D1                                ; $0007
                addi.w  #$000B, D1
                moveq   #$00, D2
                move.b  Obj_Height(A0), D2                               ; $0006
                move.w  D2, D3
                addq.w  #$01, D3
                move.w  Obj_X(A0), D4                                    ; $0010
                bsr     Solid_Object                           ; Offset_0x013556
                swap.w  D6
                andi.w  #$000C, D6
                beq.s   Offset_0x01A620
                move.b  D6, D0
                andi.b  #$04, D0
                beq.s   Offset_0x01A612
                lea     (Obj_Player_One).w, A1                       ; $FFFFB000
                bsr     Hurt_Player_A1                         ; Offset_0x01A71C
Offset_0x01A612:
                andi.b  #$08, D6
                beq.s   Offset_0x01A620
                lea     (Obj_Player_Two).w, A1                       ; $FFFFB04A
                bsr     Hurt_Player_A1                         ; Offset_0x01A71C
Offset_0x01A620:
                move.w  Obj_Control_Var_00(A0), D0                       ; $0030
                jmp     (MarkObjGone_2)                        ; Offset_0x011B1A   
;-------------------------------------------------------------------------------
Offset_0x01A62A:
                bsr     Offset_0x01A7F0
                moveq   #$00, D1
                move.b  Obj_Width(A0), D1                                ; $0007
                addi.w  #$0007, D1
                moveq   #$00, D2
                move.b  Obj_Height(A0), D2                               ; $0006
                move.w  D2, D3
                addq.w  #$01, D3
                move.w  Obj_X(A0), D4                                    ; $0010
                bsr     Solid_Object                           ; Offset_0x013556
                move.b  Obj_Status(A0), D6                               ; $002A
                andi.b  #$18, D6
                beq.s   Offset_0x01A672
                move.b  D6, D0
                andi.b  #$08, D0
                beq.s   Offset_0x01A664
                lea     (Obj_Player_One).w, A1                       ; $FFFFB000
                bsr     Hurt_Player_A1                         ; Offset_0x01A71C
Offset_0x01A664:
                andi.b  #$10, D6
                beq.s   Offset_0x01A672
                lea     (Obj_Player_Two).w, A1                       ; $FFFFB04A
                bsr     Hurt_Player_A1                         ; Offset_0x01A71C
Offset_0x01A672:
                jmp     (DisplaySprite)                        ; Offset_0x011148
;-------------------------------------------------------------------------------
Offset_0x01A678:
                bsr     Offset_0x01A7F0
                moveq   #$00, D1
                move.b  Obj_Width(A0), D1                                ; $0007
                addi.w  #$0007, D1
                moveq   #$00, D2
                move.b  Obj_Height(A0), D2                               ; $0006
                move.w  D2, D3
                addq.w  #$01, D3
                move.w  Obj_X(A0), D4                                    ; $0010
                bsr     Solid_Object                           ; Offset_0x013556
                swap.w  D6
                andi.w  #$0003, D6
                beq.s   Offset_0x01A6CA
                move.b  D6, D0
                andi.b  #$01, D0
                beq.s   Offset_0x01A6B6
                lea     (Obj_Player_One).w, A1                       ; $FFFFB000
                bsr     Hurt_Player_A1                         ; Offset_0x01A71C
                bclr    #$05, Obj_Status(A0)                             ; $002A
Offset_0x01A6B6:
                andi.b  #$02, D6
                beq.s   Offset_0x01A6CA
                lea     (Obj_Player_Two).w, A1                       ; $FFFFB04A
                bsr     Hurt_Player_A1                         ; Offset_0x01A71C
                bclr    #$06, Obj_Status(A0)                             ; $002A
Offset_0x01A6CA:
                jmp     (DisplaySprite)                        ; Offset_0x011148   
;-------------------------------------------------------------------------------
Offset_0x01A6D0:
                bsr     Offset_0x01A7F0
                moveq   #$00, D1
                move.b  Obj_Width(A0), D1                                ; $0007
                addi.w  #$0007, D1
                moveq   #$00, D2
                move.b  Obj_Height(A0), D2                               ; $0006
                move.w  D2, D3
                addq.w  #$01, D3
                move.w  Obj_X(A0), D4                                    ; $0010
                bsr     Solid_Object                           ; Offset_0x013556
                swap.w  D6
                andi.w  #$000C, D6
                beq.s   Offset_0x01A716
                move.b  D6, D0
                andi.b  #$04, D0
                beq.s   Offset_0x01A708
                lea     (Obj_Player_One).w, A1                       ; $FFFFB000
                bsr     Hurt_Player_A1                         ; Offset_0x01A71C
Offset_0x01A708:
                andi.b  #$08, D6
                beq.s   Offset_0x01A716
                lea     (Obj_Player_Two).w, A1                       ; $FFFFB04A
                bsr     Hurt_Player_A1                         ; Offset_0x01A71C
Offset_0x01A716:
                jmp     (DisplaySprite)                        ; Offset_0x011148
;=============================================================================== 
; Rotina para causar danos ao Sonic / Miles
; ->>>                        
;===============================================================================   
Hurt_Player_A1:                                                ; Offset_0x01A71C
                btst    #Invincibility_Type, Obj_Player_Status(A1)  ; $01, $002F
                bne.s   Offset_0x01A750
                tst.b   Obj_P_Invunerblt_Time(A1)                        ; $0034
                bne.s   Offset_0x01A750
                cmpi.b  #$04, Obj_Routine(A1)                            ; $0005
                bcc.s   Offset_0x01A750
                move.l  Obj_Y(A1), D3                                    ; $0014
                move.w  Obj_Speed_Y(A1), D0                              ; $001A
                ext.l   D0
                asl.l   #$08, D0
                sub.l   D0, D3
                move.l  D3, Obj_Y(A1)                                    ; $0014
                move.l  A0, A2
                move.l  A1, A0
                jsr     (Hurt_Player)                          ; Offset_0x00A3FA
                move.l  A2, A0
Offset_0x01A750:
                rts
;=============================================================================== 
; Rotina para causar danos ao Sonic / Miles
; <<<-                        
;===============================================================================                 
Offset_0x01A752:
                moveq   #$00, D0
                move.b  Obj_Subtype(A0), D0                              ; $002C
                move.w  Offset_0x01A760(PC, D0), D1
                jmp     Offset_0x01A760(PC, D1)
;-------------------------------------------------------------------------------
Offset_0x01A760:
                dc.w    Offset_0x01A766-Offset_0x01A760
                dc.w    Offset_0x01A768-Offset_0x01A760
                dc.w    Offset_0x01A77C-Offset_0x01A760   
;-------------------------------------------------------------------------------
Offset_0x01A766:
                rts
;-------------------------------------------------------------------------------
Offset_0x01A768:
                bsr     Offset_0x01A790
                moveq   #$00, D0
                move.b  Obj_Control_Var_04(A0), D0                       ; $0034
                add.w   Obj_Control_Var_02(A0), D0                       ; $0032
                move.w  D0, Obj_Y(A0)                                    ; $0014
                rts
;-------------------------------------------------------------------------------
Offset_0x01A77C:
                bsr     Offset_0x01A790
                moveq   #$00, D0
                move.b  Obj_Control_Var_04(A0), D0                       ; $0034
                add.w   Obj_Control_Var_00(A0), D0                       ; $0030
                move.w  D0, Obj_X(A0)                                    ; $0010
                rts
Offset_0x01A790:
                tst.w   Obj_Control_Var_08(A0)                           ; $0038
                beq.s   Offset_0x01A7AC
                subq.w  #$01, Obj_Control_Var_08(A0)                     ; $0038
                bne.s   Offset_0x01A7EE
                tst.b   Obj_Flags(A0)                                    ; $0004
                bpl.s   Offset_0x01A7EE
                moveq   #Spike_Move_Sfx, D0                                ; $58
                jsr     (Play_Music)                           ; Offset_0x001176
                bra.s   Offset_0x01A7EE
Offset_0x01A7AC:
                tst.w   Obj_Control_Var_06(A0)                           ; $0036
                beq.s   Offset_0x01A7CE
                subi.w  #$0800, Obj_Control_Var_04(A0)                   ; $0034
                bcc.s   Offset_0x01A7EE
                move.w  #$0000, Obj_Control_Var_04(A0)                   ; $0034
                move.w  #$0000, Obj_Control_Var_06(A0)                   ; $0036
                move.w  #$003C, Obj_Control_Var_08(A0)                   ; $0038
                bra.s   Offset_0x01A7EE
Offset_0x01A7CE:
                addi.w  #$0800, Obj_Control_Var_04(A0)                   ; $0034
                cmpi.w  #$2000, Obj_Control_Var_04(A0)                   ; $0034
                bcs.s   Offset_0x01A7EE
                move.w  #$2000, Obj_Control_Var_04(A0)                   ; $0034
                move.w  #$0001, Obj_Control_Var_06(A0)                   ; $0036
                move.w  #$003C, Obj_Control_Var_08(A0)                   ; $0038
Offset_0x01A7EE:
                rts
;-------------------------------------------------------------------------------                
Offset_0x01A7F0:
                moveq   #$00, D0
                move.b  Obj_Subtype(A0), D0                              ; $002C
                move.w  Offset_0x01A7FE(PC, D0), D1
                jmp     Offset_0x01A7FE(PC, D1)   
;-------------------------------------------------------------------------------
Offset_0x01A7FE:
                dc.w    Offset_0x01A766-Offset_0x01A7FE
                dc.w    Offset_0x01A804-Offset_0x01A7FE
                dc.w    Offset_0x01A818-Offset_0x01A7FE
;-------------------------------------------------------------------------------
Offset_0x01A804:
                bsr     Offset_0x01A82C
                moveq   #$00, D0
                move.b  Obj_Control_Var_04(A0), D0                       ; $0034
                add.w   Obj_Control_Var_02(A0), D0                       ; $0032
                move.w  D0, Obj_Y(A0)                                    ; $0014
                rts
;-------------------------------------------------------------------------------                
Offset_0x01A818:
                bsr     Offset_0x01A82C
                moveq   #$00, D0
                move.b  Obj_Control_Var_04(A0), D0                       ; $0034
                add.w   Obj_Control_Var_00(A0), D0                       ; $0030
                move.w  D0, Obj_X(A0)                                    ; $0010
                rts
Offset_0x01A82C:
                tst.w   Obj_Control_Var_08(A0)                           ; $0038
                beq.s   Offset_0x01A848
                subq.w  #$01, Obj_Control_Var_08(A0)                     ; $0038
                bne.s   Offset_0x01A88A
                tst.b   Obj_Flags(A0)                                    ; $0004
                bpl.s   Offset_0x01A88A
                moveq   #Spike_Move_Sfx, D0                                ; $58
                jsr     (Play_Music)                           ; Offset_0x001176
                bra.s   Offset_0x01A88A
Offset_0x01A848:
                tst.w   Obj_Control_Var_06(A0)                           ; $0036
                beq.s   Offset_0x01A86A
                subi.w  #$0800, Obj_Control_Var_04(A0)                   ; $0034
                bcc.s   Offset_0x01A88A
                move.w  #$0000, Obj_Control_Var_04(A0)                   ; $0034
                move.w  #$0000, Obj_Control_Var_06(A0)                   ; $0036
                move.w  #$003C, Obj_Control_Var_08(A0)                   ; $0038
                bra.s   Offset_0x01A88A
Offset_0x01A86A:
                addi.w  #$0800, Obj_Control_Var_04(A0)                   ; $0034
                cmpi.w  #$1800, Obj_Control_Var_04(A0)                   ; $0034
                bcs.s   Offset_0x01A88A
                move.w  #$1800, Obj_Control_Var_04(A0)                   ; $0034
                move.w  #$0001, Obj_Control_Var_06(A0)                   ; $0036
                move.w  #$003C, Obj_Control_Var_08(A0)                   ; $0038
Offset_0x01A88A:
                rts  
;------------------------------------------------------------------------------- 
Spikes_Mappings:                                               ; Offset_0x01A88C
                dc.w    Offset_0x01A89C-Spikes_Mappings
                dc.w    Offset_0x01A8AA-Spikes_Mappings
                dc.w    Offset_0x01A8C4-Spikes_Mappings
                dc.w    Offset_0x01A8EA-Spikes_Mappings
                dc.w    Offset_0x01A91C-Spikes_Mappings
                dc.w    Offset_0x01A92A-Spikes_Mappings
                dc.w    Offset_0x01A944-Spikes_Mappings
                dc.w    Offset_0x01A96A-Spikes_Mappings
Offset_0x01A89C:
                dc.w    $0002
                dc.w    $F007, $0000, $FFF0
                dc.w    $F007, $0000, $0000
Offset_0x01A8AA:
                dc.w    $0004
                dc.w    $F007, $0000, $FFE0
                dc.w    $F007, $0000, $FFF0
                dc.w    $F007, $0000, $0000
                dc.w    $F007, $0000, $0010
Offset_0x01A8C4:
                dc.w    $0006
                dc.w    $F007, $0000, $FFD0
                dc.w    $F007, $0000, $FFE0
                dc.w    $F007, $0000, $FFF0
                dc.w    $F007, $0000, $0000
                dc.w    $F007, $0000, $0010
                dc.w    $F007, $0000, $0020
Offset_0x01A8EA:
                dc.w    $0008
                dc.w    $F007, $0000, $FFC0
                dc.w    $F007, $0000, $FFD0
                dc.w    $F007, $0000, $FFE0
                dc.w    $F007, $0000, $FFF0
                dc.w    $F007, $0000, $0000
                dc.w    $F007, $0000, $0010
                dc.w    $F007, $0000, $0020
                dc.w    $F007, $0000, $0030
Offset_0x01A91C:
                dc.w    $0002
                dc.w    $F00D, $0800, $FFF0
                dc.w    $000D, $0800, $FFF0
Offset_0x01A92A:
                dc.w    $0004
                dc.w    $E00D, $0800, $FFF0
                dc.w    $F00D, $0800, $FFF0
                dc.w    $000D, $0800, $FFF0
                dc.w    $100D, $0800, $FFF0
Offset_0x01A944:
                dc.w    $0006
                dc.w    $D00D, $0800, $FFF0
                dc.w    $E00D, $0800, $FFF0
                dc.w    $F00D, $0800, $FFF0
                dc.w    $000D, $0800, $FFF0
                dc.w    $100D, $0800, $FFF0
                dc.w    $200D, $0800, $FFF0
Offset_0x01A96A:
                dc.w    $0008
                dc.w    $C00D, $0800, $FFF0
                dc.w    $D00D, $0800, $FFF0
                dc.w    $E00D, $0800, $FFF0
                dc.w    $F00D, $0800, $FFF0
                dc.w    $000D, $0800, $FFF0
                dc.w    $100D, $0800, $FFF0
                dc.w    $200D, $0800, $FFF0
                dc.w    $300D, $0800, $FFF0 
;-------------------------------------------------------------------------------  
Spikes_Mappings_2P:                                            ; Offset_0x01A99C
                dc.w    Offset_0x01A9AC-Spikes_Mappings_2P
                dc.w    Offset_0x01A9B4-Spikes_Mappings_2P
                dc.w    Offset_0x01A9C2-Spikes_Mappings_2P
                dc.w    Offset_0x01A9D6-Spikes_Mappings_2P
                dc.w    Offset_0x01A9F0-Spikes_Mappings_2P
                dc.w    Offset_0x01A9F8-Spikes_Mappings_2P
                dc.w    Offset_0x01AA06-Spikes_Mappings_2P
                dc.w    Offset_0x01AA1A-Spikes_Mappings_2P
Offset_0x01A9AC:
                dc.w    $0001
                dc.w    $F40A, $0013, $FFF4
Offset_0x01A9B4:
                dc.w    $0002
                dc.w    $F40A, $0013, $FFE8
                dc.w    $F40A, $0013, $0000
Offset_0x01A9C2:
                dc.w    $0003
                dc.w    $F40A, $0013, $FFDC
                dc.w    $F40A, $0013, $FFF4
                dc.w    $F40A, $0013, $000C
Offset_0x01A9D6:
                dc.w    $0004
                dc.w    $F40A, $0013, $FFD0
                dc.w    $F40A, $0013, $FFE8
                dc.w    $F40A, $0013, $0000
                dc.w    $F40A, $0013, $0018
Offset_0x01A9F0:
                dc.w    $0001
                dc.w    $F40A, $0013, $FFF4
Offset_0x01A9F8:
                dc.w    $0002
                dc.w    $E80A, $0013, $FFF4
                dc.w    $000A, $0013, $FFF4
Offset_0x01AA06:
                dc.w    $0003
                dc.w    $DC0A, $0013, $FFF4
                dc.w    $F40A, $0013, $FFF4
                dc.w    $0C0A, $0013, $FFF4
Offset_0x01AA1A:
                dc.w    $0004
                dc.w    $D00A, $0013, $FFF4
                dc.w    $E80A, $0013, $FFF4
                dc.w    $000A, $0013, $FFF4
                dc.w    $180A, $0013, $FFF4                                                                                                                                                                                                                                                               
;===============================================================================
; Objeto 0x08 - Espinhos
; <<<-
;===============================================================================  