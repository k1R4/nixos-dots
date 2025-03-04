return {
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release' }
    },
    enabled = true,
    config = function()
      vim.keymap.set("n", "<leader>ff", require('telescope.builtin').find_files)
      vim.keymap.set("n", "<leader>fr", require('telescope.builtin').lsp_references)
      vim.keymap.set("n", "<leader>fs", require('telescope.builtin').lsp_document_symbols)
      vim.keymap.set("n", "<leader>fb", require('telescope.builtin').buffers)
      vim.keymap.set("n", "<leader>fg", require('telescope.builtin').live_grep)
      vim.keymap.set("n", "<leader>fh", require('telescope.builtin').help_tags)
    end
  }
}
