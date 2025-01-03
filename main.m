pkg load control;
pkg load symbolic;
syms s;
warning('off', 'all');

clc;

N=3*s-2
D=s^2+s

[Acc, Bcc, Ccc, Dcc] = fn_rcont(N,D)

[G,H] = fn_discretize(Acc,Bcc,1)

[k2, k1] = fn_segreferencia_d(G, H, Ccc, [0.5+0.2*i 0.5-0.2*i -0.1])
