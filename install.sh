#!/data/data/com.termux/files/usr/bin/bash

main() {

  ##############################################################################################################

  # Use colors, but only if connected to a terminal, and that terminal supports them.

  if which tput >/dev/null 2>&1; then
    ncolors=$(tput colors)
  fi

  if [ -t 1 ] && [ -n "$ncolors" ] && [ "$ncolors" -ge 8 ]; then
    RED="$(tput setaf 1)"
    GREEN="$(tput setaf 2)"
    YELLOW="$(tput setaf 3)"
    BLUE="$(tput setaf 4)"
    BOLD="$(tput bold)"
    NORMAL="$(tput sgr0)"
  else
    RED="\e[31m"
    GREEN="\e[32m"
    YELLOW="\e[33m"
    BLUE="\e[34m"
    BOLD="\e[1m"
    NORMAL="\e[0m"
  fi

  ##############################################################################################################

  # Only enable exit-on-error after the non-critical colorization stuff,
  # which may fail on systems lacking tput or terminfo

  set -e

  # Check if .oh-my-zsh exist

  if [ ! -n "$ZSH" ]; then
    ZSH=~/.oh-my-zsh
  fi

  # Exit if .oh-my-zsh exist

  if [ -d "$ZSH" ]; then
    echo -e "${BLUE}You already have Oh-My-Zsh installed.\n"
    echo -e "You'll need to remove $ZSH if you want to re-install.${NORMAL}\n"
    exit
  fi

  ##############################################################################################################

  # PATHS and variabels.

  # PATHS

  ZSHRC=~/.zshrc
  DOT_TERMUX=~/.termux
  dir_files=~/dir_files

  url_autosuggestions=https://github.com/zsh-users/zsh-autosuggestions.git
  dir_autosuggestions=$ZSH/custom/plugins/zsh-autosuggestions
  url_zsh_syntax_highlighting=https://github.com/zsh-users/zsh-syntax-highlighting.git
  dir_zsh_syntax_highlighting=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

  url_powerlevel10k=https://github.com/romkatv/powerlevel10k.git
  dir_powerlevel10k=${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

  url_dot_termux=https://github.com/Milton797/Oh_My_Zsh_Termux.git
  dir_dot_termux_files=~/dir_files/dot_termux/.termux

  # Variables

  text_colors+=' \\n# ↓ For colors ↓\n\nif which tput >/dev/null 2>&1; then\n  ncolors=$(tput colors)\nfi\n'
  text_colors+='\nif [ -t 1 ] && [ -n "$ncolors" ] && [ "$ncolors" -ge 8 ]; then\n  RED="$(tput setaf 1)"\n'
  text_colors+='  GREEN="$(tput setaf 2)"\n  YELLOW="$(tput setaf 3)"\n  BLUE="$(tput setaf 4)"\n  BOLD="$(tput bold)"\n'
  text_colors+='  NORMAL="$(tput sgr0)"\nelse\n  RED="\e[31m"\n  GREEN="\e[32m"\n  YELLOW="\e[33m"\n  BLUE="\e[34m"\n'
  text_colors+='  BOLD="\e[1m"\n  NORMAL="\e[0m"\nfi\n\n#↑ Colors variables HERE ↑'

  ##############################################################################################################

  # Start script.

  echo -e "\n${GREEN}Script Start - Installing Oh-My-Zsh In ${RED}(Termux)${NORMAL}\n" && sleep 1

  ##############################################################################################################

  # Download packages && update system.

  echo -e "${BLUE}↓ 1 of 8 | Start to download packages and update system ↓${NORMAL}\n" && sleep 3


  echo -e "\n${YELLOW}1 of 4 System Update.${NORMAL}\n" && sleep 3
  echo -e "${GREEN}$( pkg update --yes && pkg upgrade --yes && sleep .2 )\n\n${RED}Done, System update.${NORMAL}"

  echo -e "\n${YELLOW}2 of 4 Install python and lolcat.${NORMAL}\n" && sleep 3
  echo -e "${GREEN}$( pkg install python --yes && pkg install python-pip --yes && pip install lolcat && sleep .2 )\n\n${RED}Done, Python and lolcat installed.${NORMAL}"

  echo -e "\n${YELLOW}3 of 4 Install git, zsh, figlet, nano.${NORMAL}\n" && sleep 3
  echo -e "${GREEN}$( pkg install git zsh figlet nano --yes && sleep .2 )\n\n${RED}Done, Git, zsh, figlet, nano installed.${NORMAL}"

  echo -e "\n${YELLOW}4 of 4 Autoremove unused packages.${NORMAL}\n" && sleep 3
  echo -e "${GREEN}$( pkg autoremove --yes && sleep .2 )\n\n${RED}Done, Autoremove.${NORMAL}"


  echo -e "\n↑ Done, Packages downloaded and updated system ↑\n\n\n" | lolcat && sleep 3

  ##############################################################################################################

  # If ".termux" existing before this install to do backup file.

  echo -e "${BLUE}↓ 2 of 8 | Backup old data ↓${NORMAL}\n" && sleep 3

  echo -e "${YELLOW}1 of 2 Looking for an existing .termux config...${NORMAL}\n" && sleep 3
  if [ -d "$DOT_TERMUX" ]; then
    echo -e "${GREEN}$( mv $DOT_TERMUX $DOT_TERMUX.bak )\nDone, Found $DOT_TERMUX Backup up to $DOT_TERMUX.bak${NORMAL}\n"
  else
    echo -e "${GREEN}$DOT_TERMUX doesn't exist before, Nothing to backup.${NORMAL}\n"
  fi
  echo -e "${RED}Done, Check $DOT_TERMUX old version.${NORMAL}\n"

  # If ".zshrc" existing before this install to do backup file.

  echo -e "${YELLOW}2 of 2 Looking for an existing zsh config...${NORMAL}\n" && sleep 3
  if [ -f $ZSHRC ] || [ -h $ZSHRC ]; then
    echo -e "${GREEN}$( mv $ZSHRC $ZSHRC.pre-oh-my-zsh )\nDone, Found $ZSHRC Backup up to $ZSHRC.pre-oh-my-zsh${NORMAL}\n"
  else
    echo -e "${GREEN}$ZSHRC doesn't exist before, Nothing to backup.${NORMAL}\n"
  fi
  echo -e "${RED}Done, Check $ZSHRC old version.${NORMAL}\n"

  echo -e "↑ Done, Backup old data ↑\n\n\n" | lolcat && sleep 3

  ##############################################################################################################

  echo -e "${BLUE}↓ 3 of 8 | Download and copy required files. ↓${NORMAL}\n" && sleep 3

  # Download and copy original files to oh-my-zsh from robbyrussell

  echo -e "${YELLOW}1 of 4 Installing Oh My Zsh.${NORMAL}\n" && sleep 3
  sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

  # Copy required files to ".termux" from anorebel

  echo -e "${YELLOW}2 of 4 .termux Download and copy${NORMAL}\n" && sleep 3
  echo -e "$( git clone $url_dot_termux dir_files --depth 1 )${GREEN}\nDone.${NORMAL}\n"
  echo -e "$( cp -R $dir_dot_termux_files $DOT_TERMUX )${RED}Done, .termux Copied in $dot_termux${NORMAL}\n"

  # Install autosuggestions for zsh from zsh-users

  echo -e "${YELLOW}3 of 4 /.zsh-autosuggestions Download and copy.${NORMAL}\n" && sleep 3
  echo -e "$( git clone $url_autosuggestions $dir_autosuggestions --depth 1 )${GREEN}\nDone.\n"
  echo -e "${RED}Done, Downloaded and copied in $dir_autosuggestions${NORMAL}\n"

  # Install zsh-syntax-highlighting for zsh from zsh-users

  echo -e "${YELLOW}4 of 4 /.zsh-syntax-highlighting Download and copy.${NORMAL}\n" && sleep 3
  echo -e "$( git clone $url_zsh_syntax_highlighting $dir_zsh_syntax_highlighting --depth 1 )${GREEN}\nDone.\n"
  echo -e "${RED}Done, Downloaded and copied in $dir_zsh_syntax_highlighting${NORMAL}\n"

  echo -e "↑ Done, Required files copied ↑\n\n\n" | lolcat && sleep 3

  ##############################################################################################################

  # Create ".zshrc" with initial config.

  echo -e "${BLUE}↓ 4 of 8 | Copy template in $ZSHRC ↓${NORMAL}\n" && sleep 3

  echo -e "${YELLOW}1 of 1 Using the oh-my-zsh template file and adding it to $ZSHRC${NORMAL}\n"
  echo -e "$( cp $ZSH/templates/zshrc.zsh-template $ZSHRC )${GREEN}Done, Oh-my-zsh template adding${NORMAL}\n"
  echo -e "${RED}Template in in $ZSHRC${NORMAL}\n"

  echo -e "↑ Done, Copy template ↑\n\n\n" | lolcat && sleep 3

  ##############################################################################################################

  # Set default shell Oh-My-Zsh.

  echo -e "${BLUE}↓ 5 of 8 | Start to do zsh default shell ↓${NORMAL}\n" && sleep 3

  echo -e "${YELLOW}1 of 1 Making zsh your default shell using 'chsh -s'${NORMAL}\n"
  echo -e "$( chsh -s zsh )${GREEN}Done, Zsh default shell.${NORMAL}\n"
  echo -e "${RED}Zsh is default shell now.${NORMAL}\n"

  echo -e "↑ Done, Zsh for use for default shell now ↑\n\n\n" | lolcat && sleep 3

  ##############################################################################################################

  # Modify config in ".zshrc".

  echo -e "${BLUE}↓ 6 of 8 | .zshrc Modify ↓${NORMAL}" && sleep 3

  read -p 'Wanna use Powerlevel10k as theme? [y/n] → ' data;
  if [[ "$data" == [Yy] ]]; then
    echo -e "$( git clone $url_powerlevel10k $dir_powerlevel10k --depth 1 )${GREEN}\nDone.\n"
    echo -e "\n${RED}Adding Powerlevel10k theme, you can change it later to anything in the $ZSHRC${NORMAL}"
    sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="powerlevel10k/powerlevel10k"/gi' $ZSHRC
  else
    echo -e "\n${RED}Adding the agnoster theme, you can change it later to anything in the $ZSHRC${NORMAL}"
    sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="agnoster"/gi' $ZSHRC
  fi

  sed -i 's/# export UPDATE_ZSH_DAYS=13/ export UPDATE_ZSH_DAYS=1/gi' $ZSHRC
  sed -i 's/# DISABLE_AUTO_UPDATE="true"/ DISABLE_AUTO_UPDATE="true"/gi' $ZSHRC
  sed -i 's/plugins=(git)/plugins=(\n  git\n  pip\n  sudo\n  ruby\n  pep8\n  python\n  autopep8\n  web-search\n  zsh-autosuggestions\n  zsh-syntax-highlighting\n)/gi' $ZSHRC
  sed -i "$ a $text_colors" $ZSHRC

  # Configure language

  while true
  echo -e "${BLUE}"
  do
    read -r -p "What print you use (? English terminal or Spanish terminal [EN/ES] → " input
    case $input in
      [eE][sS])
    echo -e "\n${RED}You selected Spanish terminal, You can change this in $ZSHRC line 83 and 84, put your locale language.\n"
    sed -i 's/# export LANG=en_US.UTF-8/export LANG=es_ES.UTF-8\nexport LC_CTYPE=es_ES.UTF-8/gi' $ZSHRC

    echo -e "You want delete :HOLA\!: Message (? removing :figlet -f standard HELLO! | lolcat: use → nano $ZSHRC to open${NORMAL}"
    sed -i '$ a \\n# ↓ Config Users HERE ↓\n\nclear\nfiglet -f standard "HOLA!" | lolcat\n\n# ↑ HERE for more config ↑' $ZSHRC

    break
    ;;
      [eE][nN])
    echo -e "\n${RED}You selected English terminal, You can change this in $ZSHRC line 83 and 84, put your locale language.\n"
    sed -i 's/# export LANG=en_US.UTF-8/export LANG=en_US.UTF-8\nexport LC_CTYPE=en_US.UTF-8/gi' $ZSHRC

    echo -e "You want delete :HELLO\!: Message (? removing :figlet -f standard HELLO! | lolcat: use → nano $ZSHRC to open${NORMAL}"
    sed -i '$ a \\n# ↓ Config Users HERE ↓\n\nclear\nfiglet -f standard "HELLO!" | lolcat\n\n# ↑ HERE for more config ↑' $ZSHRC

    break
        ;;
      *)
    echo -e "${RED}Invalid Lang ....."
    ;;
    esac
  done

  echo -e "\n${RED}List of themes here → https://github.com/robbyrussell/oh-my-zsh/wiki/Themes${NORMAL}"

  sleep 6

  echo -e "\n↑ Done .zshrc Modify ↑\n" | lolcat && sleep 3

  ##############################################################################################################

  # Make exotic words with colors LOL. && You can see more styles with showfigfonts.

  for x in "GOOD!" "WAIT" "MORE" "PLEASE" "WE ARE" "CLOSE."
  do
    figlet -f standard $x | lolcat && sleep .7
  done
  sleep 3

  ##############################################################################################################

  # Select colors.

  echo -e "\n${BLUE}↓ 7 of 8 | Change bash styles ↓${NORMAL}\n"

  echo -e "${YELLOW}1 of 2 Choose your color scheme now.${NORMAL}\n" && sleep 3
  bash $DOT_TERMUX/colors.sh |lolcat
  echo -e "\n${GREEN}Done, Color scheme applied."
  echo -e "If you want to change color scheme after, use: bash $DOT_TERMUX/colors.sh${NORMAL}\n"

  # Select Font.

  echo -e "${YELLOW}2 of 2 Choose your font now.${NORMAL}\n" && sleep 3
  bash $DOT_TERMUX/fonts.sh | lolcat
  echo -e "\n${GREEN}Done, Font applied"
  echo -e "If you want to change font after, use: bash $DOT_TERMUX/fonts.sh${NORMAL}\n"

  echo -e "↑ Done, Styles changed ↑\n\n\n" | lolcat && sleep 3

  ##############################################################################################################

  # Remove unused repositories after for this install.

  echo -e "${BLUE}↓ 8 of 8 | Remove unused repositories ↓${NORMAL}\n" && sleep 3

  echo -e "${YELLOW}1 of 2 Trying to delete old bash_history.${NORMAL}\n" && sleep 3
  if [ -f "$HOME/.bash_history" ]; then
    echo -e "$( rm -rf ~/.bash_history )${GREEN}Done, Old history of bash deleted.${NORMAL}\n"
  else
    echo -e "${GREEN}You not have old bash history.${NORMAL}\n"
  fi
  echo -e "${RED}Done, Old bash_history delete.${NORMAL}\n"

  echo -e "${YELLOW}2 of 2 Trying to delete main repository.${NORMAL}\n" && sleep 3
  if [ -d "$dir_files" ]; then
    echo -e "$( rm -rf $dir_files )${GREEN}Done, Delete main repository.${NORMAL}\n"
  else
    echo -e "${GREEN}O.o Main repository not deleted .....${NORMAL}\n"
  fi
  echo -e "${RED}Done, Main repository delete.${NORMAL}\n"

  echo -e "↑ Done, deleted repositories ↑\n\n\n" | lolcat && sleep 3

  ##############################################################################################################

  # Finish screen.

  for x in "ZSH ;3" "LAST" "STEPS"
  do
    figlet -f standard $x | lolcat && sleep .7
  done
  sleep 3

  echo -e "${GREEN}"
    echo -e "\n→ Is now installed! ...... ←\n"
    echo -e "→ Take look over the $ZSHRC use : nano $ZSHRC : To go file to select plugins, themes, and options. ←\n"
    echo -e "→ You can use : upgrade_oh_my_zsh : to update oh-my-zsh. after restart TERMUX app ←\n"
    echo -e "→ If you want after to change color schame use : bash $DOT_TERMUX/colors.sh : ←\n"
    echo -e "→ If you want after to change font use : bash $DOT_TERMUX/fonts.sh : ←\n"
    echo -e "→ Please restart TERMUX app... To avoid bugs but you can use it. ¯\_(ツ)_/¯ ←\n"
    echo -e "If you saw :warning linker unsupported flags dt_flags_1=0x8: during install ignore it, it´s error on android v5."
  echo -e "${NORMAL} $( sleep 10 )"

  ##############################################################################################################

  # Finish

  sleep 3
  for x in "END ;3" "BYE o.o/"
  do
    figlet -f standard $x | lolcat && sleep .7
  done

  # Start Zsh

  clear && sleep 1 && env zsh -l

}

# Start all operations of scrit.

main
