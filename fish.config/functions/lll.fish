if command -v eza &>/dev/null
    function lll --description "list files and directories" --wraps eza
        eza -l --group --header --group-directories-first -ls time $argv
    end
else
    function lll --description "list files and directories" --wraps ls
        ls -lart $argv
    end
end
