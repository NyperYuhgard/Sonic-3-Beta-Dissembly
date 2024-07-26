; tells the Z80 to stop, and waits for it to finish stopping (acquire bus)
stopZ80 macro
	move.w	#$100,(Z80_Bus_Request).l	; stop the Z80
@loop:	btst	#0,(Z80_Bus_Request).l
	bne.s	@loop				; loop until it says it has stopped
    endm

; tells the Z80 to start again
startZ80 macro
	move.w	#0,(Z80_Bus_Request).l    ; start the Z80
    endm

; macro to declare a little-endian 16-bit pointer for the Z80 sound driver
rom_ptr_z80 macro addr
	dc.w	(((addr>>8)|(addr<<8))&$FFFF)
    endm

; we don't have bytesToLcnt or bytesToWcnt yet, so here's examples of when they are used
; bytesToLcnt
; #(XX>>2-YY>>2)-1
; bytesToWcnt
; #(XX>>1-YY>>1)-1

; macro to declare an offset table
offsetTable macro *
\* EQU *
current_offset_table = \*
    endm

; macro to declare an entry in an offset table
offsetTableEntry macro ptr
	dc.\0 ptr-current_offset_table
    endm

; SpritePiece macros by MainMemory, converted to AXM68k's format
SonicMappingVer = 3		; say we're using Sonic 3's format

; macro to declare a mappings table (taken from Sonic 2 Hg disassembly)
mappingsTable macro *
\* EQU *
current_mappings_table = \*
    endm

; macro to declare an entry in a mappings table (taken from Sonic 2 Hg disassembly)
mappingsTableEntry macro ptr
	dc.\0 ptr-current_mappings_table
    endm

spriteHeader macro *
\* EQU *
	if SonicMappingsVer=1
	dc.b ((\*_End-\*-1)/5)
	elseif SonicMappingsVer=2
	dc.w ((\*_End-\*-2)/8)
	else
	dc.w ((\*_End-\*-2)/6)
	endif
    endm

spritePiece macro xpos,ypos,width,height,tile,xflip,yflip,pal,pri
	if SonicMappingsVer=1
	dc.b	ypos
	dc.b	(((width-1)&3)<<2)|((height-1)&3)
	dc.b	((pri&1)<<7)|((pal&3)<<5)|((yflip&1)<<4)|((xflip&1)<<3)|((tile&$700)>>8)
	dc.b	tile&$FF
	dc.b	xpos
	elseif SonicMappingsVer=2
	dc.w	((ypos&$FF)<<8)|(((width-1)&3)<<2)|((height-1)&3)
	dc.w	((pri&1)<<15)|((pal&3)<<13)|((yflip&1)<<12)|((xflip&1)<<11)|(tile&$7FF)
	dc.w	((pri&1)<<15)|((pal&3)<<13)|((yflip&1)<<12)|((xflip&1)<<11)|((tile>>1)&$7FF)
	dc.w	xpos
	else
	dc.w	((ypos&$FF)<<8)|(((width-1)&3)<<2)|((height-1)&3)
	dc.w	((pri&1)<<15)|((pal&3)<<13)|((yflip&1)<<12)|((xflip&1)<<11)|(tile&$7FF)
	dc.w	xpos
	endif
	endm

spritePiece2P macro xpos,ypos,width,height,tile,xflip,yflip,pal,pri,tile2,xflip2,yflip2,pal2,pri2
	if SonicMappingsVer=1
	dc.b	ypos
	dc.b	(((width-1)&3)<<2)|((height-1)&3)
	dc.b	((pri&1)<<7)|((pal&3)<<5)|((yflip&1)<<4)|((xflip&1)<<3)|((tile&$700)>>8)
	dc.b	tile&$FF
	dc.b	xpos
	elseif SonicMappingsVer=2
	dc.w	((ypos&$FF)<<8)|(((width-1)&3)<<2)|((height-1)&3)
	dc.w	((pri&1)<<15)|((pal&3)<<13)|((yflip&1)<<12)|((xflip&1)<<11)|(tile&$7FF)
	dc.w	((pri2&1)<<15)|((pal2&3)<<13)|((yflip2&1)<<12)|((xflip2&1)<<11)|(tile2&$7FF)
	dc.w	xpos
	else
	dc.w	((ypos&$FF)<<8)|(((width-1)&3)<<2)|((height-1)&3)
	dc.w	((pri&1)<<15)|((pal&3)<<13)|((yflip&1)<<12)|((xflip&1)<<11)|(tile&$7FF)
	dc.w	xpos
	endif
	endm

dplcHeader macro *
\* EQU *
	if SonicMappingsVer=1
	dc.b ((\*_End-\*-1)/2)
	elseif SonicMappingsVer=2
	dc.w ((\*_End-\*-2)/2)
	else
	dc.w ((\*_End-\*-4)/2)
	endif
    endm

dplcEntry macro tiles,offset
	if SonicMappingsVer=3
	dc.w	((offset&$FFF)<<4)|((tiles-1)&$F)
	else
	dc.w	(((tiles-1)&$F)<<12)|(offset&$FFF)
	endif
	endm

; I don't know why, but S3K uses Sonic 2's DPLC format for players, and its own for everything else
; So to avoid having to set and reset SonicMappingsVer I'll just make special macros
s3kPlayerDplcHeader macro *
\* EQU *
	dc.w ((\*_End-\*-2)/2)
    endm

s3kPlayerDplcEntry macro tiles,offset
	dc.w	(((tiles-1)&$F)<<12)|(offset&$FFF)
	endm