function [k2 k1] = fn_segreferencia_d(G,H,C,polos)
    % Seguidor de referência discreto para entrada degrau unitário
    % @param G, H, C
    % @param polos
    % @returns

    % Ordem do sistema
    ns = size(G, 1);
    O = zeros(ns-1, 1);

    % Montar matriz aumentada
    Ga = [G H; zeros(1,ns+1)]
    Ha = [O; H]
    n = size(Ga, 1);

    % Verificar controlabilidade
    Wc = ctrb(Ga, Ha)
    if rank(Wc) < n
        disp("O sistema não é controlável. Não é possível calcular K.");
        return;
    end

    disp('rank(Wc) =');
    disp(rank(Wc));

    % Aplicar fórmula de Ackerman para descobrir k1 e K2
    O = zeros(1, n-1);
    K = fn_realestados(Ga, Ha, polos) * (-1)
    aux = (K+[O 1])*inv([G-eye(ns,ns) H; C*G C*H])

    k2 = aux(1)
    k1 = aux(2:end)

end;
