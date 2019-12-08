reddit-monolith-docker
======================

This role deploy "{{ app_image_url }}:{{ app_image_tga }}" docker container

Requirements
------------

Docker must be installed on target system

Role Variables
--------------

| variable                                                                                     | default                            | description                                                                                           |
| -------------------------------------------------------------------------------------------- | ---------------------------------- | ----------------------------------------------------------------------------------------------------- |
| app_container_name                                                                           | reddit-app                         | container name                                                                                        |
| app_image_url                                                                                | vscoder/otus-reddit                | image url (may be galaxy image name)                                                                  |
| app_image_tag                                                                                | 1.0                                | image tag                                                                                             |
| app_container_labels                                                                         | { role: reddit-monolith }          | docker container labels dictionary                                                                    |
| app_memory_swap                                                                              | `{{ ansible_memtotal_mb * 0.8 }}M` | memory+swap limit                                                                                     |
| app_memory                                                                                   | `{{ ansible_memtotal_mb * 0.8 }}M` | memory limit                                                                                          |
| app_oom_score_adj                                                                            | omit                               | an integer value containing the score given to the container in order to tune OOM killer preferences. |
| app_ports                                                                                    | `["9292"]`                         |
| list of ports to publish from the container to the host (unused if `app_network_mode: host`) |
| app_pull                                                                                     | yes                                | if true, always pull the latest version of an image                                                   |
| app_recreate                                                                                 | no                                 | force the re-creation of an container                                                                 |
| app_restart                                                                                  | no                                 | force a container to be stopped and restarted                                                         |
| app_docker_debug                                                                             | no                                 | debug mode                                                                                            |

Dependencies
------------

None

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables
passed in as parameters) is always nice for users too:

    - hosts: servers
      roles:
         - { role: reddit-monolith-docker }

License
-------

BSD

Author Information
------------------

Aleksey Koloskov <vsyscoder@gmail.com>
