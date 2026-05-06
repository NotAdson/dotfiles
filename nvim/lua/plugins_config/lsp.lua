local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  return
end

local mason_status_ok, mason = pcall(require, "mason")
local mason_lspconfig_status_ok, mason_lspconfig = pcall(require, "mason-lspconfig")

if mason_status_ok then
  mason.setup()
end

if mason_lspconfig_status_ok then
  mason_lspconfig.setup({
      ensure_installed = { "pyright", "lua_ls", "zls", "clangd", "ruff" },
      automatic_installation = true,
  })
end

-- Diagnostic configuration
local signs = {
  { name = "DiagnosticSignError", text = "" },
  { name = "DiagnosticSignWarn", text = "" },
  { name = "DiagnosticSignHint", text = "" },
  { name = "DiagnosticSignInfo", text = "" },
}

for _, sign in ipairs(signs) do
  vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
end

vim.diagnostic.config({
  virtual_text = true,
  signs = {
    active = signs,
  },
  update_in_insert = true,
  underline = true,
  severity_sort = true,
  float = {
    focusable = false,
    style = "minimal",
    border = "rounded",
    source = "always",
    header = "",
    prefix = "",
  },
})

-- Modern Neovim LSP configuration (v0.11+)
local on_attach = function(client, bufnr)
  local opts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
  vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
  vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
  vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)

  -- Disable semantic tokens to prevent them from overriding Treesitter highlights
  -- This often fixes "flat" coloring issues in Neovim 0.10+
  client.server_capabilities.semanticTokensProvider = nil
end

local cmp_lsp_status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
local capabilities = cmp_lsp_status_ok and cmp_nvim_lsp.default_capabilities() or nil

-- Configure pyright using the new API
vim.lsp.config("pyright", {
  on_attach = on_attach,
  capabilities = capabilities,
})

-- Configure lua_ls
vim.lsp.config("lua_ls", {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false,
      },
      telemetry = {
        enable = false,
      },
    },
  },
})

-- Configure Zig
vim.lsp.config("zls", {
  on_attach = on_attach,
  capabilities = capabilities,
})

-- Configure C/C++
vim.lsp.config("clangd", {
  on_attach = on_attach,
  capabilities = capabilities,
})

-- Configure Ruff (Python linter/formatter)
vim.lsp.config("ruff", {
  on_attach = on_attach,
  capabilities = capabilities,
})

-- Enable the configured servers
vim.lsp.enable("pyright")
vim.lsp.enable("lua_ls")
vim.lsp.enable("zls")
vim.lsp.enable("clangd")
vim.lsp.enable("ruff")
