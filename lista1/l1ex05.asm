        ORG        0
        MOV        R0, #50h        ;início da área de rascunho na RAM interna
        MOV        R1, #00h        ;registrador para a contagem
        MOV        DPTR, #8200h    ;endereço inicial para cópia
LOOP:   MOVX       A, @DPTR
        MOV        @R0, A          ;copia para a área de rascunho
        INC        R0
        INC        DPTR
        INC        R1              ;incrementa a contagem
        CJNE       A, #00h, LOOP   ;se o dado for zero, interrompe o loop
        
        MOV        R0, #50h
        MOV        DPTR, #8300h    ;endereço de destino da cópia
LOOP2:  MOV        A, @R0
        MOVX       @DPTR, A
        INC        R0
        INC        DPTR
        CJNE       A, #00h, LOOP2  ;se o dado for zero, interrompe o loop
        DEC        R1              ;decrementa a contagem pois contou o dado 00h
        MOV        40h, R1
        END
