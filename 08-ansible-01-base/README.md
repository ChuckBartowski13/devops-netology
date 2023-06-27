# Домашнее задание к занятию 1 «Введение в Ansible»

## Подготовка к выполнению

1. Установите Ansible версии 2.10 или выше.
2. Создайте свой публичный репозиторий на GitHub с произвольным именем.
3. Скачайте [Playbook](./playbook/) из репозитория с домашним заданием и перенесите его в свой репозиторий.

## Основная часть

1. Попробуйте запустить playbook на окружении из `test.yml`, зафиксируйте значение, которое имеет факт `some_fact` для указанного хоста при выполнении playbook.
```
[admin@ALMA-MAIN playbook]$  ansible-playbook site.yml -i inventory/test.yml 

PLAY [Print os facts] *************************************************************************

TASK [Gathering Facts] ************************************************************************
ok: [localhost]

TASK [Print OS] *******************************************************************************
ok: [localhost] => {
    "msg": "AlmaLinux"
}

TASK [Print fact] *****************************************************************************
ok: [localhost] => {
    "msg": 12
}

PLAY RECAP ************************************************************************************
localhost                  : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   

[admin@ALMA-MAIN playbook]$
```

2. Найдите файл с переменными (group_vars), в котором задаётся найденное в первом пункте значение, и поменяйте его на `all default fact`.
```
[admin@ALMA-MAIN playbook]$ cat group_vars/all/examp.yml 
---
  some_fact: 'all default fact'


[admin@ALMA-MAIN playbook]$ ansible-playbook site.yml -i inventory/test.yml 

PLAY [Print os facts] *************************************************************************

TASK [Gathering Facts] ************************************************************************
ok: [localhost]

TASK [Print OS] *******************************************************************************
ok: [localhost] => {
    "msg": "AlmaLinux"
}

TASK [Print fact] *****************************************************************************
ok: [localhost] => {
    "msg": "all default fact"
}

PLAY RECAP ************************************************************************************
localhost                  : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   

[admin@ALMA-MAIN playbook]$
```
3. Воспользуйтесь подготовленным (используется `docker`) или создайте собственное окружение для проведения дальнейших испытаний.

```
[admin@ALMA-MAIN playbook]$ sudo docker ps
CONTAINER ID   IMAGE             COMMAND                  CREATED          STATUS          PORTS                                   NAMES
c495925a45fd   centos            "/bin/bash"              30 minutes ago   Up 30 minutes                                           centos
72f7a083db99   ubuntu            "/bin/bash"              31 minutes ago   Up 31 minutes                                           ubuntu
```

4. Проведите запуск playbook на окружении из `prod.yml`. Зафиксируйте полученные значения `some_fact` для каждого из `managed host`.
5. Добавьте факты в `group_vars` каждой из групп хостов так, чтобы для `some_fact` получились значения: для `deb` — `deb default fact`, для `el` — `el default fact`.

```
[admin@ALMA-MAIN playbook]$ nano group_vars/el/examp.yml

  GNU nano 2.9.8                                                                  group_vars/el/examp.yml                                                                  Modified

---
  some_fact: 'el default fact'


[admin@ALMA-MAIN playbook]$ nano group_vars/deb/examp.yml

  GNU nano 2.9.8                                                                 group_vars/deb/examp.yml

---
  some_fact: 'deb default fact'
```

6.  Повторите запуск playbook на окружении `prod.yml`. Убедитесь, что выдаются корректные значения для всех хостов.

```
[admin@ALMA-MAIN playbook]$ sudo ansible-playbook site.yml -i inventory/prod.yml
[sudo] password for admin: 

PLAY [Print os facts] ***************************************************************************************************************************************************************

TASK [Gathering Facts] **************************************************************************************************************************************************************
ok: [ubuntu]
ok: [centos]

TASK [Print OS] *********************************************************************************************************************************************************************
ok: [centos] => {
    "msg": "CentOS"
}
ok: [ubuntu] => {
    "msg": "Ubuntu"
}

TASK [Print fact] *******************************************************************************************************************************************************************
ok: [centos] => {
    "msg": "el default fact"
}
ok: [ubuntu] => {
    "msg": "deb default fact"
}

PLAY RECAP **************************************************************************************************************************************************************************
centos                     : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
ubuntu                     : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   

[admin@ALMA-MAIN playbook]$ 
```

7. При помощи `ansible-vault` зашифруйте факты в `group_vars/deb` и `group_vars/el` с паролем `netology`.

```
[admin@ALMA-MAIN playbook]$ ansible-vault encrypt group_vars/el/examp.yml
New Vault password: 
Confirm New Vault password: 
Encryption successful
[admin@ALMA-MAIN playbook]$ ansible-vault encrypt group_vars/deb/examp.yml
New Vault password: 
Confirm New Vault password: 
Encryption successful
[admin@ALMA-MAIN playbook]$ 
```

8. Запустите playbook на окружении `prod.yml`. При запуске `ansible` должен запросить у вас пароль. Убедитесь в работоспособности.

```
[admin@ALMA-MAIN playbook]$ sudo ansible-playbook --ask-vault-pass site.yml -i inventory/prod.yml
Vault password: 

PLAY [Print os facts] ***************************************************************************************************************************************************************

TASK [Gathering Facts] **************************************************************************************************************************************************************
ok: [ubuntu]
ok: [centos]

TASK [Print OS] *********************************************************************************************************************************************************************
ok: [centos] => {
    "msg": "CentOS"
}
ok: [ubuntu] => {
    "msg": "Ubuntu"
}

TASK [Print fact] *******************************************************************************************************************************************************************
ok: [centos] => {
    "msg": "el default fact"
}
ok: [ubuntu] => {
    "msg": "deb default fact"
}

PLAY RECAP **************************************************************************************************************************************************************************
centos                     : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
ubuntu                     : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   

[admin@ALMA-MAIN playbook]$ 
```

9. Посмотрите при помощи `ansible-doc` список плагинов для подключения. Выберите подходящий для работы на `control node`.

Если я правильно понял, то речь об этом:
```
[admin@ALMA-MAIN playbook]$ ansible-doc -t connection -l
ansible.builtin.local          execute on controller                                                                                                                            
ansible.builtin.paramiko_ssh   Run tasks via python ssh (paramiko)                                                                                                              
ansible.builtin.psrp           Run tasks over Microsoft PowerShell Remoting Protocol                                                                                            
ansible.builtin.ssh            connect via SSH client binary                                                                                                                    
ansible.builtin.winrm          Run tasks over Microsoft's WinRM                                                                                                                 
ansible.netcommon.grpc         Provides a persistent connection using the gRPC protocol                                                                                         
ansible.netcommon.httpapi      Use httpapi to run command on network appliances                                                                                                 
ansible.netcommon.libssh       Run tasks using libssh for ssh connection                                                                                                        
ansible.netcommon.netconf      Provides a persistent connection using the netconf protocol                                                                                      
ansible.netcommon.network_cli  Use network_cli to run command on network appliances                                                                                             
ansible.netcommon.persistent   Use a persistent unix socket for connection                                                                                                      
community.aws.aws_ssm          execute via AWS Systems Manager                                                                                                                  
community.docker.docker        Run tasks in docker containers                                                                                                                   
community.docker.docker_api    Run tasks in docker containers                                                                                                                   
community.docker.nsenter       execute on host running controller container                                                                                                     
community.general.chroot       Interact with local chroot                                                                                                                       
community.general.funcd        Use funcd to connect to target                                                                                                                   
community.general.iocage       Run tasks in iocage jails                                                                                                                        
community.general.jail         Run tasks in jails                                                                                                                               
community.general.lxc          Run tasks in lxc containers via lxc python library                                                                                               
community.general.lxd          Run tasks in lxc containers via lxc CLI                                                                                                          
community.general.qubes        Interact with an existing QubesOS AppVM                                                                                                          
community.general.saltstack    Allow ansible to piggyback on salt minions                                                                                                       
community.general.zone         Run tasks in a zone instance                                                                                                                     
community.libvirt.libvirt_lxc  Run tasks in lxc containers via libvirt                                                                                                          
community.libvirt.libvirt_qemu Run tasks on libvirt/qemu virtual machines                                                                                                       
community.okd.oc               Execute tasks in pods running on OpenShift                                                                                                       
community.vmware.vmware_tools  Execute tasks inside a VM via VMware Tools                                                                                                       
containers.podman.buildah      Interact with an existing buildah container                                                                                                      
containers.podman.podman       Interact with an existing podman container                                                                                                       
kubernetes.core.kubectl        Execute tasks in pods running on Kubernetes                                                                                                      
(END)
```

10. В `prod.yml` добавьте новую группу хостов с именем  `local`, в ней разместите localhost с необходимым типом подключения.

```
admin@ALMA-MAIN playbook]$ cat inventory/prod.yml 
---
  el:
    hosts:
      centos:
        ansible_connection: docker
  deb:
    hosts:
      ubuntu:
        ansible_connection: docker
  local:
    hosts:
      localhost:
        ansible_connection: local
[admin@ALMA-MAIN playbook]$ 
```

11. Запустите playbook на окружении `prod.yml`. При запуске `ansible` должен запросить у вас пароль. Убедитесь, что факты `some_fact` для каждого из хостов определены из верных `group_vars`.

```
[admin@ALMA-MAIN playbook]$ sudo ansible-playbook --ask-vault-pass  site.yml -i inventory/prod.yml 
Vault password: 

PLAY [Print os facts] ***************************************************************************************************************************************************************

TASK [Gathering Facts] **************************************************************************************************************************************************************
ok: [localhost]
ok: [ubuntu]
ok: [centos]

TASK [Print OS] *********************************************************************************************************************************************************************
ok: [centos] => {
    "msg": "CentOS"
}
ok: [ubuntu] => {
    "msg": "Ubuntu"
}
ok: [localhost] => {
    "msg": "AlmaLinux"
}

TASK [Print fact] *******************************************************************************************************************************************************************
ok: [centos] => {
    "msg": "el default fact"
}
ok: [ubuntu] => {
    "msg": "deb default fact"
}
ok: [localhost] => {
    "msg": "all default fact"
}

PLAY RECAP **************************************************************************************************************************************************************************
centos                     : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
localhost                  : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
ubuntu                     : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   

[admin@ALMA-MAIN playbook]$ 
```

12. Заполните `README.md` ответами на вопросы. Сделайте `git push` в ветку `master`. В ответе отправьте ссылку на ваш открытый репозиторий с изменённым `playbook` и заполненным `README.md`.

