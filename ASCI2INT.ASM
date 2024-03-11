.MODEL SMALL

PUBLIC ASCII2INT

.DATA

.CODE


; Converts ascii string to int
; DX - string terminated with $
; 
; returns:
; al - converted int
ASCII2INT PROC
        PUSH BX
        PUSH DI
        PUSH CX
                        
        ; signal end with $
        MOV BL, '$'
        PUSH BX

        XOR DI, DI
        MOV BX, DX
PUSH_LOOP:
        MOV AL, BYTE PTR [BX+DI]
        CMP AL, '$'
        JE POP_LOOP_INIT
        PUSH AX
        INC DI
        JMP PUSH_LOOP

POP_LOOP_INIT:
        MOV CL, 1H ; multiplier for pop loop
        XOR AL, AL
POP_LOOP:
        POP BX
        CMP BL, '-'
        JE HANDLE_MINUS
        CMP BL, '$'
        JE PROC_END
        SUB BL, '0'
        MOV CH, AL  ; store current number
        MOV AL, BL
        MUL CL ; multiply by multiplier
        ADD CH, AL
        MOV AL, CH
        
        ; multiply multiplier by 10
        PUSH AX ; store result
        MOV AL, 10
        MUL CL
        MOV CL, AL
        POP AX
        XOR AH, AH ; zero out high byte
        JMP POP_LOOP


HANDLE_MINUS:
       NEG AL
       POP BX

PROC_END:
        POP CX
        POP DI
        POP BX

        RET

ASCII2INT ENDP
END
