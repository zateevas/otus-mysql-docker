# Задание 12

1) Вывести количество заказов в определенные дни (CASE)

CREATE
OR REPLACE
VIEW orders_count AS
SELECT
CASE 
 WHEN  create_time  = NOW() then  "today"
 WHEN  create_time  = (DATE_ADD(NOW(), INTERVAL -1 DAY)) then  "yesterday"
 WHEN  create_time  < (DATE_ADD(NOW(), INTERVAL -1 DAY)) then CONCAT(TIMESTAMPDIFF(DAY,create_time,NOW()), " days ago")
 END as days_ago,
 COUNT(*) as orders_count
FROM orders GROUP BY  days_ago ORDER BY days_ago;

2)  Вывести количество заказов в статусе 4 (HAVING)

CREATE
OR REPLACE
VIEW orders_status_4 AS
SELECT status, COUNT(*) as status_count FROM orders GROUP BY status HAVING status=4;

3) Вывести количество заказов во всех статусах и общее количество заказов. (GROUPING , ROLLUP)

CREATE
OR REPLACE
VIEW orders_all_statuses AS
SELECT
CASE GROUPING(status)
WHEN 1 then "Summary"
ELSE status
END as statuses, COUNT(*) as statuses_count FROM orders GROUP BY status WITH ROLLUP;



# Задание 11

1) Процедура удаляет всю связанную с пользователем информацию

CREATE PROCEDURE delete_all_user_data(IN userid varchar(64))

BEGIN
	START TRANSACTION;
	SELECT GROUP_CONCAT(address_id) INTO @addressesid FROM addresses where user_uuid = userid ;
    set @get_order_ids = CONCAT ("SELECT GROUP_CONCAT(order_id) INTO @orderid FROM orders WHERE address_id IN (",@addressesid,")");
    PREPARE get_order_ids from @get_order_ids;
    EXECUTE get_order_ids;
    set @delete_from_orders_offers = CONCAT ("DELETE FROM orders_offers WHERE order_id in (",@orderid,")");
    PREPARE delete_from_orders_offers from @delete_from_orders_offers;
    set @delete_from_orders = CONCAT ("DELETE FROM orders WHERE address_id in (",@addressesid,")");
    PREPARE delete_from_orders from @delete_from_orders;      
    EXECUTE delete_from_orders_offers;   
    EXECUTE delete_from_orders;
    DELETE FROM addresses WHERE user_uuid = userid;
    DELETE FROM users WHERE uuid = userid;   
    COMMIT;
END


2) Пример LOAD DATA

  LOAD DATA INFILE '/tmp/Apparel.csv' INTO TABLE products.Apparel
  FIELDS TERMINATED BY ',' ENCLOSED BY '"'
  LINES TERMINATED BY '\n'
  IGNORE 1 LINES;

  Пример mysqlimport
  
  mysqlimport --ignore-lines=1 --fields-terminated-by=, --fields-enclosed-by=\" --lines-terminated-by=\\n --verbose -u root -p12345 --local products /tmp/SnowDevil.csv

# Задание 10

1) select user_uuid,title, first_name, last_name, correspondence_language, marital_status,  birth_date, gender, postal_code, countries.name as country, regions.name as region, cities.name as city, streets.name as street, building_number, apartment   
   FROM addresses 
   JOIN users ON users.uuid=addresses.user_uuid 
   JOIN streets ON streets.id=addresses.street_id
   JOIN cities ON cities.id=streets.city_id
   JOIN regions On regions.id=cities.region_id
   JOIN countries On countries.id=regions.country_id; - **Получаем полную информацию по адресам и людям, которые указали адрес
**


   Пример вывода:

| user_uuid                            | title | first_name | last_name | correspondence_language | marital_status | birth_date | gender | postal_code | country | region          | city           | street     | building_number | apartment |
+--------------------------------------+-------+------------+-----------+-------------------------+----------------+------------+--------+-------------+---------+-----------------+----------------+------------+-----------------+-----------+
| 8ed9e006-346a-11ea-9545-0242c0a84002 | mr    | Anton      | Pavlov    | en                      | single         | 1994-05-10 | man    | 2000        | England | Greater London  | London         | Baker st.  | 40              |        15 |
| 45ea8083-346a-11ea-9545-0242c0a84002 | mr    | Ivan       | Ivanov    | ru                      | single         | 1999-10-12 | man    | 1100        | Russia  | Moscow obl      | Moscow         | Lenina st. | 20              |        13 |
| 2f6d7c57-346a-11ea-9545-0242c0a84002 | mr    | Alex       | Zateev    | ru                      | single         | 1996-09-12 | man    | 1000        | Russia  | Moscow obl      | Solnechnogorsk | Lenina st. | 10              |        12 |
| 8ed9dd6a-346a-11ea-9545-0242c0a84002 | mr    | Petr       | Petrov    | ru                      | single         | 1995-08-12 | man    | 1200        | Russia  | Smolenskaya obl | Smolensk       | Lenina st. | 30              |        14 |
+--------------------------------------+-------+------------+-----------+-------------------------+----------------+------------+--------+-------------+---------+-----------------+----------------+------------+-----------------+-----------+

2) select offers.offer_id from offers 
LEFT JOIN orders_offers ON offers.offer_id=orders_offers.offer_id WHERE order_id IS NULL; - **Узнаем по каким предложениям не было ни одного заказа. ** 

   Пример вывода: 
    +----------+
    | offer_id |
    +----------+
    |       58 |
    |       64 |
    |       65 |
    |       57 |
    |       60 |
    |       63 |
    |       66 |
    |       68 |
    |       55 |
    |       61 |
    |       67 |
    +----------+

3) select product_id, offer_id, prices.name as price_type, price_value, currencies.name as currency from offers
   JOIN currencies On currencies.id=offers.currency_id
   JOIN prices On prices.id=offers.price_id
   where product_id=37 and active=1 and end_time > NOW(); - **Узнать все активные предложения по конкретному товару**
   
   Вывод:

   +------------+----------+------------+-------------+----------+
   | product_id | offer_id | price_type | price_value | currency |
   +------------+----------+------------+-------------+----------+
   |         37 |       52 | regular_ru |       10000 | RUB      |
   |         37 |       54 | regular_en |         120 | GBP      |
   +------------+----------+------------+-------------+----------+


   select user_uuid, postal_code, countries.name as country, regions.name as region, cities.name as city, streets.name as street, building_number, apartment   
   FROM addresses 
   JOIN streets ON streets.id=addresses.street_id
   JOIN cities ON cities.id=streets.city_id
   JOIN regions On regions.id=cities.region_id
   JOIN countries On countries.id=regions.country_id WHERE user_uuid='8ed9e006-346a-11ea-9545-0242c0a84002' -** Получить все адреса конкретного пользователя.**
   
   Вывод:
   +--------------------------------------+-------------+---------+----------------+--------+-----------+-----------------+-----------+
   | user_uuid                            | postal_code | country | region         | city   | street    | building_number | apartment |
   +--------------------------------------+-------------+---------+----------------+--------+-----------+-----------------+-----------+
   | 8ed9e006-346a-11ea-9545-0242c0a84002 | 2000        | England | Greater London | London | Baker st. | 40              |        15 |
   +--------------------------------------+-------------+---------+----------------+--------+-----------+-----------------+-----------+

   select order_id, postal_code, countries.name as country, regions.name as region, cities.name as city, streets.name as street, building_number, apartment from orders
   JOIN addresses On orders.address_id=addresses.address_id
   JOIN streets ON streets.id=addresses.street_id
   JOIN cities ON cities.id=streets.city_id
   JOIN regions On regions.id=cities.region_id
   JOIN countries On countries.id=regions.country_id where order_id=1; - **Узнаем по какому адресу нужно доставить конкретный заказ**
   
   Вывод:
   +----------+-------------+---------+------------+----------------+------------+-----------------+-----------+
   | order_id | postal_code | country | region     | city           | street     | building_number | apartment |
   +----------+-------------+---------+------------+----------------+------------+-----------------+-----------+
   |        1 | 1000        | Russia  | Moscow obl | Solnechnogorsk | Lenina st. | 10              |        12 |
   +----------+-------------+---------+------------+----------------+------------+-----------------+-----------+

   select order_id, create_time, close_time, status FROM users 
   JOIN addresses On addresses.user_uuid=users.uuid
   JOIN orders On orders.address_id=addresses.address_id WHERE uuid='2f6d7c57-346a-11ea-9545-0242c0a84002'; - **узнать все заказы конкретного пользователя по всем адресам**

   Вывод:
   +----------+---------------------+---------------------+--------+
   | order_id | create_time         | close_time          | status |
   +----------+---------------------+---------------------+--------+
   |        1 | 2019-11-02 00:00:00 | 2019-11-15 00:00:00 |      5 |
   +----------+---------------------+---------------------+--------+

   SELECT products.id, products.name as product_name, manufacturers.name as manufacturers_name FROM products 
   JOIN manufacturers On products.manufacturer_id=manufacturers.id 
   where JSON_EXTRACT(product_characteristics,"$.category")="Home video game console" ; - **показать все продукты категории "Home video game console"**

   Вывод:
   +----+--------------+--------------------+
   | id | product_name | manufacturers_name |
   +----+--------------+--------------------+
   | 37 | playstation3 | Sony               |
   | 39 | playstation4 | Sony               |
   | 41 | xbox360      | Microsoft          |
   | 42 | Atari 2600   | Atari              |
   +----+--------------+--------------------+




# Задание 9

1) Сделал партиционирование таблицы orders методом key по ключу address_id. Таблицы orders, потому что в ней будет храниться гораздо больше информации, чем во всех остальных. Методом key, потому что мне нужно партиционирование по полю, где будет id, и мне кажется, что так будет наиболее равномерно размазываться информация. По полю address_id, потому что в моем случае address_id является уникальным идентификатором пользователя и таким образом все заказы пользователя будут попадать в одну партицию.

2) Вроде с этим у меня все ок

3) Добавил в таблицу products поле characteristics типа json и удалил все таблицы, которыми я делал характеристики ранее.
   Пример добавления характеристик:
   insert into products (name,manufacturer_id,provider_id,active,product_characteristics) values
   ('playstation3',1,1,1,'{"category":"Home video game console","weight":{"size":2,"unit":"kg"}}'),
   ('playstation3 joystick',1,1,1,'{"category":"Joystick","platform":"playstation3","weight":{"size":0.5,"unit":"kg"}}'),
   ('playstation4',1,1,1,'{"category":"Home video game console","weight":{"size":2,"unit":"kg"}}'),
   ('playstation4 joystick',1,1,1,'{"category":"Joystick","platform":"playstation4","weight":{"size":0.5,"unit":"kg"}}'),
   ('xbox360',2,1,1,'{"category":"Home video game console","weight":{"size":3,"unit":"kg"}}'),
   ('Atari 2600',3,2,0,'{"category":"Home video game console","weight":{"size":1,"unit":"kg"}}');

# Задание 7

Поднять сервис db_va можно командой:

`docker-compose up otusdb`

Для подключения к БД используйте команду:

`docker-compose exec otusdb mysql -u root -p12345 otus`

Для использования в клиентских приложениях можно использовать команду:

`mysql -u root -p12345 --port=3309 --protocol=tcp otus`


# Ниже результаты выполнения sysbench


## Дефолтные настройки

sysbench --num-threads=8 --max-requests=2000 --mysql-user=root --mysql-password=12345 --mysql-host=127.0.0.1 --mysql-port=3309 --db-driver=mysql --mysql-db=otus oltp_read_write run


WARNING: --num-threads is deprecated, use --threads instead
WARNING: --max-requests is deprecated, use --events instead
sysbench 1.0.11 (using system LuaJIT 2.1.0-beta3)

Running the test with following options:
Number of threads: 8
Initializing random number generator from current time


Initializing worker threads...

Threads started!

SQL statistics:
    queries performed:
        read:                            28196
        write:                           8022
        other:                           4014
        total:                           40232
    transactions:                        2000   (336.64 per sec.)
    queries:                             40232  (6771.82 per sec.)
    ignored errors:                      14     (2.36 per sec.)
    reconnects:                          0      (0.00 per sec.)

General statistics:
    total time:                          5.9372s
    total number of events:              2000

Latency (ms):
         min:                                  8.71
         avg:                                 23.67
         max:                                 59.39
         95th percentile:                     36.89
         sum:                              47345.77

Threads fairness:
    events (avg/stddev):           250.0000/2.50
    execution time (avg/stddev):   5.9182/0.01



## Оптимизированные настройки


sysbench --num-threads=8 --max-requests=2000 --mysql-user=root --mysql-password=12345 --mysql-host=127.0.0.1 --mysql-port=3309 --db-driver=mysql --mysql-db=otus oltp_read_write run
WARNING: --num-threads is deprecated, use --threads instead
WARNING: --max-requests is deprecated, use --events instead
sysbench 1.0.11 (using system LuaJIT 2.1.0-beta3)

Running the test with following options:
Number of threads: 8
Initializing random number generator from current time


Initializing worker threads...

Threads started!

SQL statistics:
    queries performed:
        read:                            28420
        write:                           8036
        other:                           4030
        total:                           40486
    transactions:                        2000   (761.55 per sec.)
    queries:                             40486  (15416.01 per sec.)
    ignored errors:                      30     (11.42 per sec.)
    reconnects:                          0      (0.00 per sec.)

General statistics:
    total time:                          2.6245s
    total number of events:              2000

Latency (ms):
         min:                                  5.34
         avg:                                 10.47
         max:                                 39.00
         95th percentile:                     20.00
         sum:                              20930.06

Threads fairness:
    events (avg/stddev):           250.0000/2.92
    execution time (avg/stddev):   2.6163/0.00
