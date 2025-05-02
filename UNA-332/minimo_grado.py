import networkx as nx
import matplotlib.pyplot as plt

# Grafo de entrada
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
    for vertice, vecinos in grafo.items():
        for vecino in vecinos:
            G.add_edge(vertice, vecino)
    plt.figure(figsize=(8, 6))
    nx.draw(G, with_labels=True, node_size=500, node_color="skyblue", font_size=10, font_weight="bold", edge_color="gray")
    plt.title(titulo)
    plt.show()

# Función para conectar todos los vecinos de un vértice
def conectar_vecinos(grafo, vertice):
    vecinos = grafo[vertice]
    for i in range(len(vecinos)):
        for j in range(i + 1, len(vecinos)):
            if vecinos[j] not in grafo[vecinos[i]]:
                grafo[vecinos[i]].append(vecinos[j])
            if vecinos[i] not in grafo[vecinos[j]]:
                grafo[vecinos[j]].append(vecinos[i])

# Función para eliminar un vértice del grafo
def eliminar_vertice(grafo, vertice):
    conectar_vecinos(grafo, vertice)
    vecinos = list(grafo[vertice])
    for vecino in vecinos:
        if vertice in grafo[vecino]:
            grafo[vecino].remove(vertice)
    del grafo[vertice]

# Algoritmo de Mínimo Grado
def algoritmo_minimo_grado(grafo):
    # Copia del grafo para manipular
    grafo_copia = {v: list(vecinos) for v, vecinos in grafo.items()}
    
    print("Inicio del Algoritmo de Mínimo Grado")
    dibujar_grafo(grafo_copia, "Grafo Original")
    
    while grafo_copia:
        # Encontrar el vértice con el grado mínimo
        vertice_min_grado = min(grafo_copia, key=lambda v: len(grafo_copia[v]))
        grado_min = len(grafo_copia[vertice_min_grado])
        
        print(f"\nEliminando vértice '{vertice_min_grado}' con grado {grado_min}")
        
        # Conectar vecinos y eliminar el vértice
        eliminar_vertice(grafo_copia, vertice_min_grado)
        
        # Dibujar el grafo después de cada eliminación
        dibujar_grafo(grafo_copia, f"Grafo después de eliminar {vertice_min_grado}")

    print("Algoritmo de Mínimo Grado completado. Todos los vértices han sido eliminados.")

# Ejecutar el algoritmo en el grafo dado
algoritmo_minimo_grado(grafo)
