Role Name
=========

Vector role

Requirements
------------

-

Role Variables
--------------
You can specify a particular version.
```yaml
vector_version: "0.21.2"
```
You can manage download URL.
```yaml
vector_url: https://packages.timber.io/vector/{{ vector_version }}/vector-{{ vector_version }}-1.x86_64.rpm
```
You can cange log settings.
```yaml
vector_config:
  sources:
    our_log:
      type: file
      read_from: beginning
      ignore_older_secs: 600
      include:
      - /var/log/**/*.log
```
You can manage connection to lighthouse server.
```yaml
sinks:
    to_clickhouse:
      type: clickhouse
      inputs:
        - our_log
      database: logs
      endpoint: http://{{ hostvars['clickhouse-01']['ansible_default_ipv4']['address'] }}:8123
      table: table
      compression: gzip
      healthcheck: false
      skip_unknown_fields: true
```

Dependencies
------------

-

Example Playbook
----------------

    - hosts: servers
      roles:
         - vector

License
-------

MIT

Author Information
------------------

Churilov Aleksandr
