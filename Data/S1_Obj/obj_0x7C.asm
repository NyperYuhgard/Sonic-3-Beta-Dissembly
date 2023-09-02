;=============================================================================== 
; Objeto 0x7C - Flash do anel gigante usado no Sonic 1 para acesso ao 
; ->>>          Special Stage não usado (Left over)
;===============================================================================  
; Offset_0x010D26:
                moveq   #$00, D0
                move.b  Obj_Routine(A0), D0                              ; $0005
                move.w  Offset_0x010D34(PC, D0), D1
                jmp     Offset_0x010D34(PC, D1)
;-------------------------------------------------------------------------------
Offset_0x010D34:
                dc.w    Offset_0x010D3A-Offset_0x010D34
                dc.w    Offset_0x010D64-Offset_0x010D34
                dc.w    Offset_0x010DD6-Offset_0x010D34  
;-------------------------------------------------------------------------------
Offset_0x010D3A:
                addq.b  #$02, Obj_Routine(A0)                            ; $0005
                move.l  #Big_Ring_Flash_Mappings, Obj_Map(A0) ; Offset_0x010EFA,$000C
                move.w  #$2462, Obj_Art_VRAM(A0)                         ; $000A
                ori.b   #$04, Obj_Flags(A0)                              ; $0004
                move.w  #$0000, Obj_Priority(A0)                         ; $0008
                move.b  #$20, Obj_Width(A0)                              ; $0007
                move.b  #$FF, Obj_Map_Id(A0)                             ; $0022
;-------------------------------------------------------------------------------                
Offset_0x010D64:                
                bsr.s   Offset_0x010D7E
                move.w  Obj_X(A0), D0                                    ; $0010
                andi.w  #$FF80, D0
                sub.w   (Camera_X_Left).w, D0                        ; $FFFFF7DA
                cmpi.w  #$0280, D0
                bhi     DeleteObject                           ; Offset_0x011138
                bra     DisplaySprite                          ; Offset_0x011148
Offset_0x010D7E:
                subq.b  #$01, Obj_Ani_Time(A0)                           ; $0024
                bpl.s   Offset_0x010DC4
                move.b  #$01, Obj_Ani_Time(A0)                           ; $0024
                addq.b  #$01, Obj_Map_Id(A0)                             ; $0022
                cmpi.b  #$08, Obj_Map_Id(A0)                             ; $0022
                bcc.s   Offset_0x010DC6
                cmpi.b  #$03, Obj_Map_Id(A0)                             ; $0022
                bne.s   Offset_0x010DC4
                move.l  Obj_Control_Var_10(A0), A1                       ; $0040
                move.b  #$06, Obj_Routine(A1)                            ; $0005
                move.b  #$1C, (Obj_Player_One+Obj_Ani_Number).w      ; $FFFFB020
                move.b  #$01, (Special_Stage_Entry_Flag).w           ; $FFFFF7CD
                lea     (Obj_Player_One).w, A1                       ; $FFFFB000
                bclr    #$01, Obj_Player_Status(A1)                      ; $002F
                bclr    #$00, Obj_Player_Status(A1)                      ; $002F
Offset_0x010DC4:
                rts
Offset_0x010DC6:
                addq.b  #$02, Obj_Routine(A0)                            ; $0005
                move.l  #$00000000, (Obj_Player_One).w               ; $FFFFB000
                addq.l  #$04, A7
                rts
;-------------------------------------------------------------------------------
Offset_0x010DD6:
                bra     DeleteObject                           ; Offset_0x011138
;=============================================================================== 
; Objeto 0x7C - Flash do anel gigante usado no Sonic 1 para acesso ao 
; <<<-          Special Stage não usado (Left over)
;===============================================================================  