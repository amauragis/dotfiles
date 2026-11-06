function copymode --description "Toggle a minimal one-line prompt for clean copy/paste"
    # Swaps in a plain `~/dir $ ` prompt with no right side, so copied
    # scrollback carries no padding, connector line or timestamps. The
    # active prompt (Tide's) is stashed and restored on the next toggle.
    if set -q __copymode_active
        set -e __copymode_active
        for f in fish_prompt fish_right_prompt
            functions -e $f
            functions -q __copymode_saved_$f
            and functions -c __copymode_saved_$f $f
            and functions -e __copymode_saved_$f
        end
    else
        set -g __copymode_active
        for f in fish_prompt fish_right_prompt
            functions -e __copymode_saved_$f
            functions -q $f
            and functions -c $f __copymode_saved_$f
        end
        function fish_prompt
            printf '%s%s%s $ ' (set_color $fish_color_cwd) (prompt_pwd) (set_color normal)
        end
        function fish_right_prompt
        end
    end
    commandline -f repaint 2>/dev/null
end
