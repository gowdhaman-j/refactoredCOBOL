000100 IDENTIFICATION DIVISION.                                               00
000200 PROGRAM-ID.    ADDVERB.                                                00
000300 AUTHOR. R THORNTON.                                                    00
000400*REMARKS. SHOWS EXAMPLES OF VARIOUS COBOL VERBS.                        00
000500 ENVIRONMENT DIVISION.                                                  00
000600 CONFIGURATION SECTION.                                                 00
000700 INPUT-OUTPUT SECTION.                                                  00
000800 FILE-CONTROL.                                                          00
000900     SELECT INPUT-FILE ASSIGN TO UT-S-INPUT1.                           00
001000     SELECT OUTPUT-FILE ASSIGN TO UT-S-OUTPUT1.                         00
001100 DATA DIVISION.                                                         00
001200 FILE SECTION.                                                          00
001300                                                                        00
001400 FD INPUT-FILE                                                          00
001500     RECORD CONTAINS 80 CHARACTERS                                      00
001600     RECORDING MODE IS F                                                00
001700     BLOCK CONTAINS 0 RECORDS                                           00
001800     LABEL RECORD IS STANDARD                                           00
001900     DATA RECORD IS INPUT-RECORD.                                       00
002000                                                                        00
002100 01  INPUT-RECORD.                                                      00
002200     05  FILLER              PIC X(80).                                 00
002300                                                                        00
002400 FD OUTPUT-FILE                                                         00
002500     RECORD CONTAINS 80 CHARACTERS                                      00
002600     RECORDING MODE IS F                                                00
002700     BLOCK CONTAINS 0 RECORDS                                           00
002800     LABEL RECORD IS STANDARD                                           00
002900     DATA RECORD IS INPUT-RECORD.                                       00
003000                                                                        00
003100 01  OUTPUT-RECORD.                                                     00
003200     05  FILLER              PIC X(80).                                 00
003300                                                                        00
003400 WORKING-STORAGE SECTION.                                               00
003500 77  FILLER PIC X(36)  VALUE                                            00
003600     'VERBCHEK WORKING STORAGE BEGINS HERE'.                            00
003700                                                                        00
003800 01  MISCELLANEOUS-AREAS.                                               00
003900     05 EOF-SWITCH               PIC X VALUE 'N'.                       00
004000        88 END-OF-INPUT          VALUE 'Y'.                             00
004100        88 MORE-INPUT            VALUE 'N'.                             00
004200     05 TEXT-STRING              PIC XXX VALUE 'YES'.                     
004300     05 ACCEPTED-DATE            PIC 9(6).                                
004400     05 BINARY-HALFWORD          PIC S99V99 BINARY.                       
004500     05 BINARY-FULLWORD          PIC S9(5)V99 BINARY.                     
004600     05 BINARY-DOUBLEWORD        PIC S9(7)V99 BINARY.                     
004700     05 ZONED-NUMBER             PIC S9(6)V9.                             
004800     05 PACKED-NUMBER            PIC S9(6)V999 COMP-3.                    
004900     05 ANSWER                   PIC S9(9)V999 COMP-3.                    
005000     05 FLOATING-POINT-SHORT     COMP-1.                                  
005100     05 FLOATING-POINT-LONG      COMP-2.                                  
005200     05 INDEX-CELL               INDEX.                                   
005300                                                                        00
005400 LINKAGE SECTION.                                                         
005500 01  BIN-NUM                     PIC S9(8) COMP.                          
005600 01  PACK-NUM                    PIC S9(5)V99 COMP-3.                     
005700 01  ZON-NUM                     PIC S99V9(5).                            
005800 01  ANS-NUM                     COMP-2.                                  
005900                                                                        00
006000 PROCEDURE DIVISION.                                                    00
006100     ACCEPT TEXT-STRING.                                                00
006200     ACCEPT ACCEPTED-DATE FROM DATE.                                    00
006300     COMPUTE ANSWER =                                                   00
006400             BINARY-HALFWORD * (ZONED-NUMBER + PACKED-NUMBER).            
006500     COMPUTE ANSWER =                                                   00
006600             (ZONED-NUMBER ** 1.2) / (5 * PACKED-NUMBER).                 
006700     DIVIDE 2.35 INTO PACKED-NUMBER GIVING BINARY-FULLWORD                
006800          ROUNDED ON SIZE ERROR DISPLAY 'ERROR'.                          
006900     DIVIDE BINARY-HALFWORD INTO BINARY-DOUBLEWORD.                       
007000     DIVIDE PACKED-NUMBER INTO BINARY-FULLWORD GIVING ZONED-NUMBER.       
007010     MULTIPLY BINARY-HALFWORD BY PACKED-NUMBER.                           
007020     MULTIPLY ZONED-NUMBER BY 2 GIVING ANSWER ROUNDED.                    
007100     ENTRY 'ADDSUBR' USING BIN-NUM,                                       
007110                                  PACK-NUM, ZON-NUM, ANS-NUM.             
007200     ADD BINARY-HALFWORD TO BINARY-HALFWORD ROUNDED.                      
007300     ADD BINARY-HALFWORD TO BINARY-FULLWORD ROUNDED.                      
007400     ADD BINARY-HALFWORD TO BINARY-DOUBLEWORD ROUNDED.                    
007500     ADD BINARY-HALFWORD TO ZONED-NUMBER ROUNDED.                         
007600     ADD BINARY-HALFWORD TO PACKED-NUMBER ROUNDED.                        
007700     ADD BINARY-HALFWORD TO FLOATING-POINT-SHORT ROUNDED.                 
007800     ADD BINARY-HALFWORD TO FLOATING-POINT-LONG ROUNDED.                  
007900     ADD BINARY-FULLWORD TO BINARY-HALFWORD ROUNDED.                      
008000     ADD BINARY-FULLWORD TO BINARY-FULLWORD ROUNDED.                      
008100     ADD BINARY-FULLWORD TO BINARY-DOUBLEWORD ROUNDED.                    
008200     ADD BINARY-FULLWORD TO ZONED-NUMBER ROUNDED.                         
008300     ADD BINARY-FULLWORD TO PACKED-NUMBER ROUNDED.                        
008400     ADD BINARY-FULLWORD TO FLOATING-POINT-SHORT ROUNDED.                 
008500     ADD BINARY-FULLWORD TO FLOATING-POINT-LONG ROUNDED.                  
008600     ADD BINARY-DOUBLEWORD TO BINARY-HALFWORD ROUNDED.                    
008700     ADD BINARY-DOUBLEWORD TO BINARY-FULLWORD ROUNDED.                    
008800     ADD BINARY-DOUBLEWORD TO BINARY-DOUBLEWORD ROUNDED.                  
008900     ADD BINARY-DOUBLEWORD TO ZONED-NUMBER ROUNDED.                       
009000     ADD BINARY-DOUBLEWORD TO PACKED-NUMBER ROUNDED.                      
009100     ADD BINARY-DOUBLEWORD TO FLOATING-POINT-SHORT ROUNDED.               
009200     ADD BINARY-DOUBLEWORD TO FLOATING-POINT-LONG ROUNDED.                
009300     ADD ZONED-NUMBER TO BINARY-HALFWORD ROUNDED.                         
009400     ADD ZONED-NUMBER TO BINARY-FULLWORD ROUNDED.                         
009500     ADD ZONED-NUMBER TO BINARY-DOUBLEWORD ROUNDED.                       
009600     ADD ZONED-NUMBER TO ZONED-NUMBER ROUNDED.                            
009700     ADD ZONED-NUMBER TO PACKED-NUMBER ROUNDED.                           
009800     ADD ZONED-NUMBER TO FLOATING-POINT-SHORT ROUNDED.                    
009900     ADD ZONED-NUMBER TO FLOATING-POINT-LONG ROUNDED.                     
010000     ADD PACKED-NUMBER TO BINARY-HALFWORD ROUNDED.                        
010100     ADD PACKED-NUMBER TO BINARY-FULLWORD ROUNDED.                        
010200     ADD PACKED-NUMBER TO BINARY-DOUBLEWORD ROUNDED.                      
010300     ADD PACKED-NUMBER TO ZONED-NUMBER ROUNDED.                           
010400     ADD PACKED-NUMBER TO PACKED-NUMBER ROUNDED.                          
010500     ADD PACKED-NUMBER TO FLOATING-POINT-SHORT ROUNDED.                   
010600     ADD PACKED-NUMBER TO FLOATING-POINT-LONG ROUNDED.                    
010700     ADD FLOATING-POINT-SHORT TO BINARY-HALFWORD ROUNDED.                 
010800     ADD FLOATING-POINT-SHORT TO BINARY-FULLWORD ROUNDED.                 
010900     ADD FLOATING-POINT-SHORT TO BINARY-DOUBLEWORD ROUNDED.               
011000     ADD FLOATING-POINT-SHORT TO ZONED-NUMBER ROUNDED.                    
011100     ADD FLOATING-POINT-SHORT TO PACKED-NUMBER ROUNDED.                   
011200     ADD FLOATING-POINT-SHORT TO FLOATING-POINT-SHORT ROUNDED.            
011300     ADD FLOATING-POINT-SHORT TO FLOATING-POINT-LONG ROUNDED.             
011400     ADD FLOATING-POINT-LONG TO BINARY-HALFWORD ROUNDED.                  
011500     ADD FLOATING-POINT-LONG TO BINARY-FULLWORD ROUNDED.                  
011600     ADD FLOATING-POINT-LONG TO BINARY-DOUBLEWORD ROUNDED.                
011700     ADD FLOATING-POINT-LONG TO ZONED-NUMBER ROUNDED.                     
011800     ADD FLOATING-POINT-LONG TO PACKED-NUMBER ROUNDED.                    
011900     ADD FLOATING-POINT-LONG TO FLOATING-POINT-SHORT ROUNDED.             
012000     ADD FLOATING-POINT-LONG TO FLOATING-POINT-LONG ROUNDED.              
012100     STOP RUN.                                                            
