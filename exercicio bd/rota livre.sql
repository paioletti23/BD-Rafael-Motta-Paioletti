CREATE DATABASE rota_livre;
USE rota_livre;


CREATE TABLE cliente (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cpf VARCHAR(14) UNIQUE NOT NULL,
    telefone VARCHAR(20),
    email VARCHAR(100),
    endereco VARCHAR(200),
    status ENUM('ativo', 'inadimplente') DEFAULT 'ativo'
);


CREATE TABLE funcionario (
    id_funcionario INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cargo VARCHAR(50),
    telefone VARCHAR(20)
);


CREATE TABLE categoria_veiculo (
    id_categoria INT AUTO_INCREMENT PRIMARY KEY,
    nome_categoria VARCHAR(50) NOT NULL,
    valor_diaria DECIMAL(10,2) NOT NULL
);


CREATE TABLE status_veiculo (
    id_status INT AUTO_INCREMENT PRIMARY KEY,
    descricao VARCHAR(50) NOT NULL
);


CREATE TABLE veiculo (
    id_veiculo INT AUTO_INCREMENT PRIMARY KEY,
    placa VARCHAR(10) UNIQUE NOT NULL,
    modelo VARCHAR(50),
    marca VARCHAR(50),
    ano INT,
    quilometragem_atual INT,
    id_categoria INT,
    id_status INT,
    FOREIGN KEY (id_categoria) REFERENCES categoria_veiculo(id_categoria),
    FOREIGN KEY (id_status) REFERENCES status_veiculo(id_status)
);


CREATE TABLE contrato_locacao (
    id_contrato INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT,
    id_veiculo INT,
    id_funcionario INT,
    data_retirada DATE,
    data_prevista_devolucao DATE,
    quilometragem_inicial INT,
    valor_diaria DECIMAL(10,2),
    tipo_seguro VARCHAR(50),
    condutor VARCHAR(100),
    FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente),
    FOREIGN KEY (id_veiculo) REFERENCES veiculo(id_veiculo),
    FOREIGN KEY (id_funcionario) REFERENCES funcionario(id_funcionario)
);


CREATE TABLE pagamento (
    id_pagamento INT AUTO_INCREMENT PRIMARY KEY,
    id_contrato INT,
    valor DECIMAL(10,2),
    data_pagamento DATE,
    forma_pagamento VARCHAR(50),
    status_pagamento VARCHAR(30),
    FOREIGN KEY (id_contrato) REFERENCES contrato_locacao(id_contrato)
);


CREATE TABLE multa (
    id_multa INT AUTO_INCREMENT PRIMARY KEY,
    id_contrato INT,
    descricao VARCHAR(200),
    valor DECIMAL(10,2),
    data_multa DATE,
    FOREIGN KEY (id_contrato) REFERENCES contrato_locacao(id_contrato)
);


CREATE TABLE manutencao (
    id_manutencao INT AUTO_INCREMENT PRIMARY KEY,
    id_veiculo INT,
    tipo ENUM('preventiva', 'corretiva'),
    descricao VARCHAR(200),
    data_inicio DATE,
    data_fim DATE,
    custo DECIMAL(10,2),
    FOREIGN KEY (id_veiculo) REFERENCES veiculo(id_veiculo)
);


CREATE TABLE historico_quilometragem (
    id_historico INT AUTO_INCREMENT PRIMARY KEY,
    id_veiculo INT,
    data_registro DATE,
    quilometragem INT,
    FOREIGN KEY (id_veiculo) REFERENCES veiculo(id_veiculo)
);


CREATE TABLE devolucao (
    id_devolucao INT AUTO_INCREMENT PRIMARY KEY,
    id_contrato INT UNIQUE,
    quilometragem_final INT,
    danos VARCHAR(200),
    combustivel_faltante DECIMAL(5,2),
    valor_extra DECIMAL(10,2),
    FOREIGN KEY (id_contrato) REFERENCES contrato_locacao(id_contrato)
);