return {
  {
    'luukvbaal/statuscol.nvim',
    opts = {
      relculright = true, -- Show relative line numbers on the right-hand side
      ft_ignore = { 'help', 'NvimTree', 'lazy', 'dashboard' }, -- Filetypes to ignore
      segments = {
        {
          text = { '%s' }, -- Sign column
          click = 'v:lua.ScSa',
        },
        {
          text = { '%l' }, -- Line number
          condition = { true }, -- Always show line number
          click = 'v:lua.ScLa',
        },
        {
          text = { ' ' }, -- Spacing between line number and content
        },
      },
    },
    config = function(_, opts)
      require('statuscol').setup(opts)
    end,
  },
}
