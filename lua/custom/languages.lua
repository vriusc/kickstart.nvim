local function gh(repo) return 'https://github.com/' .. repo end

vim.g.rustaceanvim = {
  server = {
    default_settings = {
      ['rust-analyzer'] = {
        check = { command = 'clippy' },
      },
    },
  },
}

vim.pack.add {
  gh 'mfussenegger/nvim-jdtls',
  { src = gh 'mrcjkb/rustaceanvim', version = vim.version.range '^9' },
}
