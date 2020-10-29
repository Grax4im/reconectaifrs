/*Tabela Pessoa
id_pessoa - Chave Primaria
nome_pessoa - varchar
telefone - number(11)
email - varchar
cidade - varchar
*/
CREATE TABLE reconecta_pessoa(
    id_pessoa number constraint pk_pessoa primary key,
    nome_pessoa varchar2(30),
    telefone number,
    email varchar2(100),
    cidade varchar2(30)
);
/*
Tabela Computador
id_computador - chave primaria
isNotebook - booleano
isUsable - booleano
descricao - varchar
*/
CREATE TABLE reconecta_computador(
    id_computador number constraint pk_computador primary key,
    isNotebook NUMBER(1),
    isUsable NUMBER(1),
    descricao varchar2(200)
);
/*
Tabela quero_doar
id_quero_doar - chave primaria
id_pessoa - chave estrangeira
id_computador - chave estrangeira
data - date
*/
CREATE TABLE reconecta_quero_doar(
    id_quero_doar number constraint pk_quero_doar primary key,
    id_pessoa number,
    id_computador number,
    data date
);
/*
Tabela quero_receber
id_quero_receber - chave primaria
id_pessoa - chave estrangeira
isNotebook - booleano
descricao - varchar
data - date
*/
CREATE TABLE reconecta_quero_receber(
    id_quero_receber number constraint pk_quero_receber primary key,
    id_pessoa number,
    isNotebook NUMBER(1),
    descricao varchar2(255),
    data date
);
/*Tabela doacao
id_doacao - chave primaria
id_quero_doar - chave estrangeira
id_quero_receber - chave estrangeira
data -date
*/
CREATE TABLE reconecta_doacao(
    id_doacao number constraint pk_doacao primary key,
    id_quero_doar number,
    id_quero_receber number,
    data date
);

alter table reconecta_quero_doar add (constraint fk_quero_doar_pessoa foreign key (id_pessoa) references reconecta_pessoa(id_pessoa));

alter table reconecta_quero_doar add (constraint fk_quero_doar_computador foreign key (id_computador) references reconecta_computador(id_computador));

alter table reconecta_quero_receber add (constraint fk_quero_receber_pessoa foreign key (id_pessoa) references reconecta_pessoa(id_pessoa));

alter table reconecta_doacao add (constraint fk_doacao_quero_doar foreign key (id_quero_doar) references reconecta_quero_doar(id_quero_doar));

alter table reconecta_doacao add (constraint fk_doacao_quero_receber foreign key (id_quero_receber) references reconecta_quero_receber(id_quero_receber));


CREATE SEQUENCE s_id_reconecta_pessoa nocache;

CREATE SEQUENCE s_id_reconecta_computador nocache;

CREATE SEQUENCE s_id_reconecta_quero_doar nocache;

CREATE SEQUENCE s_id_reconecta_quero_receber nocache;

CREATE SEQUENCE s_id_reconecta_doacao nocache;