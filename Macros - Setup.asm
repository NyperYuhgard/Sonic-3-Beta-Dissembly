; align to a specified address
align	macro address
	if *%(\1)<>0
		dcb.b    (\1)-(*%(\1)),$FF
	endif
    endm