         ; OJO, PONER LA PILA QUE LA VAMOS A USAR
         LXI      H, 020F8H
         SPHL     


RED:     MVI      A,128
         OUT      0
         MVI      A,32   ; 160
R2:      MVI      B,10
R1:      OUT      1
         INR      A
         CPI      224      ; 96
         JZ       FINR  
         DCR      B
         JNZ      R1 
         ADI      10H      ; 16
      ;   JM       R2
         CPI      224      ; 96
         JC       R2
FINR:    

RECT:    MVI      A,32   ; 160
         OUT      1
         MVI      A,0    ;128
L1:      OUT      0
         INR      A
         CPI      255      ; 127
         JNZ      L1
         MVI      A,32   ;160
L2:      OUT      1
         INR      A
         CPI      224      ; 96
         JNZ      L2
         MVI      A,255    ; 127
L3:      OUT      0
         DCR      A
         CPI      0      ; 128
         JNZ      L3 
         MVI      A,224    ; 96
L4:      OUT      1
         DCR      A
         CPI      32     ; 160
         JNZ      L4

         MVI      D, 200
         MVI      E, 120
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
         
         ; PALETAS

         MVI      A, 32
         OUT      1

PAL:     MVI      A,8
         OUT      0

         ;MOV      A,M
         MVI      A, 100

         SUI      10
         MVI      B,20
L23:     OUT      1
         INR      A
         DCR      B
         JNZ      L23

         MVI      A, 32
         OUT      1
         MVI      A,247
         OUT      0

         MVI      B,20
         DCX      H

         ;MOV      A,M
         MVI      A, 150

         SUI      10
L24:     OUT      1
         INR      A
         DCR      B
         JNZ      L24


         ;-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
         ; DISM EFECTUA LA PRESENTACION DEL 
         ; MARCADOR EN LA PANTALLA
         ;
         ;
         ;

         ; MARCADOR INICIAL
         ; LXI H, CONT
         ; MVI A, 88H
         ; MOV M, A
         ; LXI H, CONT+1
         ; MVI A, 88H
         ; MOV M,A
         



DISM:    
         LXI      H,CONT
         MVI      D,96
         MVI      E,192
         MOV      A,M

         MVI      A,8

         ANI      0FH

         CALL     DIS8         ; PRIMER DIGITO, JUGADOR 1

         ; LXI      H,CONT
         ; MVI      D,0D0H
         ; MVI      E,40H
         ; MOV      A,M
         ; RLC
         ; RLC
         ; RLC
         ; RLC
         ; ANI      0FH
         ; CALL     DIS         ; SEGUNDO DIGITO, JUGADOR 1

         ; LXI      H,CONT+1
         ; MVI      D,20H
         ; MVI      E,40H
         ; MOV      A,M
         ; RLC
         ; RLC
         ; RLC
         ; RLC
         ; ANI      0FH
         ; CALL     DIS         ; PRIMER DIGITO, JUGADOR 2

         ; LXI      H,CONT+1
         ; MVI      D,30H
         ; MVI      E,40H
         ; MOV      A,M
         ; ANI      0FH
         ; CALL     DIS         ; SEGUNDO DIGITO, JUGADOR 2

         JMP      RED


         ; PINTA UN DIGITO EN (D,E)

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
DIS1:    RET
         CALL     DISC  
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
         JMP RED


         ORG      020F8H
INXY: DS 2
CONT: DS 2
