### Как сдавать задания

Вы уже изучили блок «Системы управления версиями», и начиная с этого занятия все ваши работы будут приниматься ссылками на .md-файлы, размещённые в вашем публичном репозитории.

Скопируйте в свой .md-файл содержимое этого файла; исходники можно посмотреть [здесь](https://raw.githubusercontent.com/netology-code/sysadm-homeworks/devsys10/04-script-01-bash/README.md). Заполните недостающие части документа решением задач (заменяйте `???`, ОСТАЛЬНОЕ В ШАБЛОНЕ НЕ ТРОГАЙТЕ чтобы не сломать форматирование текста, подсветку синтаксиса и прочее, иначе можно отправиться на доработку) и отправляйте на проверку. Вместо логов можно вставить скриншоты по желани.

---


# Домашнее задание к занятию "4.1. Командная оболочка Bash: Практические навыки"

## Обязательная задача 1

Есть скрипт:
```bash
a=1
b=2
c=a+b
d=$a+$b
e=$(($a+$b))
```

Какие значения переменным c,d,e будут присвоены? Почему?

| Переменная  | Значение | Обоснование |
| ------------- | ------------- | ------------- |
| `c`  | `"a+b"`  | `так как указали текст, а не переменные` |
| `d`  | `"1+2"`  | `команда преобразовала и вывела значения переменных, но не выполнила арифметическую операцию, т.к. по умолчанию это строки` |
| `e`  | `"3"`  | `т.к. теперь за счет скобок дана команда на выполнение арифметической операции со значениями переменных` |


## Обязательная задача 2
На нашем локальном сервере упал сервис и мы написали скрипт, который постоянно проверяет его доступность, записывая дату проверок до тех пор, пока сервис не станет доступным (после чего скрипт должен завершиться). В скрипте допущена ошибка, из-за которой выполнение не может завершиться, при этом место на Жёстком Диске постоянно уменьшается. Что необходимо сделать, чтобы его исправить:
```bash
while ((1==1)
do
	curl https://localhost:4757
	if (($? != 0))
	then
		date >> curl.log
	fi
done
```

### Ваш скрипт:
```
#!/bin/bash
    while (( 1 == 1 ))# в условии нехватает закрывающей скобки )
    do
        curl https://localhost:4757
        if (($? != 0))
        then
            date >> curl.log
        #нужно добавить проверку успешности для выхода из цикла
        else exit
        fi
        #слишком частые проверки забивают файл, нужно добавить sleep $timeout - для задания интервала проверки
        sleep 5
    done
```

## Обязательная задача 3
Необходимо написать скрипт, который проверяет доступность трёх IP: `192.168.0.1`, `173.194.222.113`, `87.250.250.242` по `80` порту и записывает результат в файл `log`. Проверять доступность необходимо пять раз для каждого узла.

### Ваш скрипт:
```bash
#!/bin/bash
hosts=(192.168.0.1 173.194.222.113 87.250.250.24)
timeout=5
for popytka in {1..5}
do
date >>hosts.log

    for host in ${hosts[@]}
    do
        curl -Is --connect-timeout $timeout $host:80 >/dev/null
        if (($? == 0))
        then
            echo "check $host status=$? connection OK" >>hosts.log
        else
            echo "check $host status=$? connection BAD" >>hosts.log
        fi
    done
done
```

## Обязательная задача 4
Необходимо дописать скрипт из предыдущего задания так, чтобы он выполнялся до тех пор, пока один из узлов не окажется недоступным. Если любой из узлов недоступен - IP этого узла пишется в файл error, скрипт прерывается.

### Ваш скрипт:
```bash
#!/bin/bash
hosts=(192.168.0.1 173.194.222.113 87.250.250.24)
timeout=5
for popytka in {1..5}
do
date >>hosts.log
date >>error.log
    for host in ${hosts[@]}
    do
        curl -Is --connect-timeout $timeout $host:80 >/dev/null
        if (($? == 0))
        then
            echo "check $host status=$? connection OK" >>hosts.log
        else
            echo "check $host status=$? connection BAD" >>error.log
            exit
        fi
    done
done
```

## Дополнительное задание (со звездочкой*) - необязательно к выполнению

Мы хотим, чтобы у нас были красивые сообщения для коммитов в репозиторий. Для этого нужно написать локальный хук для git, который будет проверять, что сообщение в коммите содержит код текущего задания в квадратных скобках и количество символов в сообщении не превышает 30. Пример сообщения: \[04-script-01-bash\] сломал хук.

### Ваш скрипт:
```bash
???
```
# Домашнее задание к занятию "4.2. Использование Python для решения типовых DevOps задач"

## Обязательная задача 1

Есть скрипт:
```python
#!/usr/bin/env python3
a = 1
b = '2'
c = a + b
```

### Вопросы:
| Вопрос  | Ответ |
| ------------- | ------------- |
| Какое значение будет присвоено переменной `c`?  | 'ошибка - переменные разных типов' |
| Как получить для переменной `c` значение 12?  | 'c = str(a) + b' |
| Как получить для переменной `c` значение 3?  | 'c = a + int(b)'  |

## Обязательная задача 2
Мы устроились на работу в компанию, где раньше уже был DevOps Engineer. Он написал скрипт, позволяющий узнать, какие файлы модифицированы в репозитории, относительно локальных изменений. Этим скриптом недовольно начальство, потому что в его выводе есть не все изменённые файлы, а также непонятен полный путь к директории, где они находятся. Как можно доработать скрипт ниже, чтобы он исполнял требования вашего руководителя?

```python
#!/usr/bin/env python3

import os

bash_command = ["cd ~/netology/sysadm-homeworks", "git status"]
result_os = os.popen(' && '.join(bash_command)).read()
is_change = False
for result in result_os.split('\n'):
    if result.find('modified') != -1:
        prepare_result = result.replace('\tmodified:   ', '')
        print(prepare_result)
        break
```

### Ваш скрипт:
```python
import os

bash_command = ["cd ~/netology/devops-netology", "git status"]
result_os = os.popen(' && '.join(bash_command)).read()
#is_change = False  # непонятная переменная
for result in result_os.split('\n'):
    if result.find('modified') != -1:
        prepare_result = result.replace('\tmodified:   ', '')
        print(prepare_result)
        #break  #брейк прекращает цикл как только найден первый модифицированнй файл
```

### Вывод скрипта при запуске при тестировании:
```
/usr/bin/python3.10 /home/ret/netology/python/python2.py 
.gitignore
README.md
has_been_moved.txt

Process finished with exit code 0
```

## Обязательная задача 3
1. Доработать скрипт выше так, чтобы он мог проверять не только локальный репозиторий в текущей директории, а также умел воспринимать путь к репозиторию, который мы передаём как входной параметр. Мы точно знаем, что начальство коварное и будет проверять работу этого скрипта в директориях, которые не являются локальными репозиториями.

### Ваш скрипт:
```python
import os
import sys  # модуль для доступа к аргументам
from colored import fg  # модуль для цветов шрифта

color_green = fg('green')  # цвет шрифта
color_red = fg('red')      # цвет шрифта

directory = os.getcwd()    # по умолчанию для скрипта смотрим в текущую директорию

if len(sys.argv) > 1:
    directory = sys.argv[1]  # если мы запустили с параметром, то используем его

bash_command = ["cd " + directory, "git status 2>&1"]   #в случае ошибки она пойдет в вывод и будет обработана ниже
result_os = os.popen(' && '.join(bash_command)).read()
for result in result_os.split('\n'):
    if result.find('fatal') != -1:
        print(color_red + directory + ' - not a git repository. Choose another')
        break
    if result.find('modified') != -1:
        prepare_result = result.replace('\tmodified:   ', '')
        print(color_green + directory + prepare_result)
```

### Вывод скрипта при запуске при тестировании:
```
ret@test-netology:~/netology/python$ python3 python3.py /root
/bin/sh: 1: cd: can't cd to /root

ret@test-netology:~/netology/python$ python3 python3.py
/home/ret/netology/python - not a git repository. Choose another

ret@test-netology:~/netology/python$ python3 python3.py /home/ret/netology/devops-netology/
/home/ret/netology/devops-netology/.gitignore
/home/ret/netology/devops-netology/README.md
/home/ret/netology/devops-netology/has_been_moved.txt

```

## Обязательная задача 4
1. Наша команда разрабатывает несколько веб-сервисов, доступных по http. Мы точно знаем, что на их стенде нет никакой балансировки, кластеризации, за DNS прячется конкретный IP сервера, где установлен сервис. Проблема в том, что отдел, занимающийся нашей инфраструктурой очень часто меняет нам сервера, поэтому IP меняются примерно раз в неделю, при этом сервисы сохраняют за собой DNS имена. Это бы совсем никого не беспокоило, если бы несколько раз сервера не уезжали в такой сегмент сети нашей компании, который недоступен для разработчиков. Мы хотим написать скрипт, который опрашивает веб-сервисы, получает их IP, выводит информацию в стандартный вывод в виде: <URL сервиса> - <его IP>. Также, должна быть реализована возможность проверки текущего IP сервиса c его IP из предыдущей проверки. Если проверка будет провалена - оповестить об этом в стандартный вывод сообщением: [ERROR] <URL сервиса> IP mismatch: <старый IP> <Новый IP>. Будем считать, что наша разработка реализовала сервисы: `drive.google.com`, `mail.google.com`, `google.com`.

### Ваш скрипт:
```python
import socket
import time

services = {'drive.google.com': '0.0.0.0', 'mail.google.com': '0.0.0.0', 'google.com': '0.0.0.0'}

while True:
  for service in services:
    time.sleep(3)
    ip_service = socket.gethostbyname(service)
    print(service + ' - ' + ip_service)
    if ip_service != services[service]:
      print('[ERROR] ' + service + ' IP mistmatch: ' + str(services[service]) + ' ' + ip_service)
      services[service] = ip_service
```

### Вывод скрипта при запуске при тестировании:
```
/usr/bin/python3.10 /home/ret/netology/python/python4.py 
drive.google.com - 142.251.1.194
[ERROR] drive.google.com IP mistmatch: 0.0.0.0 142.251.1.194
mail.google.com - 142.250.150.18
[ERROR] mail.google.com IP mistmatch: 0.0.0.0 142.250.150.18
google.com - 108.177.14.101
[ERROR] google.com IP mistmatch: 0.0.0.0 108.177.14.101
drive.google.com - 142.251.1.194
mail.google.com - 142.250.150.17
[ERROR] mail.google.com IP mistmatch: 142.250.150.18 142.250.150.17
google.com - 108.177.14.139
[ERROR] google.com IP mistmatch: 108.177.14.101 108.177.14.139
drive.google.com - 142.251.1.194
mail.google.com - 142.250.150.18
[ERROR] mail.google.com IP mistmatch: 142.250.150.17 142.250.150.18
google.com - 108.177.14.101
[ERROR] google.com IP mistmatch: 108.177.14.139 108.177.14.101
drive.google.com - 142.251.1.194
mail.google.com - 142.250.150.83
[ERROR] mail.google.com IP mistmatch: 142.250.150.18 142.250.150.83
google.com - 108.177.14.100
[ERROR] google.com IP mistmatch: 108.177.14.101 108.177.14.100
drive.google.com - 142.251.1.194
mail.google.com - 142.250.150.19
[ERROR] mail.google.com IP mistmatch: 142.250.150.83 142.250.150.19
```

## Дополнительное задание (со звездочкой*) - необязательно к выполнению

Так получилось, что мы очень часто вносим правки в конфигурацию своей системы прямо на сервере. Но так как вся наша команда разработки держит файлы конфигурации в github и пользуется gitflow, то нам приходится каждый раз переносить архив с нашими изменениями с сервера на наш локальный компьютер, формировать новую ветку, коммитить в неё изменения, создавать pull request (PR) и только после выполнения Merge мы наконец можем официально подтвердить, что новая конфигурация применена. Мы хотим максимально автоматизировать всю цепочку действий. Для этого нам нужно написать скрипт, который будет в директории с локальным репозиторием обращаться по API к github, создавать PR для вливания текущей выбранной ветки в master с сообщением, которое мы вписываем в первый параметр при обращении к py-файлу (сообщение не может быть пустым). При желании, можно добавить к указанному функционалу создание новой ветки, commit и push в неё изменений конфигурации. С директорией локального репозитория можно делать всё, что угодно. Также, принимаем во внимание, что Merge Conflict у нас отсутствуют и их точно не будет при push, как в свою ветку, так и при слиянии в master. Важно получить конечный результат с созданным PR, в котором применяются наши изменения. 

### Ваш скрипт:
```python
???
```

### Вывод скрипта при запуске при тестировании:
```
???
```

# Домашнее задание к занятию "4.3. Языки разметки JSON и YAML"


## Обязательная задача 1
Мы выгрузили JSON, который получили через API запрос к нашему сервису:
```
    { "info" : "Sample JSON output from our service\t",
        "elements" :[
            { "name" : "first",
            "type" : "server",
            "ip" : 7175 
            },
            { "name" : "second",
            "type" : "proxy",
            "ip" : "71.78.22.43"
            }
        ]
    }
```
  Нужно найти и исправить все ошибки, которые допускает наш сервис
##Ответ
  не хватало запятой после фигурной скобки 
              "ip" : 7175 
            },   вот здесь
            { "name" : "second",
  и кавычек вот здесь "ip" : "71.78.22.43"
  

## Обязательная задача 2
В прошлый рабочий день мы создавали скрипт, позволяющий опрашивать веб-сервисы и получать их IP. К уже реализованному функционалу нам нужно добавить возможность записи JSON и YAML файлов, описывающих наши сервисы. Формат записи JSON по одному сервису: `{ "имя сервиса" : "его IP"}`. Формат записи YAML по одному сервису: `- имя сервиса: его IP`. Если в момент исполнения скрипта меняется IP у сервиса - он должен так же поменяться в yml и json файле.

### Ваш скрипт:
```python
import socket
import time
import json
import yaml

services = {'drive.google.com': '0.0.0.0', 'mail.google.com': '0.0.0.0', 'google.com': '0.0.0.0'}
#записал в файлы исходную информацию
# json
with open("json_file.json", 'w') as jsf:
  json_data = json.dumps(services, indent=4, separators=(", ", ": "))
  jsf.write(json_data)
# yaml
with open("yaml_file.yaml", 'w') as ymf:
  yaml_data = yaml.dump(services)
  ymf.write(yaml_data)

while True:
  for service in services:
    time.sleep(3)
    ip_service = socket.gethostbyname(service)
    print(service + ' - ' + ip_service)
    if ip_service != services[service]:
      print('[ERROR] ' + service + ' IP mistmatch: ' + str(services[service]) + ' ' + ip_service)
      services[service] = ip_service
      # записываю изменения
      # json
      with open("json_file.json", 'w') as jsf:
        json_data = json.dumps(services, indent=4, separators=(", ", ": "))
        jsf.write(json_data)
      # yaml
      with open("yaml_file.yaml", 'w') as ymf:
        yaml_data = yaml.dump(services)
        ymf.write(yaml_data)
```

### Вывод скрипта при запуске при тестировании:
```
/usr/bin/python3.10 /home/ret/netology/python/python4.py 
drive.google.com - 64.233.165.194
[ERROR] drive.google.com IP mistmatch: 0.0.0.0 64.233.165.194
mail.google.com - 74.125.131.83
[ERROR] mail.google.com IP mistmatch: 0.0.0.0 74.125.131.83
google.com - 173.194.73.139
[ERROR] google.com IP mistmatch: 0.0.0.0 173.194.73.139
drive.google.com - 64.233.165.194
mail.google.com - 74.125.131.17
[ERROR] mail.google.com IP mistmatch: 74.125.131.83 74.125.131.17
google.com - 173.194.73.101
[ERROR] google.com IP mistmatch: 173.194.73.139 173.194.73.101
```

### json-файл(ы), который(е) записал ваш скрипт:
```json
{
    "drive.google.com": "64.233.165.194", 
    "mail.google.com": "74.125.131.17", 
    "google.com": "173.194.73.101"
}

```

### yml-файл(ы), который(е) записал ваш скрипт:
```yaml                                          
drive.google.com: 64.233.165.194
google.com: 173.194.73.101
mail.google.com: 74.125.131.17
```

## Дополнительное задание (со звездочкой*) - необязательно к выполнению

Так как команды в нашей компании никак не могут прийти к единому мнению о том, какой формат разметки данных использовать: JSON или YAML, нам нужно реализовать парсер из одного формата в другой. Он должен уметь:
   * Принимать на вход имя файла
   * Проверять формат исходного файла. Если файл не json или yml - скрипт должен остановить свою работу
   * Распознавать какой формат данных в файле. Считается, что файлы *.json и *.yml могут быть перепутаны
   * Перекодировать данные из исходного формата во второй доступный (из JSON в YAML, из YAML в JSON)
   * При обнаружении ошибки в исходном файле - указать в стандартном выводе строку с ошибкой синтаксиса и её номер
   * Полученный файл должен иметь имя исходного файла, разница в наименовании обеспечивается разницей расширения файлов

### Ваш скрипт:
```python
???
```

### Пример работы скрипта:
???