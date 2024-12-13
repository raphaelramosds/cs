// Definindo os dados do sistema
A = [1 0; 0 -2];    // Matriz de estados
B = [1; 1];         // Matriz de entrada
C = [1 1];

// Polos desejados
polos = [-2-%i -2+%i -10];

K = realestados(A,B,polos)
