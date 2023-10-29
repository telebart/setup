function fzf_cd
  set selection (fd . -td -H -E Games -E .cache -E .mozilla -E Steam ~ | fzf --scheme=path --reverse)
  if test -d "$selection"
cd "$selection"
    commandline -f repaint
  end
end
