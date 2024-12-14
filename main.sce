// Informacoes do sistema
polos = [-1+0.1*%i -1-0.1*%i -5 -12];
A = [-6 1 0; -11 0 1; -6 0 0];
B = [2; 6; 2]
C = [1 0 0];

// Projeto do seguidor de referencia
[k1, K2] = segreferencia(A,B,C,polos);

// Plotar seguidor de referencia
plotsegreferencia(A,B,C,k1,K2,4);
