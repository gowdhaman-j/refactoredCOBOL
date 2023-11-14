000100 IDENTIFICATION DIVISION.                                                 
000200 PROGRAM-ID.    WRTQSAM.                                                  
000300 AUTHOR. R THORNTON                                                       
000310****************************************************************          
000400*REMARKS. TEST BUCKET FOR WRITING A SEQUENTIAL FILE. PROGRAMS  *          
000401*         COMPILED WITH THE DEFAULT COMPILER OPTION NOCMPR2    *          
000402*         AND EXECUTED WITH THE DEFAULT RUNTIME OPTION         *          
000404*         CBLQDA(ON) WILL DYNAMICALLY ALLOCATE AN OUTPUT FILE  *          
000405*         TO A TEMPORARY DATASET AND DISCARD IT AT END OF JOB  *          
000406*         IF THE DD STATEMENT FOR THE FILE IS MISSING OR THE   *          
000410*         DDNAME IS MISSPELLED.                                *          
000420*         PURPOSE OF THIS PROGRAM IS TO INVESTIGATE THE EFFECTS*          
000430*         OF COMPILING WITH CMPR2 AND/OR EXECUTING WITH THE    *          
000440*         CBLQDA(OFF) RUNTIME OPTION.                          *          
000450****************************************************************          
000500 ENVIRONMENT DIVISION.                                                    
000600 CONFIGURATION SECTION.                                                   
000700 INPUT-OUTPUT SECTION.                                                    
000800 FILE-CONTROL.                                                            
000900*                                                                         
001000     SELECT OUTPUT-FILE ASSIGN TO UT-S-OUTPUT1.                           
001100*                                                                         
001200 DATA DIVISION.                                                           
001300*                                                                         
001400 FILE SECTION.                                                            
001500*                                                                         
001600 FD  OUTPUT-FILE                                                          
001800     RECORDING MODE IS F                                                  
001900     BLOCK CONTAINS 0 RECORDS                                             
001910     RECORD CONTAINS 80 CHARACTERS                                        
002000     LABEL RECORD IS STANDARD                                             
002100     DATA RECORD IS OUTPUT-RECORD.                                        
002200*                                                                         
002300 01  OUTPUT-RECORD           PIC X(80).                                   
002400*                                                                         
002500 WORKING-STORAGE SECTION.                                                 
002600                                                                          
002700 77  FILLER PIC X(36)  VALUE                                              
002800     'WRTQSAM WORKING STORAGE BEGINS HERE'.                               
002810 01  RECORD1                 PIC X(80) VALUE                              
002900     'THIS IS RECORD 1'.                                                  
002910 01  RECORD2                 PIC X(80) VALUE                              
002920     'THIS IS RECORD 2'.                                                  
002930 01  RECORD3                 PIC X(80) VALUE                              
002940     'THIS IS RECORD 3'.                                                  
002950 01  RECORD4                 PIC X(80) VALUE                              
002960     'THIS IS RECORD 4'.                                                  
002970 01  RECORD5                 PIC X(80) VALUE                              
002980     'THIS IS RECORD 5'.                                                  
002990 01  RECORD6                 PIC X(80) VALUE                              
002991     'THIS IS RECORD 6'.                                                  
003000 PROCEDURE DIVISION.                                                      
003100     OPEN OUTPUT OUTPUT-FILE.                                             
003300     WRITE OUTPUT-RECORD FROM RECORD1.                                    
003310     WRITE OUTPUT-RECORD FROM RECORD2.                                    
003320     WRITE OUTPUT-RECORD FROM RECORD3.                                    
003330     WRITE OUTPUT-RECORD FROM RECORD4.                                    
003340     WRITE OUTPUT-RECORD FROM RECORD5.                                    
003350     WRITE OUTPUT-RECORD FROM RECORD6.                                    
003360     CLOSE OUTPUT-FILE.                                                   
003700     GOBACK.                                                              
