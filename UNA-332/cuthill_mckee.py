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
G.add_edges_from(aristas)

# Graficar el grafo original
plt.figure(figsize=(8, 6))
nx.draw(G, with_labels=True, node_color="lightblue", edge_color="gray")
plt.title("Grafo Original")
plt.show()

# Obtener la matriz de adyacencia original del grafo
nodos_ordenados = sorted(G.nodes())  # Ordenar los nodos alfabéticamente
matriz_adyacencia = nx.to_numpy_array(G, nodelist=nodos_ordenados)
print("Matriz de adyacencia original:\n", matriz_adyacencia)

# Aplicar el algoritmo de Cuthill-McKee 
orden_cuthill_mckee = list(nx.utils.reverse_cuthill_mckee_ordering(G))
print("Orden de nodos (Algoritmo de Cuthill-McKee):", orden_cuthill_mckee)

# Reordenar la matriz de adyacencia utilizando el orden de Cuthill-McKee
# Convertir nombres de nodos a índices en la matriz de adyacencia
indices_cuthill_mckee = [nodos_ordenados.index(nodo) for nodo in orden_cuthill_mckee]
matriz_cuthill_mckee = matriz_adyacencia[np.ix_(indices_cuthill_mckee, indices_cuthill_mckee)]

print("Matriz de adyacencia reordenada (Algoritmo de Cuthill-McKee):\n", matriz_cuthill_mckee)

# Graficar la matriz de adyacencia original y la reordenada
plt.figure(figsize=(12, 5))

# Matriz de adyacencia original
plt.subplot(1, 2, 1)
plt.title("Matriz de Adyacencia Original")
plt.imshow(matriz_adyacencia, cmap="Greys", interpolation="none")

# Matriz reordenada por el algoritmo de Cuthill-McKee
plt.subplot(1, 2, 2)
plt.title("Algoritmo de Cuthill-McKee")
plt.imshow(matriz_cuthill_mckee, cmap="Greys", interpolation="none")

plt.show()



