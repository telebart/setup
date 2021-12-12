[[ $- != *i* ]] && return

autoload -U colors && colors
PS1="%B%{$fg[red]%}[%{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "

# History in cache directory:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE="$XDG_STATE_HOME"/zsh/history
HISTCONTROL=ignoreboth:erasedups

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
eval "$(fnm env)"

source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

source /home/l/.config/broot/launcher/bash/br
