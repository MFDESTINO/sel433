	ORG	0
	CLR	A
	MOV	R0, #50h
	MOV	DPTR, #2200h
LOOP1:	INC	A
	MOV	@R0, A
	MOVX	@DPTR, A
	INC	R0
	INC	DPTR
	CJNE	A, #15h, LOOP1
	END