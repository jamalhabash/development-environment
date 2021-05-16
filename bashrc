# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv virtualenv-init -)"

HISTCONTROL=ignoreboth

shopt -s histappend

HISTSIZE=2000
HISTFILESIZE=10000
HISTTIMEFORMAT="[%F %T] "

PROMPT_COMMAND="history -a; $PROMPT_COMMAND"

hist_prompt() {
    echo "$(date "+%Y-%m-%d.%H:%M:%S") $(pwd) $(history 1)" >> $HOME/.logs/bash-history-$(date "+%Y-%m-%d").log
}

if [[ $- = *i* ]] && (( EUID != 0 )); then
[[ -d $HOME/.logs ]] || mkdir $HOME/.logs
PROMPT_COMMAND="\$(hist_prompt); $PROMPT_COMMAND"
fi
