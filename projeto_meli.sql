projeto_meli.sql# powerbi-people-analytics
Este projeto integra SQL Server e Power BI para analisar o desempenho de uma equipe de 20 colaboradores  em  um centro de distribuição. 🔍 O que o dashboard resolve? O objetivo é identificar . O dashboard conta com um Indicador de Velocímetro para a visão geral da equipe e um Gráfico de Colunas para o desempenho individual.
-- 1. Criando a estrutura e os dados (Simulação de 20 funcionários)
WITH DadosBrutos AS (
    SELECT 'Carlos Silva' as nome, 22 as idade, 3 as tempo_casa, 580 as total_bipado UNION ALL
    SELECT 'Ana Souza', 34, 24, 710 UNION ALL
    SELECT 'Marcos Oliveira', 19, 1, 450 UNION ALL
    SELECT 'Julia Lima', 28, 12, 635 UNION ALL
    SELECT 'Roberto Costa', 45, 60, 680 UNION ALL
    SELECT 'Fernanda Alvez', 21, 5, 610 UNION ALL
    SELECT 'Ricardo Santos', 30, 18, 590 UNION ALL
    SELECT 'Beatriz Rocha', 25, 9, 650 UNION ALL
    SELECT 'Lucas Mendes', 20, 2, 520 UNION ALL
    SELECT 'Patrícia Cruz', 38, 48, 720 UNION ALL
    SELECT 'Gabriel Nunes', 23, 7, 605 UNION ALL
    SELECT 'Camila Farias', 29, 15, 640 UNION ALL
    SELECT 'Thiago Silva', 31, 20, 615 UNION ALL
    SELECT 'Vanessa Gomes', 26, 11, 585 UNION ALL
    SELECT 'Douglas Lima', 40, 36, 695 UNION ALL
    SELECT 'Aline Melo', 22, 4, 550 UNION ALL
    SELECT 'Felipe Duarte', 27, 13, 630 UNION ALL
    SELECT 'Sabrina Paiva', 33, 22, 660 UNION ALL
    SELECT 'Igor Batista', 24, 6, 595 UNION ALL
    SELECT 'Tatiane Rosa', 36, 30, 705
),

-- 2. Calculando a produtividade individual (Baseada em 9h de jornada)
CalculoProdutividade AS (
    SELECT 
        nome,
        idade,
        tempo_casa as tempo_casa_meses,
        total_bipado,
        9 as horas_jornada,
        70 as meta_hora,
        ROUND(CAST(total_bipado AS FLOAT) / 9, 2) AS pecas_por_hora
    FROM DadosBrutos
)

-- 3. Gerando os indicadores finais para o Power BI
SELECT 
    nome,
    idade,
    tempo_casa_meses,
    total_bipado,
    pecas_por_hora,
    -- % de Atingimento Individual (Quanto o funcionário fez em relação aos 70 p/h)
    ROUND((pecas_por_hora / 70) * 100, 2) AS percentual_individual,
    
    -- Média de Peças/Hora da Equipe Inteira (Usando OVER para repetir em todas as linhas)
    ROUND(AVG(pecas_por_hora) OVER(), 2) AS media_equipe_pecas_hora,
    
    -- % de Atingimento da Equipe (Média do grupo em relação à meta de 70)
    ROUND((AVG(pecas_por_hora) OVER() / 70) * 100, 2) AS percentual_equipe_media

FROM CalculoProdutividade
ORDER BY percentual_individual DESC;
