// Funcao transferencia de malha fechada
N=3*%s^2+4*%s-2;
D=%s^3+3*%s^2+7*%s+5;

// Forma controlavel da FT
[Acc, Bcc, Ccc, Dcc] = rcont(N,D);

// Polos do seguidor
polos = [-1+0.1*%i -1-0.1*%i -5 -12];

// Constantes do seguidor
[k1, K2] = segreferencia(Acc,Bcc,Ccc,polos);

// Simulação da resposta ao degrau
// Matrizes do sistema em malha fechada
Ac = [Acc+Bcc*K2 Bcc*k1; Ccc 0];
Bc = [0; 0; 0; -1];
Cc = [Ccc 0];
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
