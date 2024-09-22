# shell
alias la='ls -a --color=auto'
alias ll='ls -la --color=auto'
alias -g C='| pbcopy'
alias -g G='| grep --color=auto'
alias -g L='| less --color=auto'
alias -g H='| headJ'
alias -g T='| tailJ'
alias mkdir='mkdir -p'
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'

# git
alias gs='git status'
alias ga='git add'
alias gau='git add -u'
alias gl='git log'
alias gd='git diff'
alias gco='git checkout'
alias gcz='git-cz'
alias gcb='git checkout -b'
alias gb='git branch'
alias gp='git push'
alias gpom='git pull origin master'

# vim
alias vv='source ~/.vimrc'

# zsh
alias sz='source ~/.zshrc'
alias vz='vi ~/.zshrc'

# docker
alias dc='docker compose'
alias dcu='docker compose up -d'
alias dcb='docker compose build'
alias dcbn='docker compose build --no-cache'
alias dp='docker ps'
alias dcl='docker container ls'
alias de='docker exec -it $(docker ps |peco|awk "{print \$1}") bash'

# uname for Apple/Intel Mac
if (( $+commands[arch] )); then
  alias a64="exec arch -arch arm64e '$SHELL'"
  alias x64="exec arch -arch x86_64 '$SHELL'"
fi

function runs_on_ARM64() { [[ `uname -m` = "arm64" ]]; }
function runs_on_X86_64() { [[ `uname -m` = "x86_64" ]]; }

BREW_PATH_OPT="/opt/homebrew/bin"
BREW_PATH_LOCAL="/usr/local/bin"
function brew_exists_at_opt() { [[ -d ${BREW_PATH_OPT} ]]; }
function brew_exists_at_local() { [[ -d ${BREW_PATH_LOCAL} ]]; }

setopt no_global_rcs
typeset -U path PATH
path=($path /usr/sbin /sbin)

if runs_on_ARM64; then
  path=($BREW_PATH_OPT(N-/) $BREW_PATH_LOCAL(N-/) $path)
else
  path=($BREW_PATH_LOCAL(N-/) $path)
fi