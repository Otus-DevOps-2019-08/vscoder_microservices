#!/bin/bash
set -eu

# Получаем переменные из файла ./env
. ./env
# Подставляем значения переменных окружения в шаблон конфига и пишем результат в файл
cat config.yml.template | envsubst > config.yml
# Собираем образ
docker build -t $USER_NAME/alertmanager .
# В целях безопасности, удаляем полученный файл конфига
rm config.yml
