-- 1 - Liste os nomes dos clientes junto com os endereços completos em que eles residem
-- 1 - view_clientes_enderecos
create view view_clientes_enderecos as
select cli.idCliente "ID Cliente", cli.email "E-mail", cli.datanasc "Data de Nascimento", cli.nome "Cliente", ende.rua "Rua", ende.bairro "Bairro",
ende.cidade "Cidade", ende.UF "UF"
	from cliente cli
		left join endereco ende on ende.idEndereco = cli.Endereco_idEndereco
			order by cli.nome;
    
-- 2 - Mostre os nomes dos funcionários, seus cargos e os bairros onde trabalham.
select func.idFuncionario "ID do Funcionário", func.nome "Funcionário", func.cargo "Cargo", ende.bairro "Bairro"
	from funcionario func
		left join endereco ende on ende.idendereco = func.Endereco_idEndereco
			order by func.nome;
        
-- 3 - Exiba as vendas realizadas, incluindo os nomes dos clientes e funcionários responsáveis.
-- 2 - view_venda_cliente_funcionario
create view view_venda_cliente_funcionario as
select vnd.idVenda "Id de Venda", cli.nome "Cliente", func.nome "Funcionário", func.cargo "Cargo", concat("R$ ", format(vnd.valor, 2, 'de_DE')) "Valor da Venda", 
concat("R$ ", format(vnd.desconto, 2, 'de_DE')) "Desconto", concat("R$ ", format(sum(vnd.valor - vnd.desconto), 2, 'de_DE')) "Total Valor Vendido"
	from venda vnd
		inner join cliente cli on cli.idCliente = vnd.Cliente_idCliente
        inner join funcionario func on func.idFuncionario = vnd.Funcionario_idFuncionario
			group by vnd.idVenda
				order by sum(vnd.valor - vnd.desconto) desc;
                
-- 4 - Liste os serviços agendados, mostrando o status do agendamento e o nome do cliente.
-- 3 - view_status_agendamento_cliente
create view view_status_agendamento_cliente as
select agd.idAgendamento "Id de Agendamento", agd.Status "Satus do Agendamento",
DATE_FORMAT(agd.dataagenda, '%d/%m/%Y %H:%i') "Data do Agendamento",
cli.nome "Cliente", func.nome "Funcionário"
	from agendamento agd
		inner join cliente cli on cli.idcliente = agd.Cliente_idCliente
        inner join funcionario func on func.idFuncionario - agd.Funcionario_idFuncionario;
    
-- 5 - Apresente os feedbacks recebidos, incluindo os nomes dos clientes que os forneceram.
select date_format(fb.dataFB, '%H:%i - %d/%m/%Y') "Data do Feedback", fb.Descricao "Feedback", cli.nome "Cliente"
	from feedback fb
		inner join cliente cli on cli.idcliente = fb.Cliente_idCliente;

-- 6 - Liste os produtos utilizados em cada atendimento, mostrando o tempo gasto e o funcionário envolvido.
-- 4 - view_produtil_atend
create view view_produtil_atend as
select prod.nome "Produto", atd.tempoGasto "Tempo Gasto", func.nome "Funcionário",
DATE_FORMAT(agd.dataagenda, '%d/%m/%Y %H:%i') "Data do Atendimento"
FROM produtilizados produ
INNER JOIN produtos prod on prod.idProdutos = produ.Produtos_idProdutos
INNER JOIN atendimento atd on atd.idAtendimento = produ.Atendimento_idAtendimento
INNER JOIN agendamento agd on agd.idAgendamento = atd.Agendamento_idAgendamento
INNER JOIN funcionario func on func.idFuncionario = agd.Funcionario_idFuncionario;

-- 7 - Mostre as vendas que incluíram serviços, detalhando os serviços realizados e seus valores.
select svc.nome "Serviço", concat("R$ ", format(sum(vnd.valor - vnd.desconto), 2, 'de_DE')) "Total Valor Vendido", svc.descricao "Descrição",
date_format(vnd.dataVenda, '%H:%i - %d/%m/%Y') "Data da Venda"
	from venda vnd
    inner join itensvendaservico ivs on ivs.Venda_idVenda = vnd.idVenda
    inner join servico svc on svc.idServico = ivs.Servico_idServico
		group by svc.Nome, svc.descricao, vnd.dataVenda
			order by sum(vnd.valor - vnd.desconto);

-- 8 - Exiba os agendamentos confirmados com a data, o cliente e o funcionário relacionados.
-- 5 - view_agd_confirmados
create view view_agd_confirmados as
select agd.idAgendamento "ID do Agendamento", date_format(agd.DataAgenda , '%H:%i - %d/%m/%Y') "Data do Agendamento", cli.nome "Cliente", func.nome "Funcionário",
agd.Status "Status do Agendamento"
	from agendamento agd
		inner join funcionario func on func.idFuncionario = agd.Funcionario_idFuncionario
        inner join cliente cli on cli.idCliente = agd.Cliente_idCliente
			where agd.status like "%Confirmado%";
        
-- 9 - Liste os lembretes de manutenção de serviços, incluindo o nome do cliente e do funcionário responsável
select lbt.Manutencao "Manutenção", cli.nome "Cliente", func.nome "Funcionário"
	from lembrete lbt
		inner join cliente cli on cli.idCliente = lbt.Cliente_idCliente
        inner join funcionario func on func.idFuncionario = lbt.Funcionario_idFuncionario
			order by lbt.Manutencao;

-- 10 - Mostre as vendas, incluindo o método de pagamento utilizado e o total após desconto.
-- 6 - view_vnd_metodopagamento
create view view_vnd_metodopagamento as
select pgt.MetodoPagamento "Forma de Pagamento", concat("R$ ", format(vnd.valor, 2, 'de_DE')) "Valor da Venda", 
concat("R$ ", format(vnd.desconto, 2, 'de_DE')) "Desconto", 
concat("R$ ", format(sum(vnd.valor - vnd.desconto), 2, 'de_DE')) "Total Valor Vendido"
	from venda vnd
		inner join itensvendaprod ivp on ivp.Venda_idVenda = vnd.idVenda
        inner join itensvendaservico ivs on ivs.Venda_idVenda = vnd.idVenda
        inner join pagamento pgt on ivs.Pagamento_idPagamento = pgt.idPagamento
        inner join pagamento on ivp.Pagamento_idPagamento = pgt.idPagamento
			group by pgt.MetodoPagamento, vnd.valor, vnd.Desconto
				order by sum(vnd.valor - vnd.desconto) desc;

-- 11 - Exiba os clientes que fizeram compras de produtos, incluindo os detalhes do produto comprado.
-- 7 - view_cliente_compra_produtos
create view view_cliente_compra_produtos as
select cli.nome "Cliente", prod.nome "Produto", ivp.qtd "Quantidade",
concat("R$ ", format(vnd.valor, 2, 'de_DE')) "Valor da Venda", 
concat("R$ ", format(vnd.desconto, 2, 'de_DE')) "Desconto", 
concat("R$ ", format(sum(vnd.valor - vnd.desconto), 2, 'de_DE')) "Total Valor Vendido"
	from produtos prod
		inner join itensvendaprod ivp on ivp.Produtos_idProdutos = prod.idProdutos
        inner join venda vnd on ivp.Venda_idVenda = vnd.idVenda
        inner join cliente cli on vnd.Cliente_idCliente = cli.idCliente
			group by cli.nome, prod.nome, ivp.qtd, vnd.valor, vnd.Desconto
				order by sum(vnd.valor - vnd.desconto) desc;

-- 12 - Liste os funcionários que participaram de atendimentos, incluindo os produtos utilizados por eles.
select func.nome "Funcionário", prod.nome "Produto", DATE_FORMAT(agd.dataagenda, '%H:%i - %d/%m/%Y') "Data do Atendimento", 
produ.Quantidade "Quantidade"
	from funcionario func
		inner join agendamento agd on agd.Funcionario_idFuncionario = func.idFuncionario
        inner join atendimento atd on atd.Agendamento_idAgendamento = agd.idAgendamento
        inner join produtilizados produ on produ.Atendimento_idAtendimento = atd.idAtendimento
		inner join produtos prod ON prod.idProdutos = produ.Produtos_idProdutos;

-- 13 - Mostre os serviços mais vendidos, detalhando os clientes que os adquiriram.
select cli.nome "Cliente", svc.Nome "Serviço",  COUNT(svc.idServico) "Quantidade Vendidada",
concat("R$ ", format(vnd.valor, 2, 'de_DE')) "Valor da Venda", 
concat("R$ ", format(vnd.desconto, 2, 'de_DE')) "Desconto", 
concat("R$ ", format(sum(vnd.valor - vnd.desconto), 2, 'de_DE')) "Total Valor Vendido"
	from servico svc
		inner join itensvendaservico ivs on ivs.Servico_idServico = svc.idServico
        inner join venda vnd on vnd.idVenda = ivs.Venda_idVenda
        inner join cliente cli on cli.idCliente = vnd.Cliente_idCliente
			group by vnd.valor, cli.nome, svc.Nome, vnd.desconto
				order by "Quantidade Vendida" desc;

-- 14 - Exiba os agendamentos que possuem serviços associados, incluindo a quantidade de serviços agendados.
select DATE_FORMAT(agd.dataagenda, '%H:%i - %d/%m/%Y') "Data do Serviço", svc.Nome "Serviço", COUNT(svc.idServico) "Quantidade"
	from agendamento agd
		inner join srvagendamento svag on svag.Agendamento_idAgendamento = agd.idAgendamento
        inner join servico svc on svc.idServico = svag.Servico_idServico
			group by agd.dataagenda, svc.Nome; 
        
-- 15 - Liste os atendimentos realizados por cada funcionário, detalhando o tempo gasto em cada um.
select func.nome "Funcionário", time_format(atd.TempoGasto, '%H:%i') "Tempo Gasto"
	from atendimento atd
		inner join agendamento agd on agd.idAgendamento= atd.Agendamento_idAgendamento
        inner join funcionario func on func.idFuncionario = agd.Funcionario_idFuncionario;

-- 16 - Mostre os produtos mais utilizados em atendimentos, com os funcionários responsáveis.
-- 8 - view_prod_mais_usado_atendimento
create view view_prod_mais_usado_atendimento as
select atd.idAtendimento "Id do Atenditmento", func.Nome "Funcionário", prod.nome "Produto", COUNT(produ.Produtos_idProdutos) "Quantidade"
	from produtilizados produ
		inner join produtos prod on prod.idProdutos = produ.Produtos_idProdutos
        inner join atendimento atd on atd.idAtendimento = produ.Atendimento_idAtendimento
        inner join agendamento agd on agd.idAgendamento = atd.Agendamento_idAgendamento
        inner join funcionario func on agd.Funcionario_idFuncionario = func.idFuncionario
			group by atd.idAtendimento, prod.nome, func.Nome;

-- 17 - Exiba os clientes que possuem agendamentos pendentes, incluindo o tipo de serviço agendado.
-- 9 - view_agend_pendente_cliente
create view view_agend_pendente_cliente as
select agd.idAgendamento "ID do Agendamento", date_format(agd.DataAgenda , '%H:%i - %d/%m/%Y') "Data do Agendamento", cli.nome "Cliente", func.nome "Funcionário",
agd.Status "Status do Agendamento"
	from agendamento agd
		inner join funcionario func on func.idFuncionario = agd.Funcionario_idFuncionario
        inner join cliente cli on cli.idCliente = agd.Cliente_idCliente
			where agd.status like "%Pendente%";
            
-- 18 - Liste as vendas que incluíram tanto produtos quanto serviços, detalhando os itens vendidos.
-- 10 - view_venda_prod_mais_serv 
create view view_venda_prod_mais_serv as
SELECT 
    vnd.idVenda "ID de Venda",
    date_format(vnd.DataVenda , '%H:%i - %d/%m/%Y') "Data de Venda",
    concat("R$ ", format(vnd.valor, 2, 'de_DE')) "Valor da Venda",
    ivp.Produtos_idProdutos "ID do Produto", prod.Nome "Produto", ivp.qtd "Quantidade do Produto",
    concat("R$ ", format(ivp.DescProd, 2, 'de_DE'))"Desconto do Produto",
    isv.Servico_idServico  "ID do Servico", svc.Nome "Serviço", isv.qnt "Quantidade do Serviço",
	concat("R$ ", format(isv.Desconto , 2, 'de_DE'))"Desconto do Servico",
	concat("R$ ", format(isv.ValorVenda, 2, 'de_DE')) "Valor do Serviço"
	FROM Venda vnd
		JOIN ItensVendaProd ivp ON vnd.idVenda = ivp.Venda_idVenda
		JOIN Produtos prod ON ivp.Produtos_idProdutos = prod.idProdutos
		JOIN ItensVendaServico isv ON vnd.idVenda = isv.Venda_idVenda
		JOIN Servico svc ON isv.Servico_idServico = svc.idServico
			WHERE ivp.Venda_idVenda = isv.Venda_idVenda;

-- 19 - Mostre os serviços realizados em cada atendimento, com os valores cobrados e os funcionários envolvidos.
select svc.idServico "ID do Serviço", svc.Nome "Serviço", func.nome "Funcionario", Cli.nome "Clinte",
date_format(vnd.DataVenda , '%H:%i - %d/%m/%Y') "Data do Serviço Realizado",
concat("R$ ", format(vnd.valor, 2, 'de_DE')) "Valor da Venda",
concat("R$ ", format(vnd.desconto, 2, 'de_DE')) "Desconto", 
concat("R$ ", format(sum(vnd.valor - vnd.desconto), 2, 'de_DE')) "Total Valor Vendido"
	from servico svc
    inner join itensvendaservico ivs on ivs.Servico_idServico = svc.idServico
    inner join funcionario func on func.idFuncionario = ivs.Funcionario_idFuncionario
    inner join venda vnd on vnd.Funcionario_idFuncionario = func.idFuncionario
    inner join cliente cli on cli.idCliente = vnd.Cliente_idCliente
		group by svc.idServico, svc.Nome, func.nome, Cli.nome, vnd.DataVenda, vnd.valor, vnd.desconto
			order by sum(vnd.valor - vnd.desconto) desc;

-- 20 - Exiba o histórico de vendas de cada cliente, com os detalhes dos produtos e serviços adquiridos.
select cli.idCliente "ID do Cliente", cli.Nome "Cliente", prod.Nome "Produto", svc.Nome "Serviço"
	from cliente cli
		inner join venda vnd on vnd.Cliente_idCliente = cli.idCliente
        inner join itensvendaservico ivs on ivs.Venda_idVenda = vnd.idVenda
        inner join itensvendaprod ivp on ivp.Venda_idVenda = vnd.idVenda
        inner join servico svc on svc.idServico = ivs.Servico_idServico
        inner join produtos prod on prod.idProdutos = ivp.Produtos_idProdutos
			order by cli.Nome;
