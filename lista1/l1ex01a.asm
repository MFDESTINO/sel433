MOV DPTR, #1010h ;Carrega o DPTR com endereço desejado
MOVX A, @DPTR    ;Copia o conteúdo contido no endereço em que 
                 ;o DPTR aponta para o acumulador
MOV R7, A        ;Copia o conteúdo do acumulador para R7
