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
    exa
    ffmpeg
    fd
    gh
    d jrnl
    mas
    mysql
    navi
    nb
    neovim
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
    bitwarden
    cheatsheet
    docker
    drawio
    google-backup-and-sync
    hyperswitch
    iterm2
    itsycal
    kap
    karabiner-elements
    keycastr
    skitch
    slack
    visual-studio-code
    xmind
    zoom
)

echo "brew casks"
for cask in "${casks[@]}"; do
    brew install --cask $cask
done

stores=(
    417375580  # Better Snap Tool
    975890633  # HotKey App
    568494494  # Pocket
    1398373917 # Upnote
    497799835  # Xcode
)

echo "app stores"
for store in "${stores[@]}"; do
    mas install $store
done

brew cleanup

echo "brew installed"
