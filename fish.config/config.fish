source $__fish_config_dir/env.fish

# Theme is cheap; load it everywhere so prompts rendered in a
# non-interactive background `fish -c` see the same colors.
source $__fish_config_dir/theme.fish

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

# pnpm
set -gx PNPM_HOME "$HOME/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end
