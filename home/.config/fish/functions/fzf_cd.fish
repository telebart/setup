function fzf_cd
  set selection (fd . -td -H \
  -E Games \
  -E .mozilla \
  -E Steam \
  -E heroic \
  -E .git \
  -E bottles \
  -E BraveSoftware \
  -E chromium \
  -E Library \
  -E '**/node_modules/**' \
  -E .npm \
  -E 'go/go*' \
  -E 'go/pkg' \
  -E '.rustup/*' \
  -E .cargo \
  -E .aws-sam \
  -E .tldrc \
  -E '**/*cache/**' \
  ~ | sed -E "s|^$HOME(/repos/setup/home)?|~|" | fzf --scheme=path --reverse | sed "s|~|$HOME|")
  if test -d $selection
    cd $selection
    commandline -f repaint
  end
end
