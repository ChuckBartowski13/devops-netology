# Домашнее задание к занятию "4. PostgreSQL"

## Задача 1

Используя docker поднимите инстанс PostgreSQL (версию 13). Данные БД сохраните в volume.

Подключитесь к БД PostgreSQL используя `psql`.

Воспользуйтесь командой `\?` для вывода подсказки по имеющимся в `psql` управляющим командам.

**Найдите и приведите** управляющие команды для:
- вывода списка БД
- подключения к БД
- вывода списка таблиц
- вывода описания содержимого таблиц
- выхода из psql

##Ответ
```
root@test-netology:/home/ret/Desktop/Netology/postgres_postgres# cat docker-compose.yaml 
version: "3.3"

services:
  postgesql:
    image: postgres:13
    container_name: postgresql_postgres
    environment:
      POSTGRES_USER: postgres
      POSTGRES_PASSWORD: postgres
    volumes:
      - ./data:/var/lib/postgresql/data/
      - ./backup:/var/backups/pg_backup
    restart: always
root@test-netology:/home/ret/Desktop/Netology/postgres_postgres# docker-compose -f docker-compose.yaml up -d
Creating network "postgres_postgres_default" with the default driver
Pulling postgesql (postgres:13)...
13: Pulling from library/postgres
bb263680fed1: Already exists
75a54e59e691: Already exists
3ce7f8df2b36: Already exists
f30287ef02b9: Already exists
dc1f0e9024d8: Already exists
7f0a68628bce: Already exists
32b11818cae3: Already exists
48111fe612c1: Already exists
53d17e3561d4: Pull complete
4574cb861f6a: Pull complete
0f24d68ef30d: Pull complete
54bf55f1b694: Pull complete
ed4b4d1b8ce2: Pull complete
Digest: sha256:0876afe95f304506a42c6fcd5b3b272340c394389086dcd33fe4c1ac999ff118
Status: Downloaded newer image for postgres:13
Creating postgresql_postgres ... done
root@test-netology:/home/ret/Desktop/Netology/postgres_postgres# docker exec -it postgresql_postgres /bin/bash
root@b4049cfdd951:/# psql -U postgres
psql (13.10 (Debian 13.10-1.pgdg110+1))
Type "help" for help.

postgres=# \?
General
  \copyright             show PostgreSQL usage and distribution terms
  \crosstabview [COLUMNS] execute query and display results in crosstab
  \errverbose            show most recent error message at maximum verbosity
  \g [(OPTIONS)] [FILE]  execute query (and send results to file or |pipe);
                         \g with no arguments is equivalent to a semicolon
  \gdesc                 describe result of query, without executing it
  \gexec                 execute query, then execute each value in its result
  \gset [PREFIX]         execute query and store results in psql variables
  \gx [(OPTIONS)] [FILE] as \g, but forces expanded output mode
  \q                     quit psql
  \watch [SEC]           execute query every SEC seconds

Help
  \? [commands]          show help on backslash commands
  \? options             show help on psql command-line options
  \? variables           show help on special variables
  \h [NAME]              help on syntax of SQL commands, * for all commands

Query Buffer
  \e [FILE] [LINE]       edit the query buffer (or file) with external editor
  \ef [FUNCNAME [LINE]]  edit function definition with external editor
  \ev [VIEWNAME [LINE]]  edit view definition with external editor
  \p                     show the contents of the query buffer
  \r                     reset (clear) the query buffer
  \s [FILE]              display history or save it to file
  \w FILE                write query buffer to file

Input/Output
  \copy ...              perform SQL COPY with data stream to the client host
  \echo [-n] [STRING]    write string to standard output (-n for no newline)
  \i FILE                execute commands from file
  \ir FILE               as \i, but relative to location of current script
  \o [FILE]              send all query results to file or |pipe
  \qecho [-n] [STRING]   write string to \o output stream (-n for no newline)
  \warn [-n] [STRING]    write string to standard error (-n for no newline)

Conditional
  \if EXPR               begin conditional block
  \elif EXPR             alternative within current conditional block
--More--
```
Список баз
```
postgres=# \l
                                 List of databases
   Name    |  Owner   | Encoding |  Collate   |   Ctype    |   Access privileges   
-----------+----------+----------+------------+------------+-----------------------
 postgres  | postgres | UTF8     | en_US.utf8 | en_US.utf8 | 
 template0 | postgres | UTF8     | en_US.utf8 | en_US.utf8 | =c/postgres          +
           |          |          |            |            | postgres=CTc/postgres
 template1 | postgres | UTF8     | en_US.utf8 | en_US.utf8 | =c/postgres          +
           |          |          |            |            | postgres=CTc/postgres
(3 rows)
```
Подключение к базе 
```
postgres=# \c
You are now connected to database "postgres" as user "postgres".
```
Вывод списка таблиц
```
\dt[S+] [PATTERN]      list tables
```
Вывода описания содержимого таблиц
```
\d[S+]  NAME           describe table, view, sequence, or index
```
Выход
```
  \q                     quit psql
```
## Задача 2

Используя `psql` создайте БД `test_database`.

Изучите [бэкап БД](https://github.com/netology-code/virt-homeworks/tree/virt-11/06-db-04-postgresql/test_data).

Восстановите бэкап БД в `test_database`.

Перейдите в управляющую консоль `psql` внутри контейнера.

Подключитесь к восстановленной БД и проведите операцию ANALYZE для сбора статистики по таблице.

Используя таблицу [pg_stats](https://postgrespro.ru/docs/postgresql/12/view-pg-stats), найдите столбец таблицы `orders` 
с наибольшим средним значением размера элементов в байтах.

**Приведите в ответе** команду, которую вы использовали для вычисления и полученный результат.

##Ответ
```
postgres=# CREATE DATABASE test_database;
CREATE DATABASE
postgres=# exit
exit
root@b4049cfdd951:/# psql -U postgres -W test_database < /var/backups/pg_backup/test_dump.sql
Password: 
SET
SET
SET
SET
SET
 set_config 
------------
 
(1 row)

SET
SET
SET
SET
SET
SET
CREATE TABLE
ALTER TABLE
CREATE SEQUENCE
ALTER TABLE
ALTER SEQUENCE
ALTER TABLE
COPY 8
 setval 
--------
      8
(1 row)

ALTER TABLE
root@14b702cb5fb3:/# psql -U postgres test_database
psql (13.10 (Debian 13.10-1.pgdg110+1))
Type "help" for help.

test_database=# analyze verbose orders;
INFO:  analyzing "public.orders"
INFO:  "orders": scanned 1 of 1 pages, containing 8 live rows and 0 dead rows; 8 rows in sample, 8 estimated total rows
ANALYZE
test_database=# SELECT attname, avg_width FROM pg_stats WHERE tablename = 'orders' ORDER BY attname DESC LIMIT 1;
 attname | avg_width 
---------+-----------
 title   |        16
(1 row)

test_database=# 
```


## Задача 3

Архитектор и администратор БД выяснили, что ваша таблица orders разрослась до невиданных размеров и
поиск по ней занимает долгое время. Вам, как успешному выпускнику курсов DevOps в нетологии предложили
провести разбиение таблицы на 2 (шардировать на orders_1 - price>499 и orders_2 - price<=499).

Предложите SQL-транзакцию для проведения данной операции.

Можно ли было изначально исключить "ручное" разбиение при проектировании таблицы orders?

##Ответ
```
test_database=# BEGIN;
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ; --установить изоляцию транзакций
ALTER TABLE orders RENAME TO orders_copy;        --переименовать таблицу orders
CREATE TABLE orders (                            --создать таблицу orders  
    id integer NOT NULL,
    title character varying(80) NOT NULL,
    price integer DEFAULT 0)
        PARTITION BY RANGE (price);
CREATE TABLE orders_part_1 PARTITION OF orders   --создать таблицу 1
    FOR VALUES FROM (500) TO (MAXVALUE);
CREATE TABLE orders_part_2 PARTITION OF orders   --создать таблицу 2
    FOR VALUES FROM (MINVALUE) TO (500);
INSERT INTO orders (id, title, price) SELECT * FROM orders_copy; --перенести из переименованной в orders
ALTER SEQUENCE orders_id_seq OWNED BY public.orders.id;          --сменить владельца последовательности значений id
ALTER TABLE ONLY orders ALTER COLUMN id SET DEFAULT nextval('public.orders_id_seq'::regclass); --Возобновить последовательность значений для id
DROP TABLE orders_copy;                   --Удалить таблицу copy                                                                  
COMMIT;
BEGIN
SET
ALTER TABLE
CREATE TABLE
CREATE TABLE
CREATE TABLE
INSERT 0 8
ALTER SEQUENCE
ALTER TABLE
DROP TABLE
COMMIT
test_database=# \dt+
                                       List of relations
 Schema |     Name      |       Type        |  Owner   | Persistence |    Size    | Description 
--------+---------------+-------------------+----------+-------------+------------+-------------
 public | orders        | partitioned table | postgres | permanent   | 0 bytes    | 
 public | orders_part_1 | table             | postgres | permanent   | 8192 bytes | 
 public | orders_part_2 | table             | postgres | permanent   | 8192 bytes | 
(3 rows)

test_database=# select * from orders
test_database-# ;
 id |        title         | price 
----+----------------------+-------
  1 | War and peace        |   100
  3 | Adventure psql time  |   300
  4 | Server gravity falls |   300
  5 | Log gossips          |   123
  7 | Me and my bash-pet   |   499
  2 | My little database   |   500
  6 | WAL never lies       |   900
  8 | Dbiezdmin            |   501
(8 rows)

test_database=# select * from orders_part_1
test_database-# ;
 id |       title        | price 
----+--------------------+-------
  2 | My little database |   500
  6 | WAL never lies     |   900
  8 | Dbiezdmin          |   501
(3 rows)

test_database=# select * from orders_part_2;
 id |        title         | price 
----+----------------------+-------
  1 | War and peace        |   100
  3 | Adventure psql time  |   300
  4 | Server gravity falls |   300
  5 | Log gossips          |   123
  7 | Me and my bash-pet   |   499
(5 rows)

test_database=#
```
Правильная постановка задачи при проектировании решения использования той или иной структуры БД, прогнозирование роста БД могли бы исключить необходимость ручного разбиения БД

## Задача 4

Используя утилиту `pg_dump` создайте бекап БД `test_database`.

Как бы вы доработали бэкап-файл, чтобы добавить уникальность значения столбца `title` для таблиц `test_database`?

##Ответ

Backup
```
root@14b702cb5fb3:/# pg_dump -U postgres --file /var/backups/pg_backup/test_database_dump.sql test_database
root@14b702cb5fb3:/# 
```
Нужно добавить параметр UNIQUE в описание столбца таблицы
```
title character varying(80) NOT NULL UNIQUE,
```
---

### Как cдавать задание

Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.

---
