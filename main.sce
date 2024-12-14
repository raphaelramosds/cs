// Definindo os dados do sistema
A = [0 1; -2 -2];    // Matriz de estados
B = [0; 1];         // Matriz de entrada
C = [1 0];

// Polos desejados
polos = [-10 -1-%i -1+%i];

// Seguidor de referencia
[k1, K2] = segreferencia(A, B, C, polos);

// Y(s)/U(s) = N(s)/D(s)
N = 3*%s^2+4*%s-2;
D = %s^3+3*%s^2+7*%s+5;

// Representacao controlavel
[Acc, Bcc, Ccc, Dcc] = rcont(N, D);

// Representacao observavel
[Aco, Bco, Cco, Dco] = robsv(N, D);
