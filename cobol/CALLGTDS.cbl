000100 IDENTIFICATION DIVISION.                                                 
000200 PROGRAM-ID.    CALLGTDS.                                                 
000300***********************************************************               
000400*  TEST BUCKET FOR CALLING GETDSNC SUBROUTINE: A FILE IS  *               
000510*  READ WHICH CONTAINS A 6-BYTE VOLUME SERIAL NUMBER IN   *               
000511*  POSITIONS 1-6. THE VOLUME SERIAL MUST BE FOR A TAPE    *               
000512*  CATALOGED UNDER TMS. THE VOLUME SERIAL IS PASSED TO    *               
000513*  THE GETDSNC SUBROUTINE, WHICH OBTAINS THE DATASET NAME *               
000514*  BY INTERFACING WITH TMS. THE DATASET NAME RETURNED IS  *               
000515*  PRINTED.                                               *               
000516***********************************************************               
000520 ENVIRONMENT DIVISION.                                                    
000600 CONFIGURATION SECTION.                                                   
000700 INPUT-OUTPUT SECTION.                                                    
000800 FILE-CONTROL.                                                            
001000     SELECT INPUT-FILE ASSIGN TO UT-S-INPUT1.                             
001010     SELECT PRINT-FILE ASSIGN TO UT-S-PRINT1.                             
001100*                                                                         
001200 DATA DIVISION.                                                           
001400 FILE SECTION.                                                            
001500*                                                                         
001600 FD  INPUT-FILE                                                           
001700     RECORD CONTAINS 80 CHARACTERS                                        
001800     RECORDING MODE IS F                                                  
001900     BLOCK CONTAINS 0 RECORDS                                             
002000     LABEL RECORD IS STANDARD                                             
002100     DATA RECORD IS INPUT-RECORD.                                         
002200*                                                                         
002300 01  INPUT-RECORD.                                                        
002310     05 VOLUME-SERIAL       PIC X(6).                                     
002320     05 FILLER              PIC X(74).                                    
002410*                                                                         
002420 FD  PRINT-FILE                                                           
002430     RECORD CONTAINS 133 CHARACTERS                                       
002440     RECORDING MODE IS F                                                  
002450     BLOCK CONTAINS 0 RECORDS                                             
002460     LABEL RECORD IS STANDARD                                             
002470     DATA RECORD IS PRINT-RECORD.                                         
002480*                                                                         
002490 01  PRINT-RECORD.                                                        
002491     05 CARRIAGE-CONTROL    PIC X.                                        
002492     05 PRINT-LINE.                                                       
002493         10 VOLUME-SERIAL   PIC X(6).                                     
002494         10 FILLER          PIC XX.                                       
002495         10 DATASET-NAME    PIC X(44).                                    
002496         10 FILLER          PIC X(80).                                    
002497*                                                                         
002500 WORKING-STORAGE SECTION.                                                 
002600*                                                                         
002610 01  MISCELLANEOUS-DATA-FIELDS.                                           
002700     05 FILLER                      PIC X(36)  VALUE                      
002800                      'CALLGTDS WORKING STORAGE BEGINS HERE'.             
002801     05 TABLE-1-TEST                PIC XX OCCURS 30 TIMES.               
002802     05 UNTABLE-1-TEST              PIC X(60).                            
002803     05 TARGET-TEST                 PIC XX.                               
002810     05 END-OF-INPUT-SWITCH         PIC X VALUE 'N'.                      
002820        88 END-OF-INPUT-FILE        VALUE 'Y'.                            
002830     05 COUNT-OF-PAGES              PIC S9(5) COMP-3 VALUE +0.            
002850     05 COUNT-OF-LINES              PIC S9(3) COMP-3 VALUE +0.            
002851        88 BOTTOM-OF-PAGE           VALUE +58.                            
002860     05 CCTL                        PIC 9.                                
002861     05 WS-DATE.                                                          
002862        10 WS-YEAR                  PIC XX.                               
002863        10 WS-MONTH                 PIC XX.                               
002864        10 WS-DAY                   PIC XX.                               
002870*                                                                         
002871 01  HEADING-LINE-1.                                                      
002872     05 FILLER                      PIC X VALUE SPACES.                   
002873     05 FILLER                      PIC X(13) VALUE                       
002874                                    'REPORT DATE: '.                      
002875     05 HEADING-MONTH               PIC XX.                               
002876     05 FILLER                      PIC X VALUE '/'.                      
002877     05 HEADING-DAY                 PIC XX.                               
002878     05 FILLER                      PIC X VALUE '/'.                      
002879     05 HEADING-YEAR                PIC XX.                               
002881     05 FILLER                      PIC X(19) VALUE                       
002882                                    ', PROGRAM: CALLGTDS'.                
002883     05 FILLER                      PIC X(22) VALUE SPACES.               
002885     05 FILLER                      PIC X(37) VALUE                       
002886                     'DATASET NAME FOR VOLUME SERIAL REPORT'.             
002887     05 FILLER                      PIC X(22) VALUE SPACES.               
002889     05 FILLER                      PIC X(6) VALUE 'PAGE: '.              
002890     05 HEADING-PAGE                PIC Z(5).                             
002891*                                                                         
002892 01  HEADING-LINE-2.                                                      
002893     05 FILLER                      PIC X VALUE SPACES.                   
002894     05 FILLER                      PIC X(6) VALUE SPACES.                
002895     05 FILLER                      PIC XX   VALUE SPACES.                
002896     05 FILLER                      PIC X(44) VALUE SPACES.               
002897     05 FILLER                      PIC X(50) VALUE SPACES.               
002898*                                                                         
002899 01  PARM-FIELD.                                                          
002900     05 VOLUME-SERIAL               PIC X(6).                             
002901     05 FILLER                      PIC X.                                
002902     05 DATASET-NAME                PIC X(44).                            
002903     05 FILLER                      PIC X.                                
002904     05 SUCCESS-INDICATOR           PIC XX.                               
002905        88 CALL-WAS-SUCCESSFUL      VALUE '00'.                           
002906     05 FILLER                      PIC X(16).                            
002907*                                                                         
003000 PROCEDURE DIVISION.                                                      
003001*                                                                         
003010 1000-EXECUTIVE.                                                          
003011     MOVE TABLE-1-TEST (1) TO TARGET-TEST.                                
003013     MOVE UNTABLE-1-TEST (1:3) TO TARGET-TEST.                            
003020     PERFORM 2000-INITIALIZATION THRU 2000-EXIT.                          
003030     PERFORM 3000-MAINLINE THRU 3000-EXIT                                 
003040         UNTIL END-OF-INPUT-FILE.                                         
003050     PERFORM 9000-TERMINATION THRU 9000-EXIT.                             
003060     GOBACK.                                                              
003061*                                                                         
003070 2000-INITIALIZATION.                                                     
003100     OPEN INPUT INPUT-FILE,                                               
003110          OUTPUT PRINT-FILE.                                              
003111     ACCEPT WS-DATE FROM DATE.                                            
003112     MOVE WS-MONTH TO HEADING-MONTH.                                      
003113     MOVE WS-DAY TO HEADING-DAY.                                          
003114     MOVE WS-YEAR TO HEADING-YEAR.                                        
003124     PERFORM 7000-PRINT-HEADING THRU 7000-EXIT.                           
003125     PERFORM 5000-READ-INPUT-FILE THRU 5000-EXIT.                         
003130 2000-EXIT. EXIT.                                                         
003140*                                                                         
003200 3000-MAINLINE.                                                           
003210     PERFORM 4000-PROCESS-RECORD THRU 4000-EXIT.                          
003300     PERFORM 5000-READ-INPUT-FILE THRU 5000-EXIT.                         
003400 3000-EXIT. EXIT.                                                         
003500*                                                                         
003501 4000-PROCESS-RECORD.                                                     
003503     MOVE VOLUME-SERIAL IN INPUT-RECORD TO                                
003504          VOLUME-SERIAL IN PARM-FIELD.                                    
003505     CALL 'GETDSNC' USING PARM-FIELD.                                     
003506     IF CALL-WAS-SUCCESSFUL                                               
003507         PERFORM 4100-FORMAT-DATA-LINE THRU 4100-EXIT                     
003509     ELSE                                                                 
003510         PERFORM 4700-FORMAT-ERROR-LINE THRU 4700-EXIT.                   
003511     PERFORM 6000-PRINT-A-LINE THRU 6000-EXIT.                            
003512 4000-EXIT. EXIT.                                                         
003513*                                                                         
003514 4100-FORMAT-DATA-LINE.                                                   
003515          MOVE DATASET-NAME IN PARM-FIELD TO                              
003516               DATASET-NAME IN PRINT-RECORD.                              
003517          MOVE VOLUME-SERIAL IN INPUT-RECORD TO                           
003518               VOLUME-SERIAL IN PRINT-RECORD.                             
003519          PERFORM 6000-PRINT-A-LINE THRU 6000-EXIT.                       
003520 4100-EXIT. EXIT.                                                         
003521*                                                                         
003522 4700-FORMAT-ERROR-LINE.                                                  
003523          MOVE 'UNABLE TO OBTAIN DATASET NAME' TO                         
003524               DATASET-NAME IN PRINT-RECORD.                              
003525          MOVE VOLUME-SERIAL IN INPUT-RECORD TO                           
003526               VOLUME-SERIAL IN PRINT-RECORD.                             
003527          PERFORM 6000-PRINT-A-LINE THRU 6000-EXIT.                       
003528 4700-EXIT. EXIT.                                                         
003529*                                                                         
003530 5000-READ-INPUT-FILE.                                                    
003531     READ INPUT-FILE                                                      
003532         AT END                                                           
003533             MOVE 'Y' TO END-OF-INPUT-SWITCH.                             
003541 5000-EXIT. EXIT.                                                         
003542*                                                                         
003543 6000-PRINT-A-LINE.                                                       
003544     WRITE PRINT-RECORD AFTER ADVANCING CCTL LINES.                       
003545     ADD CCTL TO COUNT-OF-LINES.                                          
003546     MOVE 1 TO CCTL.                                                      
003547     MOVE SPACES TO PRINT-RECORD.                                         
003548     IF BOTTOM-OF-PAGE                                                    
003549         PERFORM 7000-PRINT-HEADING THRU 7000-EXIT.                       
003550 6000-EXIT. EXIT.                                                         
003551*                                                                         
003552 7000-PRINT-HEADING.                                                      
003553     MOVE COUNT-OF-PAGES TO HEADING-PAGE.                                 
003555     MOVE HEADING-LINE-1 TO PRINT-RECORD.                                 
003556     WRITE PRINT-RECORD AFTER ADVANCING PAGE.                             
003557     MOVE HEADING-LINE-2 TO PRINT-RECORD.                                 
003558     MOVE 2 TO CCTL.                                                      
003559     WRITE PRINT-RECORD AFTER ADVANCING CCTL LINES.                       
003560     MOVE SPACES TO PRINT-RECORD.                                         
003561     MOVE 3 TO COUNT-OF-LINES.                                            
003562     ADD 1 TO COUNT-OF-PAGES.                                             
003563 7000-EXIT. EXIT.                                                         
003570*                                                                         
003600 9000-TERMINATION.                                                        
003700     CLOSE INPUT-FILE,                                                    
003800           PRINT-FILE.                                                    
003900 9000-EXIT. EXIT.                                                         
