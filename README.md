# My dotfiles
This repository contains all my most important configs and how to set them up.

## Requirements
Ensure you have the following installed on your system.

### Git
**Ubuntu/Debian**
```ubuntu
sudo apt install git
```

**Arch**
```arch
sudo pacman -S git
```

### Stow
**Ubuntu/Debian**
```ubuntu
sudo apt install stow
```

**Arch**
```arch
sudo pacman -S stow
```
### Installation
First, clone the dotfiles repo to your home directory.

```
git clone git@github.com/Ericode254/dotfiles.git
cd dotfiles
```
Then use GNU stow to create symlinks

```
stow .
```


