.MODEL SMALL
.STACK 100H

.DATA
    matriz1 DB 1, 2, 3, 4, 5, 6, 7, 8, 9      ; Matriz 3x3 linealizada
    matriz2 DB 9, 8, 7, 6, 5, 4, 3, 2, 1      ; Matriz 3x3 linealizada
    resultado DB 9 DUP(0)                      ; Matriz resultado
    
    ; Mensajes compactos
    mensajes DB 'Suma de Matrices 3x3', 13, 10
             DB 'Matriz 1:', 13, 10, '$'
    msg_mat2 DB 'Matriz 2:', 13, 10, '$'
    msg_res  DB 'Resultado:', 13, 10, '$'
    espacio DB ' $'
    salto DB 13, 10, '$'

.CODE
START:
    MOV AX, @DATA
    MOV DS, AX
    
    ; Mostrar título y matriz 1
    LEA DX, mensajes
    MOV AH, 09H
    INT 21H
    LEA SI, matriz1
    CALL MOSTRAR_MATRIZ
    
    ; Mostrar matriz 2
    LEA DX, msg_mat2
    MOV AH, 09H
    INT 21H
    LEA SI, matriz2
    CALL MOSTRAR_MATRIZ
    
    ; Sumar matrices
    CALL SUMAR_MATRICES
    
    ; Mostrar resultado
    LEA DX, msg_res
    MOV AH, 09H
    INT 21H
    LEA SI, resultado
    CALL MOSTRAR_MATRIZ_DOS_DIGITOS
    
    MOV AH, 4CH
    INT 21H

; ---------------------------------------------------------------
; Procedimiento optimizado para sumar matrices
; ---------------------------------------------------------------
SUMAR_MATRICES PROC NEAR
    MOV CX, 9
    XOR SI, SI                 ; Más eficiente que MOV SI, 0
    
SUMA_LOOP:
    MOV AL, matriz1[SI]
    ADD AL, matriz2[SI]
    MOV resultado[SI], AL
    INC SI
    LOOP SUMA_LOOP
    RET
SUMAR_MATRICES ENDP

; ---------------------------------------------------------------
; Procedimiento único para mostrar matrices de un dígito
; Entrada: SI = dirección de la matriz
; ---------------------------------------------------------------
MOSTRAR_MATRIZ PROC NEAR
    MOV CX, 3                  ; 3 filas
    
FILA_LOOP:
    PUSH CX
    MOV CX, 3                  ; 3 columnas
    
COLUMNA_LOOP:
    MOV DL, [SI]
    ADD DL, '0'
    MOV AH, 02H
    INT 21H
    
    LEA DX, espacio
    MOV AH, 09H
    INT 21H
    
    INC SI
    LOOP COLUMNA_LOOP
    
    LEA DX, salto
    MOV AH, 09H
    INT 21H
    
    POP CX
    LOOP FILA_LOOP
    RET
MOSTRAR_MATRIZ ENDP

; ---------------------------------------------------------------
; Procedimiento optimizado para mostrar matrices con dos dígitos
; Entrada: SI = dirección de la matriz
; ---------------------------------------------------------------
MOSTRAR_MATRIZ_DOS_DIGITOS PROC NEAR
    MOV CX, 3                  ; 3 filas
    
FILA_LOOP2:
    PUSH CX
    MOV CX, 3                  ; 3 columnas
    
COLUMNA_LOOP2:
    MOV AL, [SI]
    XOR AH, AH                 ; Más eficiente que MOV AH, 0
    MOV BL, 10
    DIV BL
    
    PUSH AX                    ; Guardar unidades
    
    ; Mostrar decenas solo si existen
    TEST AL, AL
    JZ MOSTRAR_UNIDAD
    ADD AL, '0'
    MOV DL, AL
    MOV AH, 02H
    INT 21H
    
MOSTRAR_UNIDAD:
    POP AX
    MOV DL, AH
    ADD DL, '0'
    MOV AH, 02H
    INT 21H
    
    LEA DX, espacio
    MOV AH, 09H
    INT 21H
    
    INC SI
    LOOP COLUMNA_LOOP2
    
    LEA DX, salto
    MOV AH, 09H
    INT 21H
    
    POP CX
    LOOP FILA_LOOP2
    RET
MOSTRAR_MATRIZ_DOS_DIGITOS ENDP

END START