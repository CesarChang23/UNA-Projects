.model small
.stack 100h

.data
    valor db 5 ; Variable en memoria (RAM)
    resultado db ? ; Variable para almacenar resultado

.code
start:
    ; Inicializa el segmento de datos
    mov ax, @data
    mov ds, ax

    ; Cargar valor de la memoria (RAM) en el registro AL
    mov al, valor ; Mover el contenido de 'valor' a AL

    ; Realizar una operación (incrementar el valor)
    inc al ; Incrementar el valor en AL

    ; Almacenar el resultado de vuelta en la memoria
    mov resultado, al ; Mover el contenido de AL a 'resultado'

    ; Termina el programa
    mov ax, 4C00h ; Código de salida
    int 21h ; Interrupción de DOS para salir

end start
