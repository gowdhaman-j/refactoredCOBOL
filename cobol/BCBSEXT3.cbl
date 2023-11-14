000100 ID DIVISION.                                                             
000200 PROGRAM-ID. BCBSEXT3                                                     
000210**************************************************************            
000300*    READ THE MACHINE FILE INPUT AND WRITE A FILE OF LOAD    *            
000400*    MODULES CONTAINING IP3 AND/OR PL/I CODE.                *            
000420*    RECORD DESCRIPTION COPY BOOK IS IN                      *            
000421*    SPP.EDGE.PRTFOLIO.SOURCE(MRRECCOB).                     *            
000422*    THE MACHINE RECORD CONTAINS COMMON FIELDS FROM MRMEM TO *            
000423*    MRDATLKD. FIELDS BETWEEN MRC2DATA AND MRC2AWO ARE FOR   *            
000424*    TYPES C2 AND C3. FIELDS BETWEEN MROCSYMD AND MROCSYSO   *            
000425*    ARE FOR TYPES VS AND V4. FIELDS MRCOBSM AND MRCOBDC ARE *            
000426*    COMMON TO ALL COBOLS.                                   *            
000430**************************************************************            
000500 ENVIRONMENT DIVISION.                                                    
000600 CONFIGURATION SECTION.                                                   
000700 SOURCE-COMPUTER. IBM-370.                                                
000800 OBJECT-COMPUTER. IBM-370.                                                
000900 INPUT-OUTPUT SECTION.                                                    
001000 FILE-CONTROL.                                                            
001100     SELECT MACHINE-FILE ASSIGN TO UT-S-MACHINE                           
001200         FILE STATUS MACHINE-FILE-STATUS.                                 
001300     SELECT REPORT-FILE ASSIGN TO UT-S-REPORT                             
001400         FILE STATUS REPORT-FILE-STATUS.                                  
001500 DATA DIVISION.                                                           
001600 FILE SECTION.                                                            
001700 FD  MACHINE-FILE                                                         
001800     BLOCK CONTAINS 0 RECORDS                                             
001900     RECORD CONTAINS 200 CHARACTERS                                       
002000     RECORDING F.                                                         
002100     COPY MRRECCOB.                                                       
002200                                                                          
002300 FD  REPORT-FILE                                                          
002400     BLOCK CONTAINS 0 RECORDS                                             
002500     RECORD CONTAINS 133 CHARACTERS                                       
002600     RECORDING MODE F.                                                    
002700 01  REPORT-RECORD.                                                       
002800     05  FILLER                      PIC X.                               
002900     05  RPT-MEMBER-NAME             PIC X(8).                            
003000     05  FILLER                      PIC X.                               
003001     05  RPT-MODULE-ATTRIBUTES.                                           
003010         10  RPT-TYPE-PM             PIC XX.                              
003011         10  FILLER                  PIC X.                               
003012         10  RPT-TYPE-PR             PIC XX.                              
003020         10  FILLER                  PIC X.                               
003021         10  RPT-TYPE-P1             PIC XX.                              
003022         10  FILLER                  PIC X.                               
003023         10  RPT-TYPE-P2             PIC XX.                              
003024         10  FILLER                  PIC X.                               
003030         10  RPT-IP3                 PIC X(6).                            
003031         10  FILLER                  PIC X.                               
003032         10  RPT-IBM                 PIC X(6).                            
003040         10  FILLER                  PIC X.                               
003050         10  RPT-PLISTART            PIC X(8).                            
003060         10  FILLER                  PIC X.                               
003070         10  RPT-PLIMAIN             PIC X(7).                            
003080         10  FILLER                  PIC X.                               
003100         10  RPT-DSNAME              PIC X(33).                           
003300         10  FILLER                  PIC X(47).                           
004600                                                                          
004700 WORKING-STORAGE SECTION.                                                 
004800 01  MACHINE-FILE-STATUS.                                                 
004900     05  MACHINE-FILE-STATUS-BYTE1   PIC 9 VALUE 0.                       
005000         88  MACHINE-EOF VALUE 1.                                         
005100     05  MACHINE-FILE-STATUS-BYTE2   PIC X.                               
005200 01  REPORT-FILE-STATUS.                                                  
005300     05  REPORT-FILE-STATUS-BYTE1    PIC 9 VALUE 0.                       
005400     05  REPORT-FILE-STATUS-BYTE2    PIC X.                               
005500 01  STATISTICAL-DATA.                                                    
005600     05  MACHINE-RECORDS-READ        PIC S9(8) COMP VALUE +0.             
005700 01  CURRENT-MODULE                  PIC X(8) VALUE SPACES.               
005800 01  CURRENT-USRDAT.                                                      
005810     05  CURRENT-USRDAT12            PIC X(2) VALUE SPACES.               
005820     05  CURRENT-USRDAT34            PIC X(2) VALUE SPACES.               
006900 01  DSNAMES-ARRAY.                                                       
007000     05  FILLER PIC X(4)  VALUE 'EOLL'.                                   
007100     05  FILLER PIC X(33) VALUE 'EMVSP.OUTPUT.LOADLIB'.                   
007200     05  FILLER PIC X(4)  VALUE 'IMS1'.                                   
007300     05  FILLER PIC X(33) VALUE 'EMVSP.IMSVS.PGMLIB'.                     
007400     05  FILLER PIC X(4)  VALUE 'KX01'.                                   
007500     05  FILLER PIC X(33) VALUE 'EMVSP.CICS.LOADLIB'.                     
007600     05  FILLER PIC X(4)  VALUE 'KX02'.                                   
007700     05  FILLER PIC X(33) VALUE 'EMVSQ.CICS.LOADLIB'.                     
007800     05  FILLER PIC X(4)  VALUE 'KX03'.                                   
007900     05  FILLER PIC X(33) VALUE 'EMVSP.HCS.LOADLIB'.                      
008000     05  FILLER PIC X(4)  VALUE 'KX04'.                                   
008100     05  FILLER PIC X(33) VALUE 'ECC.PRD.MDARNDP.LINKLIB'.                
008200     05  FILLER PIC X(4)  VALUE 'KX05'.                                   
008300     05  FILLER PIC X(33) VALUE 'ECC.PRD.MDDCTI.V20000.LINKLIB'.          
008400     05  FILLER PIC X(4)  VALUE 'KX06'.                                   
008500     05  FILLER PIC X(33) VALUE                                           
008510                            'ECC.PRD.MDDOAI.V20000.PTF.LINKLIB'.          
008600     05  FILLER PIC X(4)  VALUE 'KX07'.                                   
008700     05  FILLER PIC X(33) VALUE 'CICS.PROD.USERLOAD'.                     
008800     05  FILLER PIC X(4)  VALUE 'KX08'.                                   
008900     05  FILLER PIC X(33) VALUE 'CICS.TEST.USER.LOADLIB'.                 
009000     05  FILLER PIC X(4)  VALUE 'KX09'.                                   
009100     05  FILLER PIC X(33) VALUE 'CICS.MAINT.USER.LOADLIB'.                
009200     05  FILLER PIC X(4)  VALUE 'KX10'.                                   
009300     05  FILLER PIC X(33) VALUE 'CICS.MAINT.OMNIDESK.LOADLIB'.            
009400     05  FILLER PIC X(4)  VALUE 'KX11'.                                   
009500     05  FILLER PIC X(33) VALUE 'CICS.PROD.COINSERV.LOADLIB'.             
009600     05  FILLER PIC X(4)  VALUE 'KX12'.                                   
009700     05  FILLER PIC X(33) VALUE 'DBEXCEL.PRD.ALT.LOADLIB'.                
009800     05  FILLER PIC X(4)  VALUE 'KX13'.                                   
009900     05  FILLER PIC X(33) VALUE 'DRG.PRD.CCEAP981.LOADLIBA'.              
010000     05  FILLER PIC X(4)  VALUE 'KX14'.                                   
010100     05  FILLER PIC X(33) VALUE 'DRG.PRD.CCEAP991.LOADLIBA'.              
010200     05  FILLER PIC X(4)  VALUE 'KX15'.                                   
010300     05  FILLER PIC X(33) VALUE 'DRG.PRD.CCE981.LOADLIBH'.                
010400     05  FILLER PIC X(4)  VALUE 'KX16'.                                   
010500     05  FILLER PIC X(33) VALUE 'DRG.PRD.CCE982.LOADLIBA'.                
010600     05  FILLER PIC X(4)  VALUE 'KX17'.                                   
010700     05  FILLER PIC X(33) VALUE 'DRG.PRD.CCE982.LOADLIBH'.                
010800     05  FILLER PIC X(4)  VALUE 'KX18'.                                   
010900     05  FILLER PIC X(33) VALUE 'DRG.PRD.CCE991.LOADLIBH'.                
011000     05  FILLER PIC X(4)  VALUE 'KX19'.                                   
011100     05  FILLER PIC X(33) VALUE 'GIBC.PRODCICS'.                          
011200     05  FILLER PIC X(4)  VALUE 'KX20'.                                   
011300     05  FILLER PIC X(33) VALUE 'INTERQ.PROD.COB2.LOAD'.                  
011704     05  FILLER PIC X(4)  VALUE HIGH-VALUES.                              
011710     05  FILLER PIC X(33) VALUE '????UNKNOWN.LOADLIB?????'.               
011900                                                                          
012000 01  DSNAME-TABLE REDEFINES DSNAMES-ARRAY.                                
012100     05  DSNAME-TABLE-ENTRY               OCCURS 23 TIMES                 
012200                                          INDEXED BY I.                   
012300         10  TBL-ARG                      PIC X(4).                       
012400         10  TBL-DSNAME                   PIC X(33).                      
012500                                                                          
012600 PROCEDURE DIVISION.                                                      
012700 0000-EXECUTIVE-CONTROL.                                                  
012800     PERFORM 9900-INITIALIZATION.                                         
012900     PERFORM 1000-MAINLINE UNTIL MACHINE-EOF.                             
013000     PERFORM 9990-END-OF-JOB.                                             
013100     GOBACK.                                                              
013200                                                                          
013300 1000-MAINLINE.                                                           
013400      READ MACHINE-FILE                                                   
013500         AT END PERFORM 8000-END-OF-FILE.                                 
013600      IF MACHINE-EOF                                                      
013700          NEXT SENTENCE                                                   
013800      ELSE                                                                
013900          ADD +1 TO MACHINE-RECORDS-READ                                  
014000          PERFORM 2000-CHECK-MODULE-CHANGE                                
014100          PERFORM 3000-PROCESS-THIS-CSECT.                                
014200                                                                          
014300 2000-CHECK-MODULE-CHANGE.                                                
014400      IF (MRMEM NOT EQUAL CURRENT-MODULE) OR                              
014500          (MRUSRDAT NOT EQUAL CURRENT-USRDAT)                             
014600              PERFORM 7000-MODULE-ANALYSIS                                
014700              PERFORM 6000-INITIALIZE-NEW-MODULE.                         
014800                                                                          
014900 3000-PROCESS-THIS-CSECT.                                                 
015000     IF MRCSECT(1:3) = 'IP3'                                              
015100       MOVE 'IP3...' TO RPT-IP3.                                          
015200     IF MRCSECT(1:3) = 'IBM'                                              
015300       MOVE 'IBM...' TO RPT-IBM.                                          
015400     IF MRCSECT = 'PLISTART'                                              
015500       MOVE 'PLISTART' TO RPT-PLISTART.                                   
015600     IF MRCSECT = 'PLIMAIN'                                               
015700       MOVE 'PLIMAIN' TO RPT-PLIMAIN.                                     
018010     IF MRTYPE = 'PM'                                                     
018100           MOVE 'PM' TO RPT-TYPE-PM.                                      
018200     IF MRTYPE = 'PR'                                                     
018300           MOVE 'PR' TO RPT-TYPE-PR.                                      
018400     IF MRTYPE = 'P1'                                                     
018500           MOVE 'P1' TO RPT-TYPE-P1.                                      
018600     IF MRTYPE = 'P2'                                                     
018700           MOVE 'P2' TO RPT-TYPE-P2.                                      
020000                                                                          
020100 6000-INITIALIZE-NEW-MODULE.                                              
020200     MOVE MRMEM TO CURRENT-MODULE.                                        
020300     MOVE MRUSRDAT TO CURRENT-USRDAT.                                     
020600     MOVE SPACES TO REPORT-RECORD.                                        
021000                                                                          
021100 7000-MODULE-ANALYSIS.                                                    
021500     IF RPT-MODULE-ATTRIBUTES = SPACES                                    
021600         NEXT SENTENCE                                                    
021700     ELSE                                                                 
021900         MOVE CURRENT-MODULE TO RPT-MEMBER-NAME                           
022000         PERFORM VARYING I FROM 1 BY 1                                    
022100             UNTIL TBL-ARG(I) = CURRENT-USRDAT                            
022200             OR TBL-ARG(I) = HIGH-VALUES                                  
022300         END-PERFORM                                                      
022400         MOVE TBL-DSNAME(I) TO RPT-DSNAME                                 
022500         WRITE REPORT-RECORD                                              
022600         MOVE SPACES TO REPORT-RECORD.                                    
022700                                                                          
022800 8000-END-OF-FILE.                                                        
022900      IF MACHINE-RECORDS-READ EQUAL ZERO                                  
023000          DISPLAY 'NULL MACHINE INPUT FILE ENCOUNTERED - INVALID'         
023100          CALL 'ILBOABN0'                                                 
023200      ELSE                                                                
023300          IF (MACHINE-FILE-STATUS-BYTE1 NOT EQUAL 0)                      
023400              AND (MACHINE-FILE-STATUS-BYTE1 NOT EQUAL 1)                 
023500     DISPLAY 'UNEXPECTED FILE STATUS AFTER MACHINE FILE READ ='           
023600                      MACHINE-FILE-STATUS                                 
023700                  CALL 'ILBOABN0'.                                        
023800                                                                          
023900 9900-INITIALIZATION.                                                     
024000     OPEN INPUT MACHINE-FILE.                                             
024100     IF (MACHINE-FILE-STATUS-BYTE1 NOT EQUAL 0)                           
024200         AND (MACHINE-FILE-STATUS-BYTE1 NOT EQUAL 1)                      
024300           DISPLAY 'UNEXPECTED FILE STATUS AFTER MACHINE OPEN = '         
024400                 MACHINE-FILE-STATUS                                      
024500             CALL 'ILBOABN0'.                                             
024600     OPEN OUTPUT REPORT-FILE.                                             
024700     IF ( REPORT-FILE-STATUS-BYTE1 NOT EQUAL 0 )                          
024800       DISPLAY 'UNEXPECTED FILE STATUS AFTER REPORT FILE OPEN = '         
024900             REPORT-FILE-STATUS                                           
025000         CALL 'ILBOABN0'.                                                 
025100     MOVE SPACES TO REPORT-RECORD.                                        
025200                                                                          
025300 9990-END-OF-JOB.                                                         
025400      PERFORM 7000-MODULE-ANALYSIS                                        
025500     CLOSE MACHINE-FILE.                                                  
025600     CLOSE REPORT-FILE.                                                   
  