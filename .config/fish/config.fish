# The following lines were added by Docker Desktop to add commands to your PATH.
export PATH="$PATH:/Users/rasto/.docker/bin"
# End of Docker Desktop section.

if status is-interactive
    # Commands to run in interactive sessions can go here
end

alias sshx='env DISPLAY=:0 ssh -Y'
alias ff='fastfetch'
alias vim='nvim'
#alias cat='bat --paging=never --style=plain'
alias main='cd "/Users/rasto/Library/Mobile Documents/iCloud~md~obsidian/Documents/MAIN"'

# opencode
fish_add_path /Users/rasto/.opencode/bin
export PATH="$HOME/.local/bin:$PATH"

set -g fish_greeting
