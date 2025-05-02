import networkx as nx
import matplotlib.pyplot as plt

# Representación del grafo como un diccionario de adyacencias
grafo = {
    'a': ['d'],
    'b': ['c', 'd'],
    'c': ['b', 'd', 'o'],
    'd': ['a', 'c', 't'],
    'f': ['g', 'o'],
    'g': ['f', 't', 'u', 'x'],
    'o': ['c', 'f'],
    't': ['d', 'g', 'z', 'w'],
    'u': ['g', 'x'],
    'x': ['g', 'u', 'y'],
    'y': ['x', 'w'],
    'z': ['t', 'w'],
    'w': ['t', 'z', 'y']
}

# Función para dibujar el grafo
def dibujar_grafo(grafo, titulo="Grafo"):
    G = nx.Graph()
    # Agregar nodos y aristas al grafo de NetworkX
    for vertice, vecinos in grafo.items():
        for vecino in vecinos:
            G.add_edge(vertice, vecino)
    # Dibujar el grafo
    plt.figure(figsize=(8, 6))
    nx.draw(G, with_labels=True, node_size=500, node_color="skyblue", font_size=10, font_weight="bold", edge_color="gray")
    plt.title(titulo)
    plt.show()

# Función para conectar todos los vecinos de un vértice
def conectar_vecinos(grafo, vertice):
    vecinos = grafo[vertice]
    # Crear conexiones entre todos los vecinos
    for i in range(len(vecinos)):
        for j in range(i + 1, len(vecinos)):
            # Agregar conexiones bidireccionales si no existen
            if vecinos[j] not in grafo[vecinos[i]]:
                grafo[vecinos[i]].append(vecinos[j])
            if vecinos[i] not in grafo[vecinos[j]]:
                grafo[vecinos[j]].append(vecinos[i])

# Función para eliminar un vértice del grafo
def eliminar_vertice(grafo, vertice):
    # Conectar todos los vecinos del vértice antes de eliminarlo
    conectar_vecinos(grafo, vertice)
    # Hacer una copia de la lista de vecinos para evitar modificarla mientras iteramos
    vecinos = list(grafo[vertice])
    # Eliminar el vértice del grafo
    for vecino in vecinos:
        if vertice in grafo[vecino]:
            grafo[vecino].remove(vertice)
    del grafo[vertice]

# Aplicar el modelo de eliminación de vértices y mostrar paso a paso
def modelo_de_eliminacion(grafo):
    # Mostrar el grafo original
    dibujar_grafo(grafo, titulo="Grafo Original")
    
    # Hacer una copia de los vértices del grafo original
    vertices = list(grafo.keys())
    # Eliminar cada vértice uno por uno
    for vertice in vertices:
        if vertice in grafo:
            print(f"Eliminando vértice: {vertice}")
            eliminar_vertice(grafo, vertice)
            # Mostrar el grafo después de cada eliminación
            dibujar_grafo(grafo, titulo=f"Grafo después de eliminar {vertice}")

# Ejecutar el modelo de eliminación en el grafo dado
modelo_de_eliminacion(grafo)

