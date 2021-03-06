-- MYSQL WORKBENCH FORWARD ENGINEERING

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- SCHEMA PI_6_INSIDE
-- -----------------------------------------------------

-- -----------------------------------------------------
-- SCHEMA PI_6_INSIDE
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `PI_6_INSIDE` DEFAULT CHARACTER SET UTF8 ;
USE `PI_6_INSIDE` ;

-- -----------------------------------------------------
-- TABLE `PI_6_INSIDE`.`TB_CARGO_FUNC`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PI_6_INSIDE`.`TB_CARGO_FUNC` (
  `ID_CARGO_FUNC` INT NOT NULL AUTO_INCREMENT,
  `DESC_CARGO` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`ID_CARGO_FUNC`))
ENGINE = INNODB;


-- -----------------------------------------------------
-- TABLE `PI_6_INSIDE`.`TB_USUARIO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PI_6_INSIDE`.`TB_USUARIO` (
  `LOGIN` VARCHAR(40) NOT NULL,
  `SENHA` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`LOGIN`))
ENGINE = INNODB;


-- -----------------------------------------------------
-- TABLE `PI_6_INSIDE`.`TB_FUNCIONARIO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PI_6_INSIDE`.`TB_FUNCIONARIO` (
  `ID_FUNCIONARIO` INT NOT NULL AUTO_INCREMENT,
  `NOME` VARCHAR(130) NOT NULL,
  `EMAIL` VARCHAR(100) NULL,
  `CELULAR` VARCHAR(11) NULL,
  `CPF` VARCHAR(11) NULL,
  `RG` VARCHAR(9) NULL,
  `ID_CARGO_FUNC` INT NOT NULL,
  `OBSERVACOES` VARCHAR(500) NULL,
  `TELEFONE` VARCHAR(10) NULL,
  `LOGIN` VARCHAR(40) NOT NULL,
  UNIQUE INDEX `LOGIN_UNIQUE` (`ID_FUNCIONARIO` ASC),
  PRIMARY KEY (`ID_FUNCIONARIO`),
  INDEX `FK_TB_USUARIO_TB_CARGO_FUNC1_IDX` (`ID_CARGO_FUNC` ASC),
  INDEX `FK_TB_FUNCIONARIO_TB_USUARIO1_IDX` (`LOGIN` ASC),
  CONSTRAINT `FK_TB_USUARIO_TB_CARGO_FUNC1`
    FOREIGN KEY (`ID_CARGO_FUNC`)
    REFERENCES `PI_6_INSIDE`.`TB_CARGO_FUNC` (`ID_CARGO_FUNC`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_TB_FUNCIONARIO_TB_USUARIO1`
    FOREIGN KEY (`LOGIN`)
    REFERENCES `PI_6_INSIDE`.`TB_USUARIO` (`LOGIN`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = INNODB;


-- -----------------------------------------------------
-- TABLE `PI_6_INSIDE`.`TB_CLIENTE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PI_6_INSIDE`.`TB_CLIENTE` (
  `ID_CLIENTE` INT NOT NULL AUTO_INCREMENT,
  `NOME_CLIENTE` VARCHAR(130) NOT NULL,
  `REPRESENTANTE` VARCHAR(80) NULL,
  `TELEFONE` VARCHAR(11) NULL,
  `EMAIL_REP` VARCHAR(80) NULL,
  PRIMARY KEY (`ID_CLIENTE`))
ENGINE = INNODB;


-- -----------------------------------------------------
-- TABLE `PI_6_INSIDE`.`TB_PROJETO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PI_6_INSIDE`.`TB_PROJETO` (
  `ID_PROJETO` INT NOT NULL AUTO_INCREMENT,
  `DESC_PROJETO` VARCHAR(45) NOT NULL,
  `ID_CLIENTE` INT NOT NULL,
  `STATUS` VARCHAR(25) NOT NULL,
  `DETALHE` VARCHAR(200) NOT NULL,
  `ATIVIDADE` VARCHAR(80) NULL,
  `DT_INICIO` DATE NOT NULL,
  `DT_FIM` DATE NOT NULL,
  `HORAS` VARCHAR(4) NOT NULL,
  `LOGIN` VARCHAR(40) NOT NULL,
  PRIMARY KEY (`ID_PROJETO`),
  INDEX `FK_TB_PROJETO_TB_CLIENTE1_IDX` (`ID_CLIENTE` ASC),
  INDEX `FK_TB_PROJETO_TB_USUARIO1_IDX` (`LOGIN` ASC),
  CONSTRAINT `FK_TB_PROJETO_TB_CLIENTE1`
    FOREIGN KEY (`ID_CLIENTE`)
    REFERENCES `PI_6_INSIDE`.`TB_CLIENTE` (`ID_CLIENTE`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_TB_PROJETO_TB_USUARIO1`
    FOREIGN KEY (`LOGIN`)
    REFERENCES `PI_6_INSIDE`.`TB_USUARIO` (`LOGIN`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = INNODB;


-- -----------------------------------------------------
-- TABLE `PI_6_INSIDE`.`TB_DEMANDA`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PI_6_INSIDE`.`TB_DEMANDA` (
  `ID_DEMANDA` INT NOT NULL AUTO_INCREMENT,
  `DESC_DEMANDA` VARCHAR(70) NOT NULL,
  `DETALHES` VARCHAR(200) NOT NULL,
  `ID_PROJETO` INT NOT NULL,
  `DURACAO` VARCHAR(4) NOT NULL,
  `ID_FUNCIONARIO` INT NOT NULL,
  PRIMARY KEY (`ID_DEMANDA`),
  INDEX `FK_TB_DEMANDA_TB_PROJETO1_IDX` (`ID_PROJETO` ASC),
  INDEX `FK_TB_DEMANDA_TB_FUNCIONARIO1_IDX` (`ID_FUNCIONARIO` ASC),
  CONSTRAINT `FK_TB_DEMANDA_TB_PROJETO1`
    FOREIGN KEY (`ID_PROJETO`)
    REFERENCES `PI_6_INSIDE`.`TB_PROJETO` (`ID_PROJETO`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_TB_DEMANDA_TB_FUNCIONARIO1`
    FOREIGN KEY (`ID_FUNCIONARIO`)
    REFERENCES `PI_6_INSIDE`.`TB_FUNCIONARIO` (`ID_FUNCIONARIO`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = INNODB;


-- -----------------------------------------------------
-- TABLE `PI_6_INSIDE`.`TB_PRODUCAO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PI_6_INSIDE`.`TB_PRODUCAO` (
  `ID_PRODUCAO` INT NOT NULL AUTO_INCREMENT,
  `DATA` DATE NOT NULL,
  `HR_INICIO` TIME NOT NULL,
  `HR_FIM` TIME NULL,
  `ID_DEMANDA` INT NOT NULL,
  PRIMARY KEY (`ID_PRODUCAO`),
  INDEX `FK_TB_PRODUCAO_TB_DEMANDA1_IDX` (`ID_DEMANDA` ASC),
  CONSTRAINT `FK_TB_PRODUCAO_TB_DEMANDA1`
    FOREIGN KEY (`ID_DEMANDA`)
    REFERENCES `PI_6_INSIDE`.`TB_DEMANDA` (`ID_DEMANDA`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = INNODB;


-- -----------------------------------------------------
-- TABLE `PI_6_INSIDE`.`TB_RECURSO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PI_6_INSIDE`.`TB_RECURSO` (
  `ID_RECURSO` INT NOT NULL AUTO_INCREMENT,
  `ID_DEMANDA` INT NOT NULL,
  `LOGIN` VARCHAR(40) NOT NULL,
  PRIMARY KEY (`ID_RECURSO`),
  INDEX `FK_TB_RECURSO_TB_DEMANDA1_IDX` (`ID_DEMANDA` ASC),
  INDEX `FK_TB_RECURSO_TB_USUARIO1_IDX` (`LOGIN` ASC),
  CONSTRAINT `FK_TB_RECURSO_TB_DEMANDA1`
    FOREIGN KEY (`ID_DEMANDA`)
    REFERENCES `PI_6_INSIDE`.`TB_DEMANDA` (`ID_DEMANDA`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_TB_RECURSO_TB_USUARIO1`
    FOREIGN KEY (`LOGIN`)
    REFERENCES `PI_6_INSIDE`.`TB_USUARIO` (`LOGIN`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = INNODB;


-- -----------------------------------------------------
-- TABLE `PI_6_INSIDE`.`TB_COMENTARIO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PI_6_INSIDE`.`TB_COMENTARIO` (
  `ID_COMENTARIO` INT NOT NULL AUTO_INCREMENT,
  `COMENTARIO` VARCHAR(400) NOT NULL,
  `DT_COMENTARIO` DATETIME NOT NULL,
  `ID_RECURSO` INT NOT NULL,
  PRIMARY KEY (`ID_COMENTARIO`),
  INDEX `FK_TB_COMENTARIO_TB_RECURSO1_IDX` (`ID_RECURSO` ASC),
  CONSTRAINT `FK_TB_COMENTARIO_TB_RECURSO1`
    FOREIGN KEY (`ID_RECURSO`)
    REFERENCES `PI_6_INSIDE`.`TB_RECURSO` (`ID_RECURSO`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = INNODB;


-- -----------------------------------------------------
-- TABLE `PI_6_INSIDE`.`TB_ARQUIVO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PI_6_INSIDE`.`TB_ARQUIVO` (
  `ID_ARQUIVO` INT NOT NULL AUTO_INCREMENT,
  `DIRETORIO_ARQ` VARCHAR(300) NOT NULL,
  `ID_RECURSO` INT NOT NULL,
  PRIMARY KEY (`ID_ARQUIVO`),
  INDEX `FK_TB_ARQUIVO_TB_RECURSO1_IDX` (`ID_RECURSO` ASC),
  CONSTRAINT `FK_TB_ARQUIVO_TB_RECURSO1`
    FOREIGN KEY (`ID_RECURSO`)
    REFERENCES `PI_6_INSIDE`.`TB_RECURSO` (`ID_RECURSO`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = INNODB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
