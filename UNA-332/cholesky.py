import numpy as np

# Función para realizar la descomposición de Cholesky
def factorizacion_cholesky(A):
    n = len(A) # Tamaño de la matriz A
    L = np.zeros_like(A)  # Inicializa L como una matriz de ceros del mismo tamaño que A
    
    # Bucle para calcular la matriz triangular inferior L
    for i in range(n):
        for j in range(i + 1):
            sum_k = sum(L[i][k] * L[j][k] for k in range(j))  # Calcula la suma de productos de los elementos en L
            if i == j:  # Si estamos en un elemento diagonal de L
                L[i][j] = np.sqrt(A[i][i] - sum_k) # Calcula el elemento diagonal de L
            else:  # Si estamos en un elemento no diagonal de L
                L[i][j] = (A[i][j] - sum_k) / L[j][j]  # Calcula el elemento fuera de la diagonal usando los valores anteriores de L
    return L

# Función para resolver el sistema Ax = b usando la descomposición de Cholesky
def resuelve_cholesky(A, b):
   
    if A.shape[0] != A.shape[1]:
        raise ValueError("La matriz A debe ser cuadrada.")
    if A.shape[0] != len(b):
        raise ValueError("El vector b debe tener la misma longitud que el número de filas/columnas de A.")
    
    L = factorizacion_cholesky(A)
    n = len(L)

    L = factorizacion_cholesky(A)   # Obtiene la matriz triangular inferior L a partir de la factorización de Cholesky de A
    n = len(L) # Tamaño de la matriz L
    
    # Resolución de Ly = b mediante sustitución hacia adelante
    y = np.zeros(n)
    for i in range(n):
        # Para cada i, calcula y[i] usando la suma de los productos anteriores
        y[i] = (b[i] - sum(L[i][j] * y[j] for j in range(i))) / L[i][i]
    
    # Resolución de L.T * x = y mediante sustitución hacia atrás
    x = np.zeros(n)
    for i in range(n - 1, -1, -1):  # Recorre las filas de L de abajo hacia arriba
       # Para cada i, calcula x[i] usando la suma de los productos de los elementos posteriores
        x[i] = (y[i] - sum(L[j][i] * x[j] for j in range(i + 1, n))) / L[i][i]
    
    return x

# La factorización de Cholesky de la matriz asociada.
# Definición de la matriz A y el vector b para el sistema Ax = b
A = np.array([[38, 3, 50, 13],
              [3, 26, 0, 12],
              [50, 0, 89, 13],
              [13, 12, 13, 10]], dtype=float)
b = np.array([19, 24, 31, 11], dtype=float)


# Llama a la función resuelve_cholesky para encontrar x
x = resuelve_cholesky(A, b)
print("Solución del sistema: ", x)

"""
    Solución del sistema:  [ 2.84330484  3.63247863 -0.28774929 -6.58119658]
"""