       IDENTIFICATION DIVISION.                                                 
       PROGRAM-ID.    CALLGTDT.                                                 
       AUTHOR. R THORNTON                                                       
      *TEST BUCKET TO COMPARE THE DATES RETURNED BY GETDATE                     
      *AND GETDATE2 FOR ALL DATES IN A YEAR. THIS PROGRAM                       
      *CREATES A DATE FILE, CALLS GETDATE, THEN GETDATE2 FOR EACH               
      *VALID FORMAT AND COMPARES THE DATA RETURNED. DIFFERENCES ARE             
      *PRINTED. AFTER EACH DATE IS PROCESSED, THE DATE FILE IS UPDATED          
      *FOR THE NEXT DATE UNTIL ALL DATES FROM JAN 1 THRU DEC 31 HAVE            
      *BEEN PROCESSED.                                                          
       ENVIRONMENT DIVISION.                                                    
       CONFIGURATION SECTION.                                                   
       INPUT-OUTPUT SECTION.                                                    
       FILE-CONTROL.                                                            
           SELECT DATE-FILE ASSIGN TO DATE2.                                    
           SELECT PRINT-FILE ASSIGN TO PRINT1.                                  
       DATA DIVISION.                                                           
       FILE SECTION.                                                            
       FD  DATE-FILE                                                            
           RECORDING MODE IS F                                                  
           LABEL RECORDS ARE STANDARD.                                          
       01  DATE-RECORD             PIC X(80).                                 10
       FD  PRINT-FILE                                                           
           RECORDING MODE IS F                                                  
           BLOCK CONTAINS 0 RECORDS                                             
           LABEL RECORDS ARE STANDARD.                                          
       01  PRINT-RECORD.                                                      10
           05  PRINT-FLAG          PIC XXX.                                     
           05  FILLER              PIC X.                                       
           05  PRINT-DATE          PIC X(8).                                    
           05  FILLER              PIC X.                                       
           05  PRINT-REQUEST       PIC X.                                       
           05  FILLER              PIC X.                                       
           05  PRINT-GETDATE       PIC X(18).                                   
           05  FILLER              PIC X.                                       
           05  PRINT-GETDATE2      PIC X(18).                                   
           05  FILLER              PIC X(28).                                   
       WORKING-STORAGE SECTION.                                                 
       77  FILLER PIC X(36)  VALUE                                              
           'CALLGTDT WORKING STORAGE BEGINS HERE'.                              
       01  WS-MISCELLANEOUS.                                                    
           05  WS-END-SWITCH       PIC X VALUE 'Y'.                             
               88  MORE-DATES      VALUE 'Y'.                                   
               88  NO-MORE-DATES   VALUE 'N'.                                   
           05  WS-DATE-RECORD.                                                  
               10  FILLER          PICTURE X(6) VALUE ' DATE='.                 
               10  WS-DATE.                                                     
                   15  WS-MONTH    PIC 99 VALUE 01.                             
                   15  FILLER      PIC X VALUE '/'.                             
                   15  WS-DAY      PIC 99 VALUE 00.                             
                   15  FILLER      PIC X VALUE '/'.                             
                   15  WS-YEAR     PIC 99 VALUE 92.                             
           05  WS-GETDATE2-RETURN  PIC X(18).                                   
           05  WS-GETDATE-RETURN   PIC X(18).                                   
           05  WS-FORMAT-REQUEST   PIC X.                                       
                                                                                
       PROCEDURE DIVISION.                                                      
                                                                                
       A100-EXECUTIVE-CONTROL.                                                  
           PERFORM A100-INITIALIZATION.                                         
           PERFORM B100-MAINLINE-PROCESSING                                     
               UNTIL NO-MORE-DATES.                                             
           PERFORM Z100-END-OF-PROCESSING.                                      
           GOBACK.                                                              
                                                                                
       A100-INITIALIZATION.                                                     
           OPEN OUTPUT PRINT-FILE.                                              
                                                                                
       B100-MAINLINE-PROCESSING.                                                
           PERFORM C100-INITIALIZE-DATE-FILE.                                   
           IF MORE-DATES                                                        
               PERFORM D100-COMPARE-RESULTS.                                    
                                                                                
       C100-INITIALIZE-DATE-FILE.                                               
           PERFORM C200-UPDATE-DATE.                                            
           IF MORE-DATES                                                        
               OPEN OUTPUT DATE-FILE                                            
               WRITE DATE-RECORD FROM WS-DATE-RECORD                            
               CLOSE DATE-FILE.                                                 
                                                                                
       C200-UPDATE-DATE.                                                        
           IF WS-DATE = '12/31/92'                                              
               MOVE 'N' TO WS-END-SWITCH.                                       
           ADD 1 TO WS-DAY.                                                     
           IF WS-DAY > 31                                                       
               ADD 1 TO WS-MONTH                                                
               MOVE 01 TO WS-DAY.                                               
                                                                                
       D100-COMPARE-RESULTS.                                                    
           MOVE 'A' TO WS-FORMAT-REQUEST.                                       
           PERFORM D200-CALL-SUBROUTINES.                                       
           MOVE 'S' TO WS-FORMAT-REQUEST.                                       
           PERFORM D200-CALL-SUBROUTINES.                                       
           MOVE 'Y' TO WS-FORMAT-REQUEST.                                       
           PERFORM D200-CALL-SUBROUTINES.                                       
           MOVE 'D' TO WS-FORMAT-REQUEST.                                       
           PERFORM D200-CALL-SUBROUTINES.                                       
           MOVE SPACES TO PRINT-RECORD.                                         
           PERFORM E100-PRINT-A-LINE.                                           
                                                                                
       D200-CALL-SUBROUTINES.                                                   
           MOVE ALL 'A' TO WS-GETDATE-RETURN.                                   
           MOVE WS-GETDATE-RETURN TO WS-GETDATE2-RETURN.                        
           CALL 'GETDATE' USING WS-GETDATE-RETURN,                              
                                WS-FORMAT-REQUEST.                              
           CALL 'GETDATE2' USING WS-GETDATE2-RETURN,                            
                                WS-FORMAT-REQUEST.                              
           PERFORM D300-PRINT-RESULTS.                                          
                                                                                
       D300-PRINT-RESULTS.                                                      
           MOVE SPACES TO PRINT-RECORD.                                         
           MOVE WS-FORMAT-REQUEST TO PRINT-REQUEST.                             
           MOVE WS-DATE TO PRINT-DATE.                                          
           MOVE WS-GETDATE-RETURN TO PRINT-GETDATE.                             
           MOVE WS-GETDATE2-RETURN TO PRINT-GETDATE2.                           
           IF WS-GETDATE-RETURN = WS-GETDATE2-RETURN                            
               MOVE '   ' TO PRINT-FLAG                                         
           ELSE                                                                 
               MOVE 'BAD' TO PRINT-FLAG.                                        
           PERFORM E100-PRINT-A-LINE.                                           
                                                                                
       E100-PRINT-A-LINE.                                                       
           WRITE PRINT-RECORD.                                                  
                                                                                
       Z100-END-OF-PROCESSING.                                                  
           CLOSE PRINT-FILE.                                                    
