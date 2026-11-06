function fish_cmd_duration_prompt

    set -q CMD_DURATION[1]; or return
    set -q fish_cmd_duration_threshold; or set -l fish_cmd_duration_threshold 500
    if test $CMD_DURATION -gt $fish_cmd_duration_threshold
        set -l time_color (set_color -i 080 green)
        if test $CMD_DURATION -gt 10000
            set time_color (set_color -i a00 red)
        else if test $CMD_DURATION -gt 3000
            set time_color (set_color -i c90 yellow)
        end

        set -l normal (set_color normal)

        set -l seconds (math "$CMD_DURATION/1000" % 60)
        set -l minutes (math --scale=0 "$CMD_DURATION/60000" % 60)
        set -l hours (math --scale=0 "$CMD_DURATION/3600000" % 60)

        if test $seconds -eq 0
            set -e seconds
        end
        if test $minutes -eq 0
            set -e minutes
        end
        if test $hours -eq 0
            set -e hours
        end

        printf '%s' $time_color $hours'h ' $minutes'm ' $seconds's' $normal
    end
end