% Matheus Brito Faria
% QUESTAO 1
table = readtable("Belo Horizonte_83587_D_2000-01-01_2022-02-21.csv");
table.PRECIPITACAOTOTAL_DIARIO_mm_(isnan(table.PRECIPITACAOTOTAL_DIARIO_mm_))= 0;
precipitacao = table2array(table(:, "PRECIPITACAOTOTAL_DIARIO_mm_"));
tamanho_array = size(precipitacao, 1);

figure(1)
plot(precipitacao)
title('Precipitação em BH')
xlim([-100, tamanho_array+100])

precipitacao_ma_7_dias = moving_average(precipitacao, 7);

figure(2)
plot(precipitacao_ma_7_dias)
title('Média móvel de 7 dias')
xlim([-100, tamanho_array+100])


precipitacao_ma_14_dias = moving_average(precipitacao, 14);

figure(3)
plot(precipitacao_ma_14_dias)
title('Média móvel de 14 dias')
xlim([-100, tamanho_array+100])


precipitacao_ma_45_dias = moving_average(precipitacao, 45);

figure(4)
plot(precipitacao_ma_45_dias)
title('Média móvel de 45 dias')
xlim([-100, tamanho_array+100])

figure(5)
precipitacao_agregada = zeros([23, 1]);
for y = 2000:2022
    precipitacao_agregada(y-1999) = sum(table2array(table(y == year(table.DataMedicao), "PRECIPITACAOTOTAL_DIARIO_mm_")));
end
bar(2000:2022, precipitacao_agregada)
title('Acumulado de chuva por ano')

function ma = moving_average(array, delay)
    ma = zeros(size(array));
    array_com_zeros = cat(1, zeros(delay-1, 1), array);
    for i = delay:size(array_com_zeros)
        ma(i-delay+1) = mean(array_com_zeros(i-delay+1:i));
    end
    ma(isnan(ma)) = 0;
end


