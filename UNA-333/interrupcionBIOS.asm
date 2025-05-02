.model small
.stack 100h

.data
.code
start:
    ; Inicializa el segmento de datos
    mov ax, @data
    mov ds, ax

    ; Leer un carácter del teclado
    mov ah, 01h ; Función 01h para leer un carácter
    int 21h ; Llamar a la interrupción 21h (teclado)

    ; El carácter leído está en AL, mostrarlo en la pantalla
    mov ah, 0Eh ; Función 0Eh para mostrar un carácter
    int 10h ; Llamar a la interrupción 10h (video)

    ; Termina el programa
    mov ax, 4C00h ; Código de salida
    int 21h ; Interrupción de DOS para salir

end start
