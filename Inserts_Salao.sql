INSERT INTO `SalaoEscola_PI`.`Endereco` (`Rua`, `Bairro`, `Cidade`, `UF`) VALUES
("Rua São José", "Iputinga", "Recife", "PE"),
("Av. Bernardo Vieira de Melo", "Piedade", "Jaboatão dos Guararapes", "PE"),
("Av. Conde da Boa Vista", "Boa Vista", "Recife", "PE"),
("Rua da Esperança", "Afogados", "Recife", "PE"),
("Avenida Rosa e Silva", "Aflitos", "Recife", "PE"),
("Rua das Acácias", "Coelhos", "Recife", "PE"),
("Rua das Orquídeas", "Cordeiro", "Recife", "PE"),
("Rua do Futuro", "Cordeiro", "Recife", "PE"),
("Rua da Liberdade", "Jardim São Paulo", "Recife", "PE"),
("Rua da Paz", "Tamarineira", "Recife", "PE"),
("Rua das Flores", "Boa Viagem", "Recife", "PE"),
("Rua do Sol", "Apipucos", "Recife", "PE"),
("Rua 1", "Casa Amarela", "Recife", "PE"),
("Rua 2", "Vasco da Gama", "Recife", "PE"),
("Rua 3", "Jardim São Paulo", "Recife", "PE"),
("Rua 4", "Caiara", "Recife", "PE"),
("Avenida Conselheiro Rosa e Silva", "Aflitos", "Recife", "PE"),
("Rua da Independência", "Tamarineira", "Recife", "PE"),

-- Endereços em Jaboatão
("Rua do Comércio", "Centro", "Jaboatão dos Guararapes", "PE"),
("Avenida General Barreto de Menezes", "Piedade", "Jaboatão dos Guararapes", "PE"),
("Rua Manoel de Souza", "Prazeres", "Jaboatão dos Guararapes", "PE"),
("Rua das Mangueiras", "Cavaleiro", "Jaboatão dos Guararapes", "PE"),

-- Endereços em Olinda
("Avenida Brasil", "Casa Caiada", "Olinda", "PE"),
("Rua do Sol", "Olinda", "Olinda", "PE"),
("Rua da Prainha", "Forte de São João", "Olinda", "PE"),
("Rua da Aurora", "Carmo", "Olinda", "PE"),

-- Endereços em Paulista
("Rua da Liberdade", "Jardim Paulista", "Paulista", "PE"),
("Avenida Marechal Floriano Peixoto", "Paulista", "Paulista", "PE"),
("Rua da Esperança", "Maranguape I", "Paulista", "PE"),
("Rua João Pessoa", "Centro", "Paulista", "PE"),

-- Endereços em Abreu Lima
("Rua da Alegria", "Centro", "Abreu e Lima", "PE"),
("Avenida do Comércio", "Novo Abreu", "Abreu e Lima", "PE"),
("Rua da Paz", "Pau Ferreiro", "Abreu e Lima", "PE"),
("Rua das Flores", "Jardim Brasil", "Abreu e Lima", "PE");


INSERT INTO `SalaoEscola_PI`.`Funcionario` (`Nome`, `DataNasc`, `Cargo`, `Salario`, `CargaHoraria`, `Endereco_idEndereco`) VALUES
('João Silva', '1985-05-10 00:00:00', 'Cabeleireiro', 2500.00, '40h', 1),
('Maria Souza', '1990-07-15 00:00:00', 'Manicure', 2000.00, '30h', 2),
('Pedro Oliveira', '1982-03-22 00:00:00', 'Esteticista', 3000.00, '40h', 3),
('Ana Costa', '1995-11-05 00:00:00', 'Recepcionista', 1800.00, '20h', 4),
('Carlos Lima', '1988-09-30 00:00:00', 'Barbeiro', 2700.00, '40h', 5),
('Julia Pereira', '1992-02-12 00:00:00', 'Depiladora', 2200.00, '30h', 6),
('Roberto Martins', '1978-06-01 00:00:00', 'Gerente', 3500.00, '40h', 7),
('Mariana Andrade', '1993-04-18 00:00:00', 'Maquiadora', 2500.00, '30h', 8),
('Fernando Rocha', '1986-10-25 00:00:00', 'Técnico Capilar', 2800.00, '40h', 9),
('Clara Mendes', '1997-08-08 00:00:00', 'Consultora', 2300.00, '20h', 10);

INSERT INTO `SalaoEscola_PI`.`Cliente` (`Email`, `DataNasc`, `Senha`, `Nome`, `Endereco_idEndereco`) VALUES
('joao.dograu@gmail.com', '1990-05-10 00:00:00', '12345', 'João Lopes', 1),
('fernanda.torres@outlook.com', '1992-07-15 00:00:00', 'senha1', 'Fernanda Torres', 2),
('Jose.clt@example.com', '1987-03-22 00:00:00', 'senha2', 'José Almeida', 3),
('Vanessa.daMata@gmail.com', '1995-11-05 00:00:00', 'senha3', 'Vanessa da Mata', 4),
('Gilberto.gil@hotmail.com', '1988-09-30 00:00:00', 'senha4', 'Gilberto Gil', 5),
('Ivete.sangalo@hotmail.com', '1992-02-12 00:00:00', 'senha5', 'Ivete Sangalo', 6),
('roberto.carlos@gmail.com', '1978-06-01 00:00:00', 'senha6', 'Roberto Carlos', 7),
('anamaria.maisvc@gmail.com', '1993-04-18 00:00:00', 'senha7', 'Ana Maria Braga', 8),
('Wesley.safadao@yahoo.com', '1986-10-25 00:00:00', 'senha8', 'Wesley Oliveira', 9),
('clara.nunes@hotmail.com', '1997-08-08 00:00:00', 'senha9', 'Clara Nunes', 10);

INSERT INTO `SalaoEscola_PI`.`Venda` (`dataVenda`, `valor`, `Desconto`, `Funcionario_idFuncionario`, `Cliente_idCliente`) VALUES
('2024-01-01 10:00:00', 100.00, 10.00, 1, 1),
('2024-01-02 11:00:00', 150.00, 15.00, 2, 2),
('2024-01-03 12:00:00', 200.00, 20.00, 3, 3),
('2024-01-04 13:00:00', 250.00, 25.00, 4, 4),
('2024-01-05 14:00:00', 300.00, 30.00, 5, 5),
('2024-01-06 15:00:00', 350.00, 35.00, 6, 6),
('2024-01-07 16:00:00', 400.00, 40.00, 7, 7),
('2024-01-08 17:00:00', 450.00, 45.00, 8, 8),
('2024-01-09 18:00:00', 500.00, 50.00, 9, 9),
('2024-01-10 19:00:00', 550.00, 55.00, 10, 10);


INSERT INTO `SalaoEscola_PI`.`Servico` (`idServico`, `Nome`, `Valor`, `quantidade`, `descricao`) VALUES
(1, 'Corte de cabelo', 50.00, 20, 'Corte profissional'),
(2, 'Manicure', 30.00, 30, 'Cuidados com unhas'),
(3, 'Pedicure', 35.00, 25, 'Tratamento para pés'),
(4, 'Escova', 40.00, 15, 'Escova modeladora'),
(5, 'Maquiagem', 70.00, 10, 'Maquiagem social'),
(6, 'Depilação', 60.00, 20, 'Depilação corporal'),
(7, 'Limpeza de pele', 90.00, 12, 'Tratamento facial'),
(8, 'Coloração', 120.00, 8, 'Coloração capilar'),
(9, 'Massagem', 100.00, 5, 'Relaxamento'),
(10, 'Hidratação', 80.00, 15, 'Hidratação capilar');


INSERT INTO `SalaoEscola_PI`.`Produtos` (`Nome`, `Preco`, `quantidade`) VALUES
('Shampoo', 20.00, 50),
('Condicionador', 25.00, 40),
('Creme para pentear', 30.00, 30),
('Secador', 200.00, 10),
('Prancha', 250.00, 5),
('Tesoura', 100.00, 15),
('Toalha', 10.00, 100),
('Batom', 15.00, 60),
('Esmalte', 10.00, 80),
('Removedor de esmalte', 12.00, 70);


INSERT INTO `SalaoEscola_PI`.`Lembrete` (`idLembrete`, `Retorno`, `Manutencao`, `Funcionario_idFuncionario`, `Cliente_idCliente`) VALUES
(1, 'Retorno em 1 mês', 'Checar manutenção de cabelo', 1, 1),
(2, 'Retorno em 2 meses', 'Verificar coloração', 2, 2),
(3, 'Retorno em 3 meses', 'Corte programado', 3, 3),
(4, 'Retorno em 1 mês', 'Hidratação capilar', 4, 4),
(5, 'Retorno em 2 semanas', 'Revisar corte', 5, 5),
(6, 'Retorno em 1 mês', 'Manutenção de barba', 6, 6),
(7, 'Retorno em 1 mês', 'Ajuste no penteado', 7, 7),
(8, 'Retorno em 2 meses', 'Finalizar coloração', 8, 8),
(9, 'Retorno em 3 semanas', 'Corte infantil', 9, 9),
(10, 'Retorno em 1 mês', 'Revisar tratamento', 10, 10);



INSERT INTO `SalaoEscola_PI`.`Agendamento` (`idAgendamento`, `Status`, `DataAgenda`, `Funcionario_idFuncionario`, `Cliente_idCliente`) VALUES
(1, 'Confirmado', '2024-01-10 09:00:00', 1, 1),
(2, 'Pendente', '2024-01-12 10:00:00', 2, 2),
(3, 'Cancelado', '2024-01-14 11:00:00', 3, 3),
(4, 'Confirmado', '2024-01-16 13:00:00', 4, 4),
(5, 'Confirmado', '2024-01-18 15:00:00', 5, 5),
(6, 'Pendente', '2024-01-20 14:00:00', 6, 6),
(7, 'Cancelado', '2024-01-22 16:00:00', 7, 7),
(8, 'Confirmado', '2024-01-24 08:00:00', 8, 8),
(9, 'Confirmado', '2024-01-26 12:00:00', 9, 9),
(10, 'Pendente', '2024-01-28 17:00:00', 10, 10);



INSERT INTO `SalaoEscola_PI`.`Atendimento` (`idAtendimento`, `TempoGasto`, `Agendamento_idAgendamento`) VALUES
(1, '01:30:00', 1),
(2, '02:00:00', 2),
(3, '00:45:00', 3),
(4, '01:00:00', 4),
(5, '01:15:00', 5),
(6, '02:30:00', 6),
(7, '01:20:00', 7),
(8, '01:50:00', 8),
(9, '02:10:00', 9),
(10, '01:40:00', 10);



INSERT INTO `SalaoEscola_PI`.`Feedback` (`idFeedback`, `dataFB`, `Descricao`, `Cliente_idCliente`) VALUES
(1, '2024-01-01 09:00:00', 'Atendimento excelente.', 1),
(2, '2024-01-02 10:00:00', 'Muito satisfeito com o serviço.', 2),
(3, '2024-01-03 11:00:00', 'Ótima qualidade e atendimento.', 3),
(4, '2024-01-04 12:00:00', 'Recomendo a todos.', 4),
(5, '2024-01-05 13:00:00', 'Serviço eficiente e rápido.', 5),
(6, '2024-01-06 14:00:00', 'Profissional atencioso.', 6),
(7, '2024-01-07 15:00:00', 'Muito bom, voltarei mais vezes.', 7),
(8, '2024-01-08 16:00:00', 'Fiquei muito feliz com o resultado.', 8),
(9, '2024-01-09 17:00:00', 'Serviço nota 10.', 9),
(10, '2024-01-10 18:00:00', 'Excelente atendimento.', 10);

INSERT INTO `SalaoEscola_PI`.`Pagamento` (`MetodoPagamento`) VALUES
('Cartão de Crédito'),
('Cartão de Débito'),
('Dinheiro'),
('Pix'),
('Transferência Bancária'),
('Boleto'),
('Paypal'),
('Mercado Pago'),
('Vale Presente'),
('Crédito Loja');

INSERT INTO `SalaoEscola_PI`.`ItensVendaProd` (`Venda_idVenda`, `Pagamento_idPagamento`, `Produtos_idProdutos`, `qtd`, `DescProd`) VALUES
(1, 1, 1, 2, 5.00),
(2, 2, 2, 1, 3.00),
(3, 3, 3, 4, 7.50),
(4, 4, 4, 3, 2.00),
(5, 5, 5, 1, 4.00),
(6, 6, 6, 2, 1.50),
(7, 7, 7, 3, 6.00),
(8, 8, 8, 4, 5.00),
(9, 9, 9, 1, 3.00),
(10, 10, 10, 2, 2.50);



INSERT INTO `SalaoEscola_PI`.`ItensVendaServico` (`Servico_idServico`, `Venda_idVenda`, `Funcionario_idFuncionario`, `Pagamento_idPagamento`, `qnt`, `Desconto`, `ValorVenda`) VALUES
(1, 1, 1, 1, 1, 10.00, 50.00),
(2, 2, 2, 2, 2, 5.00, 80.00),
(3, 3, 3, 3, 1, 7.00, 60.00),
(4, 4, 4, 4, 2, 6.00, 90.00),
(5, 5, 5, 5, 1, 8.00, 100.00),
(6, 6, 6, 6, 2, 9.00, 70.00),
(7, 7, 7, 7, 1, 5.00, 120.00),
(8, 8, 8, 8, 2, 10.00, 75.00),
(9, 9, 9, 9, 1, 3.00, 85.00),
(10, 10, 10, 10, 2, 4.00, 110.00);

INSERT INTO `SalaoEscola_PI`.`ProdUtilizados` (`Produtos_idProdutos`, `Atendimento_idAtendimento`, `Quantidade`) VALUES
(1, 1, 2),
(2, 2, 3),
(3, 3, 1),
(4, 4, 2),
(5, 5, 4),
(6, 6, 1),
(7, 7, 3),
(8, 8, 2),
(9, 9, 5),
(10, 10, 1);

INSERT INTO `SalaoEscola_PI`.`SrvAgendamento` (`Servico_idServico`, `Agendamento_idAgendamento`, `Agendamento_Funcionario_idFuncionario`, `Agendamento_Cliente_idCliente`, `quantidade`) VALUES
(1, 1, 1, 1, 1),
(2, 2, 2, 2, 2),
(3, 3, 3, 3, 1),
(4, 4, 4, 4, 1),
(5, 5, 5, 5, 2),
(6, 6, 6, 6, 1),
(7, 7, 7, 7, 3),
(8, 8, 8, 8, 2),
(9, 9, 9, 9, 1),
(10, 10, 10, 10, 2);
