        ORG        0
        MOV        R0, #30h
        MOV        DPTR, #TAB
        
LOOP1:  CLR        A
        MOVC       A, @A+DPTR
        MOV        @R0, A
        INC        DPTR
        INC        R0
        CJNE       A, #00h, LOOP1
        
        MOV        R0, #30h
        MOV        DPTR, #1000h
        
LOOP2:  MOV        A, @R0
        MOVX       @DPTR, A
        INC        R0
        INC        DPTR
        CJNE       A, #00h, LOOP2
        
FIM:    SJMP       FIM
TAB:    DB         1Ah, 2Ah, 23h, 12h, 00h
