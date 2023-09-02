;===============================================================================
; Objeto 0x35 - Plantas na Angel Island
; ->>>  
;===============================================================================  
; Offset_0x023284:
                move.l  #Plants_Mappings, Obj_Map(A0)   ; Offset_0x023442, $000C
                ori.b   #$04, Obj_Flags(A0)                              ; $0004
                move.w  Obj_X(A0), Obj_Control_Var_00(A0)         ; $0010, $0030
                move.w  Obj_Y(A0), Obj_Control_Var_02(A0)         ; $0014, $0032
                move.b  Obj_Subtype(A0), D0                              ; $002C
                andi.w  #$000F, D0
                move.b  D0, Obj_Map_Id(A0)                               ; $0022
                add.w   D0, D0
                move.w  D0, D1
                add.w   D0, D0
                add.w   D1, D0
                lea     Offset_0x0232D6(PC, D0), A1
                move.w  (A1)+, Obj_Art_VRAM(A0)                          ; $000A
                move.w  (A1)+, Obj_Priority(A0)                          ; $0008
                move.b  (A1)+, Obj_Width(A0)                             ; $0007
                move.b  (A1)+, Obj_Height(A0)                            ; $0006
                move.b  Obj_Subtype(A0), D0                              ; $002C
                lsr.w   #$02, D0
                andi.w  #$003C, D0
                move.l  Offset_0x0232E2(PC, D0), (A0)
                rts   
;-------------------------------------------------------------------------------  
Offset_0x0232D6:
                dc.w    $C333, $0000
                dc.b    $20, $30
                dc.w    $C333, $0000  
                dc.b    $20, $3C  
;-------------------------------------------------------------------------------    
Offset_0x0232E2:
                dc.l    Offset_0x0232FE
                dc.l    Offset_0x023304
                dc.l    Offset_0x02333A
                dc.l    Offset_0x023370
                dc.l    Offset_0x0233A6
                dc.l    Offset_0x0233DC
                dc.l    Offset_0x02340E   
;-------------------------------------------------------------------------------
Offset_0x0232FE:
                jmp     (MarkObjGone)                          ; Offset_0x011AF2  
;-------------------------------------------------------------------------------
Offset_0x023304:
                move.w  Obj_Control_Var_00(A0), D1                       ; $0030
                move.w  D1, D2
                subi.w  #$00A0, D1
                sub.w   (Camera_X).w, D1                             ; $FFFFEE78
                asr.w   #$04, D1
                add.w   D2, D1
                move.w  D1, Obj_X(A0)                                    ; $0010
                move.w  Obj_Control_Var_02(A0), D1                       ; $0032
                move.w  D1, D2
                subi.w  #$0070, D1
                sub.w   (Camera_Y).w, D1                             ; $FFFFEE7C
                asr.w   #$04, D1
                add.w   D2, D1
                move.w  D1, Obj_Y(A0)                                    ; $0014
                move.w  Obj_Control_Var_00(A0), D0                       ; $0030
                jmp     (MarkObjGone_2)                        ; Offset_0x011B1A   
;-------------------------------------------------------------------------------
Offset_0x02333A:
                move.w  Obj_Control_Var_00(A0), D1                       ; $0030
                move.w  D1, D2
                subi.w  #$00A0, D1
                sub.w   (Camera_X).w, D1                             ; $FFFFEE78
                asr.w   #$03, D1
                add.w   D2, D1
                move.w  D1, Obj_X(A0)                                    ; $0010
                move.w  Obj_Control_Var_02(A0), D1                       ; $0032
                move.w  D1, D2
                subi.w  #$0070, D1
                sub.w   (Camera_Y).w, D1                             ; $FFFFEE7C
                asr.w   #$03, D1
                add.w   D2, D1
                move.w  D1, Obj_Y(A0)                                    ; $0014
                move.w  Obj_Control_Var_00(A0), D0                       ; $0030
                jmp     (MarkObjGone_2)                        ; Offset_0x011B1A  
;-------------------------------------------------------------------------------
Offset_0x023370:
                move.w  Obj_Control_Var_00(A0), D1                       ; $0030
                move.w  D1, D2
                subi.w  #$00A0, D1
                sub.w   (Camera_X).w, D1                             ; $FFFFEE78
                asr.w   #$02, D1
                add.w   D2, D1
                move.w  D1, Obj_X(A0)                                    ; $0010
                move.w  Obj_Control_Var_02(A0), D1                       ; $0032
                move.w  D1, D2
                subi.w  #$0070, D1
                sub.w   (Camera_Y).w, D1                             ; $FFFFEE7C
                asr.w   #$02, D1
                add.w   D2, D1
                move.w  D1, Obj_Y(A0)                                    ; $0014
                move.w  Obj_Control_Var_00(A0), D0                       ; $0030
                jmp     (MarkObjGone_2)                        ; Offset_0x011B1A    
;-------------------------------------------------------------------------------
Offset_0x0233A6:
                move.w  Obj_Control_Var_00(A0), D1                       ; $0030
                move.w  D1, D2
                subi.w  #$00A0, D1
                sub.w   (Camera_X).w, D1                             ; $FFFFEE78
                asr.w   #$01, D1
                add.w   D2, D1
                move.w  D1, Obj_X(A0)                                    ; $0010
                move.w  Obj_Control_Var_02(A0), D1                       ; $0032
                move.w  D1, D2
                subi.w  #$0070, D1
                sub.w   (Camera_Y).w, D1                             ; $FFFFEE7C
                asr.w   #$01, D1
                add.w   D2, D1
                move.w  D1, Obj_Y(A0)                                    ; $0014
                move.w  Obj_Control_Var_00(A0), D0                       ; $0030
                jmp     (MarkObjGone_2)                        ; Offset_0x011B1A   
;-------------------------------------------------------------------------------
Offset_0x0233DC:
                move.w  Obj_Control_Var_00(A0), D1                       ; $0030
                move.w  D1, D2
                subi.w  #$00A0, D1
                sub.w   (Camera_X).w, D1                             ; $FFFFEE78
                add.w   D2, D1
                move.w  D1, Obj_X(A0)                                    ; $0010
                move.w  Obj_Control_Var_02(A0), D1                       ; $0032
                move.w  D1, D2
                subi.w  #$0070, D1
                sub.w   (Camera_Y).w, D1                             ; $FFFFEE7C
                add.w   D2, D1
                move.w  D1, Obj_Y(A0)                                    ; $0014
                move.w  Obj_Control_Var_00(A0), D0                       ; $0030
                jmp     (MarkObjGone_2)                        ; Offset_0x011B1A  
;-------------------------------------------------------------------------------
Offset_0x02340E:
                move.w  Obj_Control_Var_00(A0), D1                       ; $0030
                move.w  D1, D2
                subi.w  #$00A0, D1
                sub.w   (Camera_X).w, D1                             ; $FFFFEE78
                add.w   D1, D1
                add.w   D2, D1
                move.w  D1, Obj_X(A0)                                    ; $0010
                move.w  Obj_Control_Var_02(A0), D1                       ; $0032
                move.w  D1, D2
                subi.w  #$0070, D1
                sub.w   (Camera_Y).w, D1                             ; $FFFFEE7C
                add.w   D2, D1
                move.w  D1, Obj_Y(A0)                                    ; $0014
                move.w  Obj_Control_Var_00(A0), D0                       ; $0030
                jmp     (MarkObjGone_2)                        ; Offset_0x011B1A 
;-------------------------------------------------------------------------------     
Plants_Mappings:                                               ; Offset_0x023442
                dc.w    Offset_0x023446-Plants_Mappings
                dc.w    Offset_0x023478-Plants_Mappings
Offset_0x023446:
                dc.w    $0008
                dc.w    $D00E, $0064, $FFE0
                dc.w    $E80F, $0070, $FFE0
                dc.w    $0809, $0080, $FFE8
                dc.w    $1802, $0086, $FFF8
                dc.w    $E804, $0089, $0010
                dc.w    $F00D, $008B, $0000
                dc.w    $0009, $0093, $0000
                dc.w    $1002, $0099, $0000
Offset_0x023478:
                dc.w    $0008
                dc.w    $C40E, $0864, $0000
                dc.w    $DC0F, $0870, $0000
                dc.w    $FC09, $0880, $0000
                dc.w    $0C02, $0886, $0000
                dc.w    $DC0E, $0064, $FFE0
                dc.w    $F40F, $0070, $FFE0
                dc.w    $1409, $0080, $FFE8
                dc.w    $2402, $0086, $FFF8                                                                                                                                  
;===============================================================================
; Objeto 0x35 - Plantas na Angel Island
; <<<-  
;===============================================================================  