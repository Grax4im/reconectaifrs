/* Alguns SELECTS para usar nas futuras procedures e functions */

--Selecionar todos os computadores já doados, mostra a descrição e a data da doação

SELECT reconecta_computador.descricao, reconecta_doacao.data, reconect
FROM reconecta_computador INNER JOIN reconecta_quero_doar
ON reconecta_computador.id_computador = reconecta_quero_doar.id_computador
INNER JOIN reconecta_doacao
ON reconecta_quero_doar.id_quero_doar = reconecta_doacao.id_quero_doar;