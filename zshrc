export EDITOR=vim
export VISUAL=vim

export PATH="/usr/local/bin:$PATH"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow -g "!{.git,node_modules,coverage}/*" 2> /dev/null'

# Load Git completion
zstyle ':completion:*:*:git:*' script ~/.zsh/git-completion.bash
fpath=(~/.zsh $fpath)

autoload -Uz compinit && compinit

# See https://github.com/github/codespaces/issues/2851
export HISTFILE=/workspaces/.codespaces/.persistedshare/.zsh_history
# Write history each command due to Codespace sometimes not flushing
export PROMPT_COMMAND="history -a"
export HISTSIZE=-1
export HISTFILESIZE=-1
export HISTCONTROL=ignoreboth
