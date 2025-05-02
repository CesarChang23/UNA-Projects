.model small
.stack 100h

.data
    num1 db 10 ; Primer número
    num2 db 5 ; Segundo número
    suma db ? ; Variable para almacenar el resultado de la suma
    producto db ? ; Variable para almacenar el resultado del producto

.code
start:
    ; Inicializa el segmento de datos
    mov ax, @data
    mov ds, ax

    ; Cargar números en registros
    mov al, num1 ; Cargar el primer número en AL
    mov bl, num2 ; Cargar el segundo número en BL

    ; Operación de suma
    add al, bl ; AL = AL + BL (suma)
    mov suma, al ; Almacenar el resultado de la suma en 'suma'

    ; Reiniciar AL para la multiplicación
    mov al, num1 ; Cargar el primer número de nuevo en AL
    mov bl, num2 ; Cargar el segundo número en BL

    ; Operación de multiplicación
    mul bl ; AL = AL * BL (multiplicación)
    mov producto, al ; Almacenar el resultado del producto en 'producto'
    ; Termina el programa
    mov ax, 4C00h ; Código de salida
    int 21h ; Interrupción de DOS para salir

end start
