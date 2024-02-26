# pull in aliases and environment
source $HOME/.config/fish/env.fish
source $HOME/.config/fish/aliases.fish

if test -e $HOME/.config/fish/local.fish
  source $HOME/.config/fish/local.fish
end

# initialize our new variables
set -U fish_color_user -o green
set -U fish_color_host -o cyan
set -U fish_color_status red

# clear greeting
set -g fish_greeting

# autojump (autojump-fish pkg)
if test -e /usr/share/autojump/autojump.fish
  source /usr/share/autojump/autojump.fish
end

# fzf stuff
if type -q fzf
  source $HOME/.config/fish/fzf.fish
end

if set -q fish_log_shell_history
  source $HOME/.config/fish/log_shell_history.fish
end

set -g fish_cmd_duration_threshold 500
