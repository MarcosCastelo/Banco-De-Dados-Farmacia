DROP TABLE CLIENTE;
DROP TABLE MARCA;
DROP TABLE PRODUTO;
DROP TABLE MEDICO;
DROP TABLE LOCAL;
DROP TABLE LOJA;
DROP TABLE ESTOQUE;


CREATE TABLE cliente (
    cliente_id SERIAL PRIMARY KEY,
    cpf VARCHAR(11) NOT NULL,
    nome VARCHAR(50) NOT NULL,
    email VARCHAR(50) NOT NULL,
    telefone VARCHAR(11) NOT NULL,
    data_nascimento DATE NOT NULL,
    ativo BOOLEAN DEFAULT true
);

CREATE TABLE MARCA(
    marca_id serial primary key,
    nome varchar(50) not null
);

CREATE TABLE produto (
	produto_id serial primary key,
	nome varchar(50) not null,
	marca int not null,
	categoria int not null,
	foreign key (marca) references marca(marca_id),
	foreign key (categoria) references categoria(categoria_id)
);

CREATE TABLE CATEGORIA(
	categoria_id serial primary key,
	nome varchar(50) not null
);

CREATE TABLE MEDICO(
	medico_id serial primary key,
	crm varchar(5) not null,
	nome varchar(50) not null,
	telefone varchar(11)
);

CREATE TABLE RECEITA(
	receita_id serial primary key,
	link varchar(50) not null
);

CREATE TABLE LOCAL(
	local_id serial primary key,
	bairro varchar(50) not null,
	valor decimal not null
);

CREATE TABLE LOJA(
	loja_id serial primary key,
	nome varchar(50) not null,
	endereco varchar(50) not null
);

CREATE TABLE ESTOQUE(
	loja_id int not null,
	produto int not null,
	preco decimal not null,
	quantidade int not null,
	foreign key (loja_id) references loja(loja_id),
	foreign key (produto) references produto(produto_id)
);

CREATE TABLE PRECO(
	fornecedor int not null,
	produto int not null,
	valor decimal not null,
	foreign key(fornecedor) references fornecedor(fornecedor_id),
	foreign key(produto) references produto(produto_id)
);

CREATE TABLE FORNECEDOR(
	fornecedor_id serial primary key,
	nome varchar(50)
);

CREATE TABLE COMPRA(
	compra_id serial primary key,
	fornecedor int not null,
	HORA_DATA TIMESTAMP NOT NULL,
	foreign key(fornecedor) references fornecedor(fornecedor_id)
);

CREATE TABLE ITEM_COMPRA(
	ITEM_COMPRA_ID SERIAL PRIMARY KEY,
	COMPRA_ID INT NOT NULL,
	ESTOQUE_ID INT NOT NULL,
	QUANTIDADE INT NOT NULL,
	VALOR DECIMAL NOT NULL,
	FOREIGN KEY(COMPRA_ID) REFERENCES COMPRA(COMPRA_ID),
	FOREIGN KEY(ESTOQUE) REFERENCES ESTOQUE(ESTOQUE_ID)
	
	
);

CREATE TABLE VENDA (
	VENDA_ID SERIAL PRIMARY KEY,
	CLIENTE INT NOT NULL,
	LOCAL INT NOT NULL,
	HORA_DATA TIMESTAMP NOT NULL,
	FOREIGN KEY(CLIENTE) REFERENCES CLIENTE(CLIENTE_ID),
	FOREIGN KEY(LOCAL) REFERENCES LOCAL(LOCAL_ID)
);

CREATE TABLE VENDA_RECEITA(
	VENDA_RECEITA_ID SERIAL PRIMARY KEY,
	VENDA INT NOT NULL,
	RECEITA INT,
	FOREIGN KEY(VENDA) REFERENCES VENDA(VENDA_ID),
	FOREIGN KEY(RECEITA) REFERENCES RECEITA(RECEITA_ID)
);

CREATE TABLE ITEM_VENDA(
	ITEM_VENDA_ID SERIAL PRIMARY KEY,
	VENDA INT NOT NULL,
	ESTOQUE INT NOT NULL,
	QUANTIDADE INT NOT NULL,
	VALOR DECIMAL NOT NULL,
	FOREIGN KEY(VENDA) REFERENCES VENDA(VENDA_ID),
	FOREIGN KEY(ESTOQUE) REFERENCES ESTOQUE(ESTOQUE_ID)
);

CREATE TABLE ITEM_COMPRA(
	ITEM_COMPRA_ID SERIAL PRIMARY KEY,
	COMPRA INT NOT NULL,
	ESTOQUE INT NOT NULL,
	QUANTIDADE INT NOT NULL,
	VALOR DECIMAL NOT NULL,
	FOREIGN KEY(COMPRA) REFERENCES COMPRA(COMPRA_ID),
	FOREIGN KEY(ESTOQUE) REFERENCES ESTOQUE(ESTOQUE_ID)
);
