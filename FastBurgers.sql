SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

CREATE SCHEMA IF NOT EXISTS `FastBurgers` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `FastBurgers` ;

-- -----------------------------------------------------
-- Table `FastBurgers`.`customer`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `FastBurgers`.`customer` (
  `id` INT(6) NOT NULL ,
  `name` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `FastBurgers`.`outlet`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `FastBurgers`.`outlet` (
  `id` INT(6) NOT NULL ,
  `address` VARCHAR(100) NOT NULL ,
  `contact_no` VARCHAR(15) NOT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `FastBurgers`.`cashier`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `FastBurgers`.`cashier` (
  `id` INT(6) NOT NULL ,
  `name` VARCHAR(45) NOT NULL ,
  `shift` VARCHAR(10) NOT NULL ,
  `outlet_id` INT(6) NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_cashier_outlet1_idx` (`outlet_id` ASC) ,
  CONSTRAINT `fk_cashier_outlet1`
    FOREIGN KEY (`outlet_id` )
    REFERENCES `FastBurgers`.`outlet` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `FastBurgers`.`bill`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `FastBurgers`.`bill` (
  `no` INT(6) NOT NULL ,
  `total` DECIMAL(6,2) NOT NULL ,
  `method_of_payment` VARCHAR(4) NOT NULL ,
  `customer_id` INT(6) NOT NULL ,
  `cashier_id` INT(6) NOT NULL ,
  PRIMARY KEY (`no`) ,
  INDEX `fk_bill_customer1_idx` (`customer_id` ASC) ,
  INDEX `fk_bill_cashier1_idx` (`cashier_id` ASC) ,
  CONSTRAINT `fk_bill_customer1`
    FOREIGN KEY (`customer_id` )
    REFERENCES `FastBurgers`.`customer` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_bill_cashier1`
    FOREIGN KEY (`cashier_id` )
    REFERENCES `FastBurgers`.`cashier` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `FastBurgers`.`inventory`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `FastBurgers`.`inventory` (
  `id` INT(6) NOT NULL ,
  `quantity` INT(6) NOT NULL ,
  `restock_margin` INT(6) NOT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `FastBurgers`.`products`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `FastBurgers`.`products` (
  `id` INT(6) NOT NULL ,
  `name` VARCHAR(45) NOT NULL ,
  `category` VARCHAR(8) NOT NULL ,
  `quantity` INT(6) NOT NULL ,
  `price` DECIMAL(6,2) NOT NULL ,
  `inventory_id` INT(6) NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_products_inventory1_idx` (`inventory_id` ASC) ,
  CONSTRAINT `fk_products_inventory1`
    FOREIGN KEY (`inventory_id` )
    REFERENCES `FastBurgers`.`inventory` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `FastBurgers`.`products_inventory`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `FastBurgers`.`products_inventory` (
  `products_id` INT(6) NOT NULL ,
  `inventory_id` INT(6) NOT NULL ,
  PRIMARY KEY (`products_id`, `inventory_id`) ,
  INDEX `fk_products_has_inventory_inventory1_idx` (`inventory_id` ASC) ,
  INDEX `fk_products_has_inventory_products1_idx` (`products_id` ASC) ,
  CONSTRAINT `fk_products_has_inventory_products1`
    FOREIGN KEY (`products_id` )
    REFERENCES `FastBurgers`.`products` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_products_has_inventory_inventory1`
    FOREIGN KEY (`inventory_id` )
    REFERENCES `FastBurgers`.`inventory` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `FastBurgers`.`manager`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `FastBurgers`.`manager` (
  `id` INT(6) NOT NULL ,
  `name` VARCHAR(45) NOT NULL ,
  `shift` VARCHAR(10) NOT NULL ,
  `outlet_id` INT(6) NOT NULL ,
  `products_inventory_products_id` INT(6) NOT NULL ,
  `products_inventory_inventory_id` INT(6) NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_manager_outlet1_idx` (`outlet_id` ASC) ,
  INDEX `fk_manager_products_inventory1_idx` (`products_inventory_products_id` ASC, `products_inventory_inventory_id` ASC) ,
  CONSTRAINT `fk_manager_outlet1`
    FOREIGN KEY (`outlet_id` )
    REFERENCES `FastBurgers`.`outlet` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_manager_products_inventory1`
    FOREIGN KEY (`products_inventory_products_id` , `products_inventory_inventory_id` )
    REFERENCES `FastBurgers`.`products_inventory` (`products_id` , `inventory_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `FastBurgers`.`servicestaff`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `FastBurgers`.`servicestaff` (
  `id` INT(6) NOT NULL ,
  `name` VARCHAR(45) NOT NULL ,
  `shift` VARCHAR(10) NOT NULL ,
  `outlet_id` INT(6) NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_servicestaff_outlet1_idx` (`outlet_id` ASC) ,
  CONSTRAINT `fk_servicestaff_outlet1`
    FOREIGN KEY (`outlet_id` )
    REFERENCES `FastBurgers`.`outlet` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `FastBurgers`.`order`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `FastBurgers`.`order` (
  `no` INT(6) NOT NULL ,
  `total` DECIMAL(6,2) NOT NULL ,
  `manager_id` INT(6) NOT NULL ,
  `customer_id` INT(6) NOT NULL ,
  `servicestaff_id` INT(6) NOT NULL ,
  `cashier_id` INT(6) NOT NULL ,
  `products_id` INT(6) NOT NULL ,
  PRIMARY KEY (`no`) ,
  INDEX `fk_order_manager1_idx` (`manager_id` ASC) ,
  INDEX `fk_order_customer1_idx` (`customer_id` ASC) ,
  INDEX `fk_order_servicestaff1_idx` (`servicestaff_id` ASC) ,
  INDEX `fk_order_cashier1_idx` (`cashier_id` ASC) ,
  INDEX `fk_order_products1_idx` (`products_id` ASC) ,
  CONSTRAINT `fk_order_manager1`
    FOREIGN KEY (`manager_id` )
    REFERENCES `FastBurgers`.`manager` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_order_customer1`
    FOREIGN KEY (`customer_id` )
    REFERENCES `FastBurgers`.`customer` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_order_servicestaff1`
    FOREIGN KEY (`servicestaff_id` )
    REFERENCES `FastBurgers`.`servicestaff` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_order_cashier1`
    FOREIGN KEY (`cashier_id` )
    REFERENCES `FastBurgers`.`cashier` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_order_products1`
    FOREIGN KEY (`products_id` )
    REFERENCES `FastBurgers`.`products` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `FastBurgers`.`cook`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `FastBurgers`.`cook` (
  `id` INT(6) NOT NULL ,
  `name` VARCHAR(45) NOT NULL ,
  `shift` VARCHAR(10) NOT NULL ,
  `inventory_id` INT(6) NOT NULL ,
  `manager_id` INT(6) NOT NULL ,
  `servicestaff_id` INT(6) NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_cook_inventory1_idx` (`inventory_id` ASC) ,
  INDEX `fk_cook_manager1_idx` (`manager_id` ASC) ,
  INDEX `fk_cook_servicestaff1_idx` (`servicestaff_id` ASC) ,
  CONSTRAINT `fk_cook_inventory1`
    FOREIGN KEY (`inventory_id` )
    REFERENCES `FastBurgers`.`inventory` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cook_manager1`
    FOREIGN KEY (`manager_id` )
    REFERENCES `FastBurgers`.`manager` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cook_servicestaff1`
    FOREIGN KEY (`servicestaff_id` )
    REFERENCES `FastBurgers`.`servicestaff` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `FastBurgers`.`menu`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `FastBurgers`.`menu` (
  `id` INT(6) NOT NULL ,
  `type` VARCHAR(7) NOT NULL ,
  `validity` VARCHAR(15) NOT NULL ,
  `products_id` INT(6) NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_menu_products1_idx` (`products_id` ASC) ,
  CONSTRAINT `fk_menu_products1`
    FOREIGN KEY (`products_id` )
    REFERENCES `FastBurgers`.`products` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `FastBurgers` ;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
