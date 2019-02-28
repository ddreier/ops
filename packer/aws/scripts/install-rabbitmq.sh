#!/usr/bin/env bash

echo ******************************
echo * Installing RabbitMQ Server *
echo ******************************
cat <<EOF > /tmp/rabbitmq.list
deb http://www.rabbitmq.com/debian/ testing main
EOF
sudo mv /tmp/rabbitmq.list /etc/apt/sources.list.d/rabbitmq.list

curl https://www.rabbitmq.com/rabbitmq-signing-key-public.asc -o /tmp/rabbitmq-signing-key-public.asc
sudo apt-key add /tmp/rabbitmq-signing-key-public.asc
rm /tmp/rabbitmq-signing-key-public.asc

sudo apt-get -qy install rabbitmq-server
sudo rabbitmq-plugins enable rabbitmq_management
sudo systemctl restart rabbitmq-server
