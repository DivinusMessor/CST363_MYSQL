-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema pharmacy
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `pharmacy` DEFAULT CHARACTER SET utf8 ;
USE `pharmacy` ;

-- -----------------------------------------------------
-- Table `pharmacy`.`doctor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pharmacy`.`doctor` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `ssn` VARCHAR(9) NOT NULL,
  `name` VARCHAR(70) NOT NULL,
  `specialty` VARCHAR(70) NOT NULL,
  `practice_since_year` INT NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pharmacy`.`patient`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pharmacy`.`patient` (
  `patientID` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(70) NOT NULL,
  `birthdate` DATE NOT NULL,
  `ssn` VARCHAR(9) NOT NULL,
  `street` VARCHAR(70) NOT NULL,
  `city` VARCHAR(70) NOT NULL,
  `state` VARCHAR(45) NOT NULL,
  `zipcode` VARCHAR(10) NOT NULL,
  `primaryID` INT NOT NULL,
  PRIMARY KEY (`patientID`),
  INDEX `fk_patient_doctor_idx` (`primaryID` ASC) VISIBLE,
  CONSTRAINT `fk_patient_doctor`
    FOREIGN KEY (`primaryID`)
    REFERENCES `pharmacy`.`doctor` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pharmacy`.`company`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pharmacy`.`company` (
  `companyID` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(70) NOT NULL,
  `phone_number` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`companyID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pharmacy`.`drug`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pharmacy`.`drug` (
  `drug_id` INT(11) NOT NULL,
  `trade_name` VARCHAR(45) NULL,
  `formula` VARCHAR(45) NULL,
  `companyID` INT NULL,
  PRIMARY KEY (`drug_id`),
  INDEX `fk_drug_company1_idx` (`companyID` ASC) VISIBLE,
  CONSTRAINT `fk_drug_company1`
    FOREIGN KEY (`companyID`)
    REFERENCES `pharmacy`.`company` (`companyID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pharmacy`.`pharmacy`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pharmacy`.`pharmacy` (
  `pharmacyID` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(70) NOT NULL,
  `address` VARCHAR(70) NOT NULL,
  `phone_number` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`pharmacyID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pharmacy`.`prescription`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pharmacy`.`prescription` (
  `rxid` INT NOT NULL AUTO_INCREMENT,
  `drug_id` INT(11) NOT NULL,
  `quantity` INT NOT NULL,
  `prescribed_date` DATE NOT NULL,
  `patientID` INT NOT NULL,
  `doctor_id` INT NOT NULL,
  `pharmacyID` INT NULL,
  `date_filled` DATE NULL,
  `cost` DECIMAL(7,2) NULL,
  PRIMARY KEY (`rxid`),
  INDEX `fk_prescription_drug1_idx` (`drug_id` ASC) VISIBLE,
  INDEX `fk_prescription_patient1_idx` (`patientID` ASC) VISIBLE,
  INDEX `fk_prescription_doctor1_idx` (`doctor_id` ASC) VISIBLE,
  INDEX `fk_prescription_pharmacy1_idx` (`pharmacyID` ASC) VISIBLE,
  CONSTRAINT `fk_prescription_drug1`
    FOREIGN KEY (`drug_id`)
    REFERENCES `pharmacy`.`drug` (`drug_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_prescription_patient1`
    FOREIGN KEY (`patientID`)
    REFERENCES `pharmacy`.`patient` (`patientID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_prescription_doctor1`
    FOREIGN KEY (`doctor_id`)
    REFERENCES `pharmacy`.`doctor` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_prescription_pharmacy1`
    FOREIGN KEY (`pharmacyID`)
    REFERENCES `pharmacy`.`pharmacy` (`pharmacyID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pharmacy`.`supervisor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pharmacy`.`supervisor` (
  `supervisorID` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(70) NOT NULL,
  `ssn` VARCHAR(9) NOT NULL,
  PRIMARY KEY (`supervisorID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pharmacy`.`contract`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pharmacy`.`contract` (
  `contractID` INT NOT NULL AUTO_INCREMENT,
  `start_date` DATE NOT NULL,
  `end_date` DATE NOT NULL,
  `text` VARCHAR(255) NOT NULL,
  `price` DECIMAL(7,2) NOT NULL,
  `supervisorID` INT NOT NULL,
  `pharmacyID` INT NOT NULL,
  `drug_id` INT(11) NOT NULL,
  PRIMARY KEY (`contractID`),
  INDEX `fk_contract_supervisor1_idx` (`supervisorID` ASC) VISIBLE,
  INDEX `fk_contract_pharmacy1_idx` (`pharmacyID` ASC) VISIBLE,
  INDEX `fk_contract_drug1_idx` (`drug_id` ASC) VISIBLE,
  CONSTRAINT `fk_contract_supervisor1`
    FOREIGN KEY (`supervisorID`)
    REFERENCES `pharmacy`.`supervisor` (`supervisorID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_contract_pharmacy1`
    FOREIGN KEY (`pharmacyID`)
    REFERENCES `pharmacy`.`pharmacy` (`pharmacyID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_contract_drug1`
    FOREIGN KEY (`drug_id`)
    REFERENCES `pharmacy`.`drug` (`drug_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
