pkg load control;
pkg load symbolic;
syms s;

clc;

A = [0.3 0; 0 0.5];
B = [1; 1];
C = [1 1];

polos = [-1 -1 -1];

#[G,H] = fn_discretize(A,B, 1);

#[k2, k1] = fn_segreferencia_d(G,H,C,polos);

fn_estabilidade(A,'c')
