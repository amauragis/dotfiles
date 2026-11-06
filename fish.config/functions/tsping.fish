function tsping --description "ping tailscale things"
    argparse 'h/help' 'a/all' 'show-offline' -- $argv

    if set -q _flag_help
        echo "\
tsping - ping tailscale things interactively.
USAGE
  tsping [OPTS]

OPTS:
  -h/--help      - print this help
  -a/--all       - ping all hosts that aren't offline
  --show-offline - show offline hosts in interactive mode

"
        return 0
    end

    # if tailscale ain't here, bail
    if not command -v tailscale > /dev/null
        echo "tailscale not found"
        return 1
    end

    if set -q _flag_all
        set -f hosts (tailscale status --json | jq -r '.Peer[] | select(.HostName != null) | select(.Online == true) | .DNSName')
        echo "Pinging all online hosts:"
        for host in $hosts
            echo "  $host"
            tailscale ping --c 1 $host 2>&1 | sed 's/^/    /'
            echo ""
        end
        return
    end

    if not command -v fzf > /dev/null
        echo "fzf not found, interactive mode needs it."
        return 1
    end
    set -f peers (tailscale status | string match -v '#*')
    if not set -q _flag_show_offline
        # line 1 is this machine (shown as the fzf header); drop offline peers
        set peers $peers[1] (string match -v '*offline*' -- $peers[2..])
    end
    set -f host (printf '%s\n' $peers | fzf --height=40% --header-lines=1 | awk '{print $1}')

    if test -z "$host"
        return 0
    end

    echo "Pinging $host via tailscale:"
    tailscale ping $host

end
