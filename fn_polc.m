function [U, V] = fn_polc(A, B, C)
    % Polinomio caracteristico, matrizes de observabilidade e controlabilidade
    % @param A, B, C
    % @returns U, V

    % Ordem do sistema
    n = size(A, 1);

    % Polinômio característico
    p = poly(A);
    disp('Polinômio característico:');
    disp( poly2sym(p) );

    % Polos
    sol = roots(p);
    disp('Polos:');
    disp(sol);

    % Matriz de controlabilidade (U)
    U = ctrb(A, B);
    disp('Matriz de controlabilidade:');
    disp(U);
    if rank(U) < n
        disp('O sistema não é controlável.');
        return;
    end

    % Matriz de observabilidade (V)
    V = obsv(A, C);
    disp('Matriz de observabilidade:');
    disp(V);
    if rank(V) < n
        disp('O sistema não é observável.');
        return;
    end
end
