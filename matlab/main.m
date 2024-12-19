pkg load control;
pkg load symbolic;
syms s;

clc;

A = [0 1; 0 -2];
B = [0; 1];

fn_discretize(A,B, 1)
