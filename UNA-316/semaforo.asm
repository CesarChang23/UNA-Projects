.model small
.stack 100h

.data
    ; Variables de control
    estado db 'R'           ; Estado actual del semáforo ('R'=Rojo, 'A'=Amarillo, 'V'=Verde)
    boton_presionado db 0   ; Bandera para saber si el botón fue presionado
    tiempo_restante dw 0    ; Tiempo restante en el estado actual
    
    ; Duración de cada estado en segundos
    tiempo_verde dw 30
    tiempo_amarillo dw 5
    tiempo_rojo dw 35
    
    ; Códigos de color para el texto
    COLOR_ROJO db 0Ch
    COLOR_AMARILLO db 0Eh
    COLOR_VERDE db 0Ah
    COLOR_BLANCO db 0Fh
    
    ; Mensajes que se imprimen en pantalla
    msg_vehiculo db "SEMAFORO VEHICULAR: $"
    msg_peaton db "SEMAFORO PEATONAL: $"
    msg_boton db 13,10,"Boton presionado! Prioridad peatonal",13,10,'$'
    msg_tiempo db "Tiempo restante: $"
    msg_instruccion db "Presione ESPACIO para solicitar cruce",13,10,'$'
    
    ; Carácter para representar la "luz" del semáforo
    char_luz db 254

.code
main proc
    ; Inicializar DS
    mov ax, @data
    mov ds, ax
    
    ; Limpiar pantalla y mostrar instrucciones
    call limpiar_pantalla
    mov dx, offset msg_instruccion
    call imprimir_mensaje
    
    ; Inicializar semáforo (empieza en rojo)
    call inicializar_semaforo

    ; Inicio del ciclo principal
    ciclo_principal:
        ; Verificar si se presionó una tecla
        mov ah, 1
        int 16h
        jz no_boton_presionado  ; Si no hay tecla, saltar
        
        ; Leer la tecla
        mov ah, 0
        int 16h
        cmp al, 32              ; Verifica si fue espacio (ASCII 32)
        jne no_boton_presionado
        
        ; Si se presionó espacio, marcar el botón como presionado
        mov boton_presionado, 1
        mov dx, offset msg_boton
        call imprimir_mensaje
        
        no_boton_presionado:
        ; Actualizar semáforo en pantalla
        call actualizar_display
        ; Esperar 1 segundo
        call delay_1seg
        ; Reducir el tiempo restante
        dec tiempo_restante
        ; Si todavía queda tiempo, repetir
        jnz ciclo_principal
        
        ; Si tiempo terminó, cambiar de estado
        call cambiar_estado
        jmp ciclo_principal
    
    ; Finalizar programa
    mov ax, 4C00h
    int 21h
main endp

; Inicializa el semáforo en rojo
inicializar_semaforo proc
    mov estado, 'R'
    mov ax, tiempo_rojo
    mov tiempo_restante, ax
    ret
inicializar_semaforo endp

; Actualiza la pantalla mostrando el estado del semáforo
actualizar_display proc
    call limpiar_pantalla
    
    ; Mostrar mensaje de instrucción
    mov dx, offset msg_instruccion
    call imprimir_mensaje
    
    ; Mostrar estado vehicular
    mov dx, offset msg_vehiculo
    call imprimir_mensaje
    
    ; Dependiendo del estado, encender el color correspondiente para vehículos
    cmp estado, 'R'
    je mostrar_rojo_vehiculo
    cmp estado, 'A'
    je mostrar_amarillo_vehiculo
    jmp mostrar_verde_vehiculo
    
    mostrar_rojo_vehiculo:
        mov dl, COLOR_ROJO
        call set_color
        mov dl, char_luz
        call imprimir_caracter
        jmp mostrar_peaton
    
    mostrar_amarillo_vehiculo:
        mov dl, COLOR_AMARILLO
        call set_color
        mov dl, char_luz
        call imprimir_caracter
        jmp mostrar_peaton
    
    mostrar_verde_vehiculo:
        mov dl, COLOR_VERDE
        call set_color
        mov dl, char_luz
        call imprimir_caracter
    
    mostrar_peaton:
        ; Resetear a color blanco
        mov dl, COLOR_BLANCO
        call set_color
        ; Imprimir nueva línea
        call nueva_linea
        ; Mostrar estado peatonal
        mov dx, offset msg_peaton
        call imprimir_mensaje
        
        ; Semáforo peatonal depende del estado vehicular
        cmp estado, 'R'
        je mostrar_verde_peaton
        jmp mostrar_rojo_peaton
    
    mostrar_verde_peaton:
        mov dl, COLOR_VERDE
        call set_color
        mov dl, char_luz
        call imprimir_caracter
        jmp mostrar_tiempo
    
    mostrar_rojo_peaton:
        mov dl, COLOR_ROJO
        call set_color
        mov dl, char_luz
        call imprimir_caracter
    
    mostrar_tiempo:
        ; Volver a color blanco
        mov dl, COLOR_BLANCO
        call set_color
        ; Nueva línea
        call nueva_linea
        ; Mostrar tiempo restante
        mov dx, offset msg_tiempo
        call imprimir_mensaje
        ; Imprimir número de segundos
        mov ax, tiempo_restante
        call imprimir_numero
        ret
actualizar_display endp

; Cambia el estado del semáforo
cambiar_estado proc
    cmp estado, 'R'
    je cambiar_a_verde
    cmp estado, 'A'
    je cambiar_a_rojo
    jmp cambiar_a_amarillo
    
    cambiar_a_verde:
        ; Si se presionó el botón, acorta el verde a 3 segundos
        cmp boton_presionado, 1
        jne continuar_verde
        mov tiempo_restante, 3
        mov boton_presionado, 0
        ret
        
        continuar_verde:
        mov estado, 'V'
        mov ax, tiempo_verde
        mov tiempo_restante, ax
        ret
    
    cambiar_a_amarillo:
        mov estado, 'A'
        mov ax, tiempo_amarillo
        mov tiempo_restante, ax
        ret
    
    cambiar_a_rojo:
        mov estado, 'R'
        mov ax, tiempo_rojo
        mov tiempo_restante, ax
        ret
cambiar_estado endp

; ========== UTILIDADES ==========

; Imprimir un mensaje que apunta DX
imprimir_mensaje proc
    push ax
    mov ah, 9
    int 21h
    pop ax
    ret
imprimir_mensaje endp

; Imprimir un solo caracter contenido en DL
imprimir_caracter proc
    push ax
    mov ah, 2
    int 21h
    pop ax
    ret
imprimir_caracter endp

; Cambiar el color del texto
set_color proc
    ; DL tiene el color
    push ax
    push bx
    push cx
    mov ah, 09h
    mov al, ' '    ; Imprimir un espacio en color deseado
    mov bh, 0
    mov bl, dl
    mov cx, 1
    int 10h
    pop cx
    pop bx
    pop ax
    ret
set_color endp

; Imprimir número en AX (asume dos dígitos)
imprimir_numero proc
    push ax
    push bx
    push dx
    
    mov bl, 10
    div bl          ; AX / 10 -> AL=cociente, AH=resto
    push ax
    mov dl, al
    add dl, '0'     ; Convertir a carácter
    mov ah, 2
    int 21h
    pop ax
    mov dl, ah
    add dl, '0'     ; Convertir a carácter
    mov ah, 2
    int 21h
    
    pop dx
    pop bx
    pop ax
    ret
imprimir_numero endp

; Saltar a nueva línea (carriage return + line feed)
nueva_linea proc
    push dx
    push ax
    mov dl, 13
    mov ah, 2
    int 21h
    mov dl, 10
    int 21h
    pop ax
    pop dx
    ret
nueva_linea endp

; Limpiar la pantalla (modo texto)
limpiar_pantalla proc
    push ax
    mov ax, 3
    int 10h
    pop ax
    ret
limpiar_pantalla endp

; Retardo aproximado de 1 segundo
delay_1seg proc
    push cx
    push dx
    mov cx, 0Fh
    delay_loop:
        mov dx, 0FFFFh
        delay_inner:
            dec dx
            jnz delay_inner
        loop delay_loop
    pop dx
    pop cx
    ret
delay_1seg endp

end main
