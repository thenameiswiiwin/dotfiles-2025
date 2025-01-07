return {
  {
    'williamboman/mason.nvim',
    opts = function(_, opts)
      -- Add additional tools to be installed by Mason
      vim.list_extend(opts.ensure_installed, {
        'proselint',
        'write-good',
        'alex',
      })
    end,
  },
  {
    'nvimtools/none-ls.nvim',
    opts = function(_, opts)
      local nls = require('null-ls')
      opts.root_dir = opts.root_dir
        or require('null-ls.utils').root_pattern('.null-ls-root', '.neoconf.json', 'Makefile', '.git')
      opts.sources = vim.list_extend(opts.sources or {}, {
        nls.builtins.diagnostics.proselint, -- Diagnostic support for proselint
        nls.builtins.code_actions.proselint, -- Code actions for proselint
        nls.builtins.diagnostics.alex, -- Diagnostic support for alex
        nls.builtins.diagnostics.write_good, -- Diagnostic support for write-good
      })
    end,
  },
}
