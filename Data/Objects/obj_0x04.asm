;===============================================================================
; Objeto 0x04 - Plataformas que desmoronam ao serem tocadas 
; ->>>
;===============================================================================
; Offset_0x01582E:
                move.l  #Collapsing_Platform_Mappings, Obj_Map(A0) ; Offset_0x016014, $000C
                move.w  #$4001, Obj_Art_VRAM(A0)                         ; $000A
                cmpi.w  #AIz_Act_2, (Level_Id).w              ; $0001, $FFFFFE10
                bne.s   Offset_0x015852
                move.l  #AIz_2_Collapsing_Platform_Mappings, Obj_Map(A0) ; Offset_0x0160F8, $000C
                move.w  #$4001, Obj_Art_VRAM(A0)                         ; $000A
Offset_0x015852:
                move.l  #Offset_0x015DE8, Obj_Control_Var_00(A0)         ; $0030
                move.l  #Offset_0x015FA4, Obj_Control_Var_0C(A0)         ; $003C
                move.b  #$3C, Obj_Width(A0)                              ; $0007
                move.b  #$20, Obj_Height(A0)                             ; $0006
                cmpi.b  #Iz_Id, (Level_Id).w                    ; $05, $FFFFFE10
                bne.s   Offset_0x0158A0
                move.l  #Iz_Collapsing_Platform_Mappings, Obj_Map(A0) ; Offset_0x016D00, $000C
                move.w  #$4001, Obj_Art_VRAM(A0)                         ; $000A
                move.l  #Offset_0x015E06, Obj_Control_Var_00(A0)         ; $0030
                move.l  #Offset_0x015FE4, Obj_Control_Var_0C(A0)         ; $003C
                move.b  #$30, Obj_Width(A0)                              ; $0007
                move.b  #$30, Obj_Height(A0)                             ; $0006
Offset_0x0158A0:
                ori.b   #$04, Obj_Flags(A0)                              ; $0004
                move.w  #$0200, Obj_Priority(A0)                         ; $0008
                move.b  #$07, Obj_Control_Var_08(A0)                     ; $0038
                move.b  Obj_Subtype(A0), Obj_Map_Id(A0)           ; $002C, $0022
                ori.b   #$80, Obj_Status(A0)                             ; $002A
                move.l  #Offset_0x0158C4, (A0)
Offset_0x0158C4:                
                tst.b   Obj_Control_Var_0A(A0)                           ; $003A
                beq.s   Offset_0x0158D6
                tst.b   Obj_Control_Var_08(A0)                           ; $0038
                beq     Offset_0x015D6A
                subq.b  #$01, Obj_Control_Var_08(A0)                     ; $0038
Offset_0x0158D6:
                move.b  Obj_Status(A0), D0                               ; $002A
                andi.b  #$18, D0
                beq.s   Offset_0x0158E6
                move.b  #$01, Obj_Control_Var_0A(A0)                     ; $003A
Offset_0x0158E6:
                moveq   #$00, D1
                move.b  Obj_Width(A0), D1                                ; $0007
                move.l  Obj_Control_Var_0C(A0), A2                       ; $003C
                move.w  Obj_X(A0), D4                                    ; $0010
                jsr     (Platform_Object_2)                    ; Offset_0x013B4E
                bra     MarkObjGone                            ; Offset_0x011AF2  
;-------------------------------------------------------------------------------
Offset_0x0158FE: ; Referência do objeto 0x0F que é referência deste objeto (0x04)
                tst.b   Obj_Control_Var_08(A0)                           ; $0038
                beq.s   Offset_0x01594E
                tst.b   Obj_Control_Var_0A(A0)                           ; $003A
                bne.s   Offset_0x015912
                subq.b  #$01, Obj_Control_Var_08(A0)                     ; $0038
                bra     DisplaySprite                          ; Offset_0x011148
Offset_0x015912:
                bsr     Offset_0x0158E6
                subq.b  #$01, Obj_Control_Var_08(A0)                     ; $0038
                bne.s   Offset_0x01594C
                lea     (Obj_Player_One).w, A1                       ; $FFFFB000
                moveq   #$03, D6
                bsr.s   Offset_0x01592A
                lea     (Obj_Player_Two).w, A1                       ; $FFFFB04A
                moveq   #$04, D6
Offset_0x01592A:
                btst    D6, Obj_Status(A0)                               ; $002A
                beq.s   Offset_0x01594C
                bclr    D6, Obj_Status(A0)                               ; $002A
                bclr    #$03, Obj_Status(A1)                             ; $002A
                bclr    #$05, Obj_Status(A1)                             ; $002A
                bset    #$01, Obj_Status(A1)                             ; $002A
                move.b  #$01, Obj_Ani_Flag(A1)                           ; $0021
Offset_0x01594C:
                rts
Offset_0x01594E:
                bsr     ObjectFall                             ; Offset_0x0110FE
                tst.b   Obj_Flags(A0)                                    ; $0004
                bpl     DeleteObject                           ; Offset_0x011138
                bra     DisplaySprite                          ; Offset_0x011148                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     
;===============================================================================
; Objeto 0x04 - Plataformas que desmoronam ao serem tocadas
; <<<- 
;===============================================================================