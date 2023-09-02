;===============================================================================
; Objeto 0x2D - Troncos que descem nas cachoeiras da Angel Island
; ->>>           
;===============================================================================
Offset_0x02278C:
                dc.w    $0001, $0003, $0007, $000F, $001F, $003F, $007F, $00FF
                dc.w    $01FF, $03FF, $07FF, $0FFF, $1FFF, $3FFF, $7FFF, $FFFF
;-------------------------------------------------------------------------------
Obj_0x2D_AIz_Falling_Log:                                      ; Offset_0x0227AC
                cmpi.w  #$26B0, Obj_X(A0)                                ; $0010
                beq.s   Offset_0x0227BC
                cmpi.w  #$2700, Obj_X(A0)                                ; $0010
                bne.s   Offset_0x0227C8
Offset_0x0227BC:
                tst.b   (Level_Trigger_Array).w                      ; $FFFFF7E0
                beq.s   Offset_0x0227C8
                jmp     (DeleteObject)                         ; Offset_0x011138
Offset_0x0227C8:
                move.b  Obj_Subtype(A0), D0                              ; $002C
                move.b  D0, D1
                andi.w  #$000F, D0
                move.w  D0, D2
                add.w   D0, D0
                move.w  Offset_0x02278C(PC, D0), Obj_Control_Var_02(A0)  ; $0032
                subq.w  #$03, D2
                bcc.s   Offset_0x0227E2
                moveq   #$00, D2
Offset_0x0227E2:
                lsr.w   #$04, D1
                andi.w  #$000F, D1
                lsl.w   D2, D1
                move.w  D1, Obj_Control_Var_04(A0)                       ; $0034
                move.b  #$04, Obj_Flags(A0)                              ; $0004
                move.l  #Offset_0x0227FA, (A0)
Offset_0x0227FA:                
                move.w  (Level_Frame_Count).w, D0                    ; $FFFFFE04
                add.w   Obj_Control_Var_04(A0), D0                       ; $0034
                and.w   Obj_Control_Var_02(A0), D0                       ; $0032
                bne     Offset_0x0228C0
                jsr     (SingleObjectLoad_A0)                  ; Offset_0x011DE0
                bne     Offset_0x0228C0
                move.l  #Offset_0x0228C6, (A1)
                move.w  Obj_X(A0), Obj_X(A1)                      ; $0010, $0010
                move.w  Obj_Y(A0), Obj_Y(A1)                      ; $0014, $0014
                move.l  #AIz_2_Falling_Log_Mappings, Obj_Map(A1) ; Offset_0x02297E, $000C
                move.w  #$42F0, Obj_Art_VRAM(A1)                         ; $000A
                tst.b   (Act_Id).w                                   ; $FFFFFE11
                bne.s   Offset_0x022848
                move.l  #AIz_Falling_Log_Mappings, Obj_Map(A1) ; Offset_0x02298E, $000C
                move.w  #$43CF, Obj_Art_VRAM(A1)                         ; $000A
Offset_0x022848:
                move.b  #$18, Obj_Width(A1)                              ; $0007
                move.b  #$08, Obj_Height(A1)                             ; $0006
                move.b  #$04, Obj_Flags(A1)                              ; $0004
                move.w  #$0280, Obj_Priority(A1)                         ; $0008
                move.l  A1, A2
                jsr     (SingleObjectLoad_A0)                  ; Offset_0x011DE0
                bne     Offset_0x0228C0
                move.l  #Offset_0x022952, (A1)
                move.w  Obj_X(A0), Obj_X(A1)                      ; $0010, $0010
                move.w  Obj_Y(A0), Obj_Y(A1)                      ; $0014, $0014
                move.l  #AIz_2_Falling_Log_Mappings_2, Obj_Map(A1) ; Offset_0x02299E, $000C
                move.w  #$62F0, Obj_Art_VRAM(A1)                         ; $000A
                tst.b   (Act_Id).w                                   ; $FFFFFE11
                bne.s   Offset_0x0228A0
                move.l  #AIz_Falling_Log_Mappings_2, Obj_Map(A1) ; Offset_0x022A0E, $000C
                move.w  #$43CF, Obj_Art_VRAM(A1)                         ; $000A
Offset_0x0228A0:
                move.b  #$20, Obj_Width(A1)                              ; $0007
                move.b  #$10, Obj_Height(A1)                             ; $0006
                move.b  #$04, Obj_Flags(A1)                              ; $0004
                move.w  #$0200, Obj_Priority(A1)                         ; $0008
                move.w  A2, Obj_Control_Var_0C(A1)                       ; $003C
                move.w  A1, Obj_Control_Var_0C(A2)                       ; $003C
Offset_0x0228C0:
                jmp     (MarkObjGone_3)                        ; Offset_0x011B3E   
;-------------------------------------------------------------------------------
Offset_0x0228C6:
                addq.w  #$01, Obj_Y(A0)                                  ; $0014
                move.w  Obj_Y(A0), D0                                    ; $0014
                cmp.w   (Water_Level_Move).w, D0                     ; $FFFFF646
                bcs.s   Offset_0x0228E0
                move.l  #Offset_0x0228E2, (A0)
                move.b  #$3B, Obj_Ani_Time(A0)                           ; $0024
Offset_0x0228E0:
                bra.s   Offset_0x0228FE        
;-------------------------------------------------------------------------------
Offset_0x0228E2:
                subq.b  #$01, Obj_Ani_Time(A0)                           ; $0024
                bpl.s   Offset_0x0228EE
                move.w  #$7FF0, Obj_X(A0)                                ; $0010
Offset_0x0228EE:
                move.b  Obj_Ani_Time(A0), D0                             ; $0024
                andi.b  #$03, D0
                bne.s   Offset_0x0228FE
                bchg    #00, Obj_Control_Var_06(A0)                      ; $0036
Offset_0x0228FE:
                moveq   #$00, D1
                move.b  Obj_Width(A0), D1                                ; $0007
                moveq   #$08, D3
                move.w  Obj_X(A0), D4                                    ; $0010
                jsr     (Platform_Object)                      ; Offset_0x013AF6
                move.w  Obj_X(A0), D0                                    ; $0010
                andi.w  #$FF80, D0
                sub.w   (Camera_X_Left).w, D0                        ; $FFFFF7DA
                cmpi.w  #$0280, D0
                bhi     Offset_0x022932
                tst.b   Obj_Control_Var_06(A0)                           ; $0036
                bne.s   Offset_0x022930
                jmp     (DisplaySprite)                        ; Offset_0x011148
Offset_0x022930:
                rts
Offset_0x022932:
                move.w  Obj_Control_Var_0C(A0), D0                       ; $003C
                beq.s   Offset_0x022940
                move.w  D0, A1
                jsr     (Delete_A1_Object)                     ; Offset_0x01113A
Offset_0x022940:
                move.w  Obj_Respaw_Ref(A0), D0                           ; $0048
                beq.s   Offset_0x02294C
                move.w  D0, A2
                bclr    #$07, (A2)
Offset_0x02294C:
                jmp     (DeleteObject)                         ; Offset_0x011138
;-------------------------------------------------------------------------------
Offset_0x022952:
                move.w  Obj_Control_Var_0C(A0), A1                       ; $003C
                move.w  Obj_X(A1), Obj_X(A0)                      ; $0010, $0010
                move.w  Obj_Y(A1), Obj_Y(A0)                      ; $0014, $0014
                subq.b  #$01, Obj_Ani_Time(A0)                           ; $0024
                bpl.s   Offset_0x022978
                move.b  #$03, Obj_Ani_Time(A0)                           ; $0024
                addq.b  #$01, Obj_Map_Id(A0)                             ; $0022
                andi.b  #$03, Obj_Map_Id(A0)                             ; $0022
Offset_0x022978:
                jmp     (DisplaySprite)                        ; Offset_0x011148 
;-------------------------------------------------------------------------------    
AIz_2_Falling_Log_Mappings:                                    ; Offset_0x02297E
                dc.w    Offset_0x022980-AIz_2_Falling_Log_Mappings
Offset_0x022980:
                dc.w    $0002
                dc.w    $F809, $0021, $FFE8
                dc.w    $F809, $0027, $0000        
;-------------------------------------------------------------------------------   
AIz_Falling_Log_Mappings:                                      ; Offset_0x02298E
                dc.w    Offset_0x022990-AIz_Falling_Log_Mappings
Offset_0x022990:
                dc.w    $0002
                dc.w    $F809, $0000, $FFE8
                dc.w    $F809, $0006, $0000   
;-------------------------------------------------------------------------------   
AIz_2_Falling_Log_Mappings_2:                                  ; Offset_0x02299E
                dc.w    Offset_0x0229A6-AIz_2_Falling_Log_Mappings_2
                dc.w    Offset_0x0229C0-AIz_2_Falling_Log_Mappings_2
                dc.w    Offset_0x0229DA-AIz_2_Falling_Log_Mappings_2
                dc.w    Offset_0x0229F4-AIz_2_Falling_Log_Mappings_2
Offset_0x0229A6:
                dc.w    $0004
                dc.w    $F007, $105C, $FFE0
                dc.w    $F009, $0852, $FFF0
                dc.w    $F007, $185C, $0010
                dc.w    $0009, $0864, $FFF0
Offset_0x0229C0:
                dc.w    $0004
                dc.w    $F007, $085C, $0010
                dc.w    $0009, $1052, $FFF8
                dc.w    $F007, $005C, $FFE0
                dc.w    $F009, $1064, $FFF8
Offset_0x0229DA:
                dc.w    $0004
                dc.w    $F007, $106A, $FFE0
                dc.w    $F009, $0064, $FFF0
                dc.w    $F007, $186A, $0010
                dc.w    $0009, $0052, $FFF0
Offset_0x0229F4:
                dc.w    $0004
                dc.w    $F007, $086A, $0010
                dc.w    $0009, $1864, $FFF8
                dc.w    $F007, $006A, $FFE0
                dc.w    $F009, $1852, $FFF8   
;-------------------------------------------------------------------------------  
AIz_Falling_Log_Mappings_2:                                    ; Offset_0x022A0E
                dc.w    Offset_0x022A16-AIz_Falling_Log_Mappings_2
                dc.w    Offset_0x022A30-AIz_Falling_Log_Mappings_2
                dc.w    Offset_0x022A4A-AIz_Falling_Log_Mappings_2
                dc.w    Offset_0x022A64-AIz_Falling_Log_Mappings_2
Offset_0x022A16:
                dc.w    $0004
                dc.w    $F007, $000C, $FFE0
                dc.w    $F009, $0014, $FFF0
                dc.w    $F007, $080C, $0010
                dc.w    $0009, $001A, $FFF0
Offset_0x022A30:
                dc.w    $0004
                dc.w    $F007, $180C, $0010
                dc.w    $0009, $1814, $FFF8
                dc.w    $F007, $100C, $FFE0
                dc.w    $F009, $181A, $FFF8
Offset_0x022A4A:
                dc.w    $0004
                dc.w    $F007, $0020, $FFE0
                dc.w    $F009, $081A, $FFF0
                dc.w    $F007, $0820, $0010
                dc.w    $0009, $0814, $FFF0
Offset_0x022A64:
                dc.w    $0004
                dc.w    $F007, $1820, $0010
                dc.w    $0009, $101A, $FFF8
                dc.w    $F007, $1020, $FFE0
                dc.w    $F009, $1014, $FFF8
;===============================================================================
; Objeto 0x2D - Troncos que descem nas cachoeiras da Angel Island 
; <<<-  
;===============================================================================  