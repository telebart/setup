function fish_prompt -d "Write out the prompt"
  printf '%s%s%s $ ' (set_color magenta) (prompt_pwd) (set_color yellow)
end
