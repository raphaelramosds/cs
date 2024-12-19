/*
* Plot para o seguidor de referência de ordem n
*/
function plotsegreferencia(A,B,C,k1,K2,n)
    // Matrizes do seguidor
    Ac = [A+B*K2 B*k1; C 0];
    aux = zeros(1,n);
    aux($) = -1;
    Bc = aux';
    Cc = [C 0];
    Dc = 0;
    
    // Configurar simulação
    t = 0:0.01:30; // Tempo de simulação
    r = ones(t);   // Entrada degrau (referência)
    
    // Resolver sistema no tempo
    sys = syslin('c', Ac, Bc, Cc, Dc);
    y = csim(r, t, sys);
    
    // Plotar resposta
    clf();
    plot(t, y, 'b', t, r, 'r--');
    xtitle("Resposta do Seguidor de Referência", "Tempo (s)", "Saída y(t)");
    legend(["Saída y(t)" "Referência r(t)"]);
endfunction;
