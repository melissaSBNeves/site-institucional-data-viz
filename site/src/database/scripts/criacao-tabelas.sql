CREATE DATABASE safe_monitor;
USE safe_monitor;


CREATE TABLE empresa (
   IdEmpresa INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
   nome_empresa VARCHAR(255) NOT NULL,
   cnpj VARCHAR(45) NOT NULL,
   razao_social VARCHAR(255) NOT NULL,
   telefone_celular VARCHAR(15) NOT NULL,
   telefone_fixo VARCHAR(14) NULL,
   telefone2_celular VARCHAR(15) NULL,
   tipo_instituicao VARCHAR(30) NOT NULL,
   privada VARCHAR(1) NOT NULL,
   cep VARCHAR(9) NULL,
   cidade VARCHAR(80) NULL,
   estado VARCHAR(80) NULL,
   rua VARCHAR(150) NULL,
   numero INT(5) NULL,
   complemento VARCHAR(45) NULL,
   bairro VARCHAR(45) NULL,
   CONSTRAINT chkTipoInstituicao CHECK(tipo_instituicao in ("escola", "faculdade", "universidade")),
   CONSTRAINT chkPrivada CHECK (privada in ("s", "n"))
   );


CREATE TABLE usuario (
   idUsuario INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
   email  VARCHAR(120) NOT NULL,
   senha VARCHAR(30) NOT NULL,
   nome  VARCHAR(45) NULL,
   cargo VARCHAR(45) NULL,
   cadastrar TINYINT NOT NULL,
   leitura TINYINT NOT NULL,
   alterar TINYINT NOT NULL,
   deletar TINYINT NOT NULL,
   capturar TINYINT NOT NULL,
   fk_empresa INT NOT NULL,
   CONSTRAINT chk_cadastro CHECK (cadastrar IN (0, 1)), 
   CONSTRAINT chk_leitura CHECK (leitura IN (0, 1)), 
   CONSTRAINT chk_alterar CHECK (alterar IN (0, 1)), 
   CONSTRAINT chk_deletar CHECK (deletar IN (0, 1)), 
   CONSTRAINT chk_capturar CHECK (capturar IN (0, 1)), 
   CONSTRAINT const_fkEmpresa FOREIGN KEY (fk_empresa) REFERENCES empresa (IdEmpresa)
);

CREATE TABLE sala_de_aula (
   idSala INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
   nome VARCHAR(45) NOT NULL,
   localizacao TEXT NOT NULL,
   fk_usuario INT NOT NULL,
   CONSTRAINT const_fkUsuario FOREIGN KEY (fk_usuario)  REFERENCES usuario(idUsuario)
  );


CREATE TABLE maquina (
   idMaquina INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
   modelo VARCHAR(45) NULL,
   numero_serie VARCHAR(15) NULL,
   marca  VARCHAR(30) NULL,
   sistema_operacional VARCHAR(15) NULL,
   armazenamento_disco DECIMAL NULL,
   espaco_livre_disco DECIMAL NULL,
   endereco_ipv4 VARCHAR(13) NULL,
   capacidade_total_ram DECIMAL NULL,
   fk_sala INT NOT NULL,
   CONSTRAINT const_fkSala FOREIGN KEY (fk_sala) REFERENCES sala_de_aula (idSala)
);


CREATE TABLE processo (
   idProcesso INT NOT NULL AUTO_INCREMENT,
   nome VARCHAR(45) NULL,
   status_proc  VARCHAR(45) NULL,
   tempo_execucao VARCHAR(45) NULL,
   data_hora DATETIME NULL,
   fk_maquina INT NOT NULL,
   CONSTRAINT const_fkMaquina FOREIGN KEY (fk_maquina) REFERENCES maquina (idMaquina),
   PRIMARY KEY (idProcesso, fk_maquina)
);

CREATE TABLE  componente (
  idComponente INT NOT NULL AUTO_INCREMENT,
  nome VARCHAR(45) NULL,
  descricao TEXT NULL,
  fk_maquina_proc INT NOT NULL,
  CONSTRAINT const_fkMaquina1_proc FOREIGN KEY (fk_maquina_proc) REFERENCES maquina (idMaquina),
  PRIMARY KEY (idComponente, fk_maquina_proc)
);

CREATE TABLE captura_dados(
   idCaptura INT NOT NULL AUTO_INCREMENT,
   nome_monitoramento VARCHAR(45) NULL,
   valor_monitorado DECIMAL NULL,
   data_hora DATETIME NULL,
   fk_componente INT NOT NULL,
   fk_maquina_captura INT NOT NULL,
   PRIMARY KEY (idCaptura, fk_componente, fk_maquina_captura),
   CONSTRAINT const_fkComponente FOREIGN KEY (fk_componente) REFERENCES componente (idComponente),
   CONSTRAINT const_fkMaquinaCaptura FOREIGN KEY (fk_maquina_captura) REFERENCES maquina (idMaquina)
);

CREATE TABLE C (
  idNotificacao INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  data_hora VARCHAR(45) NULL
  );

CREATE TABLE tipo_notificacao (
   idTipo_notificacao INT NOT NULL AUTO_INCREMENT,
   nome VARCHAR(45) NULL,
   valor_inicial DECIMAL NULL,
   valor_final DECIMAL NULL,
   fk_notificacao INT NOT NULL,
   fk_captura_tipoNot INT NOT NULL,
   fk_componente_tipoNot INT NOT NULL,
   fk_maquina_tipoNot INT NOT NULL,
   PRIMARY KEY (idTipo_notificacao, fk_notificacao, fk_captura_tipoNot, fk_componente_tipoNot, fk_maquina_tipoNot),
   CONSTRAINT const_fkNotificacao FOREIGN KEY (fk_notificacao) REFERENCES notificacao (idNotificacao),
   CONSTRAINT const_fkCapturaTipoNot FOREIGN KEY (fk_captura_tipoNot) REFERENCES captura_dados (idCaptura),
   CONSTRAINT const_fkComponenteTipoNot FOREIGN KEY (fk_componente_tipoNot) REFERENCES componente (idComponente),
   CONSTRAINT const_fkMaquinaTipoNot FOREIGN KEY (fk_maquina_tipoNot) REFERENCES maquina (idMaquina)
   );
   
   




