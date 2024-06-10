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

local formatters = require("lvim.lsp.null-ls.formatters")
formatters.setup({
  { command = "rustfmt", filetypes = { "rust" } },
})

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
    "simrat39/rust-tools.nvim",
    config = function()
      -- local lsp_installer_servers = require("nvim-lsp-installer.servers")
      -- local _, requested_server = lsp_installer_servers.get_server("rust_analyzer")
      require("rust-tools").setup({
        tools = {
          autoSetHints = true,
          -- hover_with_actions = true,
          -- options same as lsp hover / vim.lsp.util.open_floating_preview()
          hover_actions = {

            -- the border that is used for the hover window
            -- see vim.api.nvim_open_win()
            border = {
              { "╭", "FloatBorder" },
              { "─", "FloatBorder" },
              { "╮", "FloatBorder" },
              { "│", "FloatBorder" },
              { "╯", "FloatBorder" },
              { "─", "FloatBorder" },
              { "╰", "FloatBorder" },
              { "│", "FloatBorder" },
            },

            -- whether the hover action window gets automatically focused
            -- default: false
            auto_focus = true,
          },
          runnables = {
            use_telescope = true,
          },
        },
        server = {
          on_init = require("lvim.lsp").common_on_init,
          on_attach = function(client, bufnr)
            require("lvim.lsp").common_on_attach(client, bufnr)
            local rt = require("rust-tools")
            -- Hover actions
            vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
            -- Code action groups
            vim.keymap.set("n", "<leader>lA", rt.code_action_group.code_action_group, { buffer = bufnr })
          end,
        },
      })
    end,
    ft = { "rust", "rs" },
  },
  -- Markdown
  {
    "iamcco/markdown-preview.nvim",
    build = "cd app && npm install",
    ft = "markdown",
  },
}

-- Disable automatic lsp installation
lvim.lsp.automatic_servers_installation = false

-- 
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
