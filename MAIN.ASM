.MODEL SMALL

EXTRN INT2ASCII:PROC
EXTRN ASCII2INT:PROC

.STACK 100H

.DATA
NUM DB 0
ENDLINE DB 0DH, 0AH, '$'
MSG DB 'Key Recieved: $'
BUFF DB 5 DUP (1)
NUMST DB '100$'


.CODE
ASSUME DS:@DATA

@STARTUP:
        ; Initialize data segment
        MOV AX, @DATA
        MOV DS, AX

        ; call INT2ASCII with dx = buff and al=num
       ; LEA DX, BUFF
       ; MOV AL, NUM
       ; CALL INT2ASCII

        ; print num string
       ; MOV AH, 9H
       ;  LEA DX, BUFF
       ; INT 21H

        ; print endline
       ; MOV AH, 9H
       ; LEA DX, ENDLINE
       ; INT 21H

       ; CONVERTING NUMST TO INT
       LEA DX, NUMST
       CALL ASCII2INT

       ; converting buff to string
       LEA DX, BUFF
       CALL INT2ASCII

       ; printing buff
       MOV AH, 9H
       INT 21H

       LEA DX, ENDLINE
       MOV AH, 9H
       INT 21H



        ; Exit program
        MOV AH, 4CH
        INT 21H
END @STARTUP
