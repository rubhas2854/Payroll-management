create database payroll;
use payroll;

CREATE TABLE roles (
    role_id INT PRIMARY KEY AUTO_INCREMENT,
    role_name VARCHAR(100)
);
select * from roles;

insert into roles(role_name)values('admin'),('super admin');
insert into roles(role_name)values('editor'),('viewer'),('guest'),('moderator');

CREATE TABLE departments (
    department_id INT PRIMARY KEY AUTO_INCREMENT,
    department_name VARCHAR(100)
);
select * from departments;

insert into departments(department_name)values('IT'),('sales'),('marketing'),('finance');
insert into departments(department_name)values('facility management'),('security'),('business development'),('administration');

CREATE TABLE employees (
    employee_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(15),
    hire_date DATE,
    role_id INT,
    department_id INT,
    status ENUM('Active', 'Inactive') DEFAULT 'Active',
    FOREIGN KEY (role_id) REFERENCES roles(role_id),
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);
select * from employees;

INSERT INTO employees (first_name, last_name, email, phone, hire_date, role_id, department_id)
VALUES ('John', 'Doe', 'john.doe@example.com', '555-1234', '2025-02-28', 1, 2);
INSERT INTO employees (first_name, last_name, email, phone, hire_date, role_id, department_id)
VALUES ('santhosh', 'kumar', 'santhosh24@example.com', '999-8674', '2023-01-18', 2, 3);
insert into employees(first_name, last_name, email, phone, hire_date, role_id, department_id)
VALUES ('Hema', 'priya', 'hema14@example.com', '666-8534', '2023-01-18', 3, 3);
insert into employees(first_name, last_name, email, phone, hire_date, role_id, department_id)values('arun','kumar','arun123@gmail.com','555-3421','2023-04-15',4,4),
('ruba','dharshini','rubhadharshini28@gmail.com','666-6543','2024-06-28',5,5);

CREATE TABLE salaries (
    salary_id INT PRIMARY KEY AUTO_INCREMENT,
    employee_id INT,
    base_salary DECIMAL(10, 2),
    bonus DECIMAL(10, 2) DEFAULT 0.00,
    deductions DECIMAL(10, 2) DEFAULT 0.00,
    total_salary DECIMAL(10, 2) AS (base_salary + bonus - deductions) STORED,
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
);

select * from salaries;

INSERT INTO salaries (employee_id, base_salary, bonus, deductions)
VALUES (1, 5000.00, 500.00, 100.00);
INSERT INTO salaries (employee_id, base_salary, bonus, deductions)
VALUES (2, 10000.00, 1000.00, 500.00);
INSERT INTO salaries (employee_id, base_salary, bonus, deductions)
VALUES (3, 2000.00, 150.00, 100.00),(4,9000.00,650.00,700.00),(5,5800.00,540.00,150.00);


CREATE TABLE leaves (
    leave_id INT PRIMARY KEY AUTO_INCREMENT,
    employee_id INT,
    leave_type VARCHAR(50),
    start_date DATE,
    end_date DATE,
    status ENUM('Approved', 'Pending', 'Rejected') DEFAULT 'Pending',
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
);
select * from leaves;
INSERT INTO leaves (employee_id, leave_type, start_date, end_date, status)
VALUES (1, 'Sick', '2025-03-01', '2025-03-03', 'Pending');
INSERT INTO leaves (employee_id, leave_type, start_date, end_date, status)
VALUES (2, 'vacation', '2025-02-01', '2025-02-03', 'approved');
INSERT INTO leaves (employee_id, leave_type, start_date, end_date, status)
VALUES (3, 'personal', '2025-04-10', '2025-04-15', 'Pending'),(4,'emergency','2024-09-30','2024-10-05','Rejected'),(5,'maternity','2025-01-20','2025-02-15','approved');




CREATE TABLE payments (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    employee_id INT,
    payment_date DATE,
    amount DECIMAL(10, 2),
    payment_method VARCHAR(50),
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
);
select * from payments;
INSERT INTO payments (employee_id, payment_date, amount, payment_method)
VALUES (1, '2025-02-28', 5400.00, 'Bank Transfer');
insert into payments(employee_id, payment_date, amount, payment_method)values(2, '2025-01-25', 10500.00, 'cheque'),(3, '2025-01-31', 2050.00, 'paytm'),(4, '2025-02-10', 8950.00, 'cash payment'),(5,'2025-02-18',6190.00,'direct deposit');



CREATE TABLE taxes (
    tax_id INT PRIMARY KEY AUTO_INCREMENT,
    employee_id INT,
    tax_amount DECIMAL(10, 2),
    tax_date DATE,
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
);
select * from taxes;

INSERT INTO taxes (employee_id, tax_amount, tax_date)
VALUES (1, 400.00, '2025-02-28');
INSERT INTO taxes (employee_id, tax_amount, tax_date)
VALUES (2, 500.00, '2025-01-25'),(3,50.00,'2025-01-31'),(4,950.00, '2025-02-10'),(5, 190.00, '2025-02-18');


SELECT e.first_name, e.last_name, s.base_salary, s.bonus, s.deductions, s.total_salary, t.tax_amount
FROM employees e
JOIN salaries s ON e.employee_id = s.employee_id
LEFT JOIN taxes t ON e.employee_id = t.employee_id
WHERE e.employee_id = 1;

SELECT e.first_name, e.last_name, s.base_salary, s.bonus, s.deductions, s.total_salary, t.tax_amount
FROM employees e
JOIN salaries s ON e.employee_id = s.employee_id
LEFT JOIN taxes t ON e.employee_id = t.employee_id
WHERE e.employee_id between 1 and 5;


INSERT INTO employees (first_name, last_name, email, phone, hire_date, role_id, department_id)
VALUES ('divya', 'sri', 'divya199@gmail.com', '666-9834', '2024-08-18', 6, 6);

select * from employees where employee_id = 3;
update employees set phone='555-9999',status='inactive' where employee_id=1;
update employees set phone='999-8674',status='inactive' where employee_id=2;
update employees set hire_date='2022-02-25' where employee_id=3;
SELECT * FROM employees WHERE employee_id = 6;
DELETE FROM employees WHERE employee_id = 1;
delete from employees where employee_id=2; 
select * from employees;

INSERT INTO leaves (employee_id, leave_type, start_date, end_date, status)
VALUES (5,'maternity','2025-01-20','2025-02-15','approved');

UPDATE leaves
SET status = 'Approved'
WHERE leave_id = 1;

update leaves
set status = 'rejected'
where leave_id = 4;

select * from leaves where employee_id=2;
select * from leaves;


SELECT e.first_name, e.last_name, s.base_salary, s.bonus, s.deductions, s.total_salary
FROM employees e
JOIN salaries s ON e.employee_id = s.employee_id
WHERE e.employee_id = 1;

SELECT e.first_name, e.last_name, s.base_salary, s.bonus, s.deductions, s.total_salary
FROM employees e
JOIN salaries s ON e.employee_id = s.employee_id
WHERE e.employee_id between 1 and 3;


INSERT INTO taxes (employee_id, tax_amount, tax_date)
VALUES (6, 300.00, '2025-03-31');

SELECT e.first_name, e.last_name, t.tax_amount, t.tax_date
FROM employees e
JOIN taxes t ON e.employee_id = t.employee_id
WHERE e.employee_id = 4;

select * from taxes;

SELECT e.first_name, e.last_name, s.base_salary, s.bonus, s.deductions, s.total_salary, t.tax_amount,
       (s.total_salary - IFNULL(t.tax_amount, 0)) AS net_salary
FROM employees e
JOIN salaries s ON e.employee_id = s.employee_id
LEFT JOIN taxes t ON e.employee_id = t.employee_id
WHERE e.employee_id = 1;

SELECT e.first_name, e.last_name, s.base_salary, s.bonus, s.deductions, s.total_salary, t.tax_amount,
       (s.total_salary - IFNULL(t.tax_amount, 0)) AS net_salary
FROM employees e
JOIN salaries s ON e.employee_id = s.employee_id
LEFT JOIN taxes t ON e.employee_id = t.employee_id
WHERE e.employee_id between 1 and 5;


SELECT e.employee_id, e.first_name, e.last_name, d.department_name, s.base_salary, s.bonus, s.deductions, s.total_salary
FROM employees e
JOIN salaries s ON e.employee_id = s.employee_id
JOIN departments d ON e.department_id = d.department_id;

SELECT e.employee_id, e.first_name, e.last_name, SUM(t.tax_amount) AS total_tax
FROM employees e
JOIN taxes t ON e.employee_id = t.employee_id
GROUP BY e.employee_id;


SELECT e.employee_id, e.first_name, e.last_name, COUNT(l.leave_id) AS total_leaves
FROM employees e
JOIN leaves l ON e.employee_id = l.employee_id
WHERE l.status = 'Approved'
GROUP BY e.employee_id;

SELECT e.employee_id, e.first_name, e.last_name, COUNT(l.leave_id) AS total_leaves
FROM employees e
JOIN leaves l ON e.employee_id = l.employee_id
WHERE l.status = 'Rejected'
GROUP BY e.employee_id;


SELECT e.employee_id, e.first_name, e.last_name, COUNT(l.leave_id) AS total_leaves
FROM employees e
JOIN leaves l ON e.employee_id = l.employee_id
WHERE l.status = 'pending'
GROUP BY e.employee_id;
