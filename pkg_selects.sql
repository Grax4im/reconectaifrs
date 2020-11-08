-- pacote com todos as procedures e functions de selecao de dados 
CREATE OR REPLACE PACKAGE pkg_selects IS
    FUNCTION   f_procura_pessoa_por_nome(v_nome VARCHAR) RETURN NUMBER;
    FUNCTION   f_retorna_id_doador(p_nome_doador VARCHAR) RETURN NUMBER;
    FUNCTION   f_retorna_id_recebedor(p_nome_recebedor VARCHAR) RETURN NUMBER;
    
    PROCEDURE localiza_pessoas_de_cidade_especifica(nome_cidade varchar);
    PROCEDURE localiza_doador_de_uma_doacao(p_id_doacao reconecta_doacao.id_doacao%type, p_nome_doador out varchar2);
    PROCEDURE busca_nome_dos_doadores(p_doadores out sys_refcursor);
    PROCEDURE listar_computadores_usaveis;
    
END pkg_selects;
/
CREATE OR REPLACE PACKAGE BODY pkg_selects AS

    FUNCTION f_procura_pessoa_por_nome(v_nome VARCHAR) RETURN NUMBER IS
        v_id_pessoa NUMBER;
        BEGIN
            SELECT id_pessoa
            INTO v_id_pessoa
            FROM reconecta_pessoa
            WHERE nome_pessoa = v_nome;
            
            RETURN v_id_pessoa;
        END;
        
    function f_retorna_id_doador(p_nome_doador varchar) return number is
        v_id_doador number;
        begin
            select id_quero_doar
            into v_id_doador
            from reconecta_quero_doar
            inner join reconecta_pessoa
            on reconecta_quero_doar.id_pessoa=reconecta_pessoa.id_pessoa
            where reconecta_pessoa.nome_pessoa=p_nome_doador;
            return v_id_doador;
        end;
        
    function f_retorna_id_recebedor(p_nome_recebedor varchar) return number is
        v_id_recebedor number;
        begin
            select id_quero_receber
            into v_id_recebedor
            from reconecta_quero_receber
            inner join reconecta_pessoa
            on reconecta_quero_receber.id_pessoa=reconecta_pessoa.id_pessoa
            where reconecta_pessoa.nome_pessoa=p_nome_recebedor;
            
            return v_id_recebedor;
        end;
        
    procedure localiza_pessoas_de_cidade_especifica(nome_cidade varchar) is

        cursor c_pessoas is
            select *
            from reconecta_pessoa
            where cidade=nome_cidade;
        
        begin
            for r_pessoa in c_pessoas loop
            
            dbms_output.put_line('------------------');
            dbms_output.put_line(r_pessoa.id_pessoa);
            dbms_output.put_line(r_pessoa.nome_pessoa);
        
        end loop;
    end;
    
   procedure localiza_doador_de_uma_doacao(p_id_doacao reconecta_doacao.id_doacao%type, p_nome_doador out varchar2) is

    begin
        select nome_pessoa
        into p_nome_doador
        from reconecta_doacao
        left join reconecta_quero_doar
        on reconecta_doacao.id_quero_doar=reconecta_quero_doar.id_quero_doar
        left join reconecta_pessoa
        on reconecta_quero_doar.id_pessoa=reconecta_pessoa.id_pessoa
        where reconecta_doacao.id_doacao=p_id_doacao;
    end;
    
    procedure busca_nome_dos_doadores(p_doadores out sys_refcursor) as

    begin
        open p_doadores for
        select nome_pessoa
        from reconecta_pessoa
        inner join reconecta_quero_doar
        on reconecta_pessoa.id_pessoa=reconecta_quero_doar.id_pessoa;
    end;
    
    procedure listar_computadores_usaveis is
        cursor c_computadores_usaveis is
        select * from reconecta_computador
        where isusable=1;
        
        begin 
            for r_computadores_usaveis in c_computadores_usaveis loop
                dbms_output.put_line('----------');
                dbms_output.put_line('IDCOMPUTADOR - '||r_computadores_usaveis.id_computador);
                dbms_output.put_line('ISNOTEBOOK - '||r_computadores_usaveis.isnotebook);
                dbms_output.put_line('ISUSABLE - '||r_computadores_usaveis.isusable);
                dbms_output.put_line('DESCRICAO - '||r_computadores_usaveis.descricao);
            
            end loop;
        end;
END;
/