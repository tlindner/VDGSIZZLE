10 CLEAR 200,24576
15 A = PEEK(65534)*256+PEEK(65535)
16 IF A = 35867 THEN RGB
20 CLS
30 LOADM "SIZZLE/BIN"
40 PRINT "COCO VDG EXTRA SIZZLER"
50 PRINT "QUICKLY GO THRU ALL VIDEO MODES"
60 PRINT
70 PRINT "  V2 <1>"
80 PRINT "  V1 <2>"
90 PRINT "  V0 <3>"
100 PRINT "  *A/G <4>"
110 PRINT "  GM2 <5>"
120 PRINT "  GM1 <6>"
130 PRINT "  GM0 & *INT/EXT <7>"
140 PRINT "  CSS <8>"
150 PRINT
160 PRINT "<G> VIEW ALL COMBINATIONS"
170 PRINT "USE NUMBERS TOGGLE BIT"
180 PRINT "<T> TOGGLE VIEW NOW"
190 POKE 65344,0 : REM TURN OFF FLOPPY
200 EXEC
210 END
220 REM BY TIM LINDNER
230 REM AUGUST, 2024
240 REM GITHUB.COM/TLINDNER/VDGSIZZLE