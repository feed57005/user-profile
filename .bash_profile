# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ls='ls --color=auto --group-directories-first'
alias ll='ls -phg'
alias la='ls -pahl'
alias l='ls -CF'

alias du='du -h'
alias df='df -h'
alias rm='rm -i'
alias cd..='cd ..'

# force tmux 256 color terminal
alias tmux='tmux -2'
