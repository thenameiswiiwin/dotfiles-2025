return {
  {
    'Rawnly/gist.nvim',
    cmd = { 'GistCreate', 'GistCreateFromFile', 'GistsList' },
    config = true,
  },
  -- `GistsList` opens the selected gist in a terminal buffer.
  -- nvim-unception uses Neovim remote RPC functionality to open the gist in an actual buffer
  -- and prevents Neovim buffer inception.
  {
    'samjwill/nvim-unception',
    lazy = false,
    init = function()
      vim.g.unception_block_while_host_edits = true
    end,
  },
}
