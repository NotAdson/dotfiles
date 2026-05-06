local status_ok, null_ls = pcall(require, "null-ls")
if not status_ok then
  return
end

local mason_null_ls_status_ok, mason_null_ls = pcall(require, "mason-null-ls")
if mason_null_ls_status_ok then
  mason_null_ls.setup({
    ensure_installed = { "mypy", "cppcheck" }, -- Python and C linters
    automatic_installation = true,
  })
end

null_ls.setup({
  sources = {
    null_ls.builtins.diagnostics.mypy,
    null_ls.builtins.diagnostics.cppcheck,
  },
})
