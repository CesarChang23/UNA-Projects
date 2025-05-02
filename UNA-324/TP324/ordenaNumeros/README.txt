========================================================
         README - Ordenar números por el último dígito
========================================================

Requisitos para la ejecución del programa:
------------------------------------------

1. Compilador de C++ que soporte el estándar C++11 o superior.
2. Bibliotecas estándar de C++ (iostream, vector, cstdlib, algorithm).

Instrucciones para la ejecución del programa:
---------------------------------------------

1. Compila el código fuente con un compilador de C++ que soporte C++11 o superior. 

2. Ejecuta el programa compilado.


Funcionamiento del código:
--------------------------

El programa genera una lista aleatoria de números y los inserta en un árbol binario. Luego ofrece opciones para ordenar estos números según el último dígito y permite al usuario generar otra lista aleatoria si lo desea.

1. **Estructura del Nodo:**

- 'Nodo': Estructura que representa un nodo en un árbol binario. Cada nodo contiene un valor entero, un puntero al hijo izquierdo y un puntero al hijo derecho.

2. **Funciones Principales:**

- 'liberarMemoria': Libera la memoria asignada a los nodos del árbol binario.
- 'insertar': Inserta un valor en el árbol binario manteniendo el orden según el último dígito del valor.
- 'generarValores': Genera valores aleatorios y los añade a un vector.
- 'imprimirValores': Imprime los valores almacenados en un vector.
- 'ordenarValores': Ordena los valores del vector de acuerdo al último dígito de cada número, ya sea de forma creciente o decreciente.
- 'preguntarNuevaOrdenacion': Pregunta al usuario si desea ordenar los números nuevamente.

3. **Función 'main':**

- Genera valores aleatorios y los inserta en el árbol binario.
- Ofrece la opción de ordenar los números y permite al usuario generar otra lista aleatoria o salir del programa.

El usuario puede ordenar los números según el último dígito y generar nuevas listas aleatorias. 
El programa continúa ejecutándose hasta que el usuario decide salir manualmente.