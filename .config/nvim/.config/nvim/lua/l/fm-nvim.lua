require('fm-nvim').setup{
    border = "single",
    float_hl = "Normal",
    height = 1,
    width = 1,
    -- (Vim) Command used to open files
    edit_cmd = "edit", -- opts: 'tabedit', 'split', 'pedit', etc...
    -- Floating Window Transparency (see ":h winblend")
    blend = 0,
    cmds = {
        lf_cmd      = "lf-ueberzug", -- eg: lf_cmd = "lf -command 'set hidden'"
        fzf_cmd     = "fzf", -- eg: fzf_cmd = "fzf --preview 'bat --style=numbers --color=always --line-range :500 {}'"
        fzy_cmd     = "find . | fzy",
    },
    -- Mappings used inside the floating window
    mappings = {
        vert_split = "<C-v>",
        horz_split = "<C-h>",
        tabedit    = "<C-t>",
        edit       = "<C-e>",
        ESC        = "<ESC>"
    }
}
