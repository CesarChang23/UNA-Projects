.model small
.stack 100h

.data
    num1 db 0Fh ; Primer número (15 en decimal)
    num2 db 03h ; Segundo número (3 en decimal)
    suma db ? ; Variable para almacenar la suma
    resta db ?  ; Variable para almacenar la resta
    producto db ? ; Variable para almacenar el producto
    cociente db ? ; Variable para almacenar el cociente
    and_result db ? ; Resultado de AND
    or_result db ? ; Resultado de OR
    xor_result db ? ; Resultado de XOR
    not_result db ? ; Resultado de NOT
    buffer db 5 dup(0) ; Buffer para mostrar resultados

.code
start:
    mov ax, @data ; Inicializa el segmento de datos
    mov ds, ax

    ; Operaciones Aritméticas
    ; Suma
    mov al, num1 ; Carga num1 en AL
    add al, num2 ; Suma num2 a AL
    mov suma, al ; Almacena el resultado en suma



    ; Resta
    mov al, num1 ; Carga num1 en AL
    sub al, num2 ; Resta num2 de AL
    mov resta, al ; Almacena el resultado en resta
   
 ; Multiplicación (num1 * num2)
    mov al, num1 ; Carga num1 en AL
    mov bl, num2 ; Carga num2 en BL
    mul bl ; Multiplica AL por BL (resultado en AX)
    mov producto, al ; Almacena el resultado (8 bits)

    ; División (num1 / num2)
    mov al, num1 ; Carga num1 en AL
    mov bl, num2 ; Carga num2 en BL
    xor ah, ah ; Limpia AH para la división
    div bl ; Divide AX entre BL (cociente en AL, resto en AH)
    mov cociente, al ; Almacena el cociente

    ; Operaciones Lógicas
    ; AND
    mov al, num1 ; Carga num1 en AL
    and al, num2 ; Realiza AND con num2
    mov and_result, al ; Almacena el resultado

    ; OR
    mov al, num1 ; Carga num1 en AL
    or al, num2 ; Realiza OR con num2
    mov or_result, al ; Almacena el resultado

    ; XOR
    mov al, num1 ; Carga num1 en AL
    xor al, num2 ; Realiza XOR con num2
    mov xor_result, al ; Almacena el resultado
    ; NOT
    mov al, num1 ; Carga num1 en AL
    not al ; Realiza NOT
    mov not_result, al ; Almacena el resultado
    ; Mostrar Resultados
    ; Suma
    mov al, suma ; Cargar el resultado de la suma
    call PrintResult

    ; Resta
    mov al, resta ; Cargar el resultado de la resta
    call PrintResult

    ; Producto
    mov al, producto ; Cargar el resultado del producto
    call PrintResult

    ; Cociente
    mov al, cociente ; Cargar el resultado del cociente
    call PrintResult

    ; AND
    mov al, and_result ; Cargar el resultado del AND
    call PrintResult

    ; OR
    mov al, or_result ; Cargar el resultado del OR
    call PrintResult

    ; XOR
    mov al, xor_result ; Cargar el resultado del XOR
    call PrintResult

    ; NOT
    mov al, not_result ; Cargar el resultado del NOT
    call PrintResult

    ; Finaliza el programa
    mov ax, 4C00h ; Código de salida
    int 21h ; Interrupción de DOS para salir

; Subrutina para imprimir el resultado
PrintResult:
    ; Convierte el valor de AL a una cadena en ASCII
    mov bx, 10 ; Divisor para conversión decimal
    xor cx, cx ; Limpia el contador

convert_loop:
    xor dx, dx ; Limpia DX antes de dividir
    div bx ; Divide AL por 10, cociente en AL, resto en DX
    push dx ; Almacena el resto en la pila
    inc cx ; Incrementa el contador
    test al, al ; Verifica si AL es cero
    jnz convert_loop ; Si no es cero, sigue convirtiendo

; Imprimir el resultado en la pantalla
print_loop:
    pop dx ; Recupera el valor del tope de la pila
    add dl, '0' ; Convierte el dígito a ASCII
    mov ah, 02h ; Función de impresión de carácter
    int 21h ; Interrupción de DOS

    ret
end start
