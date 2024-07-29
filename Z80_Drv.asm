	CPU z80
	objend

zEntryPoint:
    di                     ; 000000 F3
    di                     ; 000001 F3
    im     1               ; 000002 ED 56
	jp	zInitAudioDriver
    nop                    ; 000007 00

zGetPointerTable:
    ld     hl,($1c02)      ; 000008 2A 02 1C
    ld     b,$00           ; 00000B 06 00
    add    hl,bc           ; 00000D 09
    ex     af,af          ; 00000E 08
    ld     a,(hl)          ; 00000F 7E
    inc    hl              ; 000010 23
    ld     h,(hl)          ; 000011 66
    ld     l,a             ; 000012 6F
    ex     af,af          ; 000013 08
    ret                    ; 000014 C9
    nop                    ; 000015 00
    nop                    ; 000016 00
    nop                    ; 000017 00

zPointerTableOffset:
    ld     c,a             ; 000018 4F
    ld     b,$00           ; 000019 06 00
    add    hl,bc           ; 00001B 09
    add    hl,bc           ; 00001C 09
    nop                    ; 00001D 00
    nop                    ; 00001E 00
    nop                    ; 00001F 00
    ld     a,(hl)          ; 000020 7E
    inc    hl              ; 000021 23
    ld     h,(hl)          ; 000022 66
    ld     l,a             ; 000023 6F
    ret                    ; 000024 C9
    nop                    ; 000025 00
    nop                    ; 000026 00
    nop                    ; 000027 00
    nop                    ; 000028 00
    nop                    ; 000029 00
    nop                    ; 00002A 00
    nop                    ; 00002B 00
    nop                    ; 00002C 00
    nop                    ; 00002D 00
    nop                    ; 00002E 00
    nop                    ; 00002F 00
    nop                    ; 000030 00
    nop                    ; 000031 00
    nop                    ; 000032 00
    nop                    ; 000033 00
    nop                    ; 000034 00
    nop                    ; 000035 00
    nop                    ; 000036 00
    nop                    ; 000037 00

zVInt:
    di                     ; 000038 F3
    push   af              ; 000039 F5
    push   iy              ; 00003A FD E5
    exx                    ; 00003C D9


    call   $07c6           ; 00003D CD C6 07
    call   $00b3           ; 000040 CD B3 00
    ld     hl,$6000        ; 000043 21 00 60
    xor    a               ; 000046 AF
    ld     e,$01           ; 000047 1E 01
    ld     (hl),a          ; 000049 77
    ld     (hl),e          ; 00004A 73
    ld     (hl),e          ; 00004B 73
    ld     (hl),e          ; 00004C 73
    ld     (hl),e          ; 00004D 73
    ld     (hl),a          ; 00004E 77
    ld     (hl),a          ; 00004F 77
    ld     (hl),a          ; 000050 77
    ld     (hl),a          ; 000051 77
    exx                    ; 000052 D9
    pop    iy              ; 000053 FD E1
    pop    af              ; 000055 F1
    ld     b,$01           ; 000056 06 01
    ret                    ; 000058 C9

zInitAudioDriver:
    ld     sp,$2000        ; 000059 31 00 20
    ld     c,$00           ; 00005C 0E 00

@loop:
    ld     b,$00           ; 00005E 06 00
	djnz	*
    dec    c               ; 000062 0D
    jr     z,@loop         ; 000063 28 F9
    ld     a,$06           ; 000065 3E 06
    ld     ($1c04),a       ; 000067 32 04 1C
    xor    a               ; 00006A AF
    ld     ($1c06),a       ; 00006B 32 06 1C
    ld     ($1c07),a       ; 00006E 32 07 1C
    call   $072c           ; 000071 CD 2C 07
    ld     a,$05           ; 000074 3E 05
    ld     ($1c08),a       ; 000076 32 08 1C
    ld     hl,$6000        ; 000079 21 00 60
    ld     d,$01           ; 00007C 16 01
    xor    a               ; 00007E AF
    ld     (hl),a          ; 00007F 77
    ld     (hl),d          ; 000080 72
    ld     (hl),d          ; 000081 72
    ld     (hl),d          ; 000082 72
    ld     (hl),d          ; 000083 72
    ld     (hl),a          ; 000084 77
    ld     (hl),a          ; 000085 77
    ld     (hl),a          ; 000086 77
    ld     (hl),a          ; 000087 77
    ei                     ; 000088 FB
	jp	zPlayDigitalAudio

zWriteFMIorII:
    bit    7,(ix+$01)      ; 00008C DD CB 01 7E
    ret    nz              ; 000090 C0
    bit    2,(ix+$00)      ; 000091 DD CB 00 56
    ret    nz              ; 000095 C0
    add    a,(ix+$01)      ; 000096 DD 86 01
    bit    2,(ix+$01)      ; 000099 DD CB 01 56
	jr	nz,zWriteFMII_reduced

zWriteFMI:
    ld     ($4000),a       ; 00009F 32 00 40
    nop                    ; 0000A2 00
    ld     a,c             ; 0000A3 79
    ld     ($4001),a       ; 0000A4 32 01 40
    ret                    ; 0000A7 C9

zWriteFMII_reduced:
    sub    $04             ; 0000A8 D6 04

zWriteFMII:
    ld     ($4002),a       ; 0000AA 32 02 40
    nop                    ; 0000AD 00
    ld     a,c             ; 0000AE 79
    ld     ($4003),a       ; 0000AF 32 03 40
    ret                    ; 0000B2 C9
    call   $064f           ; 0000B3 CD 4F 06
    call   $07b0           ; 0000B6 CD B0 07
	call	zDoMusicFadeOut
    call   $0424           ; 0000BC CD 24 04
	call	zUpdateSFXTracks

; bankswitch!
    ld     hl,$6000        ; 0000C2 21 00 60
    ld     a,($1c04)       ; 0000C5 3A 04 1C
    ld     (hl),a          ; 0000C8 77
    rra                    ; 0000C9 1F
    ld     (hl),a          ; 0000CA 77
    rra                    ; 0000CB 1F
    ld     (hl),a          ; 0000CC 77
    rra                    ; 0000CD 1F
    ld     (hl),a          ; 0000CE 77
    xor    a               ; 0000CF AF
    ld     d,$01           ; 0000D0 16 01
    ld     (hl),d          ; 0000D2 72
    ld     (hl),a          ; 0000D3 77
    ld     (hl),a          ; 0000D4 77
    ld     (hl),a          ; 0000D5 77
    ld     (hl),a          ; 0000D6 77
    xor    a               ; 0000D7 AF
    ld     ($1c19),a       ; 0000D8 32 19 1C
    ld     ix,$1c40        ; 0000DB DD 21 40 1C
    bit    7,(ix+$00)      ; 0000DF DD CB 00 7E
    call   nz,$090e        ; 0000E3 C4 0E 09
    ld     b,$08           ; 0000E6 06 08
    ld     ix,$1c70        ; 0000E8 DD 21 70 1C
	jr	zTrackUpdLoop

zUpdateSFXTracks:
    ld     a,$01           ; 0000EE 3E 01
    ld     ($1c19),a       ; 0000F0 32 19 1C
    ld     hl,$6000        ; 0000F3 21 00 60
    xor    a               ; 0000F6 AF
    ld     e,$01           ; 0000F7 1E 01
    ld     (hl),e          ; 0000F9 73
    ld     (hl),a          ; 0000FA 77
    ld     (hl),e          ; 0000FB 73
    ld     (hl),e          ; 0000FC 73
    ld     (hl),e          ; 0000FD 73
    ld     (hl),a          ; 0000FE 77
    ld     (hl),a          ; 0000FF 77
    ld     (hl),a          ; 000100 77
    ld     (hl),a          ; 000101 77
    ld     ix,$1df0        ; 000102 DD 21 F0 1D
    ld     b,$07           ; 000106 06 07

zTrackUpdLoop:
    push   bc              ; 000108 C5
    bit    7,(ix+$00)      ; 000109 DD CB 00 7E
	call	nz,zUpdateFMorPSGTrack
    ld     de,$0030        ; 000110 11 30 00
    add    ix,de           ; 000113 DD 19
    pop    bc              ; 000115 C1
	djnz	zTrackUpdLoop
	ret

zUpdateFMorPSGTrack:
    bit    7,(ix+$01)      ; 000119 DD CB 01 7E
	jp	nz,zUpdatePSGTrack

	call	zTrackRunTimer
	jr	nz,@noteGoing
	call	zGetNextNote
    bit    4,(ix+$00)      ; 000128 DD CB 00 66
    ret    nz              ; 00012C C0
	call	zPrepareModulation
	call	zUpdateFreq
	call	zDoModulation
	call	zFMSendFreq
	jp	zFMNoteOn

@noteGoing:
    bit    4,(ix+$00)      ; 00013C DD CB 00 66
    ret    nz              ; 000140 C0
	call	zDoFMVolEnv
    ld     a,(ix+$1e)      ; 000144 DD 7E 1E
    or     a               ; 000147 B7
	jr	z,@keepGoing
    dec    (ix+$1e)        ; 00014A DD 35 1E
	jp	z,zKeyOffIfActive

@keepGoing:
	call	zUpdateFreq
    bit    6,(ix+$00)      ; 000153 DD CB 00 76
    ret    nz              ; 000157 C0
	call	zDoModulation

zFMSendFreq:
    bit    2,(ix+$00)      ; 00015B DD CB 00 56
    ret    nz              ; 00015F C0
    bit    0,(ix+$00)      ; 000160 DD CB 00 46
	jp	nz,@specialMode

@notFM3:
    ld     a,$a4           ; 000167 3E A4
    ld     c,h             ; 000169 4C
	call	zWriteFMIorII
    ld     a,$a0           ; 00016D 3E A0
    ld     c,l             ; 00016F 4D
	call	zWriteFMIorII
    ret                    ; 000173 C9

@specialMode:
    ld     a,(ix+$01)      ; 000174 DD 7E 01
    cp     $02             ; 000177 FE 02
	jr	nz,@notFM3
	call	zGetSpecialFM3DataPointer
    ld     b,$04           ; 00017E 06 04
	ld	hl,zSpecialFreqCommands

@loop:
    push   bc              ; 000183 C5
    ld     a,(hl)          ; 000184 7E
    inc    hl              ; 000185 23
    push   hl              ; 000186 E5
    ex     de,hl           ; 000187 EB
    ld     c,(hl)          ; 000188 4E
    inc    hl              ; 000189 23
    ld     b,(hl)          ; 00018A 46
    inc    hl              ; 00018B 23
    ex     de,hl           ; 00018C EB
    ld     l,(ix+$0d)      ; 00018D DD 6E 0D
    ld     h,(ix+$0e)      ; 000190 DD 66 0E
    add    hl,bc           ; 000193 09
    push   af              ; 000194 F5
    ld     c,h             ; 000195 4C
	call	zWriteFMI
    pop    af              ; 000199 F1
    sub    $04             ; 00019A D6 04
    ld     c,l             ; 00019C 4D
	call	zWriteFMI
    pop    hl              ; 0001A0 E1
    pop    bc              ; 0001A1 C1
	djnz	@loop
	ret
; ---------------------------------------------------------------------------
; zloc_1A5:
zSpecialFreqCommands:
	db	$AD
	db	$AE
	db	$AC
	db	$A6
; ---------------------------------------------------------------------------

zGetSpecialFM3DataPointer:
    ld     de,$1c2a        ; 0001A9 11 2A 1C
    ld     a,($1c19)       ; 0001AC 3A 19 1C
    or     a               ; 0001AF B7
    ret    z               ; 0001B0 C8
    ld     de,$1c1a        ; 0001B1 11 1A 1C
    ret    p               ; 0001B4 F0
    ld     de,$1c22        ; 0001B5 11 22 1C
    ret                    ; 0001B8 C9

zGetNextNote:
    ld     e,(ix+$03)      ; 0001B9 DD 5E 03
    ld     d,(ix+$04)      ; 0001BC DD 56 04
    res    1,(ix+$00)      ; 0001BF DD CB 00 8E
    res    4,(ix+$00)      ; 0001C3 DD CB 00 A6
    ld     a,(de)          ; 0001C7 1A
    inc    de              ; 0001C8 13
    cp     $e0             ; 0001C9 FE E0
    jp     nc,$0958        ; 0001CB D2 58 09
    ex     af,af          ; 0001CE 08
	call	zKeyOffIfActive
    ex     af,af          ; 0001D2 08
    bit    3,(ix+$00)      ; 0001D3 DD CB 00 5E
	jp	nz,zAltFreqMode
    or     a               ; 0001DA B7
	jp	p,zStoreDuration
    sub    $81             ; 0001DE D6 81
    jp     p,$01e8         ; 0001E0 F2 E8 01
    call   $0d8f           ; 0001E3 CD 8F 0D
	jr	zGetNoteDuration
    add    a,(ix+$05)      ; 0001E8 DD 86 05
    ld     hl,$081d        ; 0001EB 21 1D 08
    push   af              ; 0001EE F5
	rst	zPointerTableOffset
    pop    af              ; 0001F0 F1
    bit    7,(ix+$01)      ; 0001F1 DD CB 01 7E
	jr	nz,zGotNoteFreq
    push   de              ; 0001F7 D5
    ld     d,$08           ; 0001F8 16 08
    ld     e,$0c           ; 0001FA 1E 0C
    ex     af,af          ; 0001FC 08
    xor    a               ; 0001FD AF

@loop:
    ex     af,af          ; 0001FE 08
    sub    e               ; 0001FF 93
	jr	c,@gotDisplacement
    ex     af,af          ; 000202 08
    add    a,d             ; 000203 82
	jr	@loop
    ex     af,af          ; 000206 08

@gotDisplacement:
    add    a,e             ; 000207 83
    ld     hl,$08c5        ; 000208 21 C5 08
	rst	zPointerTableOffset
    ex     af,af          ; 00020C 08
    or     h               ; 00020D B4
    ld     h,a             ; 00020E 67
    pop    de              ; 00020F D1

zGotNoteFreq:
    ld     (ix+$0d),l      ; 000210 DD 75 0D
    ld     (ix+$0e),h      ; 000213 DD 74 0E

zGetNoteDuration:
    ld     a,(de)          ; 000216 1A
    or     a               ; 000217 B7
	jp	p,zGotNoteDuration
    ld     a,(ix+$0c)      ; 00021B DD 7E 0C
    ld     (ix+$0b),a      ; 00021E DD 77 0B
	jr	zFinishTrackUpdate
    ld     a,(de)          ; 000223 1A
    inc    de              ; 000224 13
    ld     (ix+$11),a      ; 000225 DD 77 11
	jr	zGetRawDuration

zAltFreqMode:
    ld     h,a             ; 00022A 67
    ld     a,(de)          ; 00022B 1A
    inc    de              ; 00022C 13
    ld     l,a             ; 00022D 6F
    or     h               ; 00022E B4
	jr	z,@gotZero
    ld     a,(ix+$05)      ; 000231 DD 7E 05
    ld     b,$00           ; 000234 06 00
    or     a               ; 000236 B7
	jp	p,@didSignExtend
    dec    b               ; 00023A 05

@didSignExtend:
    ld     c,a             ; 00023B 4F
    add    hl,bc           ; 00023C 09

@gotZero:
    ld     (ix+$0d),l      ; 00023D DD 75 0D
    ld     (ix+$0e),h      ; 000240 DD 74 0E
    ld     a,(de)          ; 000243 1A
    inc    de              ; 000244 13
    ld     (ix+$11),a      ; 000245 DD 77 11

zGetRawDuration:
    ld     a,(de)          ; 000248 1A

zGotNoteDuration:
    inc    de              ; 000249 13

zStoreDuration:
	call	zComputeNoteDuration
    ld     (ix+$0c),a      ; 00024D DD 77 0C

zFinishTrackUpdate:
    ld     (ix+$03),e      ; 000250 DD 73 03
    ld     (ix+$04),d      ; 000253 DD 72 04
    ld     a,(ix+$0c)      ; 000256 DD 7E 0C
    ld     (ix+$0b),a      ; 000259 DD 77 0B
    bit    1,(ix+$00)      ; 00025C DD CB 00 4E
    ret    nz              ; 000260 C0
    xor    a               ; 000261 AF
    ld     (ix+$25),a      ; 000262 DD 77 25
    ld     (ix+$22),a      ; 000265 DD 77 22
    ld     (ix+$17),a      ; 000268 DD 77 17
    ld     a,(ix+$1f)      ; 00026B DD 7E 1F
    ld     (ix+$1e),a      ; 00026E DD 77 1E
	ret

zComputeNoteDuration:
    ld     b,(ix+$02)      ; 000272 DD 46 02
    dec    b               ; 000275 05
    ret    z               ; 000276 C8
    ld     c,a             ; 000277 4F

@loop:
    add    a,c             ; 000278 81
	djnz	@loop
	ret

zTrackRunTimer:
    ld     a,(ix+$0b)      ; 00027C DD 7E 0B
    dec    a               ; 00027F 3D
    ld     (ix+$0b),a      ; 000280 DD 77 0B
    ret                    ; 000283 C9

zFMNoteOn:
    ld     a,(ix+$0d)      ; 000284 DD 7E 0D
    or     (ix+$0e)        ; 000287 DD B6 0E
    ret    z               ; 00028A C8
    ld     a,(ix+$00)      ; 00028B DD 7E 00
    and    $06             ; 00028E E6 06
    ret    nz              ; 000290 C0
    ld     a,(ix+$01)      ; 000291 DD 7E 01
    or     $f0             ; 000294 F6 F0
    ld     c,a             ; 000296 4F
    ld     a,$28           ; 000297 3E 28
	call	zWriteFMI
	ret

zKeyOffIfActive:
    ld     a,(ix+$00)      ; 00029D DD 7E 00
    and    $06             ; 0002A0 E6 06
    ret    nz              ; 0002A2 C0

zKeyOff:
    ld     c,(ix+$01)      ; 0002A3 DD 4E 01
    bit    7,c             ; 0002A6 CB 79
    ret    nz              ; 0002A8 C0

zKeyOnOff:
    ld     a,$28           ; 0002A9 3E 28
	call	zWriteFMI
	ret

zDoFMVolEnv:
    ld     a,(ix+$18)      ; 0002AF DD 7E 18
    or     a               ; 0002B2 B7
    ret    z               ; 0002B3 C8
    ret    m               ; 0002B4 F8
    dec    a               ; 0002B5 3D
    ld     c,$0a           ; 0002B6 0E 0A
	rst	zGetPointerTable
	rst	zPointerTableOffset
    call   $0d5d           ; 0002BA CD 5D 0D
    ld     h,(ix+$1d)      ; 0002BD DD 66 1D
    ld     l,(ix+$1c)      ; 0002C0 DD 6E 1C
    ld     de,$03f3        ; 0002C3 11 F3 03
    ld     b,$04           ; 0002C6 06 04
    ld     c,(ix+$19)      ; 0002C8 DD 4E 19

@loop:
    push   af              ; 0002CB F5
    sra    c               ; 0002CC CB 29
    push   bc              ; 0002CE C5
	jr	nc,@skipReg
    add    a,(hl)          ; 0002D1 86
    and    $7f             ; 0002D2 E6 7F
    ld     c,a             ; 0002D4 4F
    ld     a,(de)          ; 0002D5 1A
	call	zWriteFMIorII

@skipReg:
    pop    bc              ; 0002D9 C1
    inc    de              ; 0002DA 13
    inc    hl              ; 0002DB 23
    pop    af              ; 0002DC F1
	djnz	@loop
	ret

zPrepareModulation:
    bit    7,(ix+$07)      ; 0002E0 DD CB 07 7E
    ret    z               ; 0002E4 C8
    bit    1,(ix+$00)      ; 0002E5 DD CB 00 4E
    ret    nz              ; 0002E9 C0
    ld     e,(ix+$20)      ; 0002EA DD 5E 20
    ld     d,(ix+$21)      ; 0002ED DD 56 21
    push   ix              ; 0002F0 DD E5
    pop    hl              ; 0002F2 E1
    ld     b,$00           ; 0002F3 06 00
    ld     c,$24           ; 0002F5 0E 24
    add    hl,bc           ; 0002F7 09
    ex     de,hl           ; 0002F8 EB
    ldi                    ; 0002F9 ED A0
    ldi                    ; 0002FB ED A0
    ldi                    ; 0002FD ED A0
    ld     a,(hl)          ; 0002FF 7E
    srl    a               ; 000300 CB 3F
    ld     (de),a          ; 000302 12
    xor    a               ; 000303 AF
    ld     (ix+$22),a      ; 000304 DD 77 22
    ld     (ix+$23),a      ; 000307 DD 77 23
	ret

zDoModulation:
    ld     a,(ix+$07)      ; 00030B DD 7E 07
    or     a               ; 00030E B7
    ret    z               ; 00030F C8
    cp     $80             ; 000310 FE 80
	jr	nz,zDoModEnvelope
    dec    (ix+$24)        ; 000314 DD 35 24
    ret    nz              ; 000317 C0
    inc    (ix+$24)        ; 000318 DD 34 24
    push   hl              ; 00031B E5
    ld     l,(ix+$22)      ; 00031C DD 6E 22
    ld     h,(ix+$23)      ; 00031F DD 66 23
    ld     e,(ix+$20)      ; 000322 DD 5E 20
    ld     d,(ix+$21)      ; 000325 DD 56 21
    push   de              ; 000328 D5
    pop    iy              ; 000329 FD E1
    dec    (ix+$25)        ; 00032B DD 35 25
	jr	nz,@modSustain
    ld     a,(iy+$01)      ; 000330 FD 7E 01
    ld     (ix+$25),a      ; 000333 DD 77 25
    ld     a,(ix+$26)      ; 000336 DD 7E 26
    ld     c,a             ; 000339 4F
    and    $80             ; 00033A E6 80
    rlca                   ; 00033C 07
    neg                    ; 00033D ED 44
    ld     b,a             ; 00033F 47
    add    hl,bc           ; 000340 09
    ld     (ix+$22),l      ; 000341 DD 75 22
    ld     (ix+$23),h      ; 000344 DD 74 23

@modSustain:
    pop    bc              ; 000347 C1
    add    hl,bc           ; 000348 09
    dec    (ix+$27)        ; 000349 DD 35 27
    ret    nz              ; 00034C C0
    ld     a,(iy+$03)      ; 00034D FD 7E 03
    ld     (ix+$27),a      ; 000350 DD 77 27
    ld     a,(ix+$26)      ; 000353 DD 7E 26
    neg                    ; 000356 ED 44
    ld     (ix+$26),a      ; 000358 DD 77 26
	ret

zDoModEnvelope:
    dec    a               ; 00035C 3D
    ex     de,hl           ; 00035D EB
    ld     c,$08           ; 00035E 0E 08
	rst	zGetPointerTable
	rst	zPointerTableOffset
	jr	zDoModEnvelope_cont

zModEnvSetIndex:
    ld     (ix+$25),a      ; 000364 DD 77 25

zDoModEnvelope_cont:
    push   hl              ; 000367 E5
    ld     c,(ix+$25)      ; 000368 DD 4E 25
    ld     b,$00           ; 00036B 06 00
    add    hl,bc           ; 00036D 09
    ld     a,(hl)          ; 00036E 7E
    pop    hl              ; 00036F E1
    bit    7,a             ; 000370 CB 7F
	jp	z,zPositiveModEnvMod
    cp     $82             ; 000375 FE 82
	jr	z,zChangeModEnvIndex
    cp     $80             ; 000379 FE 80
	jr	z,zResetModEnvMod
    cp     $84             ; 00037D FE 84
	jr	z,zModEnvIncMultiplier
    ld     h,$ff           ; 000381 26 FF
	jr	nc,zApplyModEnvMod
    set    6,(ix+$00)      ; 000385 DD CB 00 F6
    pop    hl              ; 000389 E1
    ret                    ; 00038A C9

zChangeModEnvIndex:
    inc    bc              ; 00038B 03
    ld     a,(bc)          ; 00038C 0A
	jr	zModEnvSetIndex

zResetModEnvMod:
    xor    a               ; 00038F AF
	jr	zModEnvSetIndex

zModEnvIncMultiplier:
    inc    bc              ; 000392 03
    ld     a,(bc)          ; 000393 0A
    add    a,(ix+$22)      ; 000394 DD 86 22
    ld     (ix+$22),a      ; 000397 DD 77 22
    inc    (ix+$25)        ; 00039A DD 34 25
    inc    (ix+$25)        ; 00039D DD 34 25
	jr	zDoModEnvelope_cont

zPositiveModEnvMod:
    ld     h,$00           ; 0003A2 26 00

zApplyModEnvMod:
    ld     l,a             ; 0003A4 6F
    ld     b,(ix+$22)      ; 0003A5 DD 46 22
    inc    b               ; 0003A8 04
    ex     de,hl           ; 0003A9 EB

@loop:
    add    hl,de           ; 0003AA 19
	djnz	@loop
    inc    (ix+$25)        ; 0003AD DD 34 25
    ret                    ; 0003B0 C9

zUpdateFreq:
    ld     h,(ix+$0e)      ; 0003B1 DD 66 0E
    ld     l,(ix+$0d)      ; 0003B4 DD 6E 0D
    ld     b,$00           ; 0003B7 06 00
    ld     a,(ix+$10)      ; 0003B9 DD 7E 10
    or     a               ; 0003BC B7
	jp	p,@didSignExtend
    ld     b,$ff           ; 0003C0 06 FF

@didSignExtend:
    ld     c,a             ; 0003C2 4F
    add    hl,bc           ; 0003C3 09
    ret                    ; 0003C4 C9
    ld     hl,($1c37)      ; 0003C5 2A 37 1C
    ld     a,($1c19)       ; 0003C8 3A 19 1C
    or     a               ; 0003CB B7
	jr	z,zGetFMInstrumentPointer
    ld     l,(ix+$2a)      ; 0003CE DD 6E 2A
    ld     h,(ix+$2b)      ; 0003D1 DD 66 2B

zGetFMInstrumentPointer:
    xor    a               ; 0003D4 AF
    or     b               ; 0003D5 B0
    ret    z               ; 0003D6 C8
    ld     de,$0019        ; 0003D7 11 19 00

@loop:
    add    hl,de           ; 0003DA 19
	djnz	@loop
	ret

zFMInstrumentRegTable:
	db	$B0

zFMInstrumentOperatorTable:
	db	$30
	db	$38
	db	$34
	db	$3C

zFMInstrumentRSARTable:
	db	$50
	db	$58
	db	$54
	db	$5C

zFMInstrumentAMD1RTable:
	db	$60
	db	$68
	db	$64
	db	$6C

    ld     (hl),b          ; 0003EB 70
    ld     a,b             ; 0003EC 78
    ld     (hl),h          ; 0003ED 74
    ld     a,h             ; 0003EE 7C
    add    a,b             ; 0003EF 80
    adc    a,b             ; 0003F0 88
    add    a,h             ; 0003F1 84
    adc    a,h             ; 0003F2 8C
    ld     b,b             ; 0003F3 40
    ld     c,b             ; 0003F4 48
    ld     b,h             ; 0003F5 44
    ld     c,h             ; 0003F6 4C
    sub    b               ; 0003F7 90
    sbc    a,b             ; 0003F8 98
    sub    h               ; 0003F9 94
    sbc    a,h             ; 0003FA 9C

zSendFMInstrument:
	ld	de,zFMInstrumentRegTable
    ld     c,(ix+$0a)      ; 0003FE DD 4E 0A
    ld     a,$b4           ; 000401 3E B4
	call	zWriteFMIorII
    call   $041c           ; 000406 CD 1C 04
    ld     (ix+$1b),a      ; 000409 DD 77 1B
    ld     b,$14           ; 00040C 06 14
    call   $041c           ; 00040E CD 1C 04
    djnz   $040e           ; 000411 10 FB
    ld     (ix+$1c),l      ; 000413 DD 75 1C
    ld     (ix+$1d),h      ; 000416 DD 74 1D
    jp     $0a1c           ; 000419 C3 1C 0A
    ld     a,(de)          ; 00041C 1A
    inc    de              ; 00041D 13
    ld     c,(hl)          ; 00041E 4E
    inc    hl              ; 00041F 23
	call	zWriteFMIorII
    ret                    ; 000423 C9
    ld     a,($1c09)       ; 000424 3A 09 1C
    cp     $ff             ; 000427 FE FF
    jp     z,$0816         ; 000429 CA 16 08
    cp     $32             ; 00042C FE 32
    jp     c,$0477         ; 00042E DA 77 04
    cp     $da             ; 000431 FE DA
    jp     c,$0547         ; 000433 DA 47 05
    cp     $e0             ; 000436 FE E0
    jp     c,$072c         ; 000438 DA 2C 07
    cp     $f0             ; 00043B FE F0
    jp     nc,$072c        ; 00043D D2 2C 07
    sub    $e0             ; 000440 D6 E0
    ld     hl,$044b        ; 000442 21 4B 04
	rst	zPointerTableOffset
    xor    a               ; 000446 AF
    ld     ($1c18),a       ; 000447 32 18 1C
    jp     (hl)            ; 00044A E9
    xor    h               ; 00044B AC
    ld     b,$2c           ; 00044C 06 2C
    rlca                   ; 00044E 07
    and    b               ; 00044F A0
    rlca                   ; 000450 07
    ld     d,e             ; 000451 53
    inc    b               ; 000452 04
    ld     ix,$1df0        ; 000453 DD 21 F0 1D
    ld     b,$07           ; 000457 06 07
    ld     a,$01           ; 000459 3E 01
    ld     ($1c19),a       ; 00045B 32 19 1C
    push   bc              ; 00045E C5
    bit    7,(ix+$00)      ; 00045F DD CB 00 7E
    call   nz,$0472        ; 000463 C4 72 04
    ld     de,$0030        ; 000466 11 30 00
    add    ix,de           ; 000469 DD 19
    pop    bc              ; 00046B C1
    djnz   $045e           ; 00046C 10 F0
    call   $052e           ; 00046E CD 2E 05
    ret                    ; 000471 C9
    push   hl              ; 000472 E5
    push   hl              ; 000473 E5
    jp     $09e1           ; 000474 C3 E1 09
    sub    $01             ; 000477 D6 01
    ret    m               ; 000479 F8
    push   af              ; 00047A F5
    call   $072c           ; 00047B CD 2C 07
    pop    af              ; 00047E F1
    push   af              ; 00047F F5
    ld     hl,$08dd        ; 000480 21 DD 08
    add    a,l             ; 000483 85
    ld     l,a             ; 000484 6F
    adc    a,h             ; 000485 8C
    sub    l               ; 000486 95
    ld     h,a             ; 000487 67
    ld     ($048c),hl      ; 000488 22 8C 04
    ld     a,($08dd)       ; 00048B 3A DD 08
    ld     ($1c04),a       ; 00048E 32 04 1C
    ld     hl,$6000        ; 000491 21 00 60
    ld     (hl),a          ; 000494 77
    rra                    ; 000495 1F
    ld     (hl),a          ; 000496 77
    rra                    ; 000497 1F
    ld     (hl),a          ; 000498 77
    rra                    ; 000499 1F
    ld     (hl),a          ; 00049A 77
    xor    a               ; 00049B AF
    ld     d,$01           ; 00049C 16 01
    ld     (hl),d          ; 00049E 72
    ld     (hl),a          ; 00049F 77
    ld     (hl),a          ; 0004A0 77
    ld     (hl),a          ; 0004A1 77
    ld     (hl),a          ; 0004A2 77
    ld     a,$b6           ; 0004A3 3E B6
    ld     ($4002),a       ; 0004A5 32 02 40
    nop                    ; 0004A8 00
    ld     a,$c0           ; 0004A9 3E C0
    ld     ($4003),a       ; 0004AB 32 03 40
    pop    af              ; 0004AE F1
    ld     c,$04           ; 0004AF 0E 04
	rst	zGetPointerTable
	rst	zPointerTableOffset
    push   hl              ; 0004B3 E5
    push   hl              ; 0004B4 E5
    rst    20h             ; 0004B5 E7
    ld     ($1c37),hl      ; 0004B6 22 37 1C
    pop    hl              ; 0004B9 E1
    pop    iy              ; 0004BA FD E1
    ld     a,(iy+$05)      ; 0004BC FD 7E 05
    ld     ($1c13),a       ; 0004BF 32 13 1C
    ld     ($1c05),a       ; 0004C2 32 05 1C
    ld     de,$0006        ; 0004C5 11 06 00
    add    hl,de           ; 0004C8 19
    ld     ($1c33),hl      ; 0004C9 22 33 1C
    ld     hl,$0533        ; 0004CC 21 33 05
    ld     ($1c35),hl      ; 0004CF 22 35 1C
    ld     de,$1c40        ; 0004D2 11 40 1C
    ld     b,(iy+$02)      ; 0004D5 FD 46 02
    ld     a,(iy+$04)      ; 0004D8 FD 7E 04
    push   bc              ; 0004DB C5
    ld     hl,($1c35)      ; 0004DC 2A 35 1C
    ldi                    ; 0004DF ED A0
    ldi                    ; 0004E1 ED A0
    ld     (de),a          ; 0004E3 12
    inc    de              ; 0004E4 13
    ld     ($1c35),hl      ; 0004E5 22 35 1C
    ld     hl,($1c33)      ; 0004E8 2A 33 1C
    ldi                    ; 0004EB ED A0
    ldi                    ; 0004ED ED A0
    ldi                    ; 0004EF ED A0
    ldi                    ; 0004F1 ED A0
    ld     ($1c33),hl      ; 0004F3 22 33 1C
    call   $0615           ; 0004F6 CD 15 06
    pop    bc              ; 0004F9 C1
    djnz   $04db           ; 0004FA 10 DF
    ld     a,(iy+$03)      ; 0004FC FD 7E 03
    or     a               ; 0004FF B7
    jp     z,$052e         ; 000500 CA 2E 05
    ld     b,a             ; 000503 47
    ld     hl,$0541        ; 000504 21 41 05
    ld     ($1c35),hl      ; 000507 22 35 1C
    ld     de,$1d60        ; 00050A 11 60 1D
    ld     a,(iy+$04)      ; 00050D FD 7E 04
    push   bc              ; 000510 C5
    ld     hl,($1c35)      ; 000511 2A 35 1C
    ldi                    ; 000514 ED A0
    ldi                    ; 000516 ED A0
    ld     (de),a          ; 000518 12
    inc    de              ; 000519 13
    ld     ($1c35),hl      ; 00051A 22 35 1C
    ld     hl,($1c33)      ; 00051D 2A 33 1C
    ld     bc,$0006        ; 000520 01 06 00
    ldir                   ; 000523 ED B0
    ld     ($1c33),hl      ; 000525 22 33 1C
    call   $061c           ; 000528 CD 1C 06
    pop    bc              ; 00052B C1
    djnz   $0510           ; 00052C 10 E2
    xor    a               ; 00052E AF
    ld     ($1c09),a       ; 00052F 32 09 1C
    ret                    ; 000532 C9
    add    a,b             ; 000533 80
    ld     b,$80           ; 000534 06 80
    nop                    ; 000536 00
    add    a,b             ; 000537 80
    ld     bc,$0280        ; 000538 01 80 02
    add    a,b             ; 00053B 80
    inc    b               ; 00053C 04
    add    a,b             ; 00053D 80
    dec    b               ; 00053E 05
    add    a,b             ; 00053F 80
    ld     b,$80           ; 000540 06 80
    add    a,b             ; 000542 80
    add    a,b             ; 000543 80
    and    b               ; 000544 A0
    add    a,b             ; 000545 80
    ret    nz              ; 000546 C0
    sub    $32             ; 000547 D6 32
    ex     af,af          ; 000549 08
    ld     hl,$6000        ; 00054A 21 00 60
    xor    a               ; 00054D AF
    ld     e,$01           ; 00054E 1E 01
    ld     (hl),e          ; 000550 73
    ld     (hl),a          ; 000551 77
    ld     (hl),e          ; 000552 73
    ld     (hl),e          ; 000553 73
    ld     (hl),e          ; 000554 73
    ld     (hl),a          ; 000555 77
    ld     (hl),a          ; 000556 77
    ld     (hl),a          ; 000557 77
    ld     (hl),a          ; 000558 77
    xor    a               ; 000559 AF
    ld     c,$06           ; 00055A 0E 06
    ld     ($1c19),a       ; 00055C 32 19 1C
    ex     af,af          ; 00055F 08
	rst	zGetPointerTable
	rst	zPointerTableOffset
    push   hl              ; 000562 E5
    rst    20h             ; 000563 E7
    ld     ($1c39),hl      ; 000564 22 39 1C
    xor    a               ; 000567 AF
    ld     ($1c15),a       ; 000568 32 15 1C
    pop    hl              ; 00056B E1
    push   hl              ; 00056C E5
    pop    iy              ; 00056D FD E1
    ld     a,(iy+$02)      ; 00056F FD 7E 02
    ld     ($1c3b),a       ; 000572 32 3B 1C
    ld     de,$0004        ; 000575 11 04 00
    add    hl,de           ; 000578 19
    ld     b,(iy+$03)      ; 000579 FD 46 03
    push   bc              ; 00057C C5
    push   hl              ; 00057D E5
    inc    hl              ; 00057E 23
    ld     c,(hl)          ; 00057F 4E
    call   $05df           ; 000580 CD DF 05
    set    2,(hl)          ; 000583 CB D6
    push   ix              ; 000585 DD E5
    ld     a,($1c19)       ; 000587 3A 19 1C
    or     a               ; 00058A B7
    jr     z,$0590         ; 00058B 28 03
    pop    hl              ; 00058D E1
    push   iy              ; 00058E FD E5
    pop    de              ; 000590 D1
    pop    hl              ; 000591 E1
    ldi                    ; 000592 ED A0
    ld     a,(de)          ; 000594 1A
    cp     $02             ; 000595 FE 02
    call   z,$075d         ; 000597 CC 5D 07
    ldi                    ; 00059A ED A0
    ld     a,($1c3b)       ; 00059C 3A 3B 1C
    ld     (de),a          ; 00059F 12
    inc    de              ; 0005A0 13
    ldi                    ; 0005A1 ED A0
    ldi                    ; 0005A3 ED A0
    ldi                    ; 0005A5 ED A0
    ldi                    ; 0005A7 ED A0
    call   $0615           ; 0005A9 CD 15 06
    bit    7,(ix+$00)      ; 0005AC DD CB 00 7E
    jr     z,$05be         ; 0005B0 28 0C
    ld     a,(ix+$01)      ; 0005B2 DD 7E 01
    cp     (iy+$01)        ; 0005B5 FD BE 01
    jr     nz,$05be        ; 0005B8 20 04
    set    2,(iy+$00)      ; 0005BA FD CB 00 D6
    push   hl              ; 0005BE E5
    ld     hl,($1c39)      ; 0005BF 2A 39 1C
    ld     a,($1c19)       ; 0005C2 3A 19 1C
    or     a               ; 0005C5 B7
    jr     z,$05cc         ; 0005C6 28 04
    push   iy              ; 0005C8 FD E5
    pop    ix              ; 0005CA DD E1
    ld     (ix+$2a),l      ; 0005CC DD 75 2A
    ld     (ix+$2b),h      ; 0005CF DD 74 2B
	call	zKeyOffIfActive
    call   $076a           ; 0005D5 CD 6A 07
    pop    hl              ; 0005D8 E1
    pop    bc              ; 0005D9 C1
    djnz   $057c           ; 0005DA 10 A0
    jp     $052e           ; 0005DC C3 2E 05
    bit    7,c             ; 0005DF CB 79
    jr     nz,$05eb        ; 0005E1 20 08
    ld     a,c             ; 0005E3 79
    bit    2,a             ; 0005E4 CB 57
    jr     z,$0602         ; 0005E6 28 1A
    dec    a               ; 0005E8 3D
    jr     $0602           ; 0005E9 18 17
    ld     a,$1f           ; 0005EB 3E 1F
    call   $0d98           ; 0005ED CD 98 0D
    ld     a,$ff           ; 0005F0 3E FF
    ld     ($7f11),a       ; 0005F2 32 11 7F
    ld     a,c             ; 0005F5 79
    srl    a               ; 0005F6 CB 3F
    srl    a               ; 0005F8 CB 3F
    srl    a               ; 0005FA CB 3F
    srl    a               ; 0005FC CB 3F
    srl    a               ; 0005FE CB 3F
    add    a,$02           ; 000600 C6 02
    sub    $02             ; 000602 D6 02
    ld     ($1c32),a       ; 000604 32 32 1C
    push   af              ; 000607 F5
    ld     hl,$062f        ; 000608 21 2F 06
	rst	zPointerTableOffset
    push   hl              ; 00060C E5
    pop    ix              ; 00060D DD E1
    pop    af              ; 00060F F1
    ld     hl,$063f        ; 000610 21 3F 06
	rst	zPointerTableOffset
    ret                    ; 000614 C9
    ex     af,af          ; 000615 08
    xor    a               ; 000616 AF
    ld     (de),a          ; 000617 12
    inc    de              ; 000618 13
    ld     (de),a          ; 000619 12
    inc    de              ; 00061A 13
    ex     af,af          ; 00061B 08
    ex     de,hl           ; 00061C EB
    ld     (hl),$30        ; 00061D 36 30
    inc    hl              ; 00061F 23
    ld     (hl),$c0        ; 000620 36 C0
    inc    hl              ; 000622 23
    ld     (hl),$01        ; 000623 36 01
    ld     b,$24           ; 000625 06 24
    inc    hl              ; 000627 23
    ld     (hl),$00        ; 000628 36 00
    djnz   $0627           ; 00062A 10 FB
    inc    hl              ; 00062C 23
    ex     de,hl           ; 00062D EB
    ret                    ; 00062E C9
    ret    p               ; 00062F F0
    dec    e               ; 000630 1D
    jr     nz,$0651        ; 000631 20 1E
    ld     d,b             ; 000633 50
    ld     e,$80           ; 000634 1E 80
    ld     e,$b0           ; 000636 1E B0
    ld     e,$e0           ; 000638 1E E0
    ld     e,$10           ; 00063A 1E 10
    rra                    ; 00063C 1F
    djnz   $065e           ; 00063D 10 1F
    ret    nc              ; 00063F D0
    inc    e               ; 000640 1C
    nop                    ; 000641 00
    dec    e               ; 000642 1D
    jr     nc,$0662        ; 000643 30 1D
    ld     b,b             ; 000645 40
    inc    e               ; 000646 1C
    ld     h,b             ; 000647 60
    dec    e               ; 000648 1D
    sub    b               ; 000649 90
    dec    e               ; 00064A 1D
    ret    nz              ; 00064B C0
    dec    e               ; 00064C 1D
    ret    nz              ; 00064D C0
    dec    e               ; 00064E 1D
    ld     hl,$1c10        ; 00064F 21 10 1C
    ld     a,(hl)          ; 000652 7E
    or     a               ; 000653 B7
    ret    z               ; 000654 C8
    jp     m,$0660         ; 000655 FA 60 06
    pop    de              ; 000658 D1
    dec    a               ; 000659 3D
    ret    nz              ; 00065A C0
    ld     (hl),$02        ; 00065B 36 02
    jp     $0771           ; 00065D C3 71 07
    xor    a               ; 000660 AF
    ld     (hl),a          ; 000661 77
    ld     a,($1c0d)       ; 000662 3A 0D 1C
    or     a               ; 000665 B7
    jp     nz,$072c        ; 000666 C2 2C 07
    ld     ix,$1c70        ; 000669 DD 21 70 1C
    ld     b,$06           ; 00066D 06 06
    ld     a,($1c11)       ; 00066F 3A 11 1C
    or     a               ; 000672 B7
    jr     nz,$067b        ; 000673 20 06
    bit    7,(ix+$00)      ; 000675 DD CB 00 7E
    jr     z,$0683         ; 000679 28 08
    ld     c,(ix+$0a)      ; 00067B DD 4E 0A
    ld     a,$b4           ; 00067E 3E B4
	call	zWriteFMIorII
    ld     de,$0030        ; 000683 11 30 00
    add    ix,de           ; 000686 DD 19
    djnz   $066f           ; 000688 10 E5
    ld     ix,$1f40        ; 00068A DD 21 40 1F
    ld     b,$07           ; 00068E 06 07
    bit    7,(ix+$00)      ; 000690 DD CB 00 7E
    jr     z,$06a4         ; 000694 28 0E
    bit    7,(ix+$01)      ; 000696 DD CB 01 7E
    jr     nz,$06a4        ; 00069A 20 08
    ld     c,(ix+$0a)      ; 00069C DD 4E 0A
    ld     a,$b4           ; 00069F 3E B4
	call	zWriteFMIorII
    ld     de,$0030        ; 0006A4 11 30 00
    add    ix,de           ; 0006A7 DD 19
    djnz   $0690           ; 0006A9 10 E5
    ret                    ; 0006AB C9

zFadeOutMusic:
    ld     a,$28           ; 0006AC 3E 28
    ld     ($1c0d),a       ; 0006AE 32 0D 1C
    ld     a,$06           ; 0006B1 3E 06
    ld     ($1c0f),a       ; 0006B3 32 0F 1C
    ld     ($1c0e),a       ; 0006B6 32 0E 1C

zHaltDACPSG:
    xor    a               ; 0006B9 AF
    ld     ($1c40),a       ; 0006BA 32 40 1C
    ld     ($1dc0),a       ; 0006BD 32 C0 1D
    ld     ($1d60),a       ; 0006C0 32 60 1D
    ld     ($1d90),a       ; 0006C3 32 90 1D
    jp     $07a0           ; 0006C6 C3 A0 07

zDoMusicFadeOut:
    ld     hl,$1c0d        ; 0006C9 21 0D 1C
    ld     a,(hl)          ; 0006CC 7E
    or     a               ; 0006CD B7
    ret    z               ; 0006CE C8
	call	m,zHaltDACPSG
    res    7,(hl)          ; 0006D2 CB BE
    ld     a,($1c0f)       ; 0006D4 3A 0F 1C
    dec    a               ; 0006D7 3D
    jr     z,$06de         ; 0006D8 28 04
    ld     ($1c0f),a       ; 0006DA 32 0F 1C
    ret                    ; 0006DD C9
    ld     a,($1c0e)       ; 0006DE 3A 0E 1C
    ld     ($1c0f),a       ; 0006E1 32 0F 1C
    ld     a,($1c0d)       ; 0006E4 3A 0D 1C
    dec    a               ; 0006E7 3D
    ld     ($1c0d),a       ; 0006E8 32 0D 1C
    jr     z,$072c         ; 0006EB 28 3F
    ld     a,($1c04)       ; 0006ED 3A 04 1C
    ld     hl,$6000        ; 0006F0 21 00 60
    ld     (hl),a          ; 0006F3 77
    rra                    ; 0006F4 1F
    ld     (hl),a          ; 0006F5 77
    rra                    ; 0006F6 1F
    ld     (hl),a          ; 0006F7 77
    rra                    ; 0006F8 1F
    ld     (hl),a          ; 0006F9 77
    xor    a               ; 0006FA AF
    ld     d,$01           ; 0006FB 16 01
    ld     (hl),d          ; 0006FD 72
    ld     (hl),a          ; 0006FE 77
    ld     (hl),a          ; 0006FF 77
    ld     (hl),a          ; 000700 77
    ld     (hl),a          ; 000701 77
    ld     ix,$1c40        ; 000702 DD 21 40 1C
    ld     b,$06           ; 000706 06 06
    inc    (ix+$06)        ; 000708 DD 34 06
    jp     p,$0713         ; 00070B F2 13 07
    dec    (ix+$06)        ; 00070E DD 35 06
    jr     $0724           ; 000711 18 11
    bit    7,(ix+$00)      ; 000713 DD CB 00 7E
    jr     z,$0724         ; 000717 28 0B
    bit    2,(ix+$00)      ; 000719 DD CB 00 56
    jr     nz,$0724        ; 00071D 20 05
    push   bc              ; 00071F C5
    call   $0a1c           ; 000720 CD 1C 0A
    pop    bc              ; 000723 C1
    ld     de,$0030        ; 000724 11 30 00
    add    ix,de           ; 000727 DD 19
    djnz   $0708           ; 000729 10 DD
    ret                    ; 00072B C9
    ld     hl,$1c09        ; 00072C 21 09 1C
    ld     de,$1c0a        ; 00072F 11 0A 1C
    ld     bc,$0336        ; 000732 01 36 03
    ld     (hl),$00        ; 000735 36 00
    ldir                   ; 000737 ED B0
    ld     ix,$0533        ; 000739 DD 21 33 05
    ld     b,$06           ; 00073D 06 06
    push   bc              ; 00073F C5
    call   $07f6           ; 000740 CD F6 07
    call   $076a           ; 000743 CD 6A 07
    inc    ix              ; 000746 DD 23
    inc    ix              ; 000748 DD 23
    pop    bc              ; 00074A C1
    djnz   $073f           ; 00074B 10 F2
    ld     b,$07           ; 00074D 06 07
    xor    a               ; 00074F AF
    ld     ($1c0d),a       ; 000750 32 0D 1C
    call   $07a0           ; 000753 CD A0 07
    ld     c,$00           ; 000756 0E 00
    ld     a,$2b           ; 000758 3E 2B
	call	zWriteFMI
    xor    a               ; 00075D AF
    ld     ($1c12),a       ; 00075E 32 12 1C
    ld     c,a             ; 000761 4F
    ld     a,$27           ; 000762 3E 27
	call	zWriteFMI
    jp     $052e           ; 000767 C3 2E 05
    ld     a,$90           ; 00076A 3E 90
    ld     c,$00           ; 00076C 0E 00
    jp     $080a           ; 00076E C3 0A 08
    call   $07a0           ; 000771 CD A0 07
    push   bc              ; 000774 C5
    push   af              ; 000775 F5
    ld     b,$03           ; 000776 06 03
    ld     a,$b4           ; 000778 3E B4
    ld     c,$00           ; 00077A 0E 00
    push   af              ; 00077C F5
	call	zWriteFMI
    pop    af              ; 000780 F1
    inc    a               ; 000781 3C
    djnz   $077c           ; 000782 10 F8
    ld     b,$02           ; 000784 06 02
    ld     a,$b4           ; 000786 3E B4
    push   af              ; 000788 F5
	call	zWriteFMII
    pop    af              ; 00078C F1
    inc    a               ; 00078D 3C
    djnz   $0788           ; 00078E 10 F8
    ld     c,$00           ; 000790 0E 00
    ld     b,$06           ; 000792 06 06
    ld     a,$28           ; 000794 3E 28
    push   af              ; 000796 F5
	call	zWriteFMI
    inc    c               ; 00079A 0C
    pop    af              ; 00079B F1
    djnz   $0796           ; 00079C 10 F8
    pop    af              ; 00079E F1
    pop    bc              ; 00079F C1
    push   bc              ; 0007A0 C5
    ld     b,$04           ; 0007A1 06 04
    ld     a,$9f           ; 0007A3 3E 9F
    ld     ($7f11),a       ; 0007A5 32 11 7F
    add    a,$20           ; 0007A8 C6 20
    djnz   $07a5           ; 0007AA 10 F9
    pop    bc              ; 0007AC C1
    jp     $052e           ; 0007AD C3 2E 05
    ld     a,($1c05)       ; 0007B0 3A 05 1C
    ld     hl,$1c13        ; 0007B3 21 13 1C
    add    a,(hl)          ; 0007B6 86
    ld     (hl),a          ; 0007B7 77
    ret    nc              ; 0007B8 D0
    ld     hl,$1c4b        ; 0007B9 21 4B 1C
    ld     de,$0030        ; 0007BC 11 30 00
    ld     b,$09           ; 0007BF 06 09
    inc    (hl)            ; 0007C1 34
    add    hl,de           ; 0007C2 19
    djnz   $07c1           ; 0007C3 10 FC
    ret                    ; 0007C5 C9
    ld     a,r             ; 0007C6 ED 5F
    ld     ($1c17),a       ; 0007C8 32 17 1C
    ld     de,$1c0a        ; 0007CB 11 0A 1C
    call   $07d4           ; 0007CE CD D4 07
    call   $07d4           ; 0007D1 CD D4 07
    ld     a,(de)          ; 0007D4 1A
    or     a               ; 0007D5 B7
    ret    z               ; 0007D6 C8
    sub    $01             ; 0007D7 D6 01
    ld     c,$00           ; 0007D9 0E 00
	rst	zGetPointerTable
    ld     c,a             ; 0007DC 4F
    ld     b,$00           ; 0007DD 06 00
    add    hl,bc           ; 0007DF 09
    ld     a,($1c18)       ; 0007E0 3A 18 1C
    cp     (hl)            ; 0007E3 BE
    jr     z,$07e8         ; 0007E4 28 02
    jr     nc,$07f2        ; 0007E6 30 0A
    ld     a,(de)          ; 0007E8 1A
    ld     ($1c09),a       ; 0007E9 32 09 1C
    ld     a,(hl)          ; 0007EC 7E
    and    $7f             ; 0007ED E6 7F
    ld     ($1c18),a       ; 0007EF 32 18 1C
    xor    a               ; 0007F2 AF
    ld     (de),a          ; 0007F3 12
    inc    de              ; 0007F4 13
    ret                    ; 0007F5 C9
    call   $0806           ; 0007F6 CD 06 08
    ld     a,$40           ; 0007F9 3E 40
    ld     c,$7f           ; 0007FB 0E 7F
    call   $080a           ; 0007FD CD 0A 08
    ld     c,(ix+$01)      ; 000800 DD 4E 01
	jp	zKeyOnOff
    ld     a,$80           ; 000806 3E 80
    ld     c,$ff           ; 000808 0E FF
    ld     b,$04           ; 00080A 06 04
    push   af              ; 00080C F5
	call	zWriteFMIorII
    pop    af              ; 000810 F1
    add    a,$04           ; 000811 C6 04
    djnz   $080c           ; 000813 10 F7
    ret                    ; 000815 C9
    ld     a,$01           ; 000816 3E 01
    ld     ($1c07),a       ; 000818 32 07 1C
    pop    hl              ; 00081B E1
    ret                    ; 00081C C9
    rst    38h             ; 00081D FF
    inc    bc              ; 00081E 03
    rst    38h             ; 00081F FF
    inc    bc              ; 000820 03
    rst    38h             ; 000821 FF
    inc    bc              ; 000822 03
    rst    38h             ; 000823 FF
    inc    bc              ; 000824 03
    rst    38h             ; 000825 FF
    inc    bc              ; 000826 03
    rst    38h             ; 000827 FF
    inc    bc              ; 000828 03
    rst    38h             ; 000829 FF
    inc    bc              ; 00082A 03
    rst    38h             ; 00082B FF
    inc    bc              ; 00082C 03
    rst    38h             ; 00082D FF
    inc    bc              ; 00082E 03
    rst    30h             ; 00082F F7
    inc    bc              ; 000830 03
    cp     (hl)            ; 000831 BE
    inc    bc              ; 000832 03
    adc    a,b             ; 000833 88
    inc    bc              ; 000834 03
    ld     d,(hl)          ; 000835 56
    inc    bc              ; 000836 03
    ld     h,$03           ; 000837 26 03
    ld     sp,hl           ; 000839 F9
    ld     (bc),a          ; 00083A 02
    adc    a,$02           ; 00083B CE 02
    and    l               ; 00083D A5
    ld     (bc),a          ; 00083E 02
    add    a,b             ; 00083F 80
    ld     (bc),a          ; 000840 02
    ld     e,h             ; 000841 5C
    ld     (bc),a          ; 000842 02
    ld     a,($1a02)       ; 000843 3A 02 1A
    ld     (bc),a          ; 000846 02
    ei                     ; 000847 FB
    ld     bc,$01df        ; 000848 01 DF 01
    call   nz,$ab01        ; 00084B C4 01 AB
    ld     bc,$0193        ; 00084E 01 93 01
    ld     a,l             ; 000851 7D
    ld     bc,$0167        ; 000852 01 67 01
    ld     d,e             ; 000855 53
    ld     bc,$0140        ; 000856 01 40 01
    ld     l,$01           ; 000859 2E 01
    dec    e               ; 00085B 1D
    ld     bc,$010d        ; 00085C 01 0D 01
    cp     $00             ; 00085F FE 00
    rst    28h             ; 000861 EF
    nop                    ; 000862 00
    jp     po,$d600        ; 000863 E2 00 D6
    nop                    ; 000866 00
    ret                    ; 000867 C9
    nop                    ; 000868 00
    cp     (hl)            ; 000869 BE
    nop                    ; 00086A 00
    or     h               ; 00086B B4
    nop                    ; 00086C 00
    xor    c               ; 00086D A9
    nop                    ; 00086E 00
    and    b               ; 00086F A0
    nop                    ; 000870 00
    sub    a               ; 000871 97
    nop                    ; 000872 00
    adc    a,a             ; 000873 8F
    nop                    ; 000874 00
    add    a,a             ; 000875 87
    nop                    ; 000876 00
    ld     a,a             ; 000877 7F
    nop                    ; 000878 00
    ld     a,b             ; 000879 78
    nop                    ; 00087A 00
    ld     (hl),c          ; 00087B 71
    nop                    ; 00087C 00
    ld     l,e             ; 00087D 6B
    nop                    ; 00087E 00
    ld     h,l             ; 00087F 65
    nop                    ; 000880 00
    ld     e,a             ; 000881 5F
    nop                    ; 000882 00
    ld     e,d             ; 000883 5A
    nop                    ; 000884 00
    ld     d,l             ; 000885 55
    nop                    ; 000886 00
    ld     d,b             ; 000887 50
    nop                    ; 000888 00
    ld     c,e             ; 000889 4B
    nop                    ; 00088A 00
    ld     b,a             ; 00088B 47
    nop                    ; 00088C 00
    ld     b,e             ; 00088D 43
    nop                    ; 00088E 00
    ld     b,b             ; 00088F 40
    nop                    ; 000890 00
    inc    a               ; 000891 3C
    nop                    ; 000892 00
    add    hl,sp           ; 000893 39
    nop                    ; 000894 00
    ld     (hl),$00        ; 000895 36 00
    inc    sp              ; 000897 33
    nop                    ; 000898 00
    jr     nc,$089b        ; 000899 30 00
    dec    l               ; 00089B 2D
    nop                    ; 00089C 00
    dec    hl              ; 00089D 2B
    nop                    ; 00089E 00
    jr     z,$08a1         ; 00089F 28 00
    ld     h,$00           ; 0008A1 26 00
    inc    h               ; 0008A3 24
    nop                    ; 0008A4 00
    ld     ($2000),hl      ; 0008A5 22 00 20
    nop                    ; 0008A8 00
    rra                    ; 0008A9 1F
    nop                    ; 0008AA 00
    dec    e               ; 0008AB 1D
    nop                    ; 0008AC 00
    dec    de              ; 0008AD 1B
    nop                    ; 0008AE 00
    ld     a,(de)          ; 0008AF 1A
    nop                    ; 0008B0 00
    jr     $08b3           ; 0008B1 18 00
    rla                    ; 0008B3 17
    nop                    ; 0008B4 00
    ld     d,$00           ; 0008B5 16 00
    dec    d               ; 0008B7 15
    nop                    ; 0008B8 00
    inc    de              ; 0008B9 13
    nop                    ; 0008BA 00
    ld     (de),a          ; 0008BB 12
    nop                    ; 0008BC 00
    ld     de,$1000        ; 0008BD 11 00 10
    nop                    ; 0008C0 00
    nop                    ; 0008C1 00
    nop                    ; 0008C2 00
    nop                    ; 0008C3 00
    nop                    ; 0008C4 00
    add    a,h             ; 0008C5 84
    ld     (bc),a          ; 0008C6 02
    xor    e               ; 0008C7 AB
    ld     (bc),a          ; 0008C8 02
    out    ($02),a         ; 0008C9 D3 02
    cp     $02             ; 0008CB FE 02
    dec    l               ; 0008CD 2D
    inc    bc              ; 0008CE 03
    ld     e,h             ; 0008CF 5C
    inc    bc              ; 0008D0 03
    adc    a,a             ; 0008D1 8F
    inc    bc              ; 0008D2 03
    push   bc              ; 0008D3 C5
    inc    bc              ; 0008D4 03
    rst    38h             ; 0008D5 FF
    inc    bc              ; 0008D6 03
    inc    a               ; 0008D7 3C
    inc    b               ; 0008D8 04
    ld     a,h             ; 0008D9 7C
    inc    b               ; 0008DA 04
    ret    nz              ; 0008DB C0
    inc    b               ; 0008DC 04
    ld     b,$06           ; 0008DD 06 06
    ld     b,$06           ; 0008DF 06 06
    ld     b,$06           ; 0008E1 06 06
    rlca                   ; 0008E3 07
    rlca                   ; 0008E4 07
    rlca                   ; 0008E5 07
    rlca                   ; 0008E6 07
    rlca                   ; 0008E7 07
    rlca                   ; 0008E8 07
    rlca                   ; 0008E9 07
    ex     af,af'          ; 0008EA 08
    ex     af,af'          ; 0008EB 08
    ex     af,af'          ; 0008EC 08
    ex     af,af'          ; 0008ED 08
    ex     af,af'          ; 0008EE 08
    ex     af,af'          ; 0008EF 08
    ex     af,af'          ; 0008F0 08
    ex     af,af'          ; 0008F1 08
    ex     af,af'          ; 0008F2 08
    add    hl,bc           ; 0008F3 09
    add    hl,bc           ; 0008F4 09
    add    hl,bc           ; 0008F5 09
    add    hl,bc           ; 0008F6 09
    add    hl,bc           ; 0008F7 09
    add    hl,bc           ; 0008F8 09
    add    hl,bc           ; 0008F9 09
    add    hl,bc           ; 0008FA 09
    add    hl,bc           ; 0008FB 09
    add    hl,bc           ; 0008FC 09
    add    hl,bc           ; 0008FD 09
    add    hl,bc           ; 0008FE 09
    ld     a,(bc)          ; 0008FF 0A
    ld     a,(bc)          ; 000900 0A
    ld     a,(bc)          ; 000901 0A
    ld     a,(bc)          ; 000902 0A
    ld     a,(bc)          ; 000903 0A
    ld     a,(bc)          ; 000904 0A
    ld     a,(bc)          ; 000905 0A
    ld     a,(bc)          ; 000906 0A
    ld     a,(bc)          ; 000907 0A
    ld     a,(bc)          ; 000908 0A
    ld     a,(bc)          ; 000909 0A
    ld     a,(bc)          ; 00090A 0A
    ld     a,(bc)          ; 00090B 0A
    dec    bc              ; 00090C 0B
    dec    bc              ; 00090D 0B
	call	zTrackRunTimer
    ret    nz              ; 000911 C0
    ld     e,(ix+$03)      ; 000912 DD 5E 03
    ld     d,(ix+$04)      ; 000915 DD 56 04
    ld     a,(de)          ; 000918 1A
    inc    de              ; 000919 13
    cp     $e0             ; 00091A FE E0
    jp     nc,$094e        ; 00091C D2 4E 09
    or     a               ; 00091F B7
    jp     m,$0927         ; 000920 FA 27 09
    dec    de              ; 000923 1B
    ld     a,(ix+$0d)      ; 000924 DD 7E 0D
    ld     (ix+$0d),a      ; 000927 DD 77 0D
    cp     $80             ; 00092A FE 80
    jp     z,$093e         ; 00092C CA 3E 09
    res    7,a             ; 00092F CB BF
    push   de              ; 000931 D5
    ex     af,af'          ; 000932 08
	call	zKeyOffIfActive
    call   $075d           ; 000936 CD 5D 07
    ex     af,af'          ; 000939 08
    ld     ($1c06),a       ; 00093A 32 06 1C
    pop    de              ; 00093D D1
    ld     a,(de)          ; 00093E 1A
    inc    de              ; 00093F 13
    or     a               ; 000940 B7
	jp	p,zStoreDuration
    dec    de              ; 000944 1B
    ld     a,(ix+$0c)      ; 000945 DD 7E 0C
    ld     (ix+$0b),a      ; 000948 DD 77 0B
	jp	zFinishTrackUpdate
    ld     hl,$0954        ; 00094E 21 54 09
    jp     $095b           ; 000951 C3 5B 09
    inc    de              ; 000954 13
    jp     $0918           ; 000955 C3 18 09
    ld     hl,$0964        ; 000958 21 64 09
    push   hl              ; 00095B E5
    sub    $e0             ; 00095C D6 E0
    ld     hl,$0968        ; 00095E 21 68 09
	rst	zPointerTableOffset
    ld     a,(de)          ; 000962 1A
    jp     (hl)            ; 000963 E9
    inc    de              ; 000964 13
    jp     $01c7           ; 000965 C3 C7 01
    cp     d               ; 000968 BA
    add    hl,bc           ; 000969 09
    exx                    ; 00096A D9
    add    hl,bc           ; 00096B 09
    add    ix,bc           ; 00096C DD 09
    pop    hl              ; 00096E E1
    add    hl,bc           ; 00096F 09
    rst    20h             ; 000970 E7
    add    hl,bc           ; 000971 09
    inc    bc              ; 000972 03
    ld     a,(bc)          ; 000973 0A
    dec    b               ; 000974 05
    ld     a,(bc)          ; 000975 0A
    dec    a               ; 000976 3D
    ld     a,(bc)          ; 000977 0A
    ld     b,e             ; 000978 43
    ld     a,(bc)          ; 000979 0A
    adc    a,$09           ; 00097A CE 09
    or     (hl)            ; 00097C B6
    add    hl,bc           ; 00097D 09
    ld     c,l             ; 00097E 4D
    ld     a,(bc)          ; 00097F 0A
    ld     h,e             ; 000980 63
    ld     a,(bc)          ; 000981 0A
    ld     a,l             ; 000982 7D
    ld     a,(bc)          ; 000983 0A
    add    a,e             ; 000984 83
    ld     a,(bc)          ; 000985 0A
    sub    b               ; 000986 90
    ld     a,(bc)          ; 000987 0A
	rst	zGetPointerTable
    ld     a,(bc)          ; 000989 0A
    db     $dd             ; 00098A DD
    ld     a,(bc)          ; 00098B 0A
    jp     pe,$830a        ; 00098C EA 0A 83
    dec    bc              ; 00098F 0B
    push   hl              ; 000990 E5
    ld     a,(bc)          ; 000991 0A
    and    d               ; 000992 A2
    dec    bc              ; 000993 0B
    xor    e               ; 000994 AB
    dec    bc              ; 000995 0B
    or     c               ; 000996 B1
    dec    bc              ; 000997 0B
    ret    z               ; 000998 C8
    dec    bc              ; 000999 0B
    jp     po,$f50b        ; 00099A E2 0B F5
    dec    bc              ; 00099D 0B
    ei                     ; 00099E FB
    dec    bc              ; 00099F 0B
    ld     (bc),a          ; 0009A0 02
    inc    c               ; 0009A1 0C
    inc    bc              ; 0009A2 03
    inc    c               ; 0009A3 0C
    ld     de,$580c        ; 0009A4 11 0C 58
    inc    c               ; 0009A7 0C
    ld     e,a             ; 0009A8 5F
    inc    c               ; 0009A9 0C
    ld     h,e             ; 0009AA 63
    inc    c               ; 0009AB 0C
    ld     l,e             ; 0009AC 6B
    inc    c               ; 0009AD 0C
    and    (hl)            ; 0009AE A6
    inc    c               ; 0009AF 0C
    or     h               ; 0009B0 B4
    inc    c               ; 0009B1 0C
    jp     $de0c           ; 0009B2 C3 0C DE
    inc    c               ; 0009B5 0C
    ld     ($1c06),a       ; 0009B6 32 06 1C
    ret                    ; 0009B9 C9
    ld     c,$3f           ; 0009BA 0E 3F
    ld     a,(ix+$0a)      ; 0009BC DD 7E 0A
    and    c               ; 0009BF A1
    push   de              ; 0009C0 D5
    ex     de,hl           ; 0009C1 EB
    or     (hl)            ; 0009C2 B6
    ld     (ix+$0a),a      ; 0009C3 DD 77 0A
    ld     c,a             ; 0009C6 4F
    ld     a,$b4           ; 0009C7 3E B4
	call	zWriteFMIorII
    pop    de              ; 0009CC D1
    ret                    ; 0009CD C9
    ld     a,(ix+$07)      ; 0009CE DD 7E 07
    or     a               ; 0009D1 B7
    ret    z               ; 0009D2 C8
    set    7,(ix+$07)      ; 0009D3 DD CB 07 FE
    dec    de              ; 0009D7 1B
    ret                    ; 0009D8 C9
    ld     (ix+$10),a      ; 0009D9 DD 77 10
    ret                    ; 0009DC C9
    ld     ($1c16),a       ; 0009DD 32 16 1C
    ret                    ; 0009E0 C9
    call   $07f6           ; 0009E1 CD F6 07
    jp     $0aea           ; 0009E4 C3 EA 0A
    bit    7,(ix+$01)      ; 0009E7 DD CB 01 7E
    jr     z,$09fa         ; 0009EB 28 0D
    srl    a               ; 0009ED CB 3F
    srl    a               ; 0009EF CB 3F
    srl    a               ; 0009F1 CB 3F
    xor    $0f             ; 0009F3 EE 0F
    and    $0f             ; 0009F5 E6 0F
    jp     $0a79           ; 0009F7 C3 79 0A
    xor    $7f             ; 0009FA EE 7F
    and    $7f             ; 0009FC E6 7F
    ld     (ix+$06),a      ; 0009FE DD 77 06
    jr     $0a1c           ; 000A01 18 19
    inc    de              ; 000A03 13
    ld     a,(de)          ; 000A04 1A
    bit    7,(ix+$01)      ; 000A05 DD CB 01 7E
    ret    nz              ; 000A09 C0
    add    a,(ix+$06)      ; 000A0A DD 86 06
    jp     p,$0a19         ; 000A0D F2 19 0A
    jp     pe,$0a17        ; 000A10 EA 17 0A
    xor    a               ; 000A13 AF
    jp     $0a19           ; 000A14 C3 19 0A
    ld     a,$7f           ; 000A17 3E 7F
    ld     (ix+$06),a      ; 000A19 DD 77 06
    push   de              ; 000A1C D5
    ld     de,$03f3        ; 000A1D 11 F3 03
    ld     l,(ix+$1c)      ; 000A20 DD 6E 1C
    ld     h,(ix+$1d)      ; 000A23 DD 66 1D
    ld     b,$04           ; 000A26 06 04
    ld     a,(hl)          ; 000A28 7E
    or     a               ; 000A29 B7
    jp     p,$0a30         ; 000A2A F2 30 0A
    add    a,(ix+$06)      ; 000A2D DD 86 06
    and    $7f             ; 000A30 E6 7F
    ld     c,a             ; 000A32 4F
    ld     a,(de)          ; 000A33 1A
	call	zWriteFMIorII
    inc    de              ; 000A37 13
    inc    hl              ; 000A38 23
    djnz   $0a28           ; 000A39 10 ED
    pop    de              ; 000A3B D1
    ret                    ; 000A3C C9
    set    1,(ix+$00)      ; 000A3D DD CB 00 CE
    dec    de              ; 000A41 1B
    ret                    ; 000A42 C9
	call	zComputeNoteDuration
    ld     (ix+$1e),a      ; 000A46 DD 77 1E
    ld     (ix+$1f),a      ; 000A49 DD 77 1F
    ret                    ; 000A4C C9
    inc    de              ; 000A4D 13
    add    a,$28           ; 000A4E C6 28
    ld     c,a             ; 000A50 4F
    ld     b,$00           ; 000A51 06 00
    push   ix              ; 000A53 DD E5
    pop    hl              ; 000A55 E1
    add    hl,bc           ; 000A56 09
    ld     a,(hl)          ; 000A57 7E
    dec    a               ; 000A58 3D
    jp     z,$0a5e         ; 000A59 CA 5E 0A
    inc    de              ; 000A5C 13
    ret                    ; 000A5D C9
    xor    a               ; 000A5E AF
    ld     (hl),a          ; 000A5F 77
    jp     $0bab           ; 000A60 C3 AB 0B
    bit    7,(ix+$01)      ; 000A63 DD CB 01 7E
    ret    z               ; 000A67 C8
    res    4,(ix+$00)      ; 000A68 DD CB 00 A6
    dec    (ix+$17)        ; 000A6C DD 35 17
    add    a,(ix+$06)      ; 000A6F DD 86 06
    cp     $0f             ; 000A72 FE 0F
    jp     c,$0a79         ; 000A74 DA 79 0A
    ld     a,$0f           ; 000A77 3E 0F
    ld     (ix+$06),a      ; 000A79 DD 77 06
    ret                    ; 000A7C C9
    sub    $40             ; 000A7D D6 40
    ld     (ix+$05),a      ; 000A7F DD 77 05
    ret                    ; 000A82 C9
    call   $0a8a           ; 000A83 CD 8A 0A
	call	zWriteFMI
    ret                    ; 000A89 C9
    ex     de,hl           ; 000A8A EB
    ld     a,(hl)          ; 000A8B 7E
    inc    hl              ; 000A8C 23
    ld     c,(hl)          ; 000A8D 4E
    ex     de,hl           ; 000A8E EB
    ret                    ; 000A8F C9
    bit    7,(ix+$01)      ; 000A90 DD CB 01 7E
    jr     nz,$0ac6        ; 000A94 20 30
    call   $0806           ; 000A96 CD 06 08
    ld     a,(de)          ; 000A99 1A
    ld     (ix+$08),a      ; 000A9A DD 77 08
    or     a               ; 000A9D B7
    jp     p,$0abc         ; 000A9E F2 BC 0A
    inc    de              ; 000AA1 13
    ld     a,(de)          ; 000AA2 1A
    ld     (ix+$0f),a      ; 000AA3 DD 77 0F
    push   de              ; 000AA6 D5
    ld     a,(ix+$0f)      ; 000AA7 DD 7E 0F
    sub    $81             ; 000AAA D6 81
    ld     c,$04           ; 000AAC 0E 04
	rst	zGetPointerTable
	rst	zPointerTableOffset
    rst    20h             ; 000AB0 E7
    ld     a,(ix+$08)      ; 000AB1 DD 7E 08
    and    $7f             ; 000AB4 E6 7F
    ld     b,a             ; 000AB6 47
	call	zGetFMInstrumentPointer
    jr     $0ac1           ; 000ABA 18 05
    push   de              ; 000ABC D5
    ld     b,a             ; 000ABD 47
    call   $03c5           ; 000ABE CD C5 03
	call	zSendFMInstrument
    pop    de              ; 000AC4 D1
    ret                    ; 000AC5 C9
    or     a               ; 000AC6 B7
    jp     p,$0ba7         ; 000AC7 F2 A7 0B
    inc    de              ; 000ACA 13
    jp     $0ba7           ; 000ACB C3 A7 0B
    ret                    ; 000ACE C9
    ld     (ix+$20),e      ; 000ACF DD 73 20
    ld     (ix+$21),d      ; 000AD2 DD 72 21
    ld     (ix+$07),$80    ; 000AD5 DD 36 07 80
    inc    de              ; 000AD9 13
    inc    de              ; 000ADA 13
    inc    de              ; 000ADB 13
    ret                    ; 000ADC C9
    inc    de              ; 000ADD 13
    bit    7,(ix+$01)      ; 000ADE DD CB 01 7E
    jr     nz,$0ae5        ; 000AE2 20 01
    ld     a,(de)          ; 000AE4 1A
    inc    a               ; 000AE5 3C
    ld     (ix+$07),a      ; 000AE6 DD 77 07
    ret                    ; 000AE9 C9
    res    7,(ix+$00)      ; 000AEA DD CB 00 BE
    ld     a,$1f           ; 000AEE 3E 1F
    ld     ($1c15),a       ; 000AF0 32 15 1C
	call	zKeyOffIfActive
    ld     c,(ix+$01)      ; 000AF6 DD 4E 01
    push   ix              ; 000AF9 DD E5
    call   $05df           ; 000AFB CD DF 05
    ld     a,($1c19)       ; 000AFE 3A 19 1C
    or     a               ; 000B01 B7
    jr     z,$0b6c         ; 000B02 28 68
    xor    a               ; 000B04 AF
    ld     ($1c18),a       ; 000B05 32 18 1C
    push   hl              ; 000B08 E5
    ld     hl,($1c37)      ; 000B09 2A 37 1C
    pop    ix              ; 000B0C DD E1
    res    2,(ix+$00)      ; 000B0E DD CB 00 96
    bit    7,(ix+$01)      ; 000B12 DD CB 01 7E
    jr     nz,$0b71        ; 000B16 20 59
    bit    7,(ix+$00)      ; 000B18 DD CB 00 7E
    jr     z,$0b6c         ; 000B1C 28 4E
    ld     a,$02           ; 000B1E 3E 02
    cp     (ix+$01)        ; 000B20 DD BE 01
    jr     nz,$0b32        ; 000B23 20 0D
    ld     a,$4f           ; 000B25 3E 4F
    bit    0,(ix+$00)      ; 000B27 DD CB 00 46
    jr     nz,$0b2f        ; 000B2B 20 02
    and    $0f             ; 000B2D E6 0F
    call   $0c3a           ; 000B2F CD 3A 0C
    ld     a,(ix+$08)      ; 000B32 DD 7E 08
    or     a               ; 000B35 B7
    jp     p,$0b3e         ; 000B36 F2 3E 0B
    call   $0aa6           ; 000B39 CD A6 0A
    jr     $0b69           ; 000B3C 18 2B
    ld     b,a             ; 000B3E 47
    push   hl              ; 000B3F E5
    ld     hl,$6000        ; 000B40 21 00 60
    ld     a,($1c04)       ; 000B43 3A 04 1C
    ld     (hl),a          ; 000B46 77
    rra                    ; 000B47 1F
    ld     (hl),a          ; 000B48 77
    rra                    ; 000B49 1F
    ld     (hl),a          ; 000B4A 77
    rra                    ; 000B4B 1F
    ld     (hl),a          ; 000B4C 77
    xor    a               ; 000B4D AF
    ld     d,$01           ; 000B4E 16 01
    ld     (hl),d          ; 000B50 72
    ld     (hl),a          ; 000B51 77
    ld     (hl),a          ; 000B52 77
    ld     (hl),a          ; 000B53 77
    ld     (hl),a          ; 000B54 77
    pop    hl              ; 000B55 E1
	call	zGetFMInstrumentPointer
	call	zSendFMInstrument
    ld     a,(ix+$18)      ; 000B5C DD 7E 18
    or     a               ; 000B5F B7
    jp     p,$0b6c         ; 000B60 F2 6C 0B
    ld     e,(ix+$19)      ; 000B63 DD 5E 19
    ld     d,(ix+$1a)      ; 000B66 DD 56 1A
    call   $0ccd           ; 000B69 CD CD 0C
    pop    ix              ; 000B6C DD E1
    pop    hl              ; 000B6E E1
    pop    hl              ; 000B6F E1
    ret                    ; 000B70 C9
    bit    0,(ix+$00)      ; 000B71 DD CB 00 46
    jr     z,$0b6c         ; 000B75 28 F5
    ld     a,(ix+$1a)      ; 000B77 DD 7E 1A
    or     a               ; 000B7A B7
    jp     p,$0b81         ; 000B7B F2 81 0B
    ld     ($7f11),a       ; 000B7E 32 11 7F
    jr     $0b6c           ; 000B81 18 E9
    bit    2,(ix+$01)      ; 000B83 DD CB 01 56
    ret    nz              ; 000B87 C0
    ld     a,$df           ; 000B88 3E DF
    ld     ($7f11),a       ; 000B8A 32 11 7F
    ld     a,(de)          ; 000B8D 1A
    ld     (ix+$1a),a      ; 000B8E DD 77 1A
    set    0,(ix+$00)      ; 000B91 DD CB 00 C6
    or     a               ; 000B95 B7
    jr     nz,$0b9e        ; 000B96 20 06
    res    0,(ix+$00)      ; 000B98 DD CB 00 86
    ld     a,$ff           ; 000B9C 3E FF
    ld     ($7f11),a       ; 000B9E 32 11 7F
    ret                    ; 000BA1 C9
    bit    7,(ix+$01)      ; 000BA2 DD CB 01 7E
    ret    z               ; 000BA6 C8
    ld     (ix+$08),a      ; 000BA7 DD 77 08
    ret                    ; 000BAA C9
    ex     de,hl           ; 000BAB EB
    ld     e,(hl)          ; 000BAC 5E
    inc    hl              ; 000BAD 23
    ld     d,(hl)          ; 000BAE 56
    dec    de              ; 000BAF 1B
    ret                    ; 000BB0 C9
    inc    de              ; 000BB1 13
    add    a,$28           ; 000BB2 C6 28
    ld     c,a             ; 000BB4 4F
    ld     b,$00           ; 000BB5 06 00
    push   ix              ; 000BB7 DD E5
    pop    hl              ; 000BB9 E1
    add    hl,bc           ; 000BBA 09
    ld     a,(hl)          ; 000BBB 7E
    or     a               ; 000BBC B7
    jr     nz,$0bc1        ; 000BBD 20 02
    ld     a,(de)          ; 000BBF 1A
    ld     (hl),a          ; 000BC0 77
    inc    de              ; 000BC1 13
    dec    (hl)            ; 000BC2 35
    jp     nz,$0bab        ; 000BC3 C2 AB 0B
    inc    de              ; 000BC6 13
    ret                    ; 000BC7 C9
    ld     c,a             ; 000BC8 4F
    inc    de              ; 000BC9 13
    ld     a,(de)          ; 000BCA 1A
    ld     b,a             ; 000BCB 47
    push   bc              ; 000BCC C5
    push   ix              ; 000BCD DD E5
    pop    hl              ; 000BCF E1
    dec    (ix+$09)        ; 000BD0 DD 35 09
    ld     c,(ix+$09)      ; 000BD3 DD 4E 09
    dec    (ix+$09)        ; 000BD6 DD 35 09
    ld     b,$00           ; 000BD9 06 00
    add    hl,bc           ; 000BDB 09
    ld     (hl),d          ; 000BDC 72
    dec    hl              ; 000BDD 2B
    ld     (hl),e          ; 000BDE 73
    pop    de              ; 000BDF D1
    dec    de              ; 000BE0 1B
    ret                    ; 000BE1 C9
    push   ix              ; 000BE2 DD E5
    pop    hl              ; 000BE4 E1
    ld     c,(ix+$09)      ; 000BE5 DD 4E 09
    ld     b,$00           ; 000BE8 06 00
    add    hl,bc           ; 000BEA 09
    ld     e,(hl)          ; 000BEB 5E
    inc    hl              ; 000BEC 23
    ld     d,(hl)          ; 000BED 56
    inc    (ix+$09)        ; 000BEE DD 34 09
    inc    (ix+$09)        ; 000BF1 DD 34 09
    ret                    ; 000BF4 C9
    res    7,(ix+$07)      ; 000BF5 DD CB 07 BE
    dec    de              ; 000BF9 1B
    ret                    ; 000BFA C9
    add    a,(ix+$05)      ; 000BFB DD 86 05
    ld     (ix+$05),a      ; 000BFE DD 77 05
    ret                    ; 000C01 C9
    ret                    ; 000C02 C9
    cp     $01             ; 000C03 FE 01
    jr     nz,$0c0c        ; 000C05 20 05
    set    3,(ix+$00)      ; 000C07 DD CB 00 DE
    ret                    ; 000C0B C9
    res    3,(ix+$00)      ; 000C0C DD CB 00 9E
    ret                    ; 000C10 C9
    ld     a,(ix+$01)      ; 000C11 DD 7E 01
    cp     $02             ; 000C14 FE 02
    jr     nz,$0c44        ; 000C16 20 2C
    set    0,(ix+$00)      ; 000C18 DD CB 00 C6
    ex     de,hl           ; 000C1C EB
	call	zGetSpecialFM3DataPointer
    ld     b,$04           ; 000C20 06 04
    push   bc              ; 000C22 C5
    ld     a,(hl)          ; 000C23 7E
    inc    hl              ; 000C24 23
    push   hl              ; 000C25 E5
    ld     hl,$0c48        ; 000C26 21 48 0C
    add    a,a             ; 000C29 87
    ld     c,a             ; 000C2A 4F
    ld     b,$00           ; 000C2B 06 00
    add    hl,bc           ; 000C2D 09
    ldi                    ; 000C2E ED A0
    ldi                    ; 000C30 ED A0
    pop    hl              ; 000C32 E1
    pop    bc              ; 000C33 C1
    djnz   $0c22           ; 000C34 10 EC
    ex     de,hl           ; 000C36 EB
    dec    de              ; 000C37 1B
    ld     a,$4f           ; 000C38 3E 4F
    ld     ($1c12),a       ; 000C3A 32 12 1C
    ld     c,a             ; 000C3D 4F
    ld     a,$27           ; 000C3E 3E 27
	call	zWriteFMI
    ret                    ; 000C43 C9
    inc    de              ; 000C44 13
    inc    de              ; 000C45 13
    inc    de              ; 000C46 13
    ret                    ; 000C47 C9
    nop                    ; 000C48 00
    nop                    ; 000C49 00
    ld     ($8e01),a       ; 000C4A 32 01 8E
    ld     bc,$01e4        ; 000C4D 01 E4 01
    inc    (hl)            ; 000C50 34
    ld     (bc),a          ; 000C51 02
    ld     a,(hl)          ; 000C52 7E
    ld     (bc),a          ; 000C53 02
    jp     nz,$f002        ; 000C54 C2 02 F0
    ld     (bc),a          ; 000C57 02
    ld     hl,$09a8        ; 000C58 21 A8 09
	rst	zPointerTableOffset
    inc    de              ; 000C5C 13
    ld     a,(de)          ; 000C5D 1A
    jp     (hl)            ; 000C5E E9
    ld     ($1c05),a       ; 000C5F 32 05 1C
    ret                    ; 000C62 C9
    push   ix              ; 000C63 DD E5
    call   $0427           ; 000C65 CD 27 04
    pop    ix              ; 000C68 DD E1
    ret                    ; 000C6A C9
    ld     ($1c11),a       ; 000C6B 32 11 1C
    or     a               ; 000C6E B7
    jr     z,$0c8e         ; 000C6F 28 1D
    push   ix              ; 000C71 DD E5
    push   de              ; 000C73 D5
    ld     ix,$1c40        ; 000C74 DD 21 40 1C
    ld     b,$09           ; 000C78 06 09
    ld     de,$0030        ; 000C7A 11 30 00
    res    7,(ix+$00)      ; 000C7D DD CB 00 BE
	call	zKeyOff
    add    ix,de           ; 000C84 DD 19
    djnz   $0c7d           ; 000C86 10 F5
    pop    de              ; 000C88 D1
    pop    ix              ; 000C89 DD E1
    jp     $07a0           ; 000C8B C3 A0 07
    push   ix              ; 000C8E DD E5
    push   de              ; 000C90 D5
    ld     ix,$1c40        ; 000C91 DD 21 40 1C
    ld     b,$09           ; 000C95 06 09
    ld     de,$0030        ; 000C97 11 30 00
    set    7,(ix+$00)      ; 000C9A DD CB 00 FE
    add    ix,de           ; 000C9E DD 19
    djnz   $0c9a           ; 000CA0 10 F8
    pop    de              ; 000CA2 D1
    pop    ix              ; 000CA3 DD E1
    ret                    ; 000CA5 C9
    ex     de,hl           ; 000CA6 EB
    ld     e,(hl)          ; 000CA7 5E
    inc    hl              ; 000CA8 23
    ld     d,(hl)          ; 000CA9 56
    inc    hl              ; 000CAA 23
    ld     c,(hl)          ; 000CAB 4E
    ld     b,$00           ; 000CAC 06 00
    inc    hl              ; 000CAE 23
    ex     de,hl           ; 000CAF EB
    ldir                   ; 000CB0 ED B0
    dec    de              ; 000CB2 1B
    ret                    ; 000CB3 C9
    ld     b,$09           ; 000CB4 06 09
    ld     hl,$1c42        ; 000CB6 21 42 1C
    push   bc              ; 000CB9 C5
    ld     bc,$0030        ; 000CBA 01 30 00
    ld     (hl),a          ; 000CBD 77
    add    hl,bc           ; 000CBE 09
    pop    bc              ; 000CBF C1
    djnz   $0cb9           ; 000CC0 10 F7
    ret                    ; 000CC2 C9
    ld     (ix+$18),$80    ; 000CC3 DD 36 18 80
    ld     (ix+$19),e      ; 000CC7 DD 73 19
    ld     (ix+$1a),d      ; 000CCA DD 72 1A
    ld     hl,$03f7        ; 000CCD 21 F7 03
    ld     b,$04           ; 000CD0 06 04
    ld     a,(de)          ; 000CD2 1A
    inc    de              ; 000CD3 13
    ld     c,a             ; 000CD4 4F
    ld     a,(hl)          ; 000CD5 7E
    inc    hl              ; 000CD6 23
	call	zWriteFMIorII
    djnz   $0cd2           ; 000CDA 10 F6
    dec    de              ; 000CDC 1B
    ret                    ; 000CDD C9
    ld     (ix+$18),a      ; 000CDE DD 77 18
    inc    de              ; 000CE1 13
    ld     a,(de)          ; 000CE2 1A
    ld     (ix+$19),a      ; 000CE3 DD 77 19
    ret                    ; 000CE6 C9

zUpdatePSGTrack:
	call	zTrackRunTimer
    jr     nz,$0cf9        ; 000CEA 20 0D
	call	zGetNextNote
    bit    4,(ix+$00)      ; 000CEF DD CB 00 66
    ret    nz              ; 000CF3 C0
	call	zPrepareModulation
    jr     $0d05           ; 000CF7 18 0C
    ld     a,(ix+$1e)      ; 000CF9 DD 7E 1E
    or     a               ; 000CFC B7
    jr     z,$0d05         ; 000CFD 28 06
    dec    (ix+$1e)        ; 000CFF DD 35 1E
    jp     z,$0d8f         ; 000D02 CA 8F 0D
	call	zUpdateFreq
	call	zDoModulation
    bit    2,(ix+$00)      ; 000D0B DD CB 00 56
    ret    nz              ; 000D0F C0
    ld     c,(ix+$01)      ; 000D10 DD 4E 01
    ld     a,l             ; 000D13 7D
    and    $0f             ; 000D14 E6 0F
    or     c               ; 000D16 B1
    ld     ($7f11),a       ; 000D17 32 11 7F
    ld     a,l             ; 000D1A 7D
    and    $f0             ; 000D1B E6 F0
    or     h               ; 000D1D B4
    rrca                   ; 000D1E 0F
    rrca                   ; 000D1F 0F
    rrca                   ; 000D20 0F
    rrca                   ; 000D21 0F
    ld     ($7f11),a       ; 000D22 32 11 7F
    ld     a,(ix+$08)      ; 000D25 DD 7E 08
    or     a               ; 000D28 B7
    ld     c,$00           ; 000D29 0E 00
    jr     z,$0d36         ; 000D2B 28 09
    dec    a               ; 000D2D 3D
    ld     c,$0a           ; 000D2E 0E 0A
	rst	zGetPointerTable
	rst	zPointerTableOffset
    call   $0d5d           ; 000D32 CD 5D 0D
    ld     c,a             ; 000D35 4F
    bit    4,(ix+$00)      ; 000D36 DD CB 00 66
    ret    nz              ; 000D3A C0
    ld     a,(ix+$06)      ; 000D3B DD 7E 06
    add    a,c             ; 000D3E 81
    bit    4,a             ; 000D3F CB 67
    jr     z,$0d45         ; 000D41 28 02
    ld     a,$0f           ; 000D43 3E 0F
    or     (ix+$01)        ; 000D45 DD B6 01
    add    a,$10           ; 000D48 C6 10
    bit    0,(ix+$00)      ; 000D4A DD CB 00 46
    jr     nz,$0d54        ; 000D4E 20 04
    ld     ($7f11),a       ; 000D50 32 11 7F
    ret                    ; 000D53 C9
    add    a,$20           ; 000D54 C6 20
    ld     ($7f11),a       ; 000D56 32 11 7F
    ret                    ; 000D59 C9
    ld     (ix+$17),a      ; 000D5A DD 77 17
    push   hl              ; 000D5D E5
    ld     c,(ix+$17)      ; 000D5E DD 4E 17
    ld     b,$00           ; 000D61 06 00
    add    hl,bc           ; 000D63 09
    ld     a,(hl)          ; 000D64 7E
    pop    hl              ; 000D65 E1
    bit    7,a             ; 000D66 CB 7F
    jr     z,$0d8b         ; 000D68 28 21
    cp     $83             ; 000D6A FE 83
    jr     z,$0d7a         ; 000D6C 28 0C
    cp     $81             ; 000D6E FE 81
    jr     z,$0d85         ; 000D70 28 13
    cp     $80             ; 000D72 FE 80
    jr     z,$0d82         ; 000D74 28 0C
    inc    bc              ; 000D76 03
    ld     a,(bc)          ; 000D77 0A
    jr     $0d5a           ; 000D78 18 E0
    set    4,(ix+$00)      ; 000D7A DD CB 00 E6
    pop    hl              ; 000D7E E1
    jp     $0d8f           ; 000D7F C3 8F 0D
    xor    a               ; 000D82 AF
    jr     $0d5a           ; 000D83 18 D5
    pop    hl              ; 000D85 E1
    set    4,(ix+$00)      ; 000D86 DD CB 00 E6
    ret                    ; 000D8A C9
    inc    (ix+$17)        ; 000D8B DD 34 17
    ret                    ; 000D8E C9
    set    4,(ix+$00)      ; 000D8F DD CB 00 E6
    bit    2,(ix+$00)      ; 000D93 DD CB 00 56
    ret    nz              ; 000D97 C0
    ld     a,$1f           ; 000D98 3E 1F
    add    a,(ix+$01)      ; 000D9A DD 86 01
    or     a               ; 000D9D B7
    ret    p               ; 000D9E F0
    ld     ($7f11),a       ; 000D9F 32 11 7F
    bit    0,(ix+$00)      ; 000DA2 DD CB 00 46
    ret    z               ; 000DA6 C8
    ld     a,$ff           ; 000DA7 3E FF
    ld     ($7f11),a       ; 000DA9 32 11 7F
    ret                    ; 000DAC C9

zPlayDigitalAudio:
    di                     ; 000DAD F3
    ld     a,$2b           ; 000DAE 3E 2B
    ld     c,$00           ; 000DB0 0E 00
	call	zWriteFMI
    ei                     ; 000DB5 FB
    ld     a,($1c07)       ; 000DB6 3A 07 1C
    or     a               ; 000DB9 B7
	jp	nz,zPlaySEGAPCM
    ld     a,($1c06)       ; 000DBD 3A 06 1C
    or     a               ; 000DC0 B7
    jr     z,$0db5         ; 000DC1 28 F2
    ld     a,$2b           ; 000DC3 3E 2B
    ld     c,$80           ; 000DC5 0E 80
    di                     ; 000DC7 F3
	call	zWriteFMI
    ei                     ; 000DCB FB
    ld     iy,$0e39        ; 000DCC FD 21 39 0E
    ld     hl,$1c06        ; 000DD0 21 06 1C
    ld     a,(hl)          ; 000DD3 7E
    dec    a               ; 000DD4 3D
    set    7,(hl)          ; 000DD5 CB FE
    ld     hl,$8000        ; 000DD7 21 00 80
	rst	zPointerTableOffset
    ld     c,$80           ; 000DDB 0E 80
    ld     a,(hl)          ; 000DDD 7E
    ld     ($0dee),a       ; 000DDE 32 EE 0D
    ld     ($0e0b),a       ; 000DE1 32 0B 0E
    inc    hl              ; 000DE4 23
    ld     e,(hl)          ; 000DE5 5E
    inc    hl              ; 000DE6 23
    ld     d,(hl)          ; 000DE7 56
    inc    hl              ; 000DE8 23
    ld     a,(hl)          ; 000DE9 7E
    inc    hl              ; 000DEA 23
    ld     h,(hl)          ; 000DEB 66
    ld     l,a             ; 000DEC 6F
    ld     b,$0a           ; 000DED 06 0A
    ei                     ; 000DEF FB
    djnz   $0df0           ; 000DF0 10 FE
    di                     ; 000DF2 F3
    ld     a,$2a           ; 000DF3 3E 2A
    ld     ($4000),a       ; 000DF5 32 00 40
    ld     a,(hl)          ; 000DF8 7E
    rlca                   ; 000DF9 07
    rlca                   ; 000DFA 07
    rlca                   ; 000DFB 07
    rlca                   ; 000DFC 07
    and    $0f             ; 000DFD E6 0F
    ld     ($0e05),a       ; 000DFF 32 05 0E
    ld     a,c             ; 000E02 79
    add    a,(iy+$00)      ; 000E03 FD 86 00
    ld     ($4001),a       ; 000E06 32 01 40
    ld     c,a             ; 000E09 4F
    ld     b,$0a           ; 000E0A 06 0A
    ei                     ; 000E0C FB
    djnz   $0e0d           ; 000E0D 10 FE
    di                     ; 000E0F F3
    ld     a,$2a           ; 000E10 3E 2A
    ld     ($4000),a       ; 000E12 32 00 40
    ld     a,(hl)          ; 000E15 7E
    and    $0f             ; 000E16 E6 0F
    ld     ($0e1e),a       ; 000E18 32 1E 0E
    ld     a,c             ; 000E1B 79
    add    a,(iy+$00)      ; 000E1C FD 86 00
    ld     ($4001),a       ; 000E1F 32 01 40
    ei                     ; 000E22 FB
    ld     c,a             ; 000E23 4F
    ld     a,($1c06)       ; 000E24 3A 06 1C
    or     a               ; 000E27 B7
    jp     p,$0db5         ; 000E28 F2 B5 0D
    inc    hl              ; 000E2B 23
    dec    de              ; 000E2C 1B
    ld     a,d             ; 000E2D 7A
    or     e               ; 000E2E B3
    jp     nz,$0ded        ; 000E2F C2 ED 0D
    xor    a               ; 000E32 AF
    ld     ($1c06),a       ; 000E33 32 06 1C
	jp	zPlayDigitalAudio
    nop                    ; 000E39 00
    ld     bc,$0402        ; 000E3A 01 02 04
    ex     af,af          ; 000E3D 08
    djnz   $0e60           ; 000E3E 10 20
    ld     b,b             ; 000E40 40
    add    a,b             ; 000E41 80
    rst    38h             ; 000E42 FF
    cp     $fc             ; 000E43 FE FC
    ret    m               ; 000E45 F8
    ret    p               ; 000E46 F0
    ret    po              ; 000E47 E0
    ret    nz              ; 000E48 C0

zPlaySEGAPCM:
    di                     ; 000E49 F3
    ld     a,$2b           ; 000E4A 3E 2B
    ld     ($4000),a       ; 000E4C 32 00 40
    nop                    ; 000E4F 00
    ld     a,$80           ; 000E50 3E 80
    ld     ($4001),a       ; 000E52 32 01 40
    ld     hl,$6000        ; 000E55 21 00 60
    xor    a               ; 000E58 AF
    ld     e,$01           ; 000E59 1E 01
    ld     (hl),e          ; 000E5B 73
    ld     (hl),e          ; 000E5C 73
    ld     (hl),e          ; 000E5D 73
    ld     (hl),e          ; 000E5E 73
    ld     (hl),e          ; 000E5F 73
    ld     (hl),a          ; 000E60 77
    ld     (hl),a          ; 000E61 77
    ld     (hl),a          ; 000E62 77
    ld     (hl),a          ; 000E63 77
    ld     hl,$8000        ; 000E64 21 00 80
    ld     de,$6caa        ; 000E67 11 AA 6C
    ld     a,$2a           ; 000E6A 3E 2A
    ld     ($4000),a       ; 000E6C 32 00 40

@loop:
    ld     a,(hl)          ; 000E6F 7E
    ld     ($4001),a       ; 000E70 32 01 40
    ld     b,$0d           ; 000E73 06 0D
    djnz   $0e75           ; 000E75 10 FE
    inc    hl              ; 000E77 23
    dec    de              ; 000E78 1B
    ld     a,d             ; 000E79 7A
    or     e               ; 000E7A B3
	jp	nz,@loop
    xor    a               ; 000E7E AF
    ld     ($1c07),a       ; 000E7F 32 07 1C
    call   $072c           ; 000E82 CD 2C 07
	jp	zPlayDigitalAudio
    rst    28h             ; 000E88 EF
    inc    d               ; 000E89 14
    adc    a,e             ; 000E8A 8B
    inc    sp              ; 000E8B 33
    jp     nz,$d4d3        ; 000E8C C2 D3 D4
    push   de              ; 000E8F D5
    add    a,h             ; 000E90 84
    sub    $c1             ; 000E91 D6 C1
    add    a,b             ; 000E93 80
    add    a,a             ; 000E94 87
    add    a,b             ; 000E95 80
    adc    a,a             ; 000E96 8F
    add    a,$a0           ; 000E97 C6 A0
    and    e               ; 000E99 A3
    and    l               ; 000E9A A5
    and    a               ; 000E9B A7
    xor    c               ; 000E9C A9
    xor    e               ; 000E9D AB
    xor    l               ; 000E9E AD
    adc    a,c             ; 000E9F 89
    xor    a               ; 000EA0 AF
    pop    bc              ; 000EA1 C1
    out    ($d4),a         ; 000EA2 D3 D4
    add    a,b             ; 000EA4 80
    push   de              ; 000EA5 D5
    add    a,h             ; 000EA6 84
    sub    $c9             ; 000EA7 D6 C9
    add    a,b             ; 000EA9 80
    add    a,a             ; 000EAA 87
    sub    b               ; 000EAB 90
    sbc    a,c             ; 000EAC 99
    adc    a,a             ; 000EAD 8F
    and    h               ; 000EAE A4
    and    (hl)            ; 000EAF A6
    xor    b               ; 000EB0 A8
    xor    d               ; 000EB1 AA
    xor    h               ; 000EB2 AC
    add    a,d             ; 000EB3 82
    xor    (hl)            ; 000EB4 AE
    ret                    ; 000EB5 C9
    or     b               ; 000EB6 B0
    or     c               ; 000EB7 B1
    or     d               ; 000EB8 B2
    or     e               ; 000EB9 B3
    or     l               ; 000EBA B5
    or     a               ; 000EBB B7
    ret    nz              ; 000EBC C0
    call   z,$d4d3         ; 000EBD CC D3 D4
    add    a,b             ; 000EC0 80
    push   de              ; 000EC1 D5
    add    a,h             ; 000EC2 84
    sub    $c4             ; 000EC3 D6 C4
    add    a,b             ; 000EC5 80
    add    a,a             ; 000EC6 87
    sub    c               ; 000EC7 91
    sbc    a,d             ; 000EC8 9A
    and    c               ; 000EC9 A1
    adc    a,d             ; 000ECA 8A
    and    d               ; 000ECB A2
    add    a,$b4           ; 000ECC C6 B4
    or     (hl)            ; 000ECE B6
    cp     b               ; 000ECF B8
    pop    bc              ; 000ED0 C1
    call   $d4d3           ; 000ED1 CD D3 D4
    add    a,b             ; 000ED4 80
    push   de              ; 000ED5 D5
    add    a,h             ; 000ED6 84
    sub    $c3             ; 000ED7 D6 C3
    add    a,b             ; 000ED9 80
    adc    a,b             ; 000EDA 88
    sub    d               ; 000EDB 92
    sbc    a,d             ; 000EDC 9A
    adc    a,l             ; 000EDD 8D
    and    d               ; 000EDE A2
    call   nz,$c2b9        ; 000EDF C4 B9 C2
    adc    a,$d3           ; 000EE2 CE D3
    call   nc,$d580        ; 000EE4 D4 80 D5
    add    a,h             ; 000EE7 84
    sub    $c3             ; 000EE8 D6 C3
    add    a,c             ; 000EEA 81
    adc    a,c             ; 000EEB 89
    sub    e               ; 000EEC 93
    sbc    a,e             ; 000EED 9B
    adc    a,l             ; 000EEE 8D
    and    d               ; 000EEF A2
    ret    nz              ; 000EF0 C0
    cp     d               ; 000EF1 BA
    add    a,b             ; 000EF2 80
    jp     $d3c1           ; 000EF3 C3 C1 D3
    call   nc,$d580        ; 000EF6 D4 80 D5
    add    a,h             ; 000EF9 84
    sub    $c3             ; 000EFA D6 C3
    add    a,c             ; 000EFC 81
    adc    a,c             ; 000EFD 89
    sub    h               ; 000EFE 94
    sbc    a,h             ; 000EFF 9C
    adc    a,(hl)          ; 000F00 8E
    and    d               ; 000F01 A2
    jp     $c4c3           ; 000F02 C3 C3 C4
    out    ($d4),a         ; 000F05 D3 D4
    add    a,b             ; 000F07 80
    push   de              ; 000F08 D5
    add    a,h             ; 000F09 84
    sub    $c3             ; 000F0A D6 C3
    add    a,c             ; 000F0C 81
    adc    a,c             ; 000F0D 89
    sub    l               ; 000F0E 95
    sbc    a,l             ; 000F0F 9D
    adc    a,(hl)          ; 000F10 8E
    and    d               ; 000F11 A2
    add    a,b             ; 000F12 80
    call   nz,$d3c1        ; 000F13 C4 C1 D3
    call   nc,$d580        ; 000F16 D4 80 D5
    add    a,h             ; 000F19 84
    sub    $c3             ; 000F1A D6 C3
    add    a,c             ; 000F1C 81
    adc    a,c             ; 000F1D 89
    sub    (hl)            ; 000F1E 96
    sbc    a,(hl)          ; 000F1F 9E
    adc    a,(hl)          ; 000F20 8E
    and    d               ; 000F21 A2
    add    a,b             ; 000F22 80
    call   nz,$d3c1        ; 000F23 C4 C1 D3
    call   nc,$d580        ; 000F26 D4 80 D5
    add    a,h             ; 000F29 84
    sub    $c3             ; 000F2A D6 C3
    add    a,c             ; 000F2C 81
    adc    a,c             ; 000F2D 89
    sub    a               ; 000F2E 97
    sbc    a,(hl)          ; 000F2F 9E
    adc    a,l             ; 000F30 8D
    and    d               ; 000F31 A2
    call   nz,$c5bb        ; 000F32 C4 BB C5
    call   nz,$d4d3        ; 000F35 C4 D3 D4
    add    a,b             ; 000F38 80
    push   de              ; 000F39 D5
    add    a,h             ; 000F3A 84
    sub    $c3             ; 000F3B D6 C3
    add    a,c             ; 000F3D 81
    adc    a,c             ; 000F3E 89
    sbc    a,b             ; 000F3F 98
    sbc    a,a             ; 000F40 9F
    adc    a,l             ; 000F41 8D
    and    d               ; 000F42 A2
    call   nz,$c6bb        ; 000F43 C4 BB C6
	rst	zGetPointerTable
    out    ($d4),a         ; 000F47 D3 D4
    add    a,b             ; 000F49 80
    push   de              ; 000F4A D5
    add    a,h             ; 000F4B 84
    sub    $c3             ; 000F4C D6 C3
    add    a,c             ; 000F4E 81
    adc    a,c             ; 000F4F 89
    sbc    a,b             ; 000F50 98
    sbc    a,a             ; 000F51 9F
    adc    a,l             ; 000F52 8D
    and    d               ; 000F53 A2
    call   nz,$c7bb        ; 000F54 C4 BB C7
    ret    nc              ; 000F57 D0
    out    ($d4),a         ; 000F58 D3 D4
    add    a,b             ; 000F5A 80
    push   de              ; 000F5B D5
    add    a,h             ; 000F5C 84
    sub    $c3             ; 000F5D D6 C3
    add    a,d             ; 000F5F 82
    adc    a,c             ; 000F60 89
    sbc    a,b             ; 000F61 98
    sbc    a,a             ; 000F62 9F
    adc    a,l             ; 000F63 8D
    and    d               ; 000F64 A2
    call   nz,$c8bb        ; 000F65 C4 BB C8
    ret    nc              ; 000F68 D0
    out    ($d4),a         ; 000F69 D3 D4
    add    a,b             ; 000F6B 80
    push   de              ; 000F6C D5
    add    a,h             ; 000F6D 84
    sub    $c3             ; 000F6E D6 C3
    add    a,e             ; 000F70 83
    adc    a,d             ; 000F71 8A
    sbc    a,b             ; 000F72 98
    sbc    a,a             ; 000F73 9F
    adc    a,l             ; 000F74 8D
    and    d               ; 000F75 A2
    call   nz,$c9bc        ; 000F76 C4 BC C9
    pop    de              ; 000F79 D1
    out    ($d4),a         ; 000F7A D3 D4
    add    a,b             ; 000F7C 80
    push   de              ; 000F7D D5
    add    a,h             ; 000F7E 84
    sub    $c3             ; 000F7F D6 C3
    add    a,h             ; 000F81 84
    adc    a,e             ; 000F82 8B
    sbc    a,b             ; 000F83 98
    sbc    a,a             ; 000F84 9F
    adc    a,l             ; 000F85 8D
    and    d               ; 000F86 A2
    call   nz,$c7bd        ; 000F87 C4 BD C7
    jp     nc,$d4d3        ; 000F8A D2 D3 D4
    add    a,b             ; 000F8D 80
    push   de              ; 000F8E D5
    add    a,h             ; 000F8F 84
    sub    $c3             ; 000F90 D6 C3
    add    a,l             ; 000F92 85
    adc    a,h             ; 000F93 8C
    sbc    a,b             ; 000F94 98
    sbc    a,a             ; 000F95 9F
    adc    a,l             ; 000F96 8D
    and    d               ; 000F97 A2
    call   nz,$cabe        ; 000F98 C4 BE CA
    jp     nc,$d4d3        ; 000F9B D2 D3 D4
    add    a,b             ; 000F9E 80
    push   de              ; 000F9F D5
    add    a,h             ; 000FA0 84
    sub    $c3             ; 000FA1 D6 C3
    add    a,(hl)          ; 000FA3 86
    adc    a,l             ; 000FA4 8D
    sbc    a,b             ; 000FA5 98
    sbc    a,a             ; 000FA6 9F
    adc    a,l             ; 000FA7 8D
    and    d               ; 000FA8 A2
    call   nz,$cbbe        ; 000FA9 C4 BE CB
    jp     nc,$d4d3        ; 000FAC D2 D3 D4
    add    a,b             ; 000FAF 80
    push   de              ; 000FB0 D5
    add    a,h             ; 000FB1 84
    sub    $c3             ; 000FB2 D6 C3
    add    a,(hl)          ; 000FB4 86
    adc    a,(hl)          ; 000FB5 8E
    sbc    a,b             ; 000FB6 98
    sbc    a,a             ; 000FB7 9F
    adc    a,l             ; 000FB8 8D
    and    d               ; 000FB9 A2
    call   nz,$c7bf        ; 000FBA C4 BF C7
    jp     nc,$d4d3        ; 000FBD D2 D3 D4
    add    a,b             ; 000FC0 80
    push   de              ; 000FC1 D5
    add    a,h             ; 000FC2 84
    sub    $c3             ; 000FC3 D6 C3
    add    a,(hl)          ; 000FC5 86
    adc    a,l             ; 000FC6 8D
    sbc    a,b             ; 000FC7 98
    sbc    a,a             ; 000FC8 9F
    adc    a,l             ; 000FC9 8D
    and    d               ; 000FCA A2
    call   nz,$cbbe        ; 000FCB C4 BE CB
    jp     nc,$d4d3        ; 000FCE D2 D3 D4
    add    a,b             ; 000FD1 80
    push   de              ; 000FD2 D5
    add    a,h             ; 000FD3 84
    sub    $c3             ; 000FD4 D6 C3
    add    a,l             ; 000FD6 85
    adc    a,h             ; 000FD7 8C
    sbc    a,b             ; 000FD8 98
    sbc    a,a             ; 000FD9 9F
    adc    a,l             ; 000FDA 8D
    and    d               ; 000FDB A2
    call   nz,$cabe        ; 000FDC C4 BE CA
    jp     nc,$d4d3        ; 000FDF D2 D3 D4
    add    a,b             ; 000FE2 80
    push   de              ; 000FE3 D5
    add    a,h             ; 000FE4 84
    sub    $c3             ; 000FE5 D6 C3
    add    a,h             ; 000FE7 84
    adc    a,e             ; 000FE8 8B
    sbc    a,b             ; 000FE9 98
    sbc    a,a             ; 000FEA 9F
    adc    a,l             ; 000FEB 8D
    and    d               ; 000FEC A2
    call   nz,$c7bd        ; 000FED C4 BD C7
    jp     nc,$d4d3        ; 000FF0 D2 D3 D4
    add    a,b             ; 000FF3 80
    push   de              ; 000FF4 D5
    add    a,h             ; 000FF5 84
    sub    $c3             ; 000FF6 D6 C3
    add    a,e             ; 000FF8 83
    adc    a,d             ; 000FF9 8A
    sbc    a,b             ; 000FFA 98
    sbc    a,a             ; 000FFB 9F
    adc    a,l             ; 000FFC 8D
    and    d               ; 000FFD A2
    call   nz,$c9bc        ; 000FFE C4 BC C9
    pop    de              ; 001001 D1
    out    ($d4),a         ; 001002 D3 D4
    add    a,b             ; 001004 80
    push   de              ; 001005 D5
    add    a,h             ; 001006 84
    sub    $c3             ; 001007 D6 C3
    add    a,d             ; 001009 82
    adc    a,c             ; 00100A 89
    sbc    a,b             ; 00100B 98
    sbc    a,a             ; 00100C 9F
    adc    a,l             ; 00100D 8D
    and    d               ; 00100E A2
    call   nz,$c8bb        ; 00100F C4 BB C8
    ret    nc              ; 001012 D0
    out    ($d4),a         ; 001013 D3 D4
    add    a,b             ; 001015 80
    push   de              ; 001016 D5
    add    a,h             ; 001017 84
    sub    $c3             ; 001018 D6 C3
    add    a,c             ; 00101A 81
    adc    a,c             ; 00101B 89
    sbc    a,b             ; 00101C 98
    sbc    a,a             ; 00101D 9F
    adc    a,l             ; 00101E 8D
    and    d               ; 00101F A2
    call   nz,$c7bb        ; 001020 C4 BB C7
    ret    nc              ; 001023 D0
    out    ($d4),a         ; 001024 D3 D4
    add    a,b             ; 001026 80
    push   de              ; 001027 D5
    add    a,h             ; 001028 84
    sub    $c3             ; 001029 D6 C3
    add    a,c             ; 00102B 81
    adc    a,c             ; 00102C 89
    sbc    a,b             ; 00102D 98
    sbc    a,a             ; 00102E 9F
    adc    a,l             ; 00102F 8D
    and    d               ; 001030 A2
    call   nz,$c6bb        ; 001031 C4 BB C6
	rst	zGetPointerTable
    out    ($d4),a         ; 001035 D3 D4
    add    a,b             ; 001037 80
    push   de              ; 001038 D5
    add    a,h             ; 001039 84
    sub    $c3             ; 00103A D6 C3
    add    a,c             ; 00103C 81
    adc    a,c             ; 00103D 89
    sub    a               ; 00103E 97
    sbc    a,(hl)          ; 00103F 9E
    adc    a,l             ; 001040 8D
    and    d               ; 001041 A2
    call   nz,$c5bb        ; 001042 C4 BB C5
    call   nz,$d4d3        ; 001045 C4 D3 D4
    add    a,b             ; 001048 80
    push   de              ; 001049 D5
    add    a,h             ; 00104A 84
    sub    $c3             ; 00104B D6 C3
    add    a,c             ; 00104D 81
    adc    a,c             ; 00104E 89
    sub    (hl)            ; 00104F 96
    sbc    a,(hl)          ; 001050 9E
    adc    a,(hl)          ; 001051 8E
    and    d               ; 001052 A2
    add    a,b             ; 001053 80
    call   nz,$d3c1        ; 001054 C4 C1 D3
    call   nc,$d580        ; 001057 D4 80 D5
    add    a,h             ; 00105A 84
    sub    $c3             ; 00105B D6 C3
    add    a,c             ; 00105D 81
    adc    a,c             ; 00105E 89
    sub    l               ; 00105F 95
    sbc    a,l             ; 001060 9D
    adc    a,(hl)          ; 001061 8E
    and    d               ; 001062 A2
    add    a,b             ; 001063 80
    call   nz,$d3c1        ; 001064 C4 C1 D3
    call   nc,$d580        ; 001067 D4 80 D5
    add    a,h             ; 00106A 84
    sub    $c3             ; 00106B D6 C3
    add    a,c             ; 00106D 81
    adc    a,c             ; 00106E 89
    sub    h               ; 00106F 94
    sbc    a,h             ; 001070 9C
    adc    a,(hl)          ; 001071 8E
    and    d               ; 001072 A2
    jp     $c4c3           ; 001073 C3 C3 C4
    out    ($d4),a         ; 001076 D3 D4
    add    a,b             ; 001078 80
    push   de              ; 001079 D5
    add    a,h             ; 00107A 84
    sub    $c3             ; 00107B D6 C3
    add    a,c             ; 00107D 81
    adc    a,c             ; 00107E 89
    sub    e               ; 00107F 93
    sbc    a,e             ; 001080 9B
    adc    a,l             ; 001081 8D
    and    d               ; 001082 A2
    ret    nz              ; 001083 C0
    cp     d               ; 001084 BA
    add    a,b             ; 001085 80
    jp     $d3c1           ; 001086 C3 C1 D3
    call   nc,$d580        ; 001089 D4 80 D5
    add    a,h             ; 00108C 84
    sub    $c3             ; 00108D D6 C3
    add    a,b             ; 00108F 80
    adc    a,b             ; 001090 88
    sub    d               ; 001091 92
    sbc    a,d             ; 001092 9A
    adc    a,l             ; 001093 8D
    and    d               ; 001094 A2
    call   nz,$c2b9        ; 001095 C4 B9 C2
    adc    a,$d3           ; 001098 CE D3
    call   nc,$d580        ; 00109A D4 80 D5
    add    a,h             ; 00109D 84
    sub    $c4             ; 00109E D6 C4
    add    a,b             ; 0010A0 80
    add    a,a             ; 0010A1 87
    sub    c               ; 0010A2 91
    sbc    a,d             ; 0010A3 9A
    and    c               ; 0010A4 A1
    adc    a,d             ; 0010A5 8A
    and    d               ; 0010A6 A2
    add    a,$b4           ; 0010A7 C6 B4
    or     (hl)            ; 0010A9 B6
    cp     b               ; 0010AA B8
    pop    bc              ; 0010AB C1
    call   $d4d3           ; 0010AC CD D3 D4
    add    a,b             ; 0010AF 80
    push   de              ; 0010B0 D5
    add    a,h             ; 0010B1 84
    sub    $c9             ; 0010B2 D6 C9
    add    a,b             ; 0010B4 80
    add    a,a             ; 0010B5 87
    sub    b               ; 0010B6 90
    sbc    a,c             ; 0010B7 99
    adc    a,a             ; 0010B8 8F
    and    h               ; 0010B9 A4
    and    (hl)            ; 0010BA A6
    xor    b               ; 0010BB A8
    xor    d               ; 0010BC AA
    xor    h               ; 0010BD AC
    add    a,d             ; 0010BE 82
    xor    (hl)            ; 0010BF AE
    ret                    ; 0010C0 C9
    or     b               ; 0010C1 B0
    or     c               ; 0010C2 B1
    or     d               ; 0010C3 B2
    or     e               ; 0010C4 B3
    or     l               ; 0010C5 B5
    or     a               ; 0010C6 B7
    ret    nz              ; 0010C7 C0
    call   z,$d4d3         ; 0010C8 CC D3 D4
    add    a,b             ; 0010CB 80
    push   de              ; 0010CC D5
    add    a,h             ; 0010CD 84
    sub    $c1             ; 0010CE D6 C1
    add    a,b             ; 0010D0 80
    add    a,a             ; 0010D1 87
    add    a,b             ; 0010D2 80
    adc    a,a             ; 0010D3 8F
    add    a,$a0           ; 0010D4 C6 A0
    and    e               ; 0010D6 A3
    and    l               ; 0010D7 A5
    and    a               ; 0010D8 A7
    xor    c               ; 0010D9 A9
    xor    e               ; 0010DA AB
    xor    l               ; 0010DB AD
    adc    a,c             ; 0010DC 89
    xor    a               ; 0010DD AF
    pop    bc              ; 0010DE C1
    out    ($d4),a         ; 0010DF D3 D4
    add    a,b             ; 0010E1 80
    push   de              ; 0010E2 D5
    add    a,h             ; 0010E3 84
    sub    $c9             ; 0010E4 D6 C9
    add    a,b             ; 0010E6 80
    add    a,a             ; 0010E7 87
    adc    a,a             ; 0010E8 8F
    ld     l,b             ; 0010E9 68
    add    a,b             ; 0010EA 80
    adc    a,d             ; 0010EB 8A
    sub    a               ; 0010EC 97
    jp     $14ef           ; 0010ED C3 EF 14
    adc    a,e             ; 0010F0 8B
    inc    sp              ; 0010F1 33
    jp     nz,$d4d3        ; 0010F2 C2 D3 D4
    push   de              ; 0010F5 D5
    add    a,h             ; 0010F6 84
    sub    $c9             ; 0010F7 D6 C9
    add    a,b             ; 0010F9 80
    add    a,a             ; 0010FA 87
    adc    a,a             ; 0010FB 8F
    ld     l,b             ; 0010FC 68
    add    a,b             ; 0010FD 80
    adc    a,d             ; 0010FE 8A
    sub    a               ; 0010FF 97
    jp     $14ef           ; 001100 C3 EF 14
    adc    a,e             ; 001103 8B
    inc    sp              ; 001104 33
    jp     nz,$d4d3        ; 001105 C2 D3 D4
    push   de              ; 001108 D5
    add    a,h             ; 001109 84
    sub    $c9             ; 00110A D6 C9
    add    a,b             ; 00110C 80
    add    a,a             ; 00110D 87
    adc    a,a             ; 00110E 8F
    ld     l,b             ; 00110F 68
    add    a,b             ; 001110 80
    adc    a,d             ; 001111 8A
    sub    a               ; 001112 97
    jp     $14ef           ; 001113 C3 EF 14
    adc    a,e             ; 001116 8B
    inc    sp              ; 001117 33
    jp     nz,$d4d3        ; 001118 C2 D3 D4
    push   de              ; 00111B D5
    add    a,h             ; 00111C 84
    sub    $c9             ; 00111D D6 C9
    add    a,b             ; 00111F 80
    add    a,a             ; 001120 87
    adc    a,a             ; 001121 8F
    ld     l,b             ; 001122 68
    add    a,b             ; 001123 80
    adc    a,d             ; 001124 8A
    sub    a               ; 001125 97
    jp     $14ef           ; 001126 C3 EF 14
    adc    a,e             ; 001129 8B
    inc    sp              ; 00112A 33
    jp     nz,$d4d3        ; 00112B C2 D3 D4
    push   de              ; 00112E D5
    add    a,h             ; 00112F 84
    sub    $c1             ; 001130 D6 C1
    add    a,b             ; 001132 80
    add    a,a             ; 001133 87
    add    a,b             ; 001134 80
    adc    a,a             ; 001135 8F
    add    a,$a0           ; 001136 C6 A0
    and    e               ; 001138 A3
    and    l               ; 001139 A5
    and    a               ; 00113A A7
    xor    c               ; 00113B A9
    xor    e               ; 00113C AB
    xor    l               ; 00113D AD
    adc    a,c             ; 00113E 89
    xor    a               ; 00113F AF
    pop    bc              ; 001140 C1
    out    ($d4),a         ; 001141 D3 D4
    add    a,b             ; 001143 80
    push   de              ; 001144 D5
    add    a,h             ; 001145 84
    sub    $c1             ; 001146 D6 C1
    add    a,b             ; 001148 80
    add    a,a             ; 001149 87
    add    a,b             ; 00114A 80
    adc    a,a             ; 00114B 8F
    ret    nz              ; 00114C C0
    ld     a,(hl)          ; 00114D 7E
    add    a,b             ; 00114E 80
    ld     (hl),h          ; 00114F 74
	rst	zGetPointerTable
    cp     a               ; 001151 BF
    halt                   ; 001152 76
    ld     a,b             ; 001153 78
    xor    d               ; 001154 AA
    inc    a               ; 001155 3C
    ld     l,l             ; 001156 6D
    ld     a,(hl)          ; 001157 7E
    sbc    a,d             ; 001158 9A
    ld     (hl),d          ; 001159 72
    and    (hl)            ; 00115A A6
    cp     h               ; 00115B BC
    rst    00h             ; 00115C C7
    ret    nc              ; 00115D D0
    push   de              ; 00115E D5
    out    ($d4),a         ; 00115F D3 D4
    add    a,c             ; 001161 81
    push   de              ; 001162 D5
    add    a,h             ; 001163 84
    sub    $c1             ; 001164 D6 C1
    add    a,b             ; 001166 80
    add    a,a             ; 001167 87
    add    a,b             ; 001168 80
    adc    a,a             ; 001169 8F
    add    a,c             ; 00116A 81
    ld     (hl),h          ; 00116B 74
    jp     nc,$d3c0        ; 00116C D2 C0 D3
    ld     l,d             ; 00116F 6A
    dec    de              ; 001170 1B
    dec    a               ; 001171 3D
    ld     l,(hl)          ; 001172 6E
    ld     a,a             ; 001173 7F
    sbc    a,e             ; 001174 9B
    ld     (hl),e          ; 001175 73
    and    a               ; 001176 A7
    ret    nc              ; 001177 D0
    ret    m               ; 001178 F8
    ld     l,$d5           ; 001179 2E D5
    out    ($d4),a         ; 00117B D3 D4
    push   de              ; 00117D D5
    db     $dd             ; 00117E DD
    ret    po              ; 00117F E0
    add    a,h             ; 001180 84
    sub    $c1             ; 001181 D6 C1
    add    a,b             ; 001183 80
    add    a,a             ; 001184 87
    add    a,b             ; 001185 80
    adc    a,a             ; 001186 8F
    add    a,b             ; 001187 80
    ld     (hl),h          ; 001188 74
    jp     nc,$c175        ; 001189 D2 75 C1
    call   nc,$1cfb        ; 00118C D4 FB 1C
    ld     a,$6f           ; 00118F 3E 6F
    add    a,b             ; 001191 80
    sbc    a,h             ; 001192 9C
    add    a,l             ; 001193 85
    xor    b               ; 001194 A8
    pop    de              ; 001195 D1
    ld     sp,hl           ; 001196 F9
    cpl                    ; 001197 2F
    push   de              ; 001198 D5
    out    ($d4),a         ; 001199 D3 D4
    push   de              ; 00119B D5
    sbc    a,$85           ; 00119C DE 85
    sub    $c1             ; 00119E D6 C1
    add    a,b             ; 0011A0 80
    add    a,a             ; 0011A1 87
    add    a,b             ; 0011A2 80
    adc    a,a             ; 0011A3 8F
    call   nc,$7574        ; 0011A4 D4 74 75
    halt                   ; 0011A7 76
    jp     nz,$11ed        ; 0011A8 C2 ED 11
    dec    hl              ; 0011AB 2B
    ld     c,e             ; 0011AC 4B
    ld     (hl),e          ; 0011AD 73
    adc    a,(hl)          ; 0011AE 8E
    and    e               ; 0011AF A3
    xor    l               ; 0011B0 AD
    or     (hl)            ; 0011B1 B6
    ret    nz              ; 0011B2 C0
    ret    z               ; 0011B3 C8
    jp     nc,$d3d5        ; 0011B4 D2 D5 D3
    call   nc,$dfd5        ; 0011B7 D4 D5 DF
    add    a,l             ; 0011BA 85
    sub    $c1             ; 0011BB D6 C1
    add    a,b             ; 0011BD 80
    add    a,a             ; 0011BE 87
    add    a,b             ; 0011BF 80
    adc    a,a             ; 0011C0 8F
    push   bc              ; 0011C1 C5
    ld     (hl),l          ; 0011C2 75
    halt                   ; 0011C3 76
    ld     (hl),a          ; 0011C4 77
    xor    d               ; 0011C5 AA
    xor    h               ; 0011C6 AC
    ld     (de),a          ; 0011C7 12
    adc    a,c             ; 0011C8 89
    inc    l               ; 0011C9 2C
    jp     nz,$d4d3        ; 0011CA C2 D3 D4
    exx                    ; 0011CD D9
    add    a,(hl)          ; 0011CE 86
    sub    $c1             ; 0011CF D6 C1
    add    a,b             ; 0011D1 80
    add    a,a             ; 0011D2 87
    add    a,b             ; 0011D3 80
    adc    a,a             ; 0011D4 8F
    push   bc              ; 0011D5 C5
    halt                   ; 0011D6 76
    ld     (hl),a          ; 0011D7 77
    ld     a,b             ; 0011D8 78
    xor    d               ; 0011D9 AA
    xor    h               ; 0011DA AC
    push   af              ; 0011DB F5
    adc    a,c             ; 0011DC 89
    xor    h               ; 0011DD AC
    jp     nz,$d4d3        ; 0011DE C2 D3 D4
    jp     c,$d686         ; 0011E1 DA 86 D6
    pop    bc              ; 0011E4 C1
    add    a,b             ; 0011E5 80
    add    a,a             ; 0011E6 87
    add    a,b             ; 0011E7 80
    adc    a,a             ; 0011E8 8F
    push   bc              ; 0011E9 C5
    ld     (hl),a          ; 0011EA 77
    ld     a,b             ; 0011EB 78
    ld     l,d             ; 0011EC 6A
    xor    e               ; 0011ED AB
    xor    h               ; 0011EE AC
    push   af              ; 0011EF F5
    adc    a,c             ; 0011F0 89
    xor    h               ; 0011F1 AC
    jp     nz,$d4d3        ; 0011F2 C2 D3 D4
    in     a,($86)         ; 0011F5 DB 86
    sub    $c1             ; 0011F7 D6 C1
    add    a,b             ; 0011F9 80
    add    a,a             ; 0011FA 87
    add    a,b             ; 0011FB 80
    adc    a,a             ; 0011FC 8F
    push   bc              ; 0011FD C5
    ld     a,b             ; 0011FE 78
    ld     l,d             ; 0011FF 6A
    pop    de              ; 001200 D1
    dec    d               ; 001201 15
    ld     d,d             ; 001202 52
    jr     $11a5           ; 001203 18 A0
    ld     d,$02           ; 001205 16 02
    rla                    ; 001207 17
    ld     c,$12           ; 001208 0E 12
    ld     c,e             ; 00120A 4B
    inc    de              ; 00120B 13
    ld     ($2200),a       ; 00120C 32 00 22
    ld     (de),a          ; 00120F 12
    ld     l,$12           ; 001210 2E 12
    dec    sp              ; 001212 3B
    ld     (de),a          ; 001213 12
    ld     b,a             ; 001214 47
    ld     (de),a          ; 001215 12
    adc    a,c             ; 001216 89
    ld     (de),a          ; 001217 12
    cp     (hl)            ; 001218 BE
    ld     (de),a          ; 001219 12
    ei                     ; 00121A FB
    ld     (de),a          ; 00121B 12
    dec    d               ; 00121C 15
    inc    de              ; 00121D 13
    cpl                    ; 00121E 2F
    inc    de              ; 00121F 13
    scf                    ; 001220 37
    inc    de              ; 001221 13
    ld     b,b             ; 001222 40
    ld     h,b             ; 001223 60
    ld     (hl),b          ; 001224 70
    ld     h,b             ; 001225 60
    ld     d,b             ; 001226 50
    jr     nc,$1239        ; 001227 30 10
    ret    p               ; 001229 F0
    ret    nc              ; 00122A D0
    or     b               ; 00122B B0
    sub    b               ; 00122C 90
    add    a,e             ; 00122D 83
    nop                    ; 00122E 00
    ld     (bc),a          ; 00122F 02
    inc    b               ; 001230 04
    ld     b,$08           ; 001231 06 08
    ld     a,(bc)          ; 001233 0A
    inc    c               ; 001234 0C
    ld     c,$10           ; 001235 0E 10
    ld     (de),a          ; 001237 12
    inc    d               ; 001238 14
    jr     $11bc           ; 001239 18 81
    nop                    ; 00123B 00
    nop                    ; 00123C 00
    ld     bc,$0103        ; 00123D 01 03 01
    nop                    ; 001240 00
    rst    38h             ; 001241 FF
    db     $fd             ; 001242 FD
    rst    38h             ; 001243 FF
    nop                    ; 001244 00
    add    a,d             ; 001245 82
    ld     (bc),a          ; 001246 02
    nop                    ; 001247 00
    nop                    ; 001248 00
    nop                    ; 001249 00
    nop                    ; 00124A 00
    nop                    ; 00124B 00
    nop                    ; 00124C 00
    nop                    ; 00124D 00
    nop                    ; 00124E 00
    nop                    ; 00124F 00
    nop                    ; 001250 00
    nop                    ; 001251 00
    nop                    ; 001252 00
    nop                    ; 001253 00
    nop                    ; 001254 00
    nop                    ; 001255 00
    nop                    ; 001256 00
    nop                    ; 001257 00
    nop                    ; 001258 00
    nop                    ; 001259 00
    nop                    ; 00125A 00
    nop                    ; 00125B 00
    nop                    ; 00125C 00
    nop                    ; 00125D 00
    nop                    ; 00125E 00
    nop                    ; 00125F 00
    nop                    ; 001260 00
    nop                    ; 001261 00
    nop                    ; 001262 00
    nop                    ; 001263 00
    nop                    ; 001264 00
    nop                    ; 001265 00
    nop                    ; 001266 00
    nop                    ; 001267 00
    nop                    ; 001268 00
    nop                    ; 001269 00
    nop                    ; 00126A 00
    nop                    ; 00126B 00
    nop                    ; 00126C 00
    nop                    ; 00126D 00
    nop                    ; 00126E 00
    ld     (bc),a          ; 00126F 02
    inc    b               ; 001270 04
    ld     b,$08           ; 001271 06 08
    ld     a,(bc)          ; 001273 0A
    inc    c               ; 001274 0C
    ld     a,(bc)          ; 001275 0A
    ex     af,af'          ; 001276 08
    ld     b,$04           ; 001277 06 04
    ld     (bc),a          ; 001279 02
    nop                    ; 00127A 00
    cp     $fc             ; 00127B FE FC
    jp     m,$f6f8         ; 00127D FA F8 F6
    call   p,$f8f6         ; 001280 F4 F6 F8
    jp     m,$fefc         ; 001283 FA FC FE
    nop                    ; 001286 00
    add    a,d             ; 001287 82
    add    hl,hl           ; 001288 29
    nop                    ; 001289 00
    nop                    ; 00128A 00
    nop                    ; 00128B 00
    nop                    ; 00128C 00
    nop                    ; 00128D 00
    nop                    ; 00128E 00
    nop                    ; 00128F 00
    nop                    ; 001290 00
    nop                    ; 001291 00
    nop                    ; 001292 00
    nop                    ; 001293 00
    nop                    ; 001294 00
    nop                    ; 001295 00
    nop                    ; 001296 00
    nop                    ; 001297 00
    nop                    ; 001298 00
    nop                    ; 001299 00
    nop                    ; 00129A 00
    nop                    ; 00129B 00
    nop                    ; 00129C 00
    nop                    ; 00129D 00
    nop                    ; 00129E 00
    nop                    ; 00129F 00
    nop                    ; 0012A0 00
    nop                    ; 0012A1 00
    nop                    ; 0012A2 00
    nop                    ; 0012A3 00
    nop                    ; 0012A4 00
    ld     (bc),a          ; 0012A5 02
    inc    b               ; 0012A6 04
    ld     b,$08           ; 0012A7 06 08
    ld     a,(bc)          ; 0012A9 0A
    inc    c               ; 0012AA 0C
    ld     a,(bc)          ; 0012AB 0A
    ex     af,af'          ; 0012AC 08
    ld     b,$04           ; 0012AD 06 04
    ld     (bc),a          ; 0012AF 02
    nop                    ; 0012B0 00
    cp     $fc             ; 0012B1 FE FC
    jp     m,$f6f8         ; 0012B3 FA F8 F6
    call   p,$f8f6         ; 0012B6 F4 F6 F8
    jp     m,$fefc         ; 0012B9 FA FC FE
    add    a,d             ; 0012BC 82
    dec    de              ; 0012BD 1B
    nop                    ; 0012BE 00
    nop                    ; 0012BF 00
    nop                    ; 0012C0 00
    nop                    ; 0012C1 00
    nop                    ; 0012C2 00
    nop                    ; 0012C3 00
    nop                    ; 0012C4 00
    nop                    ; 0012C5 00
    nop                    ; 0012C6 00
    nop                    ; 0012C7 00
    nop                    ; 0012C8 00
    nop                    ; 0012C9 00
    nop                    ; 0012CA 00
    nop                    ; 0012CB 00
    nop                    ; 0012CC 00
    nop                    ; 0012CD 00
    nop                    ; 0012CE 00
    nop                    ; 0012CF 00
    nop                    ; 0012D0 00
    nop                    ; 0012D1 00
    nop                    ; 0012D2 00
    nop                    ; 0012D3 00
    nop                    ; 0012D4 00
    nop                    ; 0012D5 00
    nop                    ; 0012D6 00
    nop                    ; 0012D7 00
    nop                    ; 0012D8 00
    nop                    ; 0012D9 00
    nop                    ; 0012DA 00
    nop                    ; 0012DB 00
    nop                    ; 0012DC 00
    nop                    ; 0012DD 00
    nop                    ; 0012DE 00
    nop                    ; 0012DF 00
    nop                    ; 0012E0 00
    nop                    ; 0012E1 00
    nop                    ; 0012E2 00
    nop                    ; 0012E3 00
    nop                    ; 0012E4 00
    nop                    ; 0012E5 00
    nop                    ; 0012E6 00
    nop                    ; 0012E7 00
    nop                    ; 0012E8 00
    nop                    ; 0012E9 00
    nop                    ; 0012EA 00
    nop                    ; 0012EB 00
    nop                    ; 0012EC 00
    nop                    ; 0012ED 00
    nop                    ; 0012EE 00
    nop                    ; 0012EF 00
    inc    bc              ; 0012F0 03
    ld     b,$03           ; 0012F1 06 03
    nop                    ; 0012F3 00
    db     $fd             ; 0012F4 FD
    jp     m,$fdfa         ; 0012F5 FA FA FD
    nop                    ; 0012F8 00
    add    a,d             ; 0012F9 82
    inc    sp              ; 0012FA 33
    nop                    ; 0012FB 00
    nop                    ; 0012FC 00
    nop                    ; 0012FD 00
    nop                    ; 0012FE 00
    nop                    ; 0012FF 00
    nop                    ; 001300 00
    nop                    ; 001301 00
    nop                    ; 001302 00
    nop                    ; 001303 00
    nop                    ; 001304 00
    nop                    ; 001305 00
    nop                    ; 001306 00
    nop                    ; 001307 00
    nop                    ; 001308 00
    nop                    ; 001309 00
    nop                    ; 00130A 00
    ld     (bc),a          ; 00130B 02
    inc    b               ; 00130C 04
    ld     (bc),a          ; 00130D 02
    nop                    ; 00130E 00
    cp     $fc             ; 00130F FE FC
    cp     $00             ; 001311 FE 00
    add    a,d             ; 001313 82
    ld     de,$fffe        ; 001314 11 FE FF
    nop                    ; 001317 00
    nop                    ; 001318 00
    nop                    ; 001319 00
    nop                    ; 00131A 00
    nop                    ; 00131B 00
    nop                    ; 00131C 00
    nop                    ; 00131D 00
    nop                    ; 00131E 00
    nop                    ; 00131F 00
    nop                    ; 001320 00
    nop                    ; 001321 00
    nop                    ; 001322 00
    nop                    ; 001323 00
    nop                    ; 001324 00
    nop                    ; 001325 00
    nop                    ; 001326 00
    ld     bc,$0001        ; 001327 01 01 00
    nop                    ; 00132A 00
    rst    38h             ; 00132B FF
    rst    38h             ; 00132C FF
    add    a,d             ; 00132D 82
    ld     de,$0203        ; 00132E 11 03 02
    ld     bc,$0000        ; 001331 01 00 00
    nop                    ; 001334 00
    ld     bc,$0081        ; 001335 01 81 00
    nop                    ; 001338 00
    nop                    ; 001339 00
    nop                    ; 00133A 00
    ld     bc,$0101        ; 00133B 01 01 01
    ld     bc,$0202        ; 00133E 01 02 02
    ld     bc,$0101        ; 001341 01 01 01
    nop                    ; 001344 00
    nop                    ; 001345 00
    nop                    ; 001346 00
    add    a,h             ; 001347 84
    ld     bc,$0482        ; 001348 01 82 04
    sbc    a,c             ; 00134B 99
    inc    de              ; 00134C 13
    sbc    a,e             ; 00134D 9B
    inc    de              ; 00134E 13
    and    d               ; 00134F A2
    inc    de              ; 001350 13
    cp     e               ; 001351 BB
    inc    de              ; 001352 13
    rst    00h             ; 001353 C7
    inc    de              ; 001354 13
    jp     nc,$e113        ; 001355 D2 13 E1
    inc    de              ; 001358 13
    jp     pe,$fb13        ; 001359 EA 13 FB
    inc    de              ; 00135C 13
    ld     b,$14           ; 00135D 06 14
    dec    de              ; 00135F 1B
    inc    d               ; 001360 14
    dec    h               ; 001361 25
    inc    d               ; 001362 14
    ld     l,$14           ; 001363 2E 14
    jr     nc,$137b        ; 001365 30 14
    ld     ($3914),a       ; 001367 32 14 39
    inc    d               ; 00136A 14
    ld     e,b             ; 00136B 58
    inc    d               ; 00136C 14
    ld     e,a             ; 00136D 5F
    inc    d               ; 00136E 14
    ld     l,d             ; 00136F 6A
    inc    d               ; 001370 14
    ld     a,c             ; 001371 79
    inc    d               ; 001372 14
    ld     a,a             ; 001373 7F
    inc    d               ; 001374 14
    sub    b               ; 001375 90
    inc    d               ; 001376 14
    sbc    a,e             ; 001377 9B
    inc    d               ; 001378 14
    or     b               ; 001379 B0
    inc    d               ; 00137A 14
    ret                    ; 00137B C9
    inc    d               ; 00137C 14
    jp     nc,$d914        ; 00137D D2 14 D9
    inc    d               ; 001380 14
    jp     po,$f314        ; 001381 E2 14 F3
    inc    d               ; 001384 14
    jr     nz,$139c        ; 001385 20 15
    inc    hl              ; 001387 23
    dec    d               ; 001388 15
    daa                    ; 001389 27
    dec    d               ; 00138A 15
    inc    (hl)            ; 00138B 34
    dec    d               ; 00138C 15
    ld     b,(hl)          ; 00138D 46
    dec    d               ; 00138E 15
    ld     c,l             ; 00138F 4D
    dec    d               ; 001390 15
    ld     d,(hl)          ; 001391 56
    dec    d               ; 001392 15
    ld     e,d             ; 001393 5A
    dec    d               ; 001394 15
    push   af              ; 001395 F5
    nop                    ; 001396 00
    ld     h,$00           ; 001397 26 00
    ld     (bc),a          ; 001399 02
    add    a,e             ; 00139A 83
    nop                    ; 00139B 00
    ld     (bc),a          ; 00139C 02
    inc    b               ; 00139D 04
    ld     b,$08           ; 00139E 06 08
    djnz   $1325           ; 0013A0 10 83
    ld     (bc),a          ; 0013A2 02
    ld     bc,$0000        ; 0013A3 01 00 00
    ld     bc,$0202        ; 0013A6 01 02 02
    ld     (bc),a          ; 0013A9 02
    ld     (bc),a          ; 0013AA 02
    ld     (bc),a          ; 0013AB 02
    ld     (bc),a          ; 0013AC 02
    ld     (bc),a          ; 0013AD 02
    ld     (bc),a          ; 0013AE 02
    ld     (bc),a          ; 0013AF 02
    ld     (bc),a          ; 0013B0 02
    ld     (bc),a          ; 0013B1 02
    ld     (bc),a          ; 0013B2 02
    inc    bc              ; 0013B3 03
    inc    bc              ; 0013B4 03
    inc    bc              ; 0013B5 03
    inc    b               ; 0013B6 04
    inc    b               ; 0013B7 04
    inc    b               ; 0013B8 04
    dec    b               ; 0013B9 05
    add    a,c             ; 0013BA 81
    nop                    ; 0013BB 00
    nop                    ; 0013BC 00
    ld     (bc),a          ; 0013BD 02
    inc    bc              ; 0013BE 03
    inc    b               ; 0013BF 04
    inc    b               ; 0013C0 04
    dec    b               ; 0013C1 05
    dec    b               ; 0013C2 05
    dec    b               ; 0013C3 05
    ld     b,$06           ; 0013C4 06 06
    add    a,c             ; 0013C6 81
    inc    bc              ; 0013C7 03
    nop                    ; 0013C8 00
    ld     bc,$0101        ; 0013C9 01 01 01
    ld     (bc),a          ; 0013CC 02
    inc    bc              ; 0013CD 03
    inc    b               ; 0013CE 04
    inc    b               ; 0013CF 04
    dec    b               ; 0013D0 05
    add    a,c             ; 0013D1 81
    nop                    ; 0013D2 00
    nop                    ; 0013D3 00
    ld     bc,$0201        ; 0013D4 01 01 02
    inc    bc              ; 0013D7 03
    inc    b               ; 0013D8 04
    dec    b               ; 0013D9 05
    dec    b               ; 0013DA 05
    ld     b,$08           ; 0013DB 06 08
    rlca                   ; 0013DD 07
    rlca                   ; 0013DE 07
    ld     b,$81           ; 0013DF 06 81
    ld     bc,$030c        ; 0013E1 01 0C 03
    rrca                   ; 0013E4 0F
    ld     (bc),a          ; 0013E5 02
    rlca                   ; 0013E6 07
    inc    bc              ; 0013E7 03
    rrca                   ; 0013E8 0F
    add    a,b             ; 0013E9 80
    nop                    ; 0013EA 00
    nop                    ; 0013EB 00
    nop                    ; 0013EC 00
    ld     (bc),a          ; 0013ED 02
    inc    bc              ; 0013EE 03
    inc    bc              ; 0013EF 03
    inc    b               ; 0013F0 04
    dec    b               ; 0013F1 05
    ld     b,$07           ; 0013F2 06 07
    ex     af,af'          ; 0013F4 08
    add    hl,bc           ; 0013F5 09
    ld     a,(bc)          ; 0013F6 0A
    dec    bc              ; 0013F7 0B
    ld     c,$0f           ; 0013F8 0E 0F
    add    a,e             ; 0013FA 83
    inc    bc              ; 0013FB 03
    ld     (bc),a          ; 0013FC 02
    ld     bc,$0001        ; 0013FD 01 01 00
    nop                    ; 001400 00
    ld     bc,$0302        ; 001401 01 02 03
    inc    b               ; 001404 04
    add    a,c             ; 001405 81
    ld     bc,$0000        ; 001406 01 00 00
    nop                    ; 001409 00
    nop                    ; 00140A 00
    ld     bc,$0101        ; 00140B 01 01 01
    ld     (bc),a          ; 00140E 02
    ld     (bc),a          ; 00140F 02
    ld     (bc),a          ; 001410 02
    inc    bc              ; 001411 03
    inc    bc              ; 001412 03
    inc    bc              ; 001413 03
    inc    bc              ; 001414 03
    inc    b               ; 001415 04
    inc    b               ; 001416 04
    inc    b               ; 001417 04
    dec    b               ; 001418 05
    dec    b               ; 001419 05
    add    a,c             ; 00141A 81
    djnz   $143d           ; 00141B 10 20
    jr     nc,$145f        ; 00141D 30 40
    jr     nc,$1441        ; 00141F 30 20
    djnz   $1423           ; 001421 10 00
    ret    p               ; 001423 F0
    add    a,b             ; 001424 80
    nop                    ; 001425 00
    nop                    ; 001426 00
    ld     bc,$0301        ; 001427 01 01 03
    inc    bc              ; 00142A 03
    inc    b               ; 00142B 04
    dec    b               ; 00142C 05
    add    a,e             ; 00142D 83
    nop                    ; 00142E 00
    add    a,c             ; 00142F 81
    ld     (bc),a          ; 001430 02
    add    a,e             ; 001431 83
    nop                    ; 001432 00
    ld     (bc),a          ; 001433 02
    inc    b               ; 001434 04
    ld     b,$08           ; 001435 06 08
    djnz   $13bc           ; 001437 10 83
    add    hl,bc           ; 001439 09
    add    hl,bc           ; 00143A 09
    add    hl,bc           ; 00143B 09
    ex     af,af'          ; 00143C 08
    ex     af,af'          ; 00143D 08
    ex     af,af'          ; 00143E 08
    rlca                   ; 00143F 07
    rlca                   ; 001440 07
    rlca                   ; 001441 07
    ld     b,$06           ; 001442 06 06
    ld     b,$05           ; 001444 06 05
    dec    b               ; 001446 05
    dec    b               ; 001447 05
    inc    b               ; 001448 04
    inc    b               ; 001449 04
    inc    b               ; 00144A 04
    inc    bc              ; 00144B 03
    inc    bc              ; 00144C 03
    inc    bc              ; 00144D 03
    ld     (bc),a          ; 00144E 02
    ld     (bc),a          ; 00144F 02
    ld     (bc),a          ; 001450 02
    ld     bc,$0101        ; 001451 01 01 01
    nop                    ; 001454 00
    nop                    ; 001455 00
    nop                    ; 001456 00
    add    a,c             ; 001457 81
    ld     bc,$0101        ; 001458 01 01 01
    nop                    ; 00145B 00
    nop                    ; 00145C 00
    nop                    ; 00145D 00
    add    a,c             ; 00145E 81
    inc    bc              ; 00145F 03
    nop                    ; 001460 00
    ld     bc,$0101        ; 001461 01 01 01
    ld     (bc),a          ; 001464 02
    inc    bc              ; 001465 03
    inc    b               ; 001466 04
    inc    b               ; 001467 04
    dec    b               ; 001468 05
    add    a,c             ; 001469 81
    nop                    ; 00146A 00
    nop                    ; 00146B 00
    ld     bc,$0201        ; 00146C 01 01 02
    inc    bc              ; 00146F 03
    inc    b               ; 001470 04
    dec    b               ; 001471 05
    dec    b               ; 001472 05
    ld     b,$08           ; 001473 06 08
    rlca                   ; 001475 07
    rlca                   ; 001476 07
    ld     b,$81           ; 001477 06 81
    ld     a,(bc)          ; 001479 0A
    dec    b               ; 00147A 05
    nop                    ; 00147B 00
    inc    b               ; 00147C 04
    ex     af,af'          ; 00147D 08
    add    a,e             ; 00147E 83
    nop                    ; 00147F 00
    nop                    ; 001480 00
    nop                    ; 001481 00
    ld     (bc),a          ; 001482 02
    inc    bc              ; 001483 03
    inc    bc              ; 001484 03
    inc    b               ; 001485 04
    dec    b               ; 001486 05
    ld     b,$07           ; 001487 06 07
    ex     af,af'          ; 001489 08
    add    hl,bc           ; 00148A 09
    ld     a,(bc)          ; 00148B 0A
    dec    bc              ; 00148C 0B
    ld     c,$0f           ; 00148D 0E 0F
    add    a,e             ; 00148F 83
    inc    bc              ; 001490 03
    ld     (bc),a          ; 001491 02
    ld     bc,$0001        ; 001492 01 01 00
    nop                    ; 001495 00
    ld     bc,$0302        ; 001496 01 02 03
    inc    b               ; 001499 04
    add    a,c             ; 00149A 81
    ld     bc,$0000        ; 00149B 01 00 00
    nop                    ; 00149E 00
    nop                    ; 00149F 00
    ld     bc,$0101        ; 0014A0 01 01 01
    ld     (bc),a          ; 0014A3 02
    ld     (bc),a          ; 0014A4 02
    ld     (bc),a          ; 0014A5 02
    inc    bc              ; 0014A6 03
    inc    bc              ; 0014A7 03
    inc    bc              ; 0014A8 03
    inc    bc              ; 0014A9 03
    inc    b               ; 0014AA 04
    inc    b               ; 0014AB 04
    inc    b               ; 0014AC 04
    dec    b               ; 0014AD 05
    dec    b               ; 0014AE 05
    add    a,c             ; 0014AF 81
    djnz   $14d2           ; 0014B0 10 20
    jr     nc,$14f4        ; 0014B2 30 40
    jr     nc,$14d6        ; 0014B4 30 20
    djnz   $14b8           ; 0014B6 10 00
    djnz   $14da           ; 0014B8 10 20
    jr     nc,$14fc        ; 0014BA 30 40
    jr     nc,$14de        ; 0014BC 30 20
    djnz   $14c0           ; 0014BE 10 00
    djnz   $14e2           ; 0014C0 10 20
    jr     nc,$1504        ; 0014C2 30 40
    jr     nc,$14e6        ; 0014C4 30 20
    djnz   $14c8           ; 0014C6 10 00
    add    a,b             ; 0014C8 80
    nop                    ; 0014C9 00
    nop                    ; 0014CA 00
    ld     bc,$0301        ; 0014CB 01 01 03
    inc    bc              ; 0014CE 03
    inc    b               ; 0014CF 04
    dec    b               ; 0014D0 05
    add    a,e             ; 0014D1 83
    nop                    ; 0014D2 00
    ld     (bc),a          ; 0014D3 02
    inc    b               ; 0014D4 04
    ld     b,$08           ; 0014D5 06 08
    ld     d,$83           ; 0014D7 16 83
    nop                    ; 0014D9 00
    nop                    ; 0014DA 00
    ld     bc,$0301        ; 0014DB 01 01 03
    inc    bc              ; 0014DE 03
    inc    b               ; 0014DF 04
    dec    b               ; 0014E0 05
    add    a,e             ; 0014E1 83
    inc    b               ; 0014E2 04
    inc    b               ; 0014E3 04
    inc    b               ; 0014E4 04
    inc    b               ; 0014E5 04
    inc    bc              ; 0014E6 03
    inc    bc              ; 0014E7 03
    inc    bc              ; 0014E8 03
    inc    bc              ; 0014E9 03
    ld     (bc),a          ; 0014EA 02
    ld     (bc),a          ; 0014EB 02
    ld     (bc),a          ; 0014EC 02
    ld     (bc),a          ; 0014ED 02
    ld     bc,$0101        ; 0014EE 01 01 01
    ld     bc,$0083        ; 0014F1 01 83 00
    nop                    ; 0014F4 00
    nop                    ; 0014F5 00
    nop                    ; 0014F6 00
    ld     bc,$0101        ; 0014F7 01 01 01
    ld     bc,$0202        ; 0014FA 01 02 02
    ld     (bc),a          ; 0014FD 02
    ld     (bc),a          ; 0014FE 02
    inc    bc              ; 0014FF 03
    inc    bc              ; 001500 03
    inc    bc              ; 001501 03
    inc    bc              ; 001502 03
    inc    b               ; 001503 04
    inc    b               ; 001504 04
    inc    b               ; 001505 04
    inc    b               ; 001506 04
    dec    b               ; 001507 05
    dec    b               ; 001508 05
    dec    b               ; 001509 05
    dec    b               ; 00150A 05
    ld     b,$06           ; 00150B 06 06
    ld     b,$06           ; 00150D 06 06
    rlca                   ; 00150F 07
    rlca                   ; 001510 07
    rlca                   ; 001511 07
    rlca                   ; 001512 07
    ex     af,af'          ; 001513 08
    ex     af,af'          ; 001514 08
    ex     af,af'          ; 001515 08
    ex     af,af'          ; 001516 08
    add    hl,bc           ; 001517 09
    add    hl,bc           ; 001518 09
    add    hl,bc           ; 001519 09
    add    hl,bc           ; 00151A 09
    ld     a,(bc)          ; 00151B 0A
    ld     a,(bc)          ; 00151C 0A
    ld     a,(bc)          ; 00151D 0A
    ld     a,(bc)          ; 00151E 0A
    add    a,c             ; 00151F 81
    nop                    ; 001520 00
    ld     a,(bc)          ; 001521 0A
    add    a,e             ; 001522 83
    nop                    ; 001523 00
    ld     (bc),a          ; 001524 02
    inc    b               ; 001525 04
    add    a,c             ; 001526 81
    jr     nc,$1549        ; 001527 30 20
    djnz   $152b           ; 001529 10 00
    nop                    ; 00152B 00
    nop                    ; 00152C 00
    nop                    ; 00152D 00
    nop                    ; 00152E 00
    ex     af,af'          ; 00152F 08
    djnz   $1552           ; 001530 10 20
    jr     nc,$14b5        ; 001532 30 81
    nop                    ; 001534 00
    inc    b               ; 001535 04
    inc    b               ; 001536 04
    inc    b               ; 001537 04
    inc    b               ; 001538 04
    inc    b               ; 001539 04
    inc    b               ; 00153A 04
    inc    b               ; 00153B 04
    inc    b               ; 00153C 04
    inc    b               ; 00153D 04
    inc    b               ; 00153E 04
    ld     b,$06           ; 00153F 06 06
    ld     b,$08           ; 001541 06 08
    ex     af,af'          ; 001543 08
    ld     a,(bc)          ; 001544 0A
    add    a,e             ; 001545 83
    nop                    ; 001546 00
    ld     (bc),a          ; 001547 02
    inc    bc              ; 001548 03
    inc    b               ; 001549 04
    ld     b,$07           ; 00154A 06 07
    add    a,c             ; 00154C 81
    ld     (bc),a          ; 00154D 02
    ld     bc,$0000        ; 00154E 01 00 00
    nop                    ; 001551 00
    ld     (bc),a          ; 001552 02
    inc    b               ; 001553 04
    rlca                   ; 001554 07
    add    a,c             ; 001555 81
    rrca                   ; 001556 0F
    ld     bc,$8305        ; 001557 01 05 83
    ex     af,af'          ; 00155A 08
    ld     b,$02           ; 00155B 06 02
    inc    bc              ; 00155D 03
    inc    b               ; 00155E 04
    dec    b               ; 00155F 05
    ld     b,$07           ; 001560 06 07
    ex     af,af'          ; 001562 08
    add    hl,bc           ; 001563 09
    ld     a,(bc)          ; 001564 0A
    dec    bc              ; 001565 0B
    inc    c               ; 001566 0C
    dec    c               ; 001567 0D
    ld     c,$0f           ; 001568 0E 0F
    djnz   $14ef           ; 00156A 10 83
    nop                    ; 00156C 00
    nop                    ; 00156D 00
    nop                    ; 00156E 00
    nop                    ; 00156F 00
    nop                    ; 001570 00
    nop                    ; 001571 00
    nop                    ; 001572 00
    nop                    ; 001573 00
    nop                    ; 001574 00
    nop                    ; 001575 00
    ld     bc,$0101        ; 001576 01 01 01
    ld     bc,$0101        ; 001579 01 01 01
    ld     bc,$0101        ; 00157C 01 01 01
    ld     bc,$0202        ; 00157F 01 02 02
    ld     (bc),a          ; 001582 02
    ld     (bc),a          ; 001583 02
    ld     (bc),a          ; 001584 02
    ld     (bc),a          ; 001585 02
    ld     (bc),a          ; 001586 02
    ld     (bc),a          ; 001587 02
    ld     (bc),a          ; 001588 02
    ld     (bc),a          ; 001589 02
    inc    bc              ; 00158A 03
    inc    bc              ; 00158B 03
    inc    bc              ; 00158C 03
    inc    bc              ; 00158D 03
    inc    bc              ; 00158E 03
    inc    bc              ; 00158F 03
    inc    bc              ; 001590 03
    inc    bc              ; 001591 03
    inc    bc              ; 001592 03
    inc    bc              ; 001593 03
    inc    b               ; 001594 04
    inc    b               ; 001595 04
    inc    b               ; 001596 04
    inc    b               ; 001597 04
    inc    b               ; 001598 04
    inc    b               ; 001599 04
    inc    b               ; 00159A 04
    inc    b               ; 00159B 04
    inc    b               ; 00159C 04
    inc    b               ; 00159D 04
    dec    b               ; 00159E 05
    dec    b               ; 00159F 05
    dec    b               ; 0015A0 05
    dec    b               ; 0015A1 05
    dec    b               ; 0015A2 05
    dec    b               ; 0015A3 05
    dec    b               ; 0015A4 05
    dec    b               ; 0015A5 05
    dec    b               ; 0015A6 05
    dec    b               ; 0015A7 05
    ld     b,$06           ; 0015A8 06 06
    ld     b,$06           ; 0015AA 06 06
    ld     b,$06           ; 0015AC 06 06
    ld     b,$06           ; 0015AE 06 06
    ld     b,$06           ; 0015B0 06 06
    rlca                   ; 0015B2 07
    rlca                   ; 0015B3 07
    rlca                   ; 0015B4 07
    rlca                   ; 0015B5 07
    rlca                   ; 0015B6 07
    rlca                   ; 0015B7 07
    rlca                   ; 0015B8 07
    rlca                   ; 0015B9 07
    rlca                   ; 0015BA 07
    rlca                   ; 0015BB 07
    ex     af,af'          ; 0015BC 08
    ex     af,af'          ; 0015BD 08
    ex     af,af'          ; 0015BE 08
    ex     af,af'          ; 0015BF 08
    ex     af,af'          ; 0015C0 08
    ex     af,af'          ; 0015C1 08
    ex     af,af'          ; 0015C2 08
    ex     af,af'          ; 0015C3 08
    ex     af,af'          ; 0015C4 08
    ex     af,af'          ; 0015C5 08
    add    hl,bc           ; 0015C6 09
    add    hl,bc           ; 0015C7 09
    add    hl,bc           ; 0015C8 09
    add    hl,bc           ; 0015C9 09
    add    hl,bc           ; 0015CA 09
    add    hl,bc           ; 0015CB 09
    add    hl,bc           ; 0015CC 09
    add    hl,bc           ; 0015CD 09
    add    hl,bc           ; 0015CE 09
    add    hl,bc           ; 0015CF 09
    add    a,e             ; 0015D0 83
    add    a,b             ; 0015D1 80
    add    a,b             ; 0015D2 80
    add    a,b             ; 0015D3 80
    add    a,b             ; 0015D4 80
    add    a,b             ; 0015D5 80
    add    a,b             ; 0015D6 80
    add    a,b             ; 0015D7 80
    add    a,b             ; 0015D8 80
    add    a,b             ; 0015D9 80
    add    a,b             ; 0015DA 80
    add    a,b             ; 0015DB 80
    add    a,b             ; 0015DC 80
    add    a,b             ; 0015DD 80
    add    a,b             ; 0015DE 80
    add    a,b             ; 0015DF 80
    ld     a,a             ; 0015E0 7F
    ld     a,a             ; 0015E1 7F
    ld     a,a             ; 0015E2 7F
    ld     a,a             ; 0015E3 7F
    ld     a,a             ; 0015E4 7F
    ld     a,a             ; 0015E5 7F
    ld     a,a             ; 0015E6 7F
    ld     a,a             ; 0015E7 7F
    ld     a,a             ; 0015E8 7F
    ld     a,a             ; 0015E9 7F
    ld     a,a             ; 0015EA 7F
    ld     a,a             ; 0015EB 7F
    ld     a,a             ; 0015EC 7F
    ld     a,a             ; 0015ED 7F
    ld     a,a             ; 0015EE 7F
    ld     a,a             ; 0015EF 7F
    ld     a,a             ; 0015F0 7F
    ld     a,a             ; 0015F1 7F
    ld     a,a             ; 0015F2 7F
    ld     a,a             ; 0015F3 7F
    ld     a,a             ; 0015F4 7F
    ld     a,a             ; 0015F5 7F
    ld     a,a             ; 0015F6 7F
    ld     a,a             ; 0015F7 7F
    ld     a,a             ; 0015F8 7F
    ld     a,a             ; 0015F9 7F
    ld     a,a             ; 0015FA 7F
    ld     a,a             ; 0015FB 7F
    ld     a,a             ; 0015FC 7F
    ld     a,a             ; 0015FD 7F
    ld     a,a             ; 0015FE 7F
    ld     a,a             ; 0015FF 7F
    ld     a,a             ; 001600 7F
    ld     a,a             ; 001601 7F
    ld     a,a             ; 001602 7F
    ld     a,a             ; 001603 7F
    ld     a,a             ; 001604 7F
    ld     a,a             ; 001605 7F
    ld     a,a             ; 001606 7F
    ld     a,a             ; 001607 7F
    ld     a,a             ; 001608 7F
    ld     a,a             ; 001609 7F
    ld     a,a             ; 00160A 7F
    ld     a,a             ; 00160B 7F
    ld     a,a             ; 00160C 7F
    ld     a,a             ; 00160D 7F
    ld     a,a             ; 00160E 7F
    ld     a,a             ; 00160F 7F
    ld     a,a             ; 001610 7F
    ld     a,a             ; 001611 7F
    ld     a,a             ; 001612 7F
    ld     a,a             ; 001613 7F
    ld     a,a             ; 001614 7F
    ld     a,a             ; 001615 7F
    ld     a,a             ; 001616 7F
    ld     a,a             ; 001617 7F
    ld     a,a             ; 001618 7F
    ld     a,a             ; 001619 7F
    ld     a,a             ; 00161A 7F
    ld     a,a             ; 00161B 7F
    ld     a,a             ; 00161C 7F
    ld     a,a             ; 00161D 7F
    ld     a,a             ; 00161E 7F
    ld     a,a             ; 00161F 7F
    ld     a,a             ; 001620 7F
    ld     a,a             ; 001621 7F
    ld     a,a             ; 001622 7F
    ld     a,a             ; 001623 7F
    ld     a,a             ; 001624 7F
    ld     a,a             ; 001625 7F
    ld     a,a             ; 001626 7F
    ld     a,a             ; 001627 7F
    ld     a,a             ; 001628 7F
    ld     a,a             ; 001629 7F
    ld     a,a             ; 00162A 7F
    ld     a,a             ; 00162B 7F
    ld     a,a             ; 00162C 7F
    ld     a,a             ; 00162D 7F
    ld     a,a             ; 00162E 7F
    ld     a,a             ; 00162F 7F
    ld     a,a             ; 001630 7F
    ld     a,a             ; 001631 7F
    ld     a,a             ; 001632 7F
    ld     a,a             ; 001633 7F
    ld     a,a             ; 001634 7F
    ld     a,a             ; 001635 7F
    ld     a,a             ; 001636 7F
    ld     a,a             ; 001637 7F
    ld     a,a             ; 001638 7F
    ld     a,a             ; 001639 7F
    ld     a,a             ; 00163A 7F
    ld     a,a             ; 00163B 7F
    ld     a,a             ; 00163C 7F
    ld     a,a             ; 00163D 7F
    ld     a,a             ; 00163E 7F
    ld     a,a             ; 00163F 7F
    ld     a,a             ; 001640 7F
    ld     a,a             ; 001641 7F
    ld     a,a             ; 001642 7F
    ld     a,a             ; 001643 7F
    ld     a,a             ; 001644 7F
    ld     a,a             ; 001645 7F
    ld     a,a             ; 001646 7F
    ld     a,a             ; 001647 7F
    ld     a,a             ; 001648 7F
    ld     a,a             ; 001649 7F
    ld     a,a             ; 00164A 7F
    ld     a,a             ; 00164B 7F
    ld     a,a             ; 00164C 7F
    ld     a,a             ; 00164D 7F
    ld     a,a             ; 00164E 7F
    ld     a,a             ; 00164F 7F
    ld     a,a             ; 001650 7F
    ld     a,a             ; 001651 7F
    ld     a,a             ; 001652 7F
    ld     a,a             ; 001653 7F
    ld     a,a             ; 001654 7F
    ld     a,a             ; 001655 7F
    ld     a,a             ; 001656 7F
    ld     a,a             ; 001657 7F
    ld     a,a             ; 001658 7F
    ld     a,a             ; 001659 7F
    ld     a,a             ; 00165A 7F
    ld     a,a             ; 00165B 7F
    ld     a,a             ; 00165C 7F
    ld     a,a             ; 00165D 7F
    ld     a,a             ; 00165E 7F
    ld     a,a             ; 00165F 7F
    ld     a,a             ; 001660 7F
    ld     a,a             ; 001661 7F
    ld     a,a             ; 001662 7F
    ld     a,a             ; 001663 7F
    ld     a,a             ; 001664 7F
    ld     a,a             ; 001665 7F
    ld     a,a             ; 001666 7F
    ld     a,a             ; 001667 7F
    ld     a,a             ; 001668 7F
    ld     a,a             ; 001669 7F
    ld     a,a             ; 00166A 7F
    ld     a,a             ; 00166B 7F
    ld     a,a             ; 00166C 7F
    ld     a,a             ; 00166D 7F
    ld     a,a             ; 00166E 7F
    ld     a,a             ; 00166F 7F
    ld     a,a             ; 001670 7F
    ld     a,a             ; 001671 7F
    ld     a,a             ; 001672 7F
    ld     a,a             ; 001673 7F
    ld     a,a             ; 001674 7F
    ld     a,a             ; 001675 7F
    ld     a,a             ; 001676 7F
    ld     a,a             ; 001677 7F
    ld     a,a             ; 001678 7F
    ld     a,a             ; 001679 7F
    ld     a,a             ; 00167A 7F
    ld     a,a             ; 00167B 7F
    ld     a,a             ; 00167C 7F
    ld     a,a             ; 00167D 7F
    ld     a,a             ; 00167E 7F
    ld     a,a             ; 00167F 7F
    ld     a,a             ; 001680 7F
    ld     a,a             ; 001681 7F
    ld     a,a             ; 001682 7F
    ld     a,a             ; 001683 7F
    ld     a,a             ; 001684 7F
    ld     a,a             ; 001685 7F
    ld     a,a             ; 001686 7F
    ld     a,a             ; 001687 7F
    ld     a,a             ; 001688 7F
    ld     a,a             ; 001689 7F
    ld     a,a             ; 00168A 7F
    ld     a,a             ; 00168B 7F
    ld     a,a             ; 00168C 7F
    ld     a,a             ; 00168D 7F
    ld     a,a             ; 00168E 7F
    ld     a,a             ; 00168F 7F
    ld     a,a             ; 001690 7F
    ld     a,a             ; 001691 7F
    ld     a,a             ; 001692 7F
    ld     a,a             ; 001693 7F
    ld     a,a             ; 001694 7F
    ld     a,a             ; 001695 7F
    ld     a,a             ; 001696 7F
    ld     a,a             ; 001697 7F
    ld     a,a             ; 001698 7F
    ld     a,a             ; 001699 7F
    ld     a,a             ; 00169A 7F
    ld     a,a             ; 00169B 7F
    ld     a,a             ; 00169C 7F
    ld     a,a             ; 00169D 7F
    ld     a,a             ; 00169E 7F
    ld     a,a             ; 00169F 7F

	CPU 68000
	objend