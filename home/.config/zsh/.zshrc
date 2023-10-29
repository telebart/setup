[[ $- != *i* ]] && return
autoload -U colors && colors
PS1="%B%{$fg[magenta]%}%~ %{$fg[yellow]%}$%b "

export SAVEHIST=10000
export HISTSIZE=10000
export HISTFILE="$XDG_STATE_HOME"/zsh/history
export RIPGREP_CONFIG_PATH="$HOME"/ripgrep/rgrc

setopt inc_append_history
setopt hist_expire_dups_first
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt inc_append_history

autoload -U compinit && compinit -u
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)

bindkey '^ ' autosuggest-accept

fzf_cd() {
  setopt localoptions pipefail no_aliases 2> /dev/null
  local dir="$(fd . -td -H -E Games -E .cache -E .mozilla -E Steam ~ | sed "s|^$HOME|~|" | fzf --scheme=path)"
  if [[ -z "$dir" ]]; then
    return 0
  fi
  BUFFER="cd ${dir}"
  zle accept-line
}
zle -N fzf_cd
bindkey '^f' fzf_cd



if [ -d "$HOME/.local/bin" ] ;
  then PATH="$HOME/.local/bin:$PATH"
fi

[[ -f "$ZDOTDIR"/zaliases ]] && . "${ZDOTDIR}/zaliases"
[ -f "/home/l/.ghcup/env" ] && source "/home/l/.ghcup/env" # ghcup-env

# fnm
export PATH=/home/l/.fnm:$PATH
eval "`fnm env`"

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

# fzf's command
export FZF_DEFAULT_COMMAND="fd --hidden -E Games -E .mozilla -E .cache -E Steam" # CTRL-T's command
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND" # ALT-C's command
export FZF_ALT_C_COMMAND="$FZF_DEFAULT_COMMAND --type d"
