# esklyarenkoDS_infra
esklyarenkoDS Infra repository

Домашняя работа №13

- Установили VirtualBox и Vagrant
- Описали инфраструктуру в файле Vagrantfile
- Доработали роли db и app. Используя Ansible провижинер проверили роли
- Параметризировали роли добавив переменную с пользователем
- Установили pip, Molecule, Testinfra и драйвер Vagrant
- Написали тесты, проверили db роль
- Прогнали успешно тесты
- Поправили плейбуки packer и проверили их работоспособность

Домашняя работа №12

- Перенесли созданные ранее плейбуки в раздельные роли app и db
- Описали в Ansible окружения stage и prod (поменяли inventoryб сделали по умолчанию
  окружение stage, определили переменные)
- Организовали плейбуки
- Добавили коммьюнити роль jdauphant.nginx, чтобы приложение работало на 80 порту
- Для использования Ansible Vault для окружений добавили файлы с пользователями credentials.yml
  и плейбук users.yml для создания их на инстансах. credentials.yml зашифровали

Домашняя работа №11

- Создали плейбук reddit_app.yml
- Добавили сценарии, handlers
- Добавили Unit, шаблон для приложения
- Добавили переменные
- Сделали деплой приложения
- Сделали несколько плейбуков, пересощдали инфраструктуру
  и проверили работу приложения.
- Изменили провижининг в packer для работы с плейбуками Ansible
- Описали модулями Ansible скрипты из предыдущих HW

Домашняя работа №10

- Установили pip и Ansible
- Подняли инфроаструктуру из окружения stage через Terraform
- Создали inventory и inventory.yml файлы
- Убедилиись, что Ansible может управлять хостами командами
    ansible appserver -i ./inventory -m ping
    ansible dbserver -i ./inventory -m ping
- Создали конфигурационный файл ansible.cfg с параметрами
- Поменяли inventory для возможности работы с группами хостов и проверили работу
- Проверили выполнение команд с помощью модулей command, systemd, service
- Написали плейбукв файле clone.yml, который клонирует репозиторий и проверили его работу
- Команда ansible app -m command -a 'rm -rf ~/reddit' удаляет reddit, поэтому при повторном
  выполнении плейбука появляется статус changed=1

Домашняя работа №9

- Проверили зависимость и порядок создания ресурсов
- Создали новые образы отдельно с ruby, отдельно с mongodb
- Структурировали ресурсы. Разбили конфигурацию по файлам
- Переписали на модули, загрузили и проверили их работу
- Конфигурация разнесена в окружения prod и stage

Домашняя работа №8

- Установлен Terraform v.12.29
- Создан конфигурационный файл для создания инстанса на базе образа из HW7
- Добавлена возможность подключения по SSH и установка сервиса на VM
- Некоторые параметры обозначены в виде INPUT переменных в отдельных файлах

Домашняя работа №7

- Установлен Packer
- Создан сервисный аккаунт, которому делигированы права и получен ключ для авторизации с Packer
- Создан файл-шаблон Packer ubuntu16.json
- Создан образ VM, исправлены ошибки
- Добавлена VM на основе созданного образа
- Установлено и запущено приложение reddit
- Шаблон сборки Packer параметризирован.
  Некоторые переменные вынесены в файл variables.json
  В файл variables.json.examples добавлены примеры значений

  Для проверки перейти по адресу http://84.201.158.218:9292

Домашняя работа №6

- Установлен YC CLI
- Добавлены скрипты для установки:
    - Ruby и Bundler (install_ruby.sh),
	- MongoDB,
    - Reddit

Проверить можно перейдя по адресу:
testapp_IP = 178.154.228.73
testapp_port = 9292

Для создания инстанса и деплоя приложения используется metadata.yaml.

Для проверки запустить:
yc compute instance create   --name reddit-app   --hostname reddit-app   --memory=4   --create-boot-disk image-folder-id=standard-images,image-family=ubuntu-1604-lts,size=10GB   --network-interface subnet-name=default-ru-central1-a,nat-ip-version=ipv4   --metadata serial-port-enable=1   --metadata-from-file user-data=metadata.yaml

Домашняя работа №5

Добавлены две VM:
bastion          - 178.154.247.238
someinternalhost - 10.130.0.33

Самостоятельное задание + дополнительное:

Для проброса ssh на другую машину вместо ключа -A можно использовать параметр ForwardAgent в ~/.ssh/config

Host *
ForwardAgent yes

/* Для возможности подключаться командой вида ssh someinternalhost добавим алиасы к хостам */

Host bastion
HostName 178.154.247.238
User appuser

Host someinternalhost
HostName 10.130.0.33
User  appuser
ProxyCommand ssh bastion nc %h %p

При такой конфигурации набрав в консоли ssh bastion попадем на машину bastion
Набрав ssh someinternalhost попадем на someinternalhost через bastion
Проверить можно командой hostname

Установка и настройка VPN Pritunl

При установке сервера Pritunl скриптом из методички возникали ошибки, поэтому воспользовался следующим:

/* setupvpn.sh */
sudo tee -a /etc/apt/sources.list.d/mongodb-org-3.6.list << EOF
deb http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.6 multiverse
EOF
sudo tee -a /etc/apt/sources.list.d/pritunl.list << EOF
deb http://repo.pritunl.com/stable/apt xenial main
EOF
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com --recv 2930ADAE8CAF5059EE73BB4B58712A2291FA4AD5
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com --recv 7568D9BB55FF9E5287D586017AE645C0CF8E292A
sudo apt update
sudo apt --assume-yes install pritunl mongodb-org
sudo systemctl start pritunl mongod
sudo systemctl enable pritunl mongod

Для выполнения дополнительного задания адрес 178.154.247.238.xip.io был добавлен в let's encrypt, что позволяет использовать валидный сертификат
https://178.154.247.238.xip.io/

bastion_IP = 178.154.247.238
someinternalhost_IP = 10.130.0.33
