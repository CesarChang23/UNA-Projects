#include <iostream>       // Para la entrada y salida estándar
#include <vector>         // Para usar vectores
#include <queue>          // Para usar colas de prioridad (usada en Dijkstra)
#include <climits>        // Para usar el valor de INT_MAX
#include <unordered_map>  // Para usar mapas no ordenados (usada para almacenar distancias)

using namespace std;

const int INF = INT_MAX;  // Valor infinito para distancias

// Estructura para representar una arista
struct Edge {
    int to;       // Nodo destino de la arista
    int weight;   // distancia de la arista
};

// Función para el algoritmo de Dijkstra
void dijkstra(vector<vector<Edge>>& graph, int start, vector<int>& distance) {
    int n = graph.size();
    distance.assign(n, INF);  // Inicializa todas las distancias como infinito
    distance[start] = 0;       // La distancia al nodo inicial es 0

    // Cola de prioridad para almacenar nodos por distancia
    priority_queue<pair<int, int>, vector<pair<int, int>>, greater<pair<int, int>>> pq;
    pq.push({0, start});  // Agregamos el nodo de inicio a la cola de prioridad

    while (!pq.empty()) {
        int u = pq.top().second;    // Extrae el nodo con menor distancia
        int dist_u = pq.top().first;  // Extrae la distancia
        pq.pop();  // Elimina el nodo extraído de la cola

        // Si la distancia extraída es mayor que la distancia actual, no procesamos el nodo
        if (dist_u > distance[u]) continue;

        // Iteramos sobre los vecinos del nodo actual
        for (const Edge& edge : graph[u]) {
            int v = edge.to;          // Nodo destino
            int weight_uv = edge.weight;  // Distancia de la arista

            // Si encontramos un camino más corto a v, actualizamos la distancia y agregamos a la cola
            if (distance[u] + weight_uv < distance[v]) {
                distance[v] = distance[u] + weight_uv;
                pq.push({distance[v], v});
            }
        }
    }
}

int main() {
    // Número de nodos en el grafo
    const int N = 7;  // 6 nodos externos + 1 nodo central

    // Grafo representado como lista de adyacencia
    vector<vector<Edge>> graph(N);

    // Conexiones y distancias entre nodos
    unordered_map<string, int> distances = {
        {"XA", 1}, {"AB", 3}, {"AC", 1}, {"BC", 7}, {"CD", 1}, 
        {"CE", 2}, {"XD", 2}, {"DE", 1}, {"EY", 2}, {"BY", 2},   
    };

    // Función lambda para agregar una conexión al grafo
    auto addEdge = [&](int u, int v, int weight) {
        graph[u].push_back({v, weight});
        graph[v].push_back({u, weight});
    };

    // Agregamos las conexiones al grafo usando la función addEdge
    addEdge(0, 1, distances["XA"]);  // X -> A
    addEdge(1, 2, distances["AB"]);  // A -> B
    addEdge(2, 6, distances["BY"]);  // B -> Y
    addEdge(1, 3, distances["AC"]);  // A -> C
    addEdge(2, 3, distances["BC"]);  // B -> C
    addEdge(3, 4, distances["CD"]);  // C -> D
    addEdge(3, 5, distances["CE"]);  // C -> E
    addEdge(0, 4, distances["XD"]);  // X -> D
    addEdge(4, 5, distances["DE"]);  // D -> E
    addEdge(5, 6, distances["EY"]);  // E -> Y

    // Bucle principal para obtener distancias entre nodos
    while (true) {
        char from, to;
        cout << "Ingrese el nodo inicial (X, A, B, C, D, E, Y): ";
        cin >> from;
        cout << "Ingrese el nodo final (X, A, B, C, D, E, Y): ";
        cin >> to;

        int start = 0, end = 0;

        // Convertir caracteres a índices de nodos
        switch (from) {
            case 'X': start = 0; break;
            case 'A': start = 1; break;
            case 'B': start = 2; break;
            case 'C': start = 3; break;
            case 'D': start = 4; break;
            case 'E': start = 5; break;
            case 'Y': start = 6; break;
            default: start = -1;
        }

        switch (to) {
            case 'X': end = 0; break;
            case 'A': end = 1; break;
            case 'B': end = 2; break;
            case 'C': end = 3; break;
            case 'D': end = 4; break;
            case 'E': end = 5; break;
            case 'Y': end = 6; break;
            default: end = -1;
        }

        // Validar nodos ingresados
        if (start == -1 || end == -1) {
            cout << "Nodo inválido. Por favor, ingrese nodos válidos." << endl;
            continue;
        }

        // Vector para almacenar distancias calculadas por Dijkstra
        vector<int> distance(N);
        dijkstra(graph, start, distance);

        // Mostrar distancia entre nodos
        cout << "Distancia desde " << from << " hasta " << to << ": " << distance[end] << endl;
    }

    return 0;
}
