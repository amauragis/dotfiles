# inspired by https://www.justinjoyce.dev/save-your-shell-history-to-log-files/

if ! set -q shell_history_dir
    set -g shell_history_dir $HOME/.shell_logs
end

# echo "Shell logging enabled. Logs will be saved to '$shell_history_dir'"

if test ! -d $shell_history_dir
    mkdir -p $shell_history_dir
end

function log_cmd_history --on-event fish_preexec
    echo $(date "+%Y-%m-%dT%H:%M:%S") $(pwd) "\$" $argv[1] >> "$shell_history_dir/fish_"$(date "+%Y-%m-%d")".log"
end
