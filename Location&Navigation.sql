SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL';

CREATE SCHEMA IF NOT EXISTS `Location&Navigation` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci ;
USE `Location&Navigation` ;

-- -----------------------------------------------------
-- Table `Location&Navigation`.`User`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Location&Navigation`.`User` (
  `userID` INT NOT NULL ,
  PRIMARY KEY (`userID`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Location&Navigation`.`GuideInformation`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Location&Navigation`.`GuideInformation` (
  `guideInformationID` INT NOT NULL ,
  `userID` INT NULL ,
  `distance` DOUBLE NULL ,
  PRIMARY KEY (`guideInformationID`) ,
  INDEX `user` (`userID` ASC) ,
  CONSTRAINT `user`
    FOREIGN KEY (`userID` )
    REFERENCES `Location&Navigation`.`User` (`userID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Location&Navigation`.`Place`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Location&Navigation`.`Place` (
  `placeID` INT NOT NULL ,
  `placeType` INT NOT NULL ,
  `placePositionX` DOUBLE NOT NULL ,
  `placePositionY` DOUBLE NOT NULL ,
  `placePositionZ` DOUBLE NOT NULL ,
  PRIMARY KEY (`placeID`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Location&Navigation`.`GuidePathInformation`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Location&Navigation`.`GuidePathInformation` (
  `guideInformationID` INT NOT NULL ,
  `passPlaceID` INT NOT NULL ,
  INDEX `guideInformation` (`guideInformationID` ASC) ,
  INDEX `passPlace` (`passPlaceID` ASC) ,
  CONSTRAINT `guideInformation`
    FOREIGN KEY (`guideInformationID` )
    REFERENCES `Location&Navigation`.`GuideInformation` (`guideInformationID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `passPlace`
    FOREIGN KEY (`passPlaceID` )
    REFERENCES `Location&Navigation`.`Place` (`placeID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Location&Navigation`.`Wifi`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Location&Navigation`.`Wifi` (
  `wifiID` INT NOT NULL ,
  `deviceType` VARCHAR(45) NULL ,
  `wifiPositionX` DOUBLE NOT NULL ,
  `wifiPositionY` DOUBLE NOT NULL ,
  `wifiPositionZ` DOUBLE NOT NULL ,
  `startTime` TIME NULL ,
  `endTime` TIME NULL ,
  PRIMARY KEY (`wifiID`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Location&Navigation`.`MapInformation`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Location&Navigation`.`MapInformation` (
  `placeID` INT NOT NULL ,
  `wifiID` INT NOT NULL ,
  INDEX `place` (`placeID` ASC) ,
  INDEX `wifi` (`wifiID` ASC) ,
  CONSTRAINT `place`
    FOREIGN KEY (`placeID` )
    REFERENCES `Location&Navigation`.`Place` (`placeID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `wifi`
    FOREIGN KEY (`wifiID` )
    REFERENCES `Location&Navigation`.`Wifi` (`wifiID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Location&Navigation`.`ChooseInformation`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Location&Navigation`.`ChooseInformation` (
  `chooseInformationID` INT NOT NULL ,
  `userID` INT NOT NULL ,
  `startPlaceID` INT NOT NULL ,
  `endPlaceID` INT NOT NULL ,
  PRIMARY KEY (`chooseInformationID`) ,
  INDEX `chooseStartPlaceID` (`startPlaceID` ASC) ,
  INDEX `chooseUserID` (`userID` ASC) ,
  INDEX `chooseEndPlaceID` (`endPlaceID` ASC) ,
  CONSTRAINT `chooseStartPlaceID`
    FOREIGN KEY (`startPlaceID` )
    REFERENCES `Location&Navigation`.`Place` (`placeID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `chooseUserID`
    FOREIGN KEY (`userID` )
    REFERENCES `Location&Navigation`.`User` (`userID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `chooseEndPlaceID`
    FOREIGN KEY (`endPlaceID` )
    REFERENCES `Location&Navigation`.`Place` (`placeID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
