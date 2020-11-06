--Funcao que dado o nome da pessoa ela retorna o id de tal pessoa, boa pra criar chaves estrangeiras
--dica: colocar tratamento de erros (caso nao ache a pessoa ou retorne mais de uma)
--obrigado, boa noite
CREATE OR REPLACE FUNCTION f_procura_pessoa_por_nome(v_nome VARCHAR) RETURN NUMBER IS
    v_id_pessoa NUMBER;
BEGIN
    SELECT id_pessoa
    INTO v_id_pessoa
    FROM reconecta_pessoa
    WHERE nome_pessoa = v_nome;
    
    RETURN v_id_pessoa;
END;

--Apenas testando o uso da funcao acima - everything ok
DECLARE
    c NUMBER;
BEGIN 
    c := f_procura_pessoa_por_nome('Robert');
    dbms_output.put_line(c);
END;
