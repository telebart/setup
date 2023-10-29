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
fish_add_path -p $GOPATH/bin
fish_add_path -p $HOME/.local/bin


# alias -s lsl "ls -l"

set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME ; set -gx PATH $HOME/.cabal/bin $PATH /home/l/.ghcup/bin # ghcup-env