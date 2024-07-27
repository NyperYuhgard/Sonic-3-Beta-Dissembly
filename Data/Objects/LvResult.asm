; ===========================================================================
; ---------------------------------------------------------------------------
; Object - Level Results
; ---------------------------------------------------------------------------
; Offset_0x0247D0:
Obj_LevelResults:
		moveq	#0,d0
		move.b	Obj_Routine(a0),d0
		move.w	LevelResults_Index(pc,d0.w),d1
		jmp	LevelResults_Index(pc,d1.w)  
; ===========================================================================
; Offset_0x0247DE:
LevelResults_Index:	offsetTable
		offsetTableEntry.w LevelResults_Init
		offsetTableEntry.w LevelResults_Main
		offsetTableEntry.w LevelResults_Wait
		offsetTableEntry.w LevelResults_Wait2
; ===========================================================================
; Offset_0x0247E6:
LevelResults_Init:
		lea	(Title_Card_Results).l,a1
		move.w	#$A400,d2
		jsr	(Queue_Kos_Module).l
		lea	(Title_Card_Number_1).l,a1
		move.w	#$B000,d2
		tst.b	(Apparent_Act).w			; are we in "Act 2"?
		beq.s	Offset_0x024810				; if not, branch
		lea	(Title_Card_Number_2).l,a1
		move.w	#$B400,d2

Offset_0x024810:
		jsr	(Queue_Kos_Module).l
		lea	(Level_Results_Sonic).l,a1
		cmpi.w	#Sonic_Alone,(Player_Selected_Flag).w	; is this a Sonic or Sonic and Tails game?
		bls.s	Offset_0x024844				; if yes, branch
		lea	(Level_Results_Knuckles).l,a1
		cmpi.w	#Knuckles_Alone,(Player_Selected_Flag).w	; is this a Knuckles game?
		beq.s	Offset_0x024844				; if yes, branch
		lea	(Level_Results_Miles).l,a1
		tst.b	(Hardware_Id).w				; is this a Japanese console?
		beq.s	Offset_0x024844				; if yes, branch
		lea	(Level_Results_Tails).l,a1

Offset_0x024844:
		move.w	#$AC20,d2
		jsr	(Queue_Kos_Module).l
		moveq	#0,d0
		move.b	(Timer_minute).w,d0
		mulu.w	#$3C,d0
		moveq	#0,d1
		move.b	(Timer_second).w,d1
		add.w	d1,d0
		cmpi.w	#600-1,d0				; are we 1 second away from a Time Over?
		bne.s	LevelResults_TimeBonus			; if not, branch
		move.w	#10000,(Level_Results_Time_Bonus).w	; give 100000 points
		bra.s	LevelResults_RingBonus
; ---------------------------------------------------------------------------
; Offset_0x02486E:
LevelResults_TimeBonus:
		divu.w	#30,d0
		moveq	#(TimeBonuses_End-TimeBonuses)/2-1,d1
		cmp.w	d1,d0
		bcs.s	Offset_0x02487A
		move.w	d1,d0

Offset_0x02487A:
		add.w	d0,d0
		lea	TimeBonuses(pc),a1
		move.w	(a1,d0.w),(Level_Results_Time_Bonus).w
; Offset_0x024886:
LevelResults_RingBonus:
		move.w	(Ring_count).w,d0
		mulu.w	#10,d0
		move.w	d0,(Level_Results_Ring_Bonus).w
		clr.w	(Level_Results_Total_Bonus).w
		move.w	#$96,Obj_Timer(a0)
		move.w	#$C,Obj_Control_Var_00(a0)
		move.b	#$1E,(Obj_Player_One+Obj_Subtype).w
		move.b	#$1E,(Obj_Player_Two+Obj_Subtype).w
		addq.b	#2,Obj_Routine(a0)
		rts     
; ===========================================================================
; Offset_0x0248B4:
LevelResults_Main:
		subq.w	#1,Obj_Timer(a0)
		tst.b	(Kosinski_Modules_Left).w		; has the KosinskiM art finished decompressing?
		bne.s	Offset_0x02490C				; if not, branch
		jsr	(AllocateObjectAfterCurrent).l
		bne.s	Offset_0x02490C
		lea	LevelResults_ObjArray(pc),a2
		moveq	#(LevelResults_ObjArray_End-LevelResults_ObjArray)/14-1,d1	; create objects
; Offset_0x0248CC:
LevelResults_MakeObject:
		move.l	(a2)+,(a1)
		move.w	(a2)+,Obj_Control_Var_16(a1)
		move.w	(a2)+,Obj_X(a1)
		spl	Obj_Routine(a1)
		move.w	(a2)+,Obj_Y(a1)
		move.b	(a2)+,Obj_Map_Id(a1)
		move.b	(a2)+,Obj_Width(a1)
		move.w	(a2)+,d2
		move.b	d2,Obj_Col_Flags(a1)
		move.b	#$40,Obj_Flags(a1)
		move.l	#Level_Results_Mappings,Obj_Map(a1)
		move.w	a0,Obj_Respaw_Ref(a1)
		jsr	(AllocateObject_Immediate).l
		dbne	d1,LevelResults_MakeObject
		addq.b	#2,Obj_Routine(a0)

Offset_0x02490C:
		rts             
; ===========================================================================
; Offset_0x02490E:
LevelResults_Wait:
		tst.w	Obj_Timer(a0)
		beq.s	LevelResults_AddTimeBonus
		subq.w	#1,Obj_Timer(a0)
		rts
; ---------------------------------------------------------------------------
; Offset_0x02491A:
LevelResults_AddTimeBonus:
		moveq	#0,d0
		tst.w	(Level_Results_Time_Bonus).w		; are we calcuating the time bonus?
		beq.s	LevelResults_AddRingBonus		; if not, branch
		addi.w	#10,d0
		subi.w	#10,(Level_Results_Time_Bonus).w
; Offset_0x02492C:
LevelResults_AddRingBonus:
		tst.w	(Level_Results_Ring_Bonus).w		; are we calculating the ring bonus?
		beq.s	LevelResults_AddTotalBonus		; if not, branch
		addi.w	#10,d0
		subi.w	#10,(Level_Results_Ring_Bonus).w
; Offset_0x02493C:
LevelResults_AddTotalBonus:
		add.w	d0,(Level_Results_Total_Bonus).w
		tst.w	d0
		beq.s	LevelResults_SetTimer
		jsr	(Add_Points_P1).l
		move.w	(Level_Frame_Count).w,d0
		andi.w	#3,d0
		rts
; ===========================================================================
; Offset_0x024954:
LevelResults_SetTimer:
		move.w	#$3C,Obj_Timer(a0)
		addq.b	#2,Obj_Routine(a0)
; Offset_0x02495E:
LevelResults_Wait2:
		tst.w	Obj_Timer(a0)
		beq.s	Offset_0x02496A
		subq.w	#1,Obj_Timer(a0)
		rts
; ---------------------------------------------------------------------------

Offset_0x02496A:
		tst.w	Obj_Control_Var_00(a0)
		beq.s	LevelResults_EndLevel
		addq.w	#1,Obj_Control_Var_02(a0)
		rts
; ---------------------------------------------------------------------------

; Offset_0x024976:
LevelResults_EndLevel:
		tst.b	(Apparent_Act).w			; are we in "Act 2"?
		beq.s	LevelResults_LoadAct2			; if not, branch
		clr.b	(Player_Control_Lock_Flag).w
		st	(End_Level_Flag).w
		jmp	(DeleteObject).l
; Offset_0x02498A:
LevelResults_LoadAct2:
		move.b	#1,(Apparent_Act).w
		clr.b	(Player_Control_Lock_Flag).w
		move.l	#Obj_TitleCard,(a0)
		clr.b	Obj_Routine(A0)
		st	Obj_Control_Var_0E(a0)
		rts

; ===========================================================================
; ---------------------------------------------------------------------------
; Object - Character Name on the Level Results
; ---------------------------------------------------------------------------
; Offset_0x0249A4: Obj_Lvl_Res_Sonic_Miles_Knuckles_Tails:
Obj_LevResultsCharName:
		cmpi.w	#Miles_Alone,(Player_Selected_Flag).w	; is this a Tails game?
		beq.s	LevResultsCharName_Tails		; if yes, branch
		cmpi.w	#Knuckles_Alone,(Player_Selected_Flag).w	; is this a Knuckles game?
		bne.s	Offset_0x0249E4				; if not, branch
; LevResultsCharName_Knux:
		addq.b	#3,Obj_Map_Id(a0)			; use Knuckles frame
		moveq	#$30,d0
		sub.w	d0,Obj_X(a0)
		sub.w	d0,Obj_Control_Var_16(a0)
		add.b	d0,Obj_Width(a0)
		bra.s	Offset_0x0249E4
; ---------------------------------------------------------------------------
; Offset_0x0249C8:
LevResultsCharName_Tails:
		addq.b	#1,Obj_Map_Id(a0)			; use Miles frame
		tst.b	(Hardware_Id).w				; is this a Japanese console?
		bpl.s	Offset_0x0249E4				; if yes, branch
		addq.b	#1,Obj_Map_Id(a0)			; use Tails frame
		moveq	#8,d0
		add.w	d0,Obj_X(a0)
		add.w	d0,Obj_Control_Var_16(a0)
		sub.b	d0,Obj_Width(a0)

Offset_0x0249E4:
		move.l	#Obj_LevResultsGeneral,(a0)

; ---------------------------------------------------------------------------
; Object - General Level Results Object
; ---------------------------------------------------------------------------
; Offset_0x0249EA:
Obj_LevResultsGeneral:
		jsr	LevelResults_MoveElement(pc)
		jmp	(DisplaySprite).l

; ---------------------------------------------------------------------------
; Object - Act on the Level Results
; ---------------------------------------------------------------------------
; Offset_0x0249F4: Obj_LvL_Res_ACT_X:
Obj_LevResultsAct:
		tst.b	(Apparent_Act).w			; are we in "Act 2"?
		beq.s	Offset_0x0249E4				; if not, branch
		addq.b	#1,Obj_Map_Id(a0)
		bra.s	Offset_0x0249E4

; ---------------------------------------------------------------------------
; Object - Time Results on the Level Results
; ---------------------------------------------------------------------------
; Offset_0x024A00: Obj_LvL_Res_Time_Bonus:
Obj_LevelResultsTimeBonus:
		jsr	LevelResults_MoveElement(pc)
		move.w	(Level_Results_Time_Bonus).w,d0
		bra.s	LevelResults_Display

; ---------------------------------------------------------------------------
; Object - Ring Results on the Level Results
; ---------------------------------------------------------------------------
; Offset_0x024A0A: Obj_LvL_Res_Ring_Bonus:
Obj_LevelResultsRingBonus:
		jsr	LevelResults_MoveElement(pc)
		move.w	(Level_Results_Ring_Bonus).w,d0
		bra.s	LevelResults_Display

; ---------------------------------------------------------------------------
; Object - Total Results on the Level Results
; ---------------------------------------------------------------------------
; Offset_0x024A14: Obj_LvL_Res_Total_Bonus:
Obj_LevelResultsTotal:
		jsr	LevelResults_MoveElement(pc)
		move.w	(Level_Results_Total_Bonus).w,d0

; Offset_0x024A1C: LR_Display_Value_D0:
LevelResults_Display:
		bsr.s	LevelResults_DisplayScore
		jmp	(DisplaySprite).l

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to convert the level results score to a viewable format
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B R O U T I N E |||||||||||||||||||||||||||||||||||||||

; Offset_0x024A24: LR_Cvt_Hex_To_BCD:
LevelResults_DisplayScore:
		move.w	#7,Obj_Sub_Y(a0)
		jsr	LevelResults_GetDecimalScore(pc)
		rol.l	#4,d1
		lea	Obj_Speed_X(a0),a1
		move.w	Obj_X(a0),d2
		subi.w	#$38,d2					; move to left of the last zero
		move.w	Obj_Y(A0),d3
		moveq	#0,d4
		moveq	#6,d5

Offset_0x024A44:
		move.w	d2,(a1)+
		move.w	d3,(a1)+
		addq.w	#1,a1
		rol.l	#4,d1					; adjust bits
		move.w	d1,d0
		andi.w	#$F,d0
		beq.s	Offset_0x024A56
		moveq	#1,d4

Offset_0x024A56:
		add.w	d4,d0
		move.b	d0,(a1)+
		addq.w	#8,d2
		dbf	d5,Offset_0x024A44
		rts
; End of function LevelResults_DisplayScore

; ---------------------------------------------------------------------------
; Subroutine to move the level results onto screen
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B R O U T I N E |||||||||||||||||||||||||||||||||||||||

; Offset_0x024A62: LR_Move_Element:
LevelResults_MoveElement:
		move.w	Obj_Respaw_Ref(a0),a1
		move.w	Obj_Control_Var_02(a1),d0		; is the object moving onto the screen?
		beq.s	LevelResults_MoveOntoScreen		; if yes, branch
		tst.b	Obj_Flags(a0)				; is the object off-screen?
		bmi.s	LevelResults_MoveOffScreen		; if not, branch
		subq.w	#1,Obj_Control_Var_00(a1)
		addq.w	#4,sp
		jmp	(DeleteObject).l
; ---------------------------------------------------------------------------
; Offset_0x024A7E:
LevelResults_MoveOffScreen:
		cmp.b	Obj_Col_Flags(a0),d0
		bcs.s	Offset_0x024AAC
		move.w	#-$20,d0
		tst.b	Obj_Routine(a0)
		beq.s	Offset_0x024A90
		neg.w	d0

Offset_0x024A90:
		add.w	Obj_X(a0),d0
		bra.s	LevelResults_ApplySpeed
; ---------------------------------------------------------------------------
; Offset_0x024A96:
LevelResults_MoveOntoScreen:
		moveq	#$10,d1
		move.w	Obj_X(a0),d0
		cmp.w	Obj_Control_Var_16(a0),d0
		beq.s	LevelResults_ApplySpeed
		blt.s	Offset_0x024AA6
		neg.w	d1

Offset_0x024AA6:
		add.w	d1,d0
; Offset_0x024AA8:
LevelResults_ApplySpeed:
		move.w	d0,Obj_X(a0)

Offset_0x024AAC:
		rts
; End of function LevelResults_MoveElement

; ---------------------------------------------------------------------------
; Subroutine to convert the score to decimal
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B R O U T I N E |||||||||||||||||||||||||||||||||||||||

; Offset_0x24AAE: LR_Get_BCD_Total_Bonus:
LevelResults_GetDecimalScore:
		clr.l	(Level_Result_BCD_Total_Bonus).w
		lea	TimeBonuses(pc),a1
		moveq	#$F,d2

Offset_0x024AB8:
		ror.w	#1,d0
		bcs.s	Offset_0x024AC0
		subq.w	#3,a1
		bra.s	Offset_0x024ACE
; ---------------------------------------------------------------------------

Offset_0x024AC0:
		lea	(Level_Result_BCD_Total_Bonus+4).w,a2
		addi.w	#0,d0
		abcd	-(a1),-(a2)
		abcd	-(a1),-(a2)
		abcd	-(a1),-(a2)

Offset_0x024ACE:
		dbf	d2,Offset_0x024AB8
		move.l	(Level_Result_BCD_Total_Bonus).w,d1
		rts
; End of function LevelResults_GetDecimalScore

; ===========================================================================
; Apparently, according to Jorge, this is used by LevelResults_GetDecimalScore
; as it reads backwards into these values when reading TimeBonuses
; Offset_0x024AD8:
		dc.b    $03, $27, $68, $01, $63, $84, $00, $81
		dc.b    $92, $00, $40, $96, $00, $20, $48, $00
		dc.b    $10, $24, $00, $05, $12, $00, $02, $56
		dc.b    $00, $01, $28, $00, $00, $64, $00, $00
		dc.b    $32, $00, $00, $16, $00, $00, $08, $00
		dc.b    $00, $04, $00, $00, $02, $00, $00, $01  
; ===========================================================================
; Offset_0x024B08: LR_Decimal_Values:
TimeBonuses:	dc.w	5000
		dc.w	5000
		dc.w	5000
		dc.w	5000
		dc.w	5000
		dc.w	1000
		dc.w	500
		dc.w	400
		dc.w	300
		dc.w	100
TimeBonuses_End:
; ===========================================================================
; Offset_0x024B1C: Level_Results_Conf:
LevelResults_ObjArray:
		ttlresObjData Obj_LevResultsCharName,	 $E0,-$220, $B8,$13,$48,1	; Character Name
		ttlresObjData Obj_LevResultsGeneral,	$130,-$1D0, $B8,$12,$30,1	; "GOT"
		ttlresObjData Obj_LevResultsGeneral,	 $E8, $468, $CC,$11,$70,3	; "THROUGH"
		ttlresObjData Obj_LevResultsAct,	$160, $4E0, $BC, $F,$38,3	; "ACT X"
		ttlresObjData Obj_LevResultsGeneral,	 $C0, $4C0, $F0, $E,$20,5	; "TIME"
		ttlresObjData Obj_LevResultsGeneral,	 $E8, $4E8, $F0, $C,$30,5	; "BONUS"
		ttlresObjData Obj_LevelResultsTimeBonus,$178, $578, $F0,  1,$40,5	; Time Bonus Number
		ttlresObjData Obj_LevResultsGeneral,	 $C0, $500,$100, $D,$20,7	; "RING"
		ttlresObjData Obj_LevResultsGeneral,	 $E8, $528,$100, $C,$30,7	; "BONUS"
		ttlresObjData Obj_LevelResultsRingBonus,$178, $5B8,$100,  1,$40,7	; Ring Bonus Number
		ttlresObjData Obj_LevResultsGeneral,	 $D4, $554,$11C, $B,$30,9	; "TOTAL"
		ttlresObjData Obj_LevelResultsTotal,	$178, $5F8,$11C,  1,$40,9	; Total Score Number
LevelResults_ObjArray_End: