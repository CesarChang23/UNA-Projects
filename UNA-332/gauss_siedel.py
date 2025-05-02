import numpy as np

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

def gauss_seidel(A, b, x0, tol=1e-10, max_iter=1000):
    """
    Implementa el método de Gauss-Seidel para resolver un sistema de ecuaciones lineales.
    """
    n = len(b)  # Obtiene el número de ecuaciones (filas) en b
    x = x0.copy()  # Inicializa el vector de solución con el valor inicial proporcionado

    # Ordenar A y b para que A tenga diagonal dominante
    A, b = ordenar_diagonal_dominante(A, b)
    
    for k in range(max_iter):  # Bucle de iteración
        x_old = x.copy()  # Guarda la solución anterior para calcular el error
        for i in range(n):  # Itera sobre cada ecuación
            # Calcula la suma de los productos de los elementos de la fila i
            sum1 = sum(A[i][j] * x[j] for j in range(i))  # Suma de x_j ya calculados
            sum2 = sum(A[i][j] * x_old[j] for j in range(i + 1, n))  # Suma de x_j no calculados
            
            # Actualiza el valor de x[i] usando la fórmula de Gauss-Seidel
            x[i] = (b[i] - sum1 - sum2) / A[i][i]
        
        # Cálculo del error de convergencia
        error = np.linalg.norm(x - x_old, ord=np.inf)  # Norma infinito de la diferencia
        print(f"Iteración {k+1}: x = {x}, Error = {error}")  # Imprime el estado actual de x y el error
        
        # Verifica si el error es menor que la tolerancia
        if error < tol:
            print("Convergencia alcanzada.")
            return x  # Retorna la solución si la convergencia se alcanza
    
    print("Se alcanzó el número máximo de iteraciones sin convergencia.")
    return x  # Retorna la solución final, aunque no se alcanzó la convergencia

# La convergencia del método Gauss-Seidel, con el valor inicial x^(0) = 0
A = np.array([[2, 0, 5, 3], 
              [0, 5, 0, 1], 
              [5, 0, 8, 0],
              [1, 2, 1, 2]], dtype=float)  # Define la matriz de coeficientes
b = np.array([1, 4, 3, 2], dtype=float)  # Define el vector de términos independientes
x0 = np.zeros(len(b))  # Inicializa el vector de solución x^(0) en ceros

resultado = gauss_seidel(A, b, x0)  # Llama a la función para resolver el sistema
print("Solución final:", resultado)  # Imprime la solución final