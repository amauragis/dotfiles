function r --description "navigate to git project root"
    set -f root "$(git rev-parse --show-toplevel)"; or return $status
    cd "$root"
end
