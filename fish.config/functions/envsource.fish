function envsource --description 'Source environment variables from a \'.env\'-style file.'

    argparse 'h/help' 'e/eval' 'l/list' 'c/clear' -- $argv
    if set -q _flag_help
        echo "\
envsource - source .env files
USAGE
  envsource [OPTS] <path>

OPTS:
  -h/--help      - print this help
  -e/--eval      - evaluate lines that don't set variables
  -l/--list      - list all variables set by envsource
  -c/--clear     - clear all variables set by envsource

ARGS:
  <path>         - path to the .env file to source, defaults to '.env'
"
        return 0
    end

    if set -q _flag_list
        if not set -q __envsource_vars
            echo "No variables set by envsource."
            return 0
        end
        echo "Variables set by envsource:"
        for var in $__envsource_vars

            echo "'$var': '$(eval echo \$$var)'"
        end
        return 0
    end

    if set -q _flag_clear
        for var in $__envsource_vars
            set -e $var
            echo "Unset variable '$var'."
        end
        set -e __envsource_vars
        return 0
    end

    set -f envfile "$argv"
    if test -z $envfile
        if test -f ".env"
            set -f envfile ".env"
            echo "Reading from '.env' file."
        else
            echo "Usage: envsource <file>"
            return 1
        end
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

                set -ga __envsource_vars $entry[1]
            else
                if set -q _flag_eval
                    eval $line
                else
                    echo "Ignoring line: '$line', use -e to evaluate."
                end
            end
        end
    end < $envfile

end
