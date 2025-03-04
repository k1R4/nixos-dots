return {
  {
    'rmagatti/auto-session',
    lazy = false,
    enabled = true,
    config = function()
      vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
      require('auto-session').setup {}
    end
  }
}
