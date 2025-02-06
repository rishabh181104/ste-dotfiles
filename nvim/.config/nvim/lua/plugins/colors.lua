require("cyberdream").setup({
	variant = "dark",

	transparent = true,

	saturation = 1,
	italic_comments = true,
	hide_fillchars = false,
	borderless_pickers = true,
	terminal_colors = true,
	cache = false,
	highlights = {
		Comment = { fg = "#696969", bg = "NONE", italic = true },
	},
	overrides = function(colors)
		return {
			Comment = { fg = colors.green, bg = "NONE", italic = true },
			["@property"] = { fg = colors.magenta, bold = true },
		}
	end,
	colors = {
		bg = "#000000",
		green = "#00ff00",
		magenta = "#ff00ff",
	},
})

-- require("rose-pine").setup({
-- 	variant = "main", -- auto, main, moon, or dawn
-- 	dark_variant = "main", -- main, moon, or dawn
-- 	dim_inactive_windows = true,
-- 	extend_background_behind_borders = true,
--
-- 	enable = {
-- 		terminal = true,
-- 		legacy_highlights = true, -- Improve compatibility for previous versions of Neovim
-- 		migrations = true, -- Handle deprecated options automatically
-- 	},
--
-- 	styles = {
-- 		bold = true,
-- 		italic = true,
-- 		transparency = false,
-- 	},
--
-- 	groups = {
-- 		border = "muted",
-- 		link = "iris",
-- 		panel = "surface",
--
-- 		error = "love",
-- 		hint = "iris",
-- 		info = "foam",
-- 		note = "pine",
-- 		todo = "rose",
-- 		warn = "gold",
--
-- 		git_add = "foam",
-- 		git_change = "rose",
-- 		git_delete = "love",
-- 		git_dirty = "rose",
-- 		git_ignore = "muted",
-- 		git_merge = "iris",
-- 		git_rename = "pine",
-- 		git_stage = "iris",
-- 		git_text = "rose",
-- 		git_untracked = "subtle",
--
-- 		h1 = "iris",
-- 		h2 = "foam",
-- 		h3 = "rose",
-- 		h4 = "gold",
-- 		h5 = "pine",
-- 		h6 = "foam",
-- 	},
-- })
--
-- vim.cmd("colorscheme rose-pine-main")
