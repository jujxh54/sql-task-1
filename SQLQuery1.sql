create database co
-- 1. DEPARTMENT TABLE (no dependencies)
CREATE TABLE DEPARTMENT (
    DNUM INT PRIMARY KEY,
    DName VARCHAR(50) UNIQUE NOT NULL,
    MgrSSN INT UNIQUE NOT NULL,
    MgrStartDate DATE NOT NULL
);

-- 2. EMPLOYEE TABLE (now DEPARTMENT exists)
CREATE TABLE EMPLOYEE (
    SSN INT PRIMARY KEY,
    Fname VARCHAR(50) NOT NULL,
    Lname VARCHAR(50) NOT NULL,
    BirthDate DATE NOT NULL,
    Gender CHAR(1) CHECK (Gender IN ('M','F')),
    DNO INT NOT NULL,
    SuperSSN INT NULL,
    FOREIGN KEY (DNO) REFERENCES DEPARTMENT(DNUM),
    FOREIGN KEY (SuperSSN) REFERENCES EMPLOYEE(SSN)
);

-- 3. DEPT_LOCATION TABLE
CREATE TABLE DEPT_LOCATION (
    DNUM INT,
    Location VARCHAR(50),
    PRIMARY KEY (DNUM, Location),
    FOREIGN KEY (DNUM) REFERENCES DEPARTMENT(DNUM)
);

-- 4. PROJECT TABLE
CREATE TABLE PROJECT (
    PNumber INT PRIMARY KEY,
    PName VARCHAR(50) NOT NULL,
    Location VARCHAR(50),
    DNUM INT NOT NULL,
    FOREIGN KEY (DNUM) REFERENCES DEPARTMENT(DNUM)
);

-- 5. WORKS_ON TABLE
CREATE TABLE WORKS_ON (
    SSN INT,
    PNumber INT,
    Hours DECIMAL(4,1) CHECK (Hours >= 0),
    PRIMARY KEY (SSN, PNumber),
    FOREIGN KEY (SSN) REFERENCES EMPLOYEE(SSN),
    FOREIGN KEY (PNumber) REFERENCES PROJECT(PNumber)
);

-- 6. DEPENDENT TABLE
CREATE TABLE DEPENDENT (
    SSN INT,
    DependentName VARCHAR(50),
    Gender CHAR(1) CHECK (Gender IN ('M', 'F')),
    BirthDate DATE,
    PRIMARY KEY (SSN, DependentName),
    FOREIGN KEY (SSN) REFERENCES EMPLOYEE(SSN) ON DELETE CASCADE
);
-- 1. Insert Departments FIRST
INSERT INTO DEPARTMENT VALUES 
(1, 'HR', 1, '2020-01-01'),
(2, 'IT', 3, '2021-06-01'),
(3, 'Finance', 5, '2019-03-10');

-- 2. Insert Employees NEXT (MgrSSNs from above must match SSNs here)
INSERT INTO EMPLOYEE VALUES 
(1, 'Ali', 'Hassan', '1990-01-01', 'M', 1, NULL),
(2, 'Sara', 'Omar', '1992-03-10', 'F', 1, 1),
(3, 'Mona', 'Nabil', '1988-05-15', 'F', 2, 1),
(4, 'Ahmed', 'Sami', '1995-07-20', 'M', 2, 2),
(5, 'Tarek', 'Khaled', '1985-11-25', 'M', 3, 3);

-- 3. Insert Projects
INSERT INTO PROJECT VALUES 
(101, 'Payroll System', 'Cairo', 1),
(102, 'ERP Development', 'Alexandria', 2),
(103, 'Audit App', 'Giza', 3);

-- 4. Insert Dept Locations
INSERT INTO DEPT_LOCATION VALUES 
(1, 'Cairo'),
(2, 'Alexandria'),
(3, 'Giza');

-- 5. Insert Works_On (now EMPLOYEE and PROJECT exist)
INSERT INTO WORKS_ON VALUES
(1, 101, 15.5),
(2, 101, 20),
(3, 102, 25),
(4, 102, 18),
(5, 103, 22);

-- 6. Insert Dependents (employees must already exist)
INSERT INTO DEPENDENT VALUES 
(2, 'Nour', 'F', '2015-08-01'),
(3, 'Omar', 'M', '2010-03-14');

-- UPDATE EMPLOYEE'S DEPARTMENT
UPDATE EMPLOYEE
SET DNO = 3
WHERE SSN = 2;

-- DELETE A DEPENDENT
DELETE FROM DEPENDENT
WHERE SSN = 2 AND DependentName = 'Nour';

-- SELECT EMPLOYEES IN SPECIFIC DEPARTMENT (e.g., IT - DNUM = 2)
SELECT * FROM EMPLOYEE
WHERE DNO = 2;

-- SELECT EMPLOYEES WITH PROJECT ASSIGNMENTS
SELECT E.Fname, E.Lname, P.PName, W.Hours
FROM EMPLOYEE E
JOIN WORKS_ON W ON E.SSN = W.SSN
JOIN PROJECT P ON W.PNumber = P.PNumber;


