function fish_user_key_bindings
    fish_default_key_bindings -M insert
    fish_vi_key_bindings --no-erase insert
    bind -M insert \cf fzf_cd
    bind -M insert -k nul forward-char
    bind -M insert \cr fzf_history
end
