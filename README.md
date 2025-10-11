# dotfiles

Personal dotfiles managed by [dotbot](https://github.com/anishathalye/dotbot)

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
Required packages (under root user):
```shell
pacman -Sy --needed sudo git base-devel
```

## Bootstrap
Repository cloning
```shell
git clone git@github.com:sanvew/dotfiles.git $HOME/.local/share/dotfiles
```

Full system-based installation
```shell
cd $HOME/.local/share/dotfiles && ./install && cd
```

Skip package installation, files linking only
```shell
cd $HOME/.local/share/dotfiles && SKIP_PACKAGE_INSTALL=1 ./install && cd
```

Minimal Debian/Ubuntu bootstrap
```shell
cd $HOME/.local/share/dotfiles && MINIMAL=1 ./install && cd
```
