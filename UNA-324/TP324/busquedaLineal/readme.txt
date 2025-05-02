=================================================
         README Programa de Búsqueda Lineal
=================================================

Requisitos para ejecutar el programa:
-------------------------------------
1. Compilador de C++ (por ejemplo, g++ en Linux o MinGW en Windows).
2. Sistema operativo compatible con C++.
3. Acceso a la línea de comandos o terminal.

Instrucciones para ejecutar el programa:
----------------------------------------
1. Abre la línea de comandos o terminal.
2. Navega al directorio donde se encuentra el archivo del programa ('busquedaLineal.cpp').
3. Compila el programa usando el compilador de C++. Por ejemplo, con g++.
4. Ejecuta el programa compilado.


Detalles del Código:
--------------------

### Librerías utilizadas:

- **iostream**: Para entrada y salida de datos.
- **vector**: Para utilizar vectores, que son arreglos dinámicos.
- **string**: Para utilizar cadenas de texto.
- **limits**: Para utilizar límites de tipos de datos.

### Funciones definidas:

- **esVocal(char c)**:
- Descripción: Determina si un caracter es una vocal.
- Parámetros: Un caracter 'c'.
- Retorna: 'True' si 'c' es una vocal, 'False' en caso contrario.

- **busquedaLineal(const std::vector<std::string>& lista)**:
- Descripción: Realiza una búsqueda lineal para encontrar palabras que comienzan con una vocal.
- Parámetros: Un vector de cadenas de texto 'lista'.
- Retorna: Un vector con las palabras que comienzan con una vocal.

### Función main():

- **Iteración Principal**:
- Utiliza un bucle 'while (true)' para permitir crear múltiples listas de palabras.

- **Ingreso de Palabras**:
- Solicita al usuario ingresar palabras hasta que decida no agregar más o ingrese "fin".
- Utiliza un bucle 'while (true)' interno para gestionar esta entrada.

- **Búsqueda de Palabras que Comienzan con Vocal**:
- Pregunta al usuario si desea seleccionar las palabras que comienzan con vocal.
- Llama a la función 'busquedaLineal()' para realizar esta búsqueda.

- **Salida de Resultados**:
- Imprime la lista original de palabras ingresadas por el usuario.
- O imprime las palabras que comienzan con vocal, según la elección del usuario.

- **Creación de Nueva Lista**:
- Pregunta al usuario si desea crear una nueva lista de palabras.
- Si la respuesta es "no", muestra el mensaje "Gracias, hasta luego" y sale del bucle principal.