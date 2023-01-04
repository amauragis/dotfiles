
function cf --description "Compress folder or files"
    if not type -q zstd &> /dev/null
        echo "zstd could not be found"
        return 1
    end

    if test (count $argv) -eq 0
        echo "Usage: cf <file or directory>"
        return 2
    end

    if test -f $argv[1]
        if test (count $argv) -eq 2
            switch (path extension $argv[2])
                case .zst
                    set -f outfile $argv[2]
                case .zstd
                    set -f outfile $argv[2]
                case '*'
                    set -f outfile $argv[2].zst
            end
        else
            set -f outfile $argv[1].zst
        end
        echo "Compressing file '$argv[1]' to '$outfile'"
        zstd --no-progress $argv[1] -o $outfile

    else if test -d $argv[1]
        set -f trimmed (string trim --right -c / $argv[1])
         if test (count $argv) -eq 2
            switch (path extension $argv[2])
                case .tar.zst
                    set -f outfile $argv[2]
                case .tar
                    set -f outfile $argv[2].zst
                case '*'
                    set -f outfile $argv[2].tar.zst
            end
        else
            set -f outfile $trimmed.tar.zst
        end
        echo "Compressing directory '$trimmed' to '$outfile'"
        # maybe -h for symlink dref?
        tar -c --zstd -f $outfile $trimmed

    else
        echo "'$argv[1]' is not a valid file or directory"
    end
end
