.model small
.stack 100h

.data
    mensaje db 'Hola desde la ROM!$'  ; Mensaje almacenado en la sección de datos (ROM)
    numero db 10 ; Valor inicial en RAM
    resultado db ? ; Variable para almacenar el resultado

.code
start:
    ; Inicializa el segmento de datos
    mov ax, @data
    mov ds, ax

    ; Mostrar mensaje desde "ROM"
    mov dx, offset mensaje ; Cargar la dirección del mensaje en DX
    mov ah, 09h ; Función para imprimir cadena en DOS
    int 21h ; Llamar a la interrupción para imprimir

    ; Cargar un número desde RAM, incrementarlo y almacenar el resultado en RAM
    mov al, numero ; Cargar el valor desde RAM en AL
    inc al ; Incrementar el valor
    mov resultado, al ; Almacenar el resultado de vuelta en RAM

    ; Termina el programa
    mov ax, 4C00h ; Código de salida
    int 21h ; Interrupción de DOS para salir

end start
