# Prompt 
export PS1="\[\033[0;32m\]\h:\w\n\[\033[1;32m\]\u\$ \[\033[0;37m\]"

# git shortcuts
if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi

alias glog='git log --oneline -n 10'
