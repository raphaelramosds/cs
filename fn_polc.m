function [U, V] = fn_polc(A, B, C)
    % Polinomio caracteristico, matrizes de observabilidade e controlabilidade
    % @param A, B, C
    % @returns U, V

    % Ordem do sistema
    disp('Ordem do sistema');
    n = size(A, 1)

    % Polinômio característico
    p = poly(A);

    % Polos
    sol = roots(p);

    % Matriz de controlabilidade (U)
    disp('Matriz de controlabilidade:');
    U = ctrb(A, B)

    disp('Rank da matriz de controlabilidade');
    rankU = rank(U)

    if rankU != n
        disp('O sistema não é controlável  porque o rank da matriz de controlabilidade é diferente da ordem do sistema.');
        return;
    else
        disp('O sistema é controlável porque o rank da matriz de controlabilidade é igual a ordem do sistema')
    end

    % Matriz de observabilidade (V)
    disp('Matriz de observabilidade:');
    V = obsv(A, C)

    disp('Rank da matriz de observabilidade');
    rankV = rank(V)

    if rankV != n
        disp('O sistema não é observavel  porque o rank da matriz de observabilidade é diferente da ordem do sistema.');
        return;
    else
        disp('O sistema é observavel porque o rank da matriz de observabilidade é igual a ordem do sistema')
    end
end
