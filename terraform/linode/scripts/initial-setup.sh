#!/usr/bin/env bash


# Set the timezone
# https://stackoverflow.com/a/42344810/390192
ln -fs /usr/share/zoneinfo/America/Chicago /etc/localtime
dpkg-reconfigure --frontend noninteractive tzdata

# Upgrade all packages except for grub, which prompts for some questions
apt update -yq
apt install -yq unattended-upgrades nmon htop unzip liblttng-ust0 libcurl4 libssl1.0.0  libkrb5-3 zlib1g libicu60 libunwind8 libuuid1
