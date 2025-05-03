if status is-login
    if test -z "$DISPLAY" -a "$XDG_VTNR" = 1
        exec Hyprland
    end
end

# Only run this in interactive shells
if status is-interactive
  set fish_vi_force_cursor 1
  set fish_prompt_pwd_dir_length 0
  set fish_cursor_default     block
  set fish_cursor_insert      line
  set fish_cursor_replace_one underscore
  set fish_cursor_visual      block
  set -U fish_vi_key_bindings
end

set -gx EDITOR nvim
set -gx RIPGREP_CONFIG_PATH $HOME/.config/ripgrep/rgrc
set -gx GOPATH $HOME/go

set -eU MANROFFOPT
set -gx MANPAGER "bat"
fish_add_path -p $GOPATH/bin
fish_add_path -p $HOME/.local/bin
fish_add_path -p /home/l/.bun/bin/
set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME ; set -gx PATH $HOME/.cabal/bin $PATH /home/l/.ghcup/bin # ghcup-env

alias pacman-cleanup='sudo pacman -Rns $(pacman -Qtdq)'
alias la='eza -aH'
alias ll='eza -lH'
alias lla='eza -laH'
alias ls='eza'
alias mirrorx="sudo reflector --age 6 --latest 20  --fastest 20 --threads 5 --sort rate --protocol https --save /etc/pacman.d/mirrorlist"
alias yta-best="yt-dlp --extract-audio --audio-format best "
alias ytv-best="yt-dlp -f bestvideo+bestaudio "
alias lg="lazygit"
alias hx="helix"
alias n="nvim ."
alias sxiv="nsxiv -a"
alias wttr="curl -s --compressed \"v2.wttr.in/espoo?FQ\""
alias cat="bat --paging=never"
alias less="bat"