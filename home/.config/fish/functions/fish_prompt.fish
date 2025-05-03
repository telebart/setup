function fish_prompt --description 'Write out the prompt'
  printf '\033[1m%s%s%s $\033[0m ' (set_color magenta) (prompt_pwd) (set_color yellow)
end
