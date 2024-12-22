function fn_estabilidade(A, tipo)
  % Calcula os polos do sistema (autovalores da matriz A)
  polos = eig(A)

  switch tipo
    case 'd' % Verificação para sistemas discretos
      if all(abs(polos) <= 1)
        disp('O sistema discreto é estável pois todos os polos pertencem ao circulo unitario.');
      else
        disp('O sistema discreto não é estável por ter um polo fora do circulo unitario.');
      end
    case 'c' % Verificação para sistemas contínuos
      if all(real(polos) <= 0)
        disp('O sistema contínuo é estável pois a parte real de todos os polos é negativa.');
      else
        disp('O sistema contínuo não é estável por ter um polo com parte real negativa.');
      end
    otherwise
      disp('Tipo precisa ser "d" (discreto) ou "c" (contínuo).');
  endswitch
end

