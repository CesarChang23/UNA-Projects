#include <iostream>   // Para entrada y salida estándar
#include <vector>     // Para usar vectores
#include <cstdlib>    // Para funciones generales (rand, srand)
#include <algorithm>  // Para algoritmos como sort

using namespace std;  // Espacio de nombres para simplificar el uso de la librería estándar

// Definición de la estructura de un nodo para el árbol binario
struct Nodo {
    int valor;          // Valor almacenado en el nodo
    Nodo* izquierdo;    // Puntero al hijo izquierdo
    Nodo* derecho;      // Puntero al hijo derecho

    Nodo(int val) : valor(val), izquierdo(nullptr), derecho(nullptr) {}  // Constructor del nodo
};

// Función para liberar la memoria asignada a los nodos del árbol binario
void liberarMemoria(Nodo* raiz) {
    if (!raiz) return;  // Si la raíz es nullptr, retorna

    // Libera la memoria de los subárboles izquierdo y derecho y luego elimina el nodo actual
    liberarMemoria(raiz->izquierdo);
    liberarMemoria(raiz->derecho);
    delete raiz;
}

// Función para insertar un valor en el árbol binario
void insertar(Nodo*& raiz, int valor) {
    if (!raiz) {
        raiz = new Nodo(valor);
        return;
    }

    if (valor % 10 < raiz->valor % 10) {
        insertar(raiz->izquierdo, valor);
    } else {
        insertar(raiz->derecho, valor);
    }
}

// Función para generar valores aleatorios y añadirlos al vector
void generarValores(vector<int>& valores, int n) {
    srand(static_cast<unsigned int>(time(nullptr)));
    for (int i = 0; i < n; ++i) {
        valores.push_back(rand() % 1000);
    }
}

// Función para imprimir los valores almacenados en el vector junto con un mensaje
void imprimirValores(const vector<int>& valores, const string& mensaje) {
    cout << mensaje << ": ";
    for (int valor : valores) {
        cout << valor << " ";
    }
    cout << endl;
}

// Función para ordenar los valores de forma creciente o decreciente según el último dígito
void ordenarValores(vector<int>& valores) {
    char opcion;
    do {
        cout << "¿En qué orden desea ver los valores ordenados? (c - creciente, d - decreciente): ";
        cin >> opcion;

        if (opcion != 'c' && opcion != 'd') {
            cout << "Opción no válida. Intente de nuevo." << endl;
        }
    } while (opcion != 'c' && opcion != 'd');

    if (opcion == 'd') {
        sort(valores.begin(), valores.end(), [](int a, int b) { return a % 10 > b % 10; });
    } else {
        sort(valores.begin(), valores.end(), [](int a, int b) { return a % 10 < b % 10; });
    }
}

// Función para preguntar al usuario si desea ordenar los números nuevamente
bool preguntarNuevaOrdenacion() {
    char respuesta;
    cout << "¿Desea ordenar los números nuevamente? (s - sí, n - no): ";
    cin >> respuesta;
    return respuesta == 's';
}

int main() {
    int n = 10;  // Número de valores a generar
    vector<int> valores;  // Vector para almacenar los valores
    Nodo* raiz = nullptr;  // Raíz del árbol binario

    generarValores(valores, n);  // Genera valores aleatorios
    for (int valor : valores) {
        insertar(raiz, valor);  // Inserta los valores en el árbol binario
    }

    do {
        imprimirValores(valores, "Valores desordenados");

        vector<int> valoresOrdenados = valores;  // Copia de la lista original
        ordenarValores(valoresOrdenados);         // Ordena la lista copiada
        imprimirValores(valoresOrdenados, "Valores ordenados");

    } while (preguntarNuevaOrdenacion());  // Repite hasta que el usuario decida no ordenar más

    char nuevaLista;
    cout << "¿Desea generar otra lista aleatoria? (s - sí, n - no): ";
    cin >> nuevaLista;

    if (nuevaLista == 's') {
        main();  // Genera una nueva lista aleatoria
    } else {
        cout << "Muchas gracias, hasta luego." << endl;  // Mensaje de despedida
    }

    liberarMemoria(raiz);  // Libera la memoria del árbol binario

    // Espera a que el usuario presione Enter para salir
    cout << "Presione Enter para salir...";
    cin.ignore();  // Espera a que se presione Enter
    cin.get();     // Espera a que se presione Enter nuevamente
    
    return 0;  // Fin del programa
}