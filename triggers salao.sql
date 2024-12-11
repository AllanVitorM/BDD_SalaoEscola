-- 6 TRIGGERS
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

-- 2 - Verificar_Estoque_Produtos (FUNCIONA)
DELIMITER // 
CREATE TRIGGER Verificar_Estoque_Produtos 
BEFORE INSERT ON ItensVendaProd
FOR EACH ROW
BEGIN
    DECLARE qtdAtual INT;
    SELECT quantidade INTO qtdAtual FROM Produtos WHERE idProdutos = NEW.Produtos_idProdutos;
    IF qtdAtual < NEW.qtd THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Estoque insuficiente para o produto.';
    END IF;
END;
//
DELIMITER ;

-- 3 - Atualizar_Saldo_Cliente (FUNCIONA)
DELIMITER //
CREATE TRIGGER Atualizar_Saldo_Cliente 
AFTER INSERT ON Venda
FOR EACH ROW
BEGIN
    UPDATE Cliente
    SET Senha = CONCAT(Senha, '_upd') 
    WHERE idCliente = NEW.Cliente_idCliente;
END;
//
DELIMITER ;

-- 4 - Atualizar_Receita_Financeiro (FUNCIONA)
DELIMITER //
CREATE TRIGGER Atualizar_Receita_Financeiro
AFTER INSERT ON Venda
FOR EACH ROW
BEGIN
    UPDATE Financeiro
    SET receita_total = receita_total + NEW.valor;
END;
//
DELIMITER ;

-- 5 - Registrar_Historico_Agendamentos (FUNCIONA)
DELIMITER //
CREATE TRIGGER Registrar_Historico_Agendamentos
AFTER DELETE ON Agendamento
FOR EACH ROW
BEGIN
    INSERT INTO HistoricoAgendamentos (idAgendamento, dataAgenda, Cliente_idCliente, Funcionario_idFuncionario, motivoCancelamento)
    VALUES (OLD.idAgendamento, OLD.dataAgenda, OLD.Cliente_idCliente, OLD.Funcionario_idFuncionario, 'Cancelado pelo sistema.');
END;
//
DELIMITER ;

-- 6 -  Atualizar_Estoque_Produtos (FUNCIONA)
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




