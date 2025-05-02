/*
Utilizando la teoría de la pila del enunciado del ejercicio, hice un juego sencillo de la Torre. 
*/

#include <iostream>
#include <stack> // Incluye la biblioteca para utilizar la estructura de datos pila
#include <stdexcept>
#include <limits> // Para usar numeric_limits

using namespace std;

class Torre {
private:
    stack<string> elementos; // Contenedor para los elementos de la torre

public:
    // Método para agregar un elemento a la torre
    void Apilar(const string& elem) {
        elementos.push(elem); // Añade un elemento a la pila
    }

    // Método para remover un elemento de la torre
    void Sacar() {
        if (elementos.empty()) {
            throw runtime_error("No se puede sacar de una torre vacía"); // Si la pila está vacía, lanza una excepción
        }
        elementos.pop(); // Saca un elemento de la pila
    }

    // Método para obtener el elemento en la cima de la torre sin removerlo
    string Cima() {
        if (elementos.empty()) {
            throw runtime_error("No se puede acceder a la cima de una torre vacía"); // Si la pila está vacía, lanza una excepción
        }
        return elementos.top(); // Devuelve el elemento en la cima de la pila
    }

    // Método para verificar si la torre está vacía
    bool Vacia() {
        return elementos.empty(); // Verifica si la pila está vacía
    }

    // Método para invertir el orden de los elementos en la torre
    void Invertir() {
        if (elementos.empty()) {
            cout << "La torre ya está vacía, no se puede invertir." << endl; // Si la pila está vacía, muestra un mensaje
            return;
        }

        stack<string> torre_aux; // Torre auxiliar para invertir la torre

        // Movemos los elementos de la torre original a la torre auxiliar en el orden deseado
        while (!elementos.empty()) {
            torre_aux.push(elementos.top());
            elementos.pop();
        }

        stack<string> torre_invertida; // Torre para almacenar la torre invertida

        // Transferimos los elementos de la torre auxiliar a la torre invertida en el orden invertido
        while (!torre_aux.empty()) {
            torre_invertida.push(torre_aux.top());
            torre_aux.pop();
        }

        // Copiamos la torre invertida de vuelta a la torre original
        while (!torre_invertida.empty()) {
            elementos.push(torre_invertida.top());
            torre_invertida.pop();
        }

        cout << "La torre se ha invertido exitosamente." << endl; // Muestra un mensaje de éxito
    }

    // Método para mostrar los elementos de la torre
    void MostrarTorre() {
        stack<string> torre = elementos; // Creamos una copia de la torre original para no modificarla
        cout << "Torre: ";
        while (!torre.empty()) {
            cout << torre.top() << " "; // Muestra los elementos de la pila
            torre.pop();
        }
        cout << endl;
    }

    // Método para limpiar la torre
    void Limpiar() {
        while (!elementos.empty()) {
            elementos.pop(); // Saca todos los elementos de la pila
        }
        cout << "La torre ha sido limpiada." << endl; // Muestra un mensaje de éxito
    }
};

int main() {
    Torre torre; // Creamos un objeto de la clase Torre

    cout << "¡Bienvenido al juego de la torre!" << endl;

    int cantidad_maxima_elementos;
    cout << "Ingrese la cantidad máxima de elementos que puede tener la torre: ";
    while (!(cin >> cantidad_maxima_elementos) || cantidad_maxima_elementos <= 0) {
        // Limpiar el búfer de entrada en caso de error
        cin.clear();
        cin.ignore(numeric_limits<streamsize>::max(), '\n');
        cout << "Error. Por favor ingrese un número entero mayor que cero: ";
    }

    // Bucle principal que controla la iteración del juego
    while (true) {
        cout << "Seleccione una acción:" << endl;
        cout << "1. Apilar elemento" << endl;
        cout << "2. Desapilar elemento" << endl;
        cout << "3. Mostrar cima de la torre" << endl;
        cout << "4. Invertir la torre" << endl;
        cout << "5. Mostrar la torre" << endl;
        cout << "6. Limpiar la torre" << endl;
        cout << "7. Salir del juego" << endl;

        int opcion;
        cout << "Opción: ";
        while (!(cin >> opcion) || opcion < 1 || opcion > 7) {
            // Limpiar el búfer de entrada en caso de error
            cin.clear();
            cin.ignore(numeric_limits<streamsize>::max(), '\n');
            cout << "Error. Por favor seleccione una opción válida: ";
        }

        switch (opcion) {
            case 1: {
                string elemento;
                cout << "Ingrese el elemento a apilar: ";
                cin >> elemento;
                torre.Apilar(elemento); // Apila un elemento en la pila
                cout << "Elemento apilado correctamente." << endl; // Muestra un mensaje de éxito
                break;
            }
            case 2: {
                try {
                    torre.Sacar(); // Desapila un elemento de la pila
                    cout << "Elemento desapilado correctamente." << endl; // Muestra un mensaje de éxito
                } catch (const runtime_error& e) {
                    cout << e.what() << endl; // Muestra un mensaje de error si la pila está vacía
                }
                break;
            }
            case 3: {
                try {
                    cout << "Cima de la torre: " << torre.Cima() << endl; // Muestra la cima de la pila
                } catch (const runtime_error& e) {
                    cout << e.what() << endl; // Muestra un mensaje de error si la pila está vacía
                }
                break;
            }
            case 4:
                torre.Invertir(); // Invierte el orden de los elementos en la pila
                break;
            case 5:
                torre.MostrarTorre(); // Muestra todos los elementos de la pila
                break;
            case 6:
                torre.Limpiar(); // Limpia la pila
                break;
            case 7:
                cout << "Gracias por jugar. ¡Hasta luego!" << endl; // Muestra un mensaje de despedida y sale del programa
                return 0;
        }
    }

    return 0;
}

