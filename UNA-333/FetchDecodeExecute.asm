; fetch

mov ax, 5 ; Instrucción a capturar

; decode - execute

.model small
.stack 100h

.data
    valor1 db 5 ; Primer valor
    valor2 db 2 ; Segundo valor
    resultado db ? ; Variable para almacenar resultado

.code
start:
    mov ax, @data ; Inicializa el segmento de datos
    mov ds, ax ; Carga DS

    mov al, valor1 ; Fetch: Cargar valor1 en AL
    add al, valor2 ; Fetch: Añadir valor2 a AL
    mov resultado, al ; Almacenar resultado

    mov ax, 4C00h ; Código de salida
    int 21h ; Interrupción de DOS para salir

end start
