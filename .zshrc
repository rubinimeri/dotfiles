# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

### zinit — plugin manager (self-installs on first run) ########################
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
if [[ ! -d $ZINIT_HOME/.git ]]; then
  mkdir -p "$(dirname $ZINIT_HOME)"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi
source "${ZINIT_HOME}/zinit.zsh"

# Powerlevel10k theme
zinit ice depth=1
zinit light romkatv/powerlevel10k

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Vi key-bindings — loaded SYNCHRONOUSLY (not turbo). Turbo-loading it makes
# ESC laggy on the first command, since the plugin isn't attached yet when you
# start typing. The ~79ms startup cost buys instant, consistent ESC behavior.
# ZVM_INIT_MODE=sourcing makes it init right here, so the plugins loaded after
# it wrap on top of its keymap. It resets the keymap on init and would clobber
# fzf's bindings, so we (re)source those from the zvm_after_init hook.
ZVM_SYSTEM_CLIPBOARD_ENABLED=true
ZVM_INIT_MODE=sourcing
ZVM_KEYTIMEOUT=0.05
zvm_after_init_commands+=('source /usr/share/fzf/key-bindings.zsh')
zinit light jeffreytse/zsh-vi-mode

# Autosuggestions — turbo-loaded just after the prompt appears.
# We load after the first precmd, so start the engine manually via atload.
zinit ice wait lucid atload"!_zsh_autosuggest_start"
zinit light zsh-users/zsh-autosuggestions

# Syntax highlighting — turbo-loaded, and registered last so it wraps the
# ZLE widgets set up by the plugins above.
zinit light zdharma-continuum/fast-syntax-highlighting
################################################################################

# Initialize mise (Omarchy node / python version manager)
eval "$(mise activate zsh)"

# fzf integration for zsh. Key-bindings are (re)sourced from the
# zvm_after_init hook above so zsh-vi-mode doesn't clobber them.
source /usr/share/fzf/completion.zsh

#source ~/.local/share/omarchy/default/bash/aliases
source ~/.local/share/omarchy/default/bash/aliases
source ~/.local/share/omarchy/default/bash/functions
source ~/.local/share/omarchy/default/bash/envs

export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# pnpm
export PNPM_HOME="/home/rubinimeri/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
