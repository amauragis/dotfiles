function take --description "create a directory and enter it"
    if test (count $argv) -eq 0
        echo "Usage: take <directory>"
        return 2
    end

    mkdir -p "$argv[1]"
    cd "$argv[1]"
end
