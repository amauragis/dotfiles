# inspired by https://www.justinjoyce.dev/save-your-shell-history-to-log-files/

if ! set -q shell_history_dir
    set -g shell_history_dir $HOME/.shell_logs
end

if test ! -d $shell_history_dir
    mkdir -p $shell_history_dir
end

set -g record_shell_history true

function histon --description "Enable shell history logging"
    argparse q/quiet -- $argv
    set -g record_shell_history true
    if ! set -ql _flag_quiet
        echo "Shell logging enabled. Logs will be saved to '$shell_history_dir'"
    end
end

function histoff --description "Disable shell history logging"
    argparse q/quiet -- $argv
    set -g record_shell_history false
    if ! set -ql _flag_quiet
        echo "Shell logging disabled."
    end
end

function log_cmd_history --on-event fish_preexec
    if test $record_shell_history = false
        return
    end
    echo $(date "+%Y-%m-%dT%H:%M:%S") $(pwd) "\$" $argv[1] >>"$shell_history_dir/fish_"$(date "+%Y-%m-%d")".log"
end

function htoday --description "show shell history for today"
    cat $shell_history_dir/fish_$(date "+%Y-%m-%d").log
end

function remove_last_shell_history --description "remove the last line of shell history"
    if test $record_shell_history = false
        set -f count -1
    else
        set -f count -2
    end
    set -f orig_file $shell_history_dir/fish_$(date "+%Y-%m-%d").log
    set -f tmp_file $orig_file.tmp
    head -n $count $orig_file > $tmp_file
    mv $tmp_file $orig_file
    rm -f $tmp_file
end

if command -v rg &>/dev/null
    function hist --description "Search shell history" --wraps rg
        rg -i $argv $shell_history_dir/*.log
    end
else
    function hist --description "Search shell history" --wraps grep
        grep -i $argv $shell_history_dir/*.log
    end
end
