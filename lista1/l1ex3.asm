	ORG	0
	MOV	R0, #50h
	MOV	DPTR, #2100h
LOOP:	MOVX	A, @DPTR
	MOV	@R0, A
	INC	R0
	INC	DPTR
	CJNE	R0, #60h, LOOP
	MOV	R0, #50h
	MOV	DPTR, #2300h
LOOP2:	MOV	A, @R0
	MOVX	@DPTR, A
	INC	R0
	INC	DPTR
	CJNE	R0, #60h, LOOP2
	END