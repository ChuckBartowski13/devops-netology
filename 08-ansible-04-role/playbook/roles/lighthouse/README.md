Role Name
=========

Lighthouse role

Requirements
------------

Role include nginx server installation.

Role Variables
--------------
You can change download URL.
```yaml
lighthouse_vcs: https://github.com/vkcom/lighthouse
```
You can cange location directory.
```yaml
lighthouse_location_dir: /home/ps/lighthouse
```
You can change nginx user name.
```yaml
nginx_user_name: root
```

Dependencies
------------

-

Example Playbook
----------------

    - hosts: servers
      roles:
         - lighthouse

License
-------

MIT

Author Information
------------------

Churilov Aleksandr
