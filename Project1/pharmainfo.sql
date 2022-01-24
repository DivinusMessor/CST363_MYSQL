-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema pharmainfo
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema pharmainfo
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `pharmainfo` DEFAULT CHARACTER SET utf8 ;
USE `pharmainfo` ;

-- -----------------------------------------------------
-- Table `pharmainfo`.`company`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pharmainfo`.`company` (
  `CompanyName` VARCHAR(70) NOT NULL,
  `PhoneNumber` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`CompanyName`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `pharmainfo`.`pharmacy`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pharmainfo`.`pharmacy` (
  `PharmacyID` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(70) NOT NULL,
  `Address` VARCHAR(255) NOT NULL,
  `PhoneNumber` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`PharmacyID`))
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `pharmainfo`.`supervisor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pharmainfo`.`supervisor` (
  `SSN` VARCHAR(9) NOT NULL,
  `FullName` VARCHAR(70) NOT NULL,
  PRIMARY KEY (`SSN`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `pharmainfo`.`contract`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pharmainfo`.`contract` (
  `ContractID` INT NOT NULL AUTO_INCREMENT,
  `StartDate` DATE NOT NULL,
  `EndDate` DATE NOT NULL,
  `Text` VARCHAR(255) NOT NULL,
  `Price` DECIMAL(6,2) NOT NULL,
  `CompanyName` VARCHAR(70) NOT NULL,
  `PharmacyID` INT NOT NULL,
  `Supervisor_SSN` VARCHAR(9) NOT NULL,
  PRIMARY KEY (`ContractID`),
  INDEX `fk_Contract_Company1_idx` (`CompanyName` ASC) VISIBLE,
  INDEX `fk_Contract_Pharmacy1_idx` (`PharmacyID` ASC) VISIBLE,
  INDEX `fk_contract_Supervisor1_idx` (`Supervisor_SSN` ASC) VISIBLE,
  CONSTRAINT `fk_Contract_Company1`
    FOREIGN KEY (`CompanyName`)
    REFERENCES `pharmainfo`.`company` (`CompanyName`),
  CONSTRAINT `fk_Contract_Pharmacy1`
    FOREIGN KEY (`PharmacyID`)
    REFERENCES `pharmainfo`.`pharmacy` (`PharmacyID`),
  CONSTRAINT `fk_contract_Supervisor1`
    FOREIGN KEY (`Supervisor_SSN`)
    REFERENCES `pharmainfo`.`supervisor` (`SSN`))
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `pharmainfo`.`doctors`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pharmainfo`.`doctors` (
  `SSN` VARCHAR(9) NOT NULL,
  `FullName` VARCHAR(70) NOT NULL,
  `Specialty` VARCHAR(70) NOT NULL,
  `ExperienceInYears` INT NOT NULL,
  PRIMARY KEY (`SSN`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `pharmainfo`.`medication`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pharmainfo`.`medication` (
  `TradeName` VARCHAR(70) NOT NULL,
  `GenericFormula` VARCHAR(70) NOT NULL,
  `CompanyName` VARCHAR(70) NOT NULL,
  PRIMARY KEY (`TradeName`),
  INDEX `fk_medication_Company1_idx` (`CompanyName` ASC) VISIBLE,
  CONSTRAINT `fk_medication_Company1`
    FOREIGN KEY (`CompanyName`)
    REFERENCES `pharmainfo`.`company` (`CompanyName`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `pharmainfo`.`patient`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pharmainfo`.`patient` (
  `SSN` VARCHAR(9) NOT NULL,
  `FullName` VARCHAR(70) NOT NULL,
  `Age` INT NOT NULL,
  `Address` VARCHAR(255) NOT NULL,
  `PrimaryPhysicianSSN` VARCHAR(9) NOT NULL,
  PRIMARY KEY (`SSN`),
  INDEX `fk_patient_doctors1_idx` (`PrimaryPhysicianSSN` ASC) VISIBLE,
  CONSTRAINT `fk_patient_doctors1`
    FOREIGN KEY (`PrimaryPhysicianSSN`)
    REFERENCES `pharmainfo`.`doctors` (`SSN`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `pharmainfo`.`prescription`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pharmainfo`.`prescription` (
  `RXNum` INT NOT NULL AUTO_INCREMENT,
  `Quantity` INT NOT NULL,
  `PrescribedDate` DATE NOT NULL,
  `FilledDate` DATE NULL DEFAULT NULL,
  `FilledPharmacyID` INT NULL,
  `medicationTradeName` VARCHAR(70) NOT NULL,
  `patient_SSN` VARCHAR(9) NOT NULL,
  `doctors_SSN` VARCHAR(9) NOT NULL,
  PRIMARY KEY (`RXNum`),
  INDEX `fk_prescription_medication1_idx` (`medicationTradeName` ASC) VISIBLE,
  INDEX `fk_prescription_patient1_idx` (`patient_SSN` ASC) VISIBLE,
  INDEX `fk_prescription_doctors1_idx` (`doctors_SSN` ASC) VISIBLE,
  INDEX `fk_prescription_pharmacy1_idx` (`FilledPharmacyID` ASC) VISIBLE,
  CONSTRAINT `fk_prescription_doctors1`
    FOREIGN KEY (`doctors_SSN`)
    REFERENCES `pharmainfo`.`doctors` (`SSN`),
  CONSTRAINT `fk_prescription_medication1`
    FOREIGN KEY (`medicationTradeName`)
    REFERENCES `pharmainfo`.`medication` (`TradeName`),
  CONSTRAINT `fk_prescription_patient1`
    FOREIGN KEY (`patient_SSN`)
    REFERENCES `pharmainfo`.`patient` (`SSN`),
  CONSTRAINT `fk_prescription_pharmacy1`
    FOREIGN KEY (`FilledPharmacyID`)
    REFERENCES `pharmainfo`.`pharmacy` (`PharmacyID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = utf8mb3;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;





-- inserts 
INSERT INTO doctors VALUES ('222114444', 'Joey Mann', 'Heart', 2);
INSERT INTO doctors VALUES ('222114449', 'Marxwell Houston', 'Heart', 1);
INSERT INTO doctors VALUES ('222113349', 'Hos Gun', 'Brain', 4);

INSERT INTO patient VALUES ('111223333', 'Bob Zager', 56, '311 Mulberry Road', '222114444'); 
INSERT INTO patient VALUES ('333112222', 'Ada Wong', 21, '215 Help Street', '222114449');
INSERT INTO patient VALUES ('333112229', 'Norma City', 27, '123 myname Street', '222114449');
INSERT INTO patient VALUES ('223112229', 'Gram Steph', 17, '215 hrash Street', '222113349');

INSERT INTO company VALUES ('Bobs Meds', '5551112222');

INSERT INTO medication VALUES('Tylenol', 'Ibeprofen', 'Bobs Meds');
INSERT INTO medication VALUES('Advil', 'Otherprofen', 'Bobs Meds');
INSERT INTO medication VALUES('Metaformin', 'PRN', 'Pfizer');

INSERT INTO prescription (quantity, prescribeddate, filleddate, filledpharmacyid, medicationtradename, patient_ssn, doctors_ssn) 
VALUES ('3', '2022-01-11', null, null, 'Tylenol', '111223333', '222114444');
INSERT INTO prescription (quantity, prescribeddate, filleddate, filledpharmacyid, medicationtradename, patient_ssn, doctors_ssn) 
VALUES ('2', '2021-01-21', null, null, 'Tylenol', '333112222', '222114444');

------------------

INSERT INTO supervisor VALUES ('890112222', 'Linda Rom');
INSERT INTO supervisor VALUES ('890113333', 'Mark Cap');

INSERT INTO pharmacy (Name, Address, PhoneNumber) 
VALUES ('CVS', '12 Grove Street', '5553131111');
INSERT INTO pharmacy (Name, Address, PhoneNumber) 
VALUES ('Walmart', '15 Money Street', '5553135555');

INSERT INTO contract (StartDate, EndDate, Text, Price, CompanyName, PharmacyID, Supervisor_SSN)
VALUES ('2002-02-11', '2025-02-11', 'Here we shall share our bounty', '8.99', 'Bobs Meds', 4, 890112222);
INSERT INTO contract (StartDate, EndDate, Text, Price, CompanyName, PharmacyID, Supervisor_SSN)
VALUES ('2005-03-09', '2025-04-12', 'more meds', '10.99', 'Bobs Meds', 4, 890112222);
INSERT INTO contract (StartDate, EndDate, Text, Price, CompanyName, PharmacyID, Supervisor_SSN)
VALUES ('2005-03-09', '2025-04-12', 'more meds', '10.99', 'Bobs Meds', 4, 890112222);
INSERT INTO contract (StartDate, EndDate, Text, Price, CompanyName, PharmacyID, Supervisor_SSN)
VALUES ('2002-03-11', '2025-04-11', 'bounty', '10.99', 'Pfizer', 5, 890113333);