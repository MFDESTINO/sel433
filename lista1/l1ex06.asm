ORG     0
CLR     C
MOV     R0, #10h   ;endereço de teste
MOV     R1, #20h   ;endereço de teste
MOVX    A, @R0     ;carrega A com o dado para onde R0 aponta da RAM externa
MOV     R2, A      ;deixa o dado em R2 provisoriamente
MOVX    A, @R1     ;carrega A com o dado para onde R1 aponta da RAM externa
ADD     A, R2      ;soma os dados de R0 e R1
MOV     40h, A     ;copia o resultado para 40h

INC     R0         ;faz o endereço de R0 ser R0+1
INC     R1         ;faz o endereço de R1 ser R1+1
MOVX    A, @R0
MOV     R2, A
MOVX    A, @R1
ADDC    A, R2      ;a soma agora considera o resultado do carry da soma anterior
MOV     41h, A

INC     R0         ;faz o endereço de R0 ser R0+2
INC     R1         ;faz o endereço de R1 ser R1+2
MOVX    A, @R0  
MOV     R2, A
MOVX    A, @R1
ADDC    A, R2
MOV     42h, A
END
