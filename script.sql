--1
CREATE TABLE employer
(
id_empl INTEGER PRIMARY KEY,
name TEXT NOT NULL,
location TEXT NOT NULL,
benefit_percentage numeric(5,2) NOT NULL
);

CREATE TABLE hire_office
(
id_office INTEGER PRIMARY KEY,
number_office TEXT NOT NULL,
office_address TEXT NOT NULL,
service_fee_percentage numeric(5,2) NOT NULL
);

CREATE TABLE profession
(
id_prof INTEGER PRIMARY KEY,
name_prof TEXT NOT NULL,
cost_rub INTEGER NOT NULL,
number_of_jobs INTEGER NOT NULL,
plase_of_prev_work TEXT
);

CREATE TABLE employment_contract
(
contract_number INTEGER NOT NULL,
hiring_date TEXT NOT NULL,

employer_id INTEGER REFERENCES employer (id_empl),
hire_office_id INTEGER REFERENCES hire_office (id_office),
profession_id INTEGER REFERENCES profession (id_prof),

quantity INTEGER NOT NULL,
payment_rub INTEGER NOT NULL
);
 
 --2
INSERT INTO employer
(id_empl ,name, location, benefit_percentage)
VALUES
(001, 'Horns and hoofs', 'Primorsk', 0),
(002, 'GAZ', 'N. Novgorod', 20),
(003, 'Stankostroitelny Zavod', 'Odessa', 2),
(004, 'KINAP', 'Odessa', 2),
(005, 'KRAZ', 'Kremenchug', 2),
(006, 'p/y 12687-u', 'Saransk', 10);

INSERT INTO hire_office
(id_office, number_office, office_address, service_fee_percentage)
VALUES
(001, 'N5', 'Novgorod', 4),
(002, 'N4', 'Moscow', 3),
(003, 'N12', 'Kiev', 11),
(004, 'N6', 'Novgorod', 3),
(005, 'N8', 'Odessa', 9);

INSERT INTO profession
(id_prof, name_prof, cost_rub, number_of_jobs, plase_of_prev_work)
VALUES
 (001, 'roofer', 10000, 7, 'Saransk'),
 (002, 'Locksmith', 15000, 6, 'Kremenchug'),
 (003, 'Accountant', 25000, 10, 'Moscow'),
 (004, 'Milling cutter', 20000, 7, 'Odessa'),
 (005, 'Programmer', 40000, 8, 'Kiev'),
 (006, 'Driver', 25000, 3, 'Primorsk'),
 (007, 'Grinder', 17000, 5, 'Odessa');

INSERT INTO employment_contract
(contract_number, hiring_date, employer_id, hire_office_id, profession_id, quantity, payment_rub)
VALUES
(00127, 'January', 003, 004, 006, 1, 25000),
(00128, 'February', 006, 002, 001, 2, 20000),
(00129, 'March', 001, 003, 004, 1, 20000),
(00130, 'April', 002, 001, 007, 2, 34000),
(00131, 'April', 004, 004, 006, 1, 25000),
(00132, 'April', 006, 004, 001, 1, 10000),
(00133, 'May', 005, 002, 005, 3, 120000),
(00134, 'May', 003, 003, 002, 3, 45000),
(00135, 'May', 003, 004, 001, 1, 10000),
(00136, 'June', 004, 001, 003, 4, 100000),
(00137, 'June', 001, 002, 002, 3, 45000),
(00138, 'June', 001, 003, 007, 1, 17000),
(00139, 'June', 005, 004, 001, 2, 20000),
(00140, 'June', 003, 005, 002, 1, 15000),
(00141, 'June', 003, 005, 002, 1, 15000),
(00142, 'July', 004, 002, 006, 1, 25000),
(00143, 'September', 002, 002, 007, 2, 34000);


--3
SELECT * FROM employer;
SELECT * FROM hire_office;
SELECT * FROM profession;
SELECT * FROM employment_contract;

--4
SELECT name, location FROM employer;
SELECT id_office FROM hire_office;
SELECT name_prof, number_of_jobs FROM profession;

--5
SELECT name, location FROM employer WHERE benefit_percentage < 8;
SELECT name_prof, cost_rub, plase_of_prev_work FROM profession WHERE cost_rub > 10000 AND plase_of_prev_work != 'Moscow';
SELECT name, location FROM employer WHERE (name LIKE '%Zavod%') AND benefit_percentage >0;


--6
SELECT employment_contract.contract_number,employment_contract.hiring_date, employer.name, hire_office.number_office
FROM employment_contract, employer, hire_office
WHERE employment_contract.employer_id = employer.id_empl AND employment_contract.hire_office_id = hire_office.id_office;

SELECT employment_contract.hiring_date,  hire_office.number_office, profession.name_prof, employment_contract.quantity
FROM employment_contract, hire_office, profession
WHERE employment_contract.profession_id = profession.id_prof AND employment_contract.hire_office_id = hire_office.id_office;

--7
SELECT employment_contract.contract_number, employment_contract.hiring_date, employer.name
FROM employment_contract, employer
WHERE employment_contract.employer_id = employer.id_empl AND (employment_contract.profession_id = 006 OR employment_contract.payment_rub >= 14000);

SELECT DISTINCT hire_office.number_office, hire_office.office_address
FROM hire_office, employment_contract, employer
WHERE employment_contract.hire_office_id = hire_office.id_office AND employment_contract.employer_id = employer.id_empl AND
	employer.benefit_percentage < 7 AND (employment_contract.hiring_date NOT IN ('January', 'February'));

SELECT DISTINCT employer.name
FROM employer, hire_office, employment_contract
WHERE employment_contract.hire_office_id = hire_office.id_office AND employment_contract.employer_id = employer.id_empl AND 
	hire_office.service_fee_percentage > 3 AND employer.location != 'Moscow';

SELECT name_prof, employer.name, hiring_date, employment_contract.payment_rub, location
FROM employment_contract, employer, profession
WHERE employment_contract.employer_id = employer.id_empl AND 
	employment_contract.profession_id = profession.id_prof AND
	employer.location = profession.plase_of_prev_work
ORDER BY payment_rub;

--8
UPDATE employment_contract SET payment_rub = payment_rub - payment_rub / 100*benefit_percentage FROM employer
WHERE employer_id = id_empl;

SELECT * FROM employment_contract;

--9
ALTER TABLE employment_contract ADD COLUMN service_fee  INTEGER;
UPDATE employment_contract SET service_fee = service_fee_percentage * payment_rub/100 FROM hire_office 
WHERE hire_office_id = id_office;

SELECT * FROM employment_contract;

--10
SELECT DISTINCT id_office, number_office
FROM employment_contract
JOIN employer ON id_empl = employer_id
JOIN hire_office ON id_office = hire_office_id
WHERE location IN ('N. Novgorod');

SELECT id_prof, name_prof
FROM profession
WHERE id_prof NOT IN(  
SELECT DISTINCT id_prof--, name_prof, contract_number, employer_id, benefit_percentage
FROM profession
JOIN employment_contract ON id_prof = profession_id
JOIN employer ON id_empl = employer_id
WHERE benefit_percentage < 10
--ORDER BY contract_number;
);

SELECT contract_number, hiring_date, employer.name
FROM employment_contract, employer
WHERE employment_contract.employer_id = employer.id_empl
	AND (profession_id IN (006) 
	OR payment_rub >= 14000);
	
SELECT DISTINCT hire_office.number_office, hire_office.office_address
FROM hire_office, employment_contract, employer
WHERE employment_contract.hire_office_id = hire_office.id_office AND employment_contract.employer_id = employer.id_empl AND
	employer.benefit_percentage < 7 AND (employment_contract.hiring_date NOT IN ('January', 'February'));
	
	
--11	
	
SELECT profession.name_prof, number_of_jobs
FROM employment_contract 
JOIN profession ON id_prof = profession_id
WHERE number_of_jobs >= ALL (
SELECT number_of_jobs 
FROM profession
);
	
SELECT employer.name
FROM employer
JOIN employment_contract ON id_empl = employer_id
WHERE payment_rub >= ALL (
SELECT payment_rub
FROM employment_contract
JOIN employer ON id_empl = employer_id
JOIN hire_office ON id_office = hire_office_id
WHERE employer.location != hire_office.office_address
);
	

SELECT id_empl, name
FROM employer
WHERE id_empl = ANY(
	SELECT employer_id 
	from employment_contract 
	WHERE hire_office_id = ANY(
		SELECT id_office 
		FROM hire_office 
		WHERE service_fee_percentage>3)
) 
AND location != 'Moscow';

	
SELECT DISTINCT employer.name, cost_rub
FROM employment_contract
JOIN employer ON id_empl = employer_id
JOIN hire_office ON id_office = hire_office_id
JOIN profession ON id_prof = profession_id
WHERE location = 'N. Novgorod' AND cost_rub >= ALL(
SELECT cost_rub
FROM employer
JOIN employment_contract ON id_empl = employer_id
JOIN profession ON id_prof = profession_id
WHERE location = 'N. Novgorod'
);

--12

SELECT location 
FROM employer
UNION SELECT office_address FROM hire_office;

--13
SELECT DISTINCT profession_id FROM employment_contract as contract
WHERE EXISTS (SELECT * FROM employment_contract WHERE contract.profession_id NOT IN 
(SELECT profession_id FROM employment_contract
WHERE employer_id = 1 ));

SELECT DISTINCT hire_office_id FROM employment_contract as contract
WHERE EXISTS (SELECT * FROM employment_contract WHERE contract.payment_rub>15000);

SELECT id_office 
FROM hire_office AS ra
WHERE NOT EXISTS(
	SELECT * 
	FROM employment_contract
	WHERE ra.id_office IN (
		SELECT hire_office_id 
		FROM employment_contract
		JOIN employer ON id_empl = employer_id
		JOIN profession ON id_prof = profession_id 
		WHERE location = plase_of_prev_work));

SELECT DISTINCT employer_id FROM employment_contract as contract
WHERE EXISTS (
SELECT * FROM employment_contract 
WHERE contract.payment_rub>10000 AND contract.hiring_date = 'April');
--14
SELECT avg(payment_rub)
FROM
(
SELECT hire_office_id, payment_rub
FROM employment_contract
JOIN employer ON id_empl = employer_id
WHERE location = 'Odessa'
) as tab;



SELECT sum(payment_rub)
FROM employment_contract;

SELECT count(DISTINCT profession_id)
FROM employment_contract
JOIN employer on id_empl = employer_id
WHERE location = 'N. Novgorod';

SELECT avg(quantity)
FROM profession
JOIN employment_contract ON id_prof = profession_id
WHERE cost_rub > 20000;

--15
SELECT number_office, employer.name, SUM(payment_rub)
FROM employment_contract
JOIN employer on id_empl = employer_id
JOIN hire_office on hire_office_id = id_office
GROUP BY number_office, employer.name;


SELECT * FROM
(SELECT number_office, COUNT(contract_number) AS count_contract
FROM employment_contract
JOIN hire_office on hire_office_id = id_office
GROUP BY number_office
) AS tab
WHERE count_contract >2;

SELECT location, COUNT(id_empl)
FROM employer
GROUP BY location;

SELECT * 
FROM
(SELECT number_office, hiring_date, SUM(payment_rub) AS sum_pay
FROM employment_contract
JOIN hire_office on hire_office_id = id_office
GROUP BY number_office, hiring_date) AS tab
WHERE sum_pay > 20000;









