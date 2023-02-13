require'lspconfig'.rust_analyzer.setup{}
require'lspconfig'.pylsp.setup {
  settings = {
	  pylsp = {
      configurationSources = {"pylint"},
      plugins = {
        pylint = { enabled = true },
        flake8 = { enabled = false },
        pycodestyle = { enabled = false },
        pyflakes = { enabled = false },
      }
    }
  }
}

