
-- 1 - Verificar_Conflito_Agendamento (FUNCIONA)
DELIMITER //
CREATE TRIGGER Verificar_Conflito_Agendamento
BEFORE INSERT ON Agendamento
FOR EACH ROW
BEGIN
    DECLARE agendamentosExistentes INT;
    SELECT COUNT(*) INTO agendamentosExistentes
    FROM Agendamento
    WHERE dataAgenda = NEW.dataAgenda AND Funcionario_idFuncionario = NEW.Funcionario_idFuncionario;

    IF agendamentosExistentes > 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Conflito de horário para o funcionário.';
    END IF;
END;
//
DELIMITER ;

-- 2 - Atualizar_Senha (FUNCIONA)
DELIMITER //
CREATE TRIGGER AtualizarSenhaCliente 
BEFORE INSERT ON Cliente
FOR EACH ROW
BEGIN
    IF RIGHT(NEW.Senha, 8) != '_upsenha' THEN
        SET NEW.Senha = CONCAT(NEW.Senha, '_mobral');
    END IF;
END;
//
DELIMITER ;


-- 3 Atualizar_Estoque_Produtos (FUNCIONA)
DELIMITER //
CREATE TRIGGER Atualizar_Estoque_Produtos 
AFTER INSERT ON ItensVendaProd
FOR EACH ROW
BEGIN
    UPDATE Produtos
    SET quantidade = quantidade - NEW.qtd
    WHERE idProdutos = NEW.Produtos_idProdutos;
END;
//
DELIMITER ;

-- 4 ATT STATUS AGENDAMENTO
DELIMITER //
CREATE TRIGGER Atualizar_Status_Agendamento
BEFORE INSERT ON Agendamento
FOR EACH ROW
BEGIN
    IF NEW.dataAgenda > CURDATE() THEN
        SET NEW.status = 'Pendente';
    END IF;
END;
//
DELIMITER ;

-- 5 NOTIFICAR ALTERAÇÃO PREÇO SERVIÇO
DELIMITER //
CREATE TRIGGER Notificar_Alteracao_Preco_Servico
AFTER UPDATE ON Servico
FOR EACH ROW
BEGIN
    IF OLD.Valor != NEW.Valor THEN
        INSERT INTO Lembrete (Retorno, Manutencao, Funcionario_idFuncionario, Cliente_idCliente)
        VALUES (CONCAT('Valor alterado "', OLD.nome, '" Valor Alterado ', NEW.Valor), CURDATE(), 3, 6);
    END IF;
END;
//
DELIMITER ;

