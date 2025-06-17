if [ -f ~/.bashrc ] ; then
  . ~/.bashrc
fi
export PATH="$HOME/.plenv/bin:$PATH"

# added by Anaconda2 5.3.1 installer
# >>> conda init >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$(CONDA_REPORT_ERRORS=false '/Users/dekokun/anaconda2/bin/conda' shell.bash hook 2> /dev/null)"
if [ $? -eq 0 ]; then
    \eval "$__conda_setup"
else
    if [ -f "/Users/dekokun/anaconda2/etc/profile.d/conda.sh" ]; then
        . "/Users/dekokun/anaconda2/etc/profile.d/conda.sh"
        CONDA_CHANGEPS1=false conda activate base
    else
        \export PATH="/Users/dekokun/anaconda2/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda init <<<
# added by Anaconda3 5.3.1 installer
# >>> conda init >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$(CONDA_REPORT_ERRORS=false '/Users/dekokun/anaconda3/bin/conda' shell.bash hook 2> /dev/null)"
if [ $? -eq 0 ]; then
    \eval "$__conda_setup"
else
    if [ -f "/Users/dekokun/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/dekokun/anaconda3/etc/profile.d/conda.sh"
        CONDA_CHANGEPS1=false conda activate base
    else
        \export PATH="/Users/dekokun/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda init <<<
. "$HOME/.cargo/env"

. "$HOME/.local/bin/env"
