require("mason-lspconfig").setup({
	ensure_installed = {
		"pyright", -- Python LSP
		"rust_analyzer", -- Rust LSP
		"gopls", -- Go LSP
		"ts_ls", -- JavaScript/TypeScript LSP
		"html", -- HTML LSP
		"cssls", -- CSS LSP
	},
})

-- Setup handlers for LSP
local lspconfig = require("lspconfig")
require("mason-lspconfig").setup_handlers({
	function(server_name)
		lspconfig[server_name].setup({})
	end,
})

-- Mason-null-ls setup for formatters and linters
require("mason-null-ls").setup({
	ensure_installed = {
		-- Formatters
		"black", -- Python formatter
		"stylua", -- Lua formatter (optional, for Neovim configuration)
		"prettier", -- Formatter for JavaScript, TypeScript, HTML, CSS
		"rustfmt", -- Rust formatter
		"gofumpt", -- Go formatter

		-- Linters
		"flake8", -- Python linter
		"eslint_d", -- JavaScript/TypeScript linter
	},
	automatic_installation = true,
})

-- Null-ls configuration
local null_ls = require("null-ls")
null_ls.setup({
	sources = {
		null_ls.builtins.formatting.black,
		null_ls.builtins.formatting.stylua,
		null_ls.builtins.formatting.prettier,
		null_ls.builtins.formatting.rustfmt,
		null_ls.builtins.formatting.gofumpt,

		null_ls.builtins.diagnostics.flake8,
		null_ls.builtins.diagnostics.eslint_d,
	},
})
