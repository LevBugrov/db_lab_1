1. Дана схема базы данных в виде следующих отношений.  С помощью операторов SQL создать логическую структуру соответствующих таблиц для хранения в СУБД, используя известные средства поддержания целостности (NOT NULL, UNIQUE, и т.д.). Обосновать выбор типов данных и используемые средства поддержания целостности. При выборе подходящих типов данных использовать информацию о конкретных значениях полей БД (см. прил.1)

```sql
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
```
2.	Ввести в ранее созданные таблицы конкретные данные (см. прил. 1). Использовать скрипт-файл из операторов INSERT или вспомогательную утилиту .

```sql
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
```
