### split zsh
ZSHHOME="${HOME}/.zsh.d"

if [ -d $ZSHHOME -a -r $ZSHHOME -a \
    -x $ZSHHOME ]; then

    # Source the .profile.zsh file first
    profile_zsh="$ZSHHOME/profile.zsh"
    if [ -f "$profile_zsh" -o -h "$profile_zsh" ] && [ -r "$profile_zsh" ]; then
        . "$profile_zsh"
    fi

    # Source the remaining zsh files
    for i in $ZSHHOME/*; do
        if [ "$i" != "$profile_zsh" ]; then
          [[ ${i##*/} = *.zsh ]] && [ \( -f $i -o -h $i \) -a -r $i ]  && . $i
        fi
    done
fi

# Env
eval "$(direnv hook zsh)"
eval "$(nodenv init -)"

source /Users/monokaai/dotfiles/.zsh/rc/alias.zsh

# Settings
setopt auto_cd # 自動でディレクトリ移動
cdpath=(.. ~ ~/work) # 列挙したパス配下へディレクトリ名だけで移動
setopt IGNOREEOF # Ctrl+Dでログアウトしてしまうことを防ぐ
setopt complete_in_word
setopt auto_param_keys
setopt auto_param_slash # ディレクトリ名末尾にスラッシュ付与
setopt correct # スペルミス修正
setopt no_beep # ビープ音の無効化
setopt no_clobber # 上書きリダイレクトの禁止
setopt print_eight_bit # 日本語ファイルの表示

# History
HISTFILE=$HOME/.zsh-history # 履歴を保存するファイル
HISTSIZE=100000             # メモリ上に保存する履歴のサイズ
SAVEHIST=1000000            # 上述のファイルに保存する履歴のサイズ
setopt inc_append_history
setopt share_history
setopt hist_ignore_dups
setopt hist_verify

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
zinit ice as"program" from"gh-r" mv"bat* -> bat" pick"bat/bat"
zinit light sharkdp/bat

if builtin command -v bat > /dev/null; then
    alias cat="bat"
fi
### End of Zinit's setting chunk

# Peco
## ディレクトリの移動履歴を表示
bindkey '^d' anyframe-widget-cdr
autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs
## コマンドの実行履歴を表示
bindkey '^r' anyframe-widget-execute-history
## Gitブランチを表示して切替え
bindkey '^b' anyframe-widget-checkout-git-branch
# GHQでクローンしたGitリポジトリを表示
bindkey '^g' anyframe-widget-cd-ghq-repository

#  https://qiita.com/kazushi47/items/d04715be05dc7c5287e3#anyenv%E3%81%AE%E5%B0%8E%E5%85%A5
export PATH="$HOME/.anyenv/bin:$PATH"
eval "$(anyenv init -)"
export PATH="/opt/homebrew/sbin:$PATH"

