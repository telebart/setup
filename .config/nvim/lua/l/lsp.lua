require"nvim-lsp-installer".setup {}
local lspconfig = require("lspconfig")

local opts = { noremap=true, silent=true }
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true


-- Setup nvim-cmp.
local cmp = require("cmp")
local source_mapping = {
  buffer = "[Buffer]",
  nvim_lsp = "[LSP]",
  nvim_lua = "[Lua]",
  cmp_tabnine = "[TN]",
  path = "[Path]",
}
local lspkind = require("lspkind")

cmp.setup({
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },
  mapping = {
    ["<C-Space>"] = cmp.mapping.complete(),
  },

  formatting = {
    format = function(entry, vim_item)
      vim_item.kind = lspkind.presets.default[vim_item.kind]
      local menu = source_mapping[entry.source.name]
      if entry.source.name == "cmp_tabnine" then
        if entry.completion_item.data ~= nil and entry.completion_item.data.detail ~= nil then
          menu = entry.completion_item.data.detail .. " " .. menu
        end
        vim_item.kind = ""
      end
      vim_item.menu = menu
      return vim_item
    end,
  },

  sources = {
    { name = "cmp_tabnine" },
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "buffer" },
  },
})

local tabnine = require("cmp_tabnine.config")
tabnine:setup({
  max_lines = 1000,
  max_num_results = 20,
  sort = true,
  run_on_every_keystroke = true,
  snippet_placeholder = "..",
})

local function config(_config)
  return vim.tbl_deep_extend("force", {
    capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities()),
    on_attach = function()
      vim.api.nvim_buf_set_keymap(0, 'n', "gd", ":lua vim.lsp.buf.definition()<CR>", opts)
      vim.api.nvim_buf_set_keymap(0, 'n', "K", ":lua vim.lsp.buf.hover()<CR>", opts)
      --vim.api.nvim_buf_set_keymap(0, 'n', "<leader>vws", ":lua vim.lsp.buf.workspace_symbol()<CR>")
      vim.api.nvim_buf_set_keymap(0, 'n', "<leader>vd", ":lua vim.diagnostic.open_float()<CR>", opts)
      vim.api.nvim_buf_set_keymap(0, 'n', "<leader>lj", ":lua vim.lsp.diagnostic.goto_next()<CR>", opts)
      vim.api.nvim_buf_set_keymap(0, 'n', "<leader>lk", ":lua vim.lsp.diagnostic.goto_prev()<CR>", opts)
      vim.api.nvim_buf_set_keymap(0, 'n', "<leader>la", ":lua vim.lsp.buf.code_action()<CR>", opts)
      vim.api.nvim_buf_set_keymap(0, 'n', "<leader>lr", ":lua vim.lsp.buf.references()<CR>", opts)
      vim.api.nvim_buf_set_keymap(0, 'n', "<leader>rn", ":lua vim.lsp.buf.rename()<CR>", opts)
      vim.api.nvim_buf_set_keymap(0, 'n', "<C-h>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
    end,
  }, _config or {})
end

lspconfig.tsserver.setup(config())
lspconfig.ccls.setup(config())
lspconfig.jedi_language_server.setup(config())
lspconfig.cssls.setup(config())
lspconfig.gopls.setup(config({
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
      },
      staticcheck = true,
    },
  },
}))
lspconfig.rust_analyzer.setup(config())
lspconfig.sumneko_lua.setup(config({
  settings = {
    Lua = {
      diagnostics = {
        globals = {
          'vim'
        }
      }
    }
  }
}))
