# grrr
alias cls 'clear'

# git stuff
alias glog "git log --graph --pretty=format:'%Cred%h%Creset %an: %s - %Creset %C(yellow)%d%Creset %Cgreen(%cr)%Creset' --abbrev-commit --date=relative"
alias gp 'git push origin HEAD'
alias gc 'git commit'
alias gac 'git add -A; and git commit'
alias gcb 'git add -A && git commit -m stuff' # job security
alias gcr 'git commit --amend --no-edit'
alias gsu 'git submodule update --remote --merge'
alias bbash 'set -x NO_FISH 1 && exec bash --login'
alias bsbash 'set -x NO_FISH 1 && bash --login'

# List so symbols
alias sosym "nm --demangle --dynamic --defined-only --extern-only"

# tree stuff
alias dtree "fd -td | tree --fromfile . --noreport -n"  # show non gitignored directories as a tree
alias ftree "fd | tree --fromfile . --noreport -n"      # tree, but filtered through fd's default filters

# fake dmesg
alias klog "journalctl -ko short-monotonic --no-hostname --pager-end"
