-- Projeto de estudo: Jogo Online
-- Banco de dados criado para praticar SQL, regras de negócio e validações
-- Algumas ideias foram exploradas com apoio de IA, mas todas entendidas e adaptadas

CREATE TABLE usuarios (
    -- Identificador do usuário (login do jogo)
    id_login VARCHAR(50) NOT NULL,

    -- Email do usuário (não pode repetir)
    email VARCHAR(100) NOT NULL,

    -- Nome completo real
    nome_completo VARCHAR(150) NOT NULL,

    -- Data de nascimento (usada para validar idade)
    data_nascimento DATE NOT NULL,

    -- Senha do usuário
    -- Obs: aqui é esperado salvar o hash da senha gerado pela aplicação
    senha VARCHAR(255) NOT NULL,

    -- CPF sem pontuação (11 dígitos)
    cpf CHAR(11) NOT NULL,

    -- Indica se o usuário quer usar chat de voz
    usa_chat_voz ENUM('SIM','NAO') DEFAULT 'NAO',

    -- Caminho do documento com foto (obrigatório apenas se usar chat de voz)
    documento_path VARCHAR(255) DEFAULT NULL,

    -- Nome exibido dentro do jogo (não pode repetir)
    nome_ingame VARCHAR(50) NOT NULL
);

-- Trigger para validar regras antes de inserir um usuário
DELIMITER $$

CREATE TRIGGER antes_de_inserir_usuario
BEFORE INSERT ON usuarios
FOR EACH ROW
BEGIN
    -- Calcula a idade do usuário
    DECLARE idade INT;
    SET idade = TIMESTAMPDIFF(YEAR, NEW.data_nascimento, CURDATE());

    -- Se for menor de idade, não pode usar chat de voz
    IF idade < 18 AND NEW.usa_chat_voz = 'SIM' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Erro: menores de 18 anos não podem habilitar o chat de voz.';
    END IF;

    -- Se quiser usar chat de voz, precisa enviar documento com foto
    IF NEW.usa_chat_voz = 'SIM'
       AND (NEW.documento_path IS NULL OR NEW.documento_path = '') THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Erro: documento com foto é obrigatório para ativar o chat de voz.';
    END IF;
END$$

DELIMITER ;

-- Regras de unicidade para evitar dados duplicados
ALTER TABLE usuarios
    ADD PRIMARY KEY (id_login),
    ADD UNIQUE KEY email (email),
    ADD UNIQUE KEY cpf (cpf),
    ADD UNIQUE KEY nome_ingame (nome_ingame);
