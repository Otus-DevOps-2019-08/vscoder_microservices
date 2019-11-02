# vscoder_microservices
vscoder microservices repository

# Makefile

## Переменные

| variable               | default | description                                                              |
| ---------------------- | ------- | ------------------------------------------------------------------------ |
| BIN_DIR                | ~/bin   | Путь для установки исполняемых файлов для целей `install_docker_machine` |
| TEMP_DIR               | /tmp    | Временная директория для загрузки файлов                                 |
| DOCKER_MACHINE_VERSION | v0.16.0 | Версия docker-machine                                                    |
| DOCKER_MACHINE_BASEURL |
| DOCKER_MACHINE_OS      |
| DOCKER_MACHINE_ARCH    |
| DOCKER_MACHINE         |

## Цели

| target                 | used variables | description |
| ---------------------- | -------------- | ----------- |
| debug                  |
| install_requirements   |
| install_docker_machine |

# Домашние задания

## HomeWork 12: Технология контейнеризации. Введение в Docker

### Подготовка проекта. Интеграции

* Склонирован репозиторий [Otus-DevOps-2019-08/vscoder_microservices
](https://github.com/Otus-DevOps-2019-08/vscoder_microservices)
* Выполнена интеграция со slack:
  * workspace `devops-team-otus.slack.com`
  * В чате aleksey_koloskov выполнена команда `/github subscribe Otus-DevOps-2019-08/vscoder_microservices commits:all`
* Настроены уведомления в slack от travis-ci
  * В клиенте: _+ Add apps_ -> _Travis-CI_ -> _Settings_ -> _Add to Slack_
  * В [.travis.yml](.travis.yml) настроены уведомления по инструкции с открывшейся страницы
    ```yaml
    notifications:
      slack: slackchannel:faketoken
    ```
* Добавлен [.gitignore](.gitignore)
* Добавлен Makefile. Цели:
  * install_requirements
  * install_docker_machine

### Установка docker

* Установлен docker как описано в документации https://docs.docker.com/engine/installation/linux/docker-ce/ubuntu/
  <details><summary>docker version</summary>
  <p>

  ```
  Client: Docker Engine - Community
   Version:           19.03.4
   API version:       1.40
   Go version:        go1.12.10
   Git commit:        9013bf583a
   Built:             Fri Oct 18 15:54:09 2019
   OS/Arch:           linux/amd64
   Experimental:      false

  Server: Docker Engine - Community
   Engine:
    Version:          19.03.4
    API version:      1.40 (minimum version 1.12)
    Go version:       go1.12.10
    Git commit:       9013bf583a
    Built:            Fri Oct 18 15:52:40 2019
    OS/Arch:          linux/amd64
    Experimental:     false
   containerd:
    Version:          1.2.10
    GitCommit:        b34a5c8af56e510852c35414db4c1f4fa6172339
   runc:
    Version:          1.0.0-rc8+dev
    GitCommit:        3e425f80a8c931f88e6d94a8c831b9d5aa481657
   docker-init:
    Version:          0.18.0
    GitCommit:        fec3683
  ```

  </p>
  </details>
  <br>
  <details><summary>docker info</summary>
  <p>

  ```
  Client:
   Debug Mode: false

  Server:
   Containers: 0
    Running: 0
    Paused: 0
    Stopped: 0
   Images: 0
   Server Version: 19.03.4
   Storage Driver: overlay2
    Backing Filesystem: extfs
    Supports d_type: true
    Native Overlay Diff: true
   Logging Driver: json-file
   Cgroup Driver: cgroupfs
   Plugins:
    Volume: local
    Network: bridge host ipvlan macvlan null overlay
    Log: awslogs fluentd gcplogs gelf journald json-file local logentries splunk syslog
   Swarm: inactive
   Runtimes: runc
   Default Runtime: runc
   Init Binary: docker-init
   containerd version: b34a5c8af56e510852c35414db4c1f4fa6172339
   runc version: 3e425f80a8c931f88e6d94a8c831b9d5aa481657
   init version: fec3683
   Security Options:
    apparmor
    seccomp
     Profile: default
   Kernel Version: 5.0.0-32-generic
   Operating System: Ubuntu 18.04.3 LTS
   OSType: linux
   Architecture: x86_64
   CPUs: 12
   Total Memory: 31.28GiB
   Name: vsc-home
   ID: RPZE:O6VJ:2IMK:H4GU:AGV7:BHBM:C5HT:MI5X:GYSH:MHZ5:BWDV:HHUC
   Docker Root Dir: /var/lib/docker
   Debug Mode: false
   Registry: https://index.docker.io/v1/
   Labels:
   Experimental: false
   Insecure Registries:
    127.0.0.0/8
   Live Restore Enabled: false

  WARNING: No swap limit support
  ```

  </p>
  </details>
  <br>
  <details><summary>docker run hello-world</summary>
  <p>

  ```
  Unable to find image 'hello-world:latest' locally
  latest: Pulling from library/hello-world
  1b930d010525: Pull complete 
  Digest: sha256:c3b4ada4687bbaa170745b3e4dd8ac3f194ca95b2d0518b417fb47e5879d9b5f
  Status: Downloaded newer image for hello-world:latest

  Hello from Docker!
  This message shows that your installation appears to be working correctly.

  To generate this message, Docker took the following steps:
   1. The Docker client contacted the Docker daemon.
   2. The Docker daemon pulled the "hello-world" image from the Docker Hub.
      (amd64)
   3. The Docker daemon created a new container from that image which runs the
      executable that produces the output you are currently reading.
   4. The Docker daemon streamed that output to the Docker client, which sent it
      to your terminal.

  To try something more ambitious, you can run an Ubuntu container with:
   $ docker run -it ubuntu bash

  Share images, automate workflows, and more with a free Docker ID:
   https://hub.docker.com/

  For more examples and ideas, visit:
   https://docs.docker.com/get-started/
  ```

  </p>
  </details>
* Установлен docker-compose в [./venv](.venv)
  ```shell
  docker-compose version 1.24.1, build 4667896
  ```
* Установлен бинарник `docker-machine`
  ```shell
  docker-machine version 0.16.0, build 702c267f
  ```
