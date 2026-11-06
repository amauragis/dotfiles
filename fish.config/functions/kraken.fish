function kraken --description "Open gitkraken on a repo (default: cwd)"
    set -l target $argv[1]
    set -q target[1]; or set target .
    set -l dir (realpath -e -- $target); or return
    gitkraken -p $dir
end
