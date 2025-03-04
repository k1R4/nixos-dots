return {
  {
    "nosduco/remote-sshfs.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    enabled = true,
    config = function()
      require('remote-sshfs').setup {}
      require('telescope').load_extension 'remote-sshfs'
    end
  }
}
