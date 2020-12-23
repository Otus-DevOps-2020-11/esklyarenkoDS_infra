# esklyarenkoDS_infra
esklyarenkoDS Infra repository

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
