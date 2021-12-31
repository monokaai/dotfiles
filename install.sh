#!/usr/bin/env bash

# https://qiita.com/ganyariya/items/d9adffc6535dfca6784b
# 未定義な変数があったら途中で終了する
set -u

# 今のディレクトリ=dotfilesに移動する
BASEDIR=$(dirname $0)
cd $BASEDIR

# dotfilesにある、ドットから始まり2文字以上の名前のファイルに対して
for f in .??*; do
    #  対象外ファイル
    [ "$f" = ".git" ] && continue
    [ "$f" = ".gitconfig.local.template" ] && continue
    [ "$f" = ".gitmodules" ] && continue

    # シンボリックリンクを貼る
    ln -snfv ${PWD}/"$f" ~/
done
