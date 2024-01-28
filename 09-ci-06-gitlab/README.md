# Домашнее задание к занятию 12 «GitLab»

## Подготовка к выполнению


1. Или подготовьте к работе Managed GitLab от yandex cloud [по инструкции](https://cloud.yandex.ru/docs/managed-gitlab/operations/instance/instance-create) .
Или создайте виртуальную машину из публичного образа [по инструкции](https://cloud.yandex.ru/marketplace/products/yc/gitlab ) .
2. Создайте виртуальную машину и установите на нее gitlab runner, подключите к вашему серверу gitlab  [по инструкции](https://docs.gitlab.com/runner/install/linux-repository.html) .

3. (* Необязательное задание повышенной сложности. )  Если вы уже знакомы с k8s попробуйте выполнить задание, запустив gitlab server и gitlab runner в k8s  [по инструкции](https://cloud.yandex.ru/docs/tutorials/infrastructure-management/gitlab-containers). 

4. Создайте свой новый проект.
5. Создайте новый репозиторий в GitLab, наполните его [файлами](./repository).
6. Проект должен быть публичным, остальные настройки по желанию.

## Основная часть

### DevOps

В репозитории содержится код проекта на Python. Проект — RESTful API сервис. Ваша задача — автоматизировать сборку образа с выполнением python-скрипта:

1. Образ собирается на основе [centos:7](https://hub.docker.com/_/centos?tab=tags&page=1&ordering=last_updated).
2. Python версии не ниже 3.7.
3. Установлены зависимости: `flask` `flask-jsonpify` `flask-restful`.
4. Создана директория `/python_api`.
5. Скрипт из репозитория размещён в /python_api.
6. Точка вызова: запуск скрипта.
7. При комите в любую ветку должен собираться docker image с форматом имени hello:gitlab-$CI_COMMIT_SHORT_SHA . Образ должен быть выложен в Gitlab registry или yandex registry.   

### Product Owner

Вашему проекту нужна бизнесовая доработка: нужно поменять JSON ответа на вызов метода GET `/rest/api/get_info`, необходимо создать Issue в котором указать:

1. Какой метод необходимо исправить.
2. Текст с `{ "message": "Already started" }` на `{ "message": "Running"}`.
3. Issue поставить label: feature.

### Developer

Пришёл новый Issue на доработку, вам нужно:

1. Создать отдельную ветку, связанную с этим Issue.
2. Внести изменения по тексту из задания.
3. Подготовить Merge Request, влить необходимые изменения в `master`, проверить, что сборка прошла успешно.


### Tester

Разработчики выполнили новый Issue, необходимо проверить валидность изменений:

1. Поднять докер-контейнер с образом `python-api:latest` и проверить возврат метода на корректность.
2. Закрыть Issue с комментарием об успешности прохождения, указав желаемый результат и фактически достигнутый.

## Итог

В качестве ответа пришлите подробные скриншоты по каждому пункту задания:

- файл gitlab-ci.yml;
- Dockerfile; 
- лог успешного выполнения пайплайна;
- решённый Issue.

### Важно 
После выполнения задания выключите и удалите все задействованные ресурсы в Yandex Cloud.


### Ответ
Файлы и логи приложил.
Остальное прикладываю в виде скринов (делал все на домашнем ПК, т.к. gitlab сервер мне еще понадобится)
Образа сохраняю на своем же gitlab сервере

<p align="center">
  <img width="1200" height="600" src="./pics/1.png">
  <img width="1200" height="600" src="./pics/2.png">
  <img width="1200" height="600" src="./pics/3.png">
  <img width="1200" height="600" src="./pics/4.png">
  <img width="1200" height="600" src="./pics/5.png">
  <img width="1200" height="600" src="./pics/6.png">
  <img width="1200" height="600" src="./pics/7.png">
  <img width="1200" height="600" src="./pics/8.png">
  <img width="1200" height="600" src="./pics/9.png">
  <img width="1200" height="600" src="./pics/10.png">
  <img width="1200" height="600" src="./pics/11.png">
  <img width="1200" height="600" src="./pics/12.png">
  <img width="1200" height="600" src="./pics/13.png">
  <img width="1200" height="600" src="./pics/14.png">
  <img width="1200" height="600" src="./pics/15.png">
  <img width="1200" height="600" src="./pics/16.png">
  <img width="1200" height="600" src="./pics/17.png">
  <img width="1200" height="600" src="./pics/18.png">
  <img width="1200" height="600" src="./pics/19.png">
  <img width="1200" height="600" src="./pics/20.png">
  <img width="1200" height="600" src="./pics/21.png">
  <img width="1200" height="600" src="./pics/22.png">
  <img width="1200" height="600" src="./pics/23.png">
  <img width="1200" height="600" src="./pics/24.png">
  <img width="1200" height="600" src="./pics/25.png">
  <img width="1200" height="600" src="./pics/26.png">
  <img width="1200" height="600" src="./pics/27.png">
  <img width="1200" height="600" src="./pics/28.png">
  <img width="1200" height="600" src="./pics/29.png">
</p>


