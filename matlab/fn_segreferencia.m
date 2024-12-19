function [k1, K2] = fn_segreferencia(A, B, C, polos)
    % Seguidor de referência para entrada degrau unitário
    % @param A, B, C
    % @param polos
    % @returns

    % Ordem do sistema
    n = size(A, 1);
    O = zeros(n, 1);

    % Montar matriz aumentada
    Aa = [0 C; O A];
    Ba = [0; B];
    n = size(Aa, 1);

    % Verificar controlabilidade
    Ua = ctrb(Aa, Ba);
    if rank(Ua) < n
        disp("O sistema não é controlável. Não é possível calcular K.");
        return;
    end

    disp('Aa =');
    disp(Aa);
    disp('Ba =');
    disp(Ba);
    disp('Ua =');
    disp(Ua);
    disp('rank(Ua) =');
    disp(rank(Ua));

    % Aplicar fórmula de Ackerman para descobrir k1 e K2
    K = fn_realestados(Aa, Ba, polos);
    k1 = K(1);
    K2 = K(2:end);

    disp('k1 =');
    disp(k1);
    disp('K2 =');
    disp(K2);
end

