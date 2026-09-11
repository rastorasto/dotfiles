# Homebrew
eval "$(/opt/homebrew/bin/brew shellenv zsh)"

# PATH
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.opencode/bin:$PATH"

# Editor
export EDITOR="nvim"
export VISUAL="nvim"

# History
HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000
SAVEHIST=10000
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE

# Completion
autoload -Uz compinit && compinit

# Aliases
alias ff='fastfetch'
alias vim='nvim'
alias cat='bat --paging=never --style=plain'
alias ll='ls -lah'
