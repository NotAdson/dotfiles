local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
  return
end

configs.setup {
  ensure_installed = { "python", "lua", "vim", "vimdoc", "markdown", "markdown_inline" },
  auto_install = true,
  highlight = {
    enable = true,
  },
}
