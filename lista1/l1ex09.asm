	ORG	0
	MOV	R0, #08h
	MOV	20h, #0Ah
	MOV	A, 20h   ;copia o byte desejado pro A
LOOP:	RLC	A        ;rotaciona movendo o MSB para o carry
	MOV	B, A     ;faz uma copia provisoria de A
	MOV	A, 2Fh   ;copia o resultado pro A
	RRC	A        ;insere o carry no MSB
	MOV	2Fh, A   ;salva o resultado
	MOV     A, B     ;volta A para onde parou
	DJNZ	R0, LOOP ;faz o loop 8 vezes
	END	0
