000100 IDENTIFICATION DIVISION.                                                 
000200 PROGRAM-ID.    SRTSVC99.                                                 
000300 AUTHOR.        R THORNTON                                                
000400 DATE-WRITTEN.  DEC 2000.                                                 
000500     DATE-COMPILED.                                                       
000700*****************************************************************         
000800* THIS PROGRAM IS A SAMPLE COBOL INTERNAL SORT WITH THE INPUT   *         
000900* FILE DYNAMICALLY ALLOCATED TO NULLFILE.                       *         
001000*****************************************************************         
001100 ENVIRONMENT DIVISION.                                                    
001200 CONFIGURATION SECTION.                                                   
001300 INPUT-OUTPUT SECTION.                                                    
001400 FILE-CONTROL.                                                            
001500     SELECT SORT-FILE          ASSIGN   TO  SORTWK01.                     
001600     SELECT INPUT-FILE         ASSIGN   TO  INPUT1.                       
001700     SELECT SORTED-FILE        ASSIGN   TO  OUTPUT1.                      
001800 DATA DIVISION.                                                           
001900 FILE SECTION.                                                            
002000 SD  SORT-FILE                                                            
002100     DATA RECORD IS SORT-RECORD.                                          
002200 01  SORT-RECORD.                                                         
002300     05  SD-MEMBER-NAME           PIC X(8).                               
002400     05  SD-REST                  PIC X(72).                              
002500 FD  INPUT-FILE                                                           
002600     DATA RECORD IS INPUT-RECORD                                          
002700     RECORD CONTAINS 80 CHARACTERS                                        
002800     BLOCK CONTAINS 0 RECORDS                                             
002900     LABEL RECORDS ARE STANDARD                                           
003000     RECORDING MODE IS F.                                                 
003100 01  INPUT-RECORD.                                                        
003200     05  IN-MEMBER-NAME           PIC X(8).                               
003300     05  IN-REST                  PIC X(72).                              
003400 FD  SORTED-FILE                                                          
003500     DATA RECORD IS SORTED-RECORD                                         
003600     RECORD CONTAINS 80 CHARACTERS                                        
003700     BLOCK CONTAINS 0 RECORDS                                             
003800     LABEL RECORDS ARE STANDARD                                           
003900     RECORDING MODE IS F.                                                 
004000 01  SORTED-RECORD.                                                       
004100     05  OUT-MEMBER-NAME          PIC X(8).                               
004200     05  OUT-REST                 PIC X(72).                              
004300 WORKING-STORAGE SECTION.                                                 
004400 77  FILLER                        PIC X(36) VALUE                        
004500     'SRTSVC99 WORKING STORAGE STARTS HERE'.                              
004510     COPY FSLDYA.                                                         
004520     COPY FSLDYR.                                                         
004600 01  SWITCHES.                                                            
004700     05  INPUT-EOF-SWITCH         PIC X VALUE 'N'.                        
004800         88  INPUT-EOF            VALUE 'Y'.                              
004900     05  SORT-EOF-SWITCH          PIC X VALUE 'N'.                        
005000         88  SORT-EOF             VALUE 'Y'.                              
005100     05  WS-ABEND-CODE            PIC S9(8) COMP VALUE 777.               
005110                                                                          
005200 PROCEDURE DIVISION.                                                      
005210     MOVE LOW-VALUES TO FEP-ALLOCATE-DATA.                                
005220     MOVE 'INPUT1 ' TO C-FEPDYA-DDNAME.                                   
005230     MOVE 'NULLFILE' TO C-FEPDYA-DSNAME-DUMMY-SYSOUT.                     
005240     MOVE +8 TO Q-FEPDYA-CURRENT-STATUS.                                  
005250     MOVE +8 TO Q-FEPDYA-NORMAL-DISPOSITION.                              
005260     MOVE +8 TO Q-FEPDYA-CONDITIONAL-DISP.                                
005270     MOVE '123456' TO C-FEPDYA-VOLUME-SERIAL (1).                         
005292     MOVE '3590-1' TO C-FEPDYA-UNIT-NAME.                                 
005293     MOVE +2 TO Q-FEPDYA-LABEL-TYPE.                                      
005294     MOVE +0 TO Q-FEPDYA-DATASET-SEQUENCE.                                
005295     MOVE 'A' TO C-FEPDYR-ALLOCDYN-REQUEST.                               
005299     CALL 'ALLOCDYN' USING FEP-ALLOCATE-DATA                              
005300                           FEP-ALLOCATE-RESULT.                           
005301                                                                          
005302     IF FEPDYR-SUCCESSFUL-ALLOCATION                                      
005303         NEXT SENTENCE                                                    
005304     ELSE                                                                 
005305         DISPLAY 'UNABLE TO ALLOCATE INPUT1: RETURN CODE='                
005306                 C-FEPDYR-ALLOCDYN-RETURN-CODE                            
005307         DISPLAY '  ERROR-REASON-CODE=' G-FEPDYR-ERROR-REASON-CODE        
005308                 ': ' C-FEPDYR-ERROR-REASON-MESSAGE                       
005309         DISPLAY '  INFORMATION-REASON='                                  
005310                 C-FEPDYR-INFORMATION-REASON                              
005311                 ': ' C-FEPDYR-INFO-REASON-MESSAGE                        
005312         DISPLAY '  DATASET NAME IS:' C-FEPDYA-DSNAME-DUMMY-SYSOUT        
005313         CALL 'CANCEL' USING WS-ABEND-CODE.                               
005320     OPEN INPUT INPUT-FILE, OUTPUT SORTED-FILE.                           
005400     SORT SORT-FILE ASCENDING KEY SD-MEMBER-NAME                          
005500         INPUT PROCEDURE IS 100-READ-INPUT                                
005600         OUTPUT PROCEDURE IS 200-WRITE-OUTPUT.                            
005700     CLOSE INPUT-FILE, SORTED-FILE.                                       
005800     GOBACK.                                                              
005900                                                                          
005901 100-READ-INPUT SECTION.                                                  
005910     PERFORM 1000-READ-INPUT-FILE THRU 100-EXIT                           
005911         UNTIL INPUT-EOF.                                                 
005912                                                                          
005913 200-WRITE-OUTPUT SECTION.                                                
005920     PERFORM 2000-WRITE-SORTED-FILE THRU 200-EXIT                         
005930         UNTIL SORT-EOF.                                                  
005940                                                                          
005950 999-PROCEDURES SECTION.                                                  
006000 1000-READ-INPUT-FILE.                                                    
006100     READ INPUT-FILE                                                      
006200         AT END                                                           
006300             MOVE 'Y' TO INPUT-EOF-SWITCH                                 
006400             GO TO 100-EXIT.                                              
006500     PERFORM 110-BUILD-SORT-RECORD THRU 110-EXIT                          
006600     GO TO 1000-READ-INPUT-FILE.                                          
006700 100-EXIT. EXIT.                                                          
006800                                                                          
006900 110-BUILD-SORT-RECORD.                                                   
007000     MOVE INPUT-RECORD TO SORT-RECORD.                                    
007100     RELEASE SORT-RECORD.                                                 
007200 110-EXIT. EXIT.                                                          
007300                                                                          
007400 2000-WRITE-SORTED-FILE.                                                  
007500     RETURN SORT-FILE                                                     
007600         AT END                                                           
007700             MOVE 'Y' TO SORT-EOF-SWITCH                                  
007800             GO TO 200-EXIT.                                              
007900     WRITE SORTED-RECORD FROM SORT-RECORD.                                
008000     GO TO 2000-WRITE-SORTED-FILE.                                        
008100 200-EXIT. EXIT.                                                          
