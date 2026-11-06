function updatevim --description "Update nvim plugins (and their pinned revisions in the lockfile)"
    set_color blue; echo "Updating nvim plugins"; set_color normal
    nvim --headless +'lua vim.pack.update(nil, { force = true })' +qa
    and git -C $DOTFILES --no-pager diff --stat -- nvim.config/nvim-pack-lock.json
end
