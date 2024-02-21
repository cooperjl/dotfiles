-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny

local formatters = require("lvim.lsp.null-ls.formatters")
formatters.setup({
	{ command = "rustfmt", filetypes = { "rust" } },
})

lvim.plugins = {
  -- IDE
  "sainnhe/gruvbox-material",
  -- {
  -- "neanias/everforest-nvim",
  -- version = false,
  -- lazy = false,
  -- priority = 1000, -- make sure to load this before all the other start plugins
  -- config = function()
  --   require("everforest").setup({
  --     background = "hard",
  --   })
  -- end,
  -- },

  -- Languages
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

lvim.colorscheme = "gruvbox-material"

vim.g.gruvbox_material_background="hard"

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

