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

create or replace function retorna_nome_doador(p_nome_doador varchar) return number is

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
/

declare
v_id number;
begin
v_id := retorna_nome_doador('Cristian');
dbms_output.put_line('ID do doador: ' || v_id);
end;
/
---------------------------------------------retorna o id do doador a partir do nome da pessoa

create or replace function retorna_nome_recebedor(p_nome_recebedor varchar) return number is

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
/

declare
v_id number;
begin
v_id := retorna_nome_recebedor('Ivania');
dbms_output.put_line('ID do recebedor: ' || v_id);
end;
/
---------------------------------------------retorna o id do recebedor a partir do nome da pessoa

--Procedimento para criar uma pessoa no sistema
CREATE OR REPLACE PROCEDURE p_cria_pessoa (nome IN VARCHAR, telefone IN NUMBER, email IN VARCHAR, cidade IN VARCHAR) IS
    BEGIN
        INSERT INTO reconecta_pessoa VALUES(s_id_reconecta_pessoa.nextval,nome, telefone,email,cidade);
    END;
    
exec p_cria_pessoa('Bruno', '998878278','bruno@gmail.com','Belem');

create or replace procedure localiza_pessoas_de_cidade_especifica(nome_cidade varchar) is

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
/

exec localiza_pessoas_de_cidade_especifica('Alvorada');
--procedure com cursor que lista todas as pessoas de uma cidade específica


create or replace procedure localiza_doador_de_uma_doacao(p_id_doacao reconecta_doacao.id_doacao%type) is

cursor c_nomes is
select nome_pessoa
from reconecta_doacao
left join reconecta_quero_doar
on reconecta_doacao.id_quero_doar=reconecta_quero_doar.id_quero_doar
left join reconecta_pessoa
on reconecta_quero_doar.id_pessoa=reconecta_pessoa.id_pessoa
where reconecta_doacao.id_doacao=p_id_doacao;

begin

for r_nomes in c_nomes loop
dbms_output.put_line('Doador da doação ' || p_id_doacao);
dbms_output.put_line(r_nomes.nome_pessoa);
end loop;

end;
/

exec localiza_doador_de_uma_doacao(3);
--indica o nome do doador a partir do id da doação

create or replace procedure localiza_recebor_de_uma_doacao(p_id_doacao reconecta_doacao.id_doacao%type) is

cursor c_nomes is
select nome_pessoa
from reconecta_doacao
left join reconecta_quero_receber
on reconecta_doacao.id_quero_receber=reconecta_quero_receber.id_quero_receber
left join reconecta_pessoa
on reconecta_quero_receber.id_pessoa=reconecta_pessoa.id_pessoa
where reconecta_doacao.id_doacao=p_id_doacao;

begin

for r_nomes in c_nomes loop
dbms_output.put_line('Recebedor da doação ' || p_id_doacao);
dbms_output.put_line(r_nomes.nome_pessoa);
end loop;

end;
/

exec localiza_recebor_de_uma_doacao(3);
--indica o nome do recebedor a partir do id da doação


create or replace procedure listar_computadores_usaveis is

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
/
exec listar_computadores_usaveis;
--lista quais são os computadores usáveis