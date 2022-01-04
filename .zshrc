# hook direnv
eval "$(direnv hook zsh)"

source /Users/kosukesuzuki/work/dotfiles/.zsh/rc/alias.zsh

# automatically change directory when dir name is typed
setopt auto_cd
# Ctrl+Dでログアウトしてしまうことを防ぐ
setopt IGNOREEOF
setopt complete_in_word
setopt auto_param_keys
setopt correct
# 上書きリダイレクトの禁止
setopt no_clobber

export LSCOLORS=Exfxcxdxbxegedabagacad
export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'

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
__conda_setup="$('/Users/kosukesuzuki/miniforge3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/kosukesuzuki/miniforge3/etc/profile.d/conda.sh" ]; then
        . "/Users/kosukesuzuki/miniforge3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/kosukesuzuki/miniforge3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

