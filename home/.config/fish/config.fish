if status is-login
    if test -z "$DISPLAY" -a "$XDG_VTNR" = 1
        exec startx -- -keeptty
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
set -gx GOPATH (go env | grep GOPATH)
fish_add_path -p $GOPATH/bin
fish_add_path -p $HOME/.local/bin
set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME ; set -gx PATH $HOME/.cabal/bin $PATH /home/l/.ghcup/bin # ghcup-env

abbr --add pacman-cleanup 'sudo pacman -Rns $(pacman -Qtdq)'
abbr --add la 'eza -aH'
abbr --add ll 'eza -lH'
abbr --add lla 'eza -laH'
abbr --add ls 'eza'
abbr --add mirrorx "sudo reflector --age 6 --latest 20  --fastest 20 --threads 5 --sort rate --protocol https --save /etc/pacman.d/mirrorlist"
abbr --add yta-best "yt-dlp --extract-audio --audio-format best "
abbr --add ytv-best "yt-dlp -f bestvideo+bestaudio "
abbr --add lg "lazygit"
abbr --add hx "hel x"
abbr --add n "nvim ."
abbr --add sxiv "nsxiv -a"