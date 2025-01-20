-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

local namespace = vim.api.nvim_create_namespace("class_conceal")
local group = vim.api.nvim_create_augroup("class_conceal", { clear = true })

local conceal_html_class = function(bufnr)
    local language_tree = vim.treesitter.get_parser(bufnr, "html")
    if not language_tree then
        vim.notify("Failed to get Treesitter parser for HTML", vim.log.levels.ERROR)
        return
    end

    local syntax_tree = language_tree:parse()
    if not syntax_tree or not syntax_tree[1] then
        vim.notify("Failed to parse syntax tree for HTML", vim.log.levels.ERROR)
        return
    end

    local root = syntax_tree[1]:root()

    local ok, query = pcall(vim.treesitter.query.parse, "html", [[
        ((attribute
            (attribute_name) @att_name (#eq? @att_name "class")
            (quoted_attribute_value (attribute_value) @class_value)))
    ]])

    if not ok then
        vim.notify("Failed to parse Treesitter query for HTML concealment: " .. tostring(query), vim.log.levels.ERROR)
        return
    end

    local success, err = pcall(function()
        for _, captures in query:iter_matches(root, bufnr, root:start(), root:end_(), {}) do
            local class_value_node = captures[2]
            if class_value_node then
                local start_row, start_col, end_row, end_col = class_value_node:range()
                vim.api.nvim_buf_set_extmark(bufnr, namespace, start_row, start_col, {
                    end_line = end_row,
                    end_col = end_col,
                    conceal = "…",
                })
            end
        end
    end)

    if not success then
        vim.notify("Error during iter_matches: " .. err, vim.log.levels.ERROR)
    end
end

vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "TextChanged", "InsertLeave" }, {
    group = vim.api.nvim_create_augroup("class_conceal", { clear = true }),
    pattern = "*.html",
    callback = function()
        local ok, err = pcall(function()
            conceal_html_class(vim.api.nvim_get_current_buf())
        end)
        if not ok then
            vim.notify("Error in HTML concealment: " .. err, vim.log.levels.ERROR)
        end
    end,
})

local create_augroup = vim.api.nvim_create_augroup
local create_autocmd = vim.api.nvim_create_autocmd

local set_toggle = create_augroup("set_toggle", { clear = true })

create_autocmd("InsertEnter", {
    callback = function()
        if vim.bo.filetype ~= "alpha" and vim.bo.filetype ~= "NvimTree" and vim.bo.filetype ~= "SidebarNvim" then
            vim.opt.relativenumber = true
            vim.opt.list = true
        end
    end,
    group = set_toggle,
})

create_autocmd({ "VimEnter", "BufEnter", "InsertLeave" }, {
    callback = function()
        if vim.bo.filetype ~= "alpha" and vim.bo.filetype ~= "NvimTree" and vim.bo.filetype ~= "SidebarNvim" then
            vim.opt.relativenumber = true
            vim.opt.list = false
        end
    end,
    group = set_toggle,
})

vim.api.nvim_create_autocmd({ "RecordingEnter", "RecordingLeave" }, {
    callback = function(match)
        vim.o.cmdheight = match.event == "RecordingEnter" and 1 or 0
    end,
})
