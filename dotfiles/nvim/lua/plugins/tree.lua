return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  enabled = true,
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    require("nvim-tree").setup {}
    vim.keymap.set("n", "<leader>e", ":NvimTreeFindFileToggle<CR>")
  end,
}
