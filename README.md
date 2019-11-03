# vscoder_microservices

vscoder microservices repository

# Makefile

## Переменные

| variable               | default                    | description                                                              |
| ---------------------- | -------------------------- | ------------------------------------------------------------------------ |
| BIN_DIR                | ~/bin                      | Путь для установки исполняемых файлов для целей `install_docker_machine` |
| TEMP_DIR               | /tmp                       | Временная директория для загрузки файлов                                 |
| DOCKER_MACHINE_VERSION | v0.16.0                    | Версия docker-machine                                                    |
| DOCKER_MACHINE_OS      | \$(shell uname -s)         | Название операционной системы                                            |
| DOCKER_MACHINE_ARCH    | \$(shell uname -m)         | Название архитектуры                                                     |
| DOCKER_MACHINE         | \${BIN_DIR}/docker-machine | Путь к исполняемому файлу `docker-machine`                               |

## Цели

| target                 | used variables                                                    | description                                                                                        |
| ---------------------- | ----------------------------------------------------------------- | -------------------------------------------------------------------------------------------------- |
| debug                  | все                                                               | Показать значения всех переменных                                                                  |
| install_requirements   | нет                                                               | Установить в python virualenv [./venv](./venv) зависимости из [requirements.txt](requirements.txt) |
| install_docker_machine | DOCKER_MACHINE_BASEURL, DOCKER_MACHINE_VERSION, TEMP_DIR, BIN_DIR | Скачать и установить в `${BIN_DIR}` исполняемый файл `docker-machine`                              |

# Домашние задания

## HomeWork 12: Технология контейнеризации. Введение в Docker

### Подготовка проекта. Интеграции

- Склонирован репозиторий [Otus-DevOps-2019-08/vscoder_microservices
  ](https://github.com/Otus-DevOps-2019-08/vscoder_microservices)
- Выполнена интеграция со slack:
  - workspace `devops-team-otus.slack.com`
  - В чате aleksey_koloskov выполнена команда `/github subscribe Otus-DevOps-2019-08/vscoder_microservices commits:all`
- Настроены уведомления в slack от travis-ci
  - В клиенте: _+ Add apps_ -> _Travis-CI_ -> _Settings_ -> _Add to Slack_
  - В [.travis.yml](.travis.yml) настроены уведомления по инструкции с открывшейся страницы
    ```yaml
    notifications:
      slack: slackchannel:faketoken
    ```
- Добавлен [.gitignore](.gitignore)
- Добавлен Makefile. Цели:
  - install_requirements
  - install_docker_machine

### Установка docker

- Установлен docker как описано в документации https://docs.docker.com/engine/installation/linux/docker-ce/ubuntu/

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

- Установлен docker-compose в [./venv](.venv)
  ```shell
  docker-compose version 1.24.1, build 4667896
  ```
- Установлен бинарник `docker-machine`
  ```shell
  docker-machine version 0.16.0, build 702c267f
  ```

### Работа с docker

- Список основных команд docker
  | Команда                                                                       | Описание                                                                                                                                            |
  | ----------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------- |
  | docker ps                                                                     | Список запущенных контейнеров                                                                                                                       |
  | docker ps -a                                                                  | Список всех контейнеров                                                                                                                             |
  | docker images                                                                 | Список локально сохранённых образов                                                                                                                 |
  | docker run -it ubuntu:16.04 /bin/bash                                         | Запустить `/bin/bash` в контейнере ubuntu:16:04. Каждый раз создаётся новый контейнер. Без флага `--rm` остановленный контейнер останется на диске. |
  | docker ps -a --format "table {{.ID}}\t{{.Image}}\t{{.CreatedAt}}\t{{.Names}}" | Список всех контейнеров. Выводятся таблица с указанными столбцами                                                                                   |
  | docker start <u_container_id>                                                 | Запустить ранее остановленный контейнер                                                                                                             | docker attach <u_container_id> | Подключить терминал к созданному контейнеру. Для отключения нажать `CTRL+p` `CTRL+q` |
  | docker create                                                                 | Создать контейнер, не запуская его                                                                                                                  |
  | docker exec -it <u_container_id> bash                                         | Запустить новый процесс внутри контейнера                                                                                                           |
  | docker commit <u_container_id> yourname/ubuntu-tmp-file                       | Создать образ yourname/ubuntu-tmp-file из контейнера <u_container_id>. Контейнер при этом останется запущенным.                                     |
- Примечание _docker run = docker create + docker start + docker attach\*_ \* _docker attach_ выполняется при наличии опции `-i`
- Основный опции
  | Опция        | Описание                                                   |
  | ------------ | ---------------------------------------------------------- |
  | -i           | запускает контейнер в foreground режиме (docker attach)    |
  | -d           | запускает контейнер в background режиме                    |
  | -t           | создает TTY                                                |
  | --entrypoint | позволяет переопределить ENTRYPOINT при запуске контейнера |
- После выполнения команд из ДЗ, список образов сохранён в [docker-monolith/docker-1.log](docker-monolith/docker-1.log)

### Задание со \*: Отличия образа и контейнера

* Сылки по теме:
  * An Image is an ordered collection of root filesystem changes and the corresponding execution parameters for use within a container runtime.
  * [About storage drivers](https://docs.docker.com/storage/storagedriver/)
  * [How the overlay2 driver works](https://docs.docker.com/storage/storagedriver/overlayfs-driver/#how-the-overlay2-driver-works)
  * [Docker Image Specification v1.2.0. Image JSON Field Descriptions](https://github.com/docker/docker-ce/blob/master/components/engine/image/spec/v1.2.md)
  * [Образы и контейнеры Docker в картинках](https://habr.com/en/post/272145/)
  * [What to Inspect When You're Inspecting](https://www.ctl.io/developers/blog/post/what-to-inspect-when-youre-inspecting)
  * [Engine API v1.24](https://docs.docker.com/engine/api/v1.24/)
  * [Подключение контейнера к нескольким сетям](https://success.docker.com/article/multiple-docker-networks)
* Произведён анализ результатов вывода команды `docker inspect <u_image_id>`.
  <details><summary>Результаты</summary>
  <p>

  ```json
  [
    {
      "Id": "sha256:5f2bf26e35249d8b47f002045c57b2ea9d8ba68704f45f3c209182a7a2a9ece5",  # SHA256 hash of its configuration JSON
      "RepoTags": [  # Список тегов образа
        "ubuntu:16.04"
      ],
      "RepoDigests": [  # Чексумма образа
        "ubuntu@sha256:bb5b48c7750a6a8775c74bcb601f7e5399135d0a06de004d000e05fd25c1a71c"
      ],
      "Parent": "",  # ID вышестоящего слоя в хранилище образов. Пуст в связи с отсутствием родительских слоёв в локальном хранилище. Подробнее: https://stackoverflow.com/questions/45820905/docker-image-inspection-json-interpretation Документация: https://docs.docker.com/storage/storagedriver/
      "Comment": "",  # Комментарий
      "Created": "2019-10-31T22:21:29.640561379Z",  # Дата создания образа
      "Container": "363288fa6924e2d1e1b00da6525ffde40bb0de65b1da6ce6e44e363df532614e",  # Временный идентификатор контейнера, созданного во время сборки образа. Docker will create a container during the image construction process, and this identifier is stored in the image data.
      "ContainerConfig": {  # This data again is referring to the temporary container created when the Docker build command was executed
        "Hostname": "363288fa6924",
        "Domainname": "",
        "User": "",
        "AttachStdin": false,
        "AttachStdout": false,
        "AttachStderr": false,
        "Tty": false,
        "OpenStdin": false,
        "StdinOnce": false,
        "Env": [
          "PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
        ],
        "Cmd": [
          "/bin/sh",
          "-c",
          "#(nop) ",
          "CMD [\"/bin/bash\"]"
        ],
        "ArgsEscaped": true,
        "Image": "sha256:66d791e2304a4caa9fda9b56ad9fff2679e7b933c83d23fca8e3ec3b5595c4dc",
        "Volumes": null,
        "WorkingDir": "",
        "Entrypoint": null,
        "OnBuild": null,
        "Labels": {}
      },
      "DockerVersion": "18.06.1-ce",  # Версия docker, используемая при сборке образа
      "Author": "",  # Автор образа
      "Config": {  # Конфигурационные параметры, которые должны быть взяты за основу при запуске контейнера на основе данного образа. Судя по документации, все эти параметры можно переопределить при создании контейнера
        "Hostname": "",
        "Domainname": "",
        "User": "",  # Пользователь запускаемого контейнера по-умолчанию
        "AttachStdin": false,
        "AttachStdout": false,
        "AttachStderr": false,
        "Tty": false,
        "OpenStdin": false,
        "StdinOnce": false,
        "Env": [  # Переменные окружения
          "PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
        ],
        "Cmd": [  # CMD по умолчанию
          "/bin/bash"
        ],
        "ArgsEscaped": true,
        "Image": "sha256:66d791e2304a4caa9fda9b56ad9fff2679e7b933c83d23fca8e3ec3b5595c4dc",
        "Volumes": null,  # Тома по-умолчанию
        "WorkingDir": "",  # Рабочая директория по-умолчанию
        "Entrypoint": null,  # ENTRYPOINT по-умолчанию
        "OnBuild": null,
        "Labels": null
      },
      "Architecture": "amd64",  # Архитектура, для которой созданы бинарные файлы образа [i386, amd64, arm]
      "Os": "linux",  # Название ОС, в которой должен запускаться образ
      "Size": 122564827,
      "VirtualSize": 122564827,  # The size of the image reported in bytes
      "GraphDriver": { # https://docs.docker.com/storage/storagedriver/select-storage-driver/
        "Data": {  # https://stackoverflow.com/a/56551786/3488348
          "LowerDir": "/var/lib/docker/overlay2/897edb9e383005a310bb7685eda9b259c5c0b7740d2d65e7d1c44f228dc73ce9/diff:/var/lib/docker/overlay2/bc1b6b3a839591c8870d5aa8ad328af83c5325b82a88163986a0186b11016921/diff:/var/lib/docker/overlay2/11810c8b5bbff1b9b14089bcef62d0029a39ae0686c51a5ce0e616e71f2573bf/diff",
          "MergedDir": "/var/lib/docker/overlay2/8dac1ac5277e9c3bf4e3d7111d947bf2f4553dd85764077b0ed057d3e1b93022/merged",
          "UpperDir": "/var/lib/docker/overlay2/8dac1ac5277e9c3bf4e3d7111d947bf2f4553dd85764077b0ed057d3e1b93022/diff",
          "WorkDir": "/var/lib/docker/overlay2/8dac1ac5277e9c3bf4e3d7111d947bf2f4553dd85764077b0ed057d3e1b93022/work"
        },
        "Name": "overlay2" # https://docs.docker.com/storage/storagedriver/overlayfs-driver/#how-the-overlay2-driver-works
      },
      "RootFS": {  # Ссылается на адреса содержимого слоёв, используемых образом
        "Type": "layers",
        "Layers": [
          "sha256:788b17b748c23d38ec62e913e87b084b7e3efda49843b3c0809b1857559b553e",
          "sha256:a5a5f8c62487121247923a4df970f2094725ac2fea8c1347236466c4a3265ae0",
          "sha256:903669ee720750938f08f95f7c8f1022d7fd7c57602af847b316f0b39efbd01c",
          "sha256:bc72fb2e7b7487b3b9f9135437319525feaf1fab6ba61dab7e2e961e5c1dbb8b"
        ]
      },
      "Metadata": {  # Метаданные
        "LastTagTime": "0001-01-01T00:00:00Z"
      }
    }
  ]
  
  ```

  </p>
  </details>
* Произведён анализ вывода команды `docker inspect <u_container_id>`
  <details><summary>Результаты</summary>
    <p>

  ```json
  [
      {
          "Id": "03a9eea159ef6e417a2e67802c5fa021f4a8d0b634ba377cd0074d6ff5eef511",
          "Created": "2019-11-02T16:08:06.723203393Z",  # Дата создания контейнера
          "Path": "bash",
          "Args": [],
          "State": {  # Описание статуса контейнера
              "Status": "running",  # Текущее состояние
              "Running": true,  # Запущен?
              "Paused": false,  # Приостановлен?
              "Restarting": false,  # Перезапускается?
              "OOMKilled": false,  # Убит OOM-киллером?
              "Dead": false,  # Упал (умер)?
              "Pid": 25711,  # ID процесса контейнера в host os
              "ExitCode": 0,  # Кот завершения (используется для перезапуска после падения)
              "Error": "",  # Ошибка в случае падения
              "StartedAt": "2019-11-02T16:08:07.16481008Z",  # Время запуска
              "FinishedAt": "0001-01-01T00:00:00Z"  # Время завершения
          },
          "Image": "sha256:5f2bf26e35249d8b47f002045c57b2ea9d8ba68704f45f3c209182a7a2a9ece5",  # ID образа, на базе которого создан контейнер
          "ResolvConfPath": "/var/lib/docker/containers/03a9eea159ef6e417a2e67802c5fa021f4a8d0b634ba377cd0074d6ff5eef511/resolv.conf",
          "HostnamePath": "/var/lib/docker/containers/03a9eea159ef6e417a2e67802c5fa021f4a8d0b634ba377cd0074d6ff5eef511/hostname",
          "HostsPath": "/var/lib/docker/containers/03a9eea159ef6e417a2e67802c5fa021f4a8d0b634ba377cd0074d6ff5eef511/hosts",
          "LogPath": "/var/lib/docker/containers/03a9eea159ef6e417a2e67802c5fa021f4a8d0b634ba377cd0074d6ff5eef511/03a9eea159ef6e417a2e67802c5fa021f4a8d0b634ba377cd0074d6ff5eef511-json.log",
          "Name": "/wonderful_blackwell",  # Имя контейнера. Генериться случайным образом, если не задано явно
          "RestartCount": 0,  # Количество перезапусков. Используется для https://docs.docker.com/engine/reference/commandline/run/#restart-policies---restart
          "Driver": "overlay2",
          "Platform": "linux",
          "MountLabel": "",
          "ProcessLabel": "",
          "AppArmorProfile": "docker-default",
          "ExecIDs": null,
          "HostConfig": {  # Конфигурация хост-системы
              "Binds": null,
              "ContainerIDFile": "",
              "LogConfig": {  # Настройки логгирования
                  "Type": "json-file",
                  "Config": {}
              },
              "NetworkMode": "default",  # Sets the networking mode for the container. Supported standard values are: bridge, host, none, and container:<name|id>. Any other value is taken as a custom network’s name to which this container should connect to.
              "PortBindings": {},  # Пробросы портов
              "RestartPolicy": {  # Политика перезапуска https://docs.docker.com/engine/reference/commandline/run/#restart-policies---restart
                  "Name": "no",
                  "MaximumRetryCount": 0
              },
              "AutoRemove": false,  # Автоматически удалять контейнер после установки
              "VolumeDriver": "",  # Driver that this container users to mount volumes.
              "VolumesFrom": null,  # A list of volumes to inherit from another container. Specified in the form <container name>[:<ro|rw>]
              "CapAdd": null,  # A list of kernel capabilities added to the container.
              "CapDrop": null,  # A list of kernel capabilities dropped from the container.
              "Capabilities": null,
              "Dns": [],  # dns-сервера, используемые контейнером
              "DnsOptions": [],
              "DnsSearch": [],
              "ExtraHosts": null,  # Дополнительные записи в /etc/hosts
              "GroupAdd": null,  # A list of additional groups that the container process will run as
              "IpcMode": "private",
              "Cgroup": "",
              "Links": null,  # A list of links for the container. Each link entry is in the form of container_name:alias.
              "OomScoreAdj": 0,  # An integer value containing the score given to the container in order to tune OOM killer preferences.
              "PidMode": "",  # Set the PID (Process) Namespace mode for the container; "container:<name|id>": joins another container’s PID namespace "host": use the host’s PID namespace inside the container
              "Privileged": false,  # Контейнер запущен в привилегированном режиме https://docs.docker.com/engine/reference/run/#runtime-privilege-and-linux-capabilities
              "PublishAllPorts": false,  # Allocates an ephemeral host port for all of a container’s exposed ports. Specified as a boolean value. Ports are de-allocated when the container stops and allocated when the container starts. The allocated port might be changed when restarting the container.
              "ReadonlyRootfs": false,  # Файловая система контейнера смонтирована только для чтения
              "SecurityOpt": null,  # A list of string values to customize labels for MLS systems, such as SELinux.
              "UTSMode": "",
              "UsernsMode": "",  # Sets the usernamespace mode for the container when usernamespace remapping option is enabled. supported values are: host.
              "ShmSize": 67108864,  # Size of /dev/shm in bytes. The size must be greater than 0. If omitted the system uses 64MB.
              "Runtime": "runc",  # Используемый рантайм
              "ConsoleSize": [
                  0,
                  0
              ],
              "Isolation": "",  # isolation=(default	process	hyperv) (Windows daemon only)
              "CpuShares": 0,  # An integer value containing the container’s CPU Shares (ie. the relative weight vs other containers).
              "Memory": 0,  # Memory limit in bytes.
              "NanoCpus": 0,
              "CgroupParent": "",  # Path to cgroups under which the container’s cgroup is created. If the path is not absolute, the path is considered to be relative to the cgroups path of the init process. Cgroups are created if they do not already exist.
              "BlkioWeight": 0,  # Block IO weight (relative weight) accepts a weight value between 10 and 1000.
              "BlkioWeightDevice": [],
              "BlkioDeviceReadBps": null,
              "BlkioDeviceWriteBps": null,
              "BlkioDeviceReadIOps": null,
              "BlkioDeviceWriteIOps": null,
              "CpuPeriod": 0,  # The length of a CPU period in microseconds.
              "CpuQuota": 0,  # Microseconds of CPU time that the container can get in a CPU period.
              "CpuRealtimePeriod": 0,
              "CpuRealtimeRuntime": 0,
              "CpusetCpus": "",  # String value containing the cgroups CpusetCpus to use.
              "CpusetMems": "",  # Memory nodes (MEMs) in which to allow execution (0-3, 0,1). Only effective on NUMA systems.
              "Devices": [],  # A list of devices to add to the container specified as a JSON object in the form { "PathOnHost": "/dev/deviceName", "PathInContainer": "/dev/deviceName", "CgroupPermissions": "mrw"}
              "DeviceCgroupRules": null,
              "DeviceRequests": null,
              "KernelMemory": 0,  # Kernel memory limit in bytes.
              "KernelMemoryTCP": 0,
              "MemoryReservation": 0,  # Memory soft limit in bytes.
              "MemorySwap": 0,  # Total memory limit (memory + swap); -1 is unlimited swap. You must use this with memory and make the swap value larger than memory.
              "MemorySwappiness": null,  # Tune a container’s memory swappiness behavior. Integer between 0 and 100.
              "OomKillDisable": false,  # Boolean value, whether to disable OOM Killer for the container or not.
              "PidsLimit": null,  # A container’s pids limit. -1 if unlimited.
              "Ulimits": null,  # A list of ulimits to set in the container, specified as { "Name": <name>, "Soft": <soft limit>, "Hard": <hard limit> }, for example: Ulimits: { "Name": "nofile", "Soft": 1024, "Hard": 2048 }
              "CpuCount": 0,
              "CpuPercent": 0,  # An integer value containing the usable percentage of the available CPUs. (Windows daemon only)
              "IOMaximumIOps": 0,  # Maximum IO absolute rate in terms of bytes per second.
              "IOMaximumBandwidth": 0,  # Maximum IO absolute rate in terms of IOps.
              "MaskedPaths": [
                  "/proc/asound",
                  "/proc/acpi",
                  "/proc/kcore",
                  "/proc/keys",
                  "/proc/latency_stats",
                  "/proc/timer_list",
                  "/proc/timer_stats",
                  "/proc/sched_debug",
                  "/proc/scsi",
                  "/sys/firmware"
              ],
              "ReadonlyPaths": [
                  "/proc/bus",
                  "/proc/fs",
                  "/proc/irq",
                  "/proc/sys",
                  "/proc/sysrq-trigger"
              ]
          },
          "GraphDriver": {
              "Data": {
                  "LowerDir": "/var/lib/docker/overlay2/7ebf817bfc93f412448a4e804d2f149b25d4072c6985ab185216648194786889-init/diff:/var/lib/docker/overlay2/8dac1ac5277e9c3bf4e3d7111d947bf2f4553dd85764077b0ed057d3e1b93022/diff:/var/lib/docker/overlay2/897edb9e383005a310bb7685eda9b259c5c0b7740d2d65e7d1c44f228dc73ce9/diff:/var/lib/docker/overlay2/bc1b6b3a839591c8870d5aa8ad328af83c5325b82a88163986a0186b11016921/diff:/var/lib/docker/overlay2/11810c8b5bbff1b9b14089bcef62d0029a39ae0686c51a5ce0e616e71f2573bf/diff",
                  "MergedDir": "/var/lib/docker/overlay2/7ebf817bfc93f412448a4e804d2f149b25d4072c6985ab185216648194786889/merged",
                  "UpperDir": "/var/lib/docker/overlay2/7ebf817bfc93f412448a4e804d2f149b25d4072c6985ab185216648194786889/diff",
                  "WorkDir": "/var/lib/docker/overlay2/7ebf817bfc93f412448a4e804d2f149b25d4072c6985ab185216648194786889/work"
              },
              "Name": "overlay2"  # https://docs.docker.com/storage/storagedriver/overlayfs-driver/#how-the-overlay2-driver-works
          },
          "Mounts": [],  # Specification for mounts that was added to containers created as part of the service.
          "Config": {
              "Hostname": "03a9eea159ef",  # Имя хоста
              "Domainname": "",  # Домен
              "User": "",  # Пользователь внутри контейнера
              "AttachStdin": true,  # Attached to stdin
              "AttachStdout": true,  # Attached to stdout
              "AttachStderr": true,  # Attached to stderr
              "Tty": true,  # Standart streams attached to tty
              "OpenStdin": true,
              "StdinOnce": true,
              "Env": [  # A list of environment variables in the form of ["VAR=value", ...]
                  "PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
              ],
              "Cmd": [  # CMD runned in container
                  "bash"
              ],
              "Image": "ubuntu:16.04",  # Имя образа контейнера
              "Volumes": null,  # An object mapping mount point paths (strings) inside the container to empty objects.
              "WorkingDir": "",  #  string specifying the working directory for commands to run in.
              "Entrypoint": null,  # ENTRYPOINT of a container
              "OnBuild": null,
              "Labels": {}  # A map of labels of a container
          },
          "NetworkSettings": {  # Настройки сети контейнера.
              "Bridge": "",
              "SandboxID": "b8b58bb4f3a477aca4a6d05ee397e6cb62859afa30d8806e64e8e8e130af9e05",
              "HairpinMode": false,  # https://en.wikipedia.org/wiki/Hairpinning
              "LinkLocalIPv6Address": "",
              "LinkLocalIPv6PrefixLen": 0,
              "Ports": {},  #  Mapped ports
              "SandboxKey": "/var/run/docker/netns/b8b58bb4f3a4",
              "SecondaryIPAddresses": null,
              "SecondaryIPv6Addresses": null,
              "EndpointID": "e7f60af3ade6a1ecba41456c0f3252f8edd502287c826a214c6318ef74f8efdf",
              "Gateway": "172.17.0.1",  # Network gateway
              "GlobalIPv6Address": "",
              "GlobalIPv6PrefixLen": 0,
              "IPAddress": "172.17.0.2",  # Container's ip address
              "IPPrefixLen": 16,
              "IPv6Gateway": "",
              "MacAddress": "02:42:ac:11:00:02",  # mac-address
              "Networks": {  # Сети и контейнера
                  "bridge": {
                      "IPAMConfig": null,
                      "Links": null,
                      "Aliases": null,
                      "NetworkID": "156780e8135120a2650a4d34c2a0aee35cd4d3cde3d98fb0e3b1ebfd3a797bfd",
                      "EndpointID": "e7f60af3ade6a1ecba41456c0f3252f8edd502287c826a214c6318ef74f8efdf",
                      "Gateway": "172.17.0.1",
                      "IPAddress": "172.17.0.2",
                      "IPPrefixLen": 16,
                      "IPv6Gateway": "",
                      "GlobalIPv6Address": "",
                      "GlobalIPv6PrefixLen": 0,
                      "MacAddress": "02:42:ac:11:00:02",
                      "DriverOpts": null
                  }
              }
          }
      }
  ]
  ```

  </p>
  </details>
* В файле [docker-monolith/docker-1.log](docker-monolith/docker-1.log) описаны различия между образом и контейнером

### Больше docker-команд

#### Docker kill & stop

Подробнее про [Сигналы в Linux](https://ru.wikipedia.org/wiki/Сигналы_(UNIX))

Описание:
* kill сразу посылает SIGKILL
* stop посылает SIGTERM, и через 10 секунд(настраивается) посылает SIGKILL
* SIGTERM - сигнал остановки приложения
* SIGKILL - безусловное завершение процесса

Практика:
* `docker ps -q`
  ```log
  cc75429464ba
  03a9eea159ef
  ```
* `docker kill cc75429464ba`
  ```log
  cc75429464ba
  ```
* `docker ps -q` - остался один запущенный контейнер
  ```log
  03a9eea159ef
  ```

#### docker system df

* Отображает сколько дискового пространства занято образами, контейнерами и volume’ами
* Отображает сколько из них не используется и возможно удалить

`docker system df`
```log
TYPE                TOTAL               ACTIVE              SIZE                RECLAIMABLE
Images              4                   3                   248.8MB             122.6MB (49%)
Containers          5                   1                   15B                 9B (60%)
Local Volumes       0                   0                   0B                  0B
Build Cache         0                   0                   0B                  0B
```

#### Docker rm & rmi

* rm удаляет контейнер, можно добавить флаг -f, чтобы удалялся работающий container(будет послан sigkill)
* rmi удаляет image, если от него не зависят запущенные контейнеры

`docker rm $(docker ps -a -q)` # удалит все незапущенные контейнеры
```log
cc75429464ba
5d9a698c4c62
2cf9183503e2
89716fceca99
Error response from daemon: You cannot remove a running container 03a9eea159ef6e417a2e67802c5fa021f4a8d0b634ba377cd0074d6ff5eef511. Stop the container before attempting removal or force remove
```

`docker rmi $(docker images -q)`
```log
Untagged: vscoder/ubuntu-tmp-file:latest
Deleted: sha256:e63bb81dd3f064fb9fe854a1e66ca76e30c79fbc54eb9f09c5ab054a8d0d8cd3
Untagged: nginx:latest
Untagged: nginx@sha256:922c815aa4df050d4df476e92daed4231f466acc8ee90e0e774951b0fd7195a4
Deleted: sha256:540a289bab6cb1bf880086a9b803cf0c4cefe38cbb5cdefa199b69614525199f
Deleted: sha256:ab18af7cee69bfb22c1771e54d5e0e68b1a1bf57bb46516142da0380b1771f4a
Deleted: sha256:02f7daf1e14541cd61a3dda1a61cc0f78fee8de2984d488b8ba5bbd3cbad9b57
Deleted: sha256:b67d19e65ef653823ed62a5835399c610a40e8205c16f839c5cc567954fcf594
Untagged: hello-world:latest
Untagged: hello-world@sha256:c3b4ada4687bbaa170745b3e4dd8ac3f194ca95b2d0518b417fb47e5879d9b5f
Deleted: sha256:fce289e99eb9bca977dae136fbe2a82b6b7d4c372474c9235adc1741675f587e
Deleted: sha256:af0b15c8625bb1938f1d7b17081031f649fd14e6b233688eea3c5483994a66a3
Error response from daemon: conflict: unable to delete 5f2bf26e3524 (cannot be forced) - image is being used by running container 03a9eea159ef
```


### Docker контейнеры

#### GCE

* Создан новый проект _docker_ id `docker-257914`
* gcloud SDK установлен ранее
* Выполнен `gcloud init` с созданием новой конфигурации _otus-devops-docker_
* Выполнен `gcloud auth application-default login` чтобы получить файл с авторизационными данными для docker-machine.
  Файл сохранён по пути `/home/<myuser>/.config/gcloud/application_default_credentials.json`

#### Docker machine

Установка в Linux https://docs.docker.com/machine/install-machine/

* docker-machine - встроенный в докер инструмент для создания хостов и установки на них docker engine. Имеет поддержку облаков и систем виртуализации (Virtualbox, GCP и др.)
* Команда создания - `docker-machine create <имя>`. Имен может быть много, переключение между ними через `eval $(docker-machine env <имя>)`. Переключение на локальный докер - `eval $(docker-machine env --unset)`. Удаление - `docker-machine rm <имя>`.
* docker-machine создает хост для докер демона со указываемым образом в --googlemachine-image, в ДЗ используется ubuntu-16.04. Образы которые используются для построения докер контейнеров к этому никак не относятся.
* Все докер команды, которые запускаются в той же консоли после `eval $(docker-machine env <имя>)` работают с удаленным докер демоном в GCP.

* Создан файл [env](env) с переменными окружения, необходимыми для работы с docker-machine
* Для проекта разрешено использование API как было сказано при первой попытке создать машину
* Создана машина
  ```shell
  docker-machine create --driver google \
  --google-machine-image https://www.googleapis.com/compute/v1/projects/ubuntu-os-cloud/global/images/family/ubuntu-1604-lts \
  --google-machine-type n1-standard-1 \
  --google-zone europe-west1-b \
  docker-host
  ```
  ```log
  Running pre-create checks...
  (docker-host) Check that the project exists
  (docker-host) Check if the instance already exists
  Creating machine...
  (docker-host) Generating SSH Key
  (docker-host) Creating host...
  (docker-host) Opening firewall ports
  (docker-host) Creating instance
  (docker-host) Waiting for Instance
  (docker-host) Uploading SSH Key
  Waiting for machine to be running, this may take a few minutes...
  Detecting operating system of created instance...
  Waiting for SSH to be available...
  Detecting the provisioner...
  Provisioning with ubuntu(systemd)...
  Installing Docker...
  Copying certs to the local machine directory...
  Copying certs to the remote machine...
  Setting Docker configuration on the remote daemon...
  Checking connection to Docker...
  Docker is up and running!
  To see how to connect your Docker Client to the Docker Engine running on this virtual machine, run: docker-machine env docker-host
  ```
* docker-machine успешно создана `docker-machine ls`
  ```log
  NAME          ACTIVE   DRIVER   STATE     URL                        SWARM   DOCKER     ERRORS
  docker-host   -        google   Running   tcp://34.76.188.197:2376           v19.03.4
  ```
* Выполнено переключение на созданную машину `eval $(docker-machine env docker-host)`
