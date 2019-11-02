# vscoder_microservices
vscoder microservices repository

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

