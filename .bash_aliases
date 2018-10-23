# Ease
alias e="emacs"
alias c="clear"
alias l="ls -la --color=always"

# Git
alias gc="git commit"
alias gs="git status"
alias gb="git branch -vv"
alias gl="git log --decorate=short"
alias gg="git grep"
alias gr='cd $(git rev-parse --show-toplevel)'

# Finding stuff
alias ff="find . -name"
alias alugrep="grep --color=always -Rin"
alias less="less -RS"
alias www="cd /var/www"

# Misc
alias watch="watch -c "
alias fuck='TF_CMD=$(TF_ALIAS=fuck PYTHONIOENCODING=utf-8 TF_SHELL_ALIASES=$(alias) thefuck $(fc -ln -1)) && eval $TF_CMD && history -s $TF_CMD'
