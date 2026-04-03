#!/bin/sh

PACKAGES="
  font-hack-nerd-font
  bash
  bash-completion@2
  lf
  ctpv
  highlight
  jq
  atool
  neovim
  tmux
  tmuxp
"

if [ ! -x "$(command -v brew)" ]; then
  echo "brew command not found. Exiting!"
  return 1
fi

for pkg in $PACKAGES; do
  brew install $pkg
done
