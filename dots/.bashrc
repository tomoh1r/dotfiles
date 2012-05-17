umask 022

# "." コマンドでシェルスクリプトを実行するときは
# 混乱するので PATH を検索させない。
shopt -u sourcepath

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# PROMPT
#PS1="[@${HOST%%.*} %1~]%(!.#.$) " # この辺は好み
PS1="[@\h \W]\$ " # この辺は好み
#RPROMPT="\t" # 右側に時間を表示する
#setopt transient_rprompt # 右側まで入力がきたら時間を消す
#setopt prompt_subst # 便利なプロント
bindkey -v # viライクなキーバインド

export LANG=ja_JP.UTF-8 # 日本語環境
export EDITOR=vim # エディタはvim

autoload -U compinit # 強力な補完機能
compinit -u # このあたりを使わないとzsh使ってる意味なし
setopt autopushd # cdの履歴を表示
setopt pushd_ignore_dups # 同ディレクトリを履歴に追加しない
setopt auto_cd # 自動的にディレクトリ移動
setopt list_packed # リストを詰めて表示
setopt list_types # 補完一覧ファイル種別表示

# 履歴
HISTSIZE=50000
HISTFILESIZE=50000
shopt -s histappend
shopt -u hostcomplete
shopt -s checkhash

#setopt hist_ignore_dups # 重複を記録しない
#setopt hist_reduce_blanks # スペース排除
#setopt share_history # 履歴ファイルを共有
#setopt EXTENDED_HISTORY # zshの開始終了を記録

# alias
alias ls="ls -G"

#zstyle ':completion:*' list-colors 'di=34' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'

# 設定ファイルのinclude
[ -f ~/.bash.alias ] && source ~/.bash.alias
[ -f ~/.bash.include ] && source ~/.bash.include

# if the command-not-found package is installed, use it
if [ -x /usr/lib/command-not-found -o -x /usr/share/command-not-found ]; then
    function command_not_found_handle {
        # check because c-n-f could've been removed in the meantime
        if [ -x /usr/lib/command-not-found ]; then
            /usr/bin/python /usr/lib/command-not-found -- $1
            return $?
        elif [ -x /usr/share/command-not-found ]; then
            /usr/bin/python /usr/share/command-not-found -- $1
            return $?
        else
            return 127
        fi
    }
fi
