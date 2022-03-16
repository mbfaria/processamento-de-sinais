% Matheus Brito Faria
% QUESTAO 2
table = readtable("Belo Horizonte_83587_D_2000-01-01_2022-02-21.csv");
table.PRECIPITACAOTOTAL_DIARIO_mm_(isnan(table.PRECIPITACAOTOTAL_DIARIO_mm_))= 0;

precipitacao = table2array(table(:, "PRECIPITACAOTOTAL_DIARIO_mm_"));
tamanho_array = size(precipitacao, 1);

figure(1)
plot(precipitacao)
title('Precipitação em BH')
xlim([-100, tamanho_array+100])


precipitacao_filtrada = filtro(precipitacao);

figure(1)
plot(precipitacao_filtrada)
title('Precipitação filtrada')
xlim([-100, tamanho_array+100])

numerador = [0.7 0 -0.252];
denominador = [1 -0.1 -0.72];

figure(2)
freqz(numerador, denominador,'whole',2001);

figure(3)
zplane(numerador, denominador)

function f = filtro(array)
    x = cat(1, zeros(2, 1), array);
    f = zeros(size(x));
    for n = 3:size(x)
        f(n) = 0.1*f(n-1) + 0.72*f(n-2) + 0.7*x(n) - 0.252*x(n-2);
    end
    f =f(3:end);
    f(isnan(f)) = 0;
end