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

# Path modifications
set -g fish_user_paths $HOME/bin $DOTFILES/bin $HOME/.local/bin $HOME/.cargo/bin

# autojump (autojump-fish pkg)
if test -e /usr/share/autojump/autojump.fish
  source /usr/share/autojump/autojump.fish
end

# fzf stuff
if type -q fzf
  source $HOME/.config/fish/fzf.fish
end

set -g fish_cmd_duration_threshold 500
