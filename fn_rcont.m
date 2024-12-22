function [Acc, Bcc, Ccc, Dcc] = fn_rcont(N, D)
    % Forma Canonica Controlavel (CC)
    % @param N, D
    % @returns Acc, Bcc, Ccc, Dcc
    %
    % Note.
    %   1. Funcao de Transferencia Y(s)/U(s) = N(s)/D(s)
    %   2. N(s) = b1*s^(n-1) + ... + b(n-1)*s + b(n)
    %   3. D(s) = s^n + a(1)*s^(n-1) + ... + a(n-1)*s + a(n)

    % Coeficientes dos polinomios
    a = coeffs(D);
    b = coeffs(N);

    % Grau dos polinomios
    dn = length(b) - 1;  % Grau de N(s)
    dd = length(a) - 1;  % Grau de D(s)

    % Ordem
    n = dd;
    O = zeros(n-1, 1);

    % Montar matrizes na forma canonica
    Acc = double([[O eye(n-1,n-1)]; -a(1:end-1)]);
    Bcc = [O; 1];

    % A forma restrita exige que o grau de N(s) seja o grau de D(s) menos um
    if dn != dd - 1
        % Complete com zero até o coeficiente n-1
        Ccc = double([b, O']);
    else
        % Se for restrita, preencha com os coeficientes b
        Ccc = double(b);
    end

    Dcc = 0;
end
