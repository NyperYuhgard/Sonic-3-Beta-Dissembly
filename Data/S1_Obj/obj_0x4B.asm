;=============================================================================== 
; Objeto 0x4B - Anel gigante usado no Sonic 1 para acesso ao Special Stage 
; ->>>          não usado (Left over)
;===============================================================================  
; Offset_0x010C60:
                moveq   #$00, D0
                move.b  Obj_Routine(A0), D0                              ; $0005
                move.w  Offset_0x010C6E(PC, D0), D1
                jmp     Offset_0x010C6E(PC, D1)
;-------------------------------------------------------------------------------
Offset_0x010C6E:
                dc.w    Offset_0x010C76-Offset_0x010C6E
                dc.w    Offset_0x010CC0-Offset_0x010C6E
                dc.w    Offset_0x010CDE-Offset_0x010C6E
                dc.w    Offset_0x010D22-Offset_0x010C6E    
;-------------------------------------------------------------------------------
Offset_0x010C76:
                move.l  #Big_Ring_Mappings, Obj_Map(A0) ; Offset_0x010E36, $000C
                move.w  #$2400, Obj_Art_VRAM(A0)                         ; $000A
                ori.b   #$04, Obj_Flags(A0)                              ; $0004
                move.b  #$40, Obj_Width(A0)                              ; $0007
                tst.b   Obj_Flags(A0)                                    ; $0004
                bpl.s   Offset_0x010CC0
                cmpi.b  #$06, (SS_Completed_Flag).w                  ; $FFFFFFB0
                beq     Offset_0x010D22
                cmpi.w  #$0032, (Ring_Count_Address).w               ; $FFFFFE20
                bcc.s   Offset_0x010CAA
                rts
Offset_0x010CAA:
                addq.b  #$02, Obj_Routine(A0)                            ; $0005
                move.w  #$0100, Obj_Priority(A0)                         ; $0008
                move.b  #$52, Obj_Col_Flags(A0)                          ; $0028
                move.w  #$0C40, (S1_Load_Big_Ring_Art_Flag).w        ; $FFFFF7BE
;-------------------------------------------------------------------------------                
Offset_0x010CC0:
                move.b  (Object_Frame_Buffer).w, Obj_Map_Id(A0) ; $FFFFFEA3, $0022
                move.w  Obj_X(A0), D0                                    ; $0010
                andi.w  #$FF80, D0
                sub.w   (Camera_X_Left).w, D0                        ; $FFFFF7DA
                cmpi.w  #$0280, D0
                bhi     DeleteObject                           ; Offset_0x011138
                bra     DisplaySprite                          ; Offset_0x011148
;------------------------------------------------------------------------------- 
Offset_0x010CDE:
                subq.b  #$02, Obj_Routine(A0)                            ; $0005
                move.b  #$00, Obj_Col_Flags(A0)                          ; $0028
                bsr     SingleObjectLoad                       ; Offset_0x011DD8
                bne     Offset_0x010D16
                move.l  #Obj_S1_0x7C_Big_Ring_Flash, (A1)      ; Offset_0x010D26
                move.w  Obj_X(A0), Obj_X(A1)                      ; $0010, $0010
                move.w  Obj_Y(A0), Obj_Y(A1)                      ; $0014, $0014
                move.l  A0, Obj_Control_Var_10(A1)                       ; $0040
                move.w  (Obj_Player_One+Obj_X).w, D0                 ; $FFFFB010
                cmp.w   Obj_X(A0), D0                                    ; $0010
                bcs.s   Offset_0x010D16
                bset    #$00, Obj_Flags(A1)                              ; $0004
Offset_0x010D16:
                move.w  #S2_Enter_Big_Ring_Sfx, D0                       ; $0032      
                jsr     (Play_Music)                           ; Offset_0x001176
                bra.s   Offset_0x010CC0
Offset_0x010D22:
                bra     DeleteObject                           ; Offset_0x011138 
;=============================================================================== 
; Objeto 0x4B - Anel gigante usado no Sonic 1 para acesso ao Special Stage   
; <<<-          não usado (Left over)
;===============================================================================   