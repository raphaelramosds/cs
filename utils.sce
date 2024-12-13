/*
* \polc
* @param A, B, C
* @returns U, V
*/
function [U,V] = polc(A,B,C)
    // Polinomio caracteristico
    p = poly(A,'x')
    disp('Polinomio caracteristico', p);
    
    // Polos
    sol = roots(p);
    disp('Polos', sol);
    
    // Matrizes de controlabilidade (U) e observabilidade (V)
    U = cont_mat(A,B);
    disp('Matriz de controlabilidade',U);
    
    V = obsv_mat(A,C);
    disp('Matriz de observabilidade',V);
endfunction;

/*
* \realestados
* @param A, B
* @returns K
*/
function K = realestados(A,B, polos)
    // Matriz de controlabilidade
    U = cont_mat(A,B)
    
    // Ordem do sistema
    n = size(A,1);
    
    // Verificar controlabilidade
    if rank(U) < n then
        disp("O sistema não é controlável. Não é possível calcular K.");
        halt;
    end
    
    // Polinomio auxiliar
    delta = poly(polos, 's');
    
    // Calculo de qc(A)
    qc = zeros(n,n);
    i=0;
    for c = coeff(delta)
        qc = qc + c*A^i;
        i=i+1;
    end
    
    // Calculo da matriz de ganhos K pela formula de Ackerman
    aux = zeros(1,n);
    aux($) = 1;
    K=-aux*inv(U)*qc;
endfunction

