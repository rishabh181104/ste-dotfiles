local null_ls = require('null-ls')
null_ls.setup({
	sources = {
		null_ls.builtins.diagnostics.eslint, -- Example
		null_ls.builtins.formatting.prettier, -- Example
	},
})
