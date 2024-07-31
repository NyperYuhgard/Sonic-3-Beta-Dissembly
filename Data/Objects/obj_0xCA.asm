; ===========================================================================
; ---------------------------------------------------------------------------
; Object CA - Final AIZ Intro with Super Sonic (unused)
; ---------------------------------------------------------------------------
; Offset_0x035AD2: Obj_0xCA_AIz_Super_Sonic_Intro:
ObjCA_AIZPlaneIntro:
		moveq	#0,d0
		move.b	Obj_Routine(a0),d0
		move.w	AIZPlaneIntro_Index(pc,d0.w),d1
		jsr	AIZPlaneIntro_Index(pc,d1.w)
		jsr	(Load_Sonic_Dynamic_PLC).l
		bsr.w	AIZPlaneIntro_Scroll
		jmp	(DisplaySprite).l
; ===========================================================================
; Offset_0x035AF0:
AIZPlaneIntro_Index:	offsetTable
		offsetTableEntry.w AIZPlaneIntro_Init
		offsetTableEntry.w AIZPlaneIntro_Wait
		offsetTableEntry.w AIZPlaneIntro_SwoopDown
		offsetTableEntry.w AIZPlaneIntro_Wait
		offsetTableEntry.w AIZPlaneIntro_SonicFallBehind
		offsetTableEntry.w AIZPlaneIntro_SonicFallBehind2
		offsetTableEntry.w AIZPlaneIntro_Wait3
		offsetTableEntry.w AIZPlaneIntro_SonicMove
		offsetTableEntry.w Offset_0x035C8E
		offsetTableEntry.w AIZPlaneIntro_SonicMove2
		offsetTableEntry.w Offset_0x035CEC
		offsetTableEntry.w AIZPlaneIntro_ReachedShores
		offsetTableEntry.w AIZPlaneIntro_InJungle
		offsetTableEntry.w AIZPlaneIntro_UpperCutSonic
; ===========================================================================
; Offset_0x035B0C:
AIZPlaneIntro_Init:
		addq.b	#2,Obj_Routine(a0)
		move.l	#Sonic_Mappings,Obj_Map(a0)
		move.w	#$680,Obj_Art_VRAM(a0)
		move.w	#$280,Obj_Priority(a0)
		move.b	#1,Obj_Map_Id(a0)
		move.b	#$40,Obj_Width(a0)
		move.b	#$20,Obj_Width(a0)
		move.w	#$60,Obj_X(a0)
		move.w	#$30,Obj_Y(a0)
		move.w	#$40,Obj_Timer(a0)
		move.l	#AIZPlaneIntro_Tornado,Obj_Child(a0)
		move.w	#8,Obj_Control_Var_10(a0)
		move.w	#$E918,(Level_Events_Buffer_1).w
		move.b	#-1,(Sonic_Previous_Frame).w
		lea	(Obj_Player_One).w,a1
		move.b	#0,Obj_Map_Id(a1)
		move.b	#$53,Obj_Timer(a1)

Offset_0x035B72:		
		rts   
; ===========================================================================
; Offset_0x035B74:
AIZPlaneIntro_Wait:
		jmp	(Run_Object_Wait_Timer_A0).l
; ===========================================================================
; Offset_0x035B7A:
AIZPlaneIntro_Tornado:
		move.b	#4,Obj_Routine(a0)
		move.w	#$300,Obj_Speed_X(a0)
		move.w	#$600,Obj_Speed_Y(a0)
		lea	AIZPlaneIntro_ObjArray(pc),a2
		jmp	(Load_Child_Object_A2).l
; ===========================================================================
; Offset_0x035B96:
AIZPlaneIntro_SwoopDown:
		subi.w	#$18,Obj_Speed_Y(a0)			; slow descent
		beq.s	AIZPlaneIntro_Stationary		; if we have 0 Y-speed, branch
		jmp	(SpeedToPos).l
; ---------------------------------------------------------------------------
; Offset_0x035BA4:
AIZPlaneIntro_Stationary:
		move.b	#6,Obj_Routine(a0)
		move.w	#$5F,Obj_Timer(a0)
		move.l	#AIZPlaneIntro_SonicJumping,Obj_Child(a0)
		rts
; ===========================================================================
; Offset_0x035BBA:
AIZPlaneIntro_SonicJumping:
		move.b	#8,Obj_Routine(a0)
		move.w	#$400,Obj_Speed_X(a0)
		move.w	#-$400,Obj_Speed_Y(a0)
		move.l	#Offset_0x035F48,Obj_Child_Data(a0)
		bset	#3,Obj_Control_Var_08(a0)
		rts    
; ===========================================================================
; Offset_0x035BDC:
AIZPlaneIntro_SonicFallBehind:
		subi.w	#$40,Obj_Speed_X(a0)			; decrease Sonic's speed to make him fall behind the Tornado
		jsr	(ObjectFall).l
		cmpi.w	#$130,Obj_Y(a0)				; are we at the ocean surface?
		bcc.s	AIZPlaneIntro_SonicFloating		; if yes, branch
		jmp	(Animate_Raw).l
; ---------------------------------------------------------------------------
; Offset_0x035BF6:
AIZPlaneIntro_SonicFloating:
		move.b	#$A,Obj_Routine(a0)
		move.w	#$130,Obj_Y(a0)
		rts
; ===========================================================================
; Offset_0x035C04:
AIZPlaneIntro_SonicFallBehind2:
		move.w	Obj_X(a0),d0
		subq.w	#4,d0
		cmpi.w	#$40,d0					; are we slightly off-screen?
		bcs.s	AIZPlaneIntro_SonicTransform		; if yes, branch
		move.w	d0,Obj_X(a0)
		rts
; ---------------------------------------------------------------------------
; Offset_0x035C16:
AIZPlaneIntro_SonicTransform:
		move.b	#$C,Obj_Routine(a0)
		move.w	#$40,Obj_X(a0)
		move.w	#5,Obj_Timer(a0)
		move.l	#AIZPlaneIntro_SuperSonic,Obj_Child(a0)
		move.w	#$3F,Obj_Control_Var_0A(a0)
		bra.w	IntroSSWaves_SetSSAnim	
; ===========================================================================
; Offset_0x035C3A:
AIZPlaneIntro_SuperSonic:
		move.w	#5,Obj_Timer(a0)
		cmpi.w	#$80,Obj_X(a0)
		bcs.w	Offset_0x035B72
		lea	AIZPlaneIntro_ObjArray3(pc),a2
		jmp	(Load_Child_Object_A2).l
; ===========================================================================
; Offset_0x035C54:
AIZPlaneIntro_Wait3:
		subq.w	#1,Obj_Control_Var_0A(a0)
		bpl.w	Offset_0x035B72
		move.b	#$E,Obj_Routine(a0)
		rts
; ---------------------------------------------------------------------------
; Offset_0x035C64:
AIZPlaneIntro_SonicMove:
		bsr.w	PalCycle_SuperSonicIntro
		jsr	(Run_Object_Wait_Timer_A0).l
		move.w	Obj_X(a0),d0
		addq.w	#4,d0
		move.w	d0,Obj_X(a0)
		cmpi.w	#$200,d0				; are we at X-pos $200?
		bcc.s	Offset_0x035C80				; if yes, branch
		rts

Offset_0x035C80:
		move.b	#$10,Obj_Routine(a0)
		move.w	#$1F,Obj_Control_Var_0A(a0)
		rts
; ===========================================================================

Offset_0x035C8E:
		bsr.w	PalCycle_SuperSonicIntro
		jsr	(Run_Object_Wait_Timer_A0).l
		subq.w	#1,Obj_Control_Var_0A(a0)
		bpl.w	Offset_0x035B72
		move.b	#$12,Obj_Routine(a0)
		bset	#2,Obj_Control_Var_08(a0)
		move.w	#$C,Obj_Control_Var_10(a0)
		rts    
; ---------------------------------------------------------------------------
; Offset_0x035CB4:
AIZPlaneIntro_SonicMove2:
		bsr.w	PalCycle_SuperSonicIntro
		jsr	(Run_Object_Wait_Timer_A0).l
		move.w	Obj_X(a0),d0
		subi.w	#4,d0
		move.w 	d0,Obj_X(a0)
		cmpi.w	#$120,d0
		bls.s	Offset_0x035CD2
		rts

Offset_0x035CD2:
		move.b	#$14,Obj_Routine(a0)
		bset	#2,Obj_Control_Var_08(a0)
		move.w	#$3F,Obj_Control_Var_0A(a0)
		move.w	#$10,Obj_Control_Var_10(a0)
		rts     
; ===========================================================================

Offset_0x035CEC:
		bsr.w	PalCycle_SuperSonicIntro
		jsr	(Run_Object_Wait_Timer_A0).l
		subq.w	#1,Obj_Control_Var_0A(a0)
		bpl.w	Offset_0x035B72
		move.b	#$16,Obj_Routine(a0)
		rts
; ---------------------------------------------------------------------------
; Offset_0x035D06:
AIZPlaneIntro_ReachedShores:
		bsr.w	PalCycle_SuperSonicIntro
		cmpi.w	#$918,(Obj_Player_One+Obj_X).w		; have we reached the shores?
		bcc.s	Offset_0x035D18				; if yes, branch
		jmp	(Run_Object_Wait_Timer_A0).l

Offset_0x035D18:
		move.b	#$18,Obj_Routine(a0)
		lea	AIZPlaneIntro_ObjArray4(pc),a2
		jmp	(Load_Child_Object_Simple_A2).l
; ===========================================================================
; Offset_0x035D28:
AIZPlaneIntro_InJungle:
		bsr.w	PalCycle_SuperSonicIntro
		cmpi.w	#$1240,(Obj_Player_One+Obj_X).w		; are we about to exit the jungle?
		bcc.s	Offset_0x035D36				; if yes, branch
		rts

Offset_0x035D36:
		move.b	#$1A,Obj_Routine(a0)
		subi.w	#$20,Obj_Y(a0)
		rts
;-------------------------------------------------------------------------------
; Offset_0x035D44:
AIZPlaneIntro_UpperCutSonic:
		bsr.w	PalCycle_SuperSonicIntro
		cmpi.w	#$13D0,(Obj_Player_One+Obj_X).w		; is Knuckles about to uppercut Sonic?
		bcc.s	AIZPlaneIntro_DisableSuper		; if yes, branch
		rts
; Offset_0x035D52:
AIZPlaneIntro_DisableSuper:
		lea	(Obj_Player_One).w,a1
		clr.b	Obj_Timer(a1)
		st	(Control_Locked_Flag_P1).w
		move.b	#2,(Super_Sonic_Palette_Status).w
		move.w	#$28,(Super_Sonic_Palette_Frame).w
		jmp	(Go_Delete_Object_A0).l
; ===========================================================================
; ---------------------------------------------------------------------------
; Object - Tornado in the Intro
; ---------------------------------------------------------------------------
; Offset_0x035D70:
Obj_IntroTornado:
		move.l	#Offset_0x035DB0,(a0)
		move.l	#Tornado_Mappings,Obj_Map(a0)
		move.w	#$529,Obj_Art_VRAM(a0)
		move.w	#$280,Obj_Priority(a0)
		move.b	#$40,Obj_Width(a0)
		move.b	#$20,Obj_Width(a0)
		lea	(Art_Tornado).l,a1
		move.w	#$A520,d2
		jsr	(Queue_Kos_Module).l
		lea	AIZPlaneIntro_ObjArray2(pc),a2
		jmp	(Load_Child_Object_A2).l
; ---------------------------------------------------------------------------

Offset_0x035DB0:
		move.w	Obj_Child_Ref(a0),a1
		btst	#2,Obj_Control_Var_08(a1)
		beq.s	Offset_0x035DC2
		move.l	#Offset_0x035DD6,(a0)

Offset_0x035DC2:
		btst	#3,Obj_Control_Var_08(a1)
		bne.s	Offset_0x035DD0
		jsr	(Refresh_Child_Position).l

Offset_0x035DD0:
		jmp     (DisplaySprite).l
; ---------------------------------------------------------------------------

Offset_0x035DD6:
		subq.w	#4,Obj_X(a0)
		cmpi.w	#$20,Obj_X(a0)
		bcs.s	Offset_0x035DE8
		jmp	(DisplaySprite).l

Offset_0x035DE8:
		jmp	(Go_Delete_Object_A0).l

; ===========================================================================
; ---------------------------------------------------------------------------
; Object - Tornado Propeller in the Intro
; ---------------------------------------------------------------------------
; Offset_0x035DEE:
Obj_IntroTornadoProp:
		move.l	#Tornado_Mappings,Obj_Map(a0)
		move.w	#$529,Obj_Art_VRAM(a0)
		move.w	#$280,Obj_Priority(a0)
		move.b	#4,Obj_Width(a0)
		move.b	#$C,Obj_Width(a0)
		move.l	#IntroTornadoProp_Animate,(a0)
; Offset_0x035E14:
IntroTornadoProp_Animate:
		lea	(Offset_0x035F52).l,a1
		jsr	(Animate_Raw_A1).l
		jsr	(Refresh_Child_Position).l
		jmp	(Child_Display_Or_Delete).l

; ===========================================================================
; ---------------------------------------------------------------------------
; Object - Tornado Booster in the Intro
; ---------------------------------------------------------------------------
; Offset_0x035E2C:
Obj_IntroTornadoBooster:
		move.l	#Tornado_Mappings,Obj_Map(a0)
		move.w	#$529,Obj_Art_VRAM(a0)
		move.w	#$280,Obj_Priority(a0)
		move.b	#4,Obj_Width(a0)
		move.b	#$C,Obj_Width(a0)
		move.l	#IntroTornadoBooster_Animate,(a0)
; Offset_0x035E52:
IntroTornadoBooster_Animate:
		lea	(Offset_0x035F5A).l,a1
		jsr	(Animate_Raw_A1).l
		jsr	(Refresh_Child_Position).l
		jmp	(Child_Display_Or_Delete).l


; ===========================================================================
; ---------------------------------------------------------------------------
; Object - Super Sonic Waves in the Intro
; ---------------------------------------------------------------------------
; Offset_0x035E6A:
Obj_IntroSuperSonicWaves:
		move.l	#IntroSSWaves_Animate,(a0)
		move.l	#Surfboard_Waves_Mappings,Obj_Map(a0)
		move.w	#$3D1,Obj_Art_VRAM(a0)
		move.w	#$100,Obj_Priority(a0)
		move.b	#$10,Obj_Width(a0)
		bset	#0,Obj_Flags(a0)
		move.w	Obj_Child_Ref(a0),a1
		move.l	#Offset_0x035F5E,Obj_Child_Data(a0)
		move.l	#Go_Delete_Object_A0,Obj_Child(a0)
; Offset_0x035EA4:
IntroSSWaves_Animate:
		move.w	Obj_Child_Ref(a0),a1
		move.w	Obj_Control_Var_10(a1),d0
		sub.w	d0,Obj_X(a0)
		jsr	(Animate_Raw_Multi_Delay)
		jmp	(DisplaySprite).l
; ===========================================================================
; Offset_0x035EBC:
IntroSSWaves_SetSSAnim:
		move.b	#$B5,Obj_Map_Id(a0)
		move.b	#0,(Super_Sonic_Palette_Timer).w
		move.w	#$30,(Super_Sonic_Palette_Frame).w
		move.w	#$7FFF,(Super_Sonic_Frame_Count).w
		rts
; ===========================================================================
; Offset_0x035ED6:
PalCycle_SuperSonicIntro:
		subq.b	#1,(Super_Sonic_Palette_Timer).w
		bpl.s	Offset_0x035F0A
		move.b	#7,(Super_Sonic_Palette_Timer).w
		lea	(Pal_SuperSonic_Cyc).l,a1
		move.w	(Super_Sonic_Palette_Frame).w,d0
		addq.w	#8,(Super_Sonic_Palette_Frame).w
		cmpi.w	#$78,(Super_Sonic_Palette_Frame).w
		bcs.s	Offset_0x035EFE
		move.w	#$30,(Super_Sonic_Palette_Frame).w

Offset_0x035EFE:
		lea	(Palette_Row_0_Offset+4).w,a2
		move.l	(a1,d0.w),(a2)+
		move.w	4(a1,d0.w),(a2)

Offset_0x035F0A:
		rts
; ===========================================================================
; Offset_0x035F0C:
AIZPlaneIntro_Scroll:
		move.w	Obj_Control_Var_10(a0),d1
		move.w	(Level_Events_Buffer_1).w,d0
		bpl.s	Offset_0x035F1E
		add.w	d1,d0
		move.w	d0,(Level_Events_Buffer_1).w
		rts

Offset_0x035F1E:
		add.w	d1,(Obj_Player_One+Obj_X).w
		rts
; End of function AIZPlaneIntro_Scroll

; ===========================================================================
; Offset_0x035F24:
AIZPlaneIntro_ObjArray:
		dc.w	1-1
		dc.l	Obj_IntroTornado
		dc.b	-$22,$2C
; Offset_0x035F2C:
AIZPlaneIntro_ObjArray2:
		dc.w	2-1
		dc.l	Obj_IntroTornadoProp
		dc.b	$38,  4
		dc.l	Obj_IntroTornadoBooster
		dc.b	$18,$18
; Offset_0x035F3A:
AIZPlaneIntro_ObjArray3:
		dc.w	1-1
		dc.l	Obj_IntroSuperSonicWaves
		dc.b	$F8,$18
; Offset_0x035F42:
AIZPlaneIntro_ObjArray4:
		dc.w	0
		dc.l	Obj_0xC7_Knuckles

; ===========================================================================

Offset_0x035F48:
		dc.b	$03, $3D, $41, $3E, $41, $3F, $41, $40
		dc.b	$41, $FC
Offset_0x035F52:
		dc.b	$00, $01, $02, $03, $04, $03, $02, $FC
Offset_0x035F5A:
		dc.b	$00, $05, $06, $FC
Offset_0x035F5E:
		dc.b	$00, $01, $01, $02, $02, $03, $03, $03
		dc.b	$04, $02, $05, $02, $F4, $00  
; ===========================================================================
; Offset_0x035F6C:
Tornado_Mappings:
		dc.w    Offset_0x035F82-Tornado_Mappings
		dc.w    Offset_0x035FBA-Tornado_Mappings
		dc.w    Offset_0x035FC2-Tornado_Mappings
		dc.w    Offset_0x035FCA-Tornado_Mappings
		dc.w    Offset_0x035FD2-Tornado_Mappings
		dc.w    Offset_0x035FDA-Tornado_Mappings
		dc.w    Offset_0x035FEE-Tornado_Mappings
		dc.w    Offset_0x036002-Tornado_Mappings
		dc.w    Offset_0x036022-Tornado_Mappings
		dc.w    Offset_0x03603C-Tornado_Mappings
		dc.w    Offset_0x036050-Tornado_Mappings
Offset_0x035F82:
		dc.w    $0009
		dc.w    $E009, $0000, $FFC4
		dc.w    $F00E, $0006, $FFC4
		dc.w    $F007, $0012, $FFE4
		dc.w    $E80F, $001A, $FFF4
		dc.w    $080C, $002A, $FFF4
		dc.w    $E80C, $002E, $0014
		dc.w    $F00B, $0032, $0014
		dc.w    $1005, $003E, $001C
		dc.w    $F802, $0042, $002C
Offset_0x035FBA:
		dc.w    $0001
		dc.w    $F402, $0045, $FFFC
Offset_0x035FC2:
		dc.w    $0001
		dc.w    $F402, $0048, $FFFC
Offset_0x035FCA:
		dc.w    $0001
		dc.w    $F402, $004B, $FFFC
Offset_0x035FD2:
		dc.w    $0001
		dc.w    $F402, $004E, $FFFC
Offset_0x035FDA:
		dc.w    $0003
		dc.w    $F80D, $0051, $FFE4
		dc.w    $F809, $0059, $0004
		dc.w    $F80D, $005F, $FFC4
Offset_0x035FEE:
		dc.w    $0003
		dc.w    $F80D, $0051, $FFE4
		dc.w    $F809, $0059, $0004
		dc.w    $F805, $0067, $FFD4
Offset_0x036002:
		dc.w    $0005
		dc.w    $F80D, $006B, $FFC4
		dc.w    $F80D, $086B, $001C
		dc.w    $F809, $0073, $FFE4
		dc.w    $F809, $006F, $0004
		dc.w    $F801, $006F, $FFFC
Offset_0x036022:
		dc.w    $0004
		dc.w    $F80D, $0079, $FFD0
		dc.w    $F80D, $0879, $0010
		dc.w    $F805, $007D, $FFF0
		dc.w    $F805, $007D, $0000
Offset_0x03603C:
		dc.w    $0003
		dc.w    $FC0C, $0081, $FFDC
		dc.w    $FC0C, $0881, $0004
		dc.w    $FC00, $0082, $FFFC
Offset_0x036050:
		dc.w    $0002
		dc.w    $FC08, $0085, $FFE8
		dc.w    $FC08, $0885, $0000