SHOW DATABASES;

USE company;

-- Creating a table Employee_deatils
CREATE TABLE employee_details (
    emp_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50)
);

-- Inserting values in Employee_details table
INSERT INTO employee_details (emp_id, first_name, last_name) VALUES
(101, 'Sohali', 'Baisla'),
(102, 'Shivani', 'Marwaha'),
(103, 'Shree', 'Rout'),
(104, 'Ashu', 'Behuria'),
(105, 'Chase', 'Paul'),
(106, 'Emily', 'Dickinson'),
(107, 'Ana', 'Huang'),
(108, 'Grace', 'Smith'),
(109, 'Amilia', 'Clark'),
(110, 'Henry', 'Cavill');

-- Create table Manager_details
CREATE TABLE manager_details (
    manager_id INT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    emp_id INT,
    FOREIGN KEY (emp_id) REFERENCES employee_details(emp_id),
    PRIMARY KEY (manager_id, emp_id) 
);

-- Inserying values in Manager_details table
INSERT INTO manager_details (manager_id, first_name, last_name, emp_id) VALUES
(201, 'Michael', 'Scott', 101),
(201, 'Michael', 'Scott', 102),
(201, 'Michael', 'Scott', 103),
(202, 'Dwight', 'Schrute', 104),
(202, 'Dwight', 'Schrute', 105),
(202, 'Dwight', 'Schrute', 106),
(203, 'Jim', 'Halpert', 107),
(203, 'Jim', 'Halpert', 108),
(203, 'Jim', 'Halpert', 109),
(203, 'Jim', 'Halpert', 110);

-- Show all employee_deatils
SELECT * FROM employee_details;

-- Show all manager_details 
SELECT * FROM manager_details;

-- Get all employees under each manager
SELECT 
    e.emp_id,
    e.first_name AS employee_first_name,
    e.last_name AS employee_last_name,
    m.manager_id,
    m.first_name AS manager_first_name,
    m.last_name AS manager_last_name
FROM 
    employee_details e
JOIN 
    manager_details m ON e.emp_id = m.emp_id;
   
-- List all employees under manager- Michael Scott
SELECT 
    e.emp_id,
    e.first_name AS employee_first_name,
    e.last_name AS employee_last_name
FROM 
    employee_details e
JOIN 
    manager_details m ON e.emp_id = m.emp_id
WHERE 
    m.first_name = 'Michael' AND m.last_name = 'Scott';

-- How many employees are there under manager- Jim Halpert
SELECT 
    COUNT(e.emp_id) AS employee_count
FROM 
    employee_details e
JOIN 
    manager_details m ON e.emp_id = m.emp_id
WHERE 
    m.first_name = 'Jim' AND m.last_name = 'Halpert';

-- Insert 2 new employees to table Employee_details
INSERT INTO employee_details (emp_id, first_name, last_name) VALUES
(111, 'Ken', 'Adams'),
(112, 'Chandler', 'Bing');

-- Show all employee_details wih no manager
SELECT 
    e.emp_id,
    e.first_name,
    e.last_name
FROM 
    employee_details e
LEFT JOIN 
    manager_details m ON e.emp_id = m.emp_id
WHERE 
    m.manager_id IS NULL;

-- Write a function to get first and last name of an employee
DELIMITER $$
CREATE FUNCTION get_employee_name(emp_id INT)
RETURNS VARCHAR(100)
DETERMINISTIC
BEGIN
    DECLARE full_name VARCHAR(100);

    SELECT CONCAT(first_name, ' ', last_name) INTO full_name
    FROM employee_details
    WHERE employee_details.emp_id = emp_id;
    RETURN full_name;
END $$
DELIMITER ;

SELECT get_employee_name(101);