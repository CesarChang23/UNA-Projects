/*
    Los números complejos tienen una parte real y una parte imaginaria, ejemplo: 2 + 3i
    i = sqrt(-1)
    
    Suma de dos (2) números complejos:
        Dados Z_1 = 1 + i y Z_2 = 2 + 2i
            Se suma (parte real de Z_1 + parte real de Z_2) + (parte imaginaria de Z_1 + parte imaginaria de Z_2)
                1 + i + 2 + 2i = 3 + 3i

    Multiplicación de dos (2) números complejos:
        Dados Z_1 = 1 + i y Z_2 = 2 + 2i
            (a+bi) * (c+di) = (a*c-b*d) + (a*d+b*c)i
            (1 + i) * (2+2i) = 1*2 - 2 + (2+2)i
                             = (2-2) + (4)i
                             = 0 + 4i
                             = 4i 

    Si el resultado de la suma es A y el producto es B nos piden una demostración donde se compruebe si A == B
*/

#include <iostream>

using namespace std;

// Definición de la estructura para generar números complejos
struct numerosComplejos{
    float real, imaginario;
} z_1, z_2;

//Prototipos de funciones
void ingresarDatos();
numerosComplejos suma(const numerosComplejos& z_1, const numerosComplejos& z_2);
numerosComplejos producto(const numerosComplejos& z_1, const numerosComplejos& z_2);
bool sonIguales(const numerosComplejos& z_1, const numerosComplejos& z_2);
void mostrarResultado(const numerosComplejos& a, const numerosComplejos& b);

int main(){
    char continuar;

    // Bucle principal para permitir al usuario realizar múltiples operaciones
    do{
        ingresarDatos(); // Solicitar al usuario que ingrese los números complejos

        // Calcular la suma y el producto de los números complejos ingresados
        numerosComplejos a = suma(z_1, z_2);
        numerosComplejos b = producto(z_1, z_2);
        mostrarResultado(a,b);

        cout<<"\n¿Desea ingresar nuevos valores? (s/n): "; cin >> continuar;
    } while (continuar == 'S' || continuar == 's');
    return 0;
}

void ingresarDatos(){
    cout<<"Ingresa los datos del primer número complejo"<< endl;
    cout<<"Parte real: "; cin>>z_1.real;
    cout<<"Parte imaginaria: "; cin>>z_1.imaginario;

    cout<<"\n\nIngresa los datos del segundo número complejo"<< endl;
    cout<<"Parte real: "; cin>>z_2.real;
    cout<<"Parte imaginaria: "; cin>>z_2.imaginario;
}

numerosComplejos suma(const numerosComplejos& z_1, const numerosComplejos& z_2){
    // (a+bi) + (c+di) = (a + c) + (b + d)i
    numerosComplejos resultadoSuma;
    resultadoSuma.real = z_1.real + z_2.real;
    resultadoSuma.imaginario = z_1.imaginario + z_2.imaginario;
    return resultadoSuma;
}

numerosComplejos producto(const numerosComplejos& z_1, const numerosComplejos& z_2){
    // (a+bi) * (c+di) = (a*c-b*d) + (a*d+b*c)i
    numerosComplejos resultadoProducto;
    resultadoProducto.real = z_1.real * z_2.real - z_1.imaginario * z_2.imaginario;
    resultadoProducto.imaginario = z_1.real * z_2.imaginario + z_1.imaginario * z_2.real;
    return resultadoProducto;
}

bool sonIguales(const numerosComplejos& z1, const numerosComplejos& z2){
    return (z1.real == z2.real) && (z1.imaginario == z2.imaginario);
}

void mostrarResultado(const numerosComplejos& a, const numerosComplejos& b){
    cout << "Suma: " << a.real << " + " << a.imaginario << "i" <<endl;
    cout << "Producto: " << b.real << " + " << b.imaginario << "i" <<endl;
    

    if (sonIguales(a,b)){
        cout << "Los resultados de la suma y el producto son iguales." <<endl;
    } else {
        cout << "Los resultados de la suma y el producto no son iguales." <<endl;
    }
}

