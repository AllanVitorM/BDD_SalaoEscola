-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema SalaoEscola_PI
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema SalaoEscola_PI
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `SalaoEscola_PI` DEFAULT CHARACTER SET utf8 ;
USE `SalaoEscola_PI` ;

-- -----------------------------------------------------
-- Table `SalaoEscola_PI`.`Endereco`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SalaoEscola_PI`.`Endereco` (
  `idEndereco` INT NOT NULL AUTO_INCREMENT,
  `Rua` VARCHAR(45) NULL,
  `Bairro` VARCHAR(45) NULL,
  `Cidade` VARCHAR(45) NULL,
  `UF` VARCHAR(45) NULL,
  PRIMARY KEY (`idEndereco`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SalaoEscola_PI`.`Funcionario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SalaoEscola_PI`.`Funcionario` (
  `idFuncionario` INT NOT NULL AUTO_INCREMENT,
  `Nome` VARCHAR(45) NOT NULL,
  `DataNasc` DATETIME NOT NULL,
  `Cargo` VARCHAR(45) NOT NULL,
  `Salario` DECIMAL(7,2) NOT NULL,
  `CargaHoraria` VARCHAR(45) NOT NULL,
  `Endereco_idEndereco` INT NULL,
  PRIMARY KEY (`idFuncionario`),
  INDEX `fk_Funcionario_Endereco1_idx` (`Endereco_idEndereco` ASC) VISIBLE,
  UNIQUE INDEX `idFuncionario_UNIQUE` (`idFuncionario` ASC) VISIBLE,
  CONSTRAINT `fk_Funcionario_Endereco1`
    FOREIGN KEY (`Endereco_idEndereco`)
    REFERENCES `SalaoEscola_PI`.`Endereco` (`idEndereco`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SalaoEscola_PI`.`Cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SalaoEscola_PI`.`Cliente` (
  `idCliente` INT NOT NULL AUTO_INCREMENT,
  `Email` VARCHAR(150) NOT NULL,
  `DataNasc` DATETIME NOT NULL,
  `Senha` VARCHAR(225) NOT NULL,
  `Nome` VARCHAR(45) NOT NULL,
  `Endereco_idEndereco` INT NULL,
  PRIMARY KEY (`idCliente`),
  UNIQUE INDEX `Email_UNIQUE` (`Email` ASC) VISIBLE,
  INDEX `fk_Cliente_Endereco1_idx` (`Endereco_idEndereco` ASC) VISIBLE,
  CONSTRAINT `fk_Cliente_Endereco1`
    FOREIGN KEY (`Endereco_idEndereco`)
    REFERENCES `SalaoEscola_PI`.`Endereco` (`idEndereco`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SalaoEscola_PI`.`Venda`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SalaoEscola_PI`.`Venda` (
  `idVenda` INT NOT NULL AUTO_INCREMENT,
  `dataVenda` DATETIME NOT NULL,
  `valor` DECIMAL(6,2) NOT NULL,
  `Desconto` DECIMAL(6,2) NULL,
  `Funcionario_idFuncionario` INT NOT NULL,
  `Cliente_idCliente` INT NOT NULL,
  PRIMARY KEY (`idVenda`, `Funcionario_idFuncionario`, `Cliente_idCliente`),
  UNIQUE INDEX `idVenda_UNIQUE` (`idVenda` ASC) VISIBLE,
  INDEX `fk_Venda_Funcionario1_idx` (`Funcionario_idFuncionario` ASC) VISIBLE,
  INDEX `fk_Venda_Cliente1_idx` (`Cliente_idCliente` ASC) VISIBLE,
  CONSTRAINT `fk_Venda_Funcionario1`
    FOREIGN KEY (`Funcionario_idFuncionario`)
    REFERENCES `SalaoEscola_PI`.`Funcionario` (`idFuncionario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Venda_Cliente1`
    FOREIGN KEY (`Cliente_idCliente`)
    REFERENCES `SalaoEscola_PI`.`Cliente` (`idCliente`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SalaoEscola_PI`.`Servico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SalaoEscola_PI`.`Servico` (
  `idServico` INT NOT NULL,
  `Nome` VARCHAR(45) NOT NULL,
  `Valor` DECIMAL(6,2) NOT NULL,
  `quantidade` INT NOT NULL,
  `descricao` VARCHAR(45) NULL,
  PRIMARY KEY (`idServico`),
  UNIQUE INDEX `idServico_UNIQUE` (`idServico` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SalaoEscola_PI`.`Pagamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SalaoEscola_PI`.`Pagamento` (
  `idPagamento` INT NOT NULL AUTO_INCREMENT,
  `MetodoPagamento` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idPagamento`),
  UNIQUE INDEX `idPagamento_UNIQUE` (`idPagamento` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SalaoEscola_PI`.`Produtos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SalaoEscola_PI`.`Produtos` (
  `idProdutos` INT NOT NULL AUTO_INCREMENT,
  `Nome` VARCHAR(45) NOT NULL,
  `Preco` DECIMAL(6,2) NOT NULL,
  `quantidade` INT NOT NULL,
  PRIMARY KEY (`idProdutos`),
  UNIQUE INDEX `idProdutos_UNIQUE` (`idProdutos` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SalaoEscola_PI`.`ItensVendaProd`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SalaoEscola_PI`.`ItensVendaProd` (
  `Venda_idVenda` INT NOT NULL,
  `Pagamento_idPagamento` INT NOT NULL,
  `Produtos_idProdutos` INT NOT NULL,
  `qtd` INT NULL,
  `DescProd` DECIMAL(5,2) NULL,
  PRIMARY KEY (`Venda_idVenda`, `Pagamento_idPagamento`, `Produtos_idProdutos`),
  INDEX `fk_ItensVendaProd_Pagamento1_idx` (`Pagamento_idPagamento` ASC) VISIBLE,
  INDEX `fk_ItensVendaProd_Produtos1_idx` (`Produtos_idProdutos` ASC) VISIBLE,
  CONSTRAINT `fk_ItensVendaProd_Venda1`
    FOREIGN KEY (`Venda_idVenda`)
    REFERENCES `SalaoEscola_PI`.`Venda` (`idVenda`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ItensVendaProd_Pagamento1`
    FOREIGN KEY (`Pagamento_idPagamento`)
    REFERENCES `SalaoEscola_PI`.`Pagamento` (`idPagamento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ItensVendaProd_Produtos1`
    FOREIGN KEY (`Produtos_idProdutos`)
    REFERENCES `SalaoEscola_PI`.`Produtos` (`idProdutos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SalaoEscola_PI`.`Agendamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SalaoEscola_PI`.`Agendamento` (
  `idAgendamento` INT NOT NULL AUTO_INCREMENT,
  `Status` VARCHAR(45) NOT NULL,
  `DataAgenda` DATETIME NOT NULL,
  `Funcionario_idFuncionario` INT NOT NULL,
  `Cliente_idCliente` INT NOT NULL,
  PRIMARY KEY (`idAgendamento`, `Funcionario_idFuncionario`, `Cliente_idCliente`),
  INDEX `fk_Agendamento_Funcionario1_idx` (`Funcionario_idFuncionario` ASC) VISIBLE,
  INDEX `fk_Agendamento_Cliente1_idx` (`Cliente_idCliente` ASC) VISIBLE,
  CONSTRAINT `fk_Agendamento_Funcionario1`
    FOREIGN KEY (`Funcionario_idFuncionario`)
    REFERENCES `SalaoEscola_PI`.`Funcionario` (`idFuncionario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Agendamento_Cliente1`
    FOREIGN KEY (`Cliente_idCliente`)
    REFERENCES `SalaoEscola_PI`.`Cliente` (`idCliente`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SalaoEscola_PI`.`Lembrete`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SalaoEscola_PI`.`Lembrete` (
  `idLembrete` INT NOT NULL AUTO_INCREMENT,
  `Retorno` VARCHAR(45) NULL,
  `Manutencao` VARCHAR(45) NULL,
  `Funcionario_idFuncionario` INT NOT NULL,
  `Cliente_idCliente` INT NOT NULL,
  PRIMARY KEY (`idLembrete`),
  INDEX `fk_Lembrete_Funcionario1_idx` (`Funcionario_idFuncionario` ASC) VISIBLE,
  INDEX `fk_Lembrete_Cliente1_idx` (`Cliente_idCliente` ASC) VISIBLE,
  UNIQUE INDEX `idLembrete_UNIQUE` (`idLembrete` ASC) VISIBLE,
  CONSTRAINT `fk_Lembrete_Funcionario1`
    FOREIGN KEY (`Funcionario_idFuncionario`)
    REFERENCES `SalaoEscola_PI`.`Funcionario` (`idFuncionario`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Lembrete_Cliente1`
    FOREIGN KEY (`Cliente_idCliente`)
    REFERENCES `SalaoEscola_PI`.`Cliente` (`idCliente`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SalaoEscola_PI`.`Atendimento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SalaoEscola_PI`.`Atendimento` (
  `idAtendimento` INT NOT NULL AUTO_INCREMENT,
  `TempoGasto` TIME NOT NULL,
  `Agendamento_idAgendamento` INT NOT NULL,
  PRIMARY KEY (`idAtendimento`),
  INDEX `fk_Atendimento_Agendamento1_idx` (`Agendamento_idAgendamento` ASC) VISIBLE,
  UNIQUE INDEX `idAtendimento_UNIQUE` (`idAtendimento` ASC) VISIBLE,
  CONSTRAINT `fk_Atendimento_Agendamento1`
    FOREIGN KEY (`Agendamento_idAgendamento`)
    REFERENCES `SalaoEscola_PI`.`Agendamento` (`idAgendamento`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SalaoEscola_PI`.`Feedback`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SalaoEscola_PI`.`Feedback` (
  `idFeedback` INT NOT NULL AUTO_INCREMENT,
  `dataFB` DATETIME NOT NULL,
  `Descricao` VARCHAR(225) NOT NULL,
  `Cliente_idCliente` INT NOT NULL,
  PRIMARY KEY (`idFeedback`, `Cliente_idCliente`),
  INDEX `fk_Feedback_Cliente1_idx` (`Cliente_idCliente` ASC) VISIBLE,
  CONSTRAINT `fk_Feedback_Cliente1`
    FOREIGN KEY (`Cliente_idCliente`)
    REFERENCES `SalaoEscola_PI`.`Cliente` (`idCliente`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SalaoEscola_PI`.`ProdUtilizados`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SalaoEscola_PI`.`ProdUtilizados` (
  `Produtos_idProdutos` INT NOT NULL,
  `Atendimento_idAtendimento` INT NOT NULL,
  `Quantidade` INT NULL,
  PRIMARY KEY (`Produtos_idProdutos`, `Atendimento_idAtendimento`),
  INDEX `fk_ProdUtilizados_Atendimento1_idx` (`Atendimento_idAtendimento` ASC) VISIBLE,
  CONSTRAINT `fk_ProdUtilizados_Produtos1`
    FOREIGN KEY (`Produtos_idProdutos`)
    REFERENCES `SalaoEscola_PI`.`Produtos` (`idProdutos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ProdUtilizados_Atendimento1`
    FOREIGN KEY (`Atendimento_idAtendimento`)
    REFERENCES `SalaoEscola_PI`.`Atendimento` (`idAtendimento`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SalaoEscola_PI`.`ItensVendaServico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SalaoEscola_PI`.`ItensVendaServico` (
  `Servico_idServico` INT NOT NULL,
  `Venda_idVenda` INT NOT NULL,
  `Funcionario_idFuncionario` INT NOT NULL,
  `Pagamento_idPagamento` INT NOT NULL,
  `qnt` INT NULL,
  `Desconto` DECIMAL(5,2) NULL,
  `ValorVenda` DECIMAL(6,2) NULL,
  PRIMARY KEY (`Servico_idServico`, `Venda_idVenda`, `Funcionario_idFuncionario`, `Pagamento_idPagamento`),
  INDEX `fk_table1_Venda1_idx` (`Venda_idVenda` ASC) VISIBLE,
  INDEX `fk_table1_Funcionario1_idx` (`Funcionario_idFuncionario` ASC) VISIBLE,
  INDEX `fk_ItensVendaServico_Pagamento1_idx` (`Pagamento_idPagamento` ASC) VISIBLE,
  CONSTRAINT `fk_table1_Servico1`
    FOREIGN KEY (`Servico_idServico`)
    REFERENCES `SalaoEscola_PI`.`Servico` (`idServico`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_table1_Venda1`
    FOREIGN KEY (`Venda_idVenda`)
    REFERENCES `SalaoEscola_PI`.`Venda` (`idVenda`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_table1_Funcionario1`
    FOREIGN KEY (`Funcionario_idFuncionario`)
    REFERENCES `SalaoEscola_PI`.`Funcionario` (`idFuncionario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ItensVendaServico_Pagamento1`
    FOREIGN KEY (`Pagamento_idPagamento`)
    REFERENCES `SalaoEscola_PI`.`Pagamento` (`idPagamento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SalaoEscola_PI`.`SrvAgendamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SalaoEscola_PI`.`SrvAgendamento` (
  `Servico_idServico` INT NOT NULL,
  `Agendamento_idAgendamento` INT NOT NULL,
  `Agendamento_Funcionario_idFuncionario` INT NOT NULL,
  `Agendamento_Cliente_idCliente` INT NOT NULL,
  `quantidade` INT NULL,
  PRIMARY KEY (`Servico_idServico`, `Agendamento_idAgendamento`, `Agendamento_Funcionario_idFuncionario`, `Agendamento_Cliente_idCliente`),
  INDEX `fk_Servico_has_Agendamento_Agendamento1_idx` (`Agendamento_idAgendamento` ASC, `Agendamento_Funcionario_idFuncionario` ASC, `Agendamento_Cliente_idCliente` ASC) VISIBLE,
  INDEX `fk_Servico_has_Agendamento_Servico1_idx` (`Servico_idServico` ASC) VISIBLE,
  CONSTRAINT `fk_Servico_has_Agendamento_Servico1`
    FOREIGN KEY (`Servico_idServico`)
    REFERENCES `SalaoEscola_PI`.`Servico` (`idServico`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Servico_has_Agendamento_Agendamento1`
    FOREIGN KEY (`Agendamento_idAgendamento` , `Agendamento_Funcionario_idFuncionario` , `Agendamento_Cliente_idCliente`)
    REFERENCES `SalaoEscola_PI`.`Agendamento` (`idAgendamento` , `Funcionario_idFuncionario` , `Cliente_idCliente`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
