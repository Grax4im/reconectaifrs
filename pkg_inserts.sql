-- pacote com todos as procedures e functions de inserção de dados 
create or replace package pkg_inserts is
    procedure   p_cria_pessoa(nome IN VARCHAR, telefone IN NUMBER, email IN VARCHAR, cidade IN VARCHAR);
	procedure	p_criar_quero_doar(nome_pessoa IN VARCHAR, isNotebook IN NUMBER, isUsable IN NUMBER, descricao IN VARCHAR);
	procedure	p_criar_quero_receber(nome_pessoa IN VARCHAR, isNotebook IN NUMBER, descricao IN VARCHAR);
	procedure	p_criar_doacao(nome_doador VARCHAR, nome_receptor VARCHAR);
    function    f_criar_computador(p_isNotebook number, p_isUsable number, p_descricao varchar) return number;
end pkg_inserts;
/

create or replace package body pkg_inserts AS
   
    PROCEDURE p_cria_pessoa (nome IN VARCHAR, telefone IN NUMBER, email IN VARCHAR, cidade IN VARCHAR) IS
        BEGIN
            INSERT INTO reconecta_pessoa VALUES(s_id_reconecta_pessoa.nextval,nome, telefone,email,cidade);
        END;

    --Procedure Quero Doar(pega o nome da pessoa, cria registro do computador e do quero doar)

    PROCEDURE p_criar_quero_doar(nome_pessoa IN VARCHAR, isNotebook IN NUMBER, isUsable IN NUMBER, descricao IN VARCHAR) IS
        id_pessoa NUMBER;
        id_computador NUMBER;
        BEGIN
            id_pessoa := f_procura_pessoa_por_nome(nome_pessoa);
            id_computador := f_criar_computador(isNotebook, isUsable, descricao);
            
            INSERT INTO reconecta_quero_doar
            VALUES (s_id_reconecta_quero_doar.nextval,id_pessoa, id_computador, sysdate);
        END;

    PROCEDURE p_criar_quero_receber(nome_pessoa IN VARCHAR, isNotebook IN NUMBER, descricao IN VARCHAR) IS
        id_pessoa NUMBER;
        BEGIN
            id_pessoa := f_procura_pessoa_por_nome(nome_pessoa);
            
            INSERT INTO reconecta_quero_receber
            VALUES (s_id_reconecta_quero_receber.nextval,id_pessoa, isNotebook, descricao,sysdate);
        END;

    PROCEDURE p_criar_doacao(nome_doador VARCHAR, nome_receptor VARCHAR) IS
        id_doador NUMBER;
        id_receptor NUMBER;
        BEGIN
            id_doador := f_procura_pessoa_por_nome(nome_doador);
            id_receptor := f_procura_pessoa_por_nome(nome_receptor);

            INSERT INTO reconecta_doacao
            VALUES (s_id_reconecta_doacao.nextval,id_doador, id_receptor, sysdate);
        END;

    function f_criar_computador(p_isNotebook number, p_isUsable number, p_descricao varchar) return number is
        v_id_computador number;
        begin
            v_id_computador := s_id_reconecta_computador.nextval;
            insert into reconecta_computador values(v_id_computador, p_isNotebook, p_isUsable, p_descricao);
            return v_id_computador;
        end;

END;
/