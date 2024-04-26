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

## install

Run this:

```sh
git clone https://github.com/amauragis/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
script/bootstrap
```

This will symlink the appropriate files in `.dotfiles` to your home directory.
Everything is configured and tweaked within `~/.dotfiles`.


## List of utilties to install probably
-  bcompare
-  fish
-  ruby (git-wtf)
-  bash
-  zstd
-  p7zip
-  fzf
-  fd-find
-  eza
-  neovim
-  tmux
-  wezterm
-  git-delta
-  bat

Fish plugins are installed with `fisher`. See [here](https://github.com/jorgebucaran/fisher).

To install:
```sh
curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher
```
