require"nvim-lsp-installer".on_server_ready(function(server)
    local opts = {}
    if server.name == "sumneko_lua" then
        opts = { settings = { Lua = { diagnostics = { globals = { 'vim'}}}}}
        end
    server:setup(opts)
end)
