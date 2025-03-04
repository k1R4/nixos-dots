return {
  {
    "akinsho/bufferline.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    enabled = true,
    config = function()
      vim.opt.termguicolors = true
      require("bufferline").setup {
        options = {
          separator_style = "slant",
          mode = "tabs"
        }
      }
    end
  }
}
