; ===========================================================================
; ---------------------------------------------------------------------------
; Object 84 - Hey Ho (Mushroom Valley Miniboss)
; ---------------------------------------------------------------------------
; Offset_0x040704: Obj_0x84_MVz_Hey_Ho:
Obj84_HeyHo:
		moveq	#0,d0
		move.b	Obj_Routine(a0),d0
		move.w	HeyHo_Index(pc,d0.w),d1
		jsr	HeyHo_Index(pc,d1.w)
		jmp	(DisplaySprite).l
; ===========================================================================
; Offset_0x040718:
HeyHo_Index:	offsetTable
		offsetTableEntry.w HeyHo_Init
		offsetTableEntry.w HeyHo_Main
; ===========================================================================
; Offset_0x04071C:
HeyHo_Init:
		lea	HeyHo_ObjData(pc),a1
		jsr	Object_Settings(pc)
		move.l	#Offset_0x040840,Obj_Child_Data(a0)
		lea	HeyHo_ObjArray(pc),a2
		jmp	Load_Child_Object_A2(pc)

Offset_0x040734:
		rts
; ===========================================================================
; Offset_0x040736:
HeyHo_Main:
		jmp	Animate_Raw_Multi_Delay(pc)
; ===========================================================================

Offset_0x04073A:
		lea	HeyHo_ObjData2(pc),a1
		jsr	Object_Settings_2(pc)
		move.l	#Offset_0x04074A,(a0)
		rts
; ===========================================================================

Offset_0x04074A:
		btst	#0,(Vint_runcount+3).w
		bne.w	Offset_0x040734
		bsr.w	Offset_0x040760
		jsr	Refresh_Child_Position_Adjusted(pc)
		jmp	Child_Display_Touch_Or_Delete(pc)
; ---------------------------------------------------------------------------

Offset_0x040760:
		move.w	Obj_Child_Ref(a0),a1
		moveq	#0,d0
		move.b	Obj_Map_Id(a1),d0
		move.b	HeyHo_MapFrames(pc,d0.w),Obj_Map_Id(a0)
		add.w	d0,d0
		move.w	d0,d1
		lea	HeyHo_Priority(pc,d0.w),a2
		move.w	(a2)+,Obj_Priority(a0)
		add.w	d1,d1
		add.b	Obj_Subtype(a0),d1
		lea	HeyHo_Position(pc,d1.w),a2
		move.w	(a2)+,Obj_Control_Var_12(a0)
		rts

; ===========================================================================
; Offset_0x04078C:
HeyHo_MapFrames:
		dc.b	$14, $14, $14, $14, $14, $15, $14, $14
		dc.b	$14, $14, $14, $14, $14, $14, $14, $14
		dc.b	$14, $14, $14, $14
; ---------------------------------------------------------------------------
; Offset_0x0407A0:
HeyHo_Position:
		dc.b	$0B, $1C, $01, $1C, $0B, $1C, $01, $1C
		dc.b	$0B, $1C, $01, $1C, $0B, $1C, $01, $1C
		dc.b	$F8, $1C, $FF, $1C, $E8, $12, $EF, $12
		dc.b	$F8, $1C, $FF, $1C, $EF, $1C, $F6, $1C
		dc.b	$F8, $1C, $FF, $1C, $EF, $1C, $F6, $1C
		dc.b	$F8, $1C, $0B, $1C, $F8, $1B, $0B, $1B
		dc.b	$F8, $1C, $0B, $1C, $F8, $1C, $0B, $1C
		dc.b	$F8, $1C, $FF, $1C, $F0, $1C, $F7, $1C
		dc.b	$EF, $1C, $F6, $1C, $F8, $1C, $0B, $1C
		dc.b	$0C, $1C, $06, $1C, $0B, $1C, $01, $1C
; ---------------------------------------------------------------------------
; Offset_0x0407F0:
HeyHo_Priority:
		dc.w	$300,$300,$300,$300,$300,$300,$300,$300
		dc.w	$300,$300,$200,$200,$200,$200,$300,$300
		dc.w	$300,$200,$300,$300

; ===========================================================================
; Offset_0x040818: Hey_Ho_Setup_Data:
HeyHo_ObjData:
		dc.l	Hey_Ho_Mappings
		dc.w	$A380, $280
		dc.b	$20,$20,  0,  0
; Offset_0x040824: Hey_Ho_Setup_Data_2:
HeyHo_ObjData2:	dc.w	$8380, $300
		dc.b	$20,$20,$14,  0

; Offset_0x04082C:
HeyHo_ObjArray:
		dc.w	$0001
		dc.l	Offset_0x04073A
		dc.b	$00, $00
		dc.l	Offset_0x04073A
		dc.b	$00, $00

; ---------------------------------------------------------------------------
; Offset_0x04083A:
		dc.b	$07, $00, $01, $02, $03, $FC
; ---------------------------------------------------------------------------

Offset_0x040840:
		dc.b	$04, $27, $04, $01, $06, $01, $08, $01
		dc.b	$0B, $01, $0C, $27, $0A, $01, $08, $01
		dc.b	$06, $01, $04, $27, $06, $01, $08, $01
		dc.b	$0C, $27, $0A, $02, $0E, $03, $0F, $07
		dc.b	$10, $07, $0F, $07, $10, $07, $0F, $07
		dc.b	$10, $31, $09, $01, $07, $01, $FC, $00
; ---------------------------------------------------------------------------
; Offset_0x040870:
Hey_Ho_Mappings:
		dc.w	Offset_0x04089C-Hey_Ho_Mappings
		dc.w	Offset_0x040934-Hey_Ho_Mappings
		dc.w	Offset_0x0409CC-Hey_Ho_Mappings
		dc.w	Offset_0x040A64-Hey_Ho_Mappings
		dc.w	Offset_0x040AFC-Hey_Ho_Mappings
		dc.w	Offset_0x040B64-Hey_Ho_Mappings
		dc.w	Offset_0x040BCC-Hey_Ho_Mappings
		dc.w	Offset_0x040C2E-Hey_Ho_Mappings
		dc.w	Offset_0x040C90-Hey_Ho_Mappings
		dc.w	Offset_0x040CE0-Hey_Ho_Mappings
		dc.w	Offset_0x040D30-Hey_Ho_Mappings
		dc.w	Offset_0x040D80-Hey_Ho_Mappings
		dc.w	Offset_0x040DD0-Hey_Ho_Mappings
		dc.w	Offset_0x040E14-Hey_Ho_Mappings
		dc.w	Offset_0x040E64-Hey_Ho_Mappings
		dc.w	Offset_0x040EA8-Hey_Ho_Mappings
		dc.w	Offset_0x040EEC-Hey_Ho_Mappings
		dc.w	Offset_0x040F30-Hey_Ho_Mappings
		dc.w	Offset_0x040F6E-Hey_Ho_Mappings
		dc.w	Offset_0x040FE2-Hey_Ho_Mappings
		dc.w	Offset_0x041068-Hey_Ho_Mappings
		dc.w	Offset_0x041070-Hey_Ho_Mappings
Offset_0x04089C:
		dc.w    $0019
		dc.w    $1804, $006F, $0002
		dc.w    $2009, $0071, $FFFA
		dc.w    $F80A, $004C, $0002
		dc.w    $0804, $0055, $000A
		dc.w    $1009, $0057, $0002
		dc.w    $0805, $0063, $000A
		dc.w    $F001, $00D4, $FFFB
		dc.w    $F005, $00CE, $FFF2
		dc.w    $F005, $00CA, $FFF2
		dc.w    $E804, $00D8, $FFF2
		dc.w    $E80F, $0011, $FFF4
		dc.w    $F002, $0021, $FFEC
		dc.w    $0801, $0024, $FFEC
		dc.w    $080D, $0026, $FFF4
		dc.w    $1804, $0067, $FFE2
		dc.w    $2009, $0069, $FFDA
		dc.w    $F80A, $004C, $FFE2
		dc.w    $0804, $0055, $FFEA
		dc.w    $1009, $0057, $FFE2
		dc.w    $0805, $0063, $FFEA
		dc.w    $100B, $008D, $FFCA
		dc.w    $3009, $0099, $FFCA
		dc.w    $2600, $0077, $FFF2
		dc.w    $2600, $0077, $0012
		dc.w    $0005, $00DA, $0003
Offset_0x040934:
		dc.w    $0019
		dc.w    $1904, $006F, $0002
		dc.w    $2109, $0071, $FFFA
		dc.w    $F80A, $004C, $0002
		dc.w    $0904, $0055, $000A
		dc.w    $1109, $0057, $0002
		dc.w    $0905, $0063, $000A
		dc.w    $F001, $00D4, $FFFB
		dc.w    $F005, $00CE, $FFF2
		dc.w    $F005, $00CA, $FFF2
		dc.w    $E804, $00D8, $FFF2
		dc.w    $E80F, $0011, $FFF4
		dc.w    $F002, $0021, $FFEC
		dc.w    $0801, $0024, $FFEC
		dc.w    $080D, $0026, $FFF4
		dc.w    $1904, $0067, $FFE2
		dc.w    $2109, $0069, $FFDA
		dc.w    $F80A, $004C, $FFE2
		dc.w    $0904, $0055, $FFEA
		dc.w    $1109, $0057, $FFE2
		dc.w    $0905, $0063, $FFEA
		dc.w    $110B, $008D, $FFCA
		dc.w    $3109, $0099, $FFCA
		dc.w    $2700, $0077, $FFF2
		dc.w    $2700, $0077, $0012
		dc.w    $0005, $00DA, $0003
Offset_0x0409CC:
		dc.w    $0019
		dc.w    $1A04, $006F, $0002
		dc.w    $2209, $0071, $FFFA
		dc.w    $F80A, $004C, $0002
		dc.w    $0A04, $0055, $000A
		dc.w    $1209, $0057, $0002
		dc.w    $0905, $0063, $000A
		dc.w    $F001, $00D4, $FFFB
		dc.w    $F005, $00CE, $FFF2
		dc.w    $F005, $00CA, $FFF2
		dc.w    $E804, $00D8, $FFF2
		dc.w    $E80F, $0011, $FFF4
		dc.w    $F002, $0021, $FFEC
		dc.w    $0801, $0024, $FFEC
		dc.w    $080D, $0026, $FFF4
		dc.w    $1A04, $0067, $FFE2
		dc.w    $2209, $0069, $FFDA
		dc.w    $F80A, $004C, $FFE2
		dc.w    $0A04, $0055, $FFEA
		dc.w    $1209, $0057, $FFE2
		dc.w    $0905, $0063, $FFEA
		dc.w    $120B, $008D, $FFCA
		dc.w    $3209, $0099, $FFCA
		dc.w    $2800, $0077, $FFF2
		dc.w    $2800, $0077, $0012
		dc.w    $0005, $00DA, $0003
Offset_0x040A64:
		dc.w    $0019
		dc.w    $1B04, $006F, $0002
		dc.w    $2309, $0071, $FFFA
		dc.w    $F80A, $004C, $0002
		dc.w    $0B04, $0055, $000A
		dc.w    $1309, $0057, $0002
		dc.w    $0905, $0063, $000A
		dc.w    $F001, $00D4, $FFFB
		dc.w    $F005, $00CE, $FFF2
		dc.w    $F005, $00CA, $FFF2
		dc.w    $E804, $00D8, $FFF2
		dc.w    $E80F, $0011, $FFF4
		dc.w    $F002, $0021, $FFEC
		dc.w    $0801, $0024, $FFEC
		dc.w    $080D, $0026, $FFF4
		dc.w    $1B04, $0067, $FFE2
		dc.w    $2309, $0069, $FFDA
		dc.w    $F80A, $004C, $FFE2
		dc.w    $0B04, $0055, $FFEA
		dc.w    $1309, $0057, $FFE2
		dc.w    $0905, $0063, $FFEA
		dc.w    $130B, $008D, $FFCA
		dc.w    $3309, $0099, $FFCA
		dc.w    $2900, $0077, $FFF2
		dc.w    $2900, $0077, $0012
		dc.w    $0005, $00DA, $0003
Offset_0x040AFC:
		dc.w    $0011
		dc.w    $F008, $0082, $0000
		dc.w    $F80D, $0085, $0000
		dc.w    $F005, $0078, $FFF0
		dc.w    $0009, $007C, $FFE8
		dc.w    $E00E, $00E3, $FFB8
		dc.w    $F808, $00EF, $FFC0
		dc.w    $F000, $00E2, $FFD8
		dc.w    $F100, $00E2, $FFE0
		dc.w    $F200, $00E2, $FFE8
		dc.w    $E805, $00BC, $0003
		dc.w    $FC00, $00C8, $000B
		dc.w    $E80E, $002E, $FFE8
		dc.w    $F005, $003A, $0008
		dc.w    $0001, $003E, $FFF0
		dc.w    $000E, $0040, $FFF8
		dc.w    $0005, $00DA, $FFF0
		dc.w    $0005, $00DA, $FFF7
Offset_0x040B64:
		dc.w    $0011
		dc.w    $F008, $0082, $0000
		dc.w    $F80D, $0085, $0000
		dc.w    $F005, $0078, $FFF0
		dc.w    $0009, $007C, $FFE8
		dc.w    $E00E, $00E3, $FFB8
		dc.w    $F808, $00EF, $FFC0
		dc.w    $F000, $00E2, $FFD8
		dc.w    $F100, $00E2, $FFE0
		dc.w    $F200, $00E2, $FFE8
		dc.w    $E805, $00BC, $0003
		dc.w    $F800, $00C8, $0011
		dc.w    $E80E, $002E, $FFE8
		dc.w    $F005, $003A, $0008
		dc.w    $0001, $003E, $FFF0
		dc.w    $000E, $0040, $FFF8
		dc.w    $0005, $00DE, $FFED
		dc.w    $0005, $00DE, $FFF4
Offset_0x040BCC:
		dc.w    $0010
		dc.w    $F308, $0082, $0008
		dc.w    $FB0D, $0085, $0008
		dc.w    $F305, $0078, $FFF8
		dc.w    $0309, $007C, $FFF0
		dc.w    $E805, $00BC, $0003
		dc.w    $F800, $00C8, $0011
		dc.w    $E50E, $00E3, $FFC8
		dc.w    $FD08, $00EF, $FFD0
		dc.w    $F500, $00E2, $FFE8
		dc.w    $F600, $00E2, $FFF0
		dc.w    $E80E, $002E, $FFE8
		dc.w    $F005, $003A, $0008
		dc.w    $0001, $003E, $FFF0
		dc.w    $000E, $0040, $FFF8
		dc.w    $0005, $00DA, $FFF0
		dc.w    $0005, $00DA, $FFF7
Offset_0x040C2E:
		dc.w    $0010
		dc.w    $F308, $0082, $FFFF
		dc.w    $FB0D, $0085, $FFFF
		dc.w    $F305, $0078, $FFEF
		dc.w    $0309, $007C, $FFE7
		dc.w    $E805, $00C4, $FFFA
		dc.w    $F800, $00C8, $0008
		dc.w    $E50E, $00E3, $FFBF
		dc.w    $FD08, $00EF, $FFC7
		dc.w    $F500, $00E2, $FFDF
		dc.w    $F600, $00E2, $FFE7
		dc.w    $E80E, $002E, $FFDF
		dc.w    $F005, $003A, $FFFF
		dc.w    $0001, $003E, $FFE7
		dc.w    $000E, $0040, $FFEF
		dc.w    $0005, $00DA, $FFE7
		dc.w    $0005, $00DA, $FFEE
Offset_0x040C90:
		dc.w    $000D
		dc.w    $E80E, $00E3, $FFE8
		dc.w    $0008, $00EF, $FFF0
		dc.w    $F800, $00E2, $0008
		dc.w    $F805, $0078, $0010
		dc.w    $0809, $007C, $0008
		dc.w    $E805, $00BC, $0003
		dc.w    $F800, $00C8, $0011
		dc.w    $E80E, $002E, $FFE8
		dc.w    $F005, $003A, $0008
		dc.w    $0001, $003E, $FFF0
		dc.w    $000E, $0040, $FFF8
		dc.w    $0005, $00DA, $FFF0
		dc.w    $0005, $00DA, $FFF7
Offset_0x040CE0:
		dc.w    $000D
		dc.w    $E80E, $00E3, $FFDF
		dc.w    $0008, $00EF, $FFE7
		dc.w    $F800, $00E2, $FFFF
		dc.w    $F805, $0078, $0007
		dc.w    $0809, $007C, $FFFF
		dc.w    $E805, $00C4, $FFFA
		dc.w    $F800, $00C8, $0008
		dc.w    $E80E, $002E, $FFDF
		dc.w    $F005, $003A, $FFFF
		dc.w    $0001, $003E, $FFE7
		dc.w    $000E, $0040, $FFEF
		dc.w    $0005, $00DA, $FFE7
		dc.w    $0005, $00DA, $FFEE
Offset_0x040D30:
		dc.w    $000D
		dc.w    $F80A, $004C, $0008
		dc.w    $0005, $00DA, $FFF0
		dc.w    $0005, $00DA, $0003
		dc.w    $E80B, $0000, $FFE8
		dc.w    $0808, $000C, $FFE8
		dc.w    $1004, $000F, $FFF0
		dc.w    $E80B, $0800, $0000
		dc.w    $0808, $080C, $0000
		dc.w    $1004, $080F, $0000
		dc.w    $F80A, $004C, $FFE4
		dc.w    $FE0A, $00AD, $0000
		dc.w    $0609, $00B6, $0018
		dc.w    $EB00, $00C9, $FFFC
Offset_0x040D80:
		dc.w    $000D
		dc.w    $F70A, $004C, $0008
		dc.w    $FF05, $00DA, $FFF0
		dc.w    $FF05, $00DA, $0003
		dc.w    $E70B, $0000, $FFE8
		dc.w    $0708, $000C, $FFE8
		dc.w    $0F04, $000F, $FFF0
		dc.w    $E70B, $0800, $0000
		dc.w    $0708, $080C, $0000
		dc.w    $0F04, $080F, $0000
		dc.w    $F70A, $004C, $FFE4
		dc.w    $FD0A, $00AD, $0000
		dc.w    $0509, $00B6, $0018
		dc.w    $EA00, $00C9, $FFFC
Offset_0x040DD0:
		dc.w    $000B
		dc.w    $0005, $00DA, $FFF0
		dc.w    $0005, $00DA, $0003
		dc.w    $E80B, $0000, $FFE8
		dc.w    $0808, $000C, $FFE8
		dc.w    $1004, $000F, $FFF0
		dc.w    $E80B, $0800, $0000
		dc.w    $0808, $080C, $0000
		dc.w    $1004, $080F, $0000
		dc.w    $F80A, $004C, $FFE0
		dc.w    $F80A, $084C, $0008
		dc.w    $EB00, $00C9, $FFFC
Offset_0x040E14:
		dc.w    $000D
		dc.w    $0005, $00DA, $FFF0
		dc.w    $0005, $00DA, $0003
		dc.w    $E80B, $0000, $FFE8
		dc.w    $0808, $000C, $FFE8
		dc.w    $1004, $000F, $FFF0
		dc.w    $E80B, $0800, $0000
		dc.w    $0808, $080C, $0000
		dc.w    $1004, $080F, $0000
		dc.w    $F80A, $004C, $FFE0
		dc.w    $F80A, $084C, $0008
		dc.w    $FE0A, $00AD, $0000
		dc.w    $0609, $00B6, $0018
		dc.w    $EB00, $00C9, $FFFC
Offset_0x040E64:
		dc.w    $000B
		dc.w    $F80A, $004C, $0008
		dc.w    $E805, $00BC, $0003
		dc.w    $F800, $00C8, $0011
		dc.w    $E80E, $002E, $FFE8
		dc.w    $F005, $003A, $0008
		dc.w    $0001, $003E, $FFF0
		dc.w    $000E, $0040, $FFF8
		dc.w    $FE0A, $00AD, $000D
		dc.w    $0609, $00B6, $001F
		dc.w    $0005, $00DA, $FFF0
		dc.w    $0005, $00DA, $FFF7
Offset_0x040EA8:
		dc.w    $000B
		dc.w    $F80A, $004C, $FFF8
		dc.w    $0005, $0063, $FFFF
		dc.w    $E805, $00C0, $FFFB
		dc.w    $E80E, $002E, $FFE0
		dc.w    $F005, $003A, $0000
		dc.w    $0001, $003E, $FFE8
		dc.w    $000E, $0040, $FFF0
		dc.w    $FE0A, $00AD, $0006
		dc.w    $0609, $00B6, $001E
		dc.w    $0005, $00DA, $FFE8
		dc.w    $0005, $00DA, $FFEF
Offset_0x040EEC:
		dc.w    $000B
		dc.w    $F80A, $004C, $FFF6
		dc.w    $0005, $0063, $FFFD
		dc.w    $FE0A, $00AD, $0005
		dc.w    $0609, $00B6, $001D
		dc.w    $E805, $00C4, $FFFA
		dc.w    $E80E, $002E, $FFDF
		dc.w    $F005, $003A, $FFFF
		dc.w    $0001, $003E, $FFE7
		dc.w    $000E, $0040, $FFEF
		dc.w    $0005, $00DA, $FFE7
		dc.w    $0005, $00DA, $FFEE
Offset_0x040F30:
		dc.w    $000A
		dc.w    $F80A, $004C, $FFE4
		dc.w    $0005, $00DA, $FFF0
		dc.w    $0005, $00DA, $0003
		dc.w    $E80B, $0000, $FFE8
		dc.w    $0808, $000C, $FFE8
		dc.w    $1004, $000F, $FFF0
		dc.w    $E80B, $0800, $0000
		dc.w    $0808, $080C, $0000
		dc.w    $1004, $080F, $0000
		dc.w    $F80A, $084C, $0004
Offset_0x040F6E:
		dc.w    $0013
		dc.w    $1804, $006F, $FFF9
		dc.w    $2009, $0071, $FFF1
		dc.w    $0804, $0055, $0001
		dc.w    $1009, $0057, $FFF9
		dc.w    $F80A, $004C, $FFF9
		dc.w    $0805, $0063, $0000
		dc.w    $E80E, $082E, $FFF8
		dc.w    $F005, $083A, $FFE8
		dc.w    $0001, $083E, $0008
		dc.w    $000E, $0840, $FFE8
		dc.w    $1804, $0067, $FFE1
		dc.w    $2009, $0069, $FFD9
		dc.w    $0804, $0055, $FFE9
		dc.w    $1009, $0057, $FFE1
		dc.w    $F80A, $004C, $FFE1
		dc.w    $100B, $008D, $FFD3
		dc.w    $3009, $0099, $FFD3
		dc.w    $0005, $00DA, $0004
		dc.w    $0005, $00DA, $FFFE
Offset_0x040FE2:
		dc.w    $0016
		dc.w    $1804, $006F, $0002
		dc.w    $2009, $0071, $FFFA
		dc.w    $F80A, $004C, $0002
		dc.w    $0804, $0055, $000A
		dc.w    $1009, $0057, $0002
		dc.w    $0805, $0063, $000A
		dc.w    $F001, $00D4, $FFFB
		dc.w    $E80F, $0011, $FFF4
		dc.w    $F002, $0021, $FFEC
		dc.w    $0801, $0024, $FFEC
		dc.w    $080D, $0026, $FFF4
		dc.w    $1804, $0067, $FFE2
		dc.w    $2009, $0069, $FFDA
		dc.w    $F80A, $004C, $FFE2
		dc.w    $0804, $0055, $FFEA
		dc.w    $1009, $0057, $FFE2
		dc.w    $0805, $0063, $FFEA
		dc.w    $100B, $008D, $FFCA
		dc.w    $3009, $0099, $FFCA
		dc.w    $2600, $0077, $FFF2
		dc.w    $2600, $0077, $0012
		dc.w    $0005, $00DA, $0003
Offset_0x041068:
		dc.w    $0001
		dc.w    $F406, $009F, $FFF8
Offset_0x041070:
		dc.w    $0002
		dc.w    $F404, $00A5, $FFFC
		dc.w    $FC09, $00A7, $FFF4

;===============================================================================
; Objeto 0x84 - Mini chefe na Mushroom Valley
; <<<- 
;===============================================================================  