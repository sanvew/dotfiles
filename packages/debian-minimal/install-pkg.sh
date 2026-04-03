#!/bin/sh

PACKAGES="
  curl
  neovim
  htop
  bash-completion
"

if [ ! -x "$(command -v apt)" ]; then
  echo "apt command not found. Exiting!"
  return 1
fi

for pkg in $PACKAGES; do
  sudo apt install -y $pkg
done
