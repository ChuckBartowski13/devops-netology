# Домашнее задание к занятию "8.4 Работа с Roles"

В рамках домашнего задания, был переработан playbook из задания 8.3.  
Данный playbook устанавливает и настраивает сервисы clickhouse, lighthouse(+nginx) и vector, на 3х ВМ.  
Создание ВМ осуществляется при помощи terraform.

1.Согласно заданию были созданы 2 отдельных репозитория для:  
  [Vector](https://github.com/ChuckBartowski13/vector-role)  
  [Lighthouse](https://github.com/ChuckBartowski13/lighthouse-role)  
+ репозиторий для Clickhouse - c с приложенным у меня не заработало
  [Clickhouse](https://github.com/ChuckBartowski13/clickhouse-role)  
2.В данных репозиториях размещены соответствующие роли.  
3.Playbook [site.yml](https://github.com/ChuckBartowski13/devops-netology/blob/main/08-ansible-04-role/playbook/site.yml) настроен на использование roles.  
4.Для загрузки ролей в Playbook используется [requirements.yml](https://github.com/ChuckBartowski13/devops-netology/blob/main/08-ansible-04-role/playbook/requirements.yml).


