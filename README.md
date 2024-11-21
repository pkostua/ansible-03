# Решение домашнего задания к занятию 2 «Работа с Playbook»
https://github.com/netology-code/mnt-homeworks/tree/MNT-video/08-ansible-02-playbook

### О репозитории
Репозиторий состоит из двух частей  
1. terraform -  Готовит окружение и формирует файл инвентаря, является вспомогательным инcтрументом и не рассматривается в рамках этой работы  
2. ansible - производит установку Clickhouse, Vector и Lighthouse

#### Описание playbook'a

Этот playbook предназначен для установки и настройки Clickhouse, Vector и Lighthouse. Он включает в себя следующие задачи:

* Установка Clickhouse с помощью RPM-пакетов.
* Создание базы данных в Clickhouse.
* Установка и настройка Vector.
* Создание каталога конфигурации Vector.
* Создание файла конфигурации Vector из шаблона.
* Запуск Vector в фоне.
* Установка статических файлов Lighthouse
* Установка веб сервера nginx
* Hастройка nginx для работы с Lighthouse

#### Требования

* Ansible 2.9 или выше.


#### Управление playbook'ом

Чтобы управлять playbook'ом, используйте следующие команды:

Используйте тэг vector для установки Vector
```
ansible-playbook site.yml -i inventory/prod.yml --tags="vector"
```

Используйте тэг clickhouse для установки Clickhouse
```
ansible-playbook site.yml -i inventory/prod.yml --tags="clickhouse"
```

Используйте тэг lighthouse для установки Lighthouse
```
ansible-playbook site.yml -i inventory/prod.yml --tags="lighthouse"
```

Запуститте без тегов для установки Vector, Lighthouse и Clickhouse
```
ansible-playbook site.yml -i inventory/prod.yml 
```

#### Примечания

*  playbook предполагает, что пакеты RPM Clickhouse доступны по умолчанию в репозиториях yum. Если это не так, может потребоваться добавить дополнительные репозитории или настроить менеджер пакетов вручную.
*  playbook создаёт базу данных под названием «logs» в Clickhouse. Вы можете изменить playbook, чтобы создать другую базу данных, если это необходимо.
*  playbook предполагает, что бинарный файл Vector будет установлен в директории, заданной в файле конфигурации `/group_vars/vector/vars.yml` . Если вам нужна другая директирия, вы можете изменить `/group_vars/vector/vars.yml`.
*  Версии ПО вы можете изменить в файлах `/group_vars/vector/vars.yml` `/group_vars/clickhouse/vars.yml`
*  Вы можете изменить источник и путь для установки Lighthouse в файле `/group_vars/lighthouse/vars.yml`

### Права

Чтобы выполнить playbook, необходимы права на установку и удаление программ. Убедитесь, что используется пользователь с этими правами.


### Источники

* [Clickhouse documentation](https://clickhouse.com/docs/en/getting-started/install/)
* [Vector documentation](https://vector.dev/docs/)
* [Lighthouse documentation](https://github.com/VKCOM/lighthouse)