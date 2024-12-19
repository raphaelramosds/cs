pkg load control;
pkg load symbolic;
syms s;

clc;

A = [-4 3 0; -1 -4 -1; 0 0 -2];
B = [0; 0; 3];
C = [1 0 0];
polos = [-2 -2 -3];

N = 0*s+3;
D = s^2+2*s-4;

[Aco, Bco, Cco, Dco] = fn_robsv(N,D);

fn_segreferencia(Aco,Bco,Cco,polos);
