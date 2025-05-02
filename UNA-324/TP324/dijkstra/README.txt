=======================================
         README - Algoritmo Dijkstra
=======================================

Requisitos para la ejecución del programa:
------------------------------------------

1. Compilador de C++ que soporte el estándar C++11 o superior.
2. Bibliotecas estándar de C++ (iostream, vector, queue, climits, unordered_map).

Instrucciones para la ejecución del programa:
---------------------------------------------

1. Compila el código fuente con un compilador de C++ que soporte C++11 o superior. Por ejemplo, con g++.
   

2. Ejecuta el programa compilado.


Funcionamiento del código:
--------------------------

El programa implementa el algoritmo de Dijkstra para encontrar las distancias más cortas desde un nodo inicial hasta todos los demás nodos en un grafo ponderado no dirigido.

1. **Estructuras y Variables Globales:**

- 'Edge': Estructura que representa una arista con un nodo destino ('to') y una distancia ('weight').
- 'INF': Constante que representa un valor infinito para distancias.
- 'graph': Lista de adyacencia que representa el grafo.
- 'distances': Mapa no ordenado que almacena las distancias entre nodos como pares de cadenas (clave) y enteros (valor).

2. **Función 'dijkstra':**

Esta función toma como argumentos un grafo 'graph', un nodo inicial 'start' y un vector 'distance' para almacenar las distancias calculadas. Utiliza una cola de prioridad para procesar nodos basándose en la distancia actual.

- Inicializa todas las distancias como infinito, excepto la distancia al nodo inicial que se establece en 0.
- Agrega el nodo inicial a la cola de prioridad.
- Mientras la cola no esté vacía, extrae el nodo con menor distancia y actualiza las distancias a sus vecinos si se encuentra un camino más corto.

3. **Función 'main':**

- Define el grafo y las conexiones entre nodos usando la función 'addEdge'.
- Solicita al usuario que ingrese nodos inicial y final.
- Convierte los caracteres ingresados a índices de nodos y valida su existencia.
- Llama a la función 'dijkstra' para calcular las distancias y muestra la distancia entre los nodos inicial y final.

4. **Función 'addEdge':**

Función lambda que agrega una arista entre dos nodos con un peso específico tanto en 'graph' como en el sentido opuesto debido a que el grafo es no dirigido.

- 'u', 'v': Nodos a conectar.
- 'weight': Distancia de la arista entre 'u' y 'v'.

El usuario puede ingresar nodos iniciales y finales para obtener la distancia más corta entre ellos. El programa continúa solicitando nodos hasta que se detiene manualmente.