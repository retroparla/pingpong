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

         JMP RED
