.MODEL SMALL

EXTRN INT2ASCII:PROC

.STACK 100H

.DATA
NUM DB -1
ENDLINE DB 0DH, 0AH, '$'
BUFF DB 5 DUP (1)


.CODE
ASSUME DS:@DATA

@STARTUP:
        ; Initialize data segment
        MOV AX, @DATA
        MOV DS, AX

        ; call INT2ASCII with dx = buff and al=num
        LEA DX, BUFF
        MOV AL, NUM
        CALL INT2ASCII

        ; print num string
        MOV AH, 9H
        LEA DX, BUFF
        INT 21H

        ; print endline
        MOV AH, 9H
        LEA DX, ENDLINE
        INT 21H

        ; Exit program
        MOV AH, 4CH
        INT 21H
END @STARTUP
