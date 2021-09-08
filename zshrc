export PATH="/usr/local/bin:$PATH"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow -g "!{.git,node_modules,coverage}/*" 2> /dev/null'
