# Lista 1

#### SEL433 - Aplicação de Microprocessadores I

**1.** Para o Microcontrolador da família MCS-51, responder aos itens abaixo de maneira
objetiva:

**1. a)** Como acessar um dado armazenado na posição 1010h da RAM externa e copiar este
dado no Registrador R7 ?

```assembly
MOV DPTR, #1010h ;Carrega o DPTR com endereço desejado
MOVX A, @DPTR    ;Copia o conteúdo contido no endereço em que 
                 ;o DPTR aponta para o acumulador
MOV R7, A        ;Copia o conteúdo do acumulador para R7
```

**1. b)** Quais os pinos da CPU do microcontrolador 8051 são utilizados para a operação do
item anterior, e qual a função de cada um?

**1. c)** Se não for utilizada a memória de programa externa qual deve ser o nível lógico do
pino EA?

**1. d)** Que instrução usar para acessar o endereço 8Bh da RAM interna de dados do
microcontrolador?

```assembly
MOV destino, #8Bh   ;trocar destino pelo endereço desejado da RAM interna
```

---

**2.** Fazer um programa que escreva os números de 1 a 15H na memória interna de dados a partir do endereço 50H e na memória externa de dados a partir do endereço 2200H. Utilize modo de endereçamento indireto para escrita nas duas regiões de memória.

```assembly
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
```

---

**3.** Fazer um programa que copie os dados da região de memória de dados externa de 2100H a 210FH para a região de memória de dados externa que inicia em 2300H.

```assembly
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
```

---

**4.** Fazer um programa que copie os dados da área de memória de programa que devem estar armazenados a partir do endereço "TAB:" para a memória interna de dados a partir do endereço 30H. A seqüência de dados na memória de programa deve ser finalizada com o código 00. O programa deve contar o número de dados da seqüência, menos o último valor = 00, e armazenar o resultado no endereço 20h da RAM interna.

```assembly
        ORG	0
        MOV	DPTR, #TAB           ;carrega o DPTR com o endereço inicial dos dados da
                                     ;memória de programa
                                     
        MOV	R0, #30h             ;endereço para os dados na RAM interna
        MOV	R1, #00h             ;contagem de quantos dados
LOOP:	CLR	A
        MOVC    A, @A+DPTR           ;copia para A o que está na memória de programa no 
                                     ;endereço apontado pelo DPTR (na verdade DPTR+A, mas
                                     ;como A=0 no momento então DPTR+A=DPTR)
                                     
        MOV	@R0, A               ;copia o dado para onde R0 aponta
        INC	R1                   ;incrementa a contagem
        INC	DPTR
        INC	R0
        CJNE    A, #00h, LOOP        ;se o dado for 00h, interrompe o loop
        DEC	R1                   ;decrementa R1 pois 00h foi contado
        MOV	20h, R1
FIM:	SJMP    FIM
TAB:	DB      1Ah, 2Ah, 23h, 12h, 00h ;dados aleatórios para testar
```
---

**5.** Escrever um programa que copie dados armazenados na RAM externa, com início na posição 8200H para a posição 8300H. A seqüência de dados deve ser finalizada com ocódigo 00. O programa deve contar o número de dados da seqüência, menos o último
valor = 00, e armazenar o resultado no endereço 40h da RAM interna.

```assembly
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
```
---
**6.** Escrever um programa que faça a soma de dois números de 24 bits (3 bytes) cada um. O primeiro número está armazenado nas posições (R0+2)=MSB, (R0+1), (R0)=LSB da RAM externa. O segundo número está nas posições (R1+2)=MSB, (R1+1), (R1)=LSB. O resultado deve ser colocado nas posições 42h=MSB, 41h e 40h=LSB da RAM interna.

```assembly
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
```
---
**7.** Fazer um programa que armazene em ordem crescente, na RAM externa a partir do
endereço 1000h, os elementos de uma tabela de bytes armazenada na Memória de
Programa e terminada com o byte 00 (zero).

```assembly
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
```
---
**8.** Fazer um programa que retorne no registrador R6 o número de bits “UM” do registrador R4.
```assembly
	ORG	0
	CLR     C
	MOV	R4, #0AAh
	MOV	R6, #00h
	
LOOP:	MOV	A, R4
	RLC	A
	MOV	R4, A
	CLR	A
	ADDC	A, R6
	MOV	R6, A
	CJNE    R4, #00h, LOOP
	END
```
---
**9.** Usando instruções que endereçam bits no 8051, escrever um programa em Assembly que mova os bits do endereço de byte 20h para o endereço de byte 2Fh na ordem inversa, ou seja, o LSB do endereço 20h vai para o MSB do endereço 2Fh e assim sucessivamente até o MSB do endereço 20h ser movido para o LSB do endereço 2Fh.
```assembly
	ORG	0
	MOV	R0, #00h
	MOV	20h, #0Ah
	MOV	A, 20h
LOOP:	RLC	A
	MOV	B, A
	MOV	A, 2Fh
	RRC	A
	MOV	2Fh, A
	MOV     A, B
	INC	R0
	CJNE	R0, #08h, LOOP
	END	0
```
---
**10.** Fazer um contador hexadecimal que coloque o valor de contagem na porta P1 em intervalos de 640 ciclos de máquina. Utilize o Timer 1.
```assembly

	ORG	0
	MOV P0, #00h
	SJMP	Prog
	ORG	001Bh
Sub1:	CLR	EA
	INC	P0
	SETB	EA
	MOV	TH1, #0FDh
	MOV	TL1, #090h
	RETI

PROG:	SETB	ET1		;habilita interrupcao de T1
	MOV	TMOD, #10h
	MOV	TH1, #0FDh
	MOV	TL1, #090h
	SETB	EA
	SETB	TR1
LOOP:	SJMP	LOOP
	END
```
---
**11.** Fazer um programa que gere uma onda quadrada na porta P1.7 com período de 2.56ms, considerando que o oscilador do microcontrolador é alimentado por um cristal de 12MHz. Utilize Timer 0 no Modo 0.
```assembly
	ORG	0
	MOV P0, #00h
	SJMP	Prog
	ORG	000Bh
Sub1:	CLR	EA
	CPL     P1.7
	SETB	EA
	MOV	TH0, #0D7h
	RETI

PROG:	SETB	ET0		;habilita interrupcao de T1
	MOV	TH0, #0D7h
	MOV	TL0, #00h
	MOV	TMOD, #00h
	SETB	EA
	SETB	TR0
LOOP:	SJMP	LOOP
	END
```
---
**12.** Fazer um programa que utilize um timer interno do 8051 para criar um tempo de atraso de 0.05 segundos. Utilizando este programa como uma sub-rotina, escrever um programa que atrase 5 segundos.
```assembly
	ORG	0
	MOV	R0, #00h
LOOP:	CALL	ATRASO
	INC	R0
	CJNE	R0, #64h, LOOP
	SJMP	FINAL
;***************************************
ATRASO:	MOV	TH0, #03Ch
	MOV	TL0, #0AFh
	MOV	TMOD, #01h
	SETB	TR0
WAIT:	JBC	TF0, RETURN
	SJMP	WAIT
RETURN:	RET
;***************************************
FINAL:	END
```
---
**13.** Um sistema baseado no 8051 utiliza as duas interrupções externas disponíveis e ainda a interrupção gerada por 1 dos Temporizadores/Contadores. As condições em que se pretende que o sistema funcione são as seguintes:
- a interrupção externa 0 deve ser sempre atendida imediatamente e deve copiar o que está na posição de RAM externa 4000H para a posição 4200H;
- a interrupção externa 1 deve escrever o que está em 4200H na porta P1;
- a interrupção gerada pelo timer deve executar uma rotina que copie o que está na porta P2 para a posição 4000H da RAM externa;
No caso de duas interrupções acontecerem simultaneamente, deve ser atendida a
interrupção externa.
```assembly
        ORG 0
        SJMP prog
        
	ORG	0003h
	SJMP ext0
	
	ORG	0013h
	SJMP ext1
	
	ORG	001Bh
	SJMP tm_1
	
tm_1:	MOV	A, P2
	MOV	DPTR, #4000h
	MOVX	@DPTR, A
	RETI

	
ext1:	MOV	DPTR, #4200h
	MOVX	A, @DPTR
	MOV	P1, A
	RETI

	
ext0:	MOV	DPTR, #4000h
	MOVX	A, @DPTR
	MOV	DPTR, #4200h
	MOVX	@DPTR, A
	RETI

prog:	MOV  IP, #0000101b
	SETB EX0
	SETB EX1
	SETB ET1
	SETB EA
	END
```
---
**14.** Um robô como mostrado na figura é acionado por dois motores de corrente contínua, um para cada roda, conforme o esquema, e possui um sensor localizado na parte da frente que tem a função de detectar a presença de obstáculos. Desenvolver um programa em Assembly do 8051 que controle o robô fazendo-o navegar por uma sala onde diversos obstáculos podem ser encontrados, de tal forma que ele não colida com nenhum. O circuito do sensor está ligado na entrada de interrupção Int0 que gera um pulso negativo quando um obstáculo é detectado.Os motores são acionados da seguinte maneira, conforme mostra o esquema eletrônico:
- P1.0 = 1 -> liga a alimentação do motor da roda da esquerda (P1.0 = 0 -> desliga)
- P1.2 = 1 -> liga a alimentação do motor da roda da direita (P1.2 = 0 -> desliga)  
O programa deve:  
a) Inicialmente movimentar o robô à frente.  
b) Quando o primeiro obstáculo for detectado o robô deve voltar atrás por 2 segundos e virar à direita por 2 segundos. A freqüência do oscilador do microcontrolador é de 12 MHz.  
c) A cada obstáculo detectado o robô deve movimentar-se para trás por 2 segundos e inverter a última direção durante 2 segundos (direita, 2s, esquerda, 2s, direita, 2s, esquerda, 2s,.........).  
d) Após cada inversão de direção, o robô deve ser movimentado para frente até que novo obstáculo seja encontrado. Durante o movimento para trás e direita/esquerda a Int0 deve ser desabilitada.
```assembly
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
```
