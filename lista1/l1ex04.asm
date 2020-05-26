        ORG     0
        MOV     DPTR, #TAB           ;carrega o DPTR com o endereço inicial dos dados da
                                     ;memória de programa
                                     
        MOV     R0, #30h             ;endereço para os dados na RAM interna
        MOV     R1, #00h             ;contagem de quantos dados
LOOP:   CLR     A
        MOVC    A, @A+DPTR           ;copia para A o que está na memória de programa no 
                                     ;endereço apontado pelo DPTR (na verdade DPTR+A, mas
                                     ;como A=0 no momento então DPTR+A=DPTR)
                                     
        MOV     @R0, A               ;copia o dado para onde R0 aponta
        INC     R1                   ;incrementa a contagem
        INC     DPTR
        INC     R0
        CJNE    A, #00h, LOOP        ;se o dado for 00h, interrompe o loop
        DEC     R1                   ;decrementa R1 pois 00h foi contado
        MOV     20h, R1
FIM:    SJMP    FIM
TAB:    DB      1Ah, 2Ah, 23h, 12h, 00h ;dados aleatórios para testar
