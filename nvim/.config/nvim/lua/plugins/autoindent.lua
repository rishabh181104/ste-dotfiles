vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	callback = function()
		vim.lsp.buf.format({ async = false }) -- Use LSP formatting if available
		vim.cmd("normal gg=G") -- Apply manual indentation as a fallback
	end,
})
