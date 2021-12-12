require'telescope'.load_extension'repo'

local actions = require("telescope.actions")
require'telescope'.setup({
    defaults = {
        mappings = {
            i = {
                ["<esc>"] = actions.close
                ,["<C-q>"] = actions.send_to_qflist
            }
        }
    }
})
