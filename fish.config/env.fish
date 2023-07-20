# Editor stuff
set -gx EDITOR 'nvim'
set -gx VISUAL 'nvim'
set -gx XEDITOR 'code'

# default browser
set -gx BROWSER google-chrome

set -gx TERMINAL wezterm

# Special snowflake variables
set -gx PROJECTS "$HOME/projects"
set -gx DOTFILES "$HOME/.dotfiles"

# Set shell variable to fish
set -gx SHELL /usr/bin/fish

# well I want it on.
set -g fish_log_shell_history true
