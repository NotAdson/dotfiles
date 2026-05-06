local status_ok, cmp = pcall(require, "cmp")
if not status_ok then
  return
end

local luasnip_status_ok, luasnip = pcall(require, "luasnip")

cmp.setup({
  snippet = {
    expand = function(args)
      if luasnip_status_ok then
        luasnip.lsp_expand(args.body)
      end
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-Space>"] = cmp.mapping.complete(),

    ["<CR>"] = cmp.mapping(function(fallback)
      fallback()
    end, { "i", "s" }),

    ["<Tab>"] = cmp.mapping(function(fallback)
      local copilot_status_ok, copilot = pcall(require, "copilot.suggestion")
      if copilot_status_ok and copilot.is_visible() then
        copilot.accept()
      elseif cmp.visible() then
        cmp.confirm({ select = true })
      else
        fallback()
      end
    end, { "i", "s" }),
  }),
  sources = cmp.config.sources({
    { name = "copilot" },
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "buffer" },
    { name = "path" },
  }),
})
