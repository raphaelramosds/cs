function fn_estabilidade(A, tipo)
  % Calcula os polos do sistema (autovalores da matriz A)
  polos = eig(A)

  switch tipo
    case 'd' % Verificação para sistemas discretos
      if all(abs(polos) <= 1)
        disp('O sistema discreto é estável.');
      else
        disp('O sistema discreto não é estável.');
      end
    case 'c' % Verificação para sistemas contínuos
      if all(real(polos) <= 0)
        disp('O sistema contínuo é estável.');
      else
        disp('O sistema contínuo não é estável.');
      end
    otherwise
      disp('Tipo precisa ser "d" (discreto) ou "c" (contínuo).');
  endswitch
end

