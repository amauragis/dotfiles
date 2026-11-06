function envsource --description 'Source environment variables from a \'.env\'-style file.'

    argparse 'h/help' 'e/eval' 'l/list' 'c/clear' -- $argv
    or return

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

VALUES:
  KEY='text'     - taken literally
  KEY=\"text\"     - \$VAR and \${VAR} are expanded, nothing else
  KEY=text       - same as double quotes; a trailing ' # comment' is dropped
  'export KEY=…' lines are accepted.
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
            echo "'$var': '$$var'"
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

    set -f envfile "$argv[1]"
    if test -z "$envfile"
        if test -f ".env"
            set -f envfile ".env"
            echo "Reading from '.env' file."
        else
            echo "Usage: envsource <file>"
            return 1
        end
    end
    if not test -f "$envfile"
        echo "File not found: $envfile"
        return 2
    end

    while read -l line
        set -l line (string trim -- $line)
        # skip empty lines and comments
        if test -z "$line"; or string match -q '#*' -- $line
            continue
        end

        if string match -rq -- '^(?:export\s+)?(?<key>[A-Za-z_][A-Za-z0-9_]*)\s*=\s*(?<value>.*)$' $line
            if string match -rq -- "^'(?<inner>.*)'\$" $value
                set value $inner
            else
                if string match -rq -- '^"(?<inner>.*)"$' $value
                    set value $inner
                else
                    set value (string replace -r -- '\s+#.*$' '' $value)
                end
                set value (__envsource_expand $value)
            end

            set -gx $key $value
            echo "Exported variable '$key'."
            contains -- $key $__envsource_vars
            or set -ga __envsource_vars $key
        else if set -q _flag_eval
            eval $line
        else
            echo "Ignoring line: '$line', use -e to evaluate."
        end
    end <"$envfile"
end

# Expand $VAR and ${VAR} references (unset ones become empty), and nothing else:
# no globs, command substitution or word splitting, unlike eval.
function __envsource_expand --argument-names value
    set -l out ''
    while string match -rq -- '^(?<pre>.*?)\$(?:\{(?<braced>\w+)\}|(?<bare>\w+))(?<rest>.*)$' $value
        set -l name $braced $bare
        set out "$out$pre$$name"
        set value $rest
    end
    echo -- "$out$value"
end
