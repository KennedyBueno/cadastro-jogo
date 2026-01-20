CREATE DATABASE IF NOT EXISTS jogo_db;
USE jogo_db;

CREATE TABLE usuarios (
    id_login VARCHAR(50) PRIMARY KEY, -- id (login)
    email VARCHAR(100) NOT NULL UNIQUE, -- email
    nome_completo VARCHAR(150) NOT NULL, -- nome completo
    data_nascimento DATE NOT NULL, -- nascimento
    senha VARCHAR(255) NOT NULL, -- senha
    cpf CHAR(11) NOT NULL UNIQUE, -- CPF
    usa_chat_voz ENUM('SIM', 'NAO') DEFAULT 'NAO', -- Pretende usar o chat de voz?
    documento_path VARCHAR(255), -- documento com foto
    nome_ingame VARCHAR(50) NOT NULL UNIQUE, -- Nome In-Game
    
    CONSTRAINT chk_nome_ingame CHECK (nome_ingame <> id_login AND nome_ingame <> nome_completo)
);

DELIMITER //

CREATE TRIGGER trg_valida_cadastro
BEFORE INSERT ON usuarios
FOR EACH ROW
BEGIN
    DECLARE idade INT;
    SET idade = TIMESTAMPDIFF(YEAR, NEW.data_nascimento, CURDATE());

    IF idade < 18 AND NEW.usa_chat_voz = 'SIM' THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Chat de voz permitido apenas para maiores de 18 anos.';
    END IF;

    IF NEW.usa_chat_voz = 'SIM' AND (NEW.documento_path IS NULL OR NEW.documento_path = '') THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Documento obrigatorio para chat de voz.';
    END IF;
END; //

DELIMITER ;
