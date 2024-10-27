-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"

-- EXAMPLE
local servers = { "html", "cssls" }
local nvlsp = require "nvchad.configs.lspconfig"

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }
end

-- language server for python
lspconfig.pyright.setup{}

-- language server for tailwind
lspconfig.tailwindcss.setup{}

-- language server for eslint
lspconfig.eslint.setup{}

-- language server for c and c++
lspconfig.clangd.setup{
  cmd = { "clangd", "--background-index"},
  filetypes = { "c", "cpp" },
  root_dir = require("lspconfig/util").root_pattern("compile_commands.json", "compile_flags.txt", ".git", "CMAKELists.txt"),
}

-- configuring single server, example: typescript
lspconfig.ts_ls.setup {
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
}
