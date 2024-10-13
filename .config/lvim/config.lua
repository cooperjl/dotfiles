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
    "vhyrro/luarocks.nvim",
    priority = 1001,
    opts = {
      rocks = { "magick" },
    },
  },
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
  {
    "3rd/image.nvim",
    version = "1.3.0",
    dependencies = { "luarocks.nvim" },
    config = function()
      require("image").setup({
        backend = "kitty",
        intergrations = {
          markdown = {
            enabled = true,
            clear_in_insert_mode = false,
            only_render_image_at_cursor = false,
            filetypes = { "markdown" },
          },
        },
        max_width = 100,
        max_height = 12,
        max_width_window_percentage = math.huge,
        max_height_window_percentage = math.huge,
        window_overlap_clear_enabled = true,
        window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
        hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg" },
      })
    end,
  },
  -- Rust
  {
    'mrcjkb/rustaceanvim',
    version = '^5',
    lazy = false,
  },
  -- Markdown
  -- {
  --   "iamcco/markdown-preview.nvim",
  --   build = "cd app && npm install",
  --   ft = "markdown",
  -- },
  -- org mode
  {
    'nvim-orgmode/orgmode',
    event = 'VeryLazy',
    ft = { 'org' },
    config = function()
      require('orgmode').setup({
        org_agenda_files = '~/documents/orgfiles/**/*',
        org_default_notes_file = '~/documents/orgfiles/refile.org',
      })
    end,
  },
  -- latex
  {
    "lervag/vimtex",
    lazy = false,
    init = function()
      vim.g.vimtex_view_method = "zathura"
    end
  },
  {
    "benlubas/molten-nvim",
    version = "^1.0.0",
    dependencies = { "3rd/image.nvim" },
    build = ":UpdateRemotePlugins",
    init = function()
      vim.g.molten_image_provider = "image.nvim"
      vim.g.molten_output_win_max_height = 12
      vim.g.molten_wrap_output = true
      vim.g.molten_virt_text_output = true
      vim.g.molten_virt_lines_off_by_1 = true
    end,
  },
  {
    "GCBallesteros/jupytext.nvim",
    config = function()
      require("jupytext").setup({
        style = "markdown",
        output_extension = "md",
        force_ft = "markdown",
      })
    end
  }
}

vim.keymap.set("n", "<leader>v", ":MoltenEvaluateOperator<CR>", { desc = "evaluate operator", silent = true })
vim.keymap.set("n", "<leader>os", ":MoltenEnterOutput<CR>", { desc = "open output window", silent = true })

vim.keymap.set("n", "<leader>rr", ":MoltenReevaluateCell<CR>", { desc = "re-eval cell", silent = true })
vim.keymap.set("v", "<leader>r", "<C-u>:MoltenEvaluateVisual<CR>gv", { desc = "execute visual selection", silent = true })
vim.keymap.set("n", "<leader>oh", ":MoltenHideOutput<CR>", { desc = "close output window", silent = true })
vim.keymap.set("n", "<leader>md", ":MoltenDelete<CR>", { desc = "delete Molten cell", silent = true })

-- lvim.keys.normal_mode[]

-- disable automatic lsp installation
-- lvim.lsp.installer.setup.automatic_installation = false
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

