        ORG	0	
;*****************************************************************************************
;primeiro é copiado da RAM externa para a área de rascunho
        MOV	R0, #50h        ;utiliza a região a partir de 50h da RAM interna pra rascunho
        MOV	DPTR, #2100h    ;endereço inicial da RAM externa em que será copiado o conteúdo
LOOP:	MOVX    A, @DPTR        ;carrega A com um byte da RAM externa
        MOV	@R0, A          ;copia A para o endereço da área de rascunho
        INC	R0    
        INC	DPTR           
        CJNE    R0, #60h, LOOP  ;210Fh - 2100h = 0Fh, quebra o loop quando R0=50h+0Fh+1h

;*****************************************************************************************
;agora é copiado da área de rascunho para a região da RAM externa desejada
        MOV	R0, #50h
        MOV	DPTR, #2300h
LOOP2:	MOV	A, @R0
        MOVX    @DPTR, A
        INC	R0
        INC	DPTR
        CJNE    R0, #60h, LOOP2
        END
