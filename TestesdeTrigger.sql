-- Inserir atualizar senha
INSERT INTO Cliente (idCliente, Nome, Email, DataNasc,Senha)
VALUES (11, 'João Silva', 'joao122@email.com', "2000-08-12" ,'senha123');
SELECT * FROM Cliente WHERE idCliente = 11;
-- Verificar_Conflito_Agendamento
INSERT INTO Agendamento (idAgendamento, dataAgenda, `Status`,Funcionario_idFuncionario, Cliente_idCliente) 
VALUES (1, '2024-12-18 10:00:00', "Presente" ,1, 11);
INSERT INTO Agendamento (idAgendamento, dataAgenda,`Status`,Funcionario_idFuncionario, Cliente_idCliente) 
VALUES (2, '2024-12-18 10:00:00', "Pendente" ,1, 8);

-- Atualização de quantidade de produto
SELECT idProdutos, nome, quantidade
FROM Produtos
WHERE idProdutos = 1;

INSERT INTO ItensVendaProd (Venda_idVenda, Pagamento_idPagamento, Produtos_idProdutos, qtd)
VALUES (8, 2, 1, 2);

SELECT idProdutos, nome, quantidade
FROM Produtos
WHERE idProdutos = 1;
-- 

-- Status Agendamento
INSERT INTO Agendamento (dataAgenda, status, Funcionario_idFuncionario, Cliente_idCliente)
VALUES (CURDATE() + INTERVAL 1 DAY, 'Pendente', 1, 4);

SELECT idAgendamento, dataAgenda, Status 
FROM Agendamento
WHERE Funcionario_idFuncionario = 1
ORDER BY dataAgenda DESC LIMIT 1;

-- Inserir um agendamento com data passada
INSERT INTO Agendamento (dataAgenda, status, Funcionario_idFuncionario, Cliente_idCliente)
VALUES (CURDATE() - INTERVAL 1 DAY, 'Pendente', 2, 5);

-- Consultar o status do agendamento inserido com data passada
SELECT idAgendamento, dataAgenda, Status 
FROM Agendamento
WHERE Funcionario_idFuncionario = 1
ORDER BY dataAgenda DESC LIMIT 3;
-- 

-- NOTIFICAR ALTERAÇÃO PREÇO SERVIÇO
SELECT * FROM Servico;
UPDATE Servico
SET Valor = Valor + 10
WHERE idServico = 4; 
SELECT * FROM Lembrete;

