require("config.lazy")
require("config.remap")
require("config.set")

local augroup = vim.api.nvim_create_augroup
local jhidalgoepsGroup = augroup('jhidalgoesp', {})

local autocmd = vim.api.nvim_create_autocmd

autocmd('LspAttach', {
  group = jhidalgoepsGroup,
  callback = function(e)
    local opts = { buffer = e.buf }
    vim.keymap.set("n", "<leader>gd", function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
    vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
    vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
    vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
    vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
    vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references)
  end
})

-- Highlight references
vim.api.nvim_create_autocmd({ "CursorHold" }, {
  callback = function()
    vim.lsp.buf.document_highlight()
  end
})

vim.api.nvim_create_autocmd({ "CursorMoved" }, {
  callback = function()
    vim.lsp.buf.clear_references()
  end
})

-- Format on save
vim.api.nvim_create_augroup("FormatAutogroup", { clear = true })
vim.api.nvim_create_autocmd("BufWritePost", {
  group = "FormatAutogroup",
  command = "FormatWrite"
})
