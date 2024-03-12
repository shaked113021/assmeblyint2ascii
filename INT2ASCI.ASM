.MODEL SMALL

PUBLIC INT2ASCII

.DATA


.CODE
; Parameters:
; DX - buffer for string, expects a size of 5 bytes
; AL - number to convert
; saves register state
INT2ASCII PROC

        PUSH AX
        PUSH BX
        PUSH DI

        ; Zero out array
        XOR DI, DI
        MOV BX, DX
CLEAR_LOOP:
        MOV BYTE PTR [BX+DI], 0
        INC DI
        CMP DI, 5
        JL CLEAR_LOOP

        ; Initialize index for writing into the array
        XOR DI, DI ; zero out index
        MOV BL, '$'
        PUSH BX
        
        CMP AL, 0
        JNS EXTRACT_DIGIT_LOOP
        ; if negative, change sign and add minus to output string
        NEG AL
        MOV BX, DX
        MOV BYTE PTR [BX], '-'
        INC DI

; Push digits one by one to the stack
EXTRACT_DIGIT_LOOP:
        XOR AH, AH ; make sure we only divide al
        MOV BL, 10
        DIV BL
        MOV BL, AH
        ADD BL, '0' ; convert to ascii
        PUSH BX
        CMP AL, 0
        JNE EXTRACT_DIGIT_LOOP

        MOV BX, DX
POP_DIGITS_LOOP:
        POP AX        
        MOV BYTE PTR [BX+DI], AL
        INC DI
        CMP AL, '$'
        JNE POP_DIGITS_LOOP

        POP DI
        POP BX
        POP AX

        RET

INT2ASCII ENDP
END
