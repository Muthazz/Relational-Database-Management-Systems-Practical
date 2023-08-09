/*Which customer places which order*/
SELECT id AS customer_id, `name` AS customer_name, `order`.`no` AS order_no, `order`.`total` AS order_total 
FROM customer INNER JOIN `order` ON customer.id = `order`.`no` ORDER BY `name` ASC;

/*All items on that order*/
SELECT `order`.`no` AS order_no, id AS products_id, `name` AS products_name, category AS products_category, 
`order`.`total` AS order_total FROM products INNER JOIN `order` ON products.id = `order`.`no`;

/*Customer paid by card or cash*/
SELECT id AS customer_id, `name` AS customer_name, total AS bill_total, method_of_payment 
FROM customer INNER JOIN bill ON customer.`id` = bill.`no`;

/*Which member of service staff took that order*/
SELECT `order`.servicestaff_id, servicestaff.`name` AS servicestaff_name, `order`.`no` AS order_no 
FROM `order` INNER JOIN servicestaff ON `order`.servicestaff_id = servicestaff.`id`;

/*Which manager took that order*/
SELECT `order`.manager_id, manager.`name` AS manager_name, `order`.`no` AS order_no 
FROM `order` INNER JOIN manager ON `order`.manager_id = manager.`id`;

/*Shifts for managers*/
SELECT `name` AS manager_name, shift FROM manager;

/*Shifts for cashiers*/
SELECT `name` AS cashier_name, shift FROM cashier;

/*Shifts for service staff*/
SELECT `name` AS servicestaff_name, shift FROM servicestaff;

/*Shifts for cooks*/
SELECT `name` AS cook_name, shift FROM cook;

/*Which proucts need restock*/
SELECT id, `name`, category, quantity FROM products
WHERE quantity < 500;