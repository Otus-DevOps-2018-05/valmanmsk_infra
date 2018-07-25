# valmanmsk_infra
## valmanmsk Infra repository
# ДЗ-3:
```
bastion_IP = 35.187.169.128
someinternalhost_IP = 10.142.0.2
```

 1. ssh -i ~/.ssh/appuser -At appuser@35.187.169.128 ssh 10.142.0.2
 2. In .ssh/config add:
```
Host someinternalhost
       HostName 10.142.0.2
       Port 22
       User appuser
       ProxyCommand ssh -i ~/.ssh/appuser -At appuser@35.187.169.128 'nc %h %p'
```

## OR:
```
Host someinternalhost
       HostName 10.142.0.2
       Port 22
       User appuser
       ProxyCommand ssh -o 'ForwardAgent yes' -i ~/.ssh/appuser appuser@35.187.169.128 'nc %h %p'
```

# ДЗ-4:
```
testapp_IP = 35.187.3.107
testapp_port = 9292
```

## Creating Rule for FirWall:
gcloud compute firewall-rules create default-puma-server --allow tcp:9292

## Запуск start-script:
```
добавить к gcloud compute instances create reddit-app \
   --metadata startup-script-url=https://raw.githubusercontent.com/Otus-DevOps-2018-05/valmanmsk_infra/master/startup_script
```

# ДЗ-5:
- Установил packer
- Создал Application Default Credentials (ADC)
- Создал шаблон ubuntu16.json для создания базового образа
- Создал образ reddit-base с помощью этого шаблона
- Сдеплоил приложение на инстанс, созданный из этого образа
- Проверил работу приложения
- Параметризироовал шаблон (ID проекта, source_image_family, machine_type)
- Создал variables.json для параметризированных опций
- Добавил в шаблон другие опции
- Создал шаблон immutable.json для bake образа reddit-full, который содержит в себе сдеплоенное приложение и запускает его при создании инстанса
- Создал скрипт create-redditvm.sh для создания инстанса на основе образа reddit-full

# ДЗ-6:
- Установил Terraform
- Создал файл main.tf с конфигурацией инфраструктуры
- Создал файл outputs.tf с выходными переменными
- Создал файлы files/puma.service и files/deploy.sh для выполнения на инстансе при его старте
- Создал файлы variables.tf и terraform.tfvars в которых сконфигурированы переменные. Отредактировал файл main.tf внеся в него эти переменные.

## Добавление ключей нескольких пользователей
- После добавления в main.tf строки ssh-keys = "appuser1:${file(var.public_key_path)}" и запуска apply выяснил, что ключ пользователя appuser заменился на ключ пользователя appuser1.
- Прописал дополнительных пользователей в одну строку:
```
ssh-keys = "appuser:${file(var.public_key_path)}appuser1:${file(var.public_key_path)}appuser2:${file(var.public_key_path)}"
```
- После добавления ключа для юзера appuser_web через веб-интерфейс и запуска apply, ключ для юзера appuser_web был удален.

## Создание балансировщика
- Создал файл lb.tf, в котором прописал создание HTTP-балансировщика. Добавил его IP в outputs.tf
- Добавил в main.tf код создания инстанса reddit-app2. Добавил его в lb.tf.
- Проверил работу балансировщика при выключении инстансов по очереди.
- Добавил в переменные инстанса параметр count. Выставил его дефолтное значение в 1, а текущее изменил на 2.

# ДЗ-7:
## Задание 1 со *
- Создал файл backend.tf с конфигурацией хранения стейт файла на удаленном бекенде в GCS.
- Переместил конфигурационные файлы terraform в папку вне репозитория. Запустил команды:
```
terraform init
terraform plan
```
Несмотря на отсутствие файла terraform.tfstate в текущей папке, terraform "видит" текущее состояние.

## Задание 2 со *
- Добавил provisioner в модули. Создал папки files в папках модулей app и db, куда положил файлы, используемые provisioner.
- В принципе можно реализовать отключение provisioner в зависимости от значения переменной, создав пустой ресурс:
```
null_resource
```
и присваивая значение переменной параметру count

# ДЗ-8:
## Простой плейбук
- После удаления папки reddit, ```ansible-playbook clone.yml``` выполнилась с changed=1, потому-что понадобилось создание этой папки.
## Задание со *
- Создан inventory.json в котором описаны хосты
- Создан investory.sh, который выводит содержимое файла inventory.json

# ДЗ-9:
## Что сделано
- Создали плейбук с одним сценарием. Для раздлеления задач импользовали тэги и лимит
- Создали плейбук с несколькими сценариями. Теперь можно указывать только тэги
- Создали несколько плейбуков с одним сценарием. Теперь можно указывать только имя плейбука и запускать их из одного файла.
- Изменили в ранее созданных образах секцию Provivsion, в которой запускались скрипты, на тип Ansible.

# ДЗ-10:
## Что сделано
- С помощью ansible-galaxy создали дерево ролей app и db
- Перенесли созданные ранее плейбуки в раздельные роли
- Описали два окружения - prod и stage
- Использовали коммьюнити роль ngnix
- Настроили работу с Ansible Vault

## Задание со *
- Настроили использование динамического инвентори для обеих окружений

# ДЗ-11:
## Что сделано
- Установили VirtualBox и Vagrant
- Создали инфрастуктуру на локальной машине с помощью Vagrant
- Использовали ansible в качестве провижинера
- Установили в среде virtualenvwrapper Molecule
- Установили и настроили роль molecule
- Написали тест для тестирования mogodb и прогнали его
- Переписали плейбуки packer_app.yml и packer_db.yml с использованием ролей app и db

## Дополнительное задание
- Прописали в файле Vagrant конфигурацию для nginx

