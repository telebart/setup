require'telescope'.load_extension'repo'

local actions = require("telescope.actions")
require'telescope'.setup({
  defaults = {
    layout_strategy='vertical',
    layout_config={width=0.95, height=0.95},
    mappings = {
      i = {
        ["<esc>"] = actions.close
        ,["<C-q>"] = actions.smart_send_to_qflist
        ,["<C-h>"] = "which_key"
        ,["<C-space>"] = actions.toggle_selection + actions.move_selection_previous
        ,["<C-w>"] = actions.delete_buffer
      }
    }
  }
})

local function file_exists(file)
  local f = io.open(file, "rb")
  if f then f:close() end
  return f ~= nil
end

local function lines_from(file)
  if not file_exists(file) then return {} end
  local lines = {}
  for line in io.lines(file) do
    lines[#lines + 1] = line
  end
  return lines
end

-- tests the functions above
local config_path = vim.fn.stdpath("config")
local file = config_path .. '/telerepos'
local extra_repos = lines_from(file)
local repos = {"~/.config/nvim", "~/repoja", "~/repos"}

if extra_repos then
  for _,v in ipairs(extra_repos) do
   table.insert(repos, v)
  end
end

vim.keymap.set('n', '<leader>fj',function() require'telescope'.extensions.repo.list({search_dirs = repos}) end)
