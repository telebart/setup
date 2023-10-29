function fzf_cd
  set selection (fd . -td -H \
  -E Games \
  -E .cache \
  -E .mozilla \
  -E Steam \
  -E heroic \
  -E .git \
  -E bottles \
  -E BraveSoftware \
  -E chromium \
  -E Library \
  -E node_modules \
  ~ | sed -E "s|^$HOME(/repos/setup/home)?|~|" | fzf --scheme=path --reverse)
  if test "$selection" != ""
    cd (echo $selection | sed "s|~|$HOME|")
    commandline -f repaint
  end
end
