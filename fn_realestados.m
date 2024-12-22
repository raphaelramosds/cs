function K = fn_realestados(A, B, polos)
    % Realimentacao de estados
    % @param A, B
    % @param polos
    % @returns K

    % Matriz de controlabilidade
    U = ctrb(A, B);
    disp('Matriz de controlabilidade:');
    disp(U);

    % Ordem do sistema
    n = size(A, 1);

    % Verificar controlabilidade
    if rank(U) < n
        disp("O sistema não é controlável. Não é possível calcular K.");
        return;
    end

    % Polinômio auxiliar
    delta = poly(polos);
    disp('delta:');
    disp( poly2sym(delta) );

    % Cálculo de qc(A)
    delta = flip(delta);
    qc = zeros(n, n);
    for i = 1:length(delta)
        qc = qc + delta(i) * A^(i-1);
    end
    disp('qc(A):');
    disp(qc);

    % Cálculo da matriz de ganhos K pela fórmula de Ackerman
    aux = zeros(1, n);
    aux(end) = 1;
    K = -aux * inv(U) * qc;
    disp('K:');
    disp(K);
end
