# dotfiles
Personal dotfiles managed with [dotbot](https://github.com/anishathalye/dotbot)

## Prerequisites
### Arch (*like*)
Required packages:
```shell
sudo pacman -Sy --needed sudo git base-devel
```

Install package manager for [aur](https://aur.archlinux.org/) packages: [yay](https://github.com/Jguer/yay)
```shell
git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si
```

### Macos
Install [brew](https://brew.sh/)
```shell
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### Debian (*like*)
Supports only **minimal** installation
Required packages (under root user):
```shell
sudo apt install -y git
```

## Bootstrap
Repository cloning
```shell
git clone git@github.com:sanvew/dotfiles.git $HOME/.local/src/dotfiles
```

Full system-based installation
```shell
cd $HOME/.local/src/dotfiles && ./install
```

Skip package installation, files linking only
```shell
cd $HOME/.local/src/dotfiles && ./install --skip-pkg
```

Minimal Debian/Ubuntu bootstrap
```shell
cd $HOME/.local/src/dotfiles && ./install --minimal
```

Configuration update and reload
```shell
reload-dotfiles
```

