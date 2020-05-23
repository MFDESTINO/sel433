	ORG	0
	MOV	R0, #00h
LOOP:	CALL	ATRASO
	INC	R0
	CJNE	R0, #64h, LOOP
	SJMP	FINAL
;***************************************
ATRASO:	MOV	TH0, #03Ch
	MOV	TL0, #0AFh
	MOV	TMOD, #01h
	SETB	TR0
WAIT:	JBC	TF0, RETURN
	SJMP	WAIT
RETURN:	RET
;***************************************
FINAL:	END


