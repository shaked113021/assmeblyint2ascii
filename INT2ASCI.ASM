.MODEL SMALL

PUBLIC INT2ASCII

.DATA


.CODE
; Parameters:
; DX - buffer for string, expects a size of 5 bytes
; AL - number to convert
; saves register state
INT2ASCII PROC
        LOCAL isNeg: BYTE
        PUSH DX
        PUSH AX
        PUSH CX
        PUSH DI
        PUSH BX

        MOV BL, 0H
        MOV isNeg, BL

        ; Clear buffer
        XOR DI, DI
        MOV BX, DX
CLEAR_LOOP:

        MOV BYTE PTR [BX+DI], 0
        INC DI
        CMP DI, 5; SIZE OF BUFFER
        JL CLEAR_LOOP

        MOV BL, '$' ; stop flag
        PUSH BX        

        ; Check if number is negative
        XOR CL, CL
        CMP AL, 0
        JNS CONVERT_LOOP
        ; if negative, make al 2s complement and set isNeg to true
        DEC AL
        NOT AL
        MOV BL, 1
        MOV isNeg, BL

CONVERT_LOOP:
        CMP AL, 10
        JL LOOP_END_INNER
        SUB AL, 10
        INC CL
        JMP CONVERT_LOOP


LOOP_END_INNER:
        ; push digit to stack
        MOV BL, AL
        ADD BL, '0'
        PUSH BX

        CMP CL, 10
        JL LOOP_END_OUTER
        MOV AL, CL ; set next exp to current exp
        XOR CL, CL ; zero next_exp counter
        JMP CONVERT_LOOP

LOOP_END_OUTER:
        ; push last digit to stack
        CMP CL, 0
        JE LAST_DIGIT_ZERO
        MOV BL, CL
        ADD BL, '0'
        PUSH BX

LAST_DIGIT_ZERO:
        ; ADD MINUS SIGN if needed
        MOV BL, isNeg
        CMP BL, 0
        JE POP_DIGITS_INIT
        ; if number was negative, add minus sign
        MOV BL, '-' ; add minus sign
        PUSH BX


POP_DIGITS_INIT:
        XOR DI, DI; zero out index register
        MOV BX, DX
POP_DIGITS_LOOP:
        POP AX
        MOV BYTE PTR [BX+DI], AL ; set char to digit
        INC DI
        CMP AL, '$'
        JNE POP_DIGITS_LOOP

        POP BX
        POP DI
        POP CX
        POP AX
        POP DX

        RET

INT2ASCII ENDP
END
