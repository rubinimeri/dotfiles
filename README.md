# dotfiles

My Linux (Omarchy / Hyprland) config files, tracked with a **bare git repo** whose
work-tree is `$HOME`. Files live in their normal locations — nothing is symlinked or moved.

## What's tracked

| Config        | Path                          |
| ------------- | ----------------------------- |
| zsh           | `~/.zshrc`                    |
| tmux          | `~/.config/tmux/tmux.conf`    |
| yazi          | `~/.config/yazi/`             |
| kitty         | `~/.config/kitty/`            |
| Hyprland      | `~/.config/hypr/`             |
| Neovim        | `~/.config/nvim/`             |

## Day-to-day

Set up the `dotfiles` command once (add to your shell rc):

```sh
alias dotfiles='git --git-dir="$HOME/.dotfiles" --work-tree="$HOME"'
```

Then use it like git:

```sh
dotfiles status
dotfiles add ~/.config/foo/bar.conf
dotfiles commit -m "tweak foo"
dotfiles push
```

## Bootstrapping a new machine

```sh
git clone --bare https://github.com/rubinimeri/dotfiles.git "$HOME/.dotfiles"
alias dotfiles='git --git-dir="$HOME/.dotfiles" --work-tree="$HOME"'
dotfiles checkout        # if this complains, back up the listed files, then retry
dotfiles config status.showUntrackedFiles no
```
