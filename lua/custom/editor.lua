local function gh(repo) return 'https://github.com/' .. repo end

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.pack.add {
  { src = gh 'nvim-neo-tree/neo-tree.nvim', version = vim.version.range '3' },
  gh 'MunifTanjim/nui.nvim',
  gh 'nvim-tree/nvim-web-devicons',
  gh 'windwp/nvim-autopairs',
  gh 'HiPhish/rainbow-delimiters.nvim',
  gh 'lukas-reineke/indent-blankline.nvim',
}

require('neo-tree').setup {
  close_if_last_window = true,
  filesystem = {
    follow_current_file = { enabled = true },
    use_libuv_file_watcher = true,
  },
  window = { position = 'left', width = 34 },
}

vim.keymap.set('n', '<leader>e', '<cmd>Neotree toggle<CR>', { desc = '[E]xplorer toggle' })
vim.keymap.set('n', '<leader>E', '<cmd>Neotree reveal<CR>', { desc = '[E]xplorer reveal current file' })

require('nvim-autopairs').setup { check_ts = true }

local rainbow = {
  'RainbowDelimiterRed',
  'RainbowDelimiterYellow',
  'RainbowDelimiterBlue',
  'RainbowDelimiterOrange',
  'RainbowDelimiterGreen',
  'RainbowDelimiterViolet',
  'RainbowDelimiterCyan',
}
vim.g.rainbow_delimiters = { highlight = rainbow }

local hooks = require 'ibl.hooks'
require('ibl').setup { scope = { highlight = rainbow } }
hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
