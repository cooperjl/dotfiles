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

--local formatters = require("lvim.lsp.null-ls.formatters")
--formatters.setup({
--  { command = "rustfmt", filetypes = { "rust" } },
--})

lvim.plugins = {
  {
    "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      theme = "wave",
      keywordStyle = { italic = false },
      overrides = function(colors)
        local theme = colors.theme
        return {
          -- More uniform popup menu colours
          Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 },
          PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
          PmenuSbar = { bg = theme.ui.bg_m1 },
          PmenuThumb = { bg = theme.ui.bg_p2 },
          -- Disable bold on booleans
          Boolean = { bold = false },
        }
      end,
    }
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
  -- Rust
  {
    'mrcjkb/rustaceanvim',
    version = '^5',
    lazy = false,
  },
  {
    "iamcco/markdown-preview.nvim",
    build = "cd app && npm install",
    ft = "markdown",
  },
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
}

-- lvim.keys.normal_mode[]

-- disable automatic lsp installation
-- lvim.lsp.installer.setup.automatic_installation = false
-- ensure rust analyzer from the system is skipped if it exists
vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "rust_analyzer" })

require("lvim.lsp.manager").setup("marksman")

lvim.colorscheme = "kanagawa"

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

