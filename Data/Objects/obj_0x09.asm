;===============================================================================
; Objeto 0x09 - Atributo das árvores na Angel Island
; ->>>
;===============================================================================      
; Offset_0x013F24:
                move.l  #AIz_Tree_Mappings, Obj_Map(A0) ; Offset_0x013F50, $000C
                move.w  #$0180, Obj_Priority(A0)                         ; $0008
                move.b  #$08, Obj_Width(A0)                              ; $0007
                move.b  #$04, Obj_Flags(A0)                              ; $0004
                move.w  #$4001, Obj_Art_VRAM(A0)                         ; $000A
                move.l  #Offset_0x013F4A, (A0)
Offset_0x013F4A:                
                jmp     (MarkObjGone)                          ; Offset_0x011AF2   
;-------------------------------------------------------------------------------
AIz_Tree_Mappings:                                             ; Offset_0x013F50
                dc.w    Offset_0x013F52-AIz_Tree_Mappings
Offset_0x013F52:
                dc.w    $0003
                dc.w    $E805, $0038, $FFF8
                dc.w    $F805, $0038, $FFF8
                dc.w    $0805, $0038, $FFF8                                                                                                                    
;===============================================================================
; Objeto 0x09 - Atributo das árvores na Angel Island
; <<<-
;===============================================================================  