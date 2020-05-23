	ORG 0
	SJMP prog
;**************************	
	ORG	0003h
sensor: SJMP obs
;**************************
prog:   SETB EA
	SETB EX0
loop:	CALL foward
	SJMP loop
;**************************
obs:    CLR  EA
	CALL back
	CALL delay
	JB   20h.0, esq
	CALL right
	SJMP fim
esq:	CALL left
fim:	CPL  20h.0
	CALL delay
	SETB EA
	RETI

;**************************
back:	CLR	P1.0
	CLR	P1.2
	RET
;**************************
left:	CLR	P1.0
	SETB	P1.2
	RET
;**************************
right:	SETB	P1.0
	CLR	P1.2
	RET
;**************************
foward:	SETB	P1.0
	SETB	P1.2
	RET
;**************************
delay:	MOV	R0, #00h
loopd:	CALL	d_50ms
	INC	R0
	CJNE	R0, #28h, loopd	;trocar por 28
	RET
;***************************************
d_50ms:	MOV	TH0, #03Ch
	MOV	TL0, #0AFh
	MOV	TMOD, #01h
	SETB	TR0
wait:	JBC	TF0, return
	SJMP	wait
return:	RET
;***************************************