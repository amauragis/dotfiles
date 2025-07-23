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

# FZF defaults
# set -gx FZF_DEFAULT_OPTS '--layout=reverse --border --inline-info --height=40% --min-height=15 --marker="*"'
set -gx FZF_DEFAULT_COMMAND 'fd --type f'

# Path modifications
set -g fish_user_paths $HOME/bin $DOTFILES/bin $HOME/.local/bin $HOME/.cargo/bin

# set fisher location
set -g fisher_path $HOME/.config/fish/fisher_plugins

# set fish completions and functions to pick up from fisher
set fish_complete_path $fish_complete_path[1] $fisher_path/completions $fish_complete_path[2..]
set fish_function_path $fish_function_path[1] $fisher_path/functions $fish_function_path[2..]

for file in $fisher_path/conf.d/*.fish
    source $file
end

# Go environment variables
if command -v go &>/dev/null
    set -gx GOPATH (go env GOPATH)
    set -a fish_user_paths $GOPATH/bin
end

# Set shell variable to fish
set -gx SHELL /usr/bin/fish

# well I want it on.
set -g fish_log_shell_history true
