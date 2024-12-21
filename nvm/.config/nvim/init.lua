-- init.lua

-- Bootstrap Lazy.nvim
local lazypath = vim.fn.stdpath('data')..'/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git', 'clone', '--filter=blob:none', 'https://github.com/folke/lazy.nvim.git', lazypath
  })
end
vim.opt.rtp:prepend(lazypath)

-- Set leader key to space
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Basic settings
vim.opt.number = true        -- Show line numbers
vim.opt.relativenumber = true -- Show relative line numbers
vim.opt.termguicolors = true -- Enable 24-bit RGB colors

require('lazy').setup({
  -- Add this near the top of your plugin list
  'nvim-tree/nvim-web-devicons', -- Add icons to Neotree

  -- Plugin for Neotree (File Explorer)
  {
    'nvim-neo-tree/neo-tree.nvim',
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- Add this dependency
      "MunifTanjim/nui.nvim",
    },
  },

  -- Install NUI (UI component library)
  'MunifTanjim/nui.nvim',

  -- Install Plenary
  'nvim-lua/plenary.nvim',

  -- Treesitter for syntax highlighting
  'nvim-treesitter/nvim-treesitter',

  -- LSP Configuration
  'neovim/nvim-lspconfig',

  -- Mason for managing LSP, linters, and formatters
  'williamboman/mason.nvim',
  'williamboman/mason-lspconfig.nvim',

  -- Harpoon for easy file navigation
  {
    'ThePrimeagen/harpoon',
    branch = "harpoon2",
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      -- Configuration will be done separately
    end
  },

  -- lualine for status line
  'nvim-lualine/lualine.nvim',

  -- Color Scheme (Dreamy Color Scheme)
  'dracula/vim',

  -- Git integration with lazygit
  'kdheepak/lazygit.nvim',

  -- Blurred UI
  'Pocco81/TrueZen.nvim',

  -- Add/update these in your plugin list
  {
    'junegunn/fzf',
    build = ':call fzf#install()'
  },
  {
    'junegunn/fzf.vim',
    dependencies = { 'junegunn/fzf' }
  },

  })
-- Set Dracula theme for Neovim
vim.cmd('colorscheme dracula')

-- Optional: Customize background and foreground if needed
vim.o.background = 'dark'  -- Set background to dark (you can set to 'light' if you prefer)

require('nvim-treesitter.configs').setup {
  ensure_installed = { "rust", "go", "python", "javascript", "typescript", "java", "c", "cpp" }, -- specify the languages
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
}

-- Mason Setup
require('mason').setup()
require('mason-lspconfig').setup {
  ensure_installed = { 'rust_analyzer', 'gopls', 'pyright', 'ts_ls'},
}

-- LSP Setup
local lspconfig = require('lspconfig')

-- Rust
lspconfig.rust_analyzer.setup {}

-- Go
lspconfig.gopls.setup {}

-- Python
lspconfig.pyright.setup {}

-- JavaScript / TypeScript
lspconfig.ts_ls.setup {}

require("neo-tree").setup({
  close_if_last_window = false,
  popup_border_style = "rounded",
  enable_git_status = true,
  enable_diagnostics = true,
  filesystem = {
    filtered_items = {
      visible = true,
      hide_dotfiles = false,
      hide_gitignored = false,
      hide_hidden = false,
    },
    follow_current_file = {
      enabled = true,
    },
    use_libuv_file_watcher = true,
    icons = {
      folder_closed = "",
      folder_open = "",
      folder_empty = "",
      default = "",
      symlink = "",
    },
  },
  window = {
    position = "left",
    width = 30,
    mapping_options = {
      noremap = true,
      nowait = true,
    },
    mappings = {
      ["<space>"] = "none",
    }
  },
  default_component_configs = {
    container = {
      enable_character_fade = true
    },
    indent = {
      indent_size = 2,
      padding = 1,
      with_markers = true,
      indent_marker = "│",
      last_indent_marker = "└",
      highlight = "NeoTreeIndentMarker",
      with_expanders = true,
      expander_collapsed = "",
      expander_expanded = "",
      expander_highlight = "NeoTreeExpander",
    },
    icon = {
      folder_closed = "",
      folder_open = "",
      folder_empty = "",
      default = "",
      highlight = "NeoTreeFileIcon"
    },
    modified = {
      symbol = "●",
      highlight = "NeoTreeModified",
    },
    name = {
      trailing_slash = false,
      use_git_status_colors = true,
      highlight = "NeoTreeFileName",
    },
    git_status = {
      symbols = {
        -- Change type
        added     = "",
        deleted   = "",
        modified  = "",
        renamed   = "",
        -- Status type
        untracked = "",
        ignored   = "",
        unstaged  = "",
        staged    = "",
        conflict  = "",
      },
    },
  },
  document_symbols = {
    kinds = {
      File = { icon = "", hl = "Tag" },
      Namespace = { icon = "", hl = "Include" },
      Package = { icon = "", hl = "Label" },
      Class = { icon = "ﴯ", hl = "Include" },
      Property = { icon = "ﰠ", hl = "@property" },
      Enum = { icon = "", hl = "@number" },
      Function = { icon = "", hl = "Function" },
      String = { icon = "", hl = "String" },
      Number = { icon = "", hl = "Number" },
      Array = { icon = "", hl = "Type" },
      Object = { icon = "", hl = "Type" },
      Key = { icon = "", hl = "" },
      Struct = { icon = "", hl = "Type" },
      Operator = { icon = "", hl = "Operator" },
      TypeParameter = { icon = "", hl = "Type" },
      StaticMethod = { icon = "", hl = 'Function' },
    }
  },
})

-- Add these keymaps for better Neotree navigation
vim.keymap.set('n', '<C-n>', ':Neotree toggle<CR>')
vim.keymap.set('n', '<leader>e', ':Neotree focus<CR>')
vim.keymap.set('n', '<leader>bf', ':Neotree buffers<CR>')  -- Show buffer list
vim.keymap.set('n', '<leader>gs', ':Neotree git_status<CR>')  -- Show git status

-- Initialize harpoon
local harpoon = require("harpoon")

-- Configure harpoon
harpoon:setup({
    settings = {
        save_on_toggle = false,
        sync_on_ui_close = true,
        save_on_change = true,
    }
})

-- Basic harpoon keymaps
vim.keymap.set("n", "<leader>ha", function() harpoon:list():add() end)
vim.keymap.set("n", "<leader>hm", function() 
    local harpoon = require("harpoon")
    harpoon.ui:toggle_quick_menu(harpoon:list()) 
end)

-- Navigation
vim.keymap.set("n", "<leader>1", function() harpoon:list():select(1) end)
vim.keymap.set("n", "<leader>2", function() harpoon:list():select(2) end)
vim.keymap.set("n", "<leader>3", function() harpoon:list():select(3) end)
vim.keymap.set("n", "<leader>4", function() harpoon:list():select(4) end)

-- Previous/next buffers
vim.keymap.set("n", "<leader>hp", function() harpoon:list():prev() end)
vim.keymap.set("n", "<leader>hn", function() harpoon:list():next() end)

require('lualine').setup {
  options = {
    theme = 'dracula',
  },
  sections = {
    lualine_b = {'branch'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'},
  },
}

require('true-zen').setup({
  ui = {
    top = { bg = "#1c1c1c" },
    right = { fg = "#ffffff", bg = "#1c1c1c" },
  },
})

-- Buffer navigation
vim.keymap.set('n', '<leader>bn', ':bnext<CR>')     -- Next buffer
vim.keymap.set('n', '<leader>bp', ':bprevious<CR>')  -- Previous buffer
vim.keymap.set('n', '<leader>bd', ':bdelete<CR>')    -- Delete buffer

-- Map jk and kj to escape
vim.keymap.set('i', 'jk', '<ESC>')
vim.keymap.set('i', 'kj', '<ESC>')

-- Additional quality of life settings
vim.opt.expandtab = true      -- Use spaces instead of tabs
vim.opt.smartindent = true    -- Enable smart indent
vim.opt.wrap = false          -- Display long lines as just one line
vim.opt.ignorecase = true     -- Ignore case in search patterns
vim.opt.smartcase = true      -- Override ignorecase if search pattern contains uppercase
vim.opt.cursorline = true     -- Highlight the current line
vim.opt.scrolloff = 8         -- Minimal number of screen lines to keep above and below the cursor

-- Buffer management keymaps
vim.keymap.set('n', '<leader>w', ':w<CR>')          -- Save
vim.keymap.set('n', '<leader>q', ':q<CR>')          -- Quit
vim.keymap.set('n', '<leader>h', ':nohl<CR>')       -- Clear highlights

-- Window navigation
vim.keymap.set('n', '<C-h>', '<C-w>h')             -- Move to left window
vim.keymap.set('n', '<C-j>', '<C-w>j')             -- Move to bottom window
vim.keymap.set('n', '<C-k>', '<C-w>k')             -- Move to top window
vim.keymap.set('n', '<C-l>', '<C-w>l')             -- Move to right window

-- Window management
vim.keymap.set('n', '<leader>sv', ':vsplit<CR>')    -- Split vertically
vim.keymap.set('n', '<leader>sh', ':split<CR>')     -- Split horizontally

-- FZF configurations
vim.g.fzf_layout = {
  window = {
    width = 0.9,
    height = 0.9,
    border = 'rounded'
  }
}

vim.g.fzf_preview_window = {'right:50%:hidden', 'ctrl-/'}

-- FZF keybindings
-- Files
vim.keymap.set('n', '<leader>ff', ':Files<CR>', { silent = true })  -- Find files
vim.keymap.set('n', '<leader>fg', ':GFiles<CR>', { silent = true }) -- Find git files
vim.keymap.set('n', '<leader>fb', ':Buffers<CR>', { silent = true }) -- Find buffers

-- Search
vim.keymap.set('n', '<leader>fl', ':Lines<CR>', { silent = true })  -- Find lines in all buffers
vim.keymap.set('n', '<leader>fs', ':Rg<CR>', { silent = true })     -- Find string in files
vim.keymap.set('n', '<leader>fc', ':Commits<CR>', { silent = true }) -- Find commits
vim.keymap.set('n', '<leader>fm', ':Maps<CR>', { silent = true })    -- Find keymaps

-- History
vim.keymap.set('n', '<leader>fh', ':History<CR>', { silent = true }) -- File history
vim.keymap.set('n', '<leader>f:', ':History:<CR>', { silent = true }) -- Command history
vim.keymap.set('n', '<leader>f/', ':History/<CR>', { silent = true }) -- Search history

-- Advanced
vim.keymap.set('n', '<leader>ft', ':BTags<CR>', { silent = true })   -- Buffer tags
vim.keymap.set('n', '<leader>fT', ':Tags<CR>', { silent = true })    -- Project tags
vim.keymap.set('n', '<leader>fH', ':Helptags<CR>', { silent = true }) -- Help tags

-- Custom ripgrep command to search in files
vim.cmd([[
  command! -bang -nargs=* Rg
    \ call fzf#vim#grep(
    \   'rg --column --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>),
    \   1,
    \   {'options': '--delimiter : --nth 4..'}, <bang>0)
]])

-- Enable system clipboard integration
vim.opt.clipboard = "unnamedplus"

-- Keybindings for clipboard operations
vim.keymap.set('n', '<leader>y', '"+y')  -- Yank to system clipboard
vim.keymap.set('v', '<leader>y', '"+y')  -- Yank selection to system clipboard
vim.keymap.set('n', '<leader>p', '"+p')  -- Paste from system clipboard
vim.keymap.set('n', '<leader>P', '"+P')  -- Paste before from system clipboard


