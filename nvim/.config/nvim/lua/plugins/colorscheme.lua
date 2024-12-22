return {
  {
    "scottmckendry/cyberdream.nvim",
    priority = 1000,
    config = function()
      vim.g.cyberdream_transparent_background = "1"
      vim.g.cyberdream_enable_italic = "1"
      vim.cmd.colorscheme("cyberdream")
    end,
  },
}
