local function gh(repo) return 'https://github.com/' .. repo end

vim.pack.add {
  gh 'mfussenegger/nvim-dap',
  gh 'rcarriga/nvim-dap-ui',
  gh 'nvim-neotest/nvim-nio',
  gh 'mfussenegger/nvim-dap-python',
}

local dap = require 'dap'
local dapui = require 'dapui'

dapui.setup {
  layouts = {
    {
      elements = { 'scopes', 'breakpoints', 'stacks', 'watches' },
      position = 'right',
      size = 40,
    },
    {
      elements = { 'repl', 'console' },
      position = 'bottom',
      size = 10,
    },
  },
}

dap.listeners.after.event_initialized['dapui_config'] = dapui.open
dap.listeners.before.event_terminated['dapui_config'] = dapui.close
dap.listeners.before.event_exited['dapui_config'] = dapui.close

vim.keymap.set('n', '<F5>', dap.continue, { desc = 'Debug: Start/continue' })
vim.keymap.set('n', '<F10>', dap.step_over, { desc = 'Debug: Step over' })
vim.keymap.set('n', '<F11>', dap.step_into, { desc = 'Debug: Step into' })
vim.keymap.set('n', '<F12>', dap.step_out, { desc = 'Debug: Step out' })
vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint, { desc = 'Debug: Toggle breakpoint' })
vim.keymap.set('n', '<leader>B', function() dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ') end, { desc = 'Debug: Conditional breakpoint' })
vim.keymap.set('n', '<leader>du', dapui.toggle, { desc = '[D]ebug [U]I' })

local debugpy = vim.fn.stdpath 'data' .. '/mason/packages/debugpy/venv/' .. (vim.fn.has 'win32' == 1 and 'Scripts/python.exe' or 'bin/python')
require('dap-python').setup(debugpy)
