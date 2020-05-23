        ORG	0
        CLR	A
        MOV	R0, #50h            ;endereço inicial de escrita na RAM interna
        MOV	DPTR, #2200h        ;endereço inicial de escrita na RAM externa
	    
LOOP1:	INC	A                   ;incrementa A
        MOV	@R0, A              ;copia A para a RAM interna
        MOVX    @DPTR, A            ;copia A para a RAM externa
        INC	R0                  ;incrementa o endereço contido em R0
        INC	DPTR                ;incrementa o endereço contido em DPTR
        CJNE    A, #15h, LOOP1      ;se A chegar a 15 quebra o loop
        END
