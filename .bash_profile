# Prompt 
export PS1="\[\033[0;32m\]\h:\w\n\[\033[1;32m\]\u\$ \[\033[0;37m\]"

# added by Anaconda3 4.4.0 installer
export PATH="/Users/fireplacetv/anaconda/bin:$PATH"

# git shortcuts
if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi

alias glog='git log --oneline -n 10'

alias jp='jupyter notebook'
alias jl='jupyter lab'
# added by Anaconda3 2019.03 installer
# >>> conda init >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$(CONDA_REPORT_ERRORS=false '/anaconda3/bin/conda' shell.bash hook 2> /dev/null)"
if [ $? -eq 0 ]; then
    \eval "$__conda_setup"
else
    if [ -f "/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/anaconda3/etc/profile.d/conda.sh"
        CONDA_CHANGEPS1=false conda activate base
    else
        \export PATH="/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda init <<<
