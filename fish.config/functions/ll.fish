if command -v eza &>/dev/null
    function ll --description "list files and directories" --wraps eza
        eza -l --group --header --group-directories-first $argv
    end
else
    function ll --description "list files and directories" --wraps ls
        ls -l $argv
    end
end
