require('plugins')
require('options')
require('lsp')
require('colorscheme')
require('mason').setup()
require('mason-lspconfig').setup {
    ensure_installed = { 'pylsp', 'rust_analyzer', "clangd" },
}
