#include <iostream>
#include <unordered_map>
#include <functional>
using namespace std;

// Definición de un nodo en el árbol binario
class Nodo {
public:
    char val; // Valor del nodo
    Nodo* left; // Puntero al hijo izquierdo
    Nodo* right; // Puntero al hijo derecho

    // Constructor para inicializar un nodo con un valor dado y punteros a nulo
    Nodo(char x) : val(x), left(nullptr), right(nullptr) {}
};

class ArbolBinario {
private:
    Nodo* raiz; // Puntero a la raíz del árbol binario

    // Función auxiliar para construir el árbol recursivamente
    Nodo* construirArbol(const string& preOrden, const string& enOrden, int preInicio, int enInicio, int enFinal, unordered_map<char, int>& mapaIndices) {
        // Caso base: si el índice de inicio del recorrido en preorden es mayor o igual al tamaño del recorrido en preorden, o si el índice de inicio del recorrido en inorden es mayor que el índice final
        if (preInicio >= preOrden.size() || enInicio > enFinal)
            return nullptr; // Retornar un nodo nulo

        // Valor de la raíz del árbol es el primer elemento del recorrido en preorden
        char valorRaiz = preOrden[preInicio];
        // Crear un nuevo nodo con el valor de la raíz
        Nodo* nodoRaiz = new Nodo(valorRaiz);

        // Encontrar el índice de la raíz en el recorrido en inorden
        int indiceEnOrden = mapaIndices[valorRaiz];

        // Construir recursivamente el subárbol izquierdo con los elementos antes de la raíz en el recorrido en preorden y en el recorrido en inorden
        nodoRaiz->left = construirArbol(preOrden, enOrden, preInicio + 1, enInicio, indiceEnOrden - 1, mapaIndices);
        // Construir recursivamente el subárbol derecho con los elementos después de la raíz en el recorrido en preorden y en el recorrido en inorden
        nodoRaiz->right = construirArbol(preOrden, enOrden, preInicio + 1 + (indiceEnOrden - enInicio), indiceEnOrden + 1, enFinal, mapaIndices);

        return nodoRaiz; // Retornar el nodo raíz del subárbol construido
    }

public:
    // Constructor que construye el árbol binario a partir de los recorridos en preorden e inorden
    ArbolBinario(const string& preOrden, const string& enOrden) {
        // Verificar si alguno de los recorridos está vacío o si tienen diferente longitud
        if (preOrden.empty() || enOrden.empty() || preOrden.size() != enOrden.size()) {
            raiz = nullptr; // Si se cumple alguna de estas condiciones, la raíz del árbol es nula
            return; // Salir del constructor
        }

        // Crear un mapeo de los valores del recorrido en inorden a sus índices
        unordered_map<char, int> mapaIndices;
        for (int i = 0; i < enOrden.size(); ++i)
            mapaIndices[enOrden[i]] = i;

        // Construir el árbol binario recursivamente
        raiz = construirArbol(preOrden, enOrden, 0, 0, enOrden.size() - 1, mapaIndices);
    }

    // Función para obtener el recorrido en postorden del árbol binario
    string recorridoPostOrden() {
        // Cadena para almacenar el recorrido en postorden
        string resultadoPostOrden = "";
        // Función recursiva para recorrer el árbol en postorden
        function<void(Nodo*)> postOrden = [&](Nodo* nodo) {
            // Si el nodo es nulo, no hay nada que hacer
            if (nodo == nullptr)
                return;
            // Recorrer recursivamente el subárbol izquierdo
            postOrden(nodo->left);
            // Recorrer recursivamente el subárbol derecho
            postOrden(nodo->right);
            // Agregar el valor del nodo al recorrido en postorden
            resultadoPostOrden += nodo->val;
        };

        // Llamar a la función de recorrido en postorden desde la raíz del árbol
        postOrden(raiz);
        // Devolver el recorrido en postorden resultante
        return resultadoPostOrden;
    }
};

int main() {
    // Recorridos en preorden e inorden del árbol binario
    string preOrden = "GEAIBMCLDFKJH";
    string enOrden = "IABEGLDCFMKHJ";

    // Construir el árbol binario a partir de los recorridos dados
    ArbolBinario arbol(preOrden, enOrden);

    // Obtener el recorrido en postorden del árbol binario
    string postOrden = arbol.recorridoPostOrden();

    // Imprimir el recorrido en postorden
    cout << "Recorrido en postorden: " << postOrden << endl;

    return 0;
}
