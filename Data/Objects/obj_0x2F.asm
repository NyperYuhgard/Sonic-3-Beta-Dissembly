;===============================================================================
; Objeto 0x2F - Miscelânea de objetos - Suporte das pontes na Angel Island,
; ->>>          postes na Angel Island, Hydrocity, Launch Base etc...  
;===============================================================================
; Offset_0x022E38:
                move.l  #Still_Sprite_Mappings, Obj_Map(A0) ; Offset_0x022F02, $000C
                ori.b   #$04, Obj_Flags(A0)                              ; $0004
                moveq   #$00, D0
                move.b  Obj_Subtype(A0), D0                              ; $002C
                move.b  D0, Obj_Map_Id(A0)                               ; $0022
                add.w   D0, D0
                move.w  D0, D1
                add.w   D0, D0
                add.w   D1, D0
                lea     Offset_0x022E78(PC, D0), A1
                move.w  (A1)+, Obj_Art_VRAM(A0)                          ; $000A
                move.w  (A1)+, Obj_Priority(A0)                          ; $0008
                move.b  (A1)+, Obj_Width(A0)                             ; $0007
                move.b  (A1)+, Obj_Height(A0)                            ; $0006
                move.l  #Offset_0x022E72, (A0)
Offset_0x022E72:                
                jmp     (MarkObjGone)                          ; Offset_0x011AF2   
;-------------------------------------------------------------------------------
Offset_0x022E78:
                dc.w    $42F0, $0300
                dc.b    $0C, $0C
                dc.w    $42F0, $0300 
                dc.b    $10, $08
                dc.w    $42F0, $0300
                dc.b    $08, $04
                dc.w    $4001, $0300 
                dc.b    $08, $08
                dc.w    $6001, $0300
                dc.b    $08, $20
                dc.w    $C2F0, $0300 
                dc.b    $0C, $0C
                dc.w    $C001, $0000
                dc.b    $40, $40
                dc.w    $C001, $0000 
                dc.b    $40, $20
                dc.w    $4001, $0300
                dc.b    $40, $10
                dc.w    $C001, $0000
                dc.b    $40, $40
                dc.w    $C001, $0000
                dc.b    $40, $60
                dc.w    $4451, $0300 
                dc.b    $10, $18
                dc.w    $4451, $0300
                dc.b    $10, $18
                dc.w    $4451, $0300 
                dc.b    $10, $18
                dc.w    $4451, $0300
                dc.b    $10, $18
                dc.w    $C368, $0000
                dc.b    $08, $30
                dc.w    $C379, $0000
                dc.b    $30, $18
                dc.w    $C399, $0000 
                dc.b    $0C, $10
                dc.w    $C3A4, $0000
                dc.b    $20, $34
                dc.w    $4038, $0300 
                dc.b    $04, $10
                dc.w    $440D, $0300
                dc.b    $08, $08
                dc.w    $2433, $0300 
                dc.b    $10, $40
                dc.w    $2433, $0300
                dc.b    $10, $80  
;-------------------------------------------------------------------------------  
Still_Sprite_Mappings:                                         ; Offset_0x022F02
                dc.w    Offset_0x022F30-Still_Sprite_Mappings
                dc.w    Offset_0x022F3E-Still_Sprite_Mappings
                dc.w    Offset_0x022F46-Still_Sprite_Mappings
                dc.w    Offset_0x022F4E-Still_Sprite_Mappings
                dc.w    Offset_0x022F56-Still_Sprite_Mappings
                dc.w    Offset_0x022F30-Still_Sprite_Mappings
                dc.w    Offset_0x022F64-Still_Sprite_Mappings
                dc.w    Offset_0x022FC6-Still_Sprite_Mappings
                dc.w    Offset_0x022FF8-Still_Sprite_Mappings
                dc.w    Offset_0x023012-Still_Sprite_Mappings
                dc.w    Offset_0x02304A-Still_Sprite_Mappings
                dc.w    Offset_0x023094-Still_Sprite_Mappings
                dc.w    Offset_0x0230A8-Still_Sprite_Mappings
                dc.w    Offset_0x0230BC-Still_Sprite_Mappings
                dc.w    Offset_0x0230D0-Still_Sprite_Mappings
                dc.w    Offset_0x0230E4-Still_Sprite_Mappings
                dc.w    Offset_0x0230FE-Still_Sprite_Mappings
                dc.w    Offset_0x023124-Still_Sprite_Mappings
                dc.w    Offset_0x023132-Still_Sprite_Mappings
                dc.w    Offset_0x023164-Still_Sprite_Mappings
                dc.w    Offset_0x02316C-Still_Sprite_Mappings
                dc.w    Offset_0x023174-Still_Sprite_Mappings
                dc.w    Offset_0x02318E-Still_Sprite_Mappings
Offset_0x022F30:
                dc.w    $0002
                dc.w    $F405, $0126, $FFF4
                dc.w    $0408, $012A, $FFF4
Offset_0x022F3E:
                dc.w    $0001
                dc.w    $F80D, $0000, $FFF0
Offset_0x022F46:
                dc.w    $0001
                dc.w    $FC04, $0008, $FFF8
Offset_0x022F4E:
                dc.w    $0001
                dc.w    $F805, $0026, $FFF8
Offset_0x022F56:
                dc.w    $0002
                dc.w    $E007, $003A, $FFF8
                dc.w    $0007, $0042, $FFF8
Offset_0x022F64:
                dc.w    $0010
                dc.w    $C00F, $0050, $FFC0
                dc.w    $C00F, $0050, $FFE0
                dc.w    $C00F, $0050, $0000
                dc.w    $C00F, $0050, $0020
                dc.w    $E00F, $0050, $FFC0
                dc.w    $E00F, $0050, $FFE0
                dc.w    $E00F, $0050, $0000
                dc.w    $E00F, $0050, $0020
                dc.w    $000F, $0050, $FFC0
                dc.w    $000F, $0050, $FFE0
                dc.w    $000F, $0050, $0000
                dc.w    $000F, $0050, $0020
                dc.w    $200F, $0050, $FFC0
                dc.w    $200F, $0050, $FFE0
                dc.w    $200F, $0050, $0000
                dc.w    $200F, $0050, $0020
Offset_0x022FC6:
                dc.w    $0008
                dc.w    $E00F, $0050, $FFC0
                dc.w    $E00F, $0050, $FFE0
                dc.w    $E00F, $0050, $0000
                dc.w    $E00F, $0050, $0020
                dc.w    $000F, $0050, $FFC0
                dc.w    $000F, $0050, $FFE0
                dc.w    $000F, $0050, $0000
                dc.w    $000F, $0050, $0020
Offset_0x022FF8:
                dc.w    $0004
                dc.w    $F00F, $0050, $FFC0
                dc.w    $F00F, $0050, $FFE0
                dc.w    $F00F, $0050, $0000
                dc.w    $F00F, $0050, $0020
Offset_0x023012:
                dc.w    $0009
                dc.w    $C00F, $0050, $0020
                dc.w    $E00F, $0050, $0000
                dc.w    $E00F, $0050, $0020
                dc.w    $000F, $0050, $FFE0
                dc.w    $000F, $0050, $0000
                dc.w    $000F, $0050, $0020
                dc.w    $200F, $0050, $FFC0
                dc.w    $200F, $0050, $FFE0
                dc.w    $200F, $0050, $0000
Offset_0x02304A:
                dc.w    $000C
                dc.w    $A00F, $0050, $FFC0
                dc.w    $C00F, $0050, $FFC0
                dc.w    $C00F, $0050, $FFE0
                dc.w    $E00F, $0050, $FFC0
                dc.w    $E00F, $0050, $FFE0
                dc.w    $E00F, $0050, $0000
                dc.w    $000F, $0050, $FFE0
                dc.w    $000F, $0050, $0000
                dc.w    $000F, $0050, $0020
                dc.w    $200F, $0050, $0000
                dc.w    $200F, $0050, $0020
                dc.w    $400F, $0050, $0020
Offset_0x023094:
                dc.w    $0003
                dc.w    $F00E, $0003, $FFF0
                dc.w    $E800, $0000, $FFFC
                dc.w    $0801, $0001, $FFFC
Offset_0x0230A8:
                dc.w    $0003
                dc.w    $F00E, $0803, $FFF0
                dc.w    $E800, $0000, $FFFC
                dc.w    $0801, $0001, $FFFC
Offset_0x0230BC:
                dc.w    $0003
                dc.w    $EC0B, $000F, $FFF4
                dc.w    $E800, $0000, $FFFC
                dc.w    $0801, $0001, $FFFC
Offset_0x0230D0:
                dc.w    $0003
                dc.w    $EC0B, $001B, $FFF4
                dc.w    $E800, $0000, $FFFC
                dc.w    $0801, $0001, $FFFC
Offset_0x0230E4:
                dc.w    $0004
                dc.w    $D005, $0000, $FFF8
                dc.w    $E003, $0004, $FFF8
                dc.w    $0002, $0008, $FFF8
                dc.w    $1806, $000B, $FFF8
Offset_0x0230FE:
                dc.w    $0006
                dc.w    $E809, $0000, $FFD0
                dc.w    $F80C, $0006, $FFD0
                dc.w    $000C, $000A, $FFD8
                dc.w    $080D, $000E, $FFD8
                dc.w    $0809, $0016, $FFF8
                dc.w    $100C, $001C, $0010
Offset_0x023124:
                dc.w    $0002
                dc.w    $F004, $0000, $FFFC
                dc.w    $F80A, $0002, $FFF4
Offset_0x023132:
                dc.w    $0008
                dc.w    $CC07, $0000, $FFE0
                dc.w    $EC06, $0008, $FFE0
                dc.w    $DC07, $0000, $FFF0
                dc.w    $FC06, $0008, $FFF0
                dc.w    $EC07, $0000, $0000
                dc.w    $0C06, $0008, $0000
                dc.w    $FC07, $0000, $0010
                dc.w    $1C06, $0008, $0010
Offset_0x023164:
                dc.w    $0001
                dc.w    $F003, $0000, $FFFC
Offset_0x02316C:
                dc.w    $0001
                dc.w    $F805, $0022, $FFF8
Offset_0x023174:
                dc.w    $0004
                dc.w    $C00F, $0009, $FFF0
                dc.w    $E00F, $0809, $FFF0
                dc.w    $000F, $0009, $FFF0
                dc.w    $200F, $0809, $FFF0
Offset_0x02318E:
                dc.w    $0008
                dc.w    $800F, $0009, $FFF0
                dc.w    $A00F, $0809, $FFF0
                dc.w    $C00F, $0009, $FFF0
                dc.w    $E00F, $0809, $FFF0
                dc.w    $000F, $0009, $FFF0
                dc.w    $200F, $0809, $FFF0
                dc.w    $400F, $0009, $FFF0
                dc.w    $600F, $0809, $FFF0                                                                                                                                                                
;===============================================================================
; Objeto 0x2F - Miscelânea de objetos - Suporte das pontes na Angel Island,
; <<<-          postes na Angel Island, Hydrocity, Launch Base etc... 
;===============================================================================  