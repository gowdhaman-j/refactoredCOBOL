000100 IDENTIFICATION DIVISION.                                                 
000200 PROGRAM-ID.  BMPCOBOL.                                                   
000300 AUTHOR. R THORNTON.                                                      
000400 REMARKS. THIS PROGRAM PROVIDES ACCESS TO THE IMS MESSAGE QUEUE T         
000500          WRITE MESSAGES DIRECTLY TO TERMINALS. THE PSB USED IS           
000600          DXT0500P, WHICH HAS AN IOPCB AND A MODIFIABLE ALTERNATE         
000700          PCB SPECIFIED.                                                  
000800 ENVIRONMENT DIVISION.                                                    
000900 INPUT-OUTPUT SECTION.                                                    
001000 FILE-CONTROL.                                                            
001100     SELECT MESSAGE-FILE ASSIGN TO UT-S-READER1.                          
001200 DATA DIVISION.                                                           
001300 FILE SECTION.                                                            
001400 FD  MESSAGE-FILE                                                         
001500     BLOCK CONTAINS 0 RECORDS                                             
001600     RECORD CONTAINS 80 CHARACTERS                                        
001700     LABEL RECORDS ARE OMITTED                                            
001800     DATA RECORD IS MESSAGE-RECORD.                                       
001900 01  MESSAGE-RECORD.                                                      
002000     05  MESSAGE-TEXT           PIC X(80).                                
002100 WORKING-STORAGE SECTION.                                                 
002200 77  FILLER                      PIC X(36)  VALUE                         
002300     'BMPCOBOL WORKING STORAGE BEGINS HERE'.                              
002400 01  MISCELLANEOUS-STORAGE-AREAS.                                         
002500     05  HM00A5                  PIC X(08) VALUE 'HM00A5'.                
002600     05  EOF-SWITCH              PIC X VALUE ' '.                         
002700         88 END-OF-INPUT         VALUE 'E'.                               
002800 01  TERMINAL-MESSAGE-AREA.                                               
002900     05  MESSAGE-LENG            PIC S9(4) COMP VALUE +4.                 
003000     05  FILLER                  PIC S9(4) COMP VALUE ZEROS.              
003100     05  MESSAGE-LINE            OCCURS 10 TIMES                          
003200                                 INDEXED BY MSG-LINE-NBR                  
003300                                 PIC X(80).                               
003400 01  IMS-COMMANDS                COPY IMSSFUN0.                           
003500 01  IMS-STATUS-CODES            COPY IMSSSTA0.                           
003600 LINKAGE SECTION.                                                         
003700 01  IOPCB                   COPY IOPCB.                                  
003800 01  ALTPCB                  COPY ALTPCB.                                 
003900 PROCEDURE DIVISION USING IOPCB, ALTPCB.                                  
004000     PERFORM A100-INITIALIZE.                                             
004100     PERFORM B100-MAIN-PROCESS UNTIL END-OF-INPUT.                        
004200     PERFORM Z900-TERMINATE.                                              
004300     GOBACK.                                                              
004400 A100-INITIALIZE.                                                         
004500     OPEN INPUT MESSAGE-FILE.                                             
004600 B100-MAIN-PROCESS.                                                       
004700     PERFORM C100-READ-CARDS                                              
004800         VARYING MSG-LINE-NBR FROM 1 BY 1                                 
004900             UNTIL MSG-LINE-NBR IS GREATER THAN 10                        
005000             OR END-OF-INPUT.                                             
005100        PERFORM D100-INSERT-TO-TERMINAL.                                  
005200 C100-READ-CARDS.                                                         
005300     READ MESSAGE-FILE                                                    
005400         AT END MOVE 'E' TO EOF-SWITCH.                                   
005500     IF NOT END-OF-INPUT                                                  
005600         MOVE MESSAGE-TEXT TO MESSAGE-LINE (MSG-LINE-NBR)                 
005700         ADD 80 TO MESSAGE-LENG.                                          
005800 D100-INSERT-TO-TERMINAL.                                                 
005900     CALL 'CBLTDLI' USING CHNG-FUNCTION-CODE,                             
006000                          ALTPCB,                                         
006100                          HM00A5.                                         
006200     CALL 'CBLTDLI' USING ISRT-FUNCTION-CODE,                             
006300                          ALTPCB,                                         
006400                          TERMINAL-MESSAGE-AREA.                          
006500     CALL 'CBLTDLI' USING PURG-FUNCTION-CODE,                             
006600                          ALTPCB.                                         
006700 Z900-TERMINATE.                                                          
006800     CLOSE MESSAGE-FILE.                                                  
