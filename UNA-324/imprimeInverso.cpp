#include <iostream>

using namespace std;

// Definición de la estructura de un nodo de la lista enlazada
struct Nodo {
    int dato;
    Nodo* siguiente;
};

// Definición de la estructura de la lista enlazada
struct Lista {
    Nodo* inicio;
    Nodo* fin;
};

typedef Nodo* Posicion;

// Prototipos de funciones
void iniciarLista(Lista& l);
bool esVacia(Lista& l);
void insertarAlFinal(int dato, Lista& l);
Posicion finLista(Lista& l);
Posicion siguiente(Posicion p, Lista& l);
void imprimeInverso(Posicion p, Lista l);
void Recuperar(int& valor, Posicion p);
bool preguntarNuevosDatos(Lista& l);
void reiniciarLista(Lista& l);
bool nuevaLista();

int main() {
    Lista lista;
    iniciarLista(lista);

    do {
        // Solicitar al usuario que ingrese los elementos de la lista
        int numElementos;
        cout << "Ingrese el número de elementos de la lista: ";
        cin >> numElementos;

        cout << "Ingrese los elementos de la lista:\n";
        for (int i = 0; i < numElementos; ++i) {
            int elemento;
            cout << "Elemento " << i+1 << ": ";
            cin >> elemento;
            insertarAlFinal(elemento, lista);
        }

        // La posición desde donde se imprimirán los elementos en orden inverso
        Posicion posicion = lista.inicio;

        cout << "Elementos en orden inverso: ";
        imprimeInverso(posicion, lista);
        cout << endl;
    } while (preguntarNuevosDatos(lista));

    reiniciarLista(lista);

    return 0;
}

// Función para iniciar una lista vacía
void iniciarLista(Lista& l) {
    l.inicio = nullptr;
    l.fin = nullptr;
}

// Función para verificar si una lista está vacía
bool esVacia(Lista& l) {
    return l.inicio == nullptr;
}

// Función para insertar un elemento al final de la lista
void insertarAlFinal(int dato, Lista& l) {
    Nodo *nuevo = new Nodo;
    nuevo->dato = dato;
    nuevo->siguiente = nullptr;
    
    if(esVacia(l)) {
        l.inicio = l.fin = nuevo;
    } else {
        l.fin->siguiente = nuevo;
        l.fin = nuevo;
    }
}

// Función para obtener la posición final de la lista
Posicion finLista(Lista& l) {
    return l.fin;
}

// Función para obtener el siguiente elemento de una posición en la lista
Posicion siguiente(Posicion p, Lista& l) {
    return p->siguiente;
}

// Función para imprimir en orden inverso los elementos de la lista a partir de una posición específica
void imprimeInverso(Posicion p, Lista l) {
    if (p != nullptr) // Recursion stops when p points to nullptr
    {
        imprimeInverso(p->siguiente, l);
        cout << p->dato << " ";
    }
}

// Función para recuperar el valor de un nodo en una posición específica
void Recuperar(int& valor, Posicion p) {
    valor = p->dato;
}

// Función para preguntar al usuario si desea ingresar nuevos datos
bool preguntarNuevosDatos(Lista& l) {
    char respuesta;
    cout << "¿Desea ingresar nuevos datos a la lista? (S/N): ";
    cin >> respuesta;
    if (respuesta == 'S' || respuesta == 's') {
        return true;
    } else {
        if (!esVacia(l)) {
            if (nuevaLista()) {
                reiniciarLista(l);
                return true;
            }
        }
        return false;
    }
}

// Función para reiniciar la lista completamente
void reiniciarLista(Lista& l) {
    Nodo* actual = l.inicio;
    while (actual != nullptr) {
        Nodo* temp = actual;
        actual = actual->siguiente;
        delete temp;
    }
    l.inicio = nullptr;
    l.fin = nullptr;
}

// Función para preguntar al usuario si quiere generar una nueva lista
bool nuevaLista() {
    char respuesta;
    cout << "¿Desea generar una nueva lista? (s/n): ";
    cin >> respuesta;
    return (respuesta == 's' || respuesta == 'S');
}