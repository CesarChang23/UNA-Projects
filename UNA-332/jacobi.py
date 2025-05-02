import numpy as np  # Importamos la biblioteca numpy para manejar operaciones con matrices y vectores

def ordenar_diagonal_dominante(A, b):
    """
    Ordena la matriz A y el vector b de manera que la matriz A tenga
    una diagonal dominante, si es posible.
    """
    n = len(A)  # Obtiene el número de filas (y columnas) de la matriz A
    for i in range(n):
        max_index = i  # Inicializa el índice del máximo como el índice actual
        max_value = abs(A[i][i])  # Obtiene el valor absoluto del elemento diagonal actual
        
        # Busca el índice de la fila con el mayor valor absoluto en la columna i
        for j in range(i + 1, n):
            if abs(A[j][i]) > max_value:
                max_index = j  # Actualiza el índice del máximo
                max_value = abs(A[j][i])  # Actualiza el valor máximo
        
        # Intercambia filas de A para lograr la diagonal dominante
        if max_index != i:  # Si se encontró una fila con un valor mayor
            A[[i, max_index]] = A[[max_index, i]]  # Intercambia las filas en A
            b[i], b[max_index] = b[max_index], b[i]  # Mantiene el vector b consistente con los cambios en A

    return A, b  # Retorna la matriz A y el vector b reordenados

# Método de Jacobi mejorado
def metodo_jacobi(A, b, tolerancia=1e-10, iteraciones_max=100, mostrar_iteraciones=False):
    # Intentamos ordenar las filas para mejorar la diagonal dominante
    A, b = ordenar_diagonal_dominante(A, b)
    n = len(b)
    x = np.zeros(n)
    x_nueva = np.zeros(n)
    contador_iteraciones = 0

    # Bucle principal de iteración del método de Jacobi
    for k in range(iteraciones_max):
        for i in range(n):
            suma_terminos = sum(A[i][j] * x[j] for j in range(n) if j != i)
            x_nueva[i] = (b[i] - suma_terminos) / A[i][i]
        
        # Calculamos el error como la diferencia entre x_nueva y x
        error = np.linalg.norm(x_nueva - x, ord=np.inf)
        
        if mostrar_iteraciones:
            print(f"Iteración {k+1}: x = {x_nueva}")
        
        # Verificamos si el error es menor que la tolerancia (criterio de convergencia)
        if error < tolerancia:
            print(f"Convergencia alcanzada en la iteración {k + 1}")
            return x_nueva  # Retornamos el vector solución si el método ha convergido
        
        # Actualizamos el vector x para la siguiente iteración
        x = np.copy(x_nueva)
        contador_iteraciones += 1

    # Si se llega al número máximo de iteraciones sin convergencia, informamos al usuario
    print("No se alcanzó la convergencia en el número máximo de iteraciones")
    return x_nueva

# La convergencia del método Jacobi, con el valor inicial 𝑥^(0)=0.
A = np.array([[2, 0, 5, 3],
              [0, 5, 0, 1],
              [5, 0, 8, 0],
              [1, 2, 1, 2]], dtype=float)
b = np.array([1, 4, 3, 2], dtype=float)

# Llamada a la función para resolver el sistema
resultado = metodo_jacobi(A, b, mostrar_iteraciones=True)
print("Solución aproximada:", resultado)

