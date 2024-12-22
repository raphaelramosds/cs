function [Aco, Bco, Cco, Dco] = fn_robsv(N,D)
    # Forma Canonica Observavel (CO)
    # @param N, D
    # @returns Aco, Bco, Cco, Dco
    [Acc, Bcc, Ccc, Dcc] = fn_rcont(N,D);
    Aco = Acc';
    Bco = Ccc';
    Cco = Bcc';
    Dco = Dcc;
end
