# Dotfiles
Forked from holman: https://github.com/holman/dotfiles/
He has [opinions](http://zachholman.com/2010/08/dotfiles-are-meant-to-be-forked/).

## topical

Everything's built around topic areas. If you're adding a new area to your
forked dotfiles — say, "Java" — you can simply add a `java` directory and put
files in there. Anything with an extension of `.symlink` will get
symlinked without extension into `$HOME` when you run `script/bootstrap`.

## components

There's a few special files in the hierarchy.

- **bin/**: Anything in `bin/` will get added to your `$PATH` and be made
  available everywhere.
- **topic/\*.symlink**: Any files ending in `*.symlink` get symlinked into
  your `$HOME`. This is so you can keep all of those versioned in your dotfiles
  but still keep those autoloaded files in your home directory. These get
  symlinked in when you run `script/bootstrap`.
- **topic.config**: Any topic folder that ends in `.config` will be created in
  `$XDG_CONFIG_HOME` and have its contents symlinked in. (The whole folder
  isn't symlinked, because the first thing that used this was `fish`, which
  puts files in that directory that I didn't want to explicitly ignore nor
  include in this repo.)
- **claude/**: Bootstrap links the instructions and each shared skill into a
  real `~/.claude` directory and seeds settings if absent. Claude's runtime data and live settings
  stay outside the repository. See [Claude setup](claude/README.md).

## install

Run this:

```sh
git clone https://github.com/amauragis/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
script/bootstrap
```

This will symlink the appropriate files in `.dotfiles` to your home directory.
Everything is configured and tweaked within `~/.dotfiles`.


## Utilities to install

- fish, bash
- neovim (>= 0.12), tmux, wezterm, Iosevka Term font
- fzf, fd-find, ripgrep, eza, bat, tree, jq
- git-delta, git-lfs, git-credential-oauth, bcompare
- zstd, p7zip, wl-clipboard
- ruby (git-wtf, git-rank-contributors)

Fish plugins are managed by [fisher](https://github.com/jorgebucaran/fisher)
and listed in `fish.config/fish_plugins`. Install fisher, then the plugins:
```sh
script/install-fisher
fisher update
```

Neovim plugins are managed by the built-in `vim.pack` (nvim >= 0.12) and
install on first launch at the revisions pinned in
`nvim.config/nvim-pack-lock.json`. Run `updatevim` to update them, then commit
the lockfile.

The prompt is [Tide](https://github.com/IlanCosman/tide). Its settings live
in universal variables, so apply the tracked style once per machine, after
the plugins are installed:
```sh
script/configure-tide
```
