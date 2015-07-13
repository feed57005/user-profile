# basic platform detect
platform='unknown'
unamestr=`uname`
if [[ "$unamestr" == 'Linux' ]]; then
   platform='linux'
elif [[ "$unamestr" == 'Darwin' ]]; then
   platform='osx'
elif [[ "$unamestr" == 'FreeBSD' ]]; then
   platform='freebsd'
fi

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
	test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi

# setup prompt
export PS1="\[\e[0;32m\]\u\[\e[0m\]@\h:\[\e[0;36m\]\W\[\e[0m\]$ "

# aliases

if [[ $platform == 'linux' ]]; then
	alias ls='ls --color=auto'
elif [[ $platform == 'osx' ]]; then
	alias ls='ls -G'
fi

alias ll='ls -phg'
alias la='ls -pahl'
alias l='ls -CF'

alias du='du -h'
alias df='df -h'
alias rm='rm -i'
alias cd..='cd ..'

alias grep='grep --color=auto'

# force tmux 256 color terminal
alias tmux='tmux -2'

# setup ssh-agent
SSH_ENV="$HOME/.ssh/environment"

function start_agent {
	echo "Initialising new SSH agent..."
	/usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
	echo succeeded
	chmod 600 "${SSH_ENV}"
	. "${SSH_ENV}" > /dev/null
	/usr/bin/ssh-add;
}

# Source SSH settings, if applicable
if [[ $platform == 'linux' ]]; then
	if [ -f "${SSH_ENV}" ]; then
		. "${SSH_ENV}" > /dev/null
		ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
			start_agent;
		}
	else
		start_agent;
	fi
fi

if [[ $platform == 'linux' ]]; then
	export LC_ALL=en_US.UTF-8
	export LANG=en_US.UTF-8
	export LANGUAGE=en_US.UTF-8
fi

# if neovim is installed use it instead of vim
if type nvim &> /dev/null; then
	alias vim='nvim'
fi

# PATH config

export PATH=~/bin:$PATH

if [ -e .java_profile ]; then
	source .java_profile
fi

