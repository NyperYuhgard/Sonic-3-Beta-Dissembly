;===============================================================================
; Objeto 0x30 - Miscelânea de objetos - Suporte das pontes na Angel Island,
; ->>>          postes na Angel Island, Hydrocity, Launch Base etc...       
;===============================================================================
; Offset_0x0231C0:
                move.l  #Animated_Still_Sprite_Mappings, Obj_Map(A0) ; Offset_0x02322A, $000C
                ori.b   #$04, Obj_Flags(A0)                              ; $0004
                moveq   #$00, D0
                move.b  Obj_Subtype(A0), D0                              ; $002C
                move.b  D0, Obj_Ani_Number(A0)                           ; $0020
                add.w   D0, D0
                move.w  D0, D1
                add.w   D0, D0
                add.w   D1, D0
                lea     Offset_0x02320C(PC, D0), A1
                move.w  (A1)+, Obj_Art_VRAM(A0)                          ; $000A
                move.w  (A1)+, Obj_Priority(A0)                          ; $0008
                move.b  (A1)+, Obj_Width(A0)                             ; $0007
                move.b  (A1)+, Obj_Height(A0)                            ; $0006
                move.l  #Offset_0x0231FA, (A0)
Offset_0x0231FA:                
                lea     (Animated_Still_Sprite_Animate_Data), A1 ; Offset_0x023218
                jsr     (AnimateSprite)                        ; Offset_0x01115E
                jmp     (MarkObjGone)                          ; Offset_0x011AF2   
;-------------------------------------------------------------------------------
Offset_0x02320C:
                dc.w    $62F0, $0300
                dc.b    $08, $0C
                dc.w    $62F0, $0300
                dc.b    $08, $0C    
;-------------------------------------------------------------------------------    
Animated_Still_Sprite_Animate_Data:                            ; Offset_0x023218
                dc.w    Offset_0x02321C-Animated_Still_Sprite_Animate_Data
                dc.w    Offset_0x023223-Animated_Still_Sprite_Animate_Data
Offset_0x02321C:
                dc.b    $03, $00, $01, $02, $03, $04, $FF
Offset_0x023223:
                dc.b    $03, $05, $06, $07, $08, $FF, $00   
;-------------------------------------------------------------------------------    
Animated_Still_Sprite_Mappings:                                ; Offset_0x02322A
                dc.w    Offset_0x02323C-Animated_Still_Sprite_Mappings
                dc.w    Offset_0x023244-Animated_Still_Sprite_Mappings
                dc.w    Offset_0x02324C-Animated_Still_Sprite_Mappings
                dc.w    Offset_0x023254-Animated_Still_Sprite_Mappings
                dc.w    Offset_0x02325C-Animated_Still_Sprite_Mappings
                dc.w    Offset_0x023264-Animated_Still_Sprite_Mappings
                dc.w    Offset_0x02326C-Animated_Still_Sprite_Mappings
                dc.w    Offset_0x023274-Animated_Still_Sprite_Mappings
                dc.w    Offset_0x02327C-Animated_Still_Sprite_Mappings
Offset_0x02323C:
                dc.w    $0001
                dc.w    $F406, $00EA, $FFF8
Offset_0x023244:
                dc.w    $0001
                dc.w    $F406, $00F0, $FFF8
Offset_0x02324C:
                dc.w    $0001
                dc.w    $F406, $00F6, $FFF8
Offset_0x023254:
                dc.w    $0001
                dc.w    $F406, $00FC, $FFF8
Offset_0x02325C:
                dc.w    $0001
                dc.w    $F406, $08F0, $FFF8
Offset_0x023264:
                dc.w    $0001
                dc.w    $F007, $0102, $FFF8
Offset_0x02326C:
                dc.w    $0001
                dc.w    $F007, $010A, $FFF8
Offset_0x023274:
                dc.w    $0001
                dc.w    $F007, $0112, $FFF8
Offset_0x02327C:
                dc.w    $0001
                dc.w    $F007, $011A, $FFF8                                                                                                      
;===============================================================================
; Objeto 0x30 - Miscelânea de objetos - Suporte das pontes na Angel Island,
; <<<-          postes na Angel Island, Hydrocity, Launch Base etc...
;===============================================================================  