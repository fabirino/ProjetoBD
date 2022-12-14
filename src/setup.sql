-- Eliminar tableas se existirem
DROP TABLE IF EXISTS admins;
DROP TABLE IF EXISTS comentarios;
DROP TABLE IF EXISTS computadores;
DROP TABLE IF EXISTS televisoes;
DROP TABLE IF EXISTS telemoveis;
DROP TABLE IF EXISTS itens;
DROP TABLE IF EXISTS ratings;
DROP TABLE IF EXISTS produtos;
DROP TABLE IF EXISTS compras;
DROP TABLE IF EXISTS compradores;
DROP TABLE IF EXISTS vendedores;
DROP TABLE IF EXISTS notificacoes;
DROP TABLE IF EXISTS utilizadores;

-- Criar tabelas da DataBase
CREATE TABLE produtos (
	id BIGINT NOT NULL,
	nome VARCHAR(512) NOT NULL,
	descricao VARCHAR(512),
	data DATE DEFAULT CURRENT_DATE,
	preco FLOAT(5) NOT NULL,
	stock INTEGER NOT NULL,
	versao INTEGER NOT NULL,
	vendedor_id BIGINT NOT NULL,
	UNIQUE(id,versao),
	PRIMARY KEY(id,versao)
);
CREATE TABLE itens (
	quantidade INTEGER NOT NULL,
	compra_id BIGINT,
	produto_id BIGINT,
	versao_produto INTEGER NOT NULL,
	vendedor_id INTEGER NOT NULL,
	PRIMARY KEY(compra_id, produto_id,versao_produto)
);
CREATE TABLE ratings (
	valor INTEGER NOT NULL,
	comentario VARCHAR(512),
	comprador_id BIGINT NOT NULL,
	produto_id BIGINT NOT NULL,
	produto_versao INTEGER NOT NULL,
	PRIMARY KEY(produto_id,produto_versao,comprador_id)
);
CREATE TABLE utilizadores (
	id SERIAL,
	username VARCHAR(512) UNIQUE NOT NULL,
	password VARCHAR(512) NOT NULL,
	nome VARCHAR(512) NOT NULL,
	PRIMARY KEY(id)
);
CREATE TABLE compradores (
	utilizador_id BIGINT UNIQUE,
	morada VARCHAR(512) NOT NULL,
	PRIMARY KEY(utilizador_id)
);
CREATE TABLE vendedores (
	utilizador_id BIGINT UNIQUE,
	nif INTEGER NOT NULL,
	PRIMARY KEY(utilizador_id)
);
CREATE TABLE admins (
	utilizador_id BIGINT UNIQUE,
	PRIMARY KEY(utilizador_id)
);
CREATE TABLE comentarios(
	id SERIAL,
	texto VARCHAR(512) NOT NULL,
	utilizador_id BIGINT NOT NULL,
	comentario_pai_id BIGINT,
	produto_id BIGINT NOT NULL,
	produto_versao	INTEGER NOT NULL,
	PRIMARY KEY(id)
);
CREATE TABLE notificacoes (
	id SERIAL,
	vista BOOL DEFAULT 'f',
	data DATE NOT NULL,
	texto	 VARCHAR(512) NOT NULL,
	utilizador_id INTEGER NOT NULL,
	PRIMARY KEY(id)
);
CREATE TABLE televisoes (
	tamanho FLOAT(8) NOT NULL,
	resolucao VARCHAR(512) NOT NULL,
	produto_id BIGINT NOT NULL,
	produto_versao INTEGER NOT NULL,
	PRIMARY KEY(produto_id,produto_versao)
);
CREATE TABLE telemoveis (
	tamanho FLOAT(8) NOT NULL,
	ram INTEGER NOT NULL,
	rom INTEGER NOT NULL,
	produto_id BIGINT NOT NULL,
	produto_versao INTEGER NOT NULL,
	PRIMARY KEY(produto_id,produto_versao)
);
CREATE TABLE computadores (
	processador VARCHAR(512) NOT NULL,
	ram INTEGER NOT NULL,
	rom INTEGER NOT NULL,
	grafica VARCHAR(512),
	produto_id BIGINT NOT NULL,
	produto_versao INTEGER NOT NULL,
	PRIMARY KEY(produto_id,produto_versao)
);
CREATE TABLE compras (
	compra_id SERIAL,
	compra_valor FLOAT(8) NOT NULL,
	compra_data DATE NOT NULL,
	comprador_id BIGINT NOT NULL,
	PRIMARY KEY(compra_id)
);

-- Adicionar as FK nas tabelas
ALTER TABLE produtos
ADD CONSTRAINT produtos_fk1 FOREIGN KEY (vendedor_id) REFERENCES vendedores(utilizador_id);
ALTER TABLE itens
ADD CONSTRAINT itens_fk1 FOREIGN KEY (compra_id) REFERENCES compras(compra_id);
ALTER TABLE itens
ADD CONSTRAINT itens_fk2 FOREIGN KEY (produto_id, versao_produto) REFERENCES produtos(id, versao);
ALTER TABLE ratings
ADD CONSTRAINT ratings_fk1 FOREIGN KEY (comprador_id) REFERENCES compradores(utilizador_id);
ALTER TABLE ratings
ADD CONSTRAINT ratings_fk2 FOREIGN KEY (produto_id,produto_versao) REFERENCES produtos(id,versao);
ALTER TABLE compradores
ADD CONSTRAINT compradores_fk1 FOREIGN KEY (utilizador_id) REFERENCES utilizadores(id);
ALTER TABLE vendedores
ADD CONSTRAINT vendedores_fk1 FOREIGN KEY (utilizador_id) REFERENCES utilizadores(id);
ALTER TABLE admins
ADD CONSTRAINT admins_fk1 FOREIGN KEY (utilizador_id) REFERENCES utilizadores(id);
ALTER TABLE comentarios
ADD CONSTRAINT comentarios_fk1 FOREIGN KEY (utilizador_id) REFERENCES utilizadores(id);
ALTER TABLE comentarios
ADD CONSTRAINT comentarios_fk2 FOREIGN KEY (comentario_pai_id) REFERENCES comentarios(id);
ALTER TABLE comentarios
ADD CONSTRAINT comentarios_fk3 FOREIGN KEY (produto_id,produto_versao) REFERENCES produtos(id,versao);
ALTER TABLE televisoes
ADD CONSTRAINT televisoes_fk1 FOREIGN KEY (produto_id,produto_versao) REFERENCES produtos(id,versao);
ALTER TABLE telemoveis
ADD CONSTRAINT telemoveis_fk1 FOREIGN KEY (produto_id,produto_versao) REFERENCES produtos(id,versao);
ALTER TABLE computadores
ADD CONSTRAINT computadores_fk1 FOREIGN KEY (produto_id,produto_versao) REFERENCES produtos(id,versao);
ALTER TABLE compras
ADD CONSTRAINT compras_fk2 FOREIGN KEY (comprador_id) REFERENCES compradores(utilizador_id);

-- ALTER TABLE token_login ADD CONSTRAINT token_login_fk1 FOREIGN KEY (utilizador_id) REFERENCES utilizador(id);