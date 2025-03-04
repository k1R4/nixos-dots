return {
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        enabled = true,
        lazy = false,
        config = function()
            require('lualine').setup {
                options = {
                  icons_enabled = true,
                  theme = 'molokai',
                }
            }
        end
    }
}