function fish_right_prompt -d "Write out the right prompt"
    set -l last_status $status

    if set -q fish_copy_paste_mode
        return
    end

    set -l normal (set_color normal)

    set -l curr_time (date '+%H:%M:%S')
    set -l prompt_time (set_color $fish_color_autosuggestion) "[$curr_time]" $normal

    set -l prompt_status
    if test $last_status -ne 0
        set prompt_status ' ' (set_color $fish_color_status) "[$last_status]" $normal
    end

    echo -n -s (fish_cmd_duration_prompt) "$prompt_status" "$prompt_time"
end
