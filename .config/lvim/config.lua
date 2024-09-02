-- vim options
local options = {
  relativenumber = true, -- relative line numbers is helpful with vim
  clipboard = "unnamedplus", -- share with system clipboard
  shiftwidth = 2, -- amount of spaces per tab
  tabstop = 2, -- how many spaces a tab character is displayed with
}

for k, v in pairs(options) do
  vim.opt[k] = v
end

local dap = require('dap')
dap.adapters.python = {
  type = 'executable',
  command = 'python',
  args = {'-m', 'debugpy.adapter'},
}
dap.configurations.python = {
  {
    type = 'python',
    request = 'launch',
    name = "Launch file",
    program = "${file}",
    pythonPath = function()
      local cwd = vim.fn.getcwd()
      if vim.fn.executable(cwd .. '/venv/bin/python') == 1 then
        return cwd .. '/venv/bin/python'
      elseif vim.fn.executable(cwd .. '/.venv/bin/python') == 1 then
        return cwd .. '/.venv/bin/python'
      else
        return '/usr/bin/python'
      end
    end;
  },
}

--local formatters = require("lvim.lsp.null-ls.formatters")
--formatters.setup({
--  { command = "rustfmt", filetypes = { "rust" } },
--})

lvim.plugins = {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      style = "night",
      styles = {
        keywords = { italic = false },
      },
    },
  },

  "sainnhe/gruvbox-material",

  -- Rust
  {
    'mrcjkb/rustaceanvim',
    version = '^5',
    lazy = false,
  },
  -- Markdown
  {
    "iamcco/markdown-preview.nvim",
    build = "cd app && npm install",
    ft = "markdown",
  },
}

-- disable automatic lsp installation
lvim.lsp.installer.setup.automatic_installation = false
-- ensure rust analyzer from the system is skipped if it exists
vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "rust_analyzer" })

require("lvim.lsp.manager").setup("marksman")


lvim.colorscheme = "tokyonight"

-- vim.g.gruvbox_material_background="hard"

-- wgsl filetype
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = "*.wgsl",
  callback = function()
    vim.bo.filetype = "wgsl"
  end,
})

-- nvim.cmp config settings, no border, background colour better Normal:NormalFloat was on but removed
-- border options: none, rounded, single, double, shadow
lvim.builtin.cmp.window.completion.border = "none"
lvim.builtin.cmp.window.completion.winhighlight = "FloatBorder:NormalFloat"

lvim.builtin.cmp.window.documentation.border = "none"
lvim.builtin.cmp.window.documentation.winhighlight = "FloatBorder:NormalFloat"
