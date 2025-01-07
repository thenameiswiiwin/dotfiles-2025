-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- Namespace and augroup for HTML class concealment
local namespace = vim.api.nvim_create_namespace('class_conceal')
local group = vim.api.nvim_create_augroup('class_conceal', { clear = true })

-- Function to conceal HTML class attributes
local conceal_html_class = function(bufnr)
  local language_tree = vim.treesitter.get_parser(bufnr, 'html')
  local syntax_tree = language_tree:parse()
  local root = syntax_tree[1]:root()

  local query = vim.treesitter.parse_query(
    'html',
    [[
    ((attribute
        (attribute_name) @att_name (#eq? @att_name "class")
        (quoted_attribute_value (attribute_value) @class_value) (#set! @class_value conceal "…")))
    ]]
  ) -- Conceals with "…" for class values

  for _, captures, metadata in query:iter_matches(root, bufnr, root:start(), root:end_()) do
    local start_row, start_col, end_row, end_col = captures[2]:range()
    vim.api.nvim_buf_set_extmark(bufnr, namespace, start_row, start_col, {
      end_line = end_row,
      end_col = end_col,
      conceal = metadata[2].conceal,
    })
  end
end

-- Autocommand for HTML files to trigger concealment
vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'TextChanged', 'InsertLeave' }, {
  group = group,
  pattern = '*.html',
  callback = function()
    conceal_html_class(vim.api.nvim_get_current_buf())
  end,
})

-- Augroup and autocommands for toggling options based on events
local create_augroup = vim.api.nvim_create_augroup
local create_autocmd = vim.api.nvim_create_autocmd

local set_toggle = create_augroup('set_toggle', { clear = true })

create_autocmd('InsertEnter', {
  callback = function()
    if not vim.tbl_contains({ 'alpha', 'NvimTree', 'SidebarNvim' }, vim.bo.filetype) then
      vim.opt.relativenumber = true
      vim.opt.list = true
    end
  end,
  group = set_toggle,
})

create_autocmd({ 'VimEnter', 'BufEnter', 'InsertLeave' }, {
  callback = function()
    if not vim.tbl_contains({ 'alpha', 'NvimTree', 'SidebarNvim' }, vim.bo.filetype) then
      vim.opt.relativenumber = true
      vim.opt.list = false
    end
  end,
  group = set_toggle,
})

-- Autocommands for adjusting cmdheight during recording
vim.api.nvim_create_autocmd({ 'RecordingEnter', 'RecordingLeave' }, {
  callback = function(event)
    vim.o.cmdheight = event.event == 'RecordingEnter' and 1 or 0
  end,
})
