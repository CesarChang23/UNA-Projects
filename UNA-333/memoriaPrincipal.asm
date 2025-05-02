.model small
.stack 100h

.data
    num1 db 5 ; Primer número a sumar
    num2 db 3 ; Segundo número a sumar
    resultado db ? ; Variable para almacenar el resultado

.code
start:
    ; Inicializa el segmento de datos
    mov ax, @data
    mov ds, ax

    ; Cargar los números en registros
    mov al, num1 ; Mover num1 a AL
    add al, num2 ; Sumar num2 a AL
    mov resultado, al ; Almacenar el resultado

    ; Mostrar el resultado en pantalla
    mov ah, 0Eh ; Función para mostrar un carácter en la pantalla
    mov bl, resultado ; Mover el resultado a BL para convertir a carácter
    add bl, '0' ; Convertir el número a carácter ASCII
    int 10h ; Llamar a la interrupción de video para mostrar el carácter

    ; Termina el programa
    mov ax, 4C00h ; Código de salida
    int 21h ; Interrupción de DOS para salir

end start
