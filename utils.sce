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
* @param polos
* @returns K
*/
function K = realestados(A,B,polos)
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

/*
* \obsvestados
* @param A, C
* @param polos
* @returns L
*/
function L = obsvestados(A,C,polos)
    // Matriz de observabilidade
    V = obsv_mat(A,C)
    
    // Ordem do sistema
    n = size(A,1);
    
    // Verificar observabilidade
    if rank(V) < n then
        disp("O sistema não é observavel. Não é possível calcular L.");
        halt;
    end
    
    // Polinomio auxiliar
    delta = poly(polos, 's');

    // Calculo de ql(A)
    ql = zeros(n,n);
    i=0;
    for c = coeff(delta)
        ql = ql + c*A^i;
        i=i+1;
    end
    
    // Calculo da matriz de ganhos L pela formula de Ackerman
    aux = zeros(1,n);
    aux($) = 1;
    L=ql*inv(V)*aux';
endfunction

/*
* \segreferencia
* @param A, B, C
* @param polos
* @returns 
*/
function [k1, K2] = segreferencia(A,B,C,polos)
    // Ordem do sistema
    n = size(A,1);
    O = zeros(n,1);
    
    // Montar matriz aumentada
    Aa = [0 C; O A];
    Ba = [0; B];
  
    // Verificar controlabilidade
    Ua = cont_mat(Aa, Ba)
    if rank(Ua) < n then
        disp("O sistema não é controlável. Não é possível calcular K.");
        halt;
    end
    
    // Aplicar formula de Ackerman para descobrir k1 e K2
    K = realestados(Aa,Ba,polos);
    k1 = K(1);
    K2 = K(2:$);
endfunction
