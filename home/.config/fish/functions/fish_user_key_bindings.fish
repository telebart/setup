function fish_user_key_bindings
    fish_default_key_bindings -M insert
    fish_vi_key_bindings --no-erase insert
    bind -M insert ctrl-f fzf_cd
    bind -M insert ctrl-space forward-char
    bind -M insert ctrl-r fzf_history
    bind -k alt-p true
end
