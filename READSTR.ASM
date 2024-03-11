.MODEL SMALL

PUBLIC READLN

.DATA
USERSTR DB 50, 51 DUP (?)
ENDLINE DB 0DH, 0AH, '$'
.CODE
ASSUME ES:@DATA

; Parameters
; DX - Read buffer, should be 50 

READLN PROC
        PUSH DX
        PUSH AX
        PUSH BX
        PUSH BP
        PUSH ES
        PUSH DI

        MOV AX, @DATA
        MOV ES, AX

        MOV BX, DX
        
        ; Read string from stdin
        LEA DX, ES:USERSTR
        MOV AH, 0AH
        INT 21H

        ; Copy to given buffer
        XOR DI, DI ; zero index
        LEA BP, ES:USERSTR
        XOR CH, CH
        MOV CL, BYTE PTR [ES:USERSTR+1] ; Copy length of input to CL
        CMP CL, 0
        JZ AFTER_LOOP
        ADD BP, 2 ; move bp to first char
COPY_LOOP: 
        MOV AL, BYTE PTR ES:[BP+DI]
        MOV BYTE PTR DS:[BX+DI], AL
        INC DI
        
        ; if di < cl -> goto copy_loop
        CMP DI, CX
        JL COPY_LOOP
AFTER_LOOP:
        MOV BYTE PTR DS:[BX+DI], '$' ; Terminate string

        ; print new line
        LEA DX, ES:ENDLINE
        MOV AH, 9H
        INT 21H

        POP DI
        POP ES
        POP BP
        POP BX
        POP AX
        POP DX
        RET

READLN ENDP
END
