#! /bin/sh

set -eu


function colorPrint() {
    case "$1" in
    "blue" ) printf "\e[34m$2\e[m";;
    "green" ) printf "\e[32m$2\e[m";;
    "red" ) printf "\e[31m$2\e[m";;
    * )
        printf "\e[31m error in colorPrint: invalid args \e[m \n"
        exit 0;;
    esac
}


function logo() {
    # usage: sudo apt install figlet && figlet hoge
    echo -e "\n"
    colorPrint "green" "=============================================================\n"
    colorPrint "green" "|                      _                                    |\n"
    colorPrint "green" "|      __      __ ___ | |  ___  ___   _ __ ___    ___       |\n"
    colorPrint "green" "|      \ \ /\ / // _ \| | / __|/ _ \ | '_ ' _ \  / _ \      |\n"
    colorPrint "green" "|       \ V  V /|  __/| || (__| (_) || | | | | ||  __/      |\n"
    colorPrint "green" "|        \_/\_/  \___||_| \___|\___/ |_| |_| |_| \___|      |\n"
    colorPrint "green" "|                                                           |\n"
    colorPrint "green" "|                         _                                 |\n"
    colorPrint "green" "|                        | |_  ___                          |\n"
    colorPrint "green" "|                        | __|/ _ \                         |\n"
    colorPrint "green" "|                        | |_| (_) |                        |\n"
    colorPrint "green" "|                         \__|\___/                         |\n"
    colorPrint "green" "|                                                           |\n"
    colorPrint "green" "|              _         _     __  _  _                     |\n"
    colorPrint "green" "|           __| |  ___  | |_  / _|(_)| |  ___  ___          |\n"
    colorPrint "green" "|          / _. | / _ \ | __|| |_ | || | / _ \/ __|         |\n"
    colorPrint "green" "|         | (_| || (_) || |_ |  _|| || ||  __/\__ \         |\n"
    colorPrint "green" "|          \__._| \___/  \__||_|  |_||_| \___||___/         |\n"
    colorPrint "green" "|                                                           |\n"
    colorPrint "green" "|                                                Yuto02D2   |\n"
    colorPrint "green" "=============================================================\n"
}


function make_symbolic_link() {
    local DOTFILE_DIR="$HOME/dotfiles-minimum"
    if [ ! -d "$DOTFILE_DIR/backup" ]; then
        mkdir -p "$DOTFILE_DIR/backup"
    fi
    cd dotfiles-minimum
    for file_name in .??*
    do
        # ignore
        [[ "$file_name" = ".git" ]] && continue
        # backup
        if [ -e "$HOME/$file_name" ]; then
            cp -r "$HOME/$file_name" "$DOTFILE_DIR/backup/$file_name.backup"
        fi
        # link
        ln -s -nf -v "$DOTFILE_DIR/$file_name" "$HOME/$file_name"
    done
    cd $HOME
}


function init() {
    logo
    echo -e "\n> initialize dotfiles\n"

    sudo apt update && sudo apt upgrade -y

    # git
    sudo apt install git -y
    if [ ! "$(git config --list | grep user.name)" ]; then
        echo -e "\n> you should setup git config"
        read -p "your git name(ex:TaroYamada): " gitUsername
        read -p "your git email(ex:info@example.com): " gitEmail
        set -v
        git config --global user.name $gitUsername
        git config --global user.email $gitEmail
        set +v
    fi
    cd $HOME
    git clone https://github.com/Yuto02D2-E2/dotfiles-minimum.git

    make_symbolic_link

    # vim
    sudo apt install vim -y
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

    # reload
    source $HOME/.bash_profile

    echo -e "\n> successfull completed @ $(date +%Y/%m/%d@%H:%M:%S)\n"
}


function update() {
    logo
    echo -e "\n> update dotfiles\n"

    make_symbolic_link

    # git add .
    # git commit -m "[update] $(date +%Y/%m/%d@%H:%M:%S)"
    echo -e "\n> successfull completed at $(date +%Y/%m/%d@%H:%M:%S)\n"
}


# --------------------------- entry point ---------------------------------
if [ $# -ne 1 ]; then
    colorPrint "red" "error : missing argument\n"
    colorPrint "red" "Usage:\n"
    colorPrint "red" "\t$ sh config.sh [init | update]\n"
    exit 0
fi
if [ "$1" = "init" ]; then
    init
elif [ "$1" = "update" ]; then
    update
else
    colorPrint "red" "error : invalid argument\n"
    colorPrint "red" "Usage:\n"
    colorPrint "red" "\t$ sh config.sh [init | update]\n"
    exit 0
fi
