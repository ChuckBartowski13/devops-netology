# Домашнее задание к занятию "2. SQL"

## Введение

Перед выполнением задания вы можете ознакомиться с 
[дополнительными материалами](https://github.com/netology-code/virt-homeworks/blob/virt-11/additional/README.md).

## Задача 1

Используя docker поднимите инстанс PostgreSQL (версию 12) c 2 volume, 
в который будут складываться данные БД и бэкапы.

Приведите получившуюся команду или docker-compose манифест.

##Ответ
```
ret@test-netology:~/Desktop/Netology/postgres$ cat docker-compose.yaml 
version: "3.3"

services:
  postgesql:
    image: postgres:12
    container_name: postgresql
    environment:
      POSTGRES_USER: postgres
      POSTGRES_PASSWORD: postgres
    volumes:
      - ./data:/var/lib/postgresql/data/
      - ./backup:/var/backups/pg_backup
    restart: always
ret@test-netology:~/Desktop/Netology/postgres$ sudo docker-compose -f docker-compose.yaml up -d
Creating network "postgres_default" with the default driver
Pulling postgesql (postgres:12)...
12: Pulling from library/postgres
bb263680fed1: Pull complete
75a54e59e691: Pull complete
3ce7f8df2b36: Pull complete
f30287ef02b9: Pull complete
dc1f0e9024d8: Pull complete
7f0a68628bce: Pull complete
32b11818cae3: Pull complete
48111fe612c1: Pull complete
5c74df908d6f: Pull complete
e1faa3d728d7: Pull complete
fdb570c7ad5c: Pull complete
7fa4a7a7ed5d: Pull complete
3f1b11174e57: Pull complete
Digest: sha256:e35253c2ca79f001392c027627ae9dded08f788b7bf40e55a211a953d5c331e5
Status: Downloaded newer image for postgres:12
Creating postgresql ... done
ret@test-netology:~/Desktop/Netology/postgres$ sudo docker ps
CONTAINER ID   IMAGE         COMMAND                  CREATED              STATUS              PORTS      NAMES
a50b312cc1dd   postgres:12   "docker-entrypoint.s…"   About a minute ago   Up About a minute   5432/tcp   postgresql
ret@test-netology:~/Desktop/Netology/postgres$ 
```

## Задача 2

В БД из задачи 1: 
- создайте пользователя test-admin-user и БД test_db
- в БД test_db создайте таблицу orders и clients (спeцификация таблиц ниже)
- предоставьте привилегии на все операции пользователю test-admin-user на таблицы БД test_db
- создайте пользователя test-simple-user  
- предоставьте пользователю test-simple-user права на SELECT/INSERT/UPDATE/DELETE данных таблиц БД test_db

Таблица orders:
- id (serial primary key)
- наименование (string)
- цена (integer)

Таблица clients:
- id (serial primary key)
- фамилия (string)
- страна проживания (string, index)
- заказ (foreign key orders)

Приведите:
- итоговый список БД после выполнения пунктов выше,
- описание таблиц (describe)
- SQL-запрос для выдачи списка пользователей с правами над таблицами test_db
- список пользователей с правами над таблицами test_db

##Ответ
```
ret@test-netology:~/Desktop/Netology/postgres$ sudo docker exec -it a50b312cc1dd /bin/bash
root@a50b312cc1dd:/# psql -U postgres
postgres=# CREATE USER "test-admin-user"; CREATE DATABASE test_db;
CREATE ROLE
CREATE DATABASE
postgres-# \c test_db;
You are now connected to database "test_db" as user "postgres".
test_db-# CREATE TABLE orders
(
id SERIAL PRIMARY KEY,
name VARCHAR(20),
price INT
);
test_db=# CREATE TABLE clients
(
  id SERIAL PRIMARY KEY,
  lastname VARCHAR(20),
  country VARCHAR(20),
  order_number INT,
  FOREIGN KEY (order_number) REFERENCES orders (id)
);
CREATE TABLE
test_db=# create index country_idx on clients (country);
CREATE INDEX
test_db=# GRANT ALL ON orders, clients TO "test-admin-user";
GRANT

postgres=# CREATE USER "test-simple-user";
CREATE ROLE
postgres=# \c test_db;
You are now connected to database "test_db" as user "postgres".
test_db=# GRANT SELECT, INSERT, UPDATE, DELETE ON orders, clients TO "test-simple-user";
GRANT
test_db=# 
```
Список БД
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
 test_db   | postgres | UTF8     | en_US.utf8 | en_US.utf8 | 
(4 rows)

postgres=# 
```

Описание

```
test_db=# \d clients
                                      Table "public.clients"
    Column    |         Type          | Collation | Nullable |               Default               
--------------+-----------------------+-----------+----------+-------------------------------------
 id           | integer               |           | not null | nextval('clients_id_seq'::regclass)
 lastname     | character varying(20) |           |          | 
 country      | character varying(20) |           |          | 
 order_number | integer               |           |          | 
Indexes:
    "clients_pkey" PRIMARY KEY, btree (id)
    "country_idx" btree (country)
Foreign-key constraints:
    "clients_order_number_\cfkey" FOREIGN KEY (order_number) REFERENCES orders(id)

test_db=# \d orders
                                   Table "public.orders"
 Column |         Type          | Collation | Nullable |              Default               
--------+-----------------------+-----------+----------+------------------------------------
 id     | integer               |           | not null | nextval('orders_id_seq'::regclass)
 name   | character varying(20) |           |          | 
 price  | integer               |           |          | 
Indexes:
    "orders_pkey" PRIMARY KEY, btree (id)
Referenced by:
    TABLE "clients" CONSTRAINT "clients_order_number_fkey" FOREIGN KEY (order_number) REFERENCES orders(id)

test_db=# 
```

SQL-запрос для выдачи списка пользователей с правами над таблицами test_db
```
est_db=# SELECT * FROM information_schema.table_privileges WHERE table_name = 'clients' OR table_name = 'orders';
 grantor  |     grantee      | table_catalog | table_schema | table_name | privilege_type | is_grantable | with_hierarchy 
----------+------------------+---------------+--------------+------------+----------------+--------------+----------------
 postgres | postgres         | test_db       | public       | orders     | INSERT         | YES          | NO
 postgres | postgres         | test_db       | public       | orders     | SELECT         | YES          | YES
 postgres | postgres         | test_db       | public       | orders     | UPDATE         | YES          | NO
 postgres | postgres         | test_db       | public       | orders     | DELETE         | YES          | NO
 postgres | postgres         | test_db       | public       | orders     | TRUNCATE       | YES          | NO
 postgres | postgres         | test_db       | public       | orders     | REFERENCES     | YES          | NO
 postgres | postgres         | test_db       | public       | orders     | TRIGGER        | YES          | NO
 postgres | test-admin-user  | test_db       | public       | orders     | INSERT         | NO           | NO
 postgres | test-admin-user  | test_db       | public       | orders     | SELECT         | NO           | YES
 postgres | test-admin-user  | test_db       | public       | orders     | UPDATE         | NO           | NO
 postgres | test-admin-user  | test_db       | public       | orders     | DELETE         | NO           | NO
 postgres | test-admin-user  | test_db       | public       | orders     | TRUNCATE       | NO           | NO
 postgres | test-admin-user  | test_db       | public       | orders     | REFERENCES     | NO           | NO
 postgres | test-admin-user  | test_db       | public       | orders     | TRIGGER        | NO           | NO
 postgres | test-simple-user | test_db       | public       | orders     | INSERT         | NO           | NO
 postgres | test-simple-user | test_db       | public       | orders     | SELECT         | NO           | YES
 postgres | test-simple-user | test_db       | public       | orders     | UPDATE         | NO           | NO
 postgres | test-simple-user | test_db       | public       | orders     | DELETE         | NO           | NO
 postgres | postgres         | test_db       | public       | clients    | INSERT         | YES          | NO
 postgres | postgres         | test_db       | public       | clients    | SELECT         | YES          | YES
 postgres | postgres         | test_db       | public       | clients    | UPDATE         | YES          | NO
 postgres | postgres         | test_db       | public       | clients    | DELETE         | YES          | NO
 postgres | postgres         | test_db       | public       | clients    | TRUNCATE       | YES          | NO
 postgres | postgres         | test_db       | public       | clients    | REFERENCES     | YES          | NO
 postgres | postgres         | test_db       | public       | clients    | TRIGGER        | YES          | NO
 postgres | test-admin-user  | test_db       | public       | clients    | INSERT         | NO           | NO
 postgres | test-admin-user  | test_db       | public       | clients    | SELECT         | NO           | YES
 postgres | test-admin-user  | test_db       | public       | clients    | UPDATE         | NO           | NO
 postgres | test-admin-user  | test_db       | public       | clients    | DELETE         | NO           | NO
 postgres | test-admin-user  | test_db       | public       | clients    | TRUNCATE       | NO           | NO
 postgres | test-admin-user  | test_db       | public       | clients    | REFERENCES     | NO           | NO
 postgres | test-admin-user  | test_db       | public       | clients    | TRIGGER        | NO           | NO
 postgres | test-simple-user | test_db       | public       | clients    | INSERT         | NO           | NO
 postgres | test-simple-user | test_db       | public       | clients    | SELECT         | NO           | YES
 postgres | test-simple-user | test_db       | public       | clients    | UPDATE         | NO           | NO
 postgres | test-simple-user | test_db       | public       | clients    | DELETE         | NO           | NO
(36 rows)


```

## Задача 3

Используя SQL синтаксис - наполните таблицы следующими тестовыми данными:

Таблица orders

|Наименование|цена|
|------------|----|
|Шоколад| 10 |
|Принтер| 3000 |
|Книга| 500 |
|Монитор| 7000|
|Гитара| 4000|

Таблица clients

|ФИО|Страна проживания|
|------------|----|
|Иванов Иван Иванович| USA |
|Петров Петр Петрович| Canada |
|Иоганн Себастьян Бах| Japan |
|Ронни Джеймс Дио| Russia|
|Ritchie Blackmore| Russia|

Используя SQL синтаксис:
- вычислите количество записей для каждой таблицы 
- приведите в ответе:
    - запросы 
    - результаты их выполнения.
    
##Ответ
    
```
test_db=# INSERT INTO orders (name, price) VALUES
('Шоколад', 10),
('Принтер', 3000),
('Книга', 500),
('Монитор', 7000),
('Гитара', 4000);
INSERT 0 5
test_db=# INSERT INTO clients (lastname, country) VALUES
('Иванов Иван Иванович', 'USA'),
('Петров Петр Петрович', 'Canada'),
('Иоганн Себастьян Бах', 'Japan'),
('Ронни Джеймс Дио', 'Russia'),
('Ritchie Blackmore', 'Russia');
INSERT 0 5
test_db=# SELECT COUNT(*) FROM orders;
 count 
-------
     5
(1 row)

test_db=# SELECT COUNT(*) FROM clients;
 count 
-------
     5
(1 row)

test_db=# 
```
## Задача 4

Часть пользователей из таблицы clients решили оформить заказы из таблицы orders.

Используя foreign keys свяжите записи из таблиц, согласно таблице:

|ФИО|Заказ|
|------------|----|
|Иванов Иван Иванович| Книга |
|Петров Петр Петрович| Монитор |
|Иоганн Себастьян Бах| Гитара |

Приведите SQL-запросы для выполнения данных операций.

Приведите SQL-запрос для выдачи всех пользователей, которые совершили заказ, а также вывод данного запроса.
 
Подсказк - используйте директиву `UPDATE`.

##Ответ
```
test_db=# UPDATE clients SET "order_number" = 3 WHERE lastname = 'Иванов Иван Иванович';
UPDATE 1
test_db=# UPDATE clients SET "order_number" = 4 WHERE lastname = 'Петров Петр Петрович';
UPDATE 1
test_db=# UPDATE clients SET "order_number" = 5 WHERE lastname = 'Иоганн Себастьян Бах';
UPDATE 1
test_db=# SELECT * FROM clients WHERE order_number IS NOT NULL;
 id |       lastname       | country | order_number 
----+----------------------+---------+--------------
  1 | Иванов Иван Иванович | USA     |            3
  2 | Петров Петр Петрович | Canada  |            4
  3 | Иоганн Себастьян Бах | Japan   |            5
(3 rows)

test_db=# 

```

## Задача 5

Получите полную информацию по выполнению запроса выдачи всех пользователей из задачи 4 
(используя директиву EXPLAIN).

Приведите получившийся результат и объясните что значат полученные значения.

##Ответ
```
test_db=# EXPLAIN SELECT * FROM clients WHERE order_number IS NOT NULL;
                         QUERY PLAN                         
------------------------------------------------------------
 Seq Scan on clients  (cost=0.00..15.30 rows=527 width=124)
   Filter: (order_number IS NOT NULL)
(2 rows)

test_db=# 
```
EXPLAIN выводит план выполнения SQL-запроса, генерируемый планировщиком для заданного оператора:
 - Seq Scan - используется последовательное чтение данных таблицы
 - cost - затратность операции:
  * 0.00 - затраты на получение первой строки
  * 15.30 - затраты на получение всех строк
 - rows - приблизительное количество возвращаемых строк при выполнении операции Seq Scan
 - width - средний размер одной строки в байтах

## Задача 6

Создайте бэкап БД test_db и поместите его в volume, предназначенный для бэкапов (см. Задачу 1).

Остановите контейнер с PostgreSQL (но не удаляйте volumes).

Поднимите новый пустой контейнер с PostgreSQL.

Восстановите БД test_db в новом контейнере.

Приведите список операций, который вы применяли для бэкапа данных и восстановления. 

##Ответ

Backup
```
root@a50b312cc1dd:/# pg_dump -U postgres -Fc test_db > /var/backups/pg_backup/test_db.bak
```
Compose down, delete all data
```
root@test-netology:/home/ret/Desktop/Netology/postgres# docker-compose down
Stopping postgresql ... done
Removing postgresql ... done
Removing network postgres_default
root@test-netology:/home/ret/Desktop/Netology/postgres# rm -R ./data/*
root@test-netology:/home/ret/Desktop/Netology/postgres# ls ./data/
root@test-netology:/home/ret/Desktop/Netology/postgres# 
```
Start compose
```
root@test-netology:/home/ret/Desktop/Netology/postgres# docker-compose -f docker-compose.yaml up -d
Creating network "postgres_default" with the default driver
Creating postgresql ... done

```
Backup restore
```
postgres=# create database test_db;
CREATE DATABASE

root@f7ff375c1848:/# pg_restore -U postgres -Fc -c -d test_db /var/backups/pg_backup/test_db.bak

test_db=# \d clients
                                      Table "public.clients"
    Column    |         Type          | Collation | Nullable |               Default               
--------------+-----------------------+-----------+----------+-------------------------------------
 id           | integer               |           | not null | nextval('clients_id_seq'::regclass)
 lastname     | character varying(20) |           |          | 
 country      | character varying(20) |           |          | 
 order_number | integer               |           |          | 
Indexes:
    "clients_pkey" PRIMARY KEY, btree (id)
    "country_idx" btree (country)
Foreign-key constraints:
    "clients_order_number_fkey" FOREIGN KEY (order_number) REFERENCES orders(id)

test_db=# select * from clients
test_db-# ;
 id |       lastname       | country | order_number 
----+----------------------+---------+--------------
  4 | Ронни Джеймс Дио     | Russia  |             
  5 | Ritchie Blackmore    | Russia  |             
  1 | Иванов Иван Иванович | USA     |            3
  2 | Петров Петр Петрович | Canada  |            4
  3 | Иоганн Себастьян Бах | Japan   |            5
(5 rows)

test_db=# \d orders
                                   Table "public.orders"
 Column |         Type          | Collation | Nullable |              Default               
--------+-----------------------+-----------+----------+------------------------------------
 id     | integer               |           | not null | nextval('orders_id_seq'::regclass)
 name   | character varying(20) |           |          | 
 price  | integer               |           |          | 
Indexes:
    "orders_pkey" PRIMARY KEY, btree (id)
Referenced by:
    TABLE "clients" CONSTRAINT "clients_order_number_fkey" FOREIGN KEY (order_number) REFERENCES orders(id)

test_db=# select * from orders;
 id |  name   | price 
----+---------+-------
  1 | Шоколад |    10
  2 | Принтер |  3000
  3 | Книга   |   500
  4 | Монитор |  7000
  5 | Гитара  |  4000
(5 rows)

test_db=# 

```
---

### Как cдавать задание

Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.

---
