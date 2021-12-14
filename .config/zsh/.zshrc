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

source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

source /home/l/.config/broot/launcher/bash/br
