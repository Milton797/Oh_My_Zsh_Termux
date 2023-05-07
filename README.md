# ZSH Install In Termux By Milton797

## Table of Contents

- [ZSH Install In Termux By Milton797](#zsh-install-in-termux-by-milton797)
  - [Table of Contents](#table-of-contents)
  - [Requirements](#requirements)
  - [Instructions](#instructions)
    - [Download Termux](#download-termux)
    - [Update your servers repository](#update-your-servers-repository)
    - [Create shortcut to access into "storage" path](#create-shortcut-to-access-into-storage-path)
  - [Install dependencies](#install-dependencies)
    - [Update packages](#update-packages)
    - [Dependencies](#dependencies)
    - [Clean packages](#clean-packages)
  - [Install retrieve content](#install-retrieve-content)
    - [install curl](#install-curl)
    - [install wget](#install-wget)
  - [Run configuration installer](#run-configuration-installer)
    - [Use with curl](#use-with-curl)
    - [Use with wget](#use-with-wget)
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

## Install dependencies

### Update packages

```bash
pkg update --yes && pkg upgrade --yes
```

### Dependencies

```bash
pkg install git zsh figlet nano which python python-pip --yes && pip install lolcat
```

### Clean packages

```bash
pkg clean --yes && pkg autoclean --yes
```

## Install retrieve content

> **Note**
>
> - Usually curl is installed by default on last versions of termux
> - Just need to install one

### install curl

```bash
pkg install curl --yes
```

### install wget

```bash
pkg install wget --yes
```

## Run configuration installer

### Use with curl

```bash
bash -c "$( curl -fsSL https://raw.githubusercontent.com/Milton797/Oh_My_Zsh_Termux/master/install.sh )"
```

### Use with wget

```bash
bash -c "$( wget -O- https://raw.githubusercontent.com/Milton797/Oh_My_Zsh_Termux/master/install.sh )"
```

## Special Thanks To

- [TERMUX](https://termux.com/)

- [robbyrussell - (oh-my-zsh)](https://github.com/robbyrussell/oh-my-zsh/wiki/Installing-ZSH)
- [zsh-users - (zsh-autosuggestions)](https://github.com/zsh-users/zsh-autosuggestions)
- [anorabel - (OhMyTermux)](https://github.com/anorebel/OhMyTermux)
- [Cabbagec - (Termux-ohmyzsh)](https://github.com/Cabbagec/termux-ohmyzsh)
- [4679 - (oh-my-termux)](https://github.com/4679/oh-my-termux)
