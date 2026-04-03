#!/bin/sh

PACKAGES="
  xclip
  bash
  bash-completion
  lf
  ctpv-git
  highlight
  jq
  atool
  ueberzugpp-new-git
  neovim
  tmux
  tmuxp
"

if [ ! -x "$(command -v yay)" ]; then
  echo "yay command not found. Exiting!"
  return 1
fi

for pkg in $PACKAGES; do
  yay --needed --noconfirm -S $pkg
done
