local function gh(repo) return 'https://github.com/' .. repo end

vim.pack.add { gh 'mfussenegger/nvim-lint' }

require('lint').linters_by_ft = {
  markdown = { 'markdownlint-cli2' },
}

vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost' }, {
  group = vim.api.nvim_create_augroup('markdown-lint', { clear = true }),
  callback = function() require('lint').try_lint() end,
})
