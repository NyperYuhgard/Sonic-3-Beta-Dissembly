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