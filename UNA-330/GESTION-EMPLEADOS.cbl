       IDENTIFICATION DIVISION.  *> División de identificación del programa
       PROGRAM-ID. GESTION-EMPLEADOS.  *> Nombre del programa

       ENVIRONMENT DIVISION.  *> División de entorno
       INPUT-OUTPUT SECTION.  *> Sección de entrada/salida
       FILE-CONTROL.  *> Control de archivos
           SELECT EMPLEADOS-FILE ASSIGN TO "empleados.dat"  *> Asignación del archivo de empleados
               ORGANIZATION IS INDEXED  *> Organización indexada para acceso rápido
               ACCESS MODE IS DYNAMIC  *> Modo de acceso dinámico
               RECORD KEY IS EMP-ID  *> Clave del registro es el ID del empleado
               FILE STATUS IS EMP-STATUS.  *> Estado del archivo de empleados
           SELECT SALARIOS-FILE ASSIGN TO "salarios.dat"  *> Asignación del archivo de salarios
               ORGANIZATION IS INDEXED  *> Organización indexada
               ACCESS MODE IS DYNAMIC  *> Modo de acceso dinámico
               RECORD KEY IS SAL-ID  *> Clave del registro es el ID del salario
               FILE STATUS IS SAL-STATUS.  *> Estado del archivo de salarios
           SELECT DESBORDAMIENTO-FILE ASSIGN TO "desbordamiento.dat"  *> Asignación del archivo de desbordamiento
               ORGANIZATION IS LINE SEQUENTIAL  *> Organización secuencial
               FILE STATUS IS DESBORD-STATUS.  *> Estado del archivo de desbordamiento
           SELECT INFORME-FILE ASSIGN TO "informe.txt"
               ORGANIZATION IS LINE SEQUENTIAL
               FILE STATUS IS INF-STATUS.

       DATA DIVISION.  *> División de datos
       FILE SECTION.  *> Sección de archivos

       FD EMPLEADOS-FILE.  *> Definición del archivo de empleados
       01 EMPLEADOS-RECORD.  *> Registro de empleados
           05 EMP-ID  PIC 9(8).  *> Cédula del empleado (numérico de 8 dígitos)
           05 EMP-APELLIDO PIC X(20). *> Apellido del empleado (20 caracteres)
           05 EMP-NOMBRE PIC X(20). *> Nombre del empleado (20 caracteres)
           05 EMP-SEXO PIC X.     *> Sexo del empleado (1 carácter)
           05 EMP-TEL-FIJO PIC X(15). *> Teléfono fijo del empleado (15 caracteres)
           05 EMP-TEL-CELULAR PIC X(15). *> Teléfono celular del empleado (15 caracteres)
           05 EMP-CORREO  PIC X(30). *> Correo electrónico del empleado (30 caracteres)
           05 EMP-DIRECCION PIC X(50). *> Dirección del empleado (50 caracteres)
           05 EMP-CONTACTO PIC X(30). *> Contacto de emergencia del empleado (30 caracteres)

       FD SALARIOS-FILE.  *> Definición del archivo de salarios
       01 SALARIOS-RECORD.  *> Registro de salarios
           05 SAL-ID PIC 9(8).  *> Cédula del salario (numérico de 8 dígitos)
           05 SAL-FECHA-INGRESO PIC 9(8).  *> Fecha de ingreso del salario (numérico de 8 dígitos)
           05 SAL-SALARIO PIC 9(9)V99. *> Salario del empleado (numérico con 2 decimales)
           05 SAL-MONTO-SSO PIC 9(9)V99. *> Monto de seguro social (numérico con 2 decimales)
           05 SAL-MONTO-PRES PIC 9(9)V99. *> Monto de préstamo (numérico con 2 decimales)

       FD DESBORDAMIENTO-FILE.  *> Definición del archivo de desbordamiento
       01 DESBORDAMIENTO-RECORD.  *> Registro de desbordamiento
           05 DESB-ID PIC 9(8).  *> ID del registro de desbordamiento (numérico de 8 dígitos)
           05 DESB-APELLIDO PIC X(20). *> Apellido del empleado (desbordamiento) (20 caracteres)
           05 DESB-NOMBRE PIC X(20). *> Nombre del empleado (desbordamiento) (20 caracteres)
           05 DESB-SEXO PIC X.     *> Sexo del empleado (desbordamiento) (1 carácter)
           05 DESB-TEL-FIJO PIC X(15). *> Teléfono fijo del empleado (desbordamiento) (15 caracteres)
           05 DESB-TEL-CELULAR PIC X(15). *> Teléfono celular del empleado (desbordamiento) (15 caracteres)
           05 DESB-CORREO PIC X(30). *> Correo electrónico del empleado (desbordamiento) (30 caracteres)
           05 DESB-DIRECCION PIC X(50). *> Dirección del empleado (desbordamiento) (50 caracteres)
           05 DESB-CONTACTO PIC X(30). *> Contacto de emergencia del empleado (desbordamiento) (30 caracteres)

       FD INFORME-FILE.  *> Definición del archivo de informe
       01 INFORME-RECORD.  *> Registro del informe
           05 INF-LINEA PIC X(100).  *> Línea de texto para el informe

       WORKING-STORAGE SECTION.  *> Sección de almacenamiento de trabajo
       77 EMP-STATUS PIC XX.  *> Estado del archivo de empleados
       77 SAL-STATUS PIC XX.  *> Estado del archivo de salarios
       77 DESBORD-STATUS PIC XX.  *> Estado del archivo de desbordamiento
       77 INF-STATUS PIC XX.
       77 OPCION PIC 9.    *> Opción seleccionada por el usuario
       77 CONTINUAR PIC X VALUE 'S'.  *> Variable para continuar el programa

       PROCEDURE DIVISION.  *> División de procedimiento
       MAIN-LOGIC.  *> Lógica principal del programa
           OPEN OUTPUT EMPLEADOS-FILE  *> Abre el archivo de empleados para entrada/salida
           OPEN OUTPUT SALARIOS-FILE    *> Abre el archivo de salarios para entrada/salida
           OPEN OUTPUT DESBORDAMIENTO-FILE  *> Abre el archivo de desbordamiento para salida

           PERFORM WITH TEST AFTER UNTIL CONTINUAR = 'N'  *> Ciclo principal del programa
               DISPLAY "1. Registrar información de nuevo empleado"  *> Opción para registrar empleado
               DISPLAY "2. Consultar empleado"  *> Opción para consultar empleado
               DISPLAY "3. Editar empleado"  *> Opción para editar empleado
               DISPLAY "4. Eliminar empleado"  *> Opción para eliminar empleado
               DISPLAY "5. Generar informe mensual de empleados"  *> Opción para generar informe
               DISPLAY "Seleccione una opción (0 para salir): "  *> Solicita la opción al usuario
               ACCEPT OPCION  *> Captura la opción seleccionada

               EVALUATE OPCION  *> Evalúa la opción seleccionada
                   WHEN 1
                       PERFORM REGISTRAR-EMPLEADO  *> Llama al procedimiento de registrar empleado
                   WHEN 2
                       PERFORM CONSULTAR-EMPLEADO  *> Llama al procedimiento de consultar empleado
                   WHEN 3
                       PERFORM EDITAR-EMPLEADO  *> Llama al procedimiento de editar empleado
                   WHEN 4
                       PERFORM ELIMINAR-EMPLEADO  *> Llama al procedimiento de eliminar empleado
                   WHEN 5
                       PERFORM GENERAR-INFORME  *> Llama al procedimiento de generar informe
                   WHEN 0
                       MOVE 'N' TO CONTINUAR  *> Cambia la variable CONTINUAR para finalizar el ciclo
                   WHEN OTHER
                       DISPLAY "Opción no válida"  *> Manejo de opción no válida
               END-EVALUATE  *> Fin de la evaluación
           END-PERFORM.  *> Fin del ciclo

           CLOSE EMPLEADOS-FILE  *> Cierra el archivo de empleados
           CLOSE SALARIOS-FILE  *> Cierra el archivo de salarios
           CLOSE DESBORDAMIENTO-FILE.  *> Cierra el archivo de desbordamiento
           CLOSE INFORME-FILE

           STOP RUN.  *> Finaliza la ejecución del programa

       REGISTRAR-EMPLEADO.  *> Procedimiento para registrar un nuevo empleado
           DISPLAY "Ingrese el número de cédula del empleado: "  *> Solicita el ID del empleado
           ACCEPT EMP-ID  *> Captura el ID del empleado
           DISPLAY "Ingrese Apellidos: "  *> Solicita el apellido
           ACCEPT EMP-APELLIDO  *> Captura el apellido
           DISPLAY "Ingrese Nombres: "  *> Solicita el nombre
           ACCEPT EMP-NOMBRE  *> Captura el nombre
           DISPLAY "Ingrese Sexo: "  *> Solicita el sexo
           ACCEPT EMP-SEXO  *> Captura el sexo
           DISPLAY "Ingrese Teléfono Fijo: "  *> Solicita el teléfono fijo
           ACCEPT EMP-TEL-FIJO  *> Captura el teléfono fijo
           DISPLAY "Ingrese Teléfono Celular: "  *> Solicita el teléfono celular
           ACCEPT EMP-TEL-CELULAR  *> Captura el teléfono celular
           DISPLAY "Ingrese Correo: "  *> Solicita el correo electrónico
           ACCEPT EMP-CORREO  *> Captura el correo electrónico
           DISPLAY "Ingrese Dirección: "  *> Solicita la dirección
           ACCEPT EMP-DIRECCION  *> Captura la dirección
           DISPLAY "Ingrese Contacto: "  *> Solicita el contacto de emergencia
           ACCEPT EMP-CONTACTO  *> Captura el contacto de emergencia

           WRITE EMPLEADOS-RECORD INVALID KEY  *> Intenta escribir el registro de empleado
               DISPLAY "Error: No se pudo registrar el empleado"  *> Manejo de error en registro
           END-WRITE.
           DISPLAY "Empleado registrado exitosamente.".  *> Mensaje de éxito

           DISPLAY "Ingrese fecha de ingreso (DD/MM/AAAA): "
           ACCEPT SAL-FECHA-INGRESO
           DISPLAY "Ingrese Salario: "
           ACCEPT SAL-SALARIO
           DISPLAY "Ingrese Monto SSO: "
           ACCEPT SAL-MONTO-SSO
           DISPLAY "Ingrese Monto Préstamo: "
           ACCEPT SAL-MONTO-PRES

           WRITE SALARIOS-RECORD INVALID KEY
               DISPLAY "Error: No se pudo registrar el salario"
           END-WRITE.

           DISPLAY "Salario registrado exitosamente.".

       CONSULTAR-EMPLEADO.  *> Procedimiento para consultar un empleado
           DISPLAY "Ingrese número de cédula del empleado a consultar: "  *> Solicita el ID del empleado a consultar
           ACCEPT EMP-ID  *> Captura el número de cédula del empleado

           READ EMPLEADOS-FILE KEY IS EMP-ID INVALID KEY  *> Intenta leer el registro del empleado
               DISPLAY "Empleado no encontrado"  *> Manejo de error si no se encuentra
           END-READ.

           DISPLAY "Cédula: " EMP-ID
           DISPLAY "Apellidos: " EMP-APELLIDO  *> Muestra el apellido del empleado
           DISPLAY "Nombres: " EMP-NOMBRE  *> Muestra el nombre del empleado
           DISPLAY "Sexo: " EMP-SEXO  *> Muestra el sexo del empleado
           DISPLAY "Teléfono Fijo: " EMP-TEL-FIJO  *> Muestra el teléfono fijo
           DISPLAY "Teléfono Celular: " EMP-TEL-CELULAR  *> Muestra el teléfono celular
           DISPLAY "Correo: " EMP-CORREO  *> Muestra el correo electrónico
           DISPLAY "Dirección: " EMP-DIRECCION  *> Muestra la dirección
           DISPLAY "Contacto: " EMP-CONTACTO.  *> Muestra el contacto de emergencia

       EDITAR-EMPLEADO.  *> Procedimiento para editar un empleado
           DISPLAY "Ingrese cédula del empleado a editar: "  *> Solicita el ID del empleado a editar
           ACCEPT EMP-ID  *> Captura el ID del empleado

           READ EMPLEADOS-FILE KEY IS EMP-ID INVALID KEY  *> Intenta leer el registro del empleado
               DISPLAY "Empleado no encontrado"  *> Manejo de error si no se encuentra
           END-READ

           DISPLAY "Ingrese nuevos Apellidos: "  *> Solicita nuevo apellido
           ACCEPT EMP-APELLIDO  *> Captura el nuevo apellido
           DISPLAY "Ingrese nuevos Nombres: "  *> Solicita nuevo nombre
           ACCEPT EMP-NOMBRE  *> Captura el nuevo nombre
           DISPLAY "Ingrese nuevo Sexo: "  *> Solicita nuevo sexo
           ACCEPT EMP-SEXO  *> Captura el nuevo sexo
           DISPLAY "Ingrese nuevo Teléfono Fijo: "  *> Solicita nuevo teléfono fijo
           ACCEPT EMP-TEL-FIJO  *> Captura el nuevo teléfono fijo
           DISPLAY "Ingrese nuevo Teléfono Celular: "  *> Solicita nuevo teléfono celular
           ACCEPT EMP-TEL-CELULAR  *> Captura el nuevo teléfono celular
           DISPLAY "Ingrese nuevo Correo: "  *> Solicita nuevo correo electrónico
           ACCEPT EMP-CORREO  *> Captura el nuevo correo electrónico
           DISPLAY "Ingrese nueva Dirección: "  *> Solicita nueva dirección
           ACCEPT EMP-DIRECCION  *> Captura la nueva dirección
           DISPLAY "Ingrese nuevo Contacto: "  *> Solicita nuevo contacto
           ACCEPT EMP-CONTACTO  *> Captura el nuevo contacto de emergencia

           REWRITE EMPLEADOS-RECORD  *> Intenta reescribir el registro del empleado
               DISPLAY "Empleado actualizado exitosamente.".  *> Mensaje de éxito

       ELIMINAR-EMPLEADO.  *> Procedimiento para eliminar un empleado
           DISPLAY "Ingrese ID del empleado a eliminar: "  *> Solicita el ID del empleado a eliminar
           ACCEPT EMP-ID  *> Captura el ID del empleado

           DELETE EMPLEADOS-FILE RECORD INVALID KEY  *> Intenta eliminar el registro del empleado
               DISPLAY "Empleado no encontrado"  *> Manejo de error si no se encuentra
           END-DELETE.

           DISPLAY "Empleado eliminado exitosamente.".  *> Mensaje de éxito

       GENERAR-INFORME.  *> Procedimiento para generar informe mensual
           DISPLAY "Generando informe mensual de empleados..."  *> Mensaje de inicio de generación de informe

           OPEN INPUT EMPLEADOS-FILE  *> Abre el archivo de empleados para lectura
           OPEN INPUT SALARIOS-FILE    *> Abre el archivo de salarios para lectura
           OPEN OUTPUT INFORME-FILE     *> Abre el archivo de informe para escritura

           PERFORM WITH TEST AFTER UNTIL EMP-STATUS = "10"  *> Comienza el ciclo de lectura de registros
               READ EMPLEADOS-FILE  *> Lee el siguiente registro de empleados
                   AT END  *> Si se llega al final del archivo
                       MOVE "10" TO EMP-STATUS  *> Establece el estado de finalización
                   NOT AT END  *> Si no se llega al final del archivo
                       MOVE "Cédula: " TO INF-LINEA
                       STRING EMP-ID DELIMITED BY SPACE
                              " - Apellido: " DELIMITED BY SIZE
                              EMP-APELLIDO DELIMITED BY SPACE
                              " - Nombre: " DELIMITED BY SIZE
                              EMP-NOMBRE DELIMITED BY SPACE
                              INTO INF-LINEA
                       END-STRING
                       WRITE INFORME-RECORD FROM INF-LINEA  *> Escribe en el archivo de informe

                       MOVE EMP-ID TO SAL-ID  *> Mueve el ID del empleado a la variable de salario
                       READ SALARIOS-FILE  *> Intenta leer el salario correspondiente
                           AT END
                               MOVE "No se ha encontrado." TO INF-LINEA
                               WRITE INFORME-RECORD FROM INF-LINEA  *> Escribe en el archivo de informe
                           NOT AT END
                               STRING " - Salario: " DELIMITED BY SIZE
                                      SAL-SALARIO DELIMITED BY SPACE
                                      " - Monto SSO: " DELIMITED BY SIZE
                                      SAL-MONTO-SSO DELIMITED BY SPACE
                                      " - Monto Préstamo: " DELIMITED BY SIZE
                                      SAL-MONTO-PRES DELIMITED BY SPACE
                                      INTO INF-LINEA
                               END-STRING
                               WRITE INFORME-RECORD FROM INF-LINEA  *> Escribe en el archivo de informe
                       END-READ  *> Fin de la lectura del archivo de salarios
               END-READ  *> Fin de la lectura del archivo de empleados
           END-PERFORM.  *> Cierra el bloque PERFORM

           CLOSE EMPLEADOS-FILE  *> Cierra el archivo de empleados
           CLOSE SALARIOS-FILE  *> Cierra el archivo de salarios
           CLOSE INFORME-FILE  *> Cierra el archivo de informe
           DISPLAY "Informe generado con éxito."  *> Mensaje de éxito en la generación del informe
           EXIT.
