#!/bin/bash

echo "installing homebrew..."
which brew >/dev/null 2>&1 || /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

echo "run brew doctor..."
which brew >/dev/null 2>&1 && brew doctor

echo "run brew update..."
which brew >/dev/null 2>&1 && brew update

echo "ok. run brew upgrade..."
brew upgrade

#  commands
# TODO remove unnecessary ones
formulas=(
    asciinema
    anyenv
    bat
    ctop
    dat
    direnv
    exa
    ffmpeg
    fd
    gh
    git
    d jrnl
    mas
    mysql
    navi
    nb
    neofetch
    nodebrew
    nnn
    pandoc
    procs
    poppler
    pstree
    sampler
    sd
    sqlite
    starship
    taskell
    thefuck
    tldr
    tmux
    tmuxinator
    tree
    warp
    wget
    yarn
)

echo "brew tap"
# brew tap thirdparty
brew tap homebrew/cask-fonts

echo "brew install formula"
for formula in "${formulas[@]}"; do
    brew install $formula || brew upgrade $formula
done

# gui apps
casks=(
    alfred
    appcleaner
    biscuit
    bitwarden
    cheatsheet
    chromedriver
    dash
    discord
    docker
    drawio
    font-hack-nerd-font
    grammarly
    google-backup-and-sync
    hyperswitch
    iterm2
    itsycal
    kap
    karabiner-elements
    keycastr
    # TODO remove unnecessary ones
    papers
    skitch
    slack
    spotify
    tickeys
    tweeten
    visual-studio-code
    vlc
    xmind
    zoom
)

echo "brew casks"
for cask in "${casks[@]}"; do
    brew install --cask $cask
done

stores=(
    494168017  # Authy
    417375580  # Better Snap Tool
    1423210932 # Flow - Focus & Pomodoro Timer
    1444383602 # Goodnotes5
    975890633  # HotKey App
    539883307  # Line
    568494494  # Pocket
    747648890  # Telegram
    1398373917 # Upnote
    497799835  # Xcode
    457622435  # Yoink
    405399194  # Kindle
)

echo "app stores"
for store in "${stores[@]}"; do
    mas install $store
done

brew cleanup

echo "brew installed"
