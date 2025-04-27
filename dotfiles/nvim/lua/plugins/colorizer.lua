return {
  {
    "NvChad/nvim-colorizer.lua",
    enabled = true,
    event = "BufRead",
    config = function()
      require('colorizer').setup {
        filetypes = { "*" },
        user_default_options = {
          RRGGBBAA = true
        }
      }
    end
  }
}
