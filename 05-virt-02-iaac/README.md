
# Домашнее задание к занятию "2. Применение принципов IaaC в работе с виртуальными машинами"

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

- Опишите своими словами основные преимущества применения на практике IaaC паттернов.
    * Ускоряет процесс разворачивания необходимой инфраструктуры 
    * Позволяет избежать ситуаций недокументированных изменений, быстрый откат изменений и деплой новых
    * Дает возможность быстро производить доставку кода для непрерывной его интеграции в продукте, а так же провести тестирование

- Какой из принципов IaaC является основополагающим?
    * Идемпотентность

## Задача 2

- Чем Ansible выгодно отличается от других систем управление конфигурациями?
    * разработкой занимается крупная компания - RedHat
    * не требует агентов на управляемых хостах - доступ по ssh
- Какой, на ваш взгляд, метод работы систем конфигурации более надёжный push или pull?
    * Pull, т.к. отсутствует единая точка отказа и хранения данных для доступа.

## Задача 3

Установить на личный компьютер:

- [VirtualBox](https://www.virtualbox.org/)
```commandline
$ VBoxManage --version
6.1.38_Ubuntur153438
```
- [Vagrant](https://github.com/netology-code/devops-materials)
```commandline
$ vagrant -v
Vagrant 2.2.19
```
- [Terraform](https://github.com/netology-code/devops-materials/blob/master/README.md)
```commandline
$ terraform -v
Terraform v1.3.7
on linux_amd64
```
- Ansible
```commandline
$ ansible --version
ansible 2.10.8
  config file = None
  configured module search path = ['/home/ret/.ansible/plugins/modules', '/usr/share/ansible/plugins/modules']
  ansible python module location = /usr/lib/python3/dist-packages/ansible
  executable location = /usr/bin/ansible
  python version = 3.10.6 (main, Nov 14 2022, 16:10:14) [GCC 11.3.0]
```

*Приложить вывод команд установленных версий каждой из программ, оформленный в markdown.*

## Задача 4 

Воспроизвести практическую часть лекции самостоятельно.

- Создать виртуальную машину.
- Зайти внутрь ВМ, убедиться, что Docker установлен с помощью команды
```
ret@ret-VirtualBox:~/Desktop/vagrant/vagrant$ vagrant up
Bringing machine 'server1.netology' up with 'virtualbox' provider...
==> server1.netology: This machine used to live in /home/ret/virt-homeworks/05-virt-02-iaac/src/vagrant but it's now at /home/ret/Desktop/vagrant/vagrant.
==> server1.netology: Depending on your current provider you may need to change the name of
==> server1.netology: the machine to run it as a different machine.
==> server1.netology: Checking if box 'bento/ubuntu-20.04' version '202212.11.0' is up to date...
==> server1.netology: There was a problem while downloading the metadata for your box
==> server1.netology: to check for updates. This is not an error, since it is usually due
==> server1.netology: to temporary network problems. This is just a warning. The problem
==> server1.netology: encountered was:
==> server1.netology: 
==> server1.netology: The requested URL returned error: 404
==> server1.netology: 
==> server1.netology: If you want to check for box updates, verify your network connection
==> server1.netology: is valid and try again.
==> server1.netology: Clearing any previously set forwarded ports...
==> server1.netology: Clearing any previously set network interfaces...
==> server1.netology: Preparing network interfaces based on configuration...
    server1.netology: Adapter 1: nat
    server1.netology: Adapter 2: hostonly
==> server1.netology: Forwarding ports...
    server1.netology: 22 (guest) => 20011 (host) (adapter 1)
    server1.netology: 22 (guest) => 2222 (host) (adapter 1)
==> server1.netology: Running 'pre-boot' VM customizations...
==> server1.netology: Booting VM...
==> server1.netology: Waiting for machine to boot. This may take a few minutes...
    server1.netology: SSH address: 127.0.0.1:2222
    server1.netology: SSH username: vagrant
    server1.netology: SSH auth method: private key
    server1.netology: Warning: Connection reset. Retrying...
    server1.netology: Warning: Remote connection disconnect. Retrying...
    server1.netology: Warning: Connection reset. Retrying...
==> server1.netology: Machine booted and ready!
==> server1.netology: Checking for guest additions in VM...
==> server1.netology: Setting hostname...
==> server1.netology: Configuring and enabling network interfaces...
==> server1.netology: Mounting shared folders...
    server1.netology: /vagrant => /home/ret/Desktop/vagrant/vagrant
==> server1.netology: Machine already provisioned. Run `vagrant provision` or use the `--provision`
==> server1.netology: flag to force provisioning. Provisioners marked to run always will still run.
ret@ret-VirtualBox:~/Desktop/vagrant/vagrant$ vagrant ssh
Welcome to Ubuntu 20.04.5 LTS (GNU/Linux 5.4.0-135-generic x86_64)
 
 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage
 
 System information disabled due to load higher than 1.0
 
This system is built by the Bento project by Chef Software
More information can be found at https://github.com/chef/bento
Last login: Wed Jan 25 22:22:53 2023 from 10.0.2.2
vagrant@server1:~$ docker ps
CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES
vagrant@server1:~$ 
```
Vagrantfile из лекции  и код ansible находятся в [папке](https://github.com/netology-code/virt-homeworks/tree/virt-11/05-virt-02-iaac/src).

Примечание! Если Vagrant выдает вам ошибку:
```
URL: ["https://vagrantcloud.com/bento/ubuntu-20.04"]     
Error: The requested URL returned error: 404:
```

Выполните следующие действия:
1. Скачайте с [сайта](https://app.vagrantup.com/bento/boxes/ubuntu-20.04) файл-образ "bento/ubuntu-20.04"
2. Добавьте его в список образов Vagrant: "vagrant box add bento/ubuntu-20.04 <путь к файлу>"
