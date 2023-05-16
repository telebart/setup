[[ $- != *i* ]] && return

autoload -U colors && colors
PS1="%B%{$fg[red]%}[%{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "

export SAVEHIST=10000
export HISTSIZE=10000
export HISTFILE="$XDG_STATE_HOME"/zsh/history

setopt inc_append_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_ignore_space
setopt inc_append_history

autoload -U compinit && compinit -u
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)

bindkey '^ ' autosuggest-accept

if [ -d "$HOME/.local/bin" ] ;
  then PATH="$HOME/.local/bin:$PATH"
fi

[[ -f "$ZDOTDIR"/zaliases ]] && . "${ZDOTDIR}/zaliases"
[ -f "/home/l/.ghcup/env" ] && source "/home/l/.ghcup/env" # ghcup-env

# pnpm
export PNPM_HOME="/home/l/.local/share/pnpm"
export PATH="$PNPM_HOME:$PATH"
# pnpm end

# fnm
export PATH=/home/l/.fnm:$PATH
eval "`fnm env`"

[ -f "/home/l/.ghcup/env" ] && source "/home/l/.ghcup/env" # ghcup-env

if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
  exec startx
fi

# bun completions
[ -s "/home/l/.bun/_bun" ] && source "/home/l/.bun/_bun"
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

[ -f "$HOME/.local/share/zap/zap.zsh" ] && source "$HOME/.local/share/zap/zap.zsh"
plug "zsh-users/zsh-autosuggestions"
plug "zap-zsh/vim"
plug "zap-zsh/fzf"
plug "zsh-users/zsh-syntax-highlighting"
