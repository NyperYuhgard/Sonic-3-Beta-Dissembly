; ===========================================================================
; ---------------------------------------------------------------------------
; Object - Title Card
; ---------------------------------------------------------------------------
; Offset_0x024546: Obj_Title_Cards:
Obj_TitleCard:
		moveq	#0,d0
		move.b	Obj_Routine(a0),d0
		move.w	TitleCard_Index(pc,d0.w),d1
		jmp	TitleCard_Index(pc,d1.w)				 
; ===========================================================================
; Offset_0x024554:
TitleCard_Index:	offsetTable
		offsetTableEntry.w TitleCard_Init
		offsetTableEntry.w TitleCard_Main
		offsetTableEntry.w TitleCard_Wait
		offsetTableEntry.w TitleCard_Wait2
; ===========================================================================
; Offset_0x02455C:
TitleCard_Init:
		lea	(Title_Card_ZONE_ACT).l,a1
		move.w	#$A000,d2
		jsr	(Queue_Kos_Module).l
		lea	(Title_Card_Number_1).l,a1
		tst.b	(Apparent_Act).w			; is this "Act 2"?
		beq.s	Offset_0x02457E				; if not, branch
		lea	(Title_Card_Number_2).l,a1

Offset_0x02457E:
		move.w	#$A7A0,d2
		jsr	(Queue_Kos_Module).l
		lea	TitleCard_LevelGfx(pc),a1
		moveq	#0,d0
		move.b	(Apparent_Zone).w,d0			; load title card based on zone
		lsl.w	#2,d0
		move.l	(a1,d0.w),a1
		move.w	#$A9A0,d2
		jsr	(Queue_Kos_Module).l
		move.w	#90,Obj_Timer(a0)			; set wait timer to 90 frames
		move.w	#4,Obj_Control_Var_00(a0)
		clr.w	Obj_Control_Var_02(a0)
		addq.b	#2,Obj_Routine(a0)
		rts
; ===========================================================================
; Offset_0x0245B8:
TitleCard_Main:
		tst.b	(Kosinski_Modules_Left).w		; has the KosinskiM art finished decompressing?
		bne.s	Offset_0x02461E				; if not, branch
		jsr	(AllocateObjectAfterCurrent).l
		bne.s	Offset_0x02461E
		lea	TitleCard_ObjArray(pc),a2
		moveq	#(TitleCard_ObjArray_End-TitleCard_ObjArray)/14-1,d1	; create objects
; Offset_0x0245CC:
TitleCard_MakeObject:
		move.l	(a2)+,(a1)
		move.w	(a2)+,Obj_Control_Var_16(a1)
		move.w	(a2)+,Obj_X(a1)
		move.w	(a2)+,Obj_Y(a1)
		move.b	(a2)+,Obj_Map_Id(a1)
		move.b	(a2)+,Obj_Width(a1)
		move.w	(a2)+,d2
		move.b	d2,Obj_Col_Flags(a1)
		move.b	#$40,Obj_Flags(a1)
		move.l	#Title_Cards_Mappings,Obj_Map(a1)
		move.w	a0,Obj_Respaw_Ref(a1)
		jsr	(AllocateObject_Immediate).l
		dbne	d1,TitleCard_MakeObject
		tst.w	Obj_Control_Var_0E(a0)
		beq.s	Offset_0x02461A
		move.b	(Apparent_Zone).w,d0
		beq.s	Offset_0x02461A
		cmpi.b	#Iz_Id,d0				; are we in IceCap Zone?
		beq.s	Offset_0x02461A				; if not, branch
		st	(Level_Events_Buffer_5).w

Offset_0x02461A:
		addq.b	#2,Obj_Routine(a0)

Offset_0x02461E:
		rts
; ===========================================================================
; Offset_0x024620:
TitleCard_Wait:
		tst.w	Obj_Control_Var_04(a0)
		beq.s	Offset_0x02462C
		clr.w	Obj_Control_Var_04(a0)
		rts
; ---------------------------------------------------------------------------

Offset_0x02462C:
		st	Obj_Respaw_Ref(a0)
		addq.b	#2,Obj_Routine(a0)
		rts
; ===========================================================================
; Offset_0x024636:
TitleCard_Wait2:
		tst.w	Obj_Timer(a0)
		beq.s	Offset_0x024642
		subq.w	#1,Obj_Timer(a0)
		rts
; ---------------------------------------------------------------------------

Offset_0x024642:
		tst.w	Obj_Control_Var_00(a0)
		beq.s	TitleCard_SetupLevel
		addq.w	#1,Obj_Control_Var_02(a0)
		rts
; ---------------------------------------------------------------------------
; Offset_0x02464E:
TitleCard_SetupLevel:
		tst.w	Obj_Control_Var_0E(a0)
		beq.s	TitleCard_LoadMainGraphics
		clr.l	(Timer).w
		clr.w	(Ring_count).w
		clr.w	(Total_Ring_Count_Address).w
		clr.b	(Extra_life_flags).w
		clr.l	(Time_Count_Address_P2).w
		clr.w	(Ring_Count_Address_P2).w
		clr.w	(Total_Ring_Count_Address_P2).w
		clr.b	(Ring_Status_Flag_P2).w
		st	(Update_HUD_timer).w
		st	(Update_HUD_rings).w
		st	(End_Level_Flag).w
		bra.s	TitleCard_LoadAnimals
; Offset_0x024682:
TitleCard_LoadMainGraphics:
		lea	(PLC_Spikes_Springs).l,a1
		jsr	(LoadPLC_Direct).l
; Offset_0x02468E:
TitleCard_LoadAnimals:
		move.w	(Apparent_ZoneAndAct).w,d0
		jsr	Level_Load_Enemies_Art(pc)		; load animals based on zone
		moveq	#2,d0
		jsr	(LoadPLC)
		jmp	(DeleteObject)

; ===========================================================================
; ---------------------------------------------------------------------------
; Object - Title Card Red Bar
; ---------------------------------------------------------------------------
; Offset_0x0246A4: Title_Card_Red_Bar:
Obj_TtlCardRedBar:
		move.w	Obj_Respaw_Ref(a0),a1
		move.w	Obj_Control_Var_02(a1),d0
		beq.s	Offset_0x0246CC
		tst.b	Obj_Flags(a0)
		bmi.s	Offset_0x0246BE
		subq.w	#1,Obj_Control_Var_00(a1)
		jmp	(DeleteObject).l

Offset_0x0246BE:
		cmp.b	Obj_Col_Flags(a0),d0
		bcs.s	Offset_0x0246E2
		subi.w	#$20,Obj_Y(a0)
		bra.s	Offset_0x0246E2

Offset_0x0246CC:
		move.w	Obj_Y(a0),d0
		cmp.w	Obj_Control_Var_16(a0),d0
		beq.s	Offset_0x0246E2
		addi.w	#$10,d0
		move.w	d0,Obj_Y(a0)
		st	Obj_Control_Var_04(a1)

Offset_0x0246E2:
		move.b	#$70,Obj_Height(a0)
		jmp	(DisplaySprite).l

; ---------------------------------------------------------------------------
; Object - Title Card Level Name
; ---------------------------------------------------------------------------
; Offset_0x0246EE: Title_Card_Level_Name:
Obj_TtlCardName:
		move.b	(Apparent_Zone).w,d0
		add.b	d0,Obj_Map_Id(a0)
		move.l	#Obj_TtlCardZone,(a0)

; ---------------------------------------------------------------------------
; Object - Title Card Zone
; ---------------------------------------------------------------------------
; Offset_0x0246FC: Title_Card_Zone:
Obj_TtlCardZone:
		move.w	Obj_Respaw_Ref(a0),a1
		move.w	Obj_Control_Var_02(a1),d0
		beq.s	Offset_0x024724
		tst.b	Obj_Flags(a0)
		bmi.s	Offset_0x024716
		subq.w	#1,Obj_Control_Var_00(a1)
		jmp	(DeleteObject).l
; ---------------------------------------------------------------------------

Offset_0x024716:
		cmp.b	Obj_Col_Flags(a0),d0
		bcs.s	Offset_0x02473A
		addi.w	#$20,Obj_X(a0)
		bra.s	Offset_0x02473A

Offset_0x024724:
		move.w	Obj_X(A0),d0
		cmp.w	Obj_Control_Var_16(a0),d0
		beq.s	Offset_0x02473A
		subi.w	#$10,d0
		move.w	d0,Obj_X(a0)
		st	Obj_Control_Var_04(a1)

Offset_0x02473A:
		jmp	(DisplaySprite).l

; ---------------------------------------------------------------------------
; Object - Title Card Act
; ---------------------------------------------------------------------------
; Offset_0x024740: Title_Card_Act_Number:
Obj_TtlCardAct:
		move.l	#Obj_TtlCardZone,(a0)
		move.b	(Apparent_Zone).w,d0
		cmpi.b	#$A,d0
		beq.s	Offset_0x024756
		cmpi.b	#$C,d0
		bne.s	Obj_TtlCardZone

Offset_0x024756:
		move.w	Obj_Respaw_Ref(a0),a1
		subq.w	#1,Obj_Control_Var_00(a1)
		jmp	(DeleteObject).l									
; ===========================================================================
; Offset_0x024764: Title_Card_Letters_Ptr:
TitleCard_LevelGfx:
		dc.l	TC_Angel_Island
		dc.l	TC_Hidrocity
		dc.l	TC_Marble_Garden
		dc.l	TC_Carnival_Night
		dc.l	TC_Flying_Battery
		dc.l	TC_Icecap
		dc.l	TC_Launch_Base
		dc.l	TC_Launch_Base
		dc.l	TC_Launch_Base
		dc.l	TC_Launch_Base
		dc.l	TC_Launch_Base
		dc.l	TC_Launch_Base
		dc.l	TC_Launch_Base
; ===========================================================================

ttlResObjData macro obj,xdest,xpos,ypos,frame,width,place
	dc.l	obj
	dc.w	xdest
	dc.w	xpos
	dc.w	ypos
	dc.b	frame
	dc.b	width
	dc.w	place
	endm

; Offset_0x024798: Title_Cards_Conf_Ptr:
TitleCard_ObjArray:
		ttlresObjData Obj_TtlCardName,		$120, $260, $E0,  4,$80,3	; Zone Name
		ttlresObjData Obj_TtlCardZone,		$17C, $2FC,$100,  3,$24,5	; "ZONE"
		ttlresObjData Obj_TtlCardAct,		$184, $344,$120,  2,$1C,7	; "ACT X"
		ttlresObjData Obj_TtlCardRedBar,	 $C0,  $E0, $10,  1,  0,1	; Red Bar
TitleCard_ObjArray_End: