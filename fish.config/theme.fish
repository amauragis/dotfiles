# Theme (colors)
#
# fish >= 4.3 no longer sets these in universal scope by default. On
# upgrade it migrates any existing universal values into a global-scope
# conf.d/fish_frozen_theme.fish file. We manage them here instead so the
# generated frozen file can be deleted and the theme stays in sync
# across machines via this repo.
#
# Purge any leftover universal copies from before we made this switch
# (no-op / harmless if they were never set).
for var in fish_color_autosuggestion fish_color_cancel fish_color_command \
    fish_color_comment fish_color_cwd fish_color_cwd_root fish_color_end \
    fish_color_error fish_color_escape fish_color_history_current fish_color_host \
    fish_color_host_remote fish_color_normal fish_color_operator fish_color_param \
    fish_color_quote fish_color_redirection fish_color_search_match fish_color_selection \
    fish_color_status fish_color_user fish_color_valid_path \
    fish_pager_color_completion fish_pager_color_description fish_pager_color_prefix \
    fish_pager_color_progress fish_pager_color_selected_background
    set -e -U $var
end

set -g fish_color_autosuggestion 555 brblack
set -g fish_color_cancel -r
set -g fish_color_command blue
set -g fish_color_comment red
set -g fish_color_cwd green
set -g fish_color_cwd_root red
set -g fish_color_end green
set -g fish_color_error brred
set -g fish_color_escape brcyan
set -g fish_color_history_current --bold
set -g fish_color_host -o cyan
set -g fish_color_host_remote yellow
set -g fish_color_normal normal
set -g fish_color_operator brcyan
set -g fish_color_param cyan
set -g fish_color_quote yellow
set -g fish_color_redirection cyan --bold
set -g fish_color_search_match white --background=brblack
set -g fish_color_selection white --bold --background=brblack
set -g fish_color_status red
set -g fish_color_user -o green
set -g fish_color_valid_path --underline
set -g fish_pager_color_completion normal
set -g fish_pager_color_description B3A06D yellow -i
set -g fish_pager_color_prefix normal --bold --underline
set -g fish_pager_color_progress brwhite --background=cyan
set -g fish_pager_color_selected_background -r
