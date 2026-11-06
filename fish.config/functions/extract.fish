function extract --description "Expand or extract bundled & compressed files"
    if test (count $argv) -eq 0
        echo "Usage: extract <archive>..." >&2
        return 2
    end

    set -l rc 0
    for f in $argv
        if not test -f $f
            echo "extract: '$f' is not a valid file" >&2
            set rc 1
            continue
        end

        # GNU tar detects the compression itself, so every tarball is one case
        switch (string lower -- $f)
            case '*.tar' '*.tar.*' '*.tgz' '*.tbz' '*.tbz2' '*.txz' '*.tzst'
                tar -xvf $f
            case '*.gz'
                gunzip -k $f
            case '*.bz2'
                bunzip2 -k $f
            case '*.xz'
                unxz -k $f
            case '*.zst'
                unzstd $f
            case '*.zip'
                unzip $f
            case '*.rar' '*.7z'
                7z x $f
            case '*'
                echo "extract: unsupported file type: '$f'" >&2
                set rc 1
                continue
        end
        or set rc 1
    end
    return $rc
end
