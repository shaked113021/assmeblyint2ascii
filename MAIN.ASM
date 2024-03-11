.MODEL SMALL

EXTRN INT2ASCII:PROC
EXTRN ASCII2INT:PROC
EXTRN READLN:PROC

.STACK 100H

.DATA
ENDLINE DB 0DH, 0AH, '$'
BUFF DB 5 DUP (1)
BUFF2 DB 50 DUP(?)
MSG1 DB 'Enter first num: $'
MSG2 DB 'Enter second num: $'
MSGRES DB 'Result is: $'
NUM1 DB ?

.CODE
ASSUME DS:@DATA

@STARTUP:
        ; Initialize data segment
        MOV AX, @DATA
        MOV DS, AX

       ; Read num1
       LEA DX, MSG1
       MOV AH, 9H
       INT 21H

       LEA DX, BUFF2
       CALL READLN
       ; convert buff2 to int
       CALL ASCII2INT
       MOV NUM1, AL

       ; read num2
       LEA DX, MSG2
       MOV AH, 9H
       INT 21H

       LEA DX, BUFF2
       CALL READLN
       CALL ASCII2INT

       ; calculate num1 + num2
       MOV BL, NUM1
       ADD AL, BL

       ; RESULT convert to ascii
       LEA DX, BUFF
       CALL INT2ASCII

       ; print result
       LEA DX, MSGRES
       MOV AH, 9H
       INT 21H

       LEA DX, BUFF
       MOV AH, 9H
       INT 21H

        ; Exit program
        MOV AH, 4CH
        INT 21H
END @STARTUP
