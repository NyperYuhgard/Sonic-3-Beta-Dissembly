;===============================================================================
; Objeto de controle ao toque nos objetos das fases
; ->>>
;===============================================================================
; Offset_0x013D7C:
                moveq   #$00, D0
                move.b  Obj_Routine(A0), D0                              ; $0005
                move.w  Offset_0x013D8A(PC, D0), D1
                jmp     Offset_0x013D8A(PC, D1)   
;-------------------------------------------------------------------------------
Offset_0x013D8A:
                dc.w    Offset_0x013D90-Offset_0x013D8A
                dc.w    Offset_0x013DB4-Offset_0x013D8A
                dc.w    Offset_0x013E08-Offset_0x013D8A
;-------------------------------------------------------------------------------
Offset_0x013D90:
                addq.b  #$02, Obj_Routine(A0)                            ; $0005
                jsr     (SingleObjectLoad)                     ; Offset_0x011DD8
                bne.s   Offset_0x013DB4
                move.l  #Obj_Flickies, (A1)                    ; Offset_0x0238DA
                move.w  Obj_X(A0), Obj_X(A1)                      ; $0010, $0010
                move.w  Obj_Y(A0), Obj_Y(A1)                      ; $0014, $0014
                move.w  Obj_Control_Var_0E(A0), Obj_Control_Var_0E(A1) ; $003E, $003E
;-------------------------------------------------------------------------------                
Offset_0x013DB4:
                addq.b  #$02, Obj_Routine(A0)                            ; $0005
                move.l  #Object_Hit_Mappings, Obj_Map(A0) ; Offset_0x013EF2, $000C
                move.w  Obj_Art_VRAM(A0), D0                             ; $000A
                andi.w  #$8000, D0
                ori.w   #$05A0, D0
                move.w  D0, Obj_Art_VRAM(A0)                             ; $000A
                move.b  #$04, Obj_Flags(A0)                              ; $0004
                move.w  #$0080, Obj_Priority(A0)                         ; $0008
                move.b  #$00, Obj_Col_Flags(A0)                          ; $0028
                move.b  #$0C, Obj_Width(A0)                              ; $0007
                move.b  #$0C, Obj_Height(A0)                             ; $0006
                move.b  #$03, Obj_Ani_Time(A0)                           ; $0024
                move.b  #$00, Obj_Map_Id(A0)                             ; $0022
                moveq   #Object_Hit_Sfx, D0                                ; $3D
                jsr     (Play_Music)                           ; Offset_0x001176
                move.l  #Offset_0x013E08, (A0)
;-------------------------------------------------------------------------------                
Offset_0x013E08:
                subq.b  #$01, Obj_Ani_Time(A0)                           ; $0024
                bpl.s   Offset_0x013E22
                move.b  #$07, Obj_Ani_Time(A0)                           ; $0024
                addq.b  #$01, Obj_Map_Id(A0)                             ; $0022
                cmpi.b  #$05, Obj_Map_Id(A0)                             ; $0022
                beq     DeleteObject                           ; Offset_0x011138
Offset_0x013E22:
                jmp     (DisplaySprite)                        ; Offset_0x011148                                                                                                                                                                                                 
;===============================================================================
; Objeto de controle ao toque nos objetos das fases
; <<<-
;===============================================================================       