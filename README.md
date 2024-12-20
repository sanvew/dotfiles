# dotfiles

Personal dotfiles managed by [dotbot](https://github.com/anishathalye/dotbot)

## Prerequisites
### Arch (like)
Required packages (under root user):
```shell
pacman -Sy --needed sudo git base-devel
```

Install package manager for [aur](https://aur.archlinux.org/) packages: [yay](https://github.com/Jguer/yay)

### Macos
Install [brew](https://brew.sh/)
```shell
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

## Bootstrap
```shell
./install
```

Set "SKIP\_PACKAGE\_INSTALL" env var to skip package installation
```shell
SKIP_PACKAGE_INSTALL=1 ./install
```

