# !!
function _bash_expansion_bind_bang
  switch (commandline -t)
  case "!"
    commandline -t $history[1]; commandline -f repaint
  case "*"
    commandline -i !
  end
end

# !$
function _bash_expansion_bind_dollar
  switch (commandline -t)
  case "!"
    commandline -t ""
    commandline -f history-token-search-backward
  case "*"
    commandline -i '$'
  end
end

# enables $?
# function _bash_expansion_bind_status
#   commandline -i (echo '$status')
# end


# # enables $$
# function _bash_expansion_bind_self
#   commandline -i (echo '$fish_pid')
# end

function bash_expansion_key_bindings
  bind ! _bash_expansion_bind_bang
  # bind '$' _bash_expansion_bind_dollar
  # bind '$?' _bash_expansion_bind_status
  # bind '$$' _bash_expansion_bind_self
end
