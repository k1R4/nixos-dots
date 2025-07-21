return {
  { "hrsh7th/cmp-nvim-lsp" },
  { "hrsh7th/cmp-buffer" },
  { "hrsh7th/cmp-path" },
  { "hrsh7th/cmp-nvim-lua",    ft = "lua" },
  { "saadparwaiz1/cmp_luasnip" },
  { "L3MON4D3/LuaSnip",        build = "make install_jsregexp" },
  {
    "neovim/nvim-lspconfig",
    enabled = true,
    config = function()
      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      local lspconfig = require('lspconfig')
      local servers = { 'ccls', 'basedpyright', 'gopls', 'rust_analyzer', 'nixd', 'ts_ls' }
      for _, lsp in ipairs(servers) do
        local ok, err = pcall(function()
          lspconfig[lsp].setup { capabilities = capabilities }
        end)
        if not ok then
          print("[LSP Setup Error] " .. lsp .. ": " .. err)
        end
      end

      lspconfig.lua_ls.setup { settings = { Lua = { diagnostics = { globals = { 'vim' } } } } }

      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if not client then return end

          if vim.bo.filetype == "nix" then
            vim.api.nvim_create_autocmd('BufWritePre', {
              buffer = args.buf,
              callback = function()
                vim.cmd('%!alejandra -qq')
              end,
            })
          end

          vim.api.nvim_create_autocmd("CursorHold", {
            buffer = args.buf,
            callback = function()
              vim.diagnostic.open_float(nil, { focusable = false, border = "rounded" })
            end,
          })

          if client:supports_method('textDocument/formatting') then
            vim.api.nvim_create_autocmd('BufWritePre', {
              buffer = args.buf,
              callback = function()
                vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
              end,
            })
          end
        end,
      })
    end
  },
  {
    "hrsh7th/nvim-cmp",
    enabled = true,
    config = function()
      local cmp = require('cmp')
      local luasnip = require('luasnip')
      cmp.setup {
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-f>'] = cmp.mapping.scroll_docs(-4),
          ['<C-d>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        sources = {
          { name = "nvim_lsp" },
          { name = "nvim_lua" },
          { name = "luasnip" },
          { name = "path" },
          { name = "buffer" },
        },
      }
    end
  }
}
