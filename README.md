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
* CREATE TABLE
* CREATE TABLE
* CREATE TABLE
* CREATE TABLE



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
* INSERT 0 6
* INSERT 0 5
* INSERT 0 7
* INSERT 0 17



3.	Используя оператор SELECT создать запрос для вывода всех строк каждой таблицы. 
```sql
SELECT * FROM employer;
SELECT * FROM hire_office;
SELECT * FROM profession;
SELECT * FROM employment_contract;
```


|  id_empl |          name          |  location   | benefit_percentage
| ---------|------------------------|-------------|--------------------
|        1 | Horns and hoofs        | Primorsk    |               0.00
|        2 | GAZ                    | N. Novgorod |              20.00
|        3 | Stankostroitelny Zavod | Odessa      |               2.00
|        4 | KINAP                  | Odessa      |               2.00
|        5 | KRAZ                   | Kremenchug  |               2.00
|        6 | p/y 12687-u            | Saransk     |              10.00

(6 rows)


|  id_office | number_office | office_address | service_fee_percentage
| -----------|---------------|----------------|------------------------
|          1 | N5            | Novgorod       |                   4.00
|          2 | N4            | Moscow         |                   3.00
|          3 | N12           | Kiev           |                  11.00
|          4 | N6            | Novgorod       |                   3.00
|          5 | N8            | Odessa         |                   9.00

(5 rows)


|  id_prof |   name_prof    | cost_rub | number_of_jobs | plase_of_prev_work
| ---------|----------------|----------|----------------|--------------------
|        1 | roofer         |    10000 |              7 | Saransk
|        2 | Locksmith      |    15000 |              6 | Kremenchug
|        3 | Accountant     |    25000 |             10 | Moscow
|        4 | Milling cutter |    20000 |              7 | Odessa
|        5 | Programmer     |    40000 |              8 | Kiev
|        6 | Driver         |    25000 |              3 | Primorsk
|        7 | Grinder        |    17000 |              5 | Odessa

(7 rows)


|  contract_number | hiring_date | employer_id | hire_office_id | profession_id | quantity | payment_rub
| -----------------|-------------|-------------|----------------|---------------|----------|-------------
|              127 | January     |           3 |              4 |             6 |        1 |       25000
|              128 | February    |           6 |              2 |             1 |        2 |       20000
|              129 | March       |           1 |              3 |             4 |        1 |       20000
|              130 | April       |           2 |              1 |             7 |        2 |       34000
|              131 | April       |           4 |              4 |             6 |        1 |       25000
|              132 | April       |           6 |              4 |             1 |        1 |       10000
|              133 | May         |           5 |              2 |             5 |        3 |      120000
|              134 | May         |           3 |              3 |             2 |        3 |       45000
|              135 | May         |           3 |              4 |             1 |        1 |       10000
|              136 | June        |           4 |              1 |             3 |        4 |      100000
|              137 | June        |           1 |              2 |             2 |        3 |       45000
|              138 | June        |           1 |              3 |             7 |        1 |       17000
|              139 | June        |           5 |              4 |             1 |        2 |       20000
|              140 | June        |           3 |              5 |             2 |        1 |       15000
|              141 | June        |           3 |              5 |             2 |        1 |       15000
|              142 | July        |           4 |              2 |             6 |        1 |       25000
|              143 | September   |           2 |              2 |             7 |        2 |       34000

(17 rows)


4.	Создать запросы для вывода:
```sql
--a)    названий всех нанимателей, вместе с местом их расположения;
SELECT name, location 
FROM employer;
--b)    всех номеров бюро найма;
SELECT number_office FROM hire_office;
--c)    всех различных предоставленных профессий вместе с их количеством.
SELECT name_prof, number_of_jobs 
FROM profession;
```
|          name          |  location
|------------------------|-------------
| Horns and hoofs        | Primorsk
| GAZ                    | N. Novgorod
| Stankostroitelny Zavod | Odessa
| KINAP                  | Odessa
| KRAZ                   | Kremenchug
| p/y 12687-u            | Saransk

(6 rows)


| number_office
|---------------
| N5
| N4
| N12
| N6
| N8

(5 rows)


|   name_prof    | number_of_jobs
|----------------|----------------
| roofer         |              7
| Locksmith      |              6
| Accountant     |             10
| Milling cutter |              7
| Programmer     |              8
| Driver         |              3
| Grinder        |              5

(7 rows)

5.	Создать запросы для получения инорфмации о:
```sql
--a)    названии и месте расположения нанимателей, имеющих льготу менее 8%;
SELECT name, location 
FROM employer 
WHERE benefit_percentage < 8;
--b)    профессиях, имеющих стоиомость найма более 10000руб. 
--для которых Москва не была местом прежней работы;
SELECT name_prof, cost_rub, plase_of_prev_work 
FROM profession 
WHERE cost_rub > 10000 AND plase_of_prev_work != 'Moscow';
--c)    Названиях  и расположении нанимателей, 
--в названии которых присутствует слово “завод” и имеющих льготы. 
--Вывод результатов организовать по названию и убыванию льгот.
SELECT name, location 
FROM employer 
WHERE (name LIKE '%Zavod%') AND benefit_percentage >0;
```
|          name          |  location
|------------------------|------------
| Horns and hoofs        | Primorsk
| Stankostroitelny Zavod | Odessa
| KINAP                  | Odessa
| KRAZ                   | Kremenchug

(4 rows)


|   name_prof    | cost_rub | plase_of_prev_work
|----------------|----------|--------------------
| Locksmith      |    15000 | Kremenchug
| Milling cutter |    20000 | Odessa
| Programmer     |    40000 | Kiev
| Driver         |    25000 | Primorsk
| Grinder        |    17000 | Odessa

(5 rows)


|         name          | location
|-----------------------|----------
|Stankostroitelny Zavod | Odessa

(1 row)

6.	Для каждого трудового договора вывести следующие данные:
```sql
--a)    название нанимателя, дату, название бюро найма;
SELECT employment_contract.contract_number,employment_contract.hiring_date, 
	employer.name, hire_office.number_office
FROM employment_contract, employer, hire_office
WHERE employment_contract.employer_id = employer.id_empl AND 
	employment_contract.hire_office_id = hire_office.id_office;
```
| contract_number | hiring_date |          name          | number_office
|-----------------|-------------|------------------------|---------------
|             127 | January     | Stankostroitelny Zavod | N6
|             128 | February    | p/y 12687-u            | N4
|             129 | March       | Horns and hoofs        | N12
|             130 | April       | GAZ                    | N5
|             131 | April       | KINAP                  | N6
|             132 | April       | p/y 12687-u            | N6
|             133 | May         | KRAZ                   | N4
|             134 | May         | Stankostroitelny Zavod | N12
|             135 | May         | Stankostroitelny Zavod | N6
|             136 | June        | KINAP                  | N5
|             137 | June        | Horns and hoofs        | N4
|             138 | June        | Horns and hoofs        | N12
|             139 | June        | KRAZ                   | N6
|             140 | June        | Stankostroitelny Zavod | N8
|             141 | June        | Stankostroitelny Zavod | N8
|             142 | July        | KINAP                  | N4
|             143 | September   | GAZ                    | N4

(17 rows)


6.	Для каждого трудового договора вывести следующие данные:
```sql
--b)    дату, название бюро найма, название и количество заказанных профессий.
SELECT employment_contract.hiring_date,  hire_office.number_office, 
	profession.name_prof, employment_contract.quantity
FROM employment_contract, hire_office, profession
WHERE employment_contract.profession_id = profession.id_prof AND 
	employment_contract.hire_office_id = hire_office.id_office;
```
| hiring_date | number_office |   name_prof    | quantity
|-------------|---------------|----------------|----------
| January     | N6            | Driver         |        1
| February    | N4            | roofer         |        2
| March       | N12           | Milling cutter |        1
| April       | N5            | Grinder        |        2
| April       | N6            | Driver         |        1
| April       | N6            | roofer         |        1
| May         | N4            | Programmer     |        3
| May         | N12           | Locksmith      |        3
| May         | N6            | roofer         |        1
| June        | N5            | Accountant     |        4
| June        | N4            | Locksmith      |        3
| June        | N12           | Grinder        |        1
| June        | N6            | roofer         |        2
| June        | N8            | Locksmith      |        1
| June        | N8            | Locksmith      |        1
| July        | N4            | Driver         |        1
| September   | N4            | Grinder        |        2

(17 rows)


7.	Определить:
```sql
--a)    дату, номер договора, название предприятий 
--заказавших автоводителей или сделавших заказ на общую сумму не менее 14000руб.
SELECT employment_contract.contract_number, employment_contract.hiring_date, employer.name
FROM employment_contract, employer
WHERE employment_contract.employer_id = employer.id_empl AND 
	(employment_contract.profession_id = 006 OR 
	employment_contract.payment_rub >= 14000);
```
| contract_number | hiring_date |          name
|-----------------|-------------|------------------------
|             127 | January     | Stankostroitelny Zavod
|             128 | February    | p/y 12687-u
|             129 | March       | Horns and hoofs
|             130 | April       | GAZ
|             131 | April       | KINAP
|             133 | May         | KRAZ
|             134 | May         | Stankostroitelny Zavod
|             136 | June        | KINAP
|             137 | June        | Horns and hoofs
|             138 | June        | Horns and hoofs
|             139 | June        | KRAZ
|             140 | June        | Stankostroitelny Zavod
|             141 | June        | Stankostroitelny Zavod
|             142 | July        | KINAP
|             143 | September   | GAZ

(15 rows)


7.	Определить:
```sql
--b)	номера тех бюро найма вместе с адресами, 
--которые предоставляли услуги организациям со льготами менее 7% после февраля месяца;
SELECT DISTINCT hire_office.number_office, hire_office.office_address
FROM hire_office, employment_contract, employer
WHERE employment_contract.hire_office_id = hire_office.id_office AND 
	employment_contract.employer_id = employer.id_empl AND
	employer.benefit_percentage < 7 AND 
	(employment_contract.hiring_date NOT IN ('January', 'February'));
```
| number_office | office_address
|---------------|----------------
| N8            | Odessa
| N6            | Novgorod
| N12           | Kiev
| N4            | Moscow
| N5            | Novgorod

(5 rows)


7.	Определить:
```sql
--c)	предприятия, расположенные в любом городе, кроме Москвы, 
--которые пользовались услугами бюро найма с платой за услуги более 3%;
SELECT DISTINCT employer.name
FROM employer, hire_office, employment_contract
WHERE employment_contract.hire_office_id = hire_office.id_office AND 
	employment_contract.employer_id = employer.id_empl AND 
	hire_office.service_fee_percentage > 3 AND employer.location != 'Moscow';
```
|          name
|------------------------
| Stankostroitelny Zavod
| Horns and hoofs
| GAZ
| KINAP

(4 rows)


7.	Определить:
```sql
--d)	данные по заказу специальностей, у которых не изменился адрес работы. 
--Включить данные о стоимости и отсортировать по возрастанию. 
SELECT name_prof, employer.name, hiring_date, employment_contract.payment_rub, location
FROM employment_contract, employer, profession
WHERE employment_contract.employer_id = employer.id_empl AND 
	employment_contract.profession_id = profession.id_prof AND
	employer.location = profession.plase_of_prev_work
ORDER BY payment_rub;
```
| name_prof |    name     | hiring_date | payment_rub | location
|-----------|-------------|-------------|-------------|----------
| roofer    | p/y 12687-u | April       |       10000 | Saransk
| roofer    | p/y 12687-u | February    |       20000 | Saransk

(2 rows)


```sql
```

```sql
```
