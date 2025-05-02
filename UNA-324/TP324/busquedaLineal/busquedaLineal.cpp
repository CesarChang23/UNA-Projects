#include <iostream>   // Para entrada y salida de datos
#include <vector>     // Para utilizar vectores
#include <string>     // Para utilizar cadenas de texto
#include <limits>     // Para utilizar límites de tipos de datos

// Función para determinar si el caracter es una vocal
bool esVocal(char c) {
    return std::string("aeiouAEIOU").find(c) != std::string::npos; // Busca el caracter en el conjunto de vocales
}

// Función que realiza una búsqueda lineal para encontrar palabras que comienzan con una vocal
std::vector<std::string> busquedaLineal(const std::vector<std::string>& lista) {
    std::vector<std::string> resultado; // Vector para almacenar las palabras que comienzan con vocal
    for (const auto& str : lista) {
        if (esVocal(str[0])) { // Verifica si el primer caracter de la palabra es una vocal
            resultado.push_back(str); // Agrega la palabra al vector de resultados
        }
    }
    return resultado; // Devuelve el vector de resultados
}

int main() {
    while (true) { // Iteración principal para permitir crear múltiples listas
        std::vector<std::string> lista; // Vector para almacenar las palabras ingresadas por el usuario
        std::string palabra; // Variable para almacenar cada palabra ingresada por el usuario

        std::cout << "Ingrese las palabras para la lista inicial:" << std::endl;

        // Bucle para que el usuario ingrese palabras hasta que decida no agregar más
        while (true) {
            std::cout << "Ingrese una palabra (o escriba 'fin' para terminar): ";
            if (!(std::cin >> palabra) || palabra == "fin") { // Verifica si el usuario ha ingresado 'fin' o un valor no válido
                break; // Si es así, termina el bucle
            }

            lista.push_back(palabra); // Agrega la palabra al vector de palabras

            char respuesta;
            std::cout << "¿Quiere agregar una palabra adicional? (s/n): ";
            // Verifica la respuesta del usuario y valida la entrada
            if (!(std::cin >> respuesta) || (respuesta != 's' && respuesta != 'S' && respuesta != 'n' && respuesta != 'N')) {
                std::cin.clear(); // Limpia el estado de error de la entrada
                std::cin.ignore(std::numeric_limits<std::streamsize>::max(), '\n'); // Ignora el resto de la línea
                std::cout << "Entrada inválida. Intente nuevamente." << std::endl;
                continue;
            }

            if (respuesta == 'n' || respuesta == 'N') { // Verifica si el usuario no quiere agregar más palabras
                break; // Si es así, termina el bucle
            }
        }

        // Imprime la lista de palabras ingresadas por el usuario
        std::cout << "\nLista de palabras ingresadas:" << std::endl;
        for (const auto& str : lista) {
            std::cout << str << std::endl;
        }

        char respuesta;
        std::cout << "\n¿Quiere seleccionar las palabras que empiezan con vocal? (s/n): ";
        // Verifica la respuesta del usuario y valida la entrada
        if (!(std::cin >> respuesta) || (respuesta != 's' && respuesta != 'S' && respuesta != 'n' && respuesta != 'N')) {
            std::cin.clear(); // Limpia el estado de error de la entrada
            std::cin.ignore(std::numeric_limits<std::streamsize>::max(), '\n'); // Ignora el resto de la línea
            std::cout << "Entrada inválida. Intente nuevamente." << std::endl;
            continue;
        }

        if (respuesta == 's' || respuesta == 'S') {
            // Realiza la búsqueda lineal para encontrar palabras que comienzan con vocal
            std::vector<std::string> resultado = busquedaLineal(lista);
            std::cout << "\nPalabras que comienzan con una vocal:" << std::endl;
            for (const auto& str : resultado) {
                std::cout << str << std::endl;
            }
        } else {
            // Imprime la lista original de palabras
            std::cout << "\nLista original de palabras:" << std::endl;
            for (const auto& str : lista) {
                std::cout << str << std::endl;
            }
        }

        std::cout << "\n¿Desea crear una nueva lista de palabras? (s/n): ";
        std::cin >> respuesta;
        if (respuesta != 's' && respuesta != 'S') {
            std::cout << "\nGracias, hasta luego." << std::endl;
            break; // Sale del bucle principal si el usuario no quiere crear una nueva lista
        }
    }

    std::cin.get(); // Pausa para que el usuario pueda ver el mensaje
    return 0; // Termina el programa con éxito
}

