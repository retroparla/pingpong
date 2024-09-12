;/------------- REBOTE start
         LXI      H,POSIC
         MOV      A,M
         SUB      E
         JP       LE1
         CMA
         INR      A
LE1:     CPI      10
         JNC      ETIQ1
         ;CALL     MINY
         JMP      ETIQ2
;\------------- REBOTE end
