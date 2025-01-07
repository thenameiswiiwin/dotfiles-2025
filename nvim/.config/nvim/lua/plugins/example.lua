-- since this is just an example spec, don't actually load anything here and return an empty spec
-- stylua: ignore
if true then return {} end

-- every spec file under config.plugins will be loaded automatically by lazy.nvim
-- In your plugin files, you can:
-- * add extra plugins
-- * disable/enabled LazyVim plugins
-- * override the configuration of LazyVim plugins
return {
  -- Add gruvbox color scheme
  { 'ellisonleao/gruvbox.nvim' },

  -- Configure LazyVim to load gruvbox
  {
    'LazyVim/LazyVim',
    opts = {
      colorscheme = 'gruvbox',
    },
  },

  -- Modify trouble.nvim config
  {
    'folke/trouble.nvim',
    opts = { use_diagnostic_signs = true },
  },

  -- Disable trouble.nvim
  { 'folke/trouble.nvim', enabled = false },

  -- Add symbols-outline.nvim plugin
  {
    'simrat39/symbols-outline.nvim',
    cmd = 'SymbolsOutline',
    keys = {
      { '<leader>cs', '<cmd>SymbolsOutline<cr>', desc = 'Symbols Outline' },
    },
    config = true,
  },

  -- Override nvim-cmp and add cmp-emoji
  {
    'hrsh7th/nvim-cmp',
    dependencies = { 'hrsh7th/cmp-emoji' },
    opts = function(_, opts)
      local cmp = require('cmp')
      opts.sources = cmp.config.sources(vim.list_extend(opts.sources, { { name = 'emoji' } }))
    end,
  },

  -- Modify telescope.nvim options and keymaps
  {
    'nvim-telescope/telescope.nvim',
    keys = {
      {
        '<leader>fp',
        function()
          require('telescope.builtin').find_files({
            cwd = require('lazy.core.config').options.root,
          })
        end,
        desc = 'Find Plugin File',
      },
    },
    opts = {
      defaults = {
        layout_strategy = 'horizontal',
        layout_config = { prompt_position = 'top' },
        sorting_strategy = 'ascending',
        winblend = 0,
      },
    },
  },

  -- Add telescope-fzf-native.nvim
  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    },
    config = function(_, opts)
      local telescope = require('telescope')
      telescope.setup(opts)
      telescope.load_extension('fzf')
    end,
  },

  -- Add pyright to LSP config
  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = {
        pyright = {},
      },
    },
  },

  -- Add tsserver and setup with typescript.nvim
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'jose-elias-alvarez/typescript.nvim',
      config = function()
        local on_attach = function(_, buffer)
          vim.keymap.set(
            'n',
            '<leader>co',
            ':TypescriptOrganizeImports<CR>',
            { buffer = buffer, desc = 'Organize Imports' }
          )
          vim.keymap.set('n', '<leader>cR', ':TypescriptRenameFile<CR>', { buffer = buffer, desc = 'Rename File' })
        end

        require('lspconfig').tsserver.setup({
          on_attach = on_attach,
        })
      end,
    },
  },

  -- Add more treesitter parsers
  {
    'nvim-treesitter/nvim-treesitter',
    opts = {
      ensure_installed = {
        'bash',
        'help',
        'html',
        'javascript',
        'json',
        'lua',
        'markdown',
        'python',
        'typescript',
        'yaml',
      },
    },
  },

  -- Extend lualine.nvim config
  {
    'nvim-lualine/lualine.nvim',
    event = 'VeryLazy',
    opts = function(_, opts)
      table.insert(opts.sections.lualine_x, '😄')
    end,
  },

  -- Use mini.starter instead of alpha
  { import = 'lazyvim.plugins.extras.ui.mini-starter' },

  -- Add essential tools via Mason
  {
    'williamboman/mason.nvim',
    opts = {
      ensure_installed = {
        'stylua',
        'shellcheck',
        'shfmt',
        'flake8',
      },
    },
  },

  -- Configure LuaSnip and nvim-cmp for <Tab> completion
  {
    'L3MON4D3/LuaSnip',
    keys = function()
      return {}
    end,
  },
  {
    'hrsh7th/nvim-cmp',
    dependencies = { 'hrsh7th/cmp-emoji' },
    opts = function(_, opts)
      local luasnip = require('luasnip')
      local cmp = require('cmp')

      opts.mapping = vim.tbl_extend('force', opts.mapping, {
        ['<Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { 'i', 's' }),
      })
    end,
  },
}
