source $__fish_config_dir/env.fish

# Theme and prompt settings load unconditionally: fish-async-prompt
# renders the prompt in a non-interactive `fish -c` child, which needs them.
source $__fish_config_dir/theme.fish
set -g fish_cmd_duration_threshold 500

if status is-interactive
    source $__fish_config_dir/aliases.fish
end

if test -e $__fish_config_dir/local.fish
    source $__fish_config_dir/local.fish
end

if status is-interactive
    set -g fish_greeting

    if test "$fish_log_shell_history" = true
        source $__fish_config_dir/log_shell_history.fish
    end
end
