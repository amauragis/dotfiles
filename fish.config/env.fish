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

# FZF defaults. These start from fzf.fish's own defaults, which it only
# applies when FZF_DEFAULT_OPTS is unset; functions add --height as needed.
set -gx FZF_DEFAULT_OPTS '--cycle --layout=reverse --border --info=inline --height=90% --preview-window=wrap --marker="*"'
set -gx FZF_DEFAULT_COMMAND 'fd --type f'

# Path modifications
fish_add_path --global $HOME/bin $DOTFILES/bin $HOME/.local/bin $HOME/.cargo/bin

# set fisher location
set -g fisher_path $__fish_config_dir/fisher_plugins

# set fish completions and functions to pick up from fisher
if not contains -- $fisher_path/completions $fish_complete_path
    set -g fish_complete_path $fish_complete_path[1] $fisher_path/completions $fish_complete_path[2..]
end
if not contains -- $fisher_path/functions $fish_function_path
    set -g fish_function_path $fish_function_path[1] $fisher_path/functions $fish_function_path[2..]
end

for file in $fisher_path/conf.d/*.fish
    source $file
end

# Go environment variables
if command -q go
    if not set -q GOPATH
        set -gx GOPATH (go env GOPATH)
    end
    fish_add_path --global --append $GOPATH/bin
end

# Set shell variable to fish
set -gx SHELL (status fish-path)

# well I want it on.
if not set -q fish_log_shell_history
    set -g fish_log_shell_history true
end
