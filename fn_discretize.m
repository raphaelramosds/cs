function [G, H] = fn_discretize(A,B, T)
  % Discretiza um sistema continuo (A,B,C,D) com periodo de amostragem T segundos
  % @param A, B
  % @param T
  % @returns G, H

  % Literais
  syms s t;

  % Ordem do sistema
  n = size(A,1);

  % Calculo de e^(AT) e integral de e^(At)*B, com t=0..T
  eAt = ilaplace(inv(s*eye(n,n)-A),s,t);
  eAtB = eAt * B;

  % Calculo das matrizes G e H
  G = double(subs(eAt, t, T))
  H = double(int(eAtB, t, 0, T))
end
