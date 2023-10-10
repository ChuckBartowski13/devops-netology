# Домашнее задание к занятию 2 «Работа с Playbook»

## Основная часть

1. Подготовьте свой inventory-файл `prod.yml`.
```
ret@test-netology:~/Desktop/!!!!homework/devops-netology/08-ansible-02-playbook/playbook/inventory$ cat prod.yml 
---
vector:
  hosts:
    centos-v:
      ansible_connection: docker

```
2. Допишите playbook: нужно сделать ещё один play, который устанавливает и настраивает [vector](https://vector.dev). Конфигурация vector должна деплоиться через template файл jinja2. От вас не требуется использовать все возможности шаблонизатора, просто вставьте стандартный конфиг в template файл. Информация по шаблонам по [ссылке](https://www.dmosk.ru/instruktions.php?object=ansible-nginx-install).
3. При создании tasks рекомендую использовать модули: `get_url`, `template`, `unarchive`, `file`.
4. Tasks должны: скачать дистрибутив нужной версии, выполнить распаковку в выбранную директорию, установить vector.
```
ret@test-netology:~/Desktop/!!!!homework/devops-netology/08-ansible-02-playbook/playbook$ cat site.yml 
---
- name: Install Vector
  hosts: vector
  tasks:
    - name: Get Vector distrib
      ansible.builtin.get_url:
        url: "https://packages.timber.io/vector/{{ vector_version }}/vector-{{
            vector_version }}-x86_64-unknown-linux-gnu.tar.gz"
        dest: "./vector-{{ vector_version }}-x86_64-unknown-linux-gnu.tar.gz"
        mode: "0755"
        timeout: 90
        force: true
      tags: download_distr
    - name: Create directory for Vector
      ansible.builtin.file:
        state: directory
        path: "{{ vector_dir }}"
        mode: "0755"
      tags: create_dir
    - name: Extract Vector
      ansible.builtin.unarchive:
        copy: false
        src: "/vector-{{ vector_version }}-x86_64-unknown-linux-gnu.tar.gz"
        dest: "{{ vector_dir }}"
        extra_opts: [--strip-components=2]
        creates: "{{ vector_dir }}/bin/vector"
      tags: extract_distr
    - name: Environment Vector
      ansible.builtin.template:
        src: templates/vector.sh.j2
        dest: /etc/profile.d/vector.sh
        mode: "0755"
      tags: env_vector
ret@test-netology:~/Desktop/!!!!homework/devops-netology/08-ansible-02-playbook/playbook$ 
```
```
ret@test-netology:~/Desktop/!!!!homework/devops-netology/08-ansible-02-playbook/playbook/templates$ cat vector.sh.j2 
#!/usr/bin/env bash
export VECTOR_DIR={{ vector_dir }}
export PATH=$PATH:$VECTOR_DIR/bin
vector --config /etc/vector/config/vector.toml
ret@test-netology:~/Desktop/!!!!homework/devops-netology/08-ansible-02-playbook/playbook/templates$ 

```
```
ret@test-netology:~/Desktop/!!!!homework/devops-netology/08-ansible-02-playbook/playbook/group_vars/vector$ cat vars.yml 
---
vector_version: "0.31.0"
vector_dir: "/etc/vector"
```

```
ret@ret-pc:~/projects/edu/08-ansible-02-playbook/playbook$ ansible-playbook site.yml -i inventory/prod.yml 

PLAY [Install Vector] ***************************************************************************************************************************************************************

TASK [Gathering Facts] **************************************************************************************************************************************************************
ok: [centos-v]

TASK [Get Vector distrib] ***********************************************************************************************************************************************************
changed: [centos-v]

TASK [Create directory for Vector] **************************************************************************************************************************************************
changed: [centos-v]

TASK [Extract Vector] ***************************************************************************************************************************************************************
changed: [centos-v]

TASK [environment Vector] ***********************************************************************************************************************************************************
changed: [centos-v]

PLAY RECAP **************************************************************************************************************************************************************************
centos-v                   : ok=5    changed=4    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0  

```
5. Запустите `ansible-lint site.yml` и исправьте ошибки, если они есть.
```
ret@ret-pc:~/projects/edu/08-ansible-02-playbook/playbook$ ansible-lint site.yml
WARNING  Listing 5 violation(s) that are fatal
yaml[octal-values]: Forbidden implicit octal value "0755"
site.yml:10

yaml[octal-values]: Forbidden implicit octal value "0755"
site.yml:18

name[casing]: All names should start with an uppercase letter.
site.yml:28 Task/Handler: environment Vector

yaml[octal-values]: Forbidden implicit octal value "0755"
site.yml:32

yaml[new-line-at-end-of-file]: No new line character at the end of file
site.yml:33

Read documentation for instructions on how to ignore specific rule violations.

                      Rule Violation Summary                       
 count tag                           profile  rule associated tags 
     1 yaml[new-line-at-end-of-file] basic    formatting, yaml     
     3 yaml[octal-values]            basic    formatting, yaml     
     1 name[casing]                  moderate idiom                

Failed: 5 failure(s), 0 warning(s) on 1 files. Last profile that met the validation criteria was 'min'.
ret@ret-pc:~/projects/edu/08-ansible-02-playbook/playbook$ 


ret@ret-pc:~/projects/edu/08-ansible-02-playbook/playbook$ ansible-lint site.yml

Passed: 0 failure(s), 0 warning(s) on 1 files. Last profile that met the validation criteria was 'production'.
ret@ret-pc:~/projects/edu/08-ansible-02-playbook/playbook$ 
```
6. Попробуйте запустить playbook на этом окружении с флагом `--check`.
```
ret@ret-pc:~/projects/edu/08-ansible-02-playbook/playbook$ ansible-playbook site.yml -i inventory/prod.yml --check

PLAY [Install Vector] ***************************************************************************************************************************************************************

TASK [Gathering Facts] **************************************************************************************************************************************************************
ok: [centos-v]

TASK [Get Vector distrib] ***********************************************************************************************************************************************************
changed: [centos-v]

TASK [Create directory for Vector] **************************************************************************************************************************************************
changed: [centos-v]

TASK [Extract Vector] ***************************************************************************************************************************************************************
An exception occurred during task execution. To see the full traceback, use -vvv. The error was: NoneType: None
fatal: [centos-v]: FAILED! => {"changed": false, "msg": "dest '/etc/vector' must be an existing dir"}

PLAY RECAP **************************************************************************************************************************************************************************
centos-v                   : ok=3    changed=2    unreachable=0    failed=1    skipped=0    rescued=0    ignored=0   

ret@ret-pc:~/projects/edu/08-ansible-02-playbook/playbook$ 
```
7. Запустите playbook на `prod.yml` окружении с флагом `--diff`. Убедитесь, что изменения на системе произведены.
```
ret@ret-pc:~/projects/edu/08-ansible-02-playbook/playbook$ ansible-playbook site.yml -i inventory/prod.yml --diff

PLAY [Install Vector] *************************************************************************************************************************************************************************

TASK [Gathering Facts] ************************************************************************************************************************************************************************
ok: [centos-v]

TASK [Get Vector distrib] *********************************************************************************************************************************************************************
changed: [centos-v]

TASK [Create directory for Vector] ************************************************************************************************************************************************************
--- before
+++ after
@@ -1,4 +1,4 @@
 {
     "path": "/etc/vector",
-    "state": "absent"
+    "state": "directory"
 }

changed: [centos-v]

TASK [Extract Vector] *************************************************************************************************************************************************************************
changed: [centos-v]

TASK [Environment Vector] *********************************************************************************************************************************************************************
--- before
+++ after: /home/ret/.ansible/tmp/ansible-local-258188v57r1ion/tmpcc1tbsrm/vector.sh.j2
@@ -0,0 +1,4 @@
+#!/usr/bin/env bash
+export VECTOR_DIR=/etc/vector
+export PATH=$PATH:$VECTOR_DIR/bin
+vector --config /etc/vector/config/vector.toml
\ No newline at end of file

changed: [centos-v]

PLAY RECAP ************************************************************************************************************************************************************************************
centos-v                   : ok=5    changed=4    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   

ret@ret-pc:~/projects/edu/08-ansible-02-playbook/playbook$ 
```
8. Повторно запустите playbook с флагом `--diff` и убедитесь, что playbook идемпотентен.
```
ret@ret-pc:~/projects/edu/08-ansible-02-playbook/playbook$ ansible-playbook site.yml -i inventory/prod.yml --diff

PLAY [Install Vector] *************************************************************************************************************************************************************************

TASK [Gathering Facts] ************************************************************************************************************************************************************************
ok: [centos-v]

TASK [Get Vector distrib] *********************************************************************************************************************************************************************
ok: [centos-v]

TASK [Create directory for Vector] ************************************************************************************************************************************************************
ok: [centos-v]

TASK [Extract Vector] *************************************************************************************************************************************************************************
skipping: [centos-v]

TASK [Environment Vector] *********************************************************************************************************************************************************************
ok: [centos-v]

PLAY RECAP ************************************************************************************************************************************************************************************
centos-v                   : ok=4    changed=0    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0   

ret@ret-pc:~/projects/edu/08-ansible-02-playbook/playbook$ 
```
9. Подготовьте README.md-файл по своему playbook. В нём должно быть описано: что делает playbook, какие у него есть параметры и теги. Пример качественной документации ansible playbook по [ссылке](https://github.com/opensearch-project/ansible-playbook).
10. Готовый playbook выложите в свой репозиторий, поставьте тег `08-ansible-02-playbook` на фиксирующий коммит, в ответ предоставьте ссылку на него.

---
