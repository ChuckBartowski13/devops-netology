
# Домашнее задание к занятию "3. Введение. Экосистема. Архитектура. Жизненный цикл Docker контейнера"

## Как сдавать задания

Обязательными к выполнению являются задачи без указания звездочки. Их выполнение необходимо для получения зачета и диплома о профессиональной переподготовке.

Задачи со звездочкой (*) являются дополнительными задачами и/или задачами повышенной сложности. Они не являются обязательными к выполнению, но помогут вам глубже понять тему.

Домашнее задание выполните в файле readme.md в github репозитории. В личном кабинете отправьте на проверку ссылку на .md-файл в вашем репозитории.

Любые вопросы по решению задач задавайте в чате учебной группы.

---


## Важно!

Перед отправкой работы на проверку удаляйте неиспользуемые ресурсы.
Это важно для того, чтоб предупредить неконтролируемый расход средств, полученных в результате использования промокода.

Подробные рекомендации [здесь](https://github.com/netology-code/virt-homeworks/blob/virt-11/r/README.md)

---

## Задача 1

Сценарий выполения задачи:

- создайте свой репозиторий на https://hub.docker.com;
- выберете любой образ, который содержит веб-сервер Nginx;
- создайте свой fork образа;
- реализуйте функциональность:
запуск веб-сервера в фоне с индекс-страницей, содержащей HTML-код ниже:
```
<html>
<head>
Hey, Netology
</head>
<body>
<h1>I’m DevOps Engineer!</h1>
</body>
</html>
```
Опубликуйте созданный форк в своем репозитории и предоставьте ответ в виде ссылки на https://hub.docker.com/username_repo.

## Ответ
```
ret@ret-VirtualBox:~/Desktop/Nginx$ sudo docker build -t ret2701/my_nginx_netology .
Sending build context to Docker daemon  3.072kB
Step 1/2 : FROM nginx:latest
 ---> a99a39d070bf
Step 2/2 : COPY ./index.html /usr/share/nginx/html/index.html
 ---> Using cache
 ---> cd93c757ada2
Successfully built cd93c757ada2
Successfully tagged ret2701/my_nginx_netology:latest
ret@ret-VirtualBox:~/Desktop/Nginx$ cat Dockerfile 
FROM nginx:latest
COPY ./index.html /usr/share/nginx/html/index.html
ret@ret-VirtualBox:~/Desktop/Nginx$ sudo docker images
REPOSITORY                  TAG       IMAGE ID       CREATED         SIZE
mysql                       8         cdf3aa69f5f0   7 days ago      517MB
my_nginx_netologu           v1        cd93c757ada2   9 days ago      142MB
ret2701/my_nginx_netology   latest    cd93c757ada2   9 days ago      142MB
postgres                    12        3d6880d04326   3 weeks ago     373MB
postgres                    15        9f3ec01f884d   3 weeks ago     379MB
nginx                       latest    a99a39d070bf   3 weeks ago     142MB
debian                      latest    5c8936e57a38   3 weeks ago     124MB
alpine                      3.14      dd53f409bf0b   5 months ago    5.61MB
centos                      latest    5d0da3dc9764   16 months ago   231MB
ret@ret-VirtualBox:~/Desktop/Nginx$ sudo docker run --name my_nginx -d -p 8080:80 ret2701/my_nginx_netology
59b4c3dc8f472cb83e6b7f4add3a9f474eabcfcf65f3bce0266cdd02b9bee86e
ret@ret-VirtualBox:~/Desktop/Nginx$ sudo docker ps
CONTAINER ID   IMAGE                       COMMAND                  CREATED        STATUS        PORTS                                   NAMES
59b4c3dc8f47   ret2701/my_nginx_netology   "/docker-entrypoint.…"   14 hours ago   Up 14 hours   0.0.0.0:8080->80/tcp, :::8080->80/tcp   my_nginx
dc1ed8bf3ca3   postgres:15                 "docker-entrypoint.s…"   6 days ago     Up 6 days     5432/tcp                                postgresql
23a6eb877860   debian:latest               "/bin/bash"              9 days ago     Up 9 days                                             debian
9a949b7a7df8   centos:latest               "/bin/bash"              9 days ago     Up 9 days                                             centos
ret@ret-VirtualBox:~/Desktop/Nginx$ sudo docker image push ret2701/my_nginx_netology:latest
The push refers to repository [docker.io/ret2701/my_nginx_netology]
273d20500576: Pushed 
80115eeb30bc: Pushed 
049fd3bdb25d: Pushed 
ff1154af28db: Pushed 
8477a329ab95: Pushed 
7e7121bf193a: Pushed 
67a4178b7d47: Pushed 
latest: digest: sha256:0ade8a699daf92957e49ef573c76668e0f00890fd1348cf7c93422a64844506f size: 1777
ret@ret-VirtualBox:~/Desktop/Nginx$ 
```
Репозиторий:
https://hub.docker.com/repositories/ret2701


## Задача 2

Посмотрите на сценарий ниже и ответьте на вопрос:
"Подходит ли в этом сценарии использование Docker контейнеров или лучше подойдет виртуальная машина, физическая машина? Может быть возможны разные варианты?"

Детально опишите и обоснуйте свой выбор.

--

Сценарий:

- Высоконагруженное монолитное java веб-приложение;
    * Монолит не подразумевает использование контейнеров, поэтому - физическая или виртуальная машина 
- Nodejs веб-приложение;
    * Контейнеры т.к. удобно деплоить и будет являться частью микросервисной архитектуры
- Мобильное приложение c версиями для Android и iOS;
    * Физическая машина с установленными гипервизорами для сборки и тестирования приложений под соответствующие мобильные ОС
- Шина данных на базе Apache Kafka;
    * Физические машины, т.к.приложение подразумевает высоконагруженную кластерную архитектуру, чувствительно к нагрузкам и требовательно к ресурсам системы, сети
- Elasticsearch кластер для реализации логирования продуктивного веб-приложения - три ноды elasticsearch, два logstash и две ноды kibana;
    * Контейнеры на узлах kubernetes кластера, т.к. в таком виде им легко управлять, перезапускать в случае падения, добавлять дополнительные при увеличении нагрузки
- Мониторинг-стек на базе Prometheus и Grafana;
    * Удобнее наверное все-таки разворачивать данную структуру в виде контейнеров в составе имеющегося kubernetes кластера, но можно установить и отдельно на спец виртуальную машину
- MongoDB, как основное хранилище данных для java-приложения;
    * Можно разворачивать, как в виде контейнеров, так в виде виртуальных и физических машин - все завист от нагрузки на бд.
- Gitlab сервер для реализации CI/CD процессов и приватный (закрытый) Docker Registry.
    * Удобнее разворачивать стек сервисов в виде docker контейнеров, хотя можно использовать и виртуальные машины

## Задача 3

- Запустите первый контейнер из образа ***centos*** c любым тэгом в фоновом режиме, подключив папку ```/data``` из текущей рабочей директории на хостовой машине в ```/data``` контейнера;
- Запустите второй контейнер из образа ***debian*** в фоновом режиме, подключив папку ```/data``` из текущей рабочей директории на хостовой машине в ```/data``` контейнера;
- Подключитесь к первому контейнеру с помощью ```docker exec``` и создайте текстовый файл любого содержания в ```/data```;
- Добавьте еще один файл в папку ```/data``` на хостовой машине;
- Подключитесь во второй контейнер и отобразите листинг и содержание файлов в ```/data``` контейнера.

## Ответ
```
ret@ret-VirtualBox:~/Desktop/Nginx$ sudo docker pull centos
Using default tag: latest
latest: Pulling from library/centos
a1d0c7532777: Pull complete 
Digest: sha256:a27fd8080b517143cbbbab9dfb7c8571c40d67d534bbdee55bd6c473f432b177
Status: Downloaded newer image for centos:latest
docker.io/library/centos:latest
ret@ret-VirtualBox:~/Desktop/Nginx$ sudo docker pull debian
Using default tag: latest
latest: Pulling from library/debian
bbeef03cda1f: Pull complete 
Digest: sha256:534da5794e770279c889daa891f46f5a530b0c5de8bfbc5e40394a0164d9fa87
Status: Downloaded newer image for debian:latest
docker.io/library/debian:latest
ret@ret-VirtualBox:~/Desktop/task3$ sudo docker run -it -d -v /home/ret/Desktop/task3/data:/tmp/data --name centos centos:latest /bin/bash
9a949b7a7df81038adc553b68a133a429f728ded51379a5507fac0b351530833
ret@ret-VirtualBox:~/Desktop/task3$ sudo docker exec -it centos /bin/bash
[root@9a949b7a7df8 /]# cd /tmp/data
[root@9a949b7a7df8 data]# pwd
/tmp/data
[root@9a949b7a7df8 data]# touch test
[root@9a949b7a7df8 data]# echo hello >> test
[root@9a949b7a7df8 data]# cat test 
hello
[root@9a949b7a7df8 data]# exit
exit
ret@ret-VirtualBox:~/Desktop/task3$ sudo docker run -it -d -v /home/ret/Desktop/task3/data:/tmp/data --name debian debian:latest /bin/bash
23a6eb8778605a44780779c25f02362a2bd07ff53996714165a2dc2990155fd2
ret@ret-VirtualBox:~/Desktop/task3$ sudo docker exec -it debian /bin/bash
root@23a6eb877860:/# cd /tmp/data
root@23a6eb877860:/tmp/data# cat test 
hello
root@23a6eb877860:/tmp/data# exit
exit
ret@ret-VirtualBox:~/Desktop/packer$ sudo docker exec -it centos /bin/bash
[root@9a949b7a7df8 /]# touch /tmp/data/test2
[root@9a949b7a7df8 /]# exit
exit
ret@ret-VirtualBox:~/Desktop/packer$ sudo docker exec -it debian /bin/bash
root@23a6eb877860:/# ll /tmp/data
bash: ll: command not found
root@23a6eb877860:/# ls /tmp/data
test  test2
root@23a6eb877860:/#
```

## Задача 4 (*)

Воспроизвести практическую часть лекции самостоятельно.

Соберите Docker образ с Ansible, загрузите на Docker Hub и пришлите ссылку вместе с остальными ответами к задачам.


---

### Как cдавать задание

Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.

---
