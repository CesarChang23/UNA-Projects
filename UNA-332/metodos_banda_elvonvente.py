import numpy as np
import networkx as nx
import matplotlib.pyplot as plt

# Definir el grafo G basado en la imagen
G = nx.Graph()
# Lista de aristas basada en el grafo de la imagen
aristas = [
    ('a', 'd'), ('b', 'c'), ('b', 'd'), ('c', 'd'), ('c', 'o'),
    ('d', 't'), ('f', 'o'), ('f', 'g'), ('g', 't'), ('g', 'u'), ('g', 'x'),
    ('t', 'z'), ('t', 'w'), ('z', 'w'), ('w', 'y'), ('x', 'y'), ('x', 'u')
]
G.add_edges_from(aristas) #añade las aristas al grafo G

# Obtener la matriz de adyacencia del grafo
nodos_ordenados = sorted(G.nodes())  # Obtener los nodos ordenados alfabéticamente
matriz_adyacencia = nx.to_numpy_array(G, nodelist=nodos_ordenados)
print("Matriz de adyacencia original:\n", matriz_adyacencia)

# Función para reordenar la matriz por el método de banda 
def metodo_banda(matriz, nodos):
    # Crear el grafo usando la matriz de adyacencia
    G = nx.from_numpy_array(matriz)
    # Obtener los grados de los nodos y ordenarlos de menor a mayor
    grados = sorted(G.degree, key=lambda x: x[1])  # Lista de nodos ordenados por grado
    # Obtener el orden de nodos en términos de sus índices en la matriz de adyacencia
    orden_banda = [nodos.index(nodos[i[0]]) for i in grados]
    # Reordenar la matriz de adyacencia usando el orden obtenido
    matriz_banda = matriz[np.ix_(orden_banda, orden_banda)]
    return matriz_banda, [nodos[i] for i in orden_banda]  # Convertir de índices a nombres de nodos

# Función para reordenar la matriz por el método de la envolvente 
def metodo_envolvente(matriz, nodos):
    # Crear el grafo usando la matriz de adyacencia
    G = nx.from_numpy_array(matriz)
    # Obtener los grados de los nodos y ordenarlos de menor a mayor
    grados = sorted(G.degree, key=lambda x: x[1])
    # Obtener el orden de nodos en términos de sus índices en la matriz de adyacencia
    orden_envolvente = [nodos.index(nodos[i[0]]) for i in grados]
    # Reordenar la matriz de adyacencia usando el orden obtenido
    matriz_envolvente = matriz[np.ix_(orden_envolvente, orden_envolvente)]
    return matriz_envolvente, [nodos[i] for i in orden_envolvente]  # Convertir de índices a nombres de nodos

# Aplicar el método de banda
matriz_banda, orden_banda = metodo_banda(matriz_adyacencia, nodos_ordenados)
print("Matriz de adyacencia reordenada (Método de Banda Manual):\n", matriz_banda)
print("Orden de nodos (Método de Banda Manual):", orden_banda)

# Aplicar el método de la envolvente
matriz_envolvente, orden_envolvente = metodo_envolvente(matriz_adyacencia, nodos_ordenados)
print("Matriz de adyacencia reordenada (Método de la Envolvente Manual):\n", matriz_envolvente)
print("Orden de nodos (Método de la Envolvente Manual):", orden_envolvente)

# Graficar el grafo original
plt.figure(figsize=(8, 6))
nx.draw(G, with_labels=True, node_color="lightblue", edge_color="gray")
plt.title("Grafo Original")
plt.show()

# Graficar la matriz de adyacencia original y las reordenadas
plt.figure(figsize=(15, 5))

# Matriz de adyacencia original
plt.subplot(1, 3, 1)
plt.title("Matriz de Adyacencia Original")
plt.imshow(matriz_adyacencia, cmap="Greys", interpolation="none")

# Matriz reordenada por el método de banda
plt.subplot(1, 3, 2)
plt.title("Método de Banda")
plt.imshow(matriz_banda, cmap="Greys", interpolation="none")

# Matriz reordenada por el método de la envolvente
plt.subplot(1, 3, 3)
plt.title("Método de la Envolvente")
plt.imshow(matriz_envolvente, cmap="Greys", interpolation="none")

plt.show()