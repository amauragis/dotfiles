# pull in aliases, environment, and theme
source $HOME/.config/fish/env.fish
source $HOME/.config/fish/aliases.fish
source $HOME/.config/fish/theme.fish

if test -e $HOME/.config/fish/local.fish
    source $HOME/.config/fish/local.fish
end

# clear greeting
set -g fish_greeting

if set -q fish_log_shell_history
    source $HOME/.config/fish/log_shell_history.fish
end

set -g fish_cmd_duration_threshold 500
