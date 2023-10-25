# Домашнее задание к занятию 5 «Тестирование roles»

## Подготовка к выполнению

1. Установите molecule: `pip3 install "molecule==3.5.2"` и драйвера `pip3 install molecule_docker molecule_podman`.
2. Выполните `docker pull aragast/netology:latest` —  это образ с podman, tox и несколькими пайтонами (3.7 и 3.9) внутри.

Выполнил
```
ret@test-netology:~$ pip3 install "molecule==3.5.2"
Defaulting to user installation because normal site-packages is not writeable
Collecting molecule==3.5.2
  Downloading molecule-3.5.2-py3-none-any.whl (240 kB)
     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 240.2/240.2 KB 2.2 MB/s eta 0:00:00
Collecting cookiecutter>=1.7.3
  Downloading cookiecutter-2.4.0-py3-none-any.whl (38 kB)
Requirement already satisfied: click<9,>=8.0 in /usr/lib/python3/dist-packages (from molecule==3.5.2) (8.0.3)
Requirement already satisfied: Jinja2>=2.11.3 in ./.local/lib/python3.10/site-packages (from molecule==3.5.2) (3.1.2)
Requirement already satisfied: rich>=9.5.1 in ./.local/lib/python3.10/site-packages (from molecule==3.5.2) (13.4.2)
Requirement already satisfied: subprocess-tee>=0.3.5 in ./.local/lib/python3.10/site-packages (from molecule==3.5.2) (0.4.1)
Requirement already satisfied: paramiko<3,>=2.5.0 in /usr/lib/python3/dist-packages (from molecule==3.5.2) (2.9.3)
Requirement already satisfied: PyYAML<6,>=5.1 in /usr/lib/python3/dist-packages (from molecule==3.5.2) (5.4.1)
Collecting pluggy<2.0,>=0.7.1
  Downloading pluggy-1.3.0-py3-none-any.whl (18 kB)
Requirement already satisfied: packaging in ./.local/lib/python3.10/site-packages (from molecule==3.5.2) (23.1)
Requirement already satisfied: ansible-compat>=0.5.0 in ./.local/lib/python3.10/site-packages (from molecule==3.5.2) (4.1.2)
Collecting click-help-colors>=0.9
  Downloading click_help_colors-0.9.2-py3-none-any.whl (5.5 kB)
Collecting enrich>=1.2.5
  Downloading enrich-1.2.7-py3-none-any.whl (8.7 kB)
Collecting cerberus!=1.3.3,!=1.3.4,>=1.3.1
  Downloading Cerberus-1.3.5-py3-none-any.whl (30 kB)
Collecting selinux
  Downloading selinux-0.3.0-py2.py3-none-any.whl (4.2 kB)
Requirement already satisfied: jsonschema>=4.6.0 in ./.local/lib/python3.10/site-packages (from ansible-compat>=0.5.0->molecule==3.5.2) (4.17.3)
Requirement already satisfied: ansible-core>=2.12 in ./.local/lib/python3.10/site-packages (from ansible-compat>=0.5.0->molecule==3.5.2) (2.15.1)
Requirement already satisfied: requests>=2.23.0 in ./.local/lib/python3.10/site-packages (from cookiecutter>=1.7.3->molecule==3.5.2) (2.31.0)
Collecting binaryornot>=0.4.4
  Downloading binaryornot-0.4.4-py2.py3-none-any.whl (9.0 kB)
Collecting python-slugify>=4.0.0
  Downloading python_slugify-8.0.1-py2.py3-none-any.whl (9.7 kB)
Collecting arrow
  Downloading arrow-1.3.0-py3-none-any.whl (66 kB)
     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 66.4/66.4 KB 18.8 MB/s eta 0:00:00
Requirement already satisfied: MarkupSafe>=2.0 in /usr/lib/python3/dist-packages (from Jinja2>=2.11.3->molecule==3.5.2) (2.0.1)
Requirement already satisfied: pygments<3.0.0,>=2.13.0 in ./.local/lib/python3.10/site-packages (from rich>=9.5.1->molecule==3.5.2) (2.15.1)
Requirement already satisfied: markdown-it-py>=2.2.0 in ./.local/lib/python3.10/site-packages (from rich>=9.5.1->molecule==3.5.2) (3.0.0)
Requirement already satisfied: distro>=1.3.0 in /usr/lib/python3/dist-packages (from selinux->molecule==3.5.2) (1.7.0)
Requirement already satisfied: resolvelib<1.1.0,>=0.5.3 in ./.local/lib/python3.10/site-packages (from ansible-core>=2.12->ansible-compat>=0.5.0->molecule==3.5.2) (1.0.1)
Requirement already satisfied: cryptography in /usr/lib/python3/dist-packages (from ansible-core>=2.12->ansible-compat>=0.5.0->molecule==3.5.2) (3.4.8)
Requirement already satisfied: chardet>=3.0.2 in /usr/lib/python3/dist-packages (from binaryornot>=0.4.4->cookiecutter>=1.7.3->molecule==3.5.2) (4.0.0)
Requirement already satisfied: attrs>=17.4.0 in /usr/lib/python3/dist-packages (from jsonschema>=4.6.0->ansible-compat>=0.5.0->molecule==3.5.2) (21.2.0)
Requirement already satisfied: pyrsistent!=0.17.0,!=0.17.1,!=0.17.2,>=0.14.0 in /usr/lib/python3/dist-packages (from jsonschema>=4.6.0->ansible-compat>=0.5.0->molecule==3.5.2) (0.18.1)
Requirement already satisfied: mdurl~=0.1 in ./.local/lib/python3.10/site-packages (from markdown-it-py>=2.2.0->rich>=9.5.1->molecule==3.5.2) (0.1.2)
Collecting text-unidecode>=1.3
  Downloading text_unidecode-1.3-py2.py3-none-any.whl (78 kB)
     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 78.2/78.2 KB 16.3 MB/s eta 0:00:00
Requirement already satisfied: certifi>=2017.4.17 in /usr/lib/python3/dist-packages (from requests>=2.23.0->cookiecutter>=1.7.3->molecule==3.5.2) (2020.6.20)
Requirement already satisfied: urllib3<3,>=1.21.1 in /usr/lib/python3/dist-packages (from requests>=2.23.0->cookiecutter>=1.7.3->molecule==3.5.2) (1.26.5)
Requirement already satisfied: idna<4,>=2.5 in /usr/lib/python3/dist-packages (from requests>=2.23.0->cookiecutter>=1.7.3->molecule==3.5.2) (3.3)
Requirement already satisfied: charset-normalizer<4,>=2 in ./.local/lib/python3.10/site-packages (from requests>=2.23.0->cookiecutter>=1.7.3->molecule==3.5.2) (3.1.0)
Collecting types-python-dateutil>=2.8.10
  Downloading types_python_dateutil-2.8.19.14-py3-none-any.whl (9.4 kB)
Requirement already satisfied: python-dateutil>=2.7.0 in /usr/lib/python3/dist-packages (from arrow->cookiecutter>=1.7.3->molecule==3.5.2) (2.8.1)
Installing collected packages: types-python-dateutil, text-unidecode, cerberus, selinux, python-slugify, pluggy, click-help-colors, binaryornot, arrow, enrich, cookiecutter, molecule
Successfully installed arrow-1.3.0 binaryornot-0.4.4 cerberus-1.3.5 click-help-colors-0.9.2 cookiecutter-2.4.0 enrich-1.2.7 molecule-3.5.2 pluggy-1.3.0 python-slugify-8.0.1 selinux-0.3.0 text-unidecode-1.3 types-python-dateutil-2.8.19.14
ret@test-netology:~$ pip3 install molecule_docker molecule_podman
Defaulting to user installation because normal site-packages is not writeable
Collecting molecule_docker
  Downloading molecule_docker-2.1.0-py3-none-any.whl (18 kB)
Collecting molecule_podman
  Downloading molecule_podman-2.0.3-py3-none-any.whl (15 kB)
Collecting molecule>=4.0.0
  Downloading molecule-6.0.2-py3-none-any.whl (229 kB)
     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 229.7/229.7 KB 2.3 MB/s eta 0:00:00
Requirement already satisfied: requests in ./.local/lib/python3.10/site-packages (from molecule_docker) (2.31.0)
Requirement already satisfied: selinux in ./.local/lib/python3.10/site-packages (from molecule_docker) (0.3.0)
Requirement already satisfied: docker>=4.3.1 in /usr/lib/python3/dist-packages (from molecule_docker) (5.0.3)
Requirement already satisfied: ansible-compat>=2.2.0 in ./.local/lib/python3.10/site-packages (from molecule_podman) (4.1.2)
Requirement already satisfied: subprocess-tee>=0.4.1 in ./.local/lib/python3.10/site-packages (from ansible-compat>=2.2.0->molecule_podman) (0.4.1)
Requirement already satisfied: jsonschema>=4.6.0 in ./.local/lib/python3.10/site-packages (from ansible-compat>=2.2.0->molecule_podman) (4.17.3)
Requirement already satisfied: ansible-core>=2.12 in ./.local/lib/python3.10/site-packages (from ansible-compat>=2.2.0->molecule_podman) (2.15.1)
Requirement already satisfied: PyYAML in /usr/lib/python3/dist-packages (from ansible-compat>=2.2.0->molecule_podman) (5.4.1)
Requirement already satisfied: packaging in ./.local/lib/python3.10/site-packages (from ansible-compat>=2.2.0->molecule_podman) (23.1)
Requirement already satisfied: wcmatch>=8.1.2 in ./.local/lib/python3.10/site-packages (from molecule>=4.0.0->molecule_docker) (8.4.1)
Requirement already satisfied: click-help-colors>=0.9 in ./.local/lib/python3.10/site-packages (from molecule>=4.0.0->molecule_docker) (0.9.2)
Requirement already satisfied: pluggy<2.0,>=0.7.1 in ./.local/lib/python3.10/site-packages (from molecule>=4.0.0->molecule_docker) (1.3.0)
Requirement already satisfied: enrich>=1.2.7 in ./.local/lib/python3.10/site-packages (from molecule>=4.0.0->molecule_docker) (1.2.7)
Requirement already satisfied: Jinja2>=2.11.3 in ./.local/lib/python3.10/site-packages (from molecule>=4.0.0->molecule_docker) (3.1.2)
Requirement already satisfied: rich>=9.5.1 in ./.local/lib/python3.10/site-packages (from molecule>=4.0.0->molecule_docker) (13.4.2)
Requirement already satisfied: click<9,>=8.0 in /usr/lib/python3/dist-packages (from molecule>=4.0.0->molecule_docker) (8.0.3)
Collecting ansible-compat>=2.2.0
  Downloading ansible_compat-4.1.10-py3-none-any.whl (22 kB)
Requirement already satisfied: urllib3<3,>=1.21.1 in /usr/lib/python3/dist-packages (from requests->molecule_docker) (1.26.5)
Requirement already satisfied: idna<4,>=2.5 in /usr/lib/python3/dist-packages (from requests->molecule_docker) (3.3)
Requirement already satisfied: certifi>=2017.4.17 in /usr/lib/python3/dist-packages (from requests->molecule_docker) (2020.6.20)
Requirement already satisfied: charset-normalizer<4,>=2 in ./.local/lib/python3.10/site-packages (from requests->molecule_docker) (3.1.0)
Requirement already satisfied: distro>=1.3.0 in /usr/lib/python3/dist-packages (from selinux->molecule_docker) (1.7.0)
Requirement already satisfied: resolvelib<1.1.0,>=0.5.3 in ./.local/lib/python3.10/site-packages (from ansible-core>=2.12->ansible-compat>=2.2.0->molecule_podman) (1.0.1)
Requirement already satisfied: cryptography in /usr/lib/python3/dist-packages (from ansible-core>=2.12->ansible-compat>=2.2.0->molecule_podman) (3.4.8)
Requirement already satisfied: MarkupSafe>=2.0 in /usr/lib/python3/dist-packages (from Jinja2>=2.11.3->molecule>=4.0.0->molecule_docker) (2.0.1)
Requirement already satisfied: attrs>=17.4.0 in /usr/lib/python3/dist-packages (from jsonschema>=4.6.0->ansible-compat>=2.2.0->molecule_podman) (21.2.0)
Requirement already satisfied: pyrsistent!=0.17.0,!=0.17.1,!=0.17.2,>=0.14.0 in /usr/lib/python3/dist-packages (from jsonschema>=4.6.0->ansible-compat>=2.2.0->molecule_podman) (0.18.1)
Requirement already satisfied: markdown-it-py>=2.2.0 in ./.local/lib/python3.10/site-packages (from rich>=9.5.1->molecule>=4.0.0->molecule_docker) (3.0.0)
Requirement already satisfied: pygments<3.0.0,>=2.13.0 in ./.local/lib/python3.10/site-packages (from rich>=9.5.1->molecule>=4.0.0->molecule_docker) (2.15.1)
Requirement already satisfied: bracex>=2.1.1 in ./.local/lib/python3.10/site-packages (from wcmatch>=8.1.2->molecule>=4.0.0->molecule_docker) (2.3.post1)
Requirement already satisfied: mdurl~=0.1 in ./.local/lib/python3.10/site-packages (from markdown-it-py>=2.2.0->rich>=9.5.1->molecule>=4.0.0->molecule_docker) (0.1.2)
Installing collected packages: ansible-compat, molecule, molecule_podman, molecule_docker
  Attempting uninstall: ansible-compat
    Found existing installation: ansible-compat 4.1.2
    Uninstalling ansible-compat-4.1.2:
      Successfully uninstalled ansible-compat-4.1.2
  Attempting uninstall: molecule
    Found existing installation: molecule 3.5.2
    Uninstalling molecule-3.5.2:
      Successfully uninstalled molecule-3.5.2
Successfully installed ansible-compat-4.1.10 molecule-6.0.2 molecule_docker-2.1.0 molecule_podman-2.0.3
ret@test-netology:~$ docker pull aragast/netology:latest
latest: Pulling from aragast/netology
f70d60810c69: Pull complete 
545277d80005: Pull complete 
3787740a304b: Pull complete 
8099be4bd6d4: Pull complete 
78316366859b: Pull complete 
a887350ff6d8: Pull complete 
8ab90b51dc15: Pull complete 
14617a4d32c2: Pull complete 
b868affa868e: Pull complete 
1e0b58337306: Pull complete 
9167ab0cbb7e: Pull complete 
907e71e165dd: Pull complete 
6025d523ea47: Pull complete 
6084c8fa3ce3: Pull complete 
cffe842942c7: Pull complete 
d984a1f47d62: Pull complete 
Digest: sha256:e44f93d3d9880123ac8170d01bd38ea1cd6c5174832b1782ce8f97f13e695ad5
Status: Downloaded newer image for aragast/netology:latest
docker.io/aragast/netology:latest
ret@test-netology:~$ 
```

## Основная часть

Ваша цель — настроить тестирование ваших ролей. 

Задача — сделать сценарии тестирования для vector. 

Ожидаемый результат — все сценарии успешно проходят тестирование ролей.

### Molecule

1. Запустите  `molecule test -s centos_7` внутри корневой директории clickhouse-role, посмотрите на вывод команды. Данная команда может отработать с ошибками, это нормально. Наша цель - посмотреть как другие в реальном мире используют молекулу.
2. Перейдите в каталог с ролью vector-role и создайте сценарий тестирования по умолчанию при помощи `molecule init scenario --driver-name docker`.
```
ret@test-netology:~/Desktop/homework/devops-netology/08-ansible-05-testing/vector$ molecule init scenario --driver-name docker
INFO     Initializing new scenario default...

PLAY [Create a new molecule scenario] ******************************************

TASK [Check if destination folder exists] **************************************
changed: [localhost]

TASK [Check if destination folder is empty] ************************************
ok: [localhost]

TASK [Fail if destination folder is not empty] *********************************
skipping: [localhost]

TASK [Expand templates] ********************************************************
changed: [localhost] => (item=molecule/default/destroy.yml)
changed: [localhost] => (item=molecule/default/converge.yml)
changed: [localhost] => (item=molecule/default/create.yml)
changed: [localhost] => (item=molecule/default/molecule.yml)

PLAY RECAP *********************************************************************
localhost                  : ok=3    changed=2    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0

INFO     Initialized scenario in /home/ret/Desktop/homework/devops-netology/08-ansible-05-testing/vector/molecule/default successfully.
ret@test-netology:~/Desktop/homework/devops-netology/08-ansible-05-testing/vector$
```
3. Добавьте несколько разных дистрибутивов (centos:8, ubuntu:latest) для инстансов и протестируйте роль, исправьте найденные ошибки, если они есть.
4. Добавьте несколько assert в verify.yml-файл для  проверки работоспособности vector-role (проверка, что конфиг валидный, проверка успешности запуска и др.). 
5. Запустите тестирование роли повторно и проверьте, что оно прошло успешно.
5. Добавьте новый тег на коммит с рабочим сценарием в соответствии с семантическим версионированием.

Создал 2 сценария тестирования: 'Cenos_7' и 'Ubuntu_lastest'

Assert для проверки роли:

```
- name: Verify
  hosts: all
  gather_facts: false
  tasks:
  - name: Get Vector version
    ansible.builtin.command: "vector --version"
    changed_when: false
    register: vector_version
  - name: Assert Vector instalation
    assert:
      that: "'{{ vector_version.rc }}' == '0'"
  - name: Validate vector config file
    ansible.builtin.command: "vector validate --no-environment --config-yaml /etc/vector/vector.yaml"
    register: vector_validate
    changed_when: false
  - name: Assert Vector validate config
    assert:
      that: "'{{ vector_validate.rc }}' == '0'"
```
Тестирование Centos7
```
ret@test-netology:~/Desktop/homework/devops-netology/08-ansible-05-testing/vector$ molecule test -s centos_7
WARNING  Driver docker does not provide a schema.
INFO     centos_7 scenario test matrix: dependency, cleanup, destroy, syntax, create, prepare, converge, idempotence, side_effect, verify, cleanup, destroy
INFO     Performing prerun with role_name_check=0...
INFO     Using /home/ret/.ansible/roles/my_namespace.vector symlink to current repository in order to enable Ansible to find the role using its expected full name.
INFO     Running centos_7 > dependency
WARNING  Skipping, missing the requirements file.
WARNING  Skipping, missing the requirements file.
INFO     Running centos_7 > cleanup
WARNING  Skipping, cleanup playbook not configured.
INFO     Running centos_7 > destroy
INFO     Sanity checks: 'docker'

PLAY [Destroy] *****************************************************************

TASK [Set async_dir for HOME env] **********************************************
ok: [localhost]

TASK [Destroy molecule instance(s)] ********************************************
changed: [localhost] => (item=instance)

TASK [Wait for instance(s) deletion to complete] *******************************
FAILED - RETRYING: [localhost]: Wait for instance(s) deletion to complete (300 retries left).
ok: [localhost] => (item=instance)

TASK [Delete docker networks(s)] ***********************************************
skipping: [localhost]

PLAY RECAP *********************************************************************
localhost                  : ok=3    changed=1    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0

INFO     Running centos_7 > syntax

playbook: /home/ret/Desktop/homework/devops-netology/08-ansible-05-testing/vector/molecule/centos_7/converge.yml
INFO     Running centos_7 > create

PLAY [Create] ******************************************************************

TASK [Set async_dir for HOME env] **********************************************
ok: [localhost]

TASK [Log into a Docker registry] **********************************************
skipping: [localhost] => (item=None) 
skipping: [localhost]

TASK [Check presence of custom Dockerfiles] ************************************
ok: [localhost] => (item={'image': 'docker.io/pycontribs/centos:7', 'name': 'instance', 'pre_build_image': True})

TASK [Create Dockerfiles from image names] *************************************
skipping: [localhost] => (item={'image': 'docker.io/pycontribs/centos:7', 'name': 'instance', 'pre_build_image': True}) 
skipping: [localhost]

TASK [Synchronization the context] *********************************************
skipping: [localhost] => (item={'image': 'docker.io/pycontribs/centos:7', 'name': 'instance', 'pre_build_image': True}) 
skipping: [localhost]

TASK [Discover local Docker images] ********************************************
ok: [localhost] => (item={'changed': False, 'skipped': True, 'skip_reason': 'Conditional result was False', 'false_condition': 'not item.pre_build_image | default(false)', 'item': {'image': 'docker.io/pycontribs/centos:7', 'name': 'instance', 'pre_build_image': True}, 'ansible_loop_var': 'item', 'i': 0, 'ansible_index_var': 'i'})

TASK [Build an Ansible compatible image (new)] *********************************
skipping: [localhost] => (item=molecule_local/docker.io/pycontribs/centos:7) 
skipping: [localhost]

TASK [Create docker network(s)] ************************************************
skipping: [localhost]

TASK [Determine the CMD directives] ********************************************
ok: [localhost] => (item={'image': 'docker.io/pycontribs/centos:7', 'name': 'instance', 'pre_build_image': True})

TASK [Create molecule instance(s)] *********************************************
changed: [localhost] => (item=instance)

TASK [Wait for instance(s) creation to complete] *******************************
FAILED - RETRYING: [localhost]: Wait for instance(s) creation to complete (300 retries left).
changed: [localhost] => (item={'failed': 0, 'started': 1, 'finished': 0, 'ansible_job_id': 'j65056372310.18217', 'results_file': '/home/ret/.ansible_async/j65056372310.18217', 'changed': True, 'item': {'image': 'docker.io/pycontribs/centos:7', 'name': 'instance', 'pre_build_image': True}, 'ansible_loop_var': 'item'})

PLAY RECAP *********************************************************************
localhost                  : ok=6    changed=2    unreachable=0    failed=0    skipped=5    rescued=0    ignored=0

INFO     Running centos_7 > prepare
WARNING  Skipping, prepare playbook not configured.
INFO     Running centos_7 > converge

PLAY [Converge] ****************************************************************

TASK [Gathering Facts] *********************************************************
ok: [instance]

TASK [Include vector] **********************************************************

TASK [vector : Vector | install Vector distrib | CentOS] ***********************
changed: [instance]

TASK [vector : Vector | install Vector distrib | Ubuntu] ***********************
skipping: [instance]

TASK [vector : Vector/Template config] *****************************************
changed: [instance]

TASK [vector : Vector/Create systemd unit] *************************************
changed: [instance]

TASK [vector : Vector | Start service] *****************************************
skipping: [instance]

PLAY RECAP *********************************************************************
instance                   : ok=4    changed=3    unreachable=0    failed=0    skipped=2    rescued=0    ignored=0

INFO     Running centos_7 > idempotence

PLAY [Converge] ****************************************************************

TASK [Gathering Facts] *********************************************************
ok: [instance]

TASK [Include vector] **********************************************************

TASK [vector : Vector | install Vector distrib | CentOS] ***********************
ok: [instance]

TASK [vector : Vector | install Vector distrib | Ubuntu] ***********************
skipping: [instance]

TASK [vector : Vector/Template config] *****************************************
ok: [instance]

TASK [vector : Vector/Create systemd unit] *************************************
ok: [instance]

TASK [vector : Vector | Start service] *****************************************
skipping: [instance]

PLAY RECAP *********************************************************************
instance                   : ok=4    changed=0    unreachable=0    failed=0    skipped=2    rescued=0    ignored=0

INFO     Idempotence completed successfully.
INFO     Running centos_7 > side_effect
WARNING  Skipping, side effect playbook not configured.
INFO     Running centos_7 > verify
INFO     Running Ansible Verifier

PLAY [Verify] ******************************************************************

TASK [Get Vector version] ******************************************************
ok: [instance]

TASK [Assert Vector instalation] ***********************************************
ok: [instance] => {
    "changed": false,
    "msg": "All assertions passed"
}

TASK [Validate vector config file] *********************************************
ok: [instance]

TASK [Assert Vector validate config] *******************************************
ok: [instance] => {
    "changed": false,
    "msg": "All assertions passed"
}

PLAY RECAP *********************************************************************
instance                   : ok=4    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0

INFO     Verifier completed successfully.
INFO     Running centos_7 > cleanup
WARNING  Skipping, cleanup playbook not configured.
INFO     Running centos_7 > destroy

PLAY [Destroy] *****************************************************************

TASK [Set async_dir for HOME env] **********************************************
ok: [localhost]

TASK [Destroy molecule instance(s)] ********************************************
changed: [localhost] => (item=instance)

TASK [Wait for instance(s) deletion to complete] *******************************
FAILED - RETRYING: [localhost]: Wait for instance(s) deletion to complete (300 retries left).
changed: [localhost] => (item=instance)

TASK [Delete docker networks(s)] ***********************************************
skipping: [localhost]

PLAY RECAP *********************************************************************
localhost                  : ok=3    changed=2    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0

INFO     Pruning extra files from scenario ephemeral directory
ret@test-netology:~/Desktop/homework/devops-netology/08-ansible-05-testing/vector$
```

Тестирование Ubuntu
```
ret@test-netology:~/Desktop/homework/devops-netology/08-ansible-05-testing/vector$ molecule test -s ubuntu_lastest
WARNING  Driver docker does not provide a schema.
INFO     ubuntu_lastest scenario test matrix: dependency, cleanup, destroy, syntax, create, prepare, converge, idempotence, side_effect, verify, cleanup, destroy
INFO     Performing prerun with role_name_check=0...
INFO     Using /home/ret/.ansible/roles/my_namespace.vector symlink to current repository in order to enable Ansible to find the role using its expected full name.
INFO     Running ubuntu_lastest > dependency
WARNING  Skipping, missing the requirements file.
WARNING  Skipping, missing the requirements file.
INFO     Running ubuntu_lastest > cleanup
WARNING  Skipping, cleanup playbook not configured.
INFO     Running ubuntu_lastest > destroy
INFO     Sanity checks: 'docker'

PLAY [Destroy] *****************************************************************

TASK [Set async_dir for HOME env] **********************************************
ok: [localhost]

TASK [Destroy molecule instance(s)] ********************************************
changed: [localhost] => (item=instance)

TASK [Wait for instance(s) deletion to complete] *******************************
FAILED - RETRYING: [localhost]: Wait for instance(s) deletion to complete (300 retries left).
ok: [localhost] => (item=instance)

TASK [Delete docker networks(s)] ***********************************************
skipping: [localhost]

PLAY RECAP *********************************************************************
localhost                  : ok=3    changed=1    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0

INFO     Running ubuntu_lastest > syntax

playbook: /home/ret/Desktop/homework/devops-netology/08-ansible-05-testing/vector/molecule/ubuntu_lastest/converge.yml
INFO     Running ubuntu_lastest > create

PLAY [Create] ******************************************************************

TASK [Set async_dir for HOME env] **********************************************
ok: [localhost]

TASK [Log into a Docker registry] **********************************************
skipping: [localhost] => (item=None) 
skipping: [localhost]

TASK [Check presence of custom Dockerfiles] ************************************
ok: [localhost] => (item={'image': 'docker.io/pycontribs/ubuntu:latest', 'name': 'instance', 'pre_build_image': True})

TASK [Create Dockerfiles from image names] *************************************
skipping: [localhost] => (item={'image': 'docker.io/pycontribs/ubuntu:latest', 'name': 'instance', 'pre_build_image': True}) 
skipping: [localhost]

TASK [Synchronization the context] *********************************************
skipping: [localhost] => (item={'image': 'docker.io/pycontribs/ubuntu:latest', 'name': 'instance', 'pre_build_image': True}) 
skipping: [localhost]

TASK [Discover local Docker images] ********************************************
ok: [localhost] => (item={'changed': False, 'skipped': True, 'skip_reason': 'Conditional result was False', 'false_condition': 'not item.pre_build_image | default(false)', 'item': {'image': 'docker.io/pycontribs/ubuntu:latest', 'name': 'instance', 'pre_build_image': True}, 'ansible_loop_var': 'item', 'i': 0, 'ansible_index_var': 'i'})

TASK [Build an Ansible compatible image (new)] *********************************
skipping: [localhost] => (item=molecule_local/docker.io/pycontribs/ubuntu:latest) 
skipping: [localhost]

TASK [Create docker network(s)] ************************************************
skipping: [localhost]

TASK [Determine the CMD directives] ********************************************
ok: [localhost] => (item={'image': 'docker.io/pycontribs/ubuntu:latest', 'name': 'instance', 'pre_build_image': True})

TASK [Create molecule instance(s)] *********************************************
changed: [localhost] => (item=instance)

TASK [Wait for instance(s) creation to complete] *******************************
FAILED - RETRYING: [localhost]: Wait for instance(s) creation to complete (300 retries left).
FAILED - RETRYING: [localhost]: Wait for instance(s) creation to complete (299 retries left).
FAILED - RETRYING: [localhost]: Wait for instance(s) creation to complete (298 retries left).
FAILED - RETRYING: [localhost]: Wait for instance(s) creation to complete (297 retries left).
changed: [localhost] => (item={'failed': 0, 'started': 1, 'finished': 0, 'ansible_job_id': 'j585126599959.21119', 'results_file': '/home/ret/.ansible_async/j585126599959.21119', 'changed': True, 'item': {'image': 'docker.io/pycontribs/ubuntu:latest', 'name': 'instance', 'pre_build_image': True}, 'ansible_loop_var': 'item'})

PLAY RECAP *********************************************************************
localhost                  : ok=6    changed=2    unreachable=0    failed=0    skipped=5    rescued=0    ignored=0

INFO     Running ubuntu_lastest > prepare
WARNING  Skipping, prepare playbook not configured.
INFO     Running ubuntu_lastest > converge

PLAY [Converge] ****************************************************************

TASK [Gathering Facts] *********************************************************
ok: [instance]

TASK [Include vector] **********************************************************

TASK [vector : Vector | install Vector distrib | CentOS] ***********************
skipping: [instance]

TASK [vector : Vector | install Vector distrib | Ubuntu] ***********************
changed: [instance]

TASK [vector : Vector/Template config] *****************************************
changed: [instance]

TASK [vector : Vector/Create systemd unit] *************************************
changed: [instance]

TASK [vector : Vector | Start service] *****************************************
skipping: [instance]

PLAY RECAP *********************************************************************
instance                   : ok=4    changed=3    unreachable=0    failed=0    skipped=2    rescued=0    ignored=0

INFO     Running ubuntu_lastest > idempotence

PLAY [Converge] ****************************************************************

TASK [Gathering Facts] *********************************************************
ok: [instance]

TASK [Include vector] **********************************************************

TASK [vector : Vector | install Vector distrib | CentOS] ***********************
skipping: [instance]

TASK [vector : Vector | install Vector distrib | Ubuntu] ***********************
ok: [instance]

TASK [vector : Vector/Template config] *****************************************
ok: [instance]

TASK [vector : Vector/Create systemd unit] *************************************
ok: [instance]

TASK [vector : Vector | Start service] *****************************************
skipping: [instance]

PLAY RECAP *********************************************************************
instance                   : ok=4    changed=0    unreachable=0    failed=0    skipped=2    rescued=0    ignored=0

INFO     Idempotence completed successfully.
INFO     Running ubuntu_lastest > side_effect
WARNING  Skipping, side effect playbook not configured.
INFO     Running ubuntu_lastest > verify
INFO     Running Ansible Verifier

PLAY [Verify] ******************************************************************

TASK [Get Vector version] ******************************************************
ok: [instance]

TASK [Assert Vector instalation] ***********************************************
ok: [instance] => {
    "changed": false,
    "msg": "All assertions passed"
}

TASK [Validate vector config file] *********************************************
ok: [instance]

TASK [Assert Vector validate config] *******************************************
ok: [instance] => {
    "changed": false,
    "msg": "All assertions passed"
}

PLAY RECAP *********************************************************************
instance                   : ok=4    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0

INFO     Verifier completed successfully.
INFO     Running ubuntu_lastest > cleanup
WARNING  Skipping, cleanup playbook not configured.
INFO     Running ubuntu_lastest > destroy

PLAY [Destroy] *****************************************************************

TASK [Set async_dir for HOME env] **********************************************
ok: [localhost]

TASK [Destroy molecule instance(s)] ********************************************
changed: [localhost] => (item=instance)

TASK [Wait for instance(s) deletion to complete] *******************************
FAILED - RETRYING: [localhost]: Wait for instance(s) deletion to complete (300 retries left).
changed: [localhost] => (item=instance)

TASK [Delete docker networks(s)] ***********************************************
skipping: [localhost]

PLAY RECAP *********************************************************************
localhost                  : ok=3    changed=2    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0

INFO     Pruning extra files from scenario ephemeral directory
ret@test-netology:~/Desktop/homework/devops-netology/08-ansible-05-testing/vector$ 

```

[TaG 1.0.1](https://github.com/ChuckBartowski13/vector-role/releases/tag/ver-1.0.1)

### Tox

1. Добавьте в директорию с vector-role файлы из [директории](./example).
2. Запустите `docker run --privileged=True -v <path_to_repo>:/opt/vector-role -w /opt/vector-role -it aragast/netology:latest /bin/bash`, где path_to_repo — путь до корня репозитория с vector-role на вашей файловой системе.
3. Внутри контейнера выполните команду `tox`, посмотрите на вывод.
5. Создайте облегчённый сценарий для `molecule` с драйвером `molecule_podman`. Проверьте его на исполнимость.
6. Пропишите правильную команду в `tox.ini`, чтобы запускался облегчённый сценарий.
8. Запустите команду `tox`. Убедитесь, что всё отработало успешно.
9. Добавьте новый тег на коммит с рабочим сценарием в соответствии с семантическим версионированием.


Cоздан отдельный сценарий тестирования centos-podman на основе образа Centos 7.

tox.ini
```
[tox]
minversion = 1.8
basepython = python3.6
envlist = py{37}-ansible{210}
skipsdist = true

[testenv]
passenv = *
deps =
    -r tox-requirements.txt
    ansible210: ansible<3.0
commands =
    {posargs:molecule test -s centos-podman --destroy always}
```
tox-requirements.txt
```
selinux
ansible-lint==5.1.3
yamllint==1.26.3
lxml
molecule==3.5.2
molecule_podman
jmespath
```
Вывод tox в контейнере

```
ret@test-netology:~/Desktop/test3/vector-role$ docker run --privileged=True -v ~/Desktop/test3/vector:/opt/vector -w /opt/vector -it aragast/netology:latest /bin/bash
[root@eefdca864ded vector]# tox
py37-ansible210 installed: ansible==2.10.7,ansible-base==2.10.17,ansible-compat==1.0.0,ansible-lint==5.1.3,arrow==1.2.3,bcrypt==4.0.1,binaryornot==0.4.4,bracex==2.3.post1,cached-property==1.5.2,Cerberus==1.3.5,certifi==2023.7.22,cffi==1.15.1,chardet==5.2.0,charset-normalizer==3.3.1,click==8.1.7,click-help-colors==0.9.2,cookiecutter==2.4.0,cryptography==41.0.5,distro==1.8.0,enrich==1.2.7,idna==3.4,importlib-metadata==6.7.0,Jinja2==3.1.2,jmespath==1.0.1,lxml==4.9.3,markdown-it-py==2.2.0,MarkupSafe==2.1.3,mdurl==0.1.2,molecule==3.5.2,molecule-podman==1.1.0,packaging==23.2,paramiko==2.12.0,pathspec==0.11.2,pluggy==1.2.0,pycparser==2.21,Pygments==2.16.1,PyNaCl==1.5.0,python-dateutil==2.8.2,python-slugify==8.0.1,PyYAML==5.4.1,requests==2.31.0,rich==13.6.0,ruamel.yaml==0.18.2,ruamel.yaml.clib==0.2.8,selinux==0.2.1,six==1.16.0,subprocess-tee==0.3.5,tenacity==8.2.3,text-unidecode==1.3,typing_extensions==4.7.1,urllib3==2.0.7,wcmatch==8.4.1,yamllint==1.26.3,zipp==3.15.0
py37-ansible210 run-test-pre: PYTHONHASHSEED='1606737019'
py37-ansible210 run-test: commands[0] | molecule test -s centos-podman --destroy always
INFO     centos-podman scenario test matrix: dependency, lint, cleanup, destroy, syntax, create, prepare, converge, idempotence, side_effect, verify, cleanup, destroy
INFO     Performing prerun...
INFO     Set ANSIBLE_LIBRARY=/root/.cache/ansible-compat/8e33c6/modules:/root/.ansible/plugins/modules:/usr/share/ansible/plugins/modules
INFO     Set ANSIBLE_COLLECTIONS_PATH=/root/.cache/ansible-compat/8e33c6/collections:/root/.ansible/collections:/usr/share/ansible/collections
INFO     Set ANSIBLE_ROLES_PATH=/root/.cache/ansible-compat/8e33c6/roles:/root/.ansible/roles:/usr/share/ansible/roles:/etc/ansible/roles
INFO     Running centos-podman > dependency
WARNING  Skipping, missing the requirements file.
WARNING  Skipping, missing the requirements file.
INFO     Running centos-podman > lint
INFO     Lint is disabled.
INFO     Running centos-podman > cleanup
WARNING  Skipping, cleanup playbook not configured.
INFO     Running centos-podman > destroy
INFO     Sanity checks: 'podman'

PLAY [Destroy] *****************************************************************

TASK [Destroy molecule instance(s)] ********************************************
changed: [localhost] => (item={'image': 'docker.io/pycontribs/centos:7', 'name': 'instance', 'pre_build_image': True})

TASK [Wait for instance(s) deletion to complete] *******************************
changed: [localhost] => (item={'started': 1, 'finished': 0, 'ansible_job_id': '157914147782.979', 'results_file': '/root/.ansible_async/157914147782.979', 'changed': True, 'failed': False, 'item': {'image': 'docker.io/pycontribs/centos:7', 'name': 'instance', 'pre_build_image': True}, 'ansible_loop_var': 'item'})

PLAY RECAP *********************************************************************
localhost                  : ok=2    changed=2    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0

INFO     Running centos-podman > syntax

playbook: /opt/vector/molecule/centos-podman/converge.yml
INFO     Running centos-podman > create

PLAY [Create] ******************************************************************

TASK [get podman executable path] **********************************************
ok: [localhost]

TASK [save path to executable as fact] *****************************************
ok: [localhost]

TASK [Log into a container registry] *******************************************
skipping: [localhost] => (item="instance registry username: None specified") 

TASK [Check presence of custom Dockerfiles] ************************************
ok: [localhost] => (item=Dockerfile: None specified)

TASK [Create Dockerfiles from image names] *************************************
skipping: [localhost] => (item="Dockerfile: None specified; Image: docker.io/pycontribs/centos:7") 

TASK [Discover local Podman images] ********************************************
ok: [localhost] => (item=instance)

TASK [Build an Ansible compatible image] ***************************************
skipping: [localhost] => (item=docker.io/pycontribs/centos:7) 

TASK [Determine the CMD directives] ********************************************
ok: [localhost] => (item="instance command: None specified")

TASK [Remove possible pre-existing containers] *********************************
changed: [localhost]

TASK [Discover local podman networks] ******************************************
skipping: [localhost] => (item=instance: None specified) 

TASK [Create podman network dedicated to this scenario] ************************
skipping: [localhost]

TASK [Create molecule instance(s)] *********************************************
changed: [localhost] => (item=instance)

TASK [Wait for instance(s) creation to complete] *******************************
FAILED - RETRYING: Wait for instance(s) creation to complete (300 retries left).
FAILED - RETRYING: Wait for instance(s) creation to complete (299 retries left).
FAILED - RETRYING: Wait for instance(s) creation to complete (298 retries left).
changed: [localhost] => (item=instance)

PLAY RECAP *********************************************************************
localhost                  : ok=8    changed=3    unreachable=0    failed=0    skipped=5    rescued=0    ignored=0

INFO     Running centos-podman > prepare
WARNING  Skipping, prepare playbook not configured.
INFO     Running centos-podman > converge

PLAY [Converge] ****************************************************************

TASK [Gathering Facts] *********************************************************
ok: [instance]

TASK [Include vector] **********************************************************

TASK [vector : Vector | install Vector distrib | CentOS] ***********************
changed: [instance]

TASK [vector : Vector | install Vector distrib | Ubuntu] ***********************
skipping: [instance]

TASK [vector : Vector/Template config] *****************************************
[WARNING]: The value "0" (type int) was converted to "u'0'" (type string). If
this does not look like what you expect, quote the entire value to ensure it
does not change.
changed: [instance]

TASK [vector : Vector/Create systemd unit] *************************************
changed: [instance]

TASK [vector : Vector | Start service] *****************************************
skipping: [instance]

PLAY RECAP *********************************************************************
instance                   : ok=4    changed=3    unreachable=0    failed=0    skipped=2    rescued=0    ignored=0

INFO     Running centos-podman > idempotence

PLAY [Converge] ****************************************************************

TASK [Gathering Facts] *********************************************************
ok: [instance]

TASK [Include vector] **********************************************************

TASK [vector : Vector | install Vector distrib | CentOS] ***********************
ok: [instance]

TASK [vector : Vector | install Vector distrib | Ubuntu] ***********************
skipping: [instance]

TASK [vector : Vector/Template config] *****************************************
[WARNING]: The value "0" (type int) was converted to "u'0'" (type string). If
this does not look like what you expect, quote the entire value to ensure it
does not change.
ok: [instance]

TASK [vector : Vector/Create systemd unit] *************************************
ok: [instance]

TASK [vector : Vector | Start service] *****************************************
skipping: [instance]

PLAY RECAP *********************************************************************
instance                   : ok=4    changed=0    unreachable=0    failed=0    skipped=2    rescued=0    ignored=0

INFO     Idempotence completed successfully.
INFO     Running centos-podman > side_effect
WARNING  Skipping, side effect playbook not configured.
INFO     Running centos-podman > verify
INFO     Running Ansible Verifier

PLAY [Verify] ******************************************************************

TASK [Get Vector version] ******************************************************
ok: [instance]

TASK [Assert Vector instalation] ***********************************************
ok: [instance] => {
    "changed": false,
    "msg": "All assertions passed"
}

TASK [Validate vector config file] *********************************************
ok: [instance]

TASK [Assert Vector validate config] *******************************************
ok: [instance] => {
    "changed": false,
    "msg": "All assertions passed"
}

PLAY RECAP *********************************************************************
instance                   : ok=4    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0

INFO     Verifier completed successfully.
INFO     Running centos-podman > cleanup
WARNING  Skipping, cleanup playbook not configured.
INFO     Running centos-podman > destroy

PLAY [Destroy] *****************************************************************

TASK [Destroy molecule instance(s)] ********************************************
changed: [localhost] => (item={'image': 'docker.io/pycontribs/centos:7', 'name': 'instance', 'pre_build_image': True})

TASK [Wait for instance(s) deletion to complete] *******************************
FAILED - RETRYING: Wait for instance(s) deletion to complete (300 retries left).
FAILED - RETRYING: Wait for instance(s) deletion to complete (299 retries left).
changed: [localhost] => (item={'started': 1, 'finished': 0, 'ansible_job_id': '21055008785.3464', 'results_file': '/root/.ansible_async/21055008785.3464', 'changed': True, 'failed': False, 'item': {'image': 'docker.io/pycontribs/centos:7', 'name': 'instance', 'pre_build_image': True}, 'ansible_loop_var': 'item'})

PLAY RECAP *********************************************************************
localhost                  : ok=2    changed=2    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0

INFO     Pruning extra files from scenario ephemeral directory
______________________________________________________________________ summary _______________________________________________________________________
  py37-ansible210: commands succeeded
  congratulations :)
[root@eefdca864ded vector]# 

```
[TaG 1.0.2](https://github.com/ChuckBartowski13/vector-role/releases/tag/ver-1.0.2)

