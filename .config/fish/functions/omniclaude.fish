function omniclaude --description "Claude Code via OmniRoute on cat (usage: omniclaude [profile] [claude args...]; default profile: litellm-kimi)"
    set -l profile litellm-kimi
    if test (count $argv) -ge 1; and test -d $HOME/.claude/profiles/$argv[1]
        set profile $argv[1]
        set argv $argv[2..-1]
    end
    if not test -d $HOME/.claude/profiles/$profile
        echo "omniclaude: profile '$profile' not found in ~/.claude/profiles" >&2
        return 1
    end
    # permission error fix
    set -l mode manual
    set -q OMNICLAUDE_PERMISSION_MODE; and set mode $OMNICLAUDE_PERMISSION_MODE
    if not contains -- --permission-mode $argv
        set argv --permission-mode $mode $argv
    end

    env CLAUDE_CONFIG_DIR=$HOME/.claude/profiles/$profile claude $argv
end
