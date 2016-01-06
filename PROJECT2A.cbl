       IDENTIFICATION DIVISION.
       PROGRAM-ID.         PROJECT2A.
       AUTHOR.             RICHARD BARNEY.
       DATE-WRITTEN.       FEBRUARY-MARCH 2014.
       
       ENVIRONMENT DIVISION. 
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT STUDENT-FILE
               ASSIGN TO "C:\STUFILE.DAT"
                   ORGANIZATION IS LINE SEQUENTIAL.
           SELECT STUDENT-REPORT
               ASSIGN TO "C:\STURPT.DAT"
                   ORGANIZATION IS LINE SEQUENTIAL.

       DATA DIVISION.
       FILE SECTION.
      * STUDENT-FILE is the input file
       FD STUDENT-FILE.
       01 STUDENT-RECORD.
           05 STUDENT-FIRST-NAME    PIC X(20).
           05 STUDENT-LAST-NAME     PIC X(20).
           05 STUDENT-NUMBER        PIC 9(9).
           05 STUDENT-PROGRAM       PIC X(3).
           05 COURSE-1              PIC X(7).
           05 MARK-1                PIC 9(3).
           05 COURSE-2              PIC X(7).
           05 MARK-2                PIC 9(3).
           05 COURSE-3              PIC X(7).
           05 MARK-3                PIC 9(3).
           05 COURSE-4              PIC X(7).
           05 MARK-4                PIC 9(3).
           
      * STUDENT-REPORT is the output file
       FD STUDENT-REPORT.
       01 STUDENT-REPORT-CARD       PIC X(63).
    
       WORKING-STORAGE SECTION.
      * Local copy of the student record
       01 STUDENT-REPORT-WS.       
           05 FILLER                   PIC X(2).
           05 STUDENT-LAST-NAME-WS     PIC X(20).
           05 FILLER                   PIC X(2).
           05 STUDENT-FIRST-NAME-WS    PIC X(20).
           05 FILLER                   PIC X(2).
           05 STUDENT-PROGRAM-WS       PIC X(3).
           05 FILLER                   PIC X(5).
           05 STUDENT-AVERAGE-WS       PIC 9(3).
           05 FILLER                   PIC X(5).
           05 STUDENT-GRADE-WS         PIC X.
           
      * Counters to keep tracks of records entered
      * and written
       01 COUNTERS.
           05 FILLER            PIC X(14)   VALUE "RECORDS READ: ".
           05 RECORDS-IN-CTR    PIC 9(3).
           05 FILLER            PIC X(18)   VALUE " RECORDS WRITTEN: ".
           05 RECORDS-OUT-CTR   PIC 9(3).
       
      * EOF-FLAG will be used to determine if input
      * file has reached end-of-file and TOTAL-MARK
      * will hold student's total mark.
       01 FLAGS-AND-CONTROLS.
           05 EOF-FLAG             PIC X       VALUE "N".
           05 TOTAL-MARK           PIC 9(3)    VALUE ZERO.
           05 STUDENT-AVERAGE      PIC 9(3)    VALUE ZERO.
           05 STUDENT-GRADE        PIC X.

      * Headers to be displayed at top of output
       01 COLUMN-HEADER.
           05 FILLER               PIC X(2)    VALUE SPACES.
           05 STUDENT-FULL-NAME    PIC X(12)   VALUE "STUDENT NAME".
           05 FILLER               PIC X(28)   VALUE SPACES.
           05 PROGRAM-NUM          PIC X(7)    VALUE "PROGRAM".
           05 FILLER               PIC X       VALUE SPACES.
           05 AVG                  PIC X(7)    VALUE "AVERAGE".
           05 FILLER               PIC X       VALUE SPACES.
           05 GRADE                PIC X(5)    VALUE "GRADE".
           
       PROCEDURE DIVISION.
      * Mainline routine
       100-CREATE-STUDENT-RECORD.
           PERFORM 200-INIT-CREATE-STUDENT-REPORT.
           PERFORM 200-CREATE-STUDENT-RECORD
               UNTIL EOF-FLAG = "Y".
           PERFORM 200-TERM-CREATE-STUDENT-REPORT.
           STOP RUN.
       
       200-INIT-CREATE-STUDENT-REPORT.
           PERFORM 700-OPEN-STUDENT-FILES.
           PERFORM 700-READ-STUDENT-RECORD.
           PERFORM 700-INIT-READ-WRITE-CTRS.
           PERFORM 700-WRITE-HEADINGS.

       200-CREATE-STUDENT-RECORD.
           PERFORM 700-CALCULATE-AVERAGE.
           PERFORM 700-DETERMINE-GRADE.
           PERFORM 700-WRITE-STUDENT-RECORD.
           PERFORM 700-READ-STUDENT-RECORD.

       200-TERM-CREATE-STUDENT-REPORT.
           PERFORM 700-WRITE-AUDIT-COUNTERS.
           PERFORM 700-CLOSE-STUDENT-FILE.

       700-OPEN-STUDENT-FILES.
           OPEN INPUT  STUDENT-FILE.
           OPEN OUTPUT STUDENT-REPORT.

       700-INIT-READ-WRITE-CTRS.
           INITIALIZE  RECORDS-IN-CTR
                       RECORDS-OUT-CTR.
                       
       700-WRITE-HEADINGS.
           WRITE STUDENT-REPORT-CARD FROM COLUMN-HEADER.
           
       700-READ-STUDENT-RECORD.
           READ  STUDENT-FILE
               AT END  MOVE "Y" TO EOF-FLAG ADD 1 TO RECORDS-IN-CTR
                   NOT AT END
                   ADD  1  TO RECORDS-IN-CTR.
                   
       700-CALCULATE-AVERAGE.
           ADD MARK-1 MARK-2 MARK-3 MARK-4 GIVING TOTAL-MARK.
           DIVIDE TOTAL-MARK BY 4
               GIVING STUDENT-AVERAGE ROUNDED.

       700-DETERMINE-GRADE.
           IF STUDENT-AVERAGE >= 85 AND <= 100
               MOVE "A" TO STUDENT-GRADE.
           IF STUDENT-AVERAGE >= 75 AND <= 84
               MOVE "B" TO STUDENT-GRADE.
           IF STUDENT-AVERAGE >= 65 AND <= 74
               MOVE "C" TO STUDENT-GRADE.
           IF STUDENT-AVERAGE >= 50 AND <= 64
               MOVE "D" TO STUDENT-GRADE.
           IF STUDENT-AVERAGE < 50
               MOVE "F" TO STUDENT-GRADE.

       700-WRITE-STUDENT-RECORD.
           MOVE    STUDENT-LAST-NAME    TO     STUDENT-LAST-NAME-WS.
           MOVE    STUDENT-FIRST-NAME   TO     STUDENT-FIRST-NAME-WS.
           MOVE    STUDENT-PROGRAM      TO     STUDENT-PROGRAM-WS.
           MOVE    STUDENT-AVERAGE      TO     STUDENT-AVERAGE-WS.
           MOVE    STUDENT-GRADE        TO     STUDENT-GRADE-WS.
           WRITE   STUDENT-REPORT-CARD  FROM   STUDENT-REPORT-WS.
           ADD  1  TO RECORDS-OUT-CTR.

       700-WRITE-AUDIT-COUNTERS.
            WRITE STUDENT-REPORT-CARD FROM COUNTERS.

       700-CLOSE-STUDENT-FILE.
           CLOSE STUDENT-FILE
                 STUDENT-REPORT.