# ZSH Install In Termux By Milton797

## Table of Contents

- [ZSH Install In Termux By Milton797](#zsh-install-in-termux-by-milton797)
  - [Table of Contents](#table-of-contents)
  - [Requirements](#requirements)
  - [Instructions](#instructions)
    - [Download Termux](#download-termux)
    - [Update your servers repository](#update-your-servers-repository)
    - [Create shortcut to access into "storage" path](#create-shortcut-to-access-into-storage-path)
    - [Use pkg update](#use-pkg-update)
    - [Install wget](#install-wget)
    - [Copy and paste in terminal this line](#copy-and-paste-in-terminal-this-line)
  - [Special Thanks To](#special-thanks-to)

## Requirements

- Termux
- Phone with android >= 7
- 110MB FREE = Data 102MB - Final 103MB

## Instructions

### Download Termux

- [TERMUX - Github](https://github.com/termux/termux-app#Installation)
- [TERMUX - F-DROID](https://f-droid.org/packages/com.termux/)
- [TERMUX - PlayStore](https://play.google.com/store/apps/details?id=com.termux) (DEPRECATED)

### Update your servers repository

```bash
termux-change-repo
```

### Create shortcut to access into "storage" path

```bash
termux-setup-storage
```

### Use pkg update

```bash
pkg update --yes
```

### Install wget

```bash
pkg install wget --yes
```

### Copy and paste in terminal this line

```bash
bash -c "$( wget https://raw.githubusercontent.com/Milton797/Oh_My_Zsh_Termux/master/install.sh -O - )"
```

## Special Thanks To

- [TERMUX](https://termux.com/)

- [robbyrussell - (oh-my-zsh)](https://github.com/robbyrussell/oh-my-zsh/wiki/Installing-ZSH)
- [zsh-users - (zsh-autosuggestions)](https://github.com/zsh-users/zsh-autosuggestions)
- [anorabel - (OhMyTermux)](https://github.com/anorebel/OhMyTermux)
- [Cabbagec - (Termux-ohmyzsh)](https://github.com/Cabbagec/termux-ohmyzsh)
- [4679 - (oh-my-termux)](https://github.com/4679/oh-my-termux)
