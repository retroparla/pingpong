;         TITLE    'JUEGO DE PING-PONG EN 8080!
REBOTE   MACRO    POSIC,ETIQ1,ETIQ2
         LXI      H,POSIC
         MOV      A,M
         SUB      E
         JP       LE1
         CMA
         INR      A
LE1:     CPI      10
         JNC      ETIQ1
         CALL     MINY
         JMP      ETIQ2
         ENDM
         LXI      H,0
         NOP
         SHLD     CONT
         LXI      H,020F8H
         SPHL
         CALL     LP
         JP       LOOP3
         JMP      LOOP4
         ;
         ;-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
         ;
         ; PROGRAMA PRINCIPAL
         ; CONTROLA EL MOVIMIENTO DE LA PELOTA
         ;
         ;
         ;
LA:      CALL     DBOL
         LXI      H,INXY
         MOV      C,M
LA1:     DCR      C
         JZ       LA11
         INR      D
         MOV      A,D
         CPI      75H
         JNZ      LA1
         REBOTE   PXY,LOOP1,LC

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; PAG 1 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

LA11:    INX      H
         MOV      C,M
LA2:     DCR      C
         JZ       LA
         INR      E
         MOV      A,E
         CPI      5EH
         JNZ      LA2
LB:      CALL     DBOL
         LXI      H,INXY
         MOV      C,M
LB1:     DCR      C
         JZ       LB11
         INR      D
         MOV      A,D
         CPI      75H   
         JNZ      LB1
         REBOTE   PXY,LOOP1,LD


LB11:    INX      H
         MOV      C,M
LB2:     DCR      C
         JZ       LB
         DCR      E
         MOV      A,E
         CPI      0A2H  
         JZ       LA
         JMP      LB2
LC:      CALL     DBOL
         LXI      H,INXY
         MOV      C,M
LC1:     DCR      C
         JZ       LC11  
         DCR      D
         MOV      A,D
         CPI      8AH
         JNZ      LC1
         REBOTE   PXY+1,LOOP2,LA

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; PAG 2 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


LC11:    INX      H
         MOV      C,M
LC2:     DCR      C
         JZ       LC 
         INR      E
         MOV      A,E
         CPI      5EH
         JNZ      LC2
LD:      CALL     DBOL
         LXI      H,INXY
         MOV      C,M
LD1:     DCR      C
         JZ       LD11
         DCR      D
         MOV      A,D
         CPI      8AH   
         JNZ      LD1
         REBOTE   PXY+1,LOOP2,LB

LD11:    INX      H
         MOV      C,M
LD2:     DCR      C
         JZ       LD 
         DCR      E
         MOV      A,E
         CPI      0A2H
         JZ       LC
         JMP      LD2
         ;
         ;-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
         ;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; PAG 3 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

         ; SUBRUTINA MINY. PRODUCE EL EFECTO DE
         ; REBOTE NO ESPECULAR EN LA PALETA, SE-
         ; GUN LA PROXIMIDAD DEL REBOTE AL BORDE
         ; DE LA MISMA
         ;
         ;
         ;
MINY:    LXI      H,INXY
         ORA      A
         RAR
         MVI      M,5      
         CPI      4
         JNZ      MINY1 
         INR      M
         INR      M
MINY1:   INX      H
         SBI      5
         CMA
         INR      A
         MOV      M,A
         RET
LOOP1:   LXI      H,CONT
         XRA      A
         MOV      A,M
         INR      A
         DAA
         MOV      M,A
         CPI      21H   
         CNC      COMP
LOOP3:   CALL     LP
         LXI      H,AZD+1
         ANI      7FH
         MOV      D,A
         MOV      E,M
         CALL     STOP
         LXI      H,0505H
         SHLD     INXY
         MOV      A,E
         RAR
         JC       LD
         JMP      LC
LOOP2:   LXI      H,CONT+1
         XRA      A
         MOV      A,M
         INR      A
         DAA
         MOV      M,A
         CPI      21H   
         CNC      COMP
LOOP4:   CALL     LP 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; PAG 4 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

         LXI      H,AZD+1
         ORI      80H
         MOV      D,A
         MOV      E,M
         CALL     STOP
         LXI      H,0505H
         SHLD     INXY
         MOV      A,E
         RAR
         JC       LB
         JMP      LA 
         ;
         ;-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
         ;
         ; COMP EXIGE QUE PARA GANAR LA PARTIDA
         ; HAYA UNA VENTAJA DE POR LO MENOS DOS
         ; PUNTOS EN EL MARACADOR
         ;
         ;
         ;
COMP:    LXI      H,CONT
         MOV      A,M
         MOV      B,A
         INX      H
         MOV      C,M
         CMP      C
         RZ 
         JC       COMP1
         XRA      A
         MOV      A,C
         INR      A
         DAA
         MOV      C,A
         MOV      A,B
         CMP      C
         RZ 
         JMP      FINPA
COMP1:   XRA      A
         MOV      A,B
         INR      A
         DAA
         CMP      C
         RZ 
         JMP      FINPA
         ;
         ;-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
         ;
         ; BUCLE PARA FINAL DE PARTIDA
         ;
         ;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; PAG 5 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

FINPA:   MVI      E,10
FINP1:   CALL     CDIS
         DCR      E
         JNZ      FINP1
         MVI      E,10
FINP2:   CALL     RECT
         DCR      E
         JNZ      FINP2
         JMP      FINPA

         ;
         ;-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
         ; RETARDO ENTRE FIN DE UNA JUGADA Y FINP2
         ; SAQUE DE LA SIGUIENTE
         ;
         ;
         ;
STOP:    PUSH     D
         MVI      E, 050H
STOP1:   CALL     CDIS
         DCR      E
         JNZ      STOP1
         POP      D
         RET
         ;
         ;-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
         ; DBOL EFECTUA LA PRESENTACION EN PANTALLA
         ; DE LA PELOTA
         ;
         ;
         ;
DBOL:    MOV      A,D
         OUT      0
         MOV      A,E
         OUT      1
         DCR      D
         DCR      D
         DCR      E
         DCR      E
         MOV      A,E
         OUT      1
         MOV      A,D
         MVI      B,5
L11:     OUT      0
         INR      A
         DCR      B
         JNZ      L11   
         MOV      C,A
         

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; PAG 6 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

         MOV      A,E
         MVI      B,5  
L12:     OUT      1
         INR      A
         DCR      B
         JNZ      L12   
         MVI      B,5      
         MOV      H,A
         MOV      A,C
L13:     OUT      0
         DCR      A
         DCR      B
         JNZ      L13
         MVI      B,5
         MOV      A,H
L14:     OUT      1  
         DCR      A
         DCR      B
         JNZ      L14
         INR      D
         INR      D
         INR      E
         INR      E
         ;
         ;-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
         ; CDIS LLAMA A LA SUBRUTINA DE PRESEN-
         ; TACION DEL MARCADOR EN LA PANTALLA
         ;
         ;
         ;
CDIS:    CALL     DISM
         ;
         ;-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*         
         ; RECT DIBUJA EL RECTANGULO
         ;
         ;
         ;
RECT:    MVI      A,0A0H
         OUT      1
         MVI      A,80H
L1:      OUT      0
         INR      A
         CPI      7FH
         JNZ      L1
         MVI      A,0A0H   
L2:      OUT      1
         INR      A
         CPI      60H

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; PAG 7 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;      

         JNZ      L2
         MVI      A,7FH
L3:      OUT      0
         DCR      A
         CPI      80H
         JNZ      L3 
         MVI      A,60H 
L4:      OUT      1
         DCR      A
         CPI      0A0H
         JNZ      L4
         CALL     PAL
         RET
         ;
         ;-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
         ; RED EFECTUA EL DIBUJO DE LA RED
         ;
         ;
         ;
RED:     MVI      A,0
         OUT      0
         MVI      A,0A0H
R2:      MVI      B,10
R1:      OUT      1
         INR      A
         CPI      60H
         JZ       FINR  
         DCR      B
         JNZ      R1 
         ADI      10H
         JM       R2
         CPI      60H
         JC       R2
FINR:    RET
         ;
         ;-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
         ; PAL LEE LA POSICION DE LAS PALETAS Y FINR
         ; EFECTUA SU PRESENTACION EN LA PANTALLA
         ;
         ;
         ;
PAL:     IN       0
         LXI      H,PXY
         MOV      M,A
         MVI      A,22H
         OUT      2
         MVI      A,02H
         OUT      2

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; PAG 8 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;                      

         CALL     RED
         IN       0
         INX      H
         MOV      M,A
         MVI      A,21H
         OUT      2
         MVI      A,01H
         OUT      2
         MVI      A,88H
         OUT      0
         MOV      A,M
         SUI      10
         MVI      B,20
L23:     OUT      1
         INR      A
         DCR      B
         JNZ      L23
         MVI      A,77H
         OUT      0
         MVI      B,20
         DCX      H
         MOV      A,M
         SUI      10
L24:     OUT      1
         INR      A
         DCR      B
         JNZ      L24
         RET
         ;
         ;-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
         ; DISM EFECTUA LA PRESENTACION DEL 
         ; MARCADOR EN LA PANTALLA
         ;
         ;
         ;
DISM:    PUSH     D
         LXI      H,CONT
         MVI      D,0E0H
         MVI      E,40H
         MOV      A,M
         ANI      0FH
         CALL     DIS
         LXI      H,CONT
         MVI      D,0D0H
         MVI      E,40H
         MOV      A,M
         RLC
         RLC
         RLC

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; PAG 9 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;    

         RLC
         ANI      0FH
         CALL     DIS
         LXI      H,CONT+1
         MVI      D,20H
         MVI      E,40H
         MOV      A,M
         RLC
         RLC
         RLC
         RLC
         ANI      0FH
         CALL     DIS
         LXI      H,CONT+1
         MVI      D,30H
         MVI      E,40H
         MOV      A,M
         ANI      0FH
         CALL     DIS
         POP      D
         RET
DIS:     RAL
         LXI      H,TAB
         LXI      B,0
         MOV      C,A
         DAD      B
         MOV      A,M
         INX      H
         MOV      H,M
         MOV      L,A
         MOV      A,D
         OUT      0
         MOV      A,E
         OUT      1  
         PCHL
DISA:    MVI      B,9
DISA1:   INR      D
         MOV      A,D
         OUT      0
         DCR      B
         JNZ      DISA1 
         RET
DISB:    MVI      B,9
DISB1:   DCR      D
         MOV      A,D
         OUT      0
         DCR      B
         JNZ      DISB1 
         RET
DISC:    MVI      B,7

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; PAG 10 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;   

DISC1:   INR      E
         MOV      A,E
         OUT      1
         DCR      B
         JNZ      DISC1
         RET
DISD:    MVI      B,7
DISD1:   DCR      E
         MOV      A,E
         OUT      1
         DCR      B
         JNZ      DISD1
         RET
DOWN:    MOV      A,E
         SBI      7
         MOV      E,A
         OUT      1
         RET
DIS0:    CALL     DISC
         CALL     DISC  
         CALL     DISB
         CALL     DISD
         CALL     DISD
         CALL     DISA
         JMP      FIN 
DIS1:    CALL     DISC  
         CALL     DISC
         JMP      FIN  
DIS2:    CALL     DISB
         CALL     DISC
         CALL     DISA
         CALL     DISC
         CALL     DISB
         JMP      FIN
DIS3:    CALL     DISC
         CALL     DISC
         CALL     DISB
         CALL     DOWN
         CALL     DISA
         CALL     DOWN
         CALL     DISB
         JMP      FIN
DIS4:    CALL     DISC
         CALL     DISC
         CALL     DOWN
         CALL     DISB
         CALL     DISC
         JMP      FIN
DIS5:    CALL     DISC
         CALL     DISB

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; PAG 11 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;            

         CALL     DISC
         CALL     DISA
         CALL     DOWN
         CALL     DOWN
         CALL     DISB
         JMP      FIN
DIS6:    CALL     DISC
         CALL     DISB
         CALL     DISC
         CALL     DOWN  
         CALL     DISD
         CALL     DISA
         JMP      FIN
DIS7:    CALL     DISC
         CALL     DISC
         CALL     DISB
         JMP      FIN
DIS8:    CALL     DISC
         CALL     DISB
         CALL     DISC
         CALL     DISA
         CALL     DISD
         CALL     DOWN
         CALL     DISB
         CALL     DISC
         JMP      FIN
DIS9:    CALL     DISC
         CALL     DISC
         CALL     DISB
         CALL     DISD
         CALL     DISA
         JMP      FIN
TAB:     DW       DIS0
         DW       DIS1
         DW       DIS2
         DW       DIS3
         DW       DIS4
         DW       DIS5
         DW       DIS6
         DW       DIS7
         DW       DIS8
         DW       DIS9
FIN:     RET
         ;
         ;-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
         ; LP OBTIENE UN PAR DE NUMEROS
         ; SEUDOALEATORIOS
         ;
         ;
         ;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; PAG 12 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;            

LP:      LXI      H,AZD
         CALL     ALE
         MOV      M,A
         LXI      H,AZE
         CALL     ALE
         MOV      M,A
         RET
ALE:     MVI      C,0
         MOV      A,M
         CPI      0
         JNZ      SK
         MVI      A,0FFH
SK:      MOV      B,A
         ANI      1DH
         JPE      PAR   
         MVI      C,80H
PAR:     MOV      A,B
         RRC
         ANI      7FH
         ADD      C
         MOV      B,A
         RAL
         MOV      A,B
         JNC      POS   
         ORI      0C0H
         RET
POS:     ANI      3FH
         RET

         ORG      020F8H
INXY:    DS       2
CONT:    DS       2
PXY:     DS       2
AZD:     DS       1
AZE:     DS       1
         END