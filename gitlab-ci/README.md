# Makefile

## Переменные

| variable        | default                 | description                                                              |
| --------------- | ----------------------- | ------------------------------------------------------------------------ |
| BIN_DIR         | ~/bin                   | Путь для установки исполняемых файлов для целей `install_docker_machine` |
| ENV             | stage                   | Название окружения                                                       |
| PACKER          | ${BIN_DIR}/packer       | Путь к исполняемому файлу `packer`                                       |
| PACKER_VAR_FILE | packer/variables.json   | путь к файлу с переменными для прожигаемого образа                       |
| ANSIBLE         | ../../.venv/bin/ansible | Путь к исполняемому файлу `ansible`                                      |
| TERRAFORM       | ${BIN_DIR}/terraform    | Путь к исполняемому файлу `terraform`                                    |
| TFLINT          | ${BIN_DIR}/tflint       | Путь к исполняемому файлу `tflint`                                       |

## Цели

| target                       | used variables                                      | description                                                                                                                      |
| ---------------------------- | --------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------- |
| packer_build                 | PACKER, PACKER_VAR_FILE                             | Собрать базовый образ из шаблона packer/docker.json с и спользованием переменных из `${PACKER_VAR_FILE}`                         |
| packer_validate              | PACKER, PACKER_VAR_FILE                             | Проверить корректность packer-шаблона packer/docker.json с и спользованием переменных из `${PACKER_VAR_FILE}`                    |
| packer_build_gitlab          | PACKER_VAR_FILE=packer/variables-gitlab.json        | Собрать образ из `variables-gitlab.json`                                                                                         |
| packer_build_gitlab_runner   | PACKER_VAR_FILE=packer/variables-gitlab-runner.json | Собрать образ из `variables-gitlab-runner.json`                                                                                  |
| packer_build_dev_server      | PACKER_VAR_FILE=packer/variables-stage-server.json  | Собрать образ из `variables-stage-server.json`                                                                                   |
| packer_all                   |                                                     | собрать все образы                                                                                                               |
| terraform_init               | ENV, TERRAFORM                                      | Инициализировать terraform для базового окружения `${ENV}` окружения                                                             |
| terraform_init_nobackend     | ENV, TERRAFORM                                      | Инициализировать terraform для окружения `${ENV}`, без инициализации remote backend. Используется в автоматизированных проверках |
| terraform_validate           | TERRAFORM                                           | Выполнить валидацию всех окружений terraform                                                                                     |
| terraform_tflint             | TFLINT                                              | Выполнить tflint для всех окружений terraform                                                                                    |
| terraform_apply              | ENV, TERRAFORM                                      | Применить инфраструктуру terraform для окружения `${ENV}`                                                                        |
| terraform_destroy            | ENV, TERRAFORM                                      | Уничтожить инфраструктуру terraform для окружения `${ENV}`                                                                       |
| ansible_install_requirements | ANSIBLE                                             | Установить внешние роли ansible из [requirements.yml](docker-monolith/ansible/environments/stage/requirements.yml)               |
| ansible_inventory_list       | ANSIBLE                                             | Показать содержимое ansible-inventory ввформате json                                                                             |
| ansible_lint                 | ANSIBLE                                             | Выполнить ansible-lint для всех плейбуков                                                                                        |
| ansible_syntax               | ANSIBLE                                             | Проверить синтаксис всех плейбуков                                                                                               |
| push_gitlab                  |                                                     | Выполнить пуш ветки `gitlab-ci-1` в remote named `gitlab`                                                                        |
