-- 10 PROCEDURES E FUNÇÕES
-- 1 - função calcAuxSaude
delimiter $$
create function calcAuxSaude(dn date)
	returns decimal(6,2) deterministic
	begin
		declare idade int;
        declare auxSaude decimal(6,2) default 0.0;
        select timestampdiff(year, dn, now()) into idade;
        if idade <= 25 then set auxSaude = 250;
			elseif idade>= 26 and idade <= 35 then set auxSaude = 350;
			elseif idade>= 36 and idade <= 45 then set auxSaude = 450;
			else set auxSaude = 550;
		end if;
        return auxSaude;
    end $$
delimiter ;

-- 2 - função de calcINSS
delimiter $$
create function calcINSS(sb decimal(7,2))
	returns decimal(6,2) deterministic
    begin
		declare inss decimal(6,2) default 0.0;
        if sb <= 1412.00 then set inss = sb * 0.075;
			elseif sb > 1412.0 and sb <= 2666.68 then set inss = sb * 0.09;
			elseif sb > 2666.68 and sb <= 4000.03 then set inss = sb * 0.12;
            elseif sb > 4000.03 and sb <= 7786.02 then set inss = sb * 0.14;
			else set inss = 7786.02 * 0.14;
            end if;
		return inss;
    end $$
delimiter ;

-- 3 - função de calcIRRF
delimiter $$
create function calcIRRF(sb decimal(7,2))
	returns decimal(6,2) deterministic
    begin
		declare irrf decimal(6,2) default 0.0;
        if sb > 2259.21  and sb <= 2826.65 then set irrf = sb * 0.075;
			elseif sb > 2826.65 and sb <= 3751.05 then set irrf = sb * 0.15;
            elseif sb > 3751.05 and sb <= 4664.68 then set irrf = sb * 0.225;
			else set irrf = sb * 0.275;
            end if;
		return irrf;
    end $$
delimiter ;
    
-- 4 procedure
-- valorComp, valorVnd --> valorComp + (valorComp * 0,33) + (valorComp * 0,25) +
-- (valorComp * 2)
delimiter $$
create procedure calcValorFinal(in valorComp decimal(6,2), out valorVnd decimal(6,2))
	begin
		set valorVnd = valorComp + (valorComp * 0.33) + 
			(valorComp * 0.25) + (valorComp * 2);
    end $$
delimiter ;

-- 5 - procedure cadastro de funcionário
delimiter $$
create procedure cadFunc(in pidFuncionario varchar(14),
						in pnome varchar(60), 
						in pdataNasc date, 
                        in pcargo varchar(45),
						in pcargahoraria int, 
						in psalario decimal(7,2),
                        in puf char(2), 
						in pcidade varchar(60), 
						in pbairro varchar(60), 
						in prua varchar(70)
	)

	begin
		insert into funcionario (idfuncionario, nome, dataNasc, cargo, CargaHoraria, salario)
			value (pidFuncionario, pnome, pdataNasc, pcargo, pcargahoraria, psalario);
		insert into enderecofunc
			value (pidFuncionario, puf, pcidade, pbairro, prua);
    end $$
delimiter ;

-- 6 - Procedure: update Salario Funcionario
DELIMITER $$
CREATE PROCEDURE updateSalarioFuncionario(
    IN pidFuncionario VARCHAR(14),
    IN aumentoPercentual DECIMAL(5,2)
)
BEGIN
    UPDATE funcionario
    SET salario = salario + (salario * (aumentoPercentual / 100))
    WHERE idFuncionario = pidFuncionario;
END $$
DELIMITER ;

-- 7 - Procedure: relatorioFuncionarios
DELIMITER $$
CREATE PROCEDURE relatorioFuncionarios()
BEGIN
    SELECT
        f.idFuncionario AS "ID",
        f.nome AS "Nome",
        f.cargo AS "Cargo",
        CONCAT("R$ ", FORMAT(f.salario, 2, 'de_DE')) AS "Salário Bruto",
        CONCAT("R$ ", FORMAT(calcAuxSaude(f.dataNasc), 2, 'de_DE')) AS "Auxílio Saúde",
        CONCAT("R$ ", FORMAT(calcINSS(f.salario), 2, 'de_DE')) AS "INSS",
        CONCAT("R$ ", FORMAT(calcIRRF(f.salario), 2, 'de_DE')) AS "IRRF",
        CONCAT("R$ ", FORMAT(f.salario + calcAuxSaude(f.dataNasc) - calcINSS(f.salario) - calcIRRF(f.salario), 2, 'de_DE')) AS "Salário Líquido"
    FROM funcionario f
    ORDER BY f.nome;
END $$
DELIMITER ;

-- 8 - Função: calcDescontoServico
DELIMITER $$
CREATE FUNCTION calcDescontoServico(numAgendamentos INT, valorServico DECIMAL(7,2))
RETURNS DECIMAL(7,2) DETERMINISTIC
BEGIN
    DECLARE desconto DECIMAL(7,2);
    IF numAgendamentos >= 10 THEN
        SET desconto = valorServico * 0.1;
    ELSEIF numAgendamentos >= 5 THEN
        SET desconto = valorServico * 0.05;
    ELSE
        SET desconto = 0;
    END IF;
    RETURN valorServico - desconto;
END $$
DELIMITER ;

-- 9 -  Procedure: addVenda
DELIMITER $$
CREATE PROCEDURE addVenda(
    IN pidFuncionario VARCHAR(14),
    IN valorVenda DECIMAL(8,2)
)
BEGIN
    INSERT INTO venda (idfuncionario, valor, dataVenda)
    VALUES (pidFuncionario, valorVenda, NOW());
END $$
DELIMITER ;

-- 10 - Procedure: resumoSalarioFuncionario
DELIMITER $$
CREATE PROCEDURE resumoSalarioFuncionario(
    IN pidFuncionario VARCHAR(14)
)
BEGIN
    DECLARE nomeFuncionario VARCHAR(60);
    DECLARE salarioBruto DECIMAL(7,2);
    DECLARE auxAlimentacao DECIMAL(6,2) DEFAULT 550.00;
    DECLARE auxSaude DECIMAL(6,2);
    DECLARE inss DECIMAL(6,2);
    DECLARE irrf DECIMAL(6,2);
    DECLARE salarioLiquido DECIMAL(7,2);

    -- Obter dados do funcionário
    SELECT nome, salario, calcAuxSaude(dataNasc)
    INTO nomeFuncionario, salarioBruto, auxSaude
    FROM funcionario
    WHERE idFuncionario = pidFuncionario;

    -- Calcular INSS e IRRF
    SET inss = calcINSS(salarioBruto);
    SET irrf = calcIRRF(salarioBruto);

    -- Calcular salário líquido
    SET salarioLiquido = salarioBruto + auxAlimentacao + auxSaude - inss - irrf;

    -- Exibir resumo
    SELECT 
        pidFuncionario AS "ID do Funcionário",
        nomeFuncionario AS "Nome do Funcionário",
        CONCAT("R$ ", FORMAT(salarioBruto, 2, 'de_DE')) AS "Salário Bruto",
        CONCAT("R$ ", FORMAT(auxAlimentacao, 2, 'de_DE')) AS "Auxílio Alimentação",
        CONCAT("R$ ", FORMAT(auxSaude, 2, 'de_DE')) AS "Auxílio Saúde",
        CONCAT("-R$ ", FORMAT(inss, 2, 'de_DE')) AS "INSS",
        CONCAT("-R$ ", FORMAT(irrf, 2, 'de_DE')) AS "IRRF",
        CONCAT("R$ ", FORMAT(salarioLiquido, 2, 'de_DE')) AS "Salário Líquido";
END $$
DELIMITER ;

