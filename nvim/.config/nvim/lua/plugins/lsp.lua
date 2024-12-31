local lspconfig = require('lspconfig')
local cmp = require('cmp')
local lspconfig_defaults = lspconfig.util.default_config

-- Extend default capabilities
lspconfig_defaults.capabilities = vim.tbl_deep_extend(
	'force',
	lspconfig_defaults.capabilities,
	require('cmp_nvim_lsp').default_capabilities()
)

-- LSP key mappings and actions
vim.api.nvim_create_autocmd('LspAttach', {
	desc = 'LSP actions',
	callback = function(event)
		local opts = {buffer = event.buf}

		vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
		vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
		vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
		vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
		vim.keymap.set('n', 'go', vim.lsp.buf.type_definition, opts)
		vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
		vim.keymap.set('n', 'gs', vim.lsp.buf.signature_help, opts)
		vim.keymap.set('n', '<F2>', vim.lsp.buf.rename, opts)
		vim.keymap.set({'n', 'x'}, '<F3>', function() vim.lsp.buf.format({async = true}) end, opts)
		vim.keymap.set('n', '<F4>', vim.lsp.buf.code_action, opts)
	end,
})

-- Language server setup
local servers = {
	pyright = {},  -- Python
	rust_analyzer = {},  -- Rust
	gopls = {},  -- Go
	ts_ls = {},  -- TypeScript/JavaScript
	html = {},  -- HTML
	cssls = {},  -- CSS
	gleam = {},  -- Existing Gleam
	ocamllsp = {}  -- Existing OCaml
}

for server, config in pairs(servers) do
	lspconfig[server].setup(config)
end

-- CMP setup
cmp.setup({
	sources = {
		{name = 'nvim_lsp'},
	},
	snippet = {
		expand = function(args)
			vim.fn["vsnip#anonymous"](args.body)  -- Adjust if using a different snippet plugin
		end,
	},
	mapping = cmp.mapping.preset.insert({}),
})

