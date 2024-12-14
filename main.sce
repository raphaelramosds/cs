// Definindo os dados do sistema
A = [0 1; -2 -2];    // Matriz de estados
B = [0; 1];         // Matriz de entrada
C = [1 0];

// Polos desejados
polos = [-10 -1-%i -1+%i];

// Seguidor de referencia
[k1, K2] = segreferencia(A, B, C, polos);
