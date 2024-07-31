; ===========================================================================
; ---------------------------------------------------------------------------
; Object C5 - Hidden Moniters
; ---------------------------------------------------------------------------
; Offset_0x04178A: Obj_0xC5_Hidden_Monitors:
ObjC5_HiddenMonitor:
		lea	HiddenMonitor_ObjData(pc),a1
		jsr	Object_Settings(pc)
		move.l	#HiddenMonitor_Main,(a0)
		move.b	#$F,Obj_Height_2(a0)
		move.b	#$F,Obj_Width_2(a0)
		move.b	#$46,Obj_Col_Flags(a0)
		move.b	Obj_Subtype(a0),Obj_Ani_Number(a0)
		rts
; ===========================================================================
; Offset_0x0417B2:
HiddenMonitor_Main:
		move.w	(Obj_End_Panel_Mem_Address).w,a1
		cmpi.l	#Obj_End_Panel,(a1)
		bne.s	Offset_0x0417FC
		btst	#0,Obj_Control_Var_08(a1)
		beq.s	Offset_0x0417FC
		move.w	Obj_X(a0),d0
		move.w	Obj_X(a1),d1
		lea	Offset_0x041802(pc),a2
		add.w	(a2)+,d0
		cmp.w	d0,d1
		bcs.s	Offset_0x0417FC
		add.w	(a2)+,d0
		cmp.w	d0,d1
		bcc.s	Offset_0x0417FC
		bclr	#0,Obj_Control_Var_08(a1)
		move.l	#Obj01_Monitors,(a0)
		move.b	#2,Obj_Routine(a0)
		move.b	#4,Obj_Control_Var_0C(a0)
		move.w	#-$400,Obj_Speed_Y(a0)

Offset_0x0417FC:
		jmp     (MarkObjGone).l
; ===========================================================================

Offset_0x041802:	dc.w	-$E,$1C

; Offset_0x041806: Hidden_Monitors_Setup_Data:
HiddenMonitor_ObjData:
		dc.l	Monitors_Mappings
		dc.w	$4C4
		dc.w	$180
		dc.b	 $E,$10,  0,  0