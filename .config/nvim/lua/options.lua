local options = {
  number = true,
  clipboard = "unnamedplus",
  smartindent = true,
  -- termguicolors = true,
  undofile = true,
  writebackup = false,
  expandtab = true,
  shiftwidth = 2,
  tabstop = 2,
  -- cursorline = true,
  updatetime = 300,
  signcolumn = "number",
  splitbelow = true,
  splitright = true,
  -- numberwidth = 3,
  wrap = false,
  scrolloff = 8,
  sidescrolloff = 8,
  timeoutlen = 100,
  showmode = false,
}

for k, v in pairs(options) do
  vim.opt[k] = v
end

