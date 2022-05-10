# original file was taken from repo https://bitbucket.org/durdn/cfg/src/master/.bin/install.sh
#!/bin/sh

git clone --bare git@github.com:sanvew/dotfiles.git $HOME/.dotfiles
function config {
    /usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME $@
}
mkdir -p .dotfiles-backup
config checkout
if [ $? = 0 ]; then
  echo "Checked out config.";
  else
    echo "Backing up pre-existing dot files.";
    config checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} .dotfiles-backup/{}
fi;
config checkout
config config status.showUntrackedFiles no

# install neovim plugins
nvim --headless +PlugInstall +qa && nvim +UpdateRemotePlugins +qa
