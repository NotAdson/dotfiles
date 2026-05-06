local status_ok, _ = pcall(require, "pywal")
if not status_ok then
  return
end

vim.cmd([[colorscheme pywal]])
