if status is-interactive
    # Commands to run in interactive sessions can go here
end

alias ff='fastfetch'
alias vim='nvim'
alias ai='env OLLAMA_DEBUG=1 ollama serve'
#alias cat='bat --paging=never --style=plain'

# Hermes Agent — ensure ~/.local/bin is on PATH
fish_add_path "$HOME/.local/bin"

# opencode
fish_add_path /Users/rasto/.opencode/bin
