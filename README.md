# vscoder_microservices

[![Build Status](https://travis-ci.com/Otus-DevOps-2019-08/vscoder_microservices.svg?branch=master)](https://travis-ci.com/Otus-DevOps-2019-08/vscoder_microservices)

vscoder microservices repository

- [vscoder_microservices](#vscodermicroservices)
- [Makefile](#makefile)
  - [Переменные](#%d0%9f%d0%b5%d1%80%d0%b5%d0%bc%d0%b5%d0%bd%d0%bd%d1%8b%d0%b5)
  - [Цели](#%d0%a6%d0%b5%d0%bb%d0%b8)
- [Домашние задания](#%d0%94%d0%be%d0%bc%d0%b0%d1%88%d0%bd%d0%b8%d0%b5-%d0%b7%d0%b0%d0%b4%d0%b0%d0%bd%d0%b8%d1%8f)
  - [HomeWork 12: Технология контейнеризации. Введение в Docker](#homework-12-%d0%a2%d0%b5%d1%85%d0%bd%d0%be%d0%bb%d0%be%d0%b3%d0%b8%d1%8f-%d0%ba%d0%be%d0%bd%d1%82%d0%b5%d0%b9%d0%bd%d0%b5%d1%80%d0%b8%d0%b7%d0%b0%d1%86%d0%b8%d0%b8-%d0%92%d0%b2%d0%b5%d0%b4%d0%b5%d0%bd%d0%b8%d0%b5-%d0%b2-docker)
    - [Подготовка проекта. Интеграции](#%d0%9f%d0%be%d0%b4%d0%b3%d0%be%d1%82%d0%be%d0%b2%d0%ba%d0%b0-%d0%bf%d1%80%d0%be%d0%b5%d0%ba%d1%82%d0%b0-%d0%98%d0%bd%d1%82%d0%b5%d0%b3%d1%80%d0%b0%d1%86%d0%b8%d0%b8)
    - [Установка docker](#%d0%a3%d1%81%d1%82%d0%b0%d0%bd%d0%be%d0%b2%d0%ba%d0%b0-docker)
    - [Работа с docker](#%d0%a0%d0%b0%d0%b1%d0%be%d1%82%d0%b0-%d1%81-docker)
    - [Задание со \*: Отличия образа и контейнера](#%d0%97%d0%b0%d0%b4%d0%b0%d0%bd%d0%b8%d0%b5-%d1%81%d0%be--%d0%9e%d1%82%d0%bb%d0%b8%d1%87%d0%b8%d1%8f-%d0%be%d0%b1%d1%80%d0%b0%d0%b7%d0%b0-%d0%b8-%d0%ba%d0%be%d0%bd%d1%82%d0%b5%d0%b9%d0%bd%d0%b5%d1%80%d0%b0)
    - [Больше docker-команд](#%d0%91%d0%be%d0%bb%d1%8c%d1%88%d0%b5-docker-%d0%ba%d0%be%d0%bc%d0%b0%d0%bd%d0%b4)
      - [Docker kill & stop](#docker-kill--stop)
      - [docker system df](#docker-system-df)
      - [Docker rm & rmi](#docker-rm--rmi)
    - [Docker контейнеры](#docker-%d0%ba%d0%be%d0%bd%d1%82%d0%b5%d0%b9%d0%bd%d0%b5%d1%80%d1%8b)
      - [GCE](#gce)
      - [Docker machine](#docker-machine)
      - [Работа с namespaces](#%d0%a0%d0%b0%d0%b1%d0%be%d1%82%d0%b0-%d1%81-namespaces)
        - [PID namespace](#pid-namespace)
        - [NET namespace](#net-namespace)
        - [USER namespace](#user-namespace)
      - [Dockerfile](#dockerfile)
      - [Запуск контейнера](#%d0%97%d0%b0%d0%bf%d1%83%d1%81%d0%ba-%d0%ba%d0%be%d0%bd%d1%82%d0%b5%d0%b9%d0%bd%d0%b5%d1%80%d0%b0)
    - [Docker hub](#docker-hub)
    - [Задание со \*: IaC с использованием docker](#%d0%97%d0%b0%d0%b4%d0%b0%d0%bd%d0%b8%d0%b5-%d1%81%d0%be--iac-%d1%81-%d0%b8%d1%81%d0%bf%d0%be%d0%bb%d1%8c%d0%b7%d0%be%d0%b2%d0%b0%d0%bd%d0%b8%d0%b5%d0%bc-docker)
      - [Packer](#packer)
      - [Terraform](#terraform)
        - [Project-wide объекты](#project-wide-%d0%be%d0%b1%d1%8a%d0%b5%d0%ba%d1%82%d1%8b)
        - [Модули](#%d0%9c%d0%be%d0%b4%d1%83%d0%bb%d0%b8)
        - [Stage-окружение](#stage-%d0%be%d0%ba%d1%80%d1%83%d0%b6%d0%b5%d0%bd%d0%b8%d0%b5)
      - [Запуск контейнера средствами ansible](#%d0%97%d0%b0%d0%bf%d1%83%d1%81%d0%ba-%d0%ba%d0%be%d0%bd%d1%82%d0%b5%d0%b9%d0%bd%d0%b5%d1%80%d0%b0-%d1%81%d1%80%d0%b5%d0%b4%d1%81%d1%82%d0%b2%d0%b0%d0%bc%d0%b8-ansible)
    - [Вне ДЗ: безопасность](#%d0%92%d0%bd%d0%b5-%d0%94%d0%97-%d0%b1%d0%b5%d0%b7%d0%be%d0%bf%d0%b0%d1%81%d0%bd%d0%be%d1%81%d1%82%d1%8c)
      - [TODO:](#todo)
      - [Docker Security Benchmark](#docker-security-benchmark)
  - [HomeWork 13: Docker-образы и Микросервисы](#homework-13-docker-%d0%be%d0%b1%d1%80%d0%b0%d0%b7%d1%8b-%d0%b8-%d0%9c%d0%b8%d0%ba%d1%80%d0%be%d1%81%d0%b5%d1%80%d0%b2%d0%b8%d1%81%d1%8b)
    - [Подготовка](#%d0%9f%d0%be%d0%b4%d0%b3%d0%be%d1%82%d0%be%d0%b2%d0%ba%d0%b0)
      - [Dockerfile best practices (collapsed)](#dockerfile-best-practices-collapsed)
        - [FROM](#from)
        - [LABEL](#label)
        - [RUN](#run)
        - [CMD](#cmd)
        - [EXPOSE](#expose)
        - [ENV](#env)
        - [ADD or COPY](#add-or-copy)
        - [ENTRYPOINT](#entrypoint)
        - [VOLUME](#volume)
        - [USER](#user)
        - [WORKDIR](#workdir)
        - [ONBUILD](#onbuild)
    - [Запуск](#%d0%97%d0%b0%d0%bf%d1%83%d1%81%d0%ba)
      - [Новая структура приложения](#%d0%9d%d0%be%d0%b2%d0%b0%d1%8f-%d1%81%d1%82%d1%80%d1%83%d0%ba%d1%82%d1%83%d1%80%d0%b0-%d0%bf%d1%80%d0%b8%d0%bb%d0%be%d0%b6%d0%b5%d0%bd%d0%b8%d1%8f)
      - [Сборка образов](#%d0%a1%d0%b1%d0%be%d1%80%d0%ba%d0%b0-%d0%be%d0%b1%d1%80%d0%b0%d0%b7%d0%be%d0%b2)
      - [Запуск приложения](#%d0%97%d0%b0%d0%bf%d1%83%d1%81%d0%ba-%d0%bf%d1%80%d0%b8%d0%bb%d0%be%d0%b6%d0%b5%d0%bd%d0%b8%d1%8f)
    - [Задание со \*: Переопределение сетевых алиасов](#%d0%97%d0%b0%d0%b4%d0%b0%d0%bd%d0%b8%d0%b5-%d1%81%d0%be--%d0%9f%d0%b5%d1%80%d0%b5%d0%be%d0%bf%d1%80%d0%b5%d0%b4%d0%b5%d0%bb%d0%b5%d0%bd%d0%b8%d0%b5-%d1%81%d0%b5%d1%82%d0%b5%d0%b2%d1%8b%d1%85-%d0%b0%d0%bb%d0%b8%d0%b0%d1%81%d0%be%d0%b2)
      - [Теория](#%d0%a2%d0%b5%d0%be%d1%80%d0%b8%d1%8f)
      - [Реализация](#%d0%a0%d0%b5%d0%b0%d0%bb%d0%b8%d0%b7%d0%b0%d1%86%d0%b8%d1%8f)
    - [Образы](#%d0%9e%d0%b1%d1%80%d0%b0%d0%b7%d1%8b)
    - [Задание со \*: Уменьшаем размер образа](#%d0%97%d0%b0%d0%b4%d0%b0%d0%bd%d0%b8%d0%b5-%d1%81%d0%be--%d0%a3%d0%bc%d0%b5%d0%bd%d1%8c%d1%88%d0%b0%d0%b5%d0%bc-%d1%80%d0%b0%d0%b7%d0%bc%d0%b5%d1%80-%d0%be%d0%b1%d1%80%d0%b0%d0%b7%d0%b0)
      - [Анализ](#%d0%90%d0%bd%d0%b0%d0%bb%d0%b8%d0%b7)
      - [Сборка на основе alpine linux](#%d0%a1%d0%b1%d0%be%d1%80%d0%ba%d0%b0-%d0%bd%d0%b0-%d0%be%d1%81%d0%bd%d0%be%d0%b2%d0%b5-alpine-linux)
        - [ui](#ui)
        - [comment](#comment)
        - [post](#post)
    - [Дальнейшие действия](#%d0%94%d0%b0%d0%bb%d1%8c%d0%bd%d0%b5%d0%b9%d1%88%d0%b8%d0%b5-%d0%b4%d0%b5%d0%b9%d1%81%d1%82%d0%b2%d0%b8%d1%8f)
      - [Проверка работоспособности](#%d0%9f%d1%80%d0%be%d0%b2%d0%b5%d1%80%d0%ba%d0%b0-%d1%80%d0%b0%d0%b1%d0%be%d1%82%d0%be%d1%81%d0%bf%d0%be%d1%81%d0%be%d0%b1%d0%bd%d0%be%d1%81%d1%82%d0%b8)
      - [Создание volume для MongoDB](#%d0%a1%d0%be%d0%b7%d0%b4%d0%b0%d0%bd%d0%b8%d0%b5-volume-%d0%b4%d0%bb%d1%8f-mongodb)
    - [src/Makefile](#srcmakefile)
      - [Переменные](#%d0%9f%d0%b5%d1%80%d0%b5%d0%bc%d0%b5%d0%bd%d0%bd%d1%8b%d0%b5-1)
      - [Цели](#%d0%a6%d0%b5%d0%bb%d0%b8-1)
  - [HomeWork 14: Docker: сети, docker-compose](#homework-14-docker-%d1%81%d0%b5%d1%82%d0%b8-docker-compose)
    - [Работа с сетями в Docker](#%d0%a0%d0%b0%d0%b1%d0%be%d1%82%d0%b0-%d1%81-%d1%81%d0%b5%d1%82%d1%8f%d0%bc%d0%b8-%d0%b2-docker)
      - [Подготовка](#%d0%9f%d0%be%d0%b4%d0%b3%d0%be%d1%82%d0%be%d0%b2%d0%ba%d0%b0-1)
      - [Работа с сетью в Docker](#%d0%a0%d0%b0%d0%b1%d0%be%d1%82%d0%b0-%d1%81-%d1%81%d0%b5%d1%82%d1%8c%d1%8e-%d0%b2-docker)
        - [none](#none)
        - [host](#host)
          - [network namespaces](#network-namespaces)
        - [bridge](#bridge)
          - [Запуск приложения](#%d0%97%d0%b0%d0%bf%d1%83%d1%81%d0%ba-%d0%bf%d1%80%d0%b8%d0%bb%d0%be%d0%b6%d0%b5%d0%bd%d0%b8%d1%8f-1)
          - [Анализ](#%d0%90%d0%bd%d0%b0%d0%bb%d0%b8%d0%b7-1)
    - [Использование docker-compose](#%d0%98%d1%81%d0%bf%d0%be%d0%bb%d1%8c%d0%b7%d0%be%d0%b2%d0%b0%d0%bd%d0%b8%d0%b5-docker-compose)
      - [Установка](#%d0%a3%d1%81%d1%82%d0%b0%d0%bd%d0%be%d0%b2%d0%ba%d0%b0)
      - [docker-compose.yml](#docker-composeyml)
        - [Переменные окружения](#%d0%9f%d0%b5%d1%80%d0%b5%d0%bc%d0%b5%d0%bd%d0%bd%d1%8b%d0%b5-%d0%be%d0%ba%d1%80%d1%83%d0%b6%d0%b5%d0%bd%d0%b8%d1%8f)
        - [Имя проекта](#%d0%98%d0%bc%d1%8f-%d0%bf%d1%80%d0%be%d0%b5%d0%ba%d1%82%d0%b0)
    - [Задание со \*: docker-compose.override.yml](#%d0%97%d0%b0%d0%b4%d0%b0%d0%bd%d0%b8%d0%b5-%d1%81%d0%be--docker-composeoverrideyml)
      - [Анализ](#%d0%90%d0%bd%d0%b0%d0%bb%d0%b8%d0%b7-2)
      - [Реализация](#%d0%a0%d0%b5%d0%b0%d0%bb%d0%b8%d0%b7%d0%b0%d1%86%d0%b8%d1%8f-1)
    - [Вне заданий](#%d0%92%d0%bd%d0%b5-%d0%b7%d0%b0%d0%b4%d0%b0%d0%bd%d0%b8%d0%b9)
  - [HomeWork 15: Устройство Gitlab CI. Построение процесса непрерывной поставки](#homework-15-%d0%a3%d1%81%d1%82%d1%80%d0%be%d0%b9%d1%81%d1%82%d0%b2%d0%be-gitlab-ci-%d0%9f%d0%be%d1%81%d1%82%d1%80%d0%be%d0%b5%d0%bd%d0%b8%d0%b5-%d0%bf%d1%80%d0%be%d1%86%d0%b5%d1%81%d1%81%d0%b0-%d0%bd%d0%b5%d0%bf%d1%80%d0%b5%d1%80%d1%8b%d0%b2%d0%bd%d0%be%d0%b9-%d0%bf%d0%be%d1%81%d1%82%d0%b0%d0%b2%d0%ba%d0%b8)
    - [Развёртывание gitlab](#%d0%a0%d0%b0%d0%b7%d0%b2%d1%91%d1%80%d1%82%d1%8b%d0%b2%d0%b0%d0%bd%d0%b8%d0%b5-gitlab)
      - [Подготовка хоста](#%d0%9f%d0%be%d0%b4%d0%b3%d0%be%d1%82%d0%be%d0%b2%d0%ba%d0%b0-%d1%85%d0%be%d1%81%d1%82%d0%b0)
        - [ansible](#ansible)
        - [packer](#packer)
        - [terraform](#terraform)
      - [Развёртывание gitlab](#%d0%a0%d0%b0%d0%b7%d0%b2%d1%91%d1%80%d1%82%d1%8b%d0%b2%d0%b0%d0%bd%d0%b8%d0%b5-gitlab-1)
      - [Первоначальная настройка](#%d0%9f%d0%b5%d1%80%d0%b2%d0%be%d0%bd%d0%b0%d1%87%d0%b0%d0%bb%d1%8c%d0%bd%d0%b0%d1%8f-%d0%bd%d0%b0%d1%81%d1%82%d1%80%d0%be%d0%b9%d0%ba%d0%b0)
        - [Работа с репозиторием через ssh](#%d0%a0%d0%b0%d0%b1%d0%be%d1%82%d0%b0-%d1%81-%d1%80%d0%b5%d0%bf%d0%be%d0%b7%d0%b8%d1%82%d0%be%d1%80%d0%b8%d0%b5%d0%bc-%d1%87%d0%b5%d1%80%d0%b5%d0%b7-ssh)
    - [Создание проекта](#%d0%a1%d0%be%d0%b7%d0%b4%d0%b0%d0%bd%d0%b8%d0%b5-%d0%bf%d1%80%d0%be%d0%b5%d0%ba%d1%82%d0%b0)
      - [CI/CD Pipeline](#cicd-pipeline)
    - [Runner](#runner)
    - [тестирование Reddit](#%d1%82%d0%b5%d1%81%d1%82%d0%b8%d1%80%d0%be%d0%b2%d0%b0%d0%bd%d0%b8%d0%b5-reddit)

# Makefile

## Переменные

| variable               | default                    | description                                                              |
| ---------------------- | -------------------------- | ------------------------------------------------------------------------ |
| BIN_DIR                | ~/bin                      | Путь для установки исполняемых файлов для целей `install_docker_machine` |
| TEMP_DIR               | /tmp                       | Временная директория для загрузки файлов                                 |
| ENV                    | stage                      | Название окружения                                                       |
| DOCKER_MACHINE_VERSION | v0.16.0                    | Версия docker-machine                                                    |
| DOCKER_MACHINE_OS      | \$(shell uname -s)         | Название операционной системы                                            |
| DOCKER_MACHINE_ARCH    | \$(shell uname -m)         | Название архитектуры                                                     |
| DOCKER_MACHINE         | \${BIN_DIR}/docker-machine | Путь к исполняемому файлу `docker-machine`                               |
| DOCKER_MACHINE_NAME    | docker-host                | Имя инстанса                                                             |
| DOCKER_MACHINE_TYPE    | n1-standard-1              | Тип инстанса                                                             |
| DOCKER_MACHINE_REGION  | europe-west1-b             | Регион                                                                   |
| PACKER_VERSION         | 1.4.4                      | Версия packer                                                            |
| PACKER                 | ${BIN_DIR}/packer          | Путь к исполняемому файлу `packer`                                       |
| ANSIBLE                | ../../.venv/bin/ansible    | Путь к исполняемому файлу `ansible`                                      |
| TERRAFORM_VERSION      | 0.12.12                    | Версия terraform                                                         |
| TERRAFORM              | ${BIN_DIR}/terraform       | Путь к исполняемому файлу `terraform`                                    |
| TFLINT_VERSION         | 0.12.1                     | Версия tflist                                                            |
| TFLINT                 | ${BIN_DIR}/tflint          | Путь к исполняемому файлу `tflint`                                       |
| HADOLINT_VERSION       | 1.17.2                     | Версия hadolint (linter для Dockerfile)                                  |
| HADOLINT               | ${BIN_DIR}/hadolint        | Путь к исполняемому файлу `hadolint`                                     |
| IMAGE_VERSION          | 1.0                        | Версия docker-образа vscoder/otus-reddit для отправки на docker-hub      |

## Цели

| target                                | used variables                                                                  | description                                                                                                                                 |
| ------------------------------------- | ------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------- |
| debug                                 | все                                                                             | Показать значения всех переменных                                                                                                           |
| install_requirements                  | нет                                                                             | Установить в python virualenv [./venv](./venv) зависимости из [requirements.txt](requirements.txt)                                          |
| install_requirements_dev              | нет                                                                             | Выполнить `make install_requirements`, а так же установить зависимости из [requirements-dev.txt](requirements-dev.txt)                      |
| install_requirements_virtualenv       | нет                                                                             | Установить в python virualenv [./venv](./venv) зависимости из [requirements.txt](requirements.txt) используя пакет virtualenv (для python2) |
| install_docker_machine                | DOCKER_MACHINE_BASEURL, DOCKER_MACHINE_VERSION, TEMP_DIR, BIN_DIR               | Скачать и установить в `${BIN_DIR}` исполняемый файл `docker-machine`                                                                       |
| docker_machine_create                 | DOCKER_MACHINE, DOCKER_MACHINE_NAME, DOCKER_MACHINE_TYPE, DOCKER_MACHINE_REGION | Создать инстанс docker-machine в gce                                                                                                        |
| docker_machine_rm                     | DOCKER_MACHINE, DOCKER_MACHINE_NAME                                             | Удалить инстанс                                                                                                                             |
| install_packer                        | TEMP_DIR, PACKER_VERSION, BIN_DIR                                               | Скачать и установить бинарник packer в ${BIN_DIR}                                                                                           |
| monolith_packer_build                 | PACKER                                                                          | Собрать базовый образ из шаблона docker-monolith/packer/docker.json                                                                         |
| monolith_packer_validate              | PACKER                                                                          | Проверить корректность packer-шаблона docker-monolith/packer/docker.json                                                                    |
| install_terraform                     | TEMP_DIR, BIN_DIR, TERRAFORM_VERSION                                            | Установить terraform                                                                                                                        |
| install_tflint                        | TEMP_DIR, BIN_DIR, TFLINT_VERSION                                               | Установить tflint                                                                                                                           |
| install_hadolint                      | TEMP_DIR, BIN_DIR, HADOLINT_VERSION, HADOLINT                                   | Установить hadolint                                                                                                                         |
| monolith_terraform_init               | ENV, TERRAFORM                                                                  | Инициализировать terraform для базового окружения `${ENV}` окружения                                                                        |
| monolith_terraform_init_nobackend     | ENV, TERRAFORM                                                                  | Инициализировать terraform для окружения `${ENV}`, без инициализации remote backend. Используется в автоматизированных проверках            |
| monolith_terraform_validate           | TERRAFORM                                                                       | Выполнить валидацию всех окружений terraform                                                                                                |
| monolith_terraform_tflint             | TFLINT                                                                          | Выполнить tflint для всех окружений terraform                                                                                               |
| monolith_terraform_apply              | ENV, TERRAFORM                                                                  | Применить инфраструктуру terraform для окружения `${ENV}`                                                                                   |
| monolith_terraform_destroy            | ENV, TERRAFORM                                                                  | Уничтожить инфраструктуру terraform для окружения `${ENV}`                                                                                  |
| monolith_ansible_install_requirements | ANSIBLE                                                                         | Установить внешние роли ansible из [requirements.yml](docker-monolith/ansible/environments/stage/requirements.yml)                          |
| monolith_ansible_inventory_list       | ANSIBLE                                                                         | Показать содержимое ansible-inventory ввформате json                                                                                        |
| monolith_ansible_lint                 | ANSIBLE                                                                         | Выполнить ansible-lint для всех плейбуков                                                                                                   |
| monolith_ansible_syntax               | ANSIBLE                                                                         | Проверить синтаксис всех плейбуков                                                                                                          |
| monolith_ansible_reddit_app           | ANSIBLE, ENV                                                                    | Развернуть reddit-app в контейнере                                                                                                          |
| monolith_docker_build                 |                                                                                 | Собрать контейнер из [docker-monolith/Dockerfile](docker-monolith/Dockerfile)                                                               |
| monolith_docker_publish               | IMAGE_VERSION                                                                   | Загрузить образ `vscoder/otus-reddit:${IMAGE_VERSION}` на docker-hub                                                                        |

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
- Основные опции
  
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

#### Работа с namespaces

##### PID namespace

* По умолчанию контейнер запускается в отдельном PID namespace
  Команда `docker run --rm -ti tehbilly/htop` результатом своим показывает только запущенный процесс htop
  Команда `docker run --rm -ti ubuntu:16.04 ps auxf` возвращает похожий результат
  ```log
  USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
  root         1  0.0  0.0  25976  1456 pts/0    Rs+  18:29   0:00 ps auxf
  ```
* Запуск контейнера в PID namespace хоста
  Команда `docker run --rm --pid host -ti tehbilly/htop` возвращает все процессы хост-системы
  Команда `docker run --rm --pid host -ti ubuntu:16.04 ps auxf` возвращает похожий
  <details><summary>результат</summary>
  <p>

  ```log
  USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
  root         2  0.0  0.0      0     0 ?        S    15:27   0:00 [kthreadd]
  root         4  0.0  0.0      0     0 ?        I<   15:27   0:00  \_ [kworker/0:
  root         6  0.0  0.0      0     0 ?        I<   15:27   0:00  \_ [mm_percpu_
  root         7  0.0  0.0      0     0 ?        S    15:27   0:00  \_ [ksoftirqd/
  root         8  0.0  0.0      0     0 ?        I    15:27   0:00  \_ [rcu_sched]
  root         9  0.0  0.0      0     0 ?        I    15:27   0:00  \_ [rcu_bh]
  root        10  0.0  0.0      0     0 ?        S    15:27   0:00  \_ [migration/
  root        11  0.0  0.0      0     0 ?        S    15:27   0:00  \_ [watchdog/0
  root        12  0.0  0.0      0     0 ?        S    15:27   0:00  \_ [cpuhp/0]
  root        13  0.0  0.0      0     0 ?        S    15:27   0:00  \_ [kdevtmpfs]
  root        14  0.0  0.0      0     0 ?        I<   15:27   0:00  \_ [netns]
  root        15  0.0  0.0      0     0 ?        S    15:27   0:00  \_ [rcu_tasks_
  root        16  0.0  0.0      0     0 ?        S    15:27   0:00  \_ [kauditd]
  root        17  0.0  0.0      0     0 ?        S    15:27   0:00  \_ [khungtaskd
  root        18  0.0  0.0      0     0 ?        S    15:27   0:00  \_ [oom_reaper
  root        19  0.0  0.0      0     0 ?        I<   15:27   0:00  \_ [writeback]
  root        20  0.0  0.0      0     0 ?        S    15:27   0:00  \_ [kcompactd0
  root        21  0.0  0.0      0     0 ?        SN   15:27   0:00  \_ [ksmd]
  root        22  0.0  0.0      0     0 ?        SN   15:27   0:00  \_ [khugepaged
  root        23  0.0  0.0      0     0 ?        I<   15:27   0:00  \_ [crypto]
  root        24  0.0  0.0      0     0 ?        I<   15:27   0:00  \_ [kintegrity
  root        25  0.0  0.0      0     0 ?        I<   15:27   0:00  \_ [kblockd]
  root        26  0.0  0.0      0     0 ?        I<   15:27   0:00  \_ [ata_sff]
  root        27  0.0  0.0      0     0 ?        I<   15:27   0:00  \_ [md]
  root        28  0.0  0.0      0     0 ?        I<   15:27   0:00  \_ [edac-polle
  root        29  0.0  0.0      0     0 ?        I<   15:27   0:00  \_ [devfreq_wq
  root        30  0.0  0.0      0     0 ?        I<   15:27   0:00  \_ [watchdogd]
  root        34  0.0  0.0      0     0 ?        S    15:27   0:00  \_ [kswapd0]
  root        35  0.0  0.0      0     0 ?        I<   15:27   0:00  \_ [kworker/u3
  root        36  0.0  0.0      0     0 ?        S    15:27   0:00  \_ [ecryptfs-k
  root        78  0.0  0.0      0     0 ?        I<   15:27   0:00  \_ [kthrotld]
  root        79  0.0  0.0      0     0 ?        I<   15:27   0:00  \_ [acpi_therm
  root        80  0.0  0.0      0     0 ?        S    15:27   0:00  \_ [scsi_eh_0]
  root        81  0.0  0.0      0     0 ?        I<   15:27   0:00  \_ [scsi_tmf_0
  root        87  0.0  0.0      0     0 ?        I<   15:27   0:00  \_ [ipv6_addrc
  root        97  0.0  0.0      0     0 ?        I<   15:27   0:00  \_ [kstrp]
  root        99  0.0  0.0      0     0 ?        I<   15:27   0:00  \_ [kworker/0:
  root       115  0.0  0.0      0     0 ?        I<   15:27   0:00  \_ [charger_ma
  root       268  0.0  0.0      0     0 ?        I<   15:27   0:00  \_ [raid5wq]
  root       321  0.0  0.0      0     0 ?        S    15:27   0:00  \_ [jbd2/sda1-
  root       322  0.0  0.0      0     0 ?        I<   15:27   0:00  \_ [ext4-rsv-c
  root       393  0.0  0.0      0     0 ?        I<   15:27   0:00  \_ [iscsi_eh]
  root       403  0.0  0.0      0     0 ?        I<   15:27   0:00  \_ [ib-comp-wq
  root       404  0.0  0.0      0     0 ?        I<   15:27   0:00  \_ [ib_mcast]
  root       405  0.0  0.0      0     0 ?        I<   15:27   0:00  \_ [ib_nl_sa_w
  root       408  0.0  0.0      0     0 ?        I<   15:27   0:00  \_ [rdma_cm]
  root      7628  0.0  0.0      0     0 ?        I    17:41   0:00  \_ [kworker/u2
  root      7678  0.0  0.0      0     0 ?        I    17:44   0:00  \_ [kworker/0:
  root      8019  0.0  0.0      0     0 ?        I    18:10   0:00  \_ [kworker/0:
  root      8094  0.0  0.0      0     0 ?        I    18:15   0:00  \_ [kworker/u2
  root      8189  0.0  0.0      0     0 ?        I    18:23   0:00  \_ [kworker/u2
  root      8254  0.0  0.0      0     0 ?        I    18:27   0:00  \_ [kworker/u2
  root      8385  0.0  0.0      0     0 ?        I    18:27   0:00  \_ [kworker/0:
  root      8601  0.0  0.0      0     0 ?        I    18:29   0:00  \_ [kworker/0:
  root         1  0.0  0.1  37732  5844 ?        Ss   15:27   0:02 /sbin/init
  root       402  0.0  0.1  31808  4304 ?        Ss   15:27   0:00 /lib/systemd/sy
  root       423  0.0  0.0  94772  1580 ?        Ss   15:27   0:00 /sbin/lvmetad -
  root       449  0.0  0.1  43068  4264 ?        Ss   15:27   0:00 /lib/systemd/sy
  root       910  0.0  0.0  16120  2864 ?        Ss   15:27   0:00 /sbin/dhclient 
  root      1133  0.0  0.0   5220   148 ?        Ss   15:27   0:00 /sbin/iscsid
  root      1135  0.0  0.0   5720  3504 ?        S<Ls 15:27   0:01 /sbin/iscsid
  root      1150  0.0  0.0  28620  3024 ?        Ss   15:27   0:00 /lib/systemd/sy
  root      1169  0.0  0.1 272944  5796 ?        Ssl  15:27   0:00 /usr/lib/accoun
  root      1179  0.0  0.0  26068  2492 ?        Ss   15:27   0:00 /usr/sbin/cron 
  root      1207  0.0  0.0   4396  1304 ?        Ss   15:27   0:00 /usr/sbin/acpid
  107       1249  0.0  0.0  42892  3744 ?        Ss   15:27   0:00 /usr/bin/dbus-d
  daemon    1265  0.0  0.0  26044  2184 ?        Ss   15:27   0:00 /usr/sbin/atd -
  root      1297  0.0  0.0  95368  1524 ?        Ssl  15:27   0:00 /usr/bin/lxcfs 
  root      1312  0.0  0.0  81068  2212 ?        Ssl  15:27   0:00 /usr/sbin/sshgu
  root      1351  0.0  0.5 171696 19376 ?        Ssl  15:27   0:00 /usr/bin/python
  root      1357  0.0  0.1 277180  6020 ?        Ssl  15:27   0:00 /usr/lib/policy
  root      1406  0.0  0.0  13372   156 ?        Ss   15:27   0:00 /sbin/mdadm --m
  112       1550  0.0  0.1  40268  4840 ?        Ss   15:27   0:00 /usr/sbin/ntpd 
  root      1553  0.0  0.5  65388 21424 ?        Ss   15:27   0:00 /usr/bin/python
  root      1580  0.0  0.5  65452 21540 ?        Ss   15:27   0:01 /usr/bin/python
  root      1581  0.0  0.5  65368 21264 ?        Ss   15:27   0:00 /usr/bin/python
  root      1595  0.0  0.1  65512  6160 ?        Ss   15:27   0:00 /usr/sbin/sshd 
  root      1602  0.0  0.0  14656  1804 ?        Ss+  15:27   0:00 /sbin/agetty --
  root      1635  0.0  0.0  12840  1780 ?        Ss+  15:27   0:00 /sbin/agetty --
  root      4552  0.1  1.2 440504 46512 ?        Ssl  15:28   0:11 /usr/bin/contai
  root      9754  0.0  0.1 108976  6044 ?        Sl   18:32   0:00  \_ containerd-
  root      9784 20.0  0.0  34560  2904 pts/0    Rs+  18:32   0:00      \_ ps auxf
  root      9817  0.0  0.0      0     0 ?        Z    18:32   0:00      \_ [runc] 
  root      5528  0.0  2.9 502264 109968 ?       Ssl  15:28   0:06 /usr/bin/docker
  _apt      8014  0.0  0.0 256392  3204 ?        Ssl  18:10   0:00 /usr/sbin/rsysl
  ```

  </p>
  </details>

##### NET namespace

Нашёл статью по теме: https://platform9.com/blog/container-namespaces-deep-dive-container-networking/

* Запустил контейнер nginx `docker run --rm --name wwweb -d nginx`
* Подключился по ssh к _docker-machine_ `gcloud compute ssh docker-host`
* `docker ps`
  ```log
  CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS               NAMES
  0e2ba62df689        nginx               "nginx -g 'daemon of…"   4 seconds ago       Up 3 seconds        80/tcp              wwweb
  ```
* По умолчанию, докер не добавляет сетевые неймспейсы контейнеров в `/var/run`. Чтобы это сделать, нужно выполнить последовательность команд:
  ```shell
  CONTAINER_PID="$(docker inspect -f '{{.State.Pid}}' wwweb)"
  echo $CONTAINER_PID
  sudo mkdir -p /var/run/netns
  sudo ln -sf /proc/$CONTAINER_PID/ns/net "/var/run/netns/wwweb"
  ```
* после этого можно посмотреть и получить доступ в network namespace контейнера
  * Список неймспейсов теперь пополнился
    ```shell
    # sudo ip netns list
    wwweb (id: 0)
    ```
* ip-адреса
  * просмотр ip-адресов интерфейсов в неймспейсе
    ```shell
    # sudo ip netns exec wwweb ip addr
    1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
        link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
        inet 127.0.0.1/8 scope host lo
           valid_lft forever preferred_lft forever
    29: eth0@if30: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default 
        link/ether 02:42:ac:11:00:02 brd ff:ff:ff:ff:ff:ff link-netnsid 0
        inet 172.17.0.2/16 brd 172.17.255.255 scope global eth0
           valid_lft forever preferred_lft forever
    ```
  * Список ip-адресов внутри контейнера wwweb (предварительно пришлось установить в контейнере пакет iproute2)
    ```shell
    # docker exec -ti wwweb ip addr
    1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
        link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
        inet 127.0.0.1/8 scope host lo
           valid_lft forever preferred_lft forever
    29: eth0@if30: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default 
        link/ether 02:42:ac:11:00:02 brd ff:ff:ff:ff:ff:ff link-netnsid 0
        inet 172.17.0.2/16 brd 172.17.255.255 scope global eth0
           valid_lft forever preferred_lft forever
    ```
    Как видно, совпадает со списком внутри net namespace
  * Список ip-адресов интерфейсов хоста
    ```shell
    # ip addr
    1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
        link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
        inet 127.0.0.1/8 scope host lo
           valid_lft forever preferred_lft forever
        inet6 ::1/128 scope host 
           valid_lft forever preferred_lft forever
    2: ens4: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1460 qdisc pfifo_fast state UP group default qlen 1000
        link/ether 42:01:0a:84:00:02 brd ff:ff:ff:ff:ff:ff
        inet 10.132.0.2/32 brd 10.132.0.2 scope global ens4
           valid_lft forever preferred_lft forever
        inet6 fe80::4001:aff:fe84:2/64 scope link 
           valid_lft forever preferred_lft forever
    4: docker0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default 
        link/ether 02:42:4c:d3:0b:bb brd ff:ff:ff:ff:ff:ff
        inet 172.17.0.1/16 brd 172.17.255.255 scope global docker0
           valid_lft forever preferred_lft forever
        inet6 fe80::42:4cff:fed3:bbb/64 scope link 
           valid_lft forever preferred_lft forever
    30: veth602f36b@if29: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue master docker0 state UP group default 
        link/ether 16:c8:f2:fc:08:ce brd ff:ff:ff:ff:ff:ff link-netnsid 0
        inet6 fe80::14c8:f2ff:fefc:8ce/64 scope link 
           valid_lft forever preferred_lft forever
    ```
    Различается со списком внутри неймспейса. При этом так же есть loopback-интерфейс с именем `lo`
* Таблицы маршрутизации
  * Внутри неймспейса
    ```shell
    # sudo ip netns exec wwweb ip route
    default via 172.17.0.1 dev eth0 
    172.17.0.0/16 dev eth0  proto kernel  scope link  src 172.17.0.2
    ```
  * Внутри контейнера
    ```shell
    # docker exec -ti wwweb ip route
    default via 172.17.0.1 dev eth0 
    172.17.0.0/16 dev eth0 proto kernel scope link src 172.17.0.2
    ```
  * Список маршрутов хоста
    ```shell
    # ip route
    default via 10.132.0.1 dev ens4 
    10.132.0.1 dev ens4  scope link 
    172.17.0.0/16 dev docker0  proto kernel  scope link  src 172.17.0.1
    ```
    Таблица маршрутизации отличается
* Открытые порты
  * Внутри неймспейса
    ```shell
    # sudo ip netns exec wwweb netstat -an
    Active Internet connections (servers and established)
    Proto Recv-Q Send-Q Local Address           Foreign Address         State      
    tcp        0      0 0.0.0.0:80              0.0.0.0:*               LISTEN     
    Active UNIX domain sockets (servers and established)
    Proto RefCnt Flags       Type       State         I-Node   Path
    unix  3      [ ]         STREAM     CONNECTED     54759    
    unix  3      [ ]         STREAM     CONNECTED     54758
    ```
  * На хост-системе
    ```shell
    # netstat -an
    Active Internet connections (servers and established)
    Proto Recv-Q Send-Q Local Address           Foreign Address         State      
    tcp        0      0 0.0.0.0:22              0.0.0.0:*               LISTEN     
    tcp        0      0 10.132.0.2:47508        169.254.169.254:80      CLOSE_WAIT 
    tcp        0      0 10.132.0.2:47514        169.254.169.254:80      ESTABLISHED
    tcp        0      0 10.132.0.2:47512        169.254.169.254:80      ESTABLISHED
    tcp        0    316 10.132.0.2:22           176.62.181.4:36416      ESTABLISHED
    tcp        0      0 10.132.0.2:47510        169.254.169.254:80      ESTABLISHED
    tcp6       0      0 :::2376                 :::*                    LISTEN     
    tcp6       0      0 :::22                   :::*                    LISTEN     
    udp        0      0 0.0.0.0:68              0.0.0.0:*                          
    udp        0      0 172.17.0.1:123          0.0.0.0:*                          
    udp        0      0 10.132.0.2:123          0.0.0.0:*                          
    udp        0      0 127.0.0.1:123           0.0.0.0:*                          
    udp        0      0 0.0.0.0:123             0.0.0.0:*                          
    udp6       0      0 fe80::14c8:f2ff:fef:123 :::*                               
    udp6       0      0 fe80::42:4cff:fed3::123 :::*                               
    udp6       0      0 fe80::4001:aff:fe84:123 :::*                               
    udp6       0      0 ::1:123                 :::*                               
    udp6       0      0 :::123                  :::*                               
    ...
    ```
* Запущен контейнер с `--network host`, не использующий отдельного net namespace
  ```shell
  # docker run --rm --name wwwhost --network host -d nginx
  168c62352a51bcda9457f11480f935275202f51bab6232dd55e2edf8ee8f5245
  # docker ps
  CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS               NAMES
  168c62352a51        nginx               "nginx -g 'daemon of…"   3 seconds ago       Up 2 seconds                            wwwhost
  0e2ba62df689        nginx               "nginx -g 'daemon of…"   38 minutes ago      Up 38 minutes       80/tcp              wwweb
  ```
  * Список открытых портов на хост-системе
    ```shell
    # netstat -pan
    Active Internet connections (servers and established)
    Proto Recv-Q Send-Q Local Address           Foreign Address         State       PID/Program name
    tcp        0      0 0.0.0.0:80              0.0.0.0:*               LISTEN      13390/nginx: master
    tcp        0      0 0.0.0.0:22              0.0.0.0:*               LISTEN      1595/sshd       
    tcp        0      0 10.132.0.2:47556        169.254.169.254:80      CLOSE_WAIT  1581/python3    
    tcp        0      0 10.132.0.2:47562        169.254.169.254:80      ESTABLISHED 1581/python3    
    tcp        0      0 10.132.0.2:47560        169.254.169.254:80      ESTABLISHED 1553/python3    
    tcp        0      0 10.132.0.2:47558        169.254.169.254:80      ESTABLISHED 1580/python3    
    tcp        0    332 10.132.0.2:22           176.62.181.4:36416      ESTABLISHED 10854/sshd: vscoder
    tcp6       0      0 :::2376                 :::*                    LISTEN      5528/dockerd    
    tcp6       0      0 :::22                   :::*                    LISTEN      1595/sshd       
    udp        0      0 0.0.0.0:68              0.0.0.0:*                           910/dhclient    
    udp        0      0 172.17.0.1:123          0.0.0.0:*                           1550/ntpd       
    udp        0      0 10.132.0.2:123          0.0.0.0:*                           1550/ntpd       
    udp        0      0 127.0.0.1:123           0.0.0.0:*                           1550/ntpd       
    udp        0      0 0.0.0.0:123             0.0.0.0:*                           1550/ntpd       
    udp6       0      0 fe80::14c8:f2ff:fef:123 :::*                                1550/ntpd       
    udp6       0      0 fe80::42:4cff:fed3::123 :::*                                1550/ntpd       
    udp6       0      0 fe80::4001:aff:fe84:123 :::*                                1550/ntpd       
    udp6       0      0 ::1:123                 :::*                                1550/ntpd       
    udp6       0      0 :::123                  :::*                                1550/ntpd
    ...
    ```
    видно, что запущен процесс nginx на порту 80
  * Та же команда из контейнера
    ```shell
    # docker exec -ti wwwhost netstat -pan
    Active Internet connections (servers and established)
    Proto Recv-Q Send-Q Local Address           Foreign Address         State       PID/Program name    
    tcp        0      0 0.0.0.0:80              0.0.0.0:*               LISTEN      1/nginx: master pro 
    tcp        0      0 0.0.0.0:22              0.0.0.0:*               LISTEN      -                   
    tcp        0      0 10.132.0.2:47608        169.254.169.254:80      ESTABLISHED -                   
    tcp        0      0 10.132.0.2:35058        217.196.149.233:80      TIME_WAIT   -                   
    tcp        0      0 10.132.0.2:39352        151.101.120.204:80      TIME_WAIT   -                   
    tcp        0      0 10.132.0.2:39340        151.101.120.204:80      TIME_WAIT   -                   
    tcp        0      0 10.132.0.2:52780        130.89.148.77:80        TIME_WAIT   -                   
    tcp        0      0 10.132.0.2:47578        169.254.169.254:80      CLOSE_WAIT  -                   
    tcp        0      0 10.132.0.2:34988        149.20.4.15:80          TIME_WAIT   -                   
    tcp        0      0 10.132.0.2:39358        151.101.120.204:80      TIME_WAIT   -                   
    tcp        0      0 10.132.0.2:47594        169.254.169.254:80      ESTABLISHED -                   
    tcp        0      0 10.132.0.2:39338        151.101.120.204:80      TIME_WAIT   -                   
    tcp        0      0 10.132.0.2:39344        151.101.120.204:80      TIME_WAIT   -                   
    tcp        0      0 10.132.0.2:22           176.62.181.4:36416      ESTABLISHED -                   
    tcp        0      0 10.132.0.2:34996        149.20.4.15:80          TIME_WAIT   -                   
    tcp        0      0 10.132.0.2:34974        149.20.4.15:80          TIME_WAIT   -                   
    tcp        0      0 10.132.0.2:35072        217.196.149.233:80      TIME_WAIT   -                   
    tcp        0      0 10.132.0.2:47580        169.254.169.254:80      ESTABLISHED -                   
    tcp        0      0 10.132.0.2:39354        151.101.120.204:80      TIME_WAIT   -                   
    tcp6       0      0 :::2376                 :::*                    LISTEN      -                   
    tcp6       0      0 :::22                   :::*                    LISTEN      -                   
    udp        0      0 0.0.0.0:68              0.0.0.0:*                           -                   
    udp        0      0 172.17.0.1:123          0.0.0.0:*                           -                   
    udp        0      0 10.132.0.2:123          0.0.0.0:*                           -                   
    udp        0      0 127.0.0.1:123           0.0.0.0:*                           -                   
    udp        0      0 0.0.0.0:123             0.0.0.0:*                           -                   
    udp6       0      0 fe80::14c8:f2ff:fef:123 :::*                                -                   
    udp6       0      0 fe80::42:4cff:fed3::123 :::*                                -                   
    udp6       0      0 fe80::4001:aff:fe84:123 :::*                                -                   
    udp6       0      0 ::1:123                 :::*                                -                   
    udp6       0      0 :::123                  :::*                                -
    ...
    ```
    Видно все открытые порты хоста

* Попытка перехватить трафик
  * Создано 2 контейнера nginx
    ```shell
    docker run --rm --name wwweb1 -d nginx
    docker run --rm --name wwweb2 -d nginx
    ```
  * В контенере wwweb1 запущен периодический `curl` на wwweb2
    wwweb1:
    ```shell
    while sleep 1; do curl 172.17.0.2; done
    Ctrl+p Ctrl+q
    ```
  * На хост-системе выполнен захват пакетов на интерфейсе docker0
    <details><summary><b>tcpdump</b></summary>
    <p>

    ```shell
    # tcpdump -ni docker0 
    tcpdump: verbose output suppressed, use -v or -vv for full protocol decode
    listening on docker0, link-type EN10MB (Ethernet), capture size 262144 bytes
    19:55:33.578680 IP 172.17.0.3.54102 > 172.17.0.2.80: Flags [S], seq 2237485892, win 29200, options [mss 1460,sackOK,TS val 4136154315 ecr 0,nop,wscale 7], length 0
    19:55:33.578763 IP 172.17.0.2.80 > 172.17.0.3.54102: Flags [S.], seq 3234450953, ack 2237485893, win 28960, options [mss 1460,sackOK,TS val 1810839543 ecr 4136154315,nop,wscale 7], length 0
    19:55:33.578783 IP 172.17.0.3.54102 > 172.17.0.2.80: Flags [.], ack 1, win 229, options [nop,nop,TS val 4136154315 ecr 1810839543], length 0
    19:55:33.579042 IP 172.17.0.3.54102 > 172.17.0.2.80: Flags [P.], seq 1:75, ack 1, win 229, options [nop,nop,TS val 4136154315 ecr 1810839543], length 74: HTTP: GET / HTTP/1.1
    19:55:33.579059 IP 172.17.0.2.80 > 172.17.0.3.54102: Flags [.], ack 75, win 227, options [nop,nop,TS val 1810839543 ecr 4136154315], length 0
    19:55:33.579146 IP 172.17.0.2.80 > 172.17.0.3.54102: Flags [P.], seq 1:239, ack 75, win 227, options [nop,nop,TS val 1810839543 ecr 4136154315], length 238: HTTP: HTTP/1.1 200 OK
    19:55:33.579410 IP 172.17.0.2.80 > 172.17.0.3.54102: Flags [P.], seq 239:851, ack 75, win 227, options [nop,nop,TS val 1810839543 ecr 4136154315], length 612: HTTP
    19:55:33.582222 IP 172.17.0.3.54102 > 172.17.0.2.80: Flags [F.], seq 75, ack 851, win 247, options [nop,nop,TS val 4136154318 ecr 1810839543], length 0
    19:55:33.582351 IP 172.17.0.2.80 > 172.17.0.3.54102: Flags [F.], seq 851, ack 76, win 227, options [nop,nop,TS val 1810839546 ecr 4136154318], length 0
    19:55:33.582364 IP 172.17.0.3.54102 > 172.17.0.2.80: Flags [.], ack 852, win 247, options [nop,nop,TS val 4136154318 ecr 1810839546], length 0
    19:55:34.593306 IP 172.17.0.3.54104 > 172.17.0.2.80: Flags [S], seq 3311237005, win 29200, options [mss 1460,sackOK,TS val 4136155329 ecr 0,nop,wscale 7], length 0
    19:55:34.593393 IP 172.17.0.2.80 > 172.17.0.3.54104: Flags [S.], seq 1172657176, ack 3311237006, win 28960, options [mss 1460,sackOK,TS val 1810840557 ecr 4136155329,nop,wscale 7], length 0
    19:55:34.593414 IP 172.17.0.3.54104 > 172.17.0.2.80: Flags [.], ack 1, win 229, options [nop,nop,TS val 4136155329 ecr 1810840557], length 0
    19:55:34.593738 IP 172.17.0.3.54104 > 172.17.0.2.80: Flags [P.], seq 1:75, ack 1, win 229, options [nop,nop,TS val 4136155330 ecr 1810840557], length 74: HTTP: GET / HTTP/1.1
    19:55:34.593754 IP 172.17.0.2.80 > 172.17.0.3.54104: Flags [.], ack 75, win 227, options [nop,nop,TS val 1810840558 ecr 4136155330], length 0
    19:55:34.593911 IP 172.17.0.2.80 > 172.17.0.3.54104: Flags [P.], seq 1:239, ack 75, win 227, options [nop,nop,TS val 1810840558 ecr 4136155330], length 238: HTTP: HTTP/1.1 200 OK
    19:55:34.594329 IP 172.17.0.2.80 > 172.17.0.3.54104: Flags [P.], seq 239:851, ack 75, win 227, options [nop,nop,TS val 1810840558 ecr 4136155330], length 612: HTTP
    19:55:34.594439 IP 172.17.0.3.54104 > 172.17.0.2.80: Flags [.], ack 239, win 237, options [nop,nop,TS val 4136155330 ecr 1810840558], length 0
    19:55:34.594493 IP 172.17.0.3.54104 > 172.17.0.2.80: Flags [.], ack 851, win 247, options [nop,nop,TS val 4136155330 ecr 1810840558], length 0
    19:55:34.597087 IP 172.17.0.3.54104 > 172.17.0.2.80: Flags [F.], seq 75, ack 851, win 247, options [nop,nop,TS val 4136155333 ecr 1810840558], length 0
    19:55:34.597247 IP 172.17.0.2.80 > 172.17.0.3.54104: Flags [F.], seq 851, ack 76, win 227, options [nop,nop,TS val 1810840561 ecr 4136155333], length 0
    19:55:34.597261 IP 172.17.0.3.54104 > 172.17.0.2.80: Flags [.], ack 852, win 247, options [nop,nop,TS val 4136155333 ecr 1810840561], length 0
    19:55:35.608138 IP 172.17.0.3.54106 > 172.17.0.2.80: Flags [S], seq 3998885043, win 29200, options [mss 1460,sackOK,TS val 4136156344 ecr 0,nop,wscale 7], length 0
    19:55:35.608228 IP 172.17.0.2.80 > 172.17.0.3.54106: Flags [S.], seq 1711094452, ack 3998885044, win 28960, options [mss 1460,sackOK,TS val 1810841572 ecr 4136156344,nop,wscale 7], length 0
    19:55:35.608247 IP 172.17.0.3.54106 > 172.17.0.2.80: Flags [.], ack 1, win 229, options [nop,nop,TS val 4136156344 ecr 1810841572], length 0
    19:55:35.608587 IP 172.17.0.3.54106 > 172.17.0.2.80: Flags [P.], seq 1:75, ack 1, win 229, options [nop,nop,TS val 4136156344 ecr 1810841572], length 74: HTTP: GET / HTTP/1.1
    19:55:35.608602 IP 172.17.0.2.80 > 172.17.0.3.54106: Flags [.], ack 75, win 227, options [nop,nop,TS val 1810841573 ecr 4136156344], length 0
    19:55:35.608776 IP 172.17.0.2.80 > 172.17.0.3.54106: Flags [P.], seq 1:239, ack 75, win 227, options [nop,nop,TS val 1810841573 ecr 4136156344], length 238: HTTP: HTTP/1.1 200 OK
    19:55:35.609098 IP 172.17.0.2.80 > 172.17.0.3.54106: Flags [P.], seq 239:851, ack 75, win 227, options [nop,nop,TS val 1810841573 ecr 4136156344], length 612: HTTP
    19:55:35.609252 IP 172.17.0.3.54106 > 172.17.0.2.80: Flags [.], ack 239, win 237, options [nop,nop,TS val 4136156345 ecr 1810841573], length 0
    19:55:35.609309 IP 172.17.0.3.54106 > 172.17.0.2.80: Flags [.], ack 851, win 247, options [nop,nop,TS val 4136156345 ecr 1810841573], length 0
    19:55:35.611656 IP 172.17.0.3.54106 > 172.17.0.2.80: Flags [F.], seq 75, ack 851, win 247, options [nop,nop,TS val 4136156348 ecr 1810841573], length 0
    19:55:35.611775 IP 172.17.0.2.80 > 172.17.0.3.54106: Flags [F.], seq 851, ack 76, win 227, options [nop,nop,TS val 1810841576 ecr 4136156348], length 0
    19:55:35.611788 IP 172.17.0.3.54106 > 172.17.0.2.80: Flags [.], ack 852, win 247, options [nop,nop,TS val 4136156348 ecr 1810841576], length 0
    ^C
    34 packets captured
    36 packets received by filter
    2 packets dropped by kernel
    ```

    </p>
    </details>
    В результате видим преиодические запросы на 172.17.0.2.80 от 172.17.0.3, и ответы.
    Вывод: для диагностики может пригодиться такая возможность


##### USER namespace

Документация по теме https://docs.docker.com/engine/security/userns-remap/
Известные ограничения https://docs.docker.com/engine/security/userns-remap/#user-namespace-known-limitations

Одно из ограничений:
This re-mapping is transparent to the container, but introduces some configuration complexity in situations where the container needs access to resources on the Docker host, such as bind mounts into areas of the filesystem that the system user cannot write to.

Важно про RHEL/CentOS
The way the namespace remapping is handled on the host is using two files, `/etc/subuid` and `/etc/subgid`. These files are typically managed automatically when you add or remove users or groups, but on a few distributions such as RHEL and CentOS 7.3, you may need to manage these files manually.

Пример `/etc/subuid`:
```
testuser:231072:65536
```
This means that user-namespaced processes started by testuser are owned by host UID 231072 (which looks like UID 0 inside the namespace) through 296607 (231072 + 65536 - 1). These ranges should not overlap, to ensure that namespaced processes cannot access each other’s namespaces.

Про достуа к ресурсам `/var/lib/docker`:
Enabling userns-remap effectively masks existing image and container layers, as well as other Docker objects within /var/lib/docker/. This is because Docker needs to adjust the ownership of these resources and actually stores them in a subdirectory within /var/lib/docker/. It is best to enable this feature on a new Docker installation rather than an existing one.

Along the same lines, if you disable userns-remap you can’t access any of the resources created while it was enabled.


* В `/etc/docker/daemon.json` добавлен `userns-remap`
  ```json
  {
    "userns-remap": "testuser"
  }
  ```
* docker перезапущен `systemctl restart docker`
* автоматически создан пользователь `dockremap`
  ```shell
  # id dockremap
  uid=113(dockremap) gid=117(dockremap) groups=117(dockremap)
  # grep dockremap /etc/subuid
  dockremap:362144:65536
  # grep dockremap /etc/subgid
  dockremap:362144:65536
  ```
* ранее загруженные образы недоступны
  ```shell
  # docker image ls
  REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
  ```
* запущен контейнер `hello-world`
  ```shell
  # docker run hello-world
  Unable to find image 'hello-world:latest' locally
  latest: Pulling from library/hello-world
  1b930d010525: Pull complete 
  Digest: sha256:c3b4ada4687bbaa170745b3e4dd8ac3f194ca95b2d0518b417fb47e5879d9b5f
  Status: Downloaded newer image for hello-world:latest
  ...
  ```
  образ заново загружен
* проверка наличия namspace-директории
  ```shell
  # sudo ls -ld /var/lib/docker/362144.362144/
  drwx------ 14 362144 362144 4096 Nov  3 20:21 /var/lib/docker/362144.362144/
  ```
  и её содержимого
  ```shell
  # sudo ls -l /var/lib/docker/362144.362144/
  total 48
  drwx------ 2 root   root   4096 Nov  3 20:21 builder
  drwx--x--x 4 root   root   4096 Nov  3 20:21 buildkit
  drwx------ 3 362144 362144 4096 Nov  3 20:25 containers
  drwx------ 3 root   root   4096 Nov  3 20:21 image
  drwxr-x--- 3 root   root   4096 Nov  3 20:21 network
  drwx------ 6 362144 362144 4096 Nov  3 20:25 overlay2
  drwx------ 4 root   root   4096 Nov  3 20:21 plugins
  drwx------ 2 root   root   4096 Nov  3 20:21 runtimes
  drwx------ 2 root   root   4096 Nov  3 20:21 swarm
  drwx------ 2 362144 362144 4096 Nov  3 20:25 tmp
  drwx------ 2 root   root   4096 Nov  3 20:21 trust
  drwx------ 2 362144 362144 4096 Nov  3 20:21 volumes
  ```
* Отключить user ns для контенйера: `--userns=host`
  There is a side effect when using this flag: user remapping will not be enabled for that container but, because the read-only (image) layers are shared between containers, ownership of the the containers filesystem will still be remapped.
  What this means is that the whole container filesystem will belong to the user specified in the `--userns-remap` daemon config (362144 in the example above). This can lead to unexpected behavior of programs inside the container. For instance sudo (which checks that its binaries belong to user 0) or binaries with a setuid flag.


#### Dockerfile

* Создан конфиг MongoDB [docker-monolith/mongod.conf](docker-monolith/mongod.conf)
* Создан скрипт запуска приложения [docker-monolith/start.sh](docker-monolith/start.sh)
* Создан скрипт с переменной окружения `DBATABASE_URL` [docker-monolith/db_config](docker-monolith/db_config)

* Создан [docker-monolith/Dockerfile](docker-monolith/Dockerfile)
  * Основан на `ubuntu:16.04`
    ```dockerfile
    FROM ubuntu:16.04
    ```
  * Установка необходимых пакетов
    ```dockerfile
    RUN apt-get update
    RUN apt-get install -y mongodb-server ruby-full ruby-dev build-essential git
    RUN gem install bundler
    ```
  * Загрузка приложения
    ```dockerfile
    RUN git clone -b monolith https://github.com/express42/reddit.git
    ```
  * Копирование необходимых файлов в контейнер
    ```dockerfile
    COPY mongod.conf /etc/mongod.conf
    COPY db_config /reddit/db_config
    COPY start.sh /start.sh
    ```
  * Установка зависимостей приложения
    ```dockerfile
    RUN cd /reddit && bundle install
    RUN chmod 0777 /start.sh
    ```
  * Запуск приложения
    ```dockerfile
    CMD ["/start.sh"]
    ```

* В [Makefile](Makefile) добавлена цель, создающая инстанс docker-machine
* Образ собран `cd docker-monolith && docker build -t reddit:latest .` (так же можно выполнить `docker build -t reddit:latest -f docker-monolith/Dockerfile ./docker-monolith` из корня репозитория)
* Список всех образов (включая промежуточные)
  ```shell
  # docker images -a 
  REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
  reddit              latest              0d1864425483        7 minutes ago       689MB
  <none>              <none>              29597f97cbd2        7 minutes ago       689MB
  <none>              <none>              6094762c8147        7 minutes ago       689MB
  <none>              <none>              1030f7038c6a        8 minutes ago       645MB
  <none>              <none>              1218af463fd2        8 minutes ago       645MB
  <none>              <none>              8a7e652e5f9c        8 minutes ago       645MB
  <none>              <none>              f3eeecf3fe0f        8 minutes ago       645MB
  <none>              <none>              f7f5048a5c4c        8 minutes ago       645MB
  <none>              <none>              6985497bf7cd        8 minutes ago       642MB
  <none>              <none>              e08fb2f1ff85        9 minutes ago       148MB
  ubuntu              16.04               5f2bf26e3524        3 days ago          123MB
  ```

#### Запуск контейнера

* Запущен контейнер из образа reddit `docker run --name reddit -d --network=host reddit:latest`
* Проверка доступности приложения
  ```shell
  # docker-machine ls
  NAME          ACTIVE   DRIVER   STATE     URL                        SWARM   DOCKER     ERRORS
  docker-host   *        google   Running   tcp://35.233.86.180:2376           v19.03.4
  ```
* При попытке зайти на [http://35.233.86.180:9292/](http://35.233.86.180:9292/) не удалось открыть страницу
* Создано правило фаервола
  ```shell
  gcloud compute firewall-rules create reddit-app \
   --allow tcp:9292 \
   --target-tags=docker-machine \
   --description="Allow PUMA connections" \
   --direction=INGRESS
  ```
  ```log
  Creating firewall...⠶Created [https://www.googleapis.com/compute/v1/projects/docker-257914/global/firewalls/reddit-app].
  Creating firewall...done.
  NAME        NETWORK  DIRECTION  PRIORITY  ALLOW     DENY  DISABLED
  reddit-app  default  INGRESS    1000      tcp:9292        False
  ```
* Попытка открыть сайт увенчалась успехом

### Docker hub

* Выполнен вход на https://hub.docker.com/
* Выполнена авторизация docker на dockerhub `docker login`
* docker-образ загружен на докер хаб
  ```shell
  # docker tag reddit:latest vscoder/otus-reddit:1.0
  # docker push vscoder/otus-reddit:1.0

  The push refers to repository [docker.io/vscoder/otus-reddit]
  9c56f25ab809: Pushed 
  9964405a2b79: Pushed 
  f3e1d374270d: Pushed 
  87badc7881a7: Pushed 
  dcc1149e9964: Pushed 
  bbeefc7b2d69: Pushed 
  038504099637: Pushed 
  28567395a615: Pushed 
  3c326a42d554: Pushed 
  bc72fb2e7b74: Mounted from library/ubuntu 
  903669ee7207: Mounted from library/ubuntu 
  a5a5f8c62487: Mounted from library/ubuntu 
  788b17b748c2: Mounted from library/ubuntu 
  1.0: digest: sha256:54828cee832eefa1a0379e4b128f7ce92ba0278c488686d8ba4ff3bdf2fc0c9d size: 3034
  ```
* Выполнена попытка запустить образ на локальном докере
  ```shell
  docker run --name reddit -d -p 9292:9292 vscoder/otus-reddit:1.0
  ```
* Образ успешно скачался с docker hub и приложение запустилось
  ```shell
  curl 127.0.0.1:9292
  ```
* Выполнен ряд проверок
  * `docker logs reddit -f` следить за логами контейнера
  * `docker exec -it reddit bash` выполнить bash в запущенном контейнере
    * `ps aux` список процессов
    * `killall5 1` послать сигнал SIGHUP всем приложениям
  * `docker start reddit` запустить ранее созданный контейнер с именем `reddit`
  * `docker stop reddit && docker rm reddit` остановить и удалить контейнер `reddit`
  * `docker run --name reddit --rm -it vscoder/otus-reddit:1.0 bash` скачать и запустить контейнер `vscoder/otus-reddit:1.0` из docker hub, удалить после остановки, в контейнере запустить `bash` вместо инструкции `CMD`
    * `ps aux` список процессов
    * `exit` выйти (с завершением `bash`)
  * Проверка что контейнер остановлен и удалён
    ```shell
    # docker container ps -a
    CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES
    03a9eea159ef        ubuntu:16.04        "bash"              41 hours ago        Up 21 hours                             wonderful_blackwell
    ```
* И ещё
  * `docker inspect vscoder/otus-reddit:1.0` посмотреть подробную информацию об образе
  * `docker inspect vscoder/otus-reddit:1.0 -f '{{.ContainerConfig.Cmd}}'` команда по-умолчанию при старте контейнера (директива `CMD` Dockerfile)
  * `docker run --name reddit -d -p 9292:9292 vscoder/otus-reddit:1.0` запустить контейнер
  * `docker exec -it reddit bash` запустить bash в уже запущенном контейнере
    * `mkdir /test1234` создать директорию /test1234 (внутри контейнера)
    * `touch /test1234/testfile` создать файл /test1234/testfile
    * `rmdir /opt` удалить лиректорию /opt
    * `exit` выйти из контейнера
  * `docker diff reddit` посмотреть изменения в перезаписываемом слое контейнера
    ```shell
    C /tmp
    A /tmp/mongodb-27017.sock
    C /var
    C /var/log
    A /var/log/mongod.log
    C /var/lib
    C /var/lib/mongodb
    A /var/lib/mongodb/_tmp
    A /var/lib/mongodb/journal
    A /var/lib/mongodb/journal/j._0
    A /var/lib/mongodb/local.0
    A /var/lib/mongodb/local.ns
    A /var/lib/mongodb/mongod.lock
    C /root
    A /root/.bash_history
    A /test1234
    A /test1234/testfile
    D /opt
    ```
  * `docker stop reddit && docker rm reddit` остановить и удалить контейнер
  * `docker run --name reddit --rm -it vscoder/otus-reddit:1.0 bash` снова запустить контейнер
  * `ls /` посмотреть содержимое корневой директории.
    Так как контейнер создан заново, /test1234 отсутствует, а /opt на месте


### Задание со \*: IaC с использованием docker

#### Packer

* Подготовлены необходимые цели в [Makefile](Makefile).
* Создан [шаблон packer](docker-monolith/packer/docker.json) и [скрипт-обёртка](docker-monolith/packer/scripts/ansible-playbook.sh) для подготовки базового образа
* Создан ansible-playbook [docker.yml](docker-monolith/ansible/playbooks/docker.yml) для провиженинга packer-образа.
  Использована galaxy-роль `geerlingguy.docker`
* Созданы необходимые для работы ansible файлы
  * Обновлены зависимости в [requirements.txt](requirements.txt)
  * Создана конфигурация [ansible.cfg](docker-monolith/ansible/ansible.cfg)
  * Добавлен файл с внешними зависимостями ansible [requirements.yml](docker-monolith/ansible/inventory/requirements.yml)
* Средствами packer подготовлен базовый образ `make monolith_packer_build`

#### Terraform

##### Project-wide объекты

* Добавлены необходимые цели в [Makefile](Makefile)
* С помощью terraform:
  * Создан bucket для хранения состояния terraform
  * Настроен projeckt-wide ssh ключ
    ```shell
    make monolith_terraform_apply ENV=""
    ```

##### Модули

Создан модуль [instance](docker-monolith/terraform/modules/instance/), описывающий абстрактный Goocle Compute Instance

Описание переменных:

| Переменная          | Описание                    | Значение по умолчанию | Тип    |
| ------------------- | --------------------------- | --------------------- | ------ |
| project             | Project ID                  |                       | string |
| region              | Region                      | europe-west1          | string |
| zone                | Zone                        | europe-west1-d        | string |
| instance_disk_image | Instance base disk image    |                       | string |
| vpc_network_name    | Network name                | default               | string |
| environment         | Environment name            |                       | string |
| machine_type        | Machine type                | g1-small              | string |
| tags                | Tags list                   | []                    | list   |
| instance_count      | instances count             | 1                     | int    |
| name_prefix         | Name prefix of instance     | instance              | strint |
| tcp_ports           | TCP ports list to open list | []                    | list   |


##### Stage-окружение

Создана stage-инфраструктура. Особенности:
* Количество инстансов берётся из переменной `docker_app_instance_count`
* Префикс имени инстанса `docker_app_name_prefix`
* Список тегов `docker_app_tags`
* Список tcp-портов для фаервола `docker_app_tcp_ports`

Описание прочих переменных можно посмотреть в [variables.tf](docker-monolith/terraform/stage/variables.tf)

#### Запуск контейнера средствами ansible

* Создана роль [docker-monolith/ansible/roles/reddit-monolith-docker](docker-monolith/ansible/roles/reddit-monolith-docker)
  Подробности в [docker-monolith/ansible/roles/reddit-monolith-docker/README.md](docker-monolith/ansible/roles/reddit-monolith-docker/README.md)
* Ностроено использование динамического инвентори `gcp_compute`
* Зависимости `requirements.yml` перемещены в [docker-monolith/ansible/environments/stage/requirements.yml](docker-monolith/ansible/environments/stage/requirements.yml)
* В [docker-monolith/terraform/modules/instance/main.tf](docker-monolith/terraform/modules/instance/main.tf) добавлены `labels` к `google_compute_instance`
* Добавлен плейбук [reddit-app.yml](docker-monolith/ansible/playbooks/reddit-app.yml) для деплоя контейнера
* Добавлены [Makefile](Makefile) цели
  
  | Цель                            | Описание                                             |
  | ------------------------------- | ---------------------------------------------------- |
  | monolith_ansible_inventory_list | Показать содержимое ansible-inventory ввформате json |
  | monolith_ansible_lint           | Выполнить ansible-lint для всех плейбуков            |
  | monolith_ansible_syntax         | Проверить синтаксис всех плейбуков                   |
* Добавлена [Makefile](Makefile) цель
  
  | Цель                        | Описание                           |
  | --------------------------- | ---------------------------------- |
  | monolith_ansible_reddit_app | Развернуть reddit-app в контейнере |
* Добавлены [Makefile](Makefile) цели
  
  | Цель                    | Описание                                                                      |
  | ----------------------- | ----------------------------------------------------------------------------- |
  | monolith_docker_build   | Собрать контейнер из [docker-monolith/Dockerfile](docker-monolith/Dockerfile) |
  | monolith_docker_publish | Загрузить образ `vscoder/otus-reddit:${IMAGE_VERSION}` на docker-hub          |
* В [README.md](README.md) добавлено оглавление
* В [README.md](README.md) добавлен статус тестов на travis-ci

**ВАЖНО!!!** В файл `.travis.yml` Был закоммичен token для уведомлений в slack. Для предотвращения спам-уведомлений в чат, был перегенерирован slack-токен и запиисан в `.travis.yml` в зашифрованом виде, как сказано в [инструкции](https://docs.travis-ci.com/user/notifications#configuring-slack-notifications)
```shell
travis encrypt "<account>:<token>" --add notifications.slack.rooms
```
Так же были почищены все коммиты бренча с помощью `git filter-branch`
```shell
# git filter-branch --tree-filter "sed -e's#slackchannel:slacktoken#faketoken#' -i .travis.yml" HEAD
### Got error, cuz in 1st commit .travis.yml does not exist!
Rewrite 9339a0dd5666e037f747c991df6436dfb4ae6ee5 (1/59) (0 seconds passed, remaining 0 predicted)    sed: невозможно прочитать .travis.yml: Нет такого файла или каталога
tree filter failed: sed -e's#slackchannel:slacktoken#faketoken#' -i .travis.yml
# git filter-branch --tree-filter "sed -e's#slackchannel:slacktoken#faketoken#' -i .travis.yml || true" HEAD
### It WORKS!
Rewrite 9339a0dd5666e037f747c991df6436dfb4ae6ee5 (1/59) (0 seconds passed, remaining 0 predicted)    sed: невозможно прочитать .travis.yml: Нет такого файла или каталога
Rewrite 4eb535e678dc189fb7fc8d6f0a0e967e2db2853d (59/59) (3 seconds passed, remaining 0 predicted)    
Ref 'refs/heads/docker-2' was rewritten
# git filter-branch --tree-filter "sed -e's#slackchannel:slacktoken#slackchannel:faketoken#' -i README.md || true" HEAD  
### Got error!
Cannot create a new backup.
A previous backup already exists in refs/original/
Force overwriting the backup with -f
# git filter-branch -f --tree-filter "sed -e's#slackchannel:slacktoken#slackchannel:faketoken#' -i README.md || true" HEAD
### It WORKS!
Rewrite 72dd8d0f6648a3432c086c0e803ade075c62d862 (53/59) (3 seconds passed, remaining 0 predicted)    
Ref 'refs/heads/docker-2' was rewritten
# git reflog expire --expire=now --all && git gc --prune=now --aggressive 
Подсчет объектов: 569, готово.
Delta compression using up to 12 threads.
Сжатие объектов: 100% (547/547), готово.
Запись объектов: 100% (569/569), готово.
Total 569 (delta 323), reused 3 (delta 0)
# git push origin --force --all
Подсчет объектов: 289, готово.
Delta compression using up to 12 threads.
Сжатие объектов: 100% (188/188), готово.
Запись объектов: 100% (289/289), 68.17 KiB | 22.72 MiB/s, готово.
Total 289 (delta 140), reused 223 (delta 79)
remote: Resolving deltas: 100% (140/140), done.
To github.com:Otus-DevOps-2019-08/vscoder_microservices.git
 + 4eb535e...5503b94 docker-2 -> docker-2 (forced update)
```
После этого, при попытке создать PR в master, github выдал ошибку There isn’t anything to compare. **master** and **docker-2** are entirely different commit histories.
Для исправления ошибки, в ветке **docker-2** был выполнен `git rebase master`
<details><summary>результат</summary>
<p>

```log
First, rewinding head to replay your work on top of it...
Applying: Add PR template and travis checks
Applying: Update README.md. Add slack-integration description
Applying: Provide travis-ci notifications to slack
Applying: Add .gitignore
Applying: Add Makefile
Applying: Update README.md. Describe docker installation
Applying: Update README.md. Add variables descrioption
Applying: Update README.md. Add Makefile targets description
Applying: Describe some useful docker commands
Applying: Add output of dokcer inspect commands
Applying: Update README.md. Describe results docker inspect image
Applying: Update README.md. Describe dockker inspect container output
Applying: Describe image and container differences
Applying: Update README.md. Describe docker kill
Applying: Update README.md. Describe docker system df
Applying: Update README.md. Describe docker rm and rmi
Applying: Update README.md. Describe GCE initialisation
Applying: Update README.md. Describe docker-machine
Applying: Update README.md Describe PID and NET namespaces
Applying: Update README.md. Describe tcpdump
Applying: Update README.md. Describe USER namespaces
Applying: Fix README.md syntax
Applying: Move example json output files to examples/
Applying: Add files, necessary to Dockerfile
Applying: Add Dockerfile
Applying: Update Makefile. Add target docker_machine_create
Applying: Update README.md. Describe docker image creation
Applying: Update README.md. Describe container run
Applying: Update README.md. Describe log in to docker hub
Applying: Update DEADME.md. Push image to docker hub
Applying: Update README.md. Describe some checks
Applying: Update MAkefile. Add target docker_machine_rm
Applying: Update .gitignore. Ignore all imported roles
Applying: Add packer-related Makefile targets
Applying: Add packer json template
Applying: Add ansible playbook to provision packer image
Applying: Add terraform-related Makefile targets
Applying: Add project-wide terraform infra
Applying: Add terraform module instance
Applying: Add terraform stage environment
Applying: Add role dreddit-monolith-docker
Applying: Use dynamic inventory gcp_plugin
Applying: Move requirements.yml
Applying: Add labels to terraform-created instances
Applying: Add playbook reddit-app.yml
Applying: Add ansible-related Makefile targets
Applying: Update README.md. Add security TODO
Applying: Update READEM.md. Docker bench security
Applying: Update README.md. Add useful link
Applying: Add Makefile target monolith_ansible_reddit_app
Applying: Add Makefile targets monolith_docker_build and monolith_docker_publish
Applying: Fix README.md syntax
Applying: Add TOC to README.md
Applying: Add travis-ci badger to README.md
Applying: Fix README.md syntax
Applying: Fix README.md syntax
Applying: Update Makefile target monolith_terraform_init
Applying: Regenerate and encrypt slack's travis-ci token
Applying: Update README.md. Describe git filter-branch
Applying: Add Makefile target install_requirements_dev
Applying: Add Makefile target install_requirements_virtualenv
Applying: Fix Makefile target install_requirements_virtualenv
Applying: Fix requirements.txt Install latest versions of docker-compose and ansible-lint
Applying: Add packer variables example
Applying: Add travis-ci tests
```

</p>
</details>

Затем снова `git push --force`

```log
Counting objects: 311, done.
Delta compression using up to 8 threads.
Compressing objects: 100% (147/147), done.
Writing objects: 100% (311/311), 73.70 KiB | 10.53 MiB/s, done.
Total 311 (delta 156), reused 221 (delta 141)
remote: Resolving deltas: 100% (156/156), done.
To github.com:Otus-DevOps-2019-08/vscoder_microservices.git
 + 557c2fa...a1dbeab docker-2 -> docker-2 (forced update)
```

После этого удалось создать PR

Ссылки по теме:
- https://git-scm.com/docs/git-filter-branch
- https://habr.com/ru/post/76084/
- https://pro-prof.com/forums/topic/git-%D1%83%D0%B4%D0%B0%D0%BB%D0%B5%D0%BD%D0%B8%D0%B5-%D1%84%D0%B0%D0%B9%D0%BB%D0%BE%D0%B2-%D0%B8%D0%B7-%D0%B2%D1%81%D0%B5%D1%85-%D0%BA%D0%BE%D0%BC%D0%BC%D0%B8%D1%82%D0%BE%D0%B2


### Вне ДЗ: безопасность

https://habr.com/ru/company/flant/blog/474012/

#### TODO:

[Docker Security Benchmark](https://github.com/docker/docker-bench-security)
- [ ] !Автоматизированть выполнение Docker Security Benchmark в рамках отдельной роли
- [ ] ОС хоста
- [ ] ?Правила аудита
- [ ] Режим FIPS
- [ ] [Docker Secrets](https://docs.docker.com/engine/swarm/secrets/)
- [ ] !Файл конфигурации Docker'а (логирование на удалённый сервер) фича в рамках отдельной роли
- [ ] Безопасность транспортного уровня (TLS при доступе к API снаружи)
- [ ] [Плагины авторизации](https://docs.docker.com/engine/extend/plugins_authorization/)
- [ ] !Параметры демона -- проверить наличие при запуске
  - [ ] `--live-restore`
  - [ ] `--userland-proxy=false`
  - [ ] `--no-new-privileges`
  - [ ] `--seccomp-profile /path/to/profile`
- [ ] [Seccomp](https://docs.docker.com/engine/security/seccomp/)

Конфигурация контейнеров и файлов сборки
- [ ] !Создание пользователя
- [ ] Удаленный доступ (запретить доступ снаружи или защитить сервтификатами)
- [ ] !Изолируйте пространство имен пользователя
- [ ] !Healthcheck'и
- [ ] ?SELinux (AppArmor)
- [ ] !Сетевые интерфейсы
- [ ] ?Кэшированные версии образов
- [ ] !Сетевой мост
- [ ] !Предупреждение о сокете Docker'а

- [ресурсе Play with Docker](https://training.play-with-docker.com/ops-stage2/) — см. секцию «Security».
- Нашёл роль на ansible-galaxy [haxorof.docker_ce](https://galaxy.ansible.com/haxorof/docker_ce). Рассмотреть!
- Ещё статья про [запуск контейнера под текущим пользователем](https://medium.com/redbubble/running-a-docker-container-as-a-non-root-user-7d2e00f8ee15)

#### Docker Security Benchmark

Первый прогон на созданном хосте:
```shell
docker run -it --net host --pid host --userns host --cap-add audit_control \
    -e DOCKER_CONTENT_TRUST=$DOCKER_CONTENT_TRUST \
    -v /etc:/etc:ro \
    -v /usr/bin/docker-containerd:/usr/bin/docker-containerd:ro \
    -v /usr/bin/docker-runc:/usr/bin/docker-runc:ro \
    -v /usr/lib/systemd:/usr/lib/systemd:ro \
    -v /var/lib:/var/lib:ro \
    -v /var/run/docker.sock:/var/run/docker.sock:ro \
    --label docker_bench_security \
    docker/docker-bench-security
```
<details><summary>CLICK ME</summary>
<p>

```log
$ sudo docker run -it --net host --pid host --userns host --cap-add audit_control \
>     -e DOCKER_CONTENT_TRUST=$DOCKER_CONTENT_TRUST \
>     -v /etc:/etc:ro \
>     -v /usr/bin/docker-containerd:/usr/bin/docker-containerd:ro \
>     -v /usr/bin/docker-runc:/usr/bin/docker-runc:ro \
>     -v /usr/lib/systemd:/usr/lib/systemd:ro \
>     -v /var/lib:/var/lib:ro \
>     -v /var/run/docker.sock:/var/run/docker.sock:ro \
>     --label docker_bench_security \
>     docker/docker-bench-security
Unable to find image 'docker/docker-bench-security:latest' locally
latest: Pulling from docker/docker-bench-security
cd784148e348: Pull complete 
48fe0d48816d: Pull complete 
164e5e0f48c5: Pull complete 
378ed37ea5ff: Pull complete 
Digest: sha256:ddbdf4f86af4405da4a8a7b7cc62bb63bfeb75e85bf22d2ece70c204d7cfabb8
Status: Downloaded newer image for docker/docker-bench-security:latest
# ------------------------------------------------------------------------------
# Docker Bench for Security v1.3.4
#
# Docker, Inc. (c) 2015-
#
# Checks for dozens of common best-practices around deploying Docker containers in production.
# Inspired by the CIS Docker Community Edition Benchmark v1.1.0.
# ------------------------------------------------------------------------------

Initializing Sat Nov  9 06:52:32 UTC 2019


[INFO] 1 - Host Configuration
[WARN] 1.1  - Ensure a separate partition for containers has been created
[NOTE] 1.2  - Ensure the container host has been Hardened
[INFO] 1.3  - Ensure Docker is up to date
[INFO]      * Using 19.03.4, verify is it up to date as deemed necessary
[INFO]      * Your operating system vendor may provide support and security maintenance for Docker
[INFO] 1.4  - Ensure only trusted users are allowed to control Docker daemon
[INFO]      * docker:x:999
[WARN] 1.5  - Ensure auditing is configured for the Docker daemon
[WARN] 1.6  - Ensure auditing is configured for Docker files and directories - /var/lib/docker
[WARN] 1.7  - Ensure auditing is configured for Docker files and directories - /etc/docker
[INFO] 1.8  - Ensure auditing is configured for Docker files and directories - docker.service
[INFO]      * File not found
[INFO] 1.9  - Ensure auditing is configured for Docker files and directories - docker.socket
[INFO]      * File not found
[WARN] 1.10  - Ensure auditing is configured for Docker files and directories - /etc/default/docker
[INFO] 1.11  - Ensure auditing is configured for Docker files and directories - /etc/docker/daemon.json
[INFO]      * File not found
[INFO] 1.12  - Ensure auditing is configured for Docker files and directories - /usr/bin/docker-containerd
[INFO]      * File not found
[INFO] 1.13  - Ensure auditing is configured for Docker files and directories - /usr/bin/docker-runc
[INFO]      * File not found


[INFO] 2 - Docker daemon configuration
[WARN] 2.1  - Ensure network traffic is restricted between containers on the default bridge
[PASS] 2.2  - Ensure the logging level is set to 'info'
[PASS] 2.3  - Ensure Docker is allowed to make changes to iptables
[PASS] 2.4  - Ensure insecure registries are not used
[PASS] 2.5  - Ensure aufs storage driver is not used
[INFO] 2.6  - Ensure TLS authentication for Docker daemon is configured
[INFO]      * Docker daemon not listening on TCP
[INFO] 2.7  - Ensure the default ulimit is configured appropriately
[INFO]      * Default ulimit doesn't appear to be set
[WARN] 2.8  - Enable user namespace support
[PASS] 2.9  - Ensure the default cgroup usage has been confirmed
[PASS] 2.10  - Ensure base device size is not changed until needed
[WARN] 2.11  - Ensure that authorization for Docker client commands is enabled
[WARN] 2.12  - Ensure centralized and remote logging is configured
[INFO] 2.13  - Ensure operations on legacy registry (v1) are Disabled (Deprecated)
[WARN] 2.14  - Ensure live restore is Enabled
[WARN] 2.15  - Ensure Userland Proxy is Disabled
[PASS] 2.16  - Ensure daemon-wide custom seccomp profile is applied, if needed
[PASS] 2.17  - Ensure experimental features are avoided in production
[WARN] 2.18  - Ensure containers are restricted from acquiring new privileges


[INFO] 3 - Docker daemon configuration files
[INFO] 3.1  - Ensure that docker.service file ownership is set to root:root
[INFO]      * File not found
[INFO] 3.2  - Ensure that docker.service file permissions are set to 644 or more restrictive
[INFO]      * File not found
[INFO] 3.3  - Ensure that docker.socket file ownership is set to root:root
[INFO]      * File not found
[INFO] 3.4  - Ensure that docker.socket file permissions are set to 644 or more restrictive
[INFO]      * File not found
[PASS] 3.5  - Ensure that /etc/docker directory ownership is set to root:root
[PASS] 3.6  - Ensure that /etc/docker directory permissions are set to 755 or more restrictive
[INFO] 3.7  - Ensure that registry certificate file ownership is set to root:root
[INFO]      * Directory not found
[INFO] 3.8  - Ensure that registry certificate file permissions are set to 444 or more restrictive
[INFO]      * Directory not found
[INFO] 3.9  - Ensure that TLS CA certificate file ownership is set to root:root
[INFO]      * No TLS CA certificate found
[INFO] 3.10  - Ensure that TLS CA certificate file permissions are set to 444 or more restrictive
[INFO]      * No TLS CA certificate found
[INFO] 3.11  - Ensure that Docker server certificate file ownership is set to root:root
[INFO]      * No TLS Server certificate found
[INFO] 3.12  - Ensure that Docker server certificate file permissions are set to 444 or more restrictive
[INFO]      * No TLS Server certificate found
[INFO] 3.13  - Ensure that Docker server certificate key file ownership is set to root:root
[INFO]      * No TLS Key found
[INFO] 3.14  - Ensure that Docker server certificate key file permissions are set to 400
[INFO]      * No TLS Key found
[PASS] 3.15  - Ensure that Docker socket file ownership is set to root:docker
[PASS] 3.16  - Ensure that Docker socket file permissions are set to 660 or more restrictive
[INFO] 3.17  - Ensure that daemon.json file ownership is set to root:root
[INFO]      * File not found
[INFO] 3.18  - Ensure that daemon.json file permissions are set to 644 or more restrictive
[INFO]      * File not found
[PASS] 3.19  - Ensure that /etc/default/docker file ownership is set to root:root
[PASS] 3.20  - Ensure that /etc/default/docker file permissions are set to 644 or more restrictive


[INFO] 4 - Container Images and Build File
[INFO] 4.1  - Ensure a user for the container has been created
[INFO]      * No containers running
[NOTE] 4.2  - Ensure that containers use trusted base images
[NOTE] 4.3  - Ensure unnecessary packages are not installed in the container
[NOTE] 4.4  - Ensure images are scanned and rebuilt to include security patches
[WARN] 4.5  - Ensure Content trust for Docker is Enabled
[PASS] 4.6  - Ensure HEALTHCHECK instructions have been added to the container image
[PASS] 4.7  - Ensure update instructions are not use alone in the Dockerfile
[NOTE] 4.8  - Ensure setuid and setgid permissions are removed in the images
[INFO] 4.9  - Ensure COPY is used instead of ADD in Dockerfile
[INFO]      * ADD in image history: [docker/docker-bench-security:latest]
[NOTE] 4.10  - Ensure secrets are not stored in Dockerfiles
[NOTE] 4.11  - Ensure verified packages are only Installed


[INFO] 5 - Container Runtime
[INFO]      * No containers running, skipping Section 5


[INFO] 6 - Docker Security Operations
[INFO] 6.1  - Avoid image sprawl
[INFO]      * There are currently: 1 images
[INFO] 6.2  - Avoid container sprawl
[INFO]      * There are currently a total of 1 containers, with 1 of them currently running


[INFO] 7 - Docker Swarm Configuration
[PASS] 7.1  - Ensure swarm mode is not Enabled, if not needed
[PASS] 7.2  - Ensure the minimum number of manager nodes have been created in a swarm (Swarm mode not enabled)
[PASS] 7.3  - Ensure swarm services are binded to a specific host interface (Swarm mode not enabled)
[PASS] 7.4  - Ensure data exchanged between containers are encrypted on different nodes on the overlay network
[PASS] 7.5  - Ensure Docker's secret management commands are used for managing secrets in a Swarm cluster (Swarm mode not enabled)
[PASS] 7.6  - Ensure swarm manager is run in auto-lock mode (Swarm mode not enabled)
[PASS] 7.7  - Ensure swarm manager auto-lock key is rotated periodically (Swarm mode not enabled)
[PASS] 7.8  - Ensure node certificates are rotated as appropriate (Swarm mode not enabled)
[PASS] 7.9  - Ensure CA certificates are rotated as appropriate (Swarm mode not enabled)
[PASS] 7.10  - Ensure management plane traffic has been separated from data plane traffic (Swarm mode not enabled)

[INFO] Checks: 74
[INFO] Score: 12
appuser@reddit-docker-stage-001:~$
```

</p>
</details>

## HomeWork 13: Docker-образы и Микросервисы

### Подготовка

- Создан Makefile target `install_hadolint`

#### Dockerfile best practices (collapsed)

<details><summary>Dockerfile best practices</summary>
<p>

https://docs.docker.com/develop/develop-images/dockerfile_best-practices/

##### FROM

https://docs.docker.com/develop/develop-images/#from

We recommend the Alpine image as it is tightly controlled and small in size (currently under 5 MB), while still being a full Linux distribution.

##### LABEL

https://docs.docker.com/develop/develop-images/#label

For each label, add a line beginning with LABEL and with one or more key-value pairs.

##### RUN

https://docs.docker.com/develop/develop-images/#run

Always combine RUN apt-get update with apt-get install in the same RUN statement. For example:
```Dockerfile
RUN apt-get update && apt-get install -y \
    package-bar \
    package-baz \
    package-foo
```

You can also achieve cache-busting by specifying a package version. This is known as version pinning, for example:
```Dockerfile
RUN apt-get update && apt-get install -y \
    package-bar \
    package-baz \
    package-foo=1.3.*
```

If you want the command to fail due to an error at any stage in the pipe, prepend set -o pipefail && to ensure that an unexpected error prevents the build from inadvertently succeeding. For example:
```Dockerfile
RUN set -o pipefail && wget -O - https://some.site | wc -l > /number
```

##### CMD

https://docs.docker.com/develop/develop-images/#cmd

`CMD` should almost always be used in the form of `CMD ["executable", "param1", "param2"…]`. Thus, if the image is for a service, such as Apache and Rails, you would run something like `CMD ["apache2","-DFOREGROUND"]`.

`CMD` should rarely be used in the manner of `CMD ["param", "param"]` in conjunction with `ENTRYPOINT`.

##### EXPOSE

https://docs.docker.com/develop/develop-images/#expose

you should use the common, traditional port for your application
For example, an image containing the Apache web server would use `EXPOSE 80`, while an image containing MongoDB would use `EXPOSE 27017` and so on.
For container linking, Docker provides environment variables for the path from the recipient container back to the source (ie, `MYSQL_PORT_3306_TCP`).


##### ENV

https://docs.docker.com/develop/develop-images/#env

For example, `ENV PATH /usr/local/nginx/bin:$PATH` ensures that `CMD ["nginx"]` just works.

The `ENV` instruction is also useful for providing required environment variables specific to services you wish to containerize, such as Postgres’s `PGDATA`.

Lastly, `ENV` can also be used to set commonly used version numbers so that version bumps are easier to maintain. Similar to having constant variables in a program (as opposed to hard-coding values), this approach lets you change a single ENV instruction to auto-magically bump the version of the software in your container.

Each `ENV` line creates a new intermediate layer, just like `RUN` commands. This means that even if you unset the environment variable in a future layer, it still persists in this layer and its value can be dumped. To prevent this, and really unset the environment variable, use a RUN command with shell commands.

##### ADD or COPY

https://docs.docker.com/develop/develop-images/#add-or-copy

Although `ADD` and `COPY` are functionally similar, generally speaking, `COPY` is preferred. That’s because it’s more transparent than ADD. COPY only supports the basic copying of local files into the container, while ADD has some features (like local-only tar extraction and remote URL support) that are not immediately obvious. 
Consequently, the best use for ADD is local tar file auto-extraction into the image, as in `ADD rootfs.tar.xz /`.

If you have multiple `Dockerfile` steps that use different files from your context, `COPY` them individually, rather than all at once.
For example:
```Dockerfile
COPY requirements.txt /tmp/
RUN pip install --requirement /tmp/requirements.txt
COPY . /tmp/
```
Results in fewer cache invalidations for the `RUN` step, than if you put the `COPY . /tmp/` before it.

Because image size matters, using ADD to fetch packages from remote URLs is strongly discouraged; you should use curl or wget instead. That way you can delete the files you no longer need after they’ve been extracted and you don’t have to add another layer in your image.
do something like:
```Dockerfile
RUN mkdir -p /usr/src/things \
    && curl -SL http://example.com/big.tar.xz \
    | tar -xJC /usr/src/things \
    && make -C /usr/src/things all
```

##### ENTRYPOINT

https://docs.docker.com/develop/develop-images/#entrypoint

The best use for ENTRYPOINT is to set the image’s main command, allowing that image to be run as though it was that command (and then use CMD as the default flags).
```Dockerfile
ENTRYPOINT ["s3cmd"]
CMD ["--help"]
```

Postgres official image `ENTRYPOINT`
```shell
#!/bin/bash
set -e

if [ "$1" = 'postgres' ]; then
    chown -R postgres "$PGDATA"

    if [ -z "$(ls -A "$PGDATA")" ]; then
        gosu postgres initdb
    fi

    exec gosu postgres "$@"
fi

exec "$@"
```

Configure app as PID 1
This script uses [the `exec` Bash command](http://wiki.bash-hackers.org/commands/builtin/exec) so that the final running application becomes the container’s `PID 1`. This allows the application to receive any Unix signals sent to the container. For more, see the [`ENTRYPOINT` reference](https://docs.docker.com/engine/reference/builder/#entrypoint).

##### VOLUME

https://docs.docker.com/develop/develop-images/#volume

The VOLUME instruction should be used to expose any database storage area, configuration storage, or files/folders created by your docker container. You are strongly encouraged to use VOLUME for any mutable and/or user-serviceable parts of your image.

##### USER

https://docs.docker.com/develop/develop-images/dockerfile_best-practices/#user

If a service can run without privileges, use `USER` to change to a non-root user. Start by creating the user and group in the Dockerfile with something like 
```Dockerfile
RUN groupadd -r postgres && useradd --no-log-init -r -g postgres postgres
```

WARNING: [unresolved bug](https://github.com/golang/go/issues/13548)

Avoid installing or using `sudo` as it has unpredictable TTY and signal-forwarding behavior that can cause problems. If you absolutely need functionality similar to `sudo`, such as initializing the daemon as root but running it as non-root, consider using `“gosu”`.

##### WORKDIR

https://docs.docker.com/develop/develop-images/#workdir

For clarity and reliability, you should always use absolute paths for your `WORKDIR`. Also, you should use `WORKDIR` instead of proliferating instructions like `RUN cd … && do-something`, which are hard to read, troubleshoot, and maintain.

##### ONBUILD

https://docs.docker.com/develop/develop-images/#onbuild

An `ONBUILD` command executes after the current `Dockerfile` build completes. `ONBUILD` executes in any child image derived FROM the current image. Think of the `ONBUILD` command as an instruction the parent `Dockerfile` gives to the child `Dockerfile`.
`ONBUILD` is useful for images that are going to be built `FROM` a given image.
[Ruby’s ONBUILD variants](https://github.com/docker-library/ruby/blob/c43fef8a60cea31eb9e7d960a076d633cb62ba8d/2.4/jessie/onbuild/Dockerfile)
Images built with `ONBUILD` should get a separate tag, for example: `ruby:1.9-onbuild` or `ruby:2.0-onbuild`.

</p>
</details>

### Запуск

#### Новая структура приложения

- Скачан и распакован архив [microservices.zip](https://github.com/express42/reddit/archive/microservices.zip)
  ```shell
  wget https://github.com/express42/reddit/archive/microservices.zip && \
    unzip microservices.zip && \
    rm microservices.zip
  ```
- Каталог `reddit-microservices` переименован в `src`
  ```shell
  mv reddit-microservices src
  ```
- Создан файл [src/post-py/Dockerfile](src/post-py/Dockerfile)
- В файле [src/post-py/Dockerfile](src/post-py/Dockerfile) рабочий каталог параметризирован
- Создан файл [src/comment/Dockerfile](src/comment/Dockerfile)
- Создан файл [src/ui/Dockerfile](src/ui/Dockerfile)
- Скачан последний образ MongoDB
  ```shell
  docker pull mongo:latest
  ```
- Подготовлен [Makefile](src/Makefile) с набороми часто используемых действий

#### Сборка образов

- Сборка образа `post-py` завершилась ошибкой
  ```log
  unable to execute 'gcc': No such file or directory
  error: command 'gcc' failed with exit status 1
  ```
- Собран образ comment `make build_comment`
- Собран образ ui `make build_ui`

- Проблема с `post-py` решена следующим образом
  ```Dockerfile
  RUN apk add --no-cache --virtual .build-deps build-base \
    && pip install -r $APP_HOME/requirements.txt \
    && apk del .build-deps
  ```
  Перед установкой `requirements.txt`, ставится пакет `build-base`. После установки `requirements.txt`, все необходимые для сборки пакеты удаляются. Это всё происходит в рамках одной инструкции `RUN`, чтобы не создавать лишний слой с установленными зависимостями.

Сборка `ui` началась не с первого шага, потому что слой с установленным пакетом `build-essential` уже был создан на этапе сборки `comment`, а сейчас был взят из build-cache вместо ссборки с нуля.

#### Запуск приложения

Работа ведётся в директории [src/](src/)

- Собраны все образы `make build_all`
- В [Makefile](src/Makefile) добавлена цель `run_all`, которая
  - Создаёт сеть `${REDDIT_NETWORK_NAME}`
  - Запускает контейнеры в сети `${REDDIT_NETWORK_NAME}` из образов
    - `mongodb:latest`
    - `${DOCKERHUB_LOGIN}/post:${POST_VERSION}`
    - `${DOCKERHUB_LOGIN}/comment:${COMMENT_VERSION}`
    - `${DOCKERHUB_LOGIN}/ui:${UI_VERSION}`
- В [Makefile](src/Makefile) добавлена цель `kill_all`, которая
  - Убивает все запущенные контейнеры (**ВНИМАНИЕ**: вообще все! О чём выдаётся предупреждение с возможностью отмены.)
  - Удаляет сеть `${REDDIT_NETWORK_NAME}`
- Создана сеть и запущены контейнеры `make run_all`
- Зайти на http://127.0.0.1:9292 удалось
- Написать пост удалось
- Всё убито `make kill_all`

### Задание со \*: Переопределение сетевых алиасов

#### Теория

https://docs.docker.com/engine/reference/commandline/run/#set-environment-variables--e---env---env-file

Use the `-e`, `--env`, and `--env-file` flags to set simple (non-array) environment variables in the container you’re running, or overwrite variables that are defined in the Dockerfile of the image you’re running.

```shell
$ docker run --env VAR1=value1 --env VAR2=value2 ubuntu env | grep VAR
VAR1=value1
VAR2=value2
```

```shell
export VAR1=value1
export VAR2=value2

$ docker run --env VAR1 --env VAR2 ubuntu env | grep VAR
VAR1=value1
VAR2=value2
```

```shell
$ cat env.list
# This is a comment
VAR1=value1
VAR2=value2
USER

$ docker run --env-file env.list ubuntu env | grep VAR
VAR1=value1
VAR2=value2
USER=denis
```

#### Реализация

Создание сети и запуск контейнеров с другими алиасами и переопределением переменных
```shell
docker network create reddit
docker run -d --network=reddit \
  --network-alias=posts_db1 \
  --network-alias=comment_db1 \
  mongo:latest
docker run -d --network=reddit \
  --network-alias=post1 \
  --env POST_DATABASE_HOST=posts_db1 \
  vscoder/post:1.0
docker run -d --network=reddit \
  --network-alias=comment1 \
  --env COMMENT_DATABASE_HOST=comment_db1 \
  vscoder/comment:1.0
docker run -d --network=reddit \
  --env POST_SERVICE_HOST=post1 \
  --env COMMENT_SERVICE_HOST=comment1 \
  -p 9292:9292 \
  vscoder/ui:1.0
```

Сеть создана, контейнеры запущены. Работоспособность приложения проверена.

### Образы

Список образов `docker images`

```shell
REPOSITORY            TAG                 IMAGE ID            CREATED             SIZE
vscoder/ui            1.0                 aacf973cbc5d        About an hour ago   772MB
vscoder/comment       1.0                 188232c05d67        About an hour ago   770MB
vscoder/post          1.0                 f22acc632909        About an hour ago   109MB
reddit                latest              fce89963a387        5 days ago          691MB
vscoder/otus-reddit   1.0                 fce89963a387        5 days ago          691MB
mongo                 latest              965553e202a4        2 weeks ago         363MB
ubuntu                16.04               5f2bf26e3524        2 weeks ago         123MB
ruby                  2.2                 6c8e6f9667b2        18 months ago       715MB
python                3.6.0-alpine        cb178ebbf0f2        2 years ago         88.6MB
```

- Уменьшен убраз `ui`, засчёт пересборки его на основе `ubuntu:16.04`. Новый [Dockerfile](src/ui/Dockerfile)
- В [Makefile](src/Makefile) изменена версия ui на 2.0
- Образ пересобран `make build_ui`

Список образов `docker images`

```shell
REPOSITORY            TAG                 IMAGE ID            CREATED             SIZE
vscoder/ui            2.0                 ebb79fd1384f        2 minutes ago       458MB
vscoder/ui            1.0                 aacf973cbc5d        About an hour ago   772MB
vscoder/comment       1.0                 188232c05d67        About an hour ago   770MB
vscoder/post          1.0                 f22acc632909        About an hour ago   109MB
reddit                latest              fce89963a387        5 days ago          691MB
vscoder/otus-reddit   1.0                 fce89963a387        5 days ago          691MB
mongo                 latest              965553e202a4        2 weeks ago         363MB
ubuntu                16.04               5f2bf26e3524        2 weeks ago         123MB
ruby                  2.2                 6c8e6f9667b2        18 months ago       715MB
python                3.6.0-alpine        cb178ebbf0f2        2 years ago         88.6MB
```

### Задание со \*: Уменьшаем размер образа

#### Анализ

Ссылки:

- [Официальная wiki](https://wiki.alpinelinux.org/wiki)
- [Статья на habr](https://habr.com/ru/company/digdes/blog/415279/)
- [Статья на habr](https://habr.com/ru/company/digdes/blog/440658/)
- [Получаем максимум от Docker. Микроконтейнеры и Alpine Linux](https://youtu.be/ClX9jbiVLaY)
- Утилита по исследованию образов [dive](https://github.com/wagoodman/dive)
  Пример использования:
  - Для интерактивного анализа
    ```shell
    docker run --rm -it \
      -v /var/run/docker.sock:/var/run/docker.sock \
      wagoodman/dive:latest <ui image id>
    ```
  - Для интеграции с CI
    ```shell
    docker run --rm -it \
      -v /var/run/docker.sock:/var/run/docker.sock \
      -e CI=true \
      wagoodman/dive:latest <ui image id>
    ```

Варианты решения:

- Образы на основе alpine-linux. 
  - '+' Очень эффективно (результаты далее) за счёт минималистичного базового образа.
  - '-' Могут возникнуть сложности при отсутствии каких-либо пакетов в репозитории.
- Образы на основе [scratch](https://hub.docker.com/_/scratch), то есть на основе пустого образа
  - '+' На несколько мегабайт эффективнее чем alpine-linux.
  - '-' Очень сильно усложняет обслуживание образов.
- Использование промежуточных образов, Многоступенчатая сборка.
  - '+' Позволяет все зависимости, необходимые для сборки исполняемого файла, иметь в отдельном образе. В основном используется для компиляции исполняемых файлов с последующим копированием их в итоговый образ.
  - '-' Усложняет обслуживание. Сложно применимо в ряде случаев (например для интерпретируемых языков).
  - Для используемых образов (python и ruby) можно в промежуточном образе установить зависимости, необходимые для компиляции, установить зависимости приложения (`pip` или `bundle`), получить с помощью `dive` добавленные файлы и скопировать их в итоговый образ. Но это **чрезмерно** усложнит обслуживание образа, что делает возможную выгоду несущественной.

Выводы:

Наиболее эффективным решением быдет использование для приложений образов на основе alpine-linux

#### Сборка на основе alpine linux

##### ui

- Образ пересобран на базе `ruby:2.2-alpine`. Установка зависимостей потребовала установки `build-base`. Установка `build-base`, установка зависимостей и удаление `build-base` выполняется одниой инструкцией `RUN`, чтобы избежать создания лишних образов.
```Dockerfile
FROM ruby:2.2-alpine

ENV POST_SERVICE_HOST post
ENV POST_SERVICE_PORT 5000
ENV COMMENT_SERVICE_HOST comment
ENV COMMENT_SERVICE_PORT 9292
ENV APP_HOME /app

RUN mkdir $APP_HOME
WORKDIR $APP_HOME
COPY Gemfile* $APP_HOME/

RUN apk add --no-cache --virtual .build-deps build-base \
    && bundle install \
    && apk del .build-deps

COPY . $APP_HOME

CMD ["puma"]
```
- Занимаемый объём уменьшился `docker images | grep vscoder/ui`
```log
vscoder/ui            3.0                 25f038173527        13 minutes ago      158MB
vscoder/ui            2.0                 ebb79fd1384f        4 hours ago         458MB
vscoder/ui            1.0                 aacf973cbc5d        6 hours ago         772MB
```
- Результат работы `dive`
  ```shell
  make dive_ui
  docker run --rm -it \
          -v /var/run/docker.sock:/var/run/docker.sock \
          -e CI=true \
          wagoodman/dive:latest $(docker images -q vscoder/ui:3.0)
  ```

<details><summary>результат</summary>
<p>

```log
Image Source: docker://7d3825b1f360
Fetching image... (this can take a while for large images)
Analyzing image...
  efficiency: 99.4482 %

  wastedBytes: 892115 bytes (892 kB)

  userWastedPercent: 0.5820 %

Inefficient Files:
Count  Wasted Space  File Path
    3        324 kB  /lib/apk/db/installed
    2        113 kB  /bin/ps
    2         83 kB  /usr/bin/top
    2         70 kB  /usr/bin/bunzip2
    2         70 kB  /usr/bin/bzip2
    2         70 kB  /usr/bin/bzcat
    3         32 kB  /lib/apk/db/scripts.tar
    2         26 kB  /usr/bin/pmap
    2         22 kB  /usr/bin/pgrep
    2         22 kB  /usr/bin/pkill
    2         18 kB  /sbin/sysctl
    2         14 kB  /usr/bin/free
    2         10 kB  /usr/bin/uptime
    2        9.9 kB  /usr/bin/pwdx
    2        3.7 kB  /app/Gemfile.lock
    3         500 B  /lib/apk/db/triggers
    2         474 B  /app/Gemfile
    3         181 B  /etc/apk/world
    2           0 B  /usr/bin/sort
    2           0 B  /usr/bin/test
    2           0 B  /usr/bin/fold
    2           0 B  /usr/bin/tail
    2           0 B  /usr/bin/tac
    2           0 B  /usr/bin/sum
    3           0 B  /usr/bin/strings
    2           0 B  /usr/bin/split
    2           0 B  /usr/bin/timeout
    2           0 B  /usr/bin/shuf
    2           0 B  /usr/bin/sha512sum
    2           0 B  /usr/bin/sha256sum
    2           0 B  /usr/bin/sha1sum
    2           0 B  /usr/bin/seq
    2           0 B  /usr/bin/realpath
    2           0 B  /usr/bin/readlink
    2           0 B  /usr/bin/tr
    2           0 B  /usr/bin/printf
    2           0 B  /usr/bin/truncate
    2           0 B  /usr/bin/tty
    2           0 B  /usr/bin/unexpand
    2           0 B  /usr/bin/od
    2           0 B  /usr/bin/nohup
    2           0 B  /usr/bin/mkfifo
    2           0 B  /usr/bin/md5sum
    2           0 B  /usr/bin/lzma
    2           0 B  /usr/bin/lzcat
    2           0 B  /usr/bin/install
    2           0 B  /usr/bin/id
    2           0 B  /usr/bin/hostid
    2           0 B  /usr/bin/head
    2           0 B  /usr/bin/groups
    2           0 B  /usr/bin/uniq
    2           0 B  /usr/bin/tee
    2           0 B  /usr/bin/expr
    2           0 B  /usr/bin/expand
    2           0 B  /usr/bin/env
    2           0 B  /usr/bin/du
    2           0 B  /usr/bin/dirname
    2           0 B  /usr/bin/cut
    2           0 B  /usr/bin/comm
    2           0 B  /usr/bin/cksum
    2           0 B  /usr/bin/unlink
    2           0 B  /usr/bin/unlzma
    2           0 B  /usr/bin/unxz
    2           0 B  /usr/bin/basename
    2           0 B  /usr/bin/[
    3           0 B  /tmp
    2           0 B  /usr/bin/wc
    2           0 B  /root
    2           0 B  /usr/bin/whoami
    2           0 B  /usr/bin/xzcat
    3           0 B  /lib/apk/db/lock
    2           0 B  /usr/bin/yes
    2           0 B  /usr/sbin/chroot
    2           0 B  /bin/uname
    2           0 B  /bin/true
    2           0 B  /bin/touch
    2           0 B  /bin/tar
    2           0 B  /bin/sync
    2           0 B  /bin/stty
    2           0 B  /bin/stat
    2           0 B  /bin/sleep
    2           0 B  /bin/rmdir
    2           0 B  /bin/rm
    2           0 B  /bin/pwd
    3           0 B  /var/cache/misc
    2           0 B  /bin/printenv
    2           0 B  /bin/nice
    2           0 B  /bin/mv
    2           0 B  /bin/mktemp
    2           0 B  /bin/mknod
    2           0 B  /bin/mkdir
    2           0 B  /bin/ls
    2           0 B  /bin/ln
    2           0 B  /bin/false
    2           0 B  /bin/echo
    2           0 B  /bin/df
    2           0 B  /bin/dd
    2           0 B  /bin/date
    2           0 B  /bin/cp
    2           0 B  /bin/chown
    2           0 B  /bin/chmod
    2           0 B  /bin/chgrp
    2           0 B  /bin/cat
    2           0 B  /bin/base64
Results:
  PASS: highestUserWastedPercent
  SKIP: highestWastedBytes: rule disabled
  PASS: lowestEfficiency
Result:PASS [Total:3] [Passed:2] [Failed:0] [Warn:0] [Skipped:1]
```

</p>
</details>

- На шаге установки зависимостей, была добавлена очистка кеша `bundle clean`, что позволило уменьшить итоговый образ на 1Мб.
  ```shell
  # docker images vscoder/ui  
  REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
  vscoder/ui          3.0-alpine          f54689080dbe        17 minutes ago      157MB
  vscoder/ui          3.0                 7d3825b1f360        2 hours ago         158MB
  vscoder/ui          2.0                 ebb79fd1384f        26 hours ago        458MB
  vscoder/ui          1.0                 aacf973cbc5d        28 hours ago        772MB
  ```

##### comment

- Dockerfile
```Dockerfile
FROM ruby:2.2-alpine

ENV COMMENT_DATABASE_HOST comment_db
ENV COMMENT_DATABASE comments
ENV APP_HOME /app

RUN mkdir $APP_HOME
WORKDIR $APP_HOME

# Application requiremets (fat layer)
COPY Gemfile* $APP_HOME/
RUN apk add --no-cache --virtual .build-deps build-base \
    && bundle install \
    && apk del .build-deps

# Application (frequently changing layer)
COPY . $APP_HOME

CMD ["puma"]
```

- Размер `docker images | grep vscoder/comment`
```log
vscoder/comment       2.0                 a85ccabc510d        15 seconds ago      156MB
vscoder/comment       1.0                 188232c05d67        6 hours ago         770MB
```
- Результат работы `dive`
  ```shell
  # make dive_comment 
  docker run --rm -it \
          -v /var/run/docker.sock:/var/run/docker.sock \
          -e CI=true \
          wagoodman/dive:latest $(docker images -q vscoder/comment:2.0)
  ```
<details><summary>результат</summary>
<p>

```log
  Using default CI config
Image Source: docker://a85ccabc510d
Fetching image... (this can take a while for large images)
Analyzing image...
  efficiency: 99.4405 %

  wastedBytes: 890157 bytes (890 kB)

  userWastedPercent: 0.5898 %

Inefficient Files:
Count  Wasted Space  File Path
    3        324 kB  /lib/apk/db/installed
    2        113 kB  /bin/ps
    2         83 kB  /usr/bin/top
    2         70 kB  /usr/bin/bunzip2
    2         70 kB  /usr/bin/bzip2
    2         70 kB  /usr/bin/bzcat
    3         32 kB  /lib/apk/db/scripts.tar
    2         26 kB  /usr/bin/pmap
    2         22 kB  /usr/bin/pgrep
    2         22 kB  /usr/bin/pkill
    2         18 kB  /sbin/sysctl
    2         14 kB  /usr/bin/free
    2         10 kB  /usr/bin/uptime
    2        9.9 kB  /usr/bin/pwdx
    2        1.8 kB  /app/Gemfile.lock
    3         500 B  /lib/apk/db/triggers
    2         364 B  /app/Gemfile
    3         181 B  /etc/apk/world
    2           0 B  /usr/bin/sort
    2           0 B  /usr/bin/test
    2           0 B  /usr/bin/fold
    2           0 B  /usr/bin/tail
    2           0 B  /usr/bin/tac
    2           0 B  /usr/bin/sum
    3           0 B  /usr/bin/strings
    2           0 B  /usr/bin/split
    2           0 B  /usr/bin/timeout
    2           0 B  /usr/bin/shuf
    2           0 B  /usr/bin/sha512sum
    2           0 B  /usr/bin/sha256sum
    2           0 B  /usr/bin/sha1sum
    2           0 B  /usr/bin/seq
    2           0 B  /usr/bin/realpath
    2           0 B  /usr/bin/readlink
    2           0 B  /usr/bin/tr
    2           0 B  /usr/bin/printf
    2           0 B  /usr/bin/truncate
    2           0 B  /usr/bin/tty
    2           0 B  /usr/bin/unexpand
    2           0 B  /usr/bin/od
    2           0 B  /usr/bin/nohup
    2           0 B  /usr/bin/mkfifo
    2           0 B  /usr/bin/md5sum
    2           0 B  /usr/bin/lzma
    2           0 B  /usr/bin/lzcat
    2           0 B  /usr/bin/install
    2           0 B  /usr/bin/id
    2           0 B  /usr/bin/hostid
    2           0 B  /usr/bin/head
    2           0 B  /usr/bin/groups
    2           0 B  /usr/bin/uniq
    2           0 B  /usr/bin/tee
    2           0 B  /usr/bin/expr
    2           0 B  /usr/bin/expand
    2           0 B  /usr/bin/env
    2           0 B  /usr/bin/du
    2           0 B  /usr/bin/dirname
    2           0 B  /usr/bin/cut
    2           0 B  /usr/bin/comm
    2           0 B  /usr/bin/cksum
    2           0 B  /usr/bin/unlink
    2           0 B  /usr/bin/unlzma
    2           0 B  /usr/bin/unxz
    2           0 B  /usr/bin/basename
    2           0 B  /usr/bin/[
    3           0 B  /tmp
    2           0 B  /usr/bin/wc
    2           0 B  /root
    2           0 B  /usr/bin/whoami
    2           0 B  /usr/bin/xzcat
    3           0 B  /lib/apk/db/lock
    2           0 B  /usr/bin/yes
    2           0 B  /usr/sbin/chroot
    2           0 B  /bin/uname
    2           0 B  /bin/true
    2           0 B  /bin/touch
    2           0 B  /bin/tar
    2           0 B  /bin/sync
    2           0 B  /bin/stty
    2           0 B  /bin/stat
    2           0 B  /bin/sleep
    2           0 B  /bin/rmdir
    2           0 B  /bin/rm
    2           0 B  /bin/pwd
    3           0 B  /var/cache/misc
    2           0 B  /bin/printenv
    2           0 B  /bin/nice
    2           0 B  /bin/mv
    2           0 B  /bin/mktemp
    2           0 B  /bin/mknod
    2           0 B  /bin/mkdir
    2           0 B  /bin/ls
    2           0 B  /bin/ln
    2           0 B  /bin/false
    2           0 B  /bin/echo
    2           0 B  /bin/df
    2           0 B  /bin/dd
    2           0 B  /bin/date
    2           0 B  /bin/cp
    2           0 B  /bin/chown
    2           0 B  /bin/chmod
    2           0 B  /bin/chgrp
    2           0 B  /bin/cat
    2           0 B  /bin/base64
Results:
  PASS: highestUserWastedPercent
  SKIP: highestWastedBytes: rule disabled
  PASS: lowestEfficiency
Result:PASS [Total:3] [Passed:2] [Failed:0] [Warn:0] [Skipped:1]
```

</p>
</details>

- На шаге установки зависимостей, была добавлена очистка кеша `bundle clean`, что позволило уменьшить итоговый образ на 1Мб.
  ```shell
  # docker images vscoder/comment
  REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
  vscoder/comment     2.0-alpine          333b8da781a5        17 minutes ago      156MB
  vscoder/comment     2.0                 a85ccabc510d        22 hours ago        156MB
  vscoder/comment     1.0                 188232c05d67        28 hours ago        770MB
  ```

##### post

- Образ post изначально бдыл основан на alpine, в связи с этим модификация не потребовалась.
  ```shell
  # docker images vscoder/post
  REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
  vscoder/post        1.0                 f22acc632909        27 hours ago        109MB
  ```
- Результат работы `dive`
  ```shell
  make dive_post 
  docker run --rm -it \
          -v /var/run/docker.sock:/var/run/docker.sock \
          -e CI=true \
          wagoodman/dive:latest $(docker images -q vscoder/post:1.0)
  ```
<details><summary>результат</summary>
<p>

```log
  Using default CI config
Image Source: docker://f22acc632909
Fetching image... (this can take a while for large images)
Analyzing image...
  efficiency: 98.7017 %

  wastedBytes: 2357680 bytes (2.4 MB)

  userWastedPercent: 2.2600 %

Inefficient Files:
Count  Wasted Space  File Path
    2        1.1 MB  /lib/ld-musl-x86_64.so.1
    2        549 kB  /etc/ssl/certs/ca-certificates.crt
    4        465 kB  /lib/apk/db/installed
    2         73 kB  /usr/bin/getent
    2         63 kB  /usr/bin/getconf
    4         45 kB  /lib/apk/db/scripts.tar
    2         41 kB  /usr/bin/iconv
    4         812 B  /lib/apk/db/triggers
    2         786 B  /sbin/ldconfig
    4         284 B  /etc/apk/world
    2         216 B  /app/requirements.txt
    2           0 B  /usr/bin/unlzma
    3           0 B  /usr/bin/strings
    2           0 B  /usr/bin/lzma
    2           0 B  /usr/bin/lzcat
    3           0 B  /tmp
    2           0 B  /root
    2           0 B  /usr/bin/xzcat
    2           0 B  /bin/tar
    4           0 B  /var/cache/misc
    2           0 B  /lib/apk/db/lock
    2           0 B  /lib/libc.musl-x86_64.so.1
    2           0 B  /usr/bin/ldd
    2           0 B  /usr/bin/unxz
Results:
  PASS: highestUserWastedPercent
  SKIP: highestWastedBytes: rule disabled
  PASS: lowestEfficiency
Result:PASS [Total:3] [Passed:2] [Failed:0] [Warn:0] [Skipped:1]
```

</p>
</details>

- При установке зависимостей была добавлена опция `--no-cache-dir` к `pip`, что позволило уменьшить итоговый образ на 3Мб
  ```shell
  # docker images vscoder/post
  REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
  vscoder/post        2.0-alpine          6cadaa2065a7        2 minutes ago       106MB
  vscoder/post        1.0                 f22acc632909        28 hours ago        109MB
  ```

### Дальнейшие действия

#### Проверка работоспособности

- К тегам образов добавлен суффикс `-alpine`
- Пересобраны все образы `make build_all`
- Остановлены ранее запущенные инстансы `make kill_all`
- Контейнеры запущены заново на основе свежих образов `make run_all`
- Работоспособность проверена. Пост создан успешно. Ранее созданный пост не сохоанился.

#### Создание volume для MongoDB

- В Makefile target run_all добавлено создание volume в случае отсутствия
  ```shell
  docker volume inspect ${REDDIT_DB_VOLUME_NAME} 1>/dev/null || docker volume create ${REDDIT_DB_VOLUME_NAME}
  ```
- В Makefile target run_all при создании контейнера с mongodb монтируется volume
  ```Makefile
  -v reddit_db:/data/db
  ```
- В результате Makefile target run_all выглядит следующим образом:
  ```Makefile
  run_all:
	docker network inspect ${REDDIT_NETWORK_NAME} 1>/dev/null || docker network create ${REDDIT_NETWORK_NAME}
	docker volume inspect ${REDDIT_DB_VOLUME_NAME} 1>/dev/null || docker volume create ${REDDIT_DB_VOLUME_NAME}
	docker run -d --network=${REDDIT_NETWORK_NAME} \
		--network-alias=post_db \
		--network-alias=comment_db \
		-v reddit_db:/data/db \
		mongo:latest
	docker run -d --network=${REDDIT_NETWORK_NAME} \
		--network-alias=post ${DOCKERHUB_LOGIN}/post:${POST_VERSION}
	docker run -d --network=${REDDIT_NETWORK_NAME} \
		--network-alias=comment ${DOCKERHUB_LOGIN}/comment:${COMMENT_VERSION}
	docker run -d --network=${REDDIT_NETWORK_NAME} \
		-p 9292:9292 ${DOCKERHUB_LOGIN}/ui:${UI_VERSION}
  ```
- Работоспособность проверена

### src/Makefile

#### Переменные

| переменная            | значение по-умолчанию | описание                                    |
| --------------------- | --------------------- | ------------------------------------------- |
| DOCKERHUB_LOGIN       | vscoder               | логин на hub.docker.com                     |
| POST_VERSION          | 1.0                   | версия сервиса post-py                      |
| COMMENT_VERSION       | 1.0                   | версия сервиса comment                      |
| UI_VERSION            | 1.0                   | версия сервиса ui                           |
| REDDIT_NETWORK_NAME   | reddit                | Имя docker-сети                             |
| REDDIT_DB_VOLUME_NAME | reddit_db             | Название volume для хранения данных mongodb |

#### Цели

| цель          | описание                                                                                         |
| ------------- | ------------------------------------------------------------------------------------------------ |
| build_post    | собирает контейнер post:${POST_VERSION} из контекста ./post-py                                   |
| dive_post     | анализ образа post:${POST_VERSION} на эффективность средствами `dive`                            |
| build_comment | собирает контейнер comment:${COMMENT_VERSION} из контекста ./comment                             |
| dive_comment  | анализ образа comment:${COMMENT_VERSION} на эффективность средствами `dive`                      |
| build_ui      | собирает контейнер ui:${UI_VERSION} из контекста ./ui                                            |
| dive_ui       | анализ образа ui:${UI_VERSION} на эффективность средствами `dive`                                |
| build_all     | собрать все контейнеры                                                                           |
| run_all       | запустить контейнеры из образов mongodb и 3х наших сервисов                                      |
| kill_all      | Убить **все запущенные** контейнеры и удалить сеть (том `${REDDIT_DB_VOLUME_NAME}` не удаляется) |


## HomeWork 14: Docker: сети, docker-compose

### Работа с сетями в Docker

#### Подготовка

- Создаём новый docker-machine и подключаемся к нему
  ```shell
  make docker_machine_create
  docker-machine ls
  ```
  ```log
  NAME          ACTIVE   DRIVER   STATE     URL                        SWARM   DOCKER     ERRORS
  docker-host   -        google   Running   tcp://35.241.253.37:2376           v19.03.5
  ```
  ```shell
  eval $(docker-machine env docker-host)
  ```

#### Работа с сетью в Docker

##### none

- Запуск контейнера с режимом сети `none`
  ```shell
  docker run -ti --rm --network none joffotron/docker-net-tools -c "ifconfig; ping -c4 localhost"
  lo        Link encap:Local Loopback  
            inet addr:127.0.0.1  Mask:255.0.0.0
            UP LOOPBACK RUNNING  MTU:65536  Metric:1
            RX packets:0 errors:0 dropped:0 overruns:0 frame:0
            TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
            collisions:0 txqueuelen:1000 
            RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)

  PING localhost (127.0.0.1): 56 data bytes
  64 bytes from 127.0.0.1: seq=0 ttl=64 time=0.040 ms
  64 bytes from 127.0.0.1: seq=1 ttl=64 time=0.062 ms
  64 bytes from 127.0.0.1: seq=2 ttl=64 time=0.064 ms
  64 bytes from 127.0.0.1: seq=3 ttl=64 time=0.064 ms

  --- localhost ping statistics ---
  4 packets transmitted, 4 packets received, 0% packet loss
  round-trip min/avg/max = 0.040/0.057/0.064 ms
  ```
  - Видим только `lo` интерфейс. Сетевой стек внутри контейнера работает.
  - Может быть применимо для тестирования или для фанимуляции с файлами в volume.

##### host

- Запуск контейнера в сетевом пространстве имён хоста
  ```shell
  docker run -ti --rm --network host joffotron/docker-net-tools -c ifconfig

  docker0   Link encap:Ethernet  HWaddr 02:42:34:B5:56:3D  
            inet addr:172.17.0.1  Bcast:172.17.255.255  Mask:255.255.0.0
            UP BROADCAST MULTICAST  MTU:1500  Metric:1
            RX packets:0 errors:0 dropped:0 overruns:0 frame:0
            TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
            collisions:0 txqueuelen:0 
            RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)

  ens4      Link encap:Ethernet  HWaddr 42:01:0A:84:00:14  
            inet addr:10.132.0.20  Bcast:10.132.0.20  Mask:255.255.255.255
            inet6 addr: fe80::4001:aff:fe84:14%32617/64 Scope:Link
            UP BROADCAST RUNNING MULTICAST  MTU:1460  Metric:1
            RX packets:5504 errors:0 dropped:0 overruns:0 frame:0
            TX packets:4356 errors:0 dropped:0 overruns:0 carrier:0
            collisions:0 txqueuelen:1000 
            RX bytes:108677168 (103.6 MiB)  TX bytes:447776 (437.2 KiB)

  lo        Link encap:Local Loopback  
            inet addr:127.0.0.1  Mask:255.0.0.0
            inet6 addr: ::1%32617/128 Scope:Host
            UP LOOPBACK RUNNING  MTU:65536  Metric:1
            RX packets:0 errors:0 dropped:0 overruns:0 frame:0
            TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
            collisions:0 txqueuelen:1000 
            RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)
   ```
- Для сравнения, `ifconfig` на хосте docker-machine
  ```shell
  docker0   Link encap:Ethernet  HWaddr 02:42:34:b5:56:3d  
            inet addr:172.17.0.1  Bcast:172.17.255.255  Mask:255.255.0.0
            UP BROADCAST MULTICAST  MTU:1500  Metric:1
            RX packets:0 errors:0 dropped:0 overruns:0 frame:0
            TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
            collisions:0 txqueuelen:0 
            RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)
  ens4      Link encap:Ethernet  HWaddr 42:01:0a:84:00:14  
            inet addr:10.132.0.20  Bcast:10.132.0.20  Mask:255.255.255.255
            inet6 addr: fe80::4001:aff:fe84:14/64 Scope:Link
            UP BROADCAST RUNNING MULTICAST  MTU:1460  Metric:1
            RX packets:5779 errors:0 dropped:0 overruns:0 frame:0
            TX packets:4570 errors:0 dropped:0 overruns:0 carrier:0
            collisions:0 txqueuelen:1000 
            RX bytes:108738036 (108.7 MB)  TX bytes:480943 (480.9 KB)
  lo        Link encap:Local Loopback  
            inet addr:127.0.0.1  Mask:255.0.0.0
            inet6 addr: ::1/128 Scope:Host
            UP LOOPBACK RUNNING  MTU:65536  Metric:1
            RX packets:0 errors:0 dropped:0 overruns:0 frame:0
            TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
            collisions:0 txqueuelen:1000 
            RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)
  ```
- Видим, что они идентичны
- docker machine host пересоздан из за проблем подулючения по ssh
- запущен nginx
  ```shell
  docker run --network host -d nginx
  ...
  docker ps
  
  CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS               NAMES
  faa0e86c423f        nginx               "nginx -g 'daemon of…"   6 seconds ago       Up 3 seconds                            distracted_bell
  ```
- запущен ещё один nginx (и ещё, и ещё), результат всегда одинаков
  ```shell
  docker ps

  CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS               NAMES
  faa0e86c423f        nginx               "nginx -g 'daemon of…"   5 minutes ago       Up 5 minutes                            distracted_bell
  ```
- попытка запуска с анализом логов
  ```shell
  docker run --network host -d nginx; docker logs $(docker ps -q | head -n1)
  ```
  ```log
  0d82882d485d9678ad273ea048d2b4631652f3feb1bfb5443efb6ffee6bd8fa0
  2019/11/17 13:01:30 [emerg] 1#1: bind() to 0.0.0.0:80 failed (98: Address already in use)
  nginx: [emerg] bind() to 0.0.0.0:80 failed (98: Address already in use)
  2019/11/17 13:01:30 [emerg] 1#1: bind() to 0.0.0.0:80 failed (98: Address already in use)
  nginx: [emerg] bind() to 0.0.0.0:80 failed (98: Address already in use)
  ```
  Из лога видно, что причина падения -- уже занятый порт 80 в неймспейсе хоста.
- все запущенные контейнеры остановлены
  ```shell
  docker kill $(docker ps -q)
  ```

###### network namespaces

- на docker-host создан симлинк, позволяющий видеть неймспейсы командой `sudo ip netns`
  ```shell
  sudo ln -s /var/run/docker/netns /var/run/netns
  ```
- список неймспейсов без запущенных контейнеров
  ```shell
  $ sudo ip netns
  default
  ```
- список неймспейсов при запущенном контейнере с сетью `none`
  ```shell
  docker run --network none -d nginx
  docker ps
  CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS               NAMES
  d227262ccf99        nginx               "nginx -g 'daemon of…"   6 seconds ago       Up 5 seconds                            zen_mclean
  ```
  на docker-machine
  ```shell
  $ sudo ip netns
  743e31b95726
  default
  ```
  видим, появился новый namespace. Запускаем ещё один контейнер
  ```shell
  docker run --network none -d nginx

  160ca7fec220c182d05a522a1a74143b0114af78220d9ef0370f2bf7be7290c6
  ```
  ```shell
  docker ps                         

  CONTAINER ID        IMAGE               COMMAND                  CREATED              STATUS              PORTS               NAMES
  160ca7fec220        nginx               "nginx -g 'daemon of…"   2 seconds ago        Up 1 second                             crazy_bardeen
  d227262ccf99        nginx               "nginx -g 'daemon of…"   About a minute ago   Up About a minute                       zen_mclean
  ```
  на docker-machine
  ```shell
  $ sudo ip netns
  73f504acb923
  743e31b95726
  default
  ```
  видим 2 неймспейса
- убили все контейнеры `docker kill $(docker ps -q)`
- используем сеть `host`
  ```shell
  docker run --network host -d nginx

  7eda8485e28a626e507d310aecaf6e45bc5aa053266ef8338b196f90df93955c
  ```
  на docker-machine
  ```shell
  $ sudo ip netns

  default
  ```
  неймспейсов создано не было. Вывод - используется неймспейс хоста))
- убили все контейнеры `docker kill $(docker ps -q)`

##### bridge

###### Запуск приложения

- контейнеры запущены с использованием bridge-сети `reddit` и назначенных контейнерам сетевых алиасов
  ```shell
  # make run_all  
  docker network inspect reddit 1>/dev/null || docker network create reddit
  docker volume inspect reddit_db 1>/dev/null || docker volume create reddit_db
  docker run -d --network=reddit \
          --network-alias=post_db \
          --network-alias=comment_db \
          -v reddit_db:/data/db \
          mongo:latest
  0ba10d8e3d43ce40c15a7b622ad09142f8ea2c9dcbe7e828287db98cc2fd5479
  docker run -d --network=reddit \
          --network-alias=post vscoder/post:2.0-alpine
  7df2e80b66e19d0335685a78bb07348c3c02124cef97732124cb745615f1d05a
  docker run -d --network=reddit \
          --network-alias=comment vscoder/comment:2.0-alpine
  37744b362a5838ddda44462e1b9bc580748eaf809c8885ba044f482815c693d2
  docker run -d --network=reddit \
          -p 9292:9292 vscoder/ui:3.0-alpine
  5281ed3316e3050d16e4c2a7d2a54145ad5d72cc127261f3c2b1169f5f52c728
  ```
  ```shell
  # docker ps
  CONTAINER ID        IMAGE                        COMMAND                  CREATED             STATUS              PORTS                    NAMES
  5281ed3316e3        vscoder/ui:3.0-alpine        "puma"                   7 minutes ago       Up 7 minutes        0.0.0.0:9292->9292/tcp   elated_gagarin
  37744b362a58        vscoder/comment:2.0-alpine   "puma"                   7 minutes ago       Up 7 minutes                                 heuristic_murdock
  7df2e80b66e1        vscoder/post:2.0-alpine      "python3 post_app.py"    7 minutes ago       Up 7 minutes                                 jolly_kirch
  5b04e0482132        mongo:latest                 "docker-entrypoint.s…"   8 minutes ago       Up 8 minutes        27017/tcp                modest_proskuriakova
  ```
  приложение доступно по адресу http://35.241.253.37:9292
- Использованы 2 сети reddit_back и reddit_front. 
  - Контейнер ui подключен к сети reddit_front. 
  - Остальные контейнеры подключены к сети reddit_back. 
  - Так как при создании контейнеру можно указать только одну сеть, post и comment подключены к reddit_front после создания.
- Теперь Makefile target выглядит следующим образом
  ```Makefile
  run_all:
  	docker network inspect ${REDDIT_NETWORK_NAME}_back 1>/dev/null || docker network create ${REDDIT_NETWORK_NAME}_back
  	docker network inspect ${REDDIT_NETWORK_NAME}_front 1>/dev/null || docker network create ${REDDIT_NETWORK_NAME}_front
  	docker volume inspect ${REDDIT_DB_VOLUME_NAME} 1>/dev/null || docker volume create ${REDDIT_DB_VOLUME_NAME}
  	docker run -d \
      --name mongo_db \
  		--network=${REDDIT_NETWORK_NAME}_back \
  		--network-alias=post_db \
  		--network-alias=comment_db \
  		-v reddit_db:/data/db \
  		mongo:latest
  	docker run -d \
      --name post \
  		--network=${REDDIT_NETWORK_NAME}_back \
  		--network-alias=post \
  		${DOCKERHUB_LOGIN}/post:${POST_VERSION}
  	docker network connect ${REDDIT_NETWORK_NAME}_front post
  	docker run -d \
      --name comment \
  		--network=${REDDIT_NETWORK_NAME}_back \
  		--network-alias=comment \
  		${DOCKERHUB_LOGIN}/comment:${COMMENT_VERSION}
  	docker network connect ${REDDIT_NETWORK_NAME}_front comment
  	docker run -d \
      --name ui \
  		--network=${REDDIT_NETWORK_NAME}_front \
  		-p 9292:9292 \
  		${DOCKERHUB_LOGIN}/ui:${UI_VERSION}
  ```
- Запущены все контейнеры
  ```shell
  # make run_all
  docker network inspect reddit_back 1>/dev/null || docker network create reddit_back
  docker network inspect reddit_front 1>/dev/null || docker network create reddit_front
  docker volume inspect reddit_db 1>/dev/null || docker volume create reddit_db
  docker run -d \
          --name mongo_db \
          --network=reddit_back \
          --network-alias=post_db \
          --network-alias=comment_db \
          -v reddit_db:/data/db \
          mongo:latest
  596f3227b31e1f90c0ab8fae012659378d7cbc99e047be6d9595ab898a2b7e8c
  docker run -d \
          --name post \
          --network=reddit_back \
          --network-alias=post \
          vscoder/post:2.0-alpine
  f272a11ca047c347e53e253ce4aafef301aa289e62ad5def39847c27c910578d
  docker network connect reddit_front post
  docker run -d \
          --name comment \
          --network=reddit_back \
          --network-alias=comment \
          vscoder/comment:2.0-alpine
  b2ebe7a9d3d8c2e6dbf6169410e8ad61740a6c7564310591ec0a0a023940d8cd
  docker network connect reddit_front comment
  docker run -d \
          --name ui \
          --network=reddit_front \
          -p 9292:9292 \
          vscoder/ui:3.0-alpine
  82db30416d495c1b590a0cefca7d9e8612cbc4b0564dd0c3937ba757ccc48811
  ```
- Работоспособность приложения проверена

###### Анализ

- Список docker-сетей на docker-machine
  ```shell
  $ sudo  docker network ls
  NETWORK ID          NAME                DRIVER              SCOPE
  0166874dac87        bridge              bridge              local
  d183b24032cc        host                host                local
  2c181ec206b6        none                null                local
  7e75ed405d47        reddit_back         bridge              local
  7c243bd0da8a        reddit_front        bridge              local
  ```
- Список br-* интерфейсов на docker-machine
  ```shell
  $ ifconfig | grep br
  br-7c243bd0da8a Link encap:Ethernet  HWaddr 02:42:7a:38:6c:0a  
  br-7e75ed405d47 Link encap:Ethernet  HWaddr 02:42:b4:2d:1a:09
  ```
  имена интефейсов бриджей совпадают с id сетей
- состав бриджей
  ```shell
  $ brctl show br-7c243bd0da8a
  bridge name     bridge id               STP enabled     interfaces
  br-7c243bd0da8a         8000.02427a386c0a       no      veth234d18b
                                                          vethf4cf7bf
                                                          vethfde16ca
  ```
  ```shell
  $ brctl show br-7e75ed405d47
  bridge name     bridge id               STP enabled     interfaces
  br-7e75ed405d47         8000.0242b42d1a09       no      veth257dc23
                                                          veth5af2b40
                                                          veth83d031a
  ```
  veth-интерфейсы соответствуют интерфейсам контейнеров в соответтсвующем бридже
- iptables
  ```shell
  $ sudo iptables -vnL -t nat
  Chain PREROUTING (policy ACCEPT 2523 packets, 151K bytes)
   pkts bytes target     prot opt in     out     source               destination         
    153 13027 DOCKER     all  --  *      *       0.0.0.0/0            0.0.0.0/0            ADDRTYPE match dst-type LOCAL

  Chain INPUT (policy ACCEPT 9 packets, 440 bytes)
   pkts bytes target     prot opt in     out     source               destination         

  Chain OUTPUT (policy ACCEPT 82 packets, 5229 bytes)
   pkts bytes target     prot opt in     out     source              destination         
      0     0 DOCKER     all  --  *      *       0.0.0.0/0           !127.0.0.0/8          ADDRTYPE match dst-type LOCAL

  Chain POSTROUTING (policy ACCEPT 2598 packets, 156K bytes)
   pkts bytes target      prot opt in     out               source               destination         
      0     0 MASQUERADE  all  --  *      !br-7c243bd0da8a  172.20.0.0/16        0.0.0.0/0           
      0     0 MASQUERADE  all  --  *      !br-7e75ed405d47  172.19.0.0/16        0.0.0.0/0           
    254 15387 MASQUERADE  all  --  *      !docker0          172.17.0.0/16        0.0.0.0/0           
      0     0 MASQUERADE  tcp  --  *      *                 172.20.0.4           172.20.0.4           tcp dpt:9292

  Chain DOCKER (2 references)
   pkts bytes target     prot opt in               out    source               destination         
      0     0 RETURN     all  --  br-7c243bd0da8a  *      0.0.0.0/0            0.0.0.0/0           
      0     0 RETURN     all  --  br-7e75ed405d47  *      0.0.0.0/0            0.0.0.0/0           
      0     0 RETURN     all  --  docker0          *      0.0.0.0/0            0.0.0.0/0           
      2   120 DNAT       tcp  --  !br-7c243bd0da8a *      0.0.0.0/0            0.0.0.0/0            tcp dpt:9292 to:172.20.0.4:9292
  ```
  - здесь видно, что перед определением маршрута, весь трафик с `dst-type LOCAL` попадает в цепочку `DOCKER`, в которой
    - возвращается обратно в `PREROUTING`, если пришёл с одного из docker-бриджей
    - если пришёл не с `reddit_front` и на tcp-порт 9292, выполняется редирект на `172.20.0.4:9292` (ui)
  - в цепочке `POSTROUTING` трафик, исходящий из docker-сетей маскируется перед выходом с других интерфейсов
    - так же маскируется трафик между любыми интерфейсами с ip 172.20.0.4 на тот же ip 172.20.0.4 порт назначения tcp 9292
      TODO: разобраться зачем это нужно
- docker-proxy
  ```shell
  $ ps ax | grep docker-proxy
  16085 ?        Sl     0:00 /usr/bin/docker-proxy -proto tcp -host-ip 0.0.0.0 -host-port 9292 -container-ip 172.20.0.4 -container-port 9292
  ```
  запущен 1 процесс `cocker-proxy`
- netstat и lsof
  ```shell
  $ sudo lsof -nPi | grep 9292
  docker-pr 16085        root    4u  IPv6 102960      0t0  TCP *:9292 (LISTEN)
  ```
  видим docker-proxy слушает TCPv6 порт 9292
  ```shell
  $ sudo netstat -apn | grep 9292 
  tcp6       0      0 :::9292                 :::*                    LISTEN      16085/docker-proxy
  ```
  то же самое
  TODO: почему ipv6?

### Использование docker-compose

#### Установка

- В [requirements.txt](requirements.txt) ранее уже был добавлен `docker-compose>=1.24.1`

#### docker-compose.yml

- Создан [src/docker-compose.yml](src/docker-compose.yml)
- В [env](env) добавлеа переменная для экспорта
  ```shell
  export USERNAME=vscoder
  ```
- Сборка образов и запуск контейнеров `docker-compose up -d`
  ```log
  ...
  Creating src_post_1    ... done
  Creating src_ui_1      ... done
  Creating src_comment_1 ... done
  Creating src_post_db_1 ... done
  ```
- `docker ps`
  ```log
  CONTAINER ID        IMAGE                 COMMAND                  CREATED             STATUS              PORTS                    NAMES
  232065aa859d        vscoder/comment:1.0   "puma"                   2 minutes ago       Up About a minute                            src_comment_1
  4d18a821d1a6        mongo:3.2             "docker-entrypoint.s…"   2 minutes ago       Up About a minute   27017/tcp                src_post_db_1
  f7631f5ae799        vscoder/ui:1.0        "puma"                   2 minutes ago       Up About a minute   0.0.0.0:9292->9292/tcp   src_ui_1
  afd5a3874d23        vscoder/post:1.0      "python3 post_app.py"    2 minutes ago       Up About a minute                            src_post_1
  ```
- В браузере открыт http://35.240.72.210:9292/
- всё работает, посты создаются

- Отступление: убрана лишняя директива `RUN` из `src/*/Dockerfile`, создающая рабочий каталок перед заданием `WORKDIR`, так как это делает `WORKDIR` автоматически.
  > If the WORKDIR doesn’t exist, it will be created even if it’s not used in any subsequent Dockerfile instruction.

- Файл [src/docker-compose.yml](src/docker-compose.yml) изменён для использования нескольких сетей
  ```yaml
  version: "3.3"
  services:
    post_db:
      image: mongo:${MONGO_VERSION-3.2}
      volumes:
        - post_db:/data/db
      networks:
        - reddit_back
    ui:
      build: ./ui
      image: ${USERNAME}/ui:${UI_VERSION-1.0}
      ports:
        - 9292:9292/tcp
      networks:
        - reddit_front
    post:
      build: ./post-py
      image: ${USERNAME}/post:${POST_VERSION-1.0}
      networks:
        - reddit_front
        - reddit_back
    comment:
      build: ./comment
      image: ${USERNAME}/comment:${COMMENT_VERSION-1.0}
      networks:
        - reddit_front
        - reddit_back

  volumes:
    post_db:

  networks:
    reddit_front:
    reddit_back:
  ```

##### Переменные окружения

Приоритет источников для значения переменных в контейнере:

When you set the same environment variable in multiple files, here’s the priority used by Compose to choose which value to use:

1. Compose file
2. Shell environment variables
3. Environment file
4. Dockerfile
5. Variable is not defined

- Подробнее про 
  - переменные окружения https://docs.docker.com/compose/environment-variables/
  - подстановку переменных окружения https://docs.docker.com/compose/compose-file/#variable-substitution
    > Important: The .env file feature only works when you use the docker-compose up command and does not work with docker stack deploy.
  - `docker-compose config` чтобы посмотреть отрезолвленный compose-файл https://docs.docker.com/compose/reference/config/
  - Compose CLI environment variables https://docs.docker.com/compose/reference/envvars/
- Создан файл [src/.env](src/.env) со значениями переменных по умолчанию
- Параметризованы следующие параметры
  - `MONGO_VERSION=3.2` - версия mongodb
  - `UI_VERSION=1.0` - версия ui
  - `POST_VERSION=1.0` - версия post-py
  - `COMMENT_VERSION=1.0` - версия comment
  - `UI_PORT=9292` - порт публикации ui
  - `USERNAME=vscoder` - имя пользователя для подстановки в имя образа.
    Например `image: ${USERNAME}/ui:${UI_VERSION}`
- Проверка `docker-compose config`
  ```yaml
  networks:
    reddit_back: {}
    reddit_front: {}
  services:
    comment:
      build:
        context: /mnt/calculate/home/vscoder/projects/otus/devops201908/vscoder_microservices/src/comment
      image: vscoder/comment:1.0
      networks:
        reddit_back: null
        reddit_front: null
    post:
      build:
        context: /mnt/calculate/home/vscoder/projects/otus/devops201908/vscoder_microservices/src/post-py
      image: vscoder/post:1.0
      networks:
        reddit_back: null
        reddit_front: null
    post_db:
      image: mongo:3.2
      networks:
        reddit_back: null
      volumes:
      - post_db:/data/db:rw
    ui:
      build:
        context: /mnt/calculate/home/vscoder/projects/otus/devops201908/vscoder_microservices/src/ui
      image: vscoder/ui:1.0
      networks:
        reddit_front: null
      ports:
      - protocol: tcp
        published: 9292
        target: 9292
  version: '3.7'
  volumes:
    post_db: {}
  ```
- Выполнен запуск всего с публикацией приложения на 80 порту (доступ на 80 разрешён в фаерволе). `export UI_PORT=80 && docker-compose up -d`
- Проверка показала, что приложение доступно на 80 порту

##### Имя проекта

- https://docs.docker.com/compose/#multiple-isolated-environments-on-a-single-host
- Имя проекта по умолчанию берётся из `basename` директории проекта
- Переопределить имя проекта можно 
  - using the [-p command line option](https://docs.docker.com/compose/reference/overview/)
  - using [COMPOSE_PROJECT_NAME environment variable](https://docs.docker.com/compose/reference/envvars/#compose_project_name)

### Задание со \*: docker-compose.override.yml

#### Анализ

[Share Compose configurations between files and projects](https://docs.docker.com/compose/extends/)

By default, Compose reads two files, a docker-compose.yml and an optional docker-compose.override.yml file.
If a service is defined in both files, Compose merges the configurations.
To use multiple override files, or an override file with a different name, you can use the -f option to specify the list of files. Compose merges files in the order they’re specified on the command line.

#### Реализация

- Добавлен файл [src/docker-compose.override.yml](src/docker-compose.override.yml)
- В [src/docker-compose.override.yml](src/docker-compose.override.yml) переопределены следующие параметры:
  - В `/app` контейнера `post` монтируется локальная директория `./post-py`
  - В `/app` контейнера `comment` монтируется локальная директория `./comment`
  - Сервис `puma` в `ui` запускается с параметрами `--debug -w 2`
- В [src/docker-compose.override.yml](src/docker-compose.override.yml) добавлена версия
  ```yaml
  version: "3.3"
  ```
- В [src/docker-compose.override.yml](src/docker-compose.override.yml) описание сервисов помещено в секцию `services:`
- Для каждого сервиса в [src/docker-compose.override.yml](src/docker-compose.override.yml) директория с кодом монтируется в директорию, указанную в соответтсвующей переменной окружения
- Итоговое содержимое [src/docker-compose.override.yml](src/docker-compose.override.yml)
  ```yaml
  ---
  version: "3.3"

  services:
    post:
      volumes:
        - "./post-py:${POST_APP_HOME}"
    comment:
      volumes:
        - "./comment:${COMMENT_APP_HOME}"
    ui:
      volumes:
        - "./ui:${UI_APP_HOME}"
      command: puma --debug -w 2
  ```
- **ВАЖНО** не работает из коробки с docker-machine, необходимо колдовать с [docker-machine mount](https://docs.docker.com/machine/reference/mount/)
- Версия формата докерфайла изменена с `3.7` на `3.3` в связи с тем, что travis-ci не поддерживает более высокую версию

### Вне заданий

- С целью улучшения читаемости, из [.travis.yml] в шелл-скрипты перенесены команды из секций
  - `install` в [.travis-scripts/install.sh](.travis-scripts/install.sh)
  - `before_script` в [.travis-scripts/before_script.sh](.travis-scripts/before_script.sh)


## HomeWork 15: Устройство Gitlab CI. Построение процесса непрерывной поставки

### Развёртывание gitlab

#### Подготовка хоста

- Создана директория [gitlab](gitlab)
- Создан [Makefile](gitlab/Makefile) с набором целей для развёртывания инфраструктуры под gitlab средствами packer, teraform и ansible

##### ansible

- На основе [docker-monolith/ansible](docker-monolith/ansible) создана директория [gitlab/ansible](gitlab/ansible)
- Удалены лишние файлы и директории.
- Оставлен только плейбук [gitlab/ansible/playbooks/docker.yml](gitlab/ansible/playbooks/docker.yml), необходимый для развёртывания docker в packer-образе
- Установлены вынешние ansible-роли

##### packer

- На основе [docker-monolith packer](docker-monolith/packer) создана директория [gitlab/packer](gitlab/packer)
- Дополнен файл с примерами переменных [gitlab/packer/variables.json.example](gitlab/packer/variables.json.example)
  ```json
  {
    "project_id": "docker-ID",
    "source_image_family": "ubuntu-1604-lts",
    "machine_type": "n1-standart-1",
    "disk_size": "60"
  }
  ```
- Заполнены переменные [gitlab/packer/variables.json](gitlab/packer/variables.json)
- Проверена конфигурация packer
  ```shell
  # make packer_validate
  ~/bin/packer --version
  1.4.4
  ~/bin/packer validate -var-file=packer/variables.json packer/docker.json
  Template validated successfully.
  ```
- Собран образ `"image_family": "gitlab-docker-base"`
  ```shell
  # make packer_build
  ...
  ==> Builds finished. The artifacts of successful builds are:
  --> googlecompute: A disk image was created: gitlab-docker-base-1574589582
  ```

##### terraform

- Директория [docker-monolith/terraform](docker-monolith/terraform) скопирована в [gitlab/terraform](gitlab/terraform)
- В [gitlab/terraform/stage/backend.tf](gitlab/terraform/stage/backend.tf) значение `prefix` установлено в `"terraform/gitlab/stage"`
- В [gitlab/terraform/stage/terraform.tfvars.example](gitlab/terraform/stage/terraform.tfvars.example) изменены значения следующих переменных
  ```hcl
  docker_app_disk_image     = "gitlab-docker-base"
  docker_app_tags           = ["gitlab-docker-app"]
  docker_app_tcp_ports      = ["80", "443"]
  ```
- Так же добавлены переменные
  ```hcl
  docker_app_name_prefix    = "gitlab"
  docker_app_machine_type   = "n1-standard-1"
  ```
- Те же переменные добавлены/изменены в [gitlab/terraform/terraform.tfvars](gitlab/terraform/terraform.tfvars)
- Выполнена инициализация terraform
  ```shell
  # make terraform_init
  ...
  Terraform has been successfully initialized!
  ...
  ```
- Выполнена валидация `make terraform_validate`
- Выполнен линтинг `make terraform_tflint`
- Создана инфраструктура `make terraform_apply`
  ```json
  Apply complete! Resources: 2 added, 0 changed, 0 destroyed.

  Outputs:

  docker_app_external_ip = [
    "34.76.206.37",
  ]
  ```

#### Развёртывание gitlab

Все действия выполняются на удалённой машине, развёрнутой в предыдущем пункте

- Созданы необходимые директории
  ```shell
  sudo mkdir -p /srv/gitlab/config /srv/gitlab/data /srv/gitlab/logs
  cd /srv/gitlab/
  sudo touch docker-compose.yml
  ```
- Содержимое `docker-compose.yml`
```yaml
web:
  image: 'gitlab/gitlab-ce:latest'
  restart: always
  hostname: 'gitlab.example.com'
  environment:
    GITLAB_OMNIBUS_CONFIG: |
      external_url 'http://34.76.206.37'
      gitlab_rails['gitlab_shell_ssh_port'] = 2222
  ports:
    - '80:80'
    - '443:443'
    - '2222:22'
  volumes:
    - '/srv/gitlab/config:/etc/gitlab'
    - '/srv/gitlab/logs:/var/log/gitlab'
    - '/srv/gitlab/data:/var/opt/gitlab'
```
- Запущено развёртывание `sudo docker-compose up -d`
- Спустя несколько минут установка завершена
- Задан пароль для пользователя `root` (пользователь по умолчанию)
- Успешно выполнен вход

#### Первоначальная настройка

- Отменена возможность регистрации новых пользователей
  *settings -> general -> sign-up restrictions ->sign-up enabled = false*, *save changes*
- Изменён логин пользователя *Administrator* чтобы усложнить подбор пароля перебором

##### Работа с репозиторием через ssh

- Пользователю добавлен публичный ssh-ключ
- В [gitlab/terraform/stage/terraform.tfvars](gitlab/terraform/stage/terraform.tfvars) разрешён порт `2222`
  ```hcl
  docker_app_tcp_ports = ["80", "443", "2222"]
  ```
- В `docker-comnpose.yml` добавлен параметр `gitlab_rails['gitlab_shell_ssh_port'] = 2222` для работы с git-репозиторием через ssh по порту `2222`

### Создание проекта

- Создана приватная группа `homework`
- Создан приватный проект `example`
- В репозиторий `vscoder_microservices` добавлен удалённый репозиторий созданного проекта
```shell
git remote add gitlab ssh://git@34.76.206.37:2222/otus/example.git
git push gitlab gitlab-ci-1
```

#### CI/CD Pipeline

- Добавлен [.gitlab-ci.yml](.gitlab-ci.yml) содержащий шаблон пайплайна
```yaml
stages:
  - build
  - test
  - deploy

build_job:
  stage: build
  script:
    - echo 'Building'

test_unit_job:
  stage: test
  script:
    - echo 'Testing 1'

test_integration_job:
  stage: test
  script:
    - echo 'Testing 2'

deploy_job:
  stage: deploy
  script:
    - echo 'Deploy'
```

### Runner

- На хосте с gitlab запущен раннер
```shell
docker run -d --name gitlab-runner --restart always \
  -v /srv/gitlab-runner/config:/etc/gitlab-runner \
  -v /var/run/docker.sock:/var/run/docker.sock \
  gitlab/gitlab-runner:latest
```
- Раннер зарегистрирован в gitlab
```shell
docker exec -it gitlab-runner gitlab-runner register --run-untagged --locked=false
```
```shell
> Runtime platform                                    arch=amd64 os=linux pid=13 revision=577f813d version=12.5.0
> Running in system-mode.                            
>                                                    
> Please enter the gitlab-ci coordinator URL (e.g. https://gitlab.com/):
http://34.76.206.37/
> Please enter the gitlab-ci token for this runner:
here_is_token
> Please enter the gitlab-ci description for this runner:
[b1ae79ee8481]: gce-docker-runnel
> Please enter the gitlab-ci tags for this runner (comma separated):
linux,xenial,ubuntu,docker
> Registering runner... succeeded                     runner=QW4GxkHH
> Please enter the executor: parallels, shell, virtualbox, docker+machine, docker-ssh+machine, custom, docker, docker-ssh, ssh, kubernetes:
docker
> Please enter the default Docker image (e.g. ruby:2.6):
alpine:latest
> Runner registered successfully. Feel free to start it, but if it's running already the config should be automatically reloaded!
```
- Пайплайн автоматически был запущен и выполнен успешно

### тестирование Reddit

- Код приложения склонирован из репозитория
```shell
git clone https://github.com/express42/reddit.git && rm -rf ./reddit/.git
git add reddit/
git commit -m "Add reddit app"
git push gitlab gitlab-ci-1
```
