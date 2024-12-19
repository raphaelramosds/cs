function L = fn_obsvestados(A, C, polos)
    % Observador de estados
    % @param A, C
    % @param polos
    % @returns L

    % Matriz de observabilidade
    V = obsv(A, C);
    disp('Matriz de observabilidade:');
    disp(V);

    % Ordem do sistema
    n = size(A, 1);

    % Verificar observabilidade
    if rank(V) < n
        disp("O sistema não é observável. Não é possível calcular L.");
        return;
    end

    % Polinômio auxiliar
    delta = poly(polos);
    disp('delta:');
    disp( poly2sym(delta) );

    % Cálculo de ql(A)
    delta = flip(delta)
    ql = zeros(n, n);
    for i = 1:length(delta)
        ql = ql + delta(i) * A^(i-1);
    end
    disp('ql(A):');
    disp(ql);

    % Cálculo da matriz de ganhos L pela fórmula de Ackerman
    aux = zeros(1, n);
    aux(end) = 1;
    L = ql * inv(V) * aux';
    disp('L:');
    disp(L);
end
