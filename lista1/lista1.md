# Lista 1

#### SEL433 - Aplicação de Microprocessadores I

**1. ** Para o Microcontrolador da família MCS-51, responder aos itens abaixo de maneira
objetiva:

**1. a)** Como acessar um dado armazenado na posição 1010h da RAM externa e copiar este
dado no Registrador R7 ?

```assembly
MOV DPTR, #1010h ;Carrega o DPTR com endereço desejado
MOVX A, @DPTR    ;Copia o conteúdo contido no endereço em que o DPTR aponta para o acumulador
MOV R7, A        ;Copia o conteúdo do acumulador para R7
```

**1. b) **Quais os pinos da CPU do microcontrolador 8051 são utilizados para a operação do
item anterior, e qual a função de cada um?

**1. c)** Se não for utilizada a memória de programa externa qual deve ser o nível lógico do
pino EA?

**1. d)** Que instrução usar para acessar o endereço 8Bh da RAM interna de dados do
microcontrolador?

```assembly
MOV destino, #8Bh   ;trocar destino pelo endereço desejado da RAM interna
```

---

**2.** Fazer um programa que escreva os números de 1 a 15H na memória interna de dados a
partir do endereço 50H e na memória externa de dados a partir do endereço 2200H. Utilize
modo de endereçamento indireto para escrita nas duas regiões de memória.

```assembly
	    ORG	0
	    CLR	A
	    MOV	R0, #50h            ;endereço inicial de escrita na RAM interna
	    MOV	DPTR, #2200h        ;endereço inicial de escrita na RAM externa
	    
LOOP1:	INC	A                   ;incrementa A
	    MOV	@R0, A              ;copia A para a RAM interna
	    MOVX	@DPTR, A        ;copia A para a RAM externa
	    INC	R0                  ;incrementa o endereço contido em R0
	    INC	DPTR				;incrementa o endereço contido em DPTR
	    CJNE	A, #15h, LOOP1  ;se A chegar a 15 quebra o loop
	    END
```

---

**3.** Fazer um programa que copie os dados da região de memória de dados externa de 2100H
a 210FH para a região de memória de dados externa que inicia em 2300H.

```assembly
		ORG	0	
;*****************************************************************************************
;primeiro é copiado da RAM externa para a área de rascunho
		MOV	R0, #50h       ;utiliza a região a partir de 50h da RAM interna pra rascunho
		MOV	DPTR, #2100h   ;endereço inicial da RAM externa em que será copiado o conteúdo
LOOP:	MOVX	A, @DPTR   ;carrega A com um byte da RAM externa
		MOV	@R0, A         ;copia A para o endereço da área de rascunho
		INC	R0    
		INC	DPTR           
		CJNE	R0, #60h, LOOP ; 210Fh - 2100h = 0Fh, quebra o loop quando R0=50h+0Fh+1h

;*****************************************************************************************
;agora é copiado da área de rascunho para a região da RAM externa desejada
		MOV	R0, #50h
		MOV	DPTR, #2300h
LOOP2:	MOV	A, @R0
		MOVX	@DPTR, A
		INC	R0
		INC	DPTR
		CJNE	R0, #60h, LOOP2
		END
```

---

**4. **Fazer um programa que copie os dados da área de memória de programa que devem
estar armazenados a partir do endereço "TAB:" para a memória interna de dados a partir
do endereço 30H. A seqüência de dados na memória de programa deve ser finalizada
com o código 00. O programa deve contar o número de dados da seqüência, menos o
último valor = 00, e armazenar o resultado no endereço 20h da RAM interna.

```assembly

		ORG	0
		MOV	DPTR, #TAB               ;carrega o DPTR com o endereço inicial dos dados da memória de programa
		MOV	R0, #30h                 ;endereço para os dados na RAM interna
		MOV	R1, #00h                 ;contagem de quantos dados
LOOP:	CLR	A
		MOVC	A, @A+DPTR           ;copia para A o que está na memória de programa no endereço apontado pelo DPTR (na verdade DPTR+A, mas como A=0 no momento então DPTR+A=DPTR)
		MOV	@R0, A                   ;copia o dado para onde R0 aponta
		INC	R1                       ;incrementa a contagem
		INC	DPTR
		INC	R0
		CJNE	A, #00h, LOOP        ;se o dado for 00h, interrompe o loop
		DEC	R1                       ;decrementa R1 pois 00h foi contado
		MOV	20h, R1
FIM:	SJMP	FIM
TAB:	DB	1Ah, 2Ah, 23h, 12h, 00h
```



