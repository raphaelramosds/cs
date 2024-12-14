/*
* Matrizes de controlablidade e observabilidade
* @param A, B, C
* @returns U, V
*/
function [U,V] = polc(A,B,C)
    // Ordem do sistema
    n = size(A,1);
    
    // Polinomio caracteristico
    p = poly(A,'x')
    disp('Polinomio caracteristico', p);
    
    // Polos
    sol = roots(p);
    disp('Polos', sol);
    
    // Matrizes de controlabilidade (U) e observabilidade (V)
    U = cont_mat(A,B);
    disp('Matriz de controlabilidade',U);
    if rank(U) < n then
        disp("O sistema não é controlável.");
        halt;
    end
    
    V = obsv_mat(A,C);
    disp('Matriz de observabilidade',V);
    if rank(V) < n then
        disp("O sistema não é observavel.");
        halt;
    end
endfunction;

/*
* Realimentacao de estados
* @param A, B
* @param polos
* @returns K
*/
function K = realestados(A,B,polos)
    // Matriz de controlabilidade
    U = cont_mat(A,B)
    disp('Matriz de controlabilidade', U)
    
    // Ordem do sistema
    n = size(A,1);
    
    // Verificar controlabilidade
    if rank(U) < n then
        disp("O sistema não é controlável. Não é possível calcular K.");
        halt;
    end
    
    // Polinomio auxiliar
    delta = poly(polos, 's');
    disp('delta',delta)
    
    // Calculo de qc(A)
    qc = zeros(n,n);
    i=0;
    for c = coeff(delta)
        qc = qc + c*A^i;
        i=i+1;
    end
    disp('qc(A)',qc);
    
    // Calculo da matriz de ganhos K pela formula de Ackerman
    aux = zeros(1,n);
    aux($) = 1;
    K=-aux*inv(U)*qc;
    disp('K', K);
endfunction

/*
* Observador de estados
* @param A, C
* @param polos
* @returns L
*/
function L = obsvestados(A,C,polos)
    // Matriz de observabilidade
    V = obsv_mat(A,C)
    disp('Matriz de observabilidade', V);
    
    // Ordem do sistema
    n = size(A,1);
    
    // Verificar observabilidade
    if rank(V) < n then
        disp("O sistema não é observavel. Não é possível calcular L.");
        halt;
    end
    
    // Polinomio auxiliar
    delta = poly(polos, 's');
    disp('delta', delta);

    // Calculo de ql(A)
    ql = zeros(n,n);
    i=0;
    for c = coeff(delta)
        ql = ql + c*A^i;
        i=i+1;
    end
    disp('ql(A)',ql);
    
    // Calculo da matriz de ganhos L pela formula de Ackerman
    aux = zeros(1,n);
    aux($) = 1;
    L=ql*inv(V)*aux';
    disp('L',L);
endfunction

/*
* Seguidor de referencia para entrada degrau unitario
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
    n = size(Aa,1);
  
    // Verificar controlabilidade
    Ua = cont_mat(Aa, Ba)
    if rank(Ua) < n then
        disp("O sistema não é controlável. Não é possível calcular K.");
        halt;
    end
    disp('Aa', Aa);
    disp('Ba', Ba);
    disp('Ua', Ua);
    
    // Aplicar formula de Ackerman para descobrir k1 e K2
    K = realestados(Aa,Ba,polos);
    k1 = K(1);
    K2 = K(2:$);
    disp('k1', k1);
    disp('K2', K2);
endfunction

/*
* Forma Canonica Controlavel (CC)
* @param N, D
* @returns Acc, Bcc, Ccc, Dcc
*
* Note.
*   1. Funcao de Transferencia Y(s)/U(s) = N(s)/D(s)
*   2. N(s) = b1*s^(n-1) + ... + b(n-1)*s + b(n)
*   3. D(s) = s^n + a(1)*s^(n-1) + ... + a(n-1)*s + a(n)   
**/
function [Acc, Bcc, Ccc, Dcc] = rcont(N,D)
    // Inverter ordem dos coeficientes de a e b
    a = coeff(D); 
    b = coeff(N);
    
    // Ordem
    n = length(a)-1;
    O = zeros(n-1,1);
    
    // Montar matrizes na forma canonica
    Acc = [O eye(n-1,n-1); -a(1:$-1)];
    Bcc = [O; 1];
    Ccc = b;
    Dcc = [0];
endfunction

/*
* Forma Canonica Observavel (CO)
* @param N, D
* @returns Aco, Bco, Cco, Dco
**/
function [Aco, Bco, Cco, Dco] = robsv(N,D)
    [Acc, Bcc, Ccc, Dcc] = rcont(N,D);
    Aco = Acc';
    Bco = Ccc';
    Cco = Bcc';
    Dco = Dcc;
endfunction
