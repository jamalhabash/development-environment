# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv virtualenv-init -)"

## don't put duplicate lines or lines starting with space in the history.
## See bash(1) for more options
HISTCONTROL=ignoreboth

## append to the history file, don't overwrite it
## useful for when using two terminals
shopt -s histappend

## for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=2000
HISTFILESIZE=10000

## The purpose of the if-statement is to ensure that when you reload the .bashrc, it will not add to the PROMPT_COMMAND if the history -a is already there.
if ! echo $PROMPT_COMMAND | grep -q "history -a"; then
PROMPT_COMMAND="history -a; $PROMPT_COMMAND"
fi

## The purpose of the cut is to remove the history 1 entry number
hist_prompt() {
    echo "$(date "+%Y-%m-%d.%H:%M:%S") $(pwd) $(history 1 | cut -f 5- -d ' ')" >> $HOME/.logs/bash-history-$(date "+%Y-%m-%d").log
}

## The second if statement is to ensure if it already exists in the prompt_command, not to add it again.
if [[ $- = *i* ]] && (( EUID != 0 )); then
if ! echo $PROMPT_COMMAND | grep -q "\$(hist_prompt);"; then
[[ -d $HOME/.logs ]] || mkdir $HOME/.logs
PROMPT_COMMAND="\$(hist_prompt); $PROMPT_COMMAND"
fi
fi
