# Makefile

## Переменные

| variable  | default                 | description                                                              |
| --------- | ----------------------- | ------------------------------------------------------------------------ |
| BIN_DIR   | ~/bin                   | Путь для установки исполняемых файлов для целей `install_docker_machine` |
| ENV       | stage                   | Название окружения                                                       |
| PACKER    | ${BIN_DIR}/packer       | Путь к исполняемому файлу `packer`                                       |
| ANSIBLE   | ../../.venv/bin/ansible | Путь к исполняемому файлу `ansible`                                      |
| TERRAFORM | ${BIN_DIR}/terraform    | Путь к исполняемому файлу `terraform`                                    |
| TFLINT    | ${BIN_DIR}/tflint       | Путь к исполняемому файлу `tflint`                                       |

## Цели

| target                       | used variables | description                                                                                                                      |
| ---------------------------- | -------------- | -------------------------------------------------------------------------------------------------------------------------------- |
| packer_build                 | PACKER         | Собрать базовый образ из шаблона docker-monolith/packer/docker.json                                                              |
| packer_validate              | PACKER         | Проверить корректность packer-шаблона docker-monolith/packer/docker.json                                                         |
| terraform_init               | ENV, TERRAFORM | Инициализировать terraform для базового окружения `${ENV}` окружения                                                             |
| terraform_init_nobackend     | ENV, TERRAFORM | Инициализировать terraform для окружения `${ENV}`, без инициализации remote backend. Используется в автоматизированных проверках |
| terraform_validate           | TERRAFORM      | Выполнить валидацию всех окружений terraform                                                                                     |
| terraform_tflint             | TFLINT         | Выполнить tflint для всех окружений terraform                                                                                    |
| terraform_apply              | ENV, TERRAFORM | Применить инфраструктуру terraform для окружения `${ENV}`                                                                        |
| terraform_destroy            | ENV, TERRAFORM | Уничтожить инфраструктуру terraform для окружения `${ENV}`                                                                       |
| ansible_install_requirements | ANSIBLE        | Установить внешние роли ansible из [requirements.yml](docker-monolith/ansible/environments/stage/requirements.yml)               |
| ansible_inventory_list       | ANSIBLE        | Показать содержимое ansible-inventory ввформате json                                                                             |
