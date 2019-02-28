#!/usr/bin/env bash

sudo sed -i "s/127\.0\.0\.1\s+\w+/127\.0\.0\.1 \$(hostname)/g" /etc/hosts
cat <<EOF > /tmp/cron-hostname
@reboot root sed -i "s/127\.0\.0\.1\s+\w+/127\.0\.0\.1 \$(hostname)/g" /etc/hosts
EOF
sudo mv /tmp/cron-hostname /etc/cron.d/set-hostname
sudo chown root:root /etc/cron.d/set-hostname
sudo chmod g-w /etc/cron.d/set-hostname

echo ****************
echo * Updating APT *
echo ****************
sudo apt-get update -q
sudo apt-get install -yq unattended-upgrades apt-listchanges

echo **************************
echo * Run unattended-upgrade *
echo **************************
sudo unattended-upgrade

echo ************************
echo * Disable Auto Updates *
echo ************************
sudo sed -i 's/1/0/g' /etc/apt/apt.conf.d/20auto-upgrades
sudo sed -i 's/1/0/g' /etc/apt/apt.conf.d/10periodic
sudo rm /etc/cron.daily/apt-compat

echo ****************************
echo * Install Default Packages *
echo ****************************
sudo apt-get install -yq dnsmasq-base dnsmasq zip unzip nmon htop

echo ************************
echo * Update SSHD settings *
echo ************************
sudo sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config

echo *********************
echo * Configure dnsmasq *
echo *********************
cat <<EOF > /tmp/dnsmasq-consul
server=/consul/127.0.0.1#8600
EOF
cat <<EOF > /tmp/resolv.conf
nameserver 127.0.0.1
nameserver 169.254.169.253
EOF
sudo mv /tmp/dnsmasq-consul /etc/dnsmasq.d/consul
sudo ln -s /etc/dnsmasq.d/consul /etc/dnsmasq.d-available/consul
sudo rm /etc/resolv.conf
sudo mv /tmp/resolv.conf /etc/resolv.conf

#cat /etc/dnsmasq.d/consul
#cat /etc/resolv.conf

sudo systemctl stop systemd-resolved
sudo systemctl disable systemd-resolved
sudo systemctl restart dnsmasq

echo ********************
echo * Add Default User *
echo ********************
echo Adding default user...
sudo useradd -d /home/ddreier -m -s /bin/bash -UG sudo ddreier
echo ddreier:r00tr00t | sudo chpasswd
sudo passwd -e ddreier
