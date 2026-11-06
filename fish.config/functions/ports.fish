# Adapted from caarlos0's dotfiles
# Copyright (c) Carlos Becker, http://carlosbecker.com
# https://github.com/caarlos0/dotfiles.fish/blob/master/system/functions/ports.fish

function ports -d "manage processes by the ports they are using"
  switch $argv[1]
    case ls
      lsof -i -n -P
    case show
      lsof -n -P -i :"$argv[2]" | tail -n 1
    case pid
      ports show "$argv[2]" | awk '{ print $2; }'
    case term
      ports pid "$argv[2]" | xargs kill -15
    case kill
      ports pid "$argv[2]" | xargs kill -9
    case '*'
      echo "NAME:
  ports - a tool to easily see what's happening on your computer's ports
USAGE:
  ports [global options] command [command options] [arguments...]
COMMANDS:
  ls                list all open ports and the processes running in them
  show <port>       shows which process is running on a given port
  pid <port>        same as show, but prints only the PID
  term <port>       stop the process running on the given port with SIGTERM
  kill <port>       kill the process running on the given port with kill -9
GLOBAL OPTIONS:
  --help,-h         show help"
  end
end
