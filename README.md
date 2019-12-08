Поднять сервис db_va можно командой:

`docker-compose up otusdb`

Для подключения к БД используйте команду:

`docker-compose exec otusdb mysql -u root -p12345 otus`

Для использования в клиентских приложениях можно использовать команду:

`mysql -u root -p12345 --port=3309 --protocol=tcp otus`


#Ниже результаты выполнения sysbench


##Дефолтные настройки

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



##Оптимизированные настройки
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
