function envsource --description 'Source environment variables from a \'.env\'-style file.'
    set -f envfile "$argv"
    if test -z $envfile
        echo "Usage: envsource <file>"
        return 1
    end
    if not test -f $envfile
        echo "File not found: $envfile"
        return 2
    end

    while read line
        if not string match -qr '^#|^$' # skip empty lines and comments
            if string match -qr '=' "$line" # if there is an =, we're setting a variable
                set entry (string split -m 1 = "$line")
                set entry[2] (eval echo $entry[2]) # expand variables in value

                set -gx $entry[1] $entry[2]
                echo "Exported variable '$entry[1]'."
            else
                eval $line
            end
        end
    end < $envfile

end
