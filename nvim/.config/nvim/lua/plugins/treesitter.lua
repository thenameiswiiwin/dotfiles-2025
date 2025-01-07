-- Register the 'markdown' language for 'mdx' files
vim.treesitter.language.register('markdown', 'mdx')

return {
  {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/playground',
    },
    opts = {
      -- Add the required modules to avoid warnings
      ensure_installed = {
        'markdown',
        'mdx',
        'lua',
        'javascript',
        'html',
        'css',
      },
      sync_install = false, -- Don't install parsers synchronously
      auto_install = true, -- Automatically install missing parsers
      ignore_install = {}, -- List parsers to ignore (empty here)

      highlight = {
        enable = true, -- Enable syntax highlighting
        additional_vim_regex_highlighting = false,
      },

      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = 'gnn',
          node_incremental = 'grn',
          scope_incremental = 'grc',
          node_decremental = 'grm',
        },
      },

      indent = {
        enable = true, -- Enable indentation
      },

      playground = {
        enable = true, -- Enable the playground
        updatetime = 25, -- Update time for highlighting in the playground
        persist_queries = false, -- Don't persist queries across sessions
        keybindings = {
          toggle_query_editor = 'o',
          toggle_hl_groups = 'i',
          toggle_injected_languages = 't',
          toggle_anonymous_nodes = 'a',
          toggle_language_display = 'I',
          focus_language = 'f',
          unfocus_language = 'F',
          update = 'R',
          goto_node = '<cr>',
          show_help = '?',
        },
      },
    },
  },
  {
    'nvim-treesitter/playground',
    cmd = 'TSPlaygroundToggle', -- Lazy-load when this command is used
  },
}
