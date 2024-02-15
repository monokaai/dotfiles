# hook direnv
eval "$(direnv hook zsh)"

source /Users/monokaai/dotfiles/.zsh/rc/alias.zsh

# automatically change directory when dir name is typed
setopt auto_cd
# Ctrl+Dでログアウトしてしまうことを防ぐ
setopt IGNOREEOF
setopt complete_in_word
setopt auto_param_keys
setopt correct
# 上書きリダイレクトの禁止
setopt no_clobber

# environments
export LSCOLORS=Exfxcxdxbxegedabagacad
export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
export PERL5LIB=$HOME/perl5/lib/perl5/

# history
HISTFILE=$HOME/.zsh-history # 履歴を保存するファイル
HISTSIZE=100000             # メモリ上に保存する履歴のサイズ
SAVEHIST=1000000            # 上述のファイルに保存する履歴のサイズ

# .zshhistory
setopt inc_append_history
setopt share_history


# enable completion
autoload -Uz compinit && compinit

# 補完候補をそのまま探す -> 小文字を大文字に変えて探す -> 大文字を小文字に変えて探す
zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]}' '+m:{[:upper:]}={[:lower:]}'

### 補完方法毎にグループ化する。
zstyle ':completion:*' format '%B%F{blue}%d%f%b'
zstyle ':completion:*' group-name ''

### 補完侯補をメニューから選択する。
### select=2: 補完候補を一覧から選択する。補完候補が2つ以上なければすぐに補完する。
zstyle ':completion:*:default' menu select=2



# disable ctrl+s, ctrl+q
#setopt no_flow_control

### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

### End of Zinit's installer chunk

zinit light zsh-users/zsh-autosuggestions
zinit light paulirish/git-open # Open related repo by 'git open'
zinit light supercrabtree/k
zinit light mollifier/anyframe
### End of Zinit's setting chunk

# peco でディレクトリの移動履歴を表示
bindkey '^d' anyframe-widget-cdr
autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs

# peco でコマンドの実行履歴を表示
bindkey '^r' anyframe-widget-execute-history

# peco でGitブランチを表示して切替え
bindkey '^b' anyframe-widget-checkout-git-branch

# GHQでクローンしたGitリポジトリを表示
bindkey '^g' anyframe-widget-cd-ghq-repository

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/monokaai/miniforge3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/monokaai/miniforge3/etc/profile.d/conda.sh" ]; then
        . "/Users/monokaai/miniforge3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/monokaai/miniforge3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

#  https://qiita.com/kazushi47/items/d04715be05dc7c5287e3#anyenv%E3%81%AE%E5%B0%8E%E5%85%A5
export PATH="$HOME/.anyenv/bin:$PATH"
eval "$(anyenv init -)"
export PATH="/opt/homebrew/sbin:$PATH"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

ZSHHOME="${HOME}/.zsh.d"

if [ -d $ZSHHOME -a -r $ZSHHOME -a \
    -x $ZSHHOME ]; then
    for i in $ZSHHOME/*; do
        [[ ${i##*/} = *.zsh ]] &&
            [ \( -f $i -o -h $i \) -a -r $i ] && . $i
    done
fi

# nodenvの初期化
eval "$(nodenv init -)"

export PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true
export PUPPETEER_EXECUTABLE_PATH=`which chromium`

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/usr/local/bin/google-cloud-sdk/path.zsh.inc' ]; then . '/usr/local/bin/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/usr/local/bin/google-cloud-sdk/completion.zsh.inc' ]; then . '/usr/local/bin/google-cloud-sdk/completion.zsh.inc'; fi

# go
export GOENV_ROOT=$HOME/.goenv
export PATH=$GOENV_ROOT/bin:$PATH
eval "$(goenv init -)"
