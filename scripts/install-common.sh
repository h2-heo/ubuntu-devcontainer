#!/bin/bash

# Change archive url
if [ -n "${ubuntu_archive_url}" ]; then
  sed -i "s@http://archive.ubuntu.com/ubuntu/@${ubuntu_archive_url}@g" /etc/apt/sources.list
fi

# Install common packages
apt-get update
apt-get install -y \
  curl \
  locales \
  sudo \
  wget
rm -rf /var/lib/apt/lists/*

# Set locale
export LANG=C.UTF-8
export LC_ALL=C.UTF-8
