function fish_user_key_bindings
    if type -q fzf_key_bindings
        fzf_key_bindings
    end
    if type -q bash_expansion_key_bindings
        bash_expansion_key_bindings
    end

    # Toggle copy-paste mode
    function __fish_toggle_copy_paste_mode
        if set -q fish_copy_paste_mode
            set -e fish_copy_paste_mode
            echo "Copy-paste mode: OFF"
        else
            set -g fish_copy_paste_mode 1
            echo "Copy-paste mode: ON"
        end
        commandline -f repaint
    end

    bind \cp __fish_toggle_copy_paste_mode
end
