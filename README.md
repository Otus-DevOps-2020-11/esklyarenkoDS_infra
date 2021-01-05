# esklyarenkoDS_infra
esklyarenkoDS Infra repository


Домашняя работа №8

- Установлен Terraform v.12.29
- Создан конфигурационный файл для создания инстанса на базе образа из HW7
- Добавлена возможность подключения по SSH и установка сервиса на VM
- Некоторые параметры обозначены в виде INPUT переменных в отдельных файлах

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
