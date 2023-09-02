;===============================================================================
; Objeto 0x00 - Anéis
; ->>>
;===============================================================================      
; Offset_0x0109A4:
                moveq   #$00, D0
                move.b  Obj_Routine(A0), D0                              ; $0005
                move.w  Offset_0x0109B2(PC, D0), D1
                jmp     Offset_0x0109B2(PC, D1) 
;-------------------------------------------------------------------------------
Offset_0x0109B2:
                dc.w    Offset_0x0109BC-Offset_0x0109B2
                dc.w    Offset_0x0109F2-Offset_0x0109B2
                dc.w    Offset_0x0109FC-Offset_0x0109B2
                dc.w    Offset_0x010A0E-Offset_0x0109B2
                dc.w    Offset_0x010A1C-Offset_0x0109B2
;-------------------------------------------------------------------------------
Offset_0x0109BC:
                addq.b  #$02, Obj_Routine(A0)                            ; $0005
                move.l  #Rings_Mappings, Obj_Map(A0)    ; Offset_0x010DE2, $000C
                move.w  #$A6BC, Obj_Art_VRAM(A0)                         ; $000A
                move.b  #$04, Obj_Flags(A0)                              ; $0004
                move.w  #$0100, Obj_Priority(A0)                         ; $0008
                move.b  #$47, Obj_Col_Flags(A0)                          ; $0028
                move.b  #$08, Obj_Width(A0)                              ; $0007
                tst.w   (Two_Player_Flag).w                          ; $FFFFFFD8
                beq.s   Offset_0x0109F2
                move.w  #$63D2, Obj_Art_VRAM(A0)                         ; $000A
;-------------------------------------------------------------------------------                
Offset_0x0109F2:
                move.b  (Object_Frame_Buffer).w, Obj_Map_Id(A0) ; $FFFFFEA3, $0022
                bra     MarkObjGone_5                          ; Offset_0x011BCC
;-------------------------------------------------------------------------------                 
Offset_0x0109FC:
                addq.b  #$02, Obj_Routine(A0)                            ; $0005
                move.b  #$00, Obj_Col_Flags(A0)                          ; $0028
                move.w  #$0080, Obj_Priority(A0)                         ; $0008
                bsr.s   Add_Rings_Check_Ring_Status            ; Offset_0x010A20
;-------------------------------------------------------------------------------                 
Offset_0x010A0E:
                lea     (Rings_Animate_Data), A1               ; Offset_0x010DDA
                bsr     AnimateSprite                          ; Offset_0x01115E
                bra     DisplaySprite                          ; Offset_0x011148
;-------------------------------------------------------------------------------                
Offset_0x010A1C:
                bra     DeleteObject                           ; Offset_0x011138                       
;===============================================================================
; Objeto 0x00 - Anéis
; <<<-
;===============================================================================  