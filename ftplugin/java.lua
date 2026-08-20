require('custom.java').start_or_attach()

local map = function(lhs, rhs, desc) vim.keymap.set('n', lhs, rhs, { buffer = true, desc = desc }) end
map('<leader>jo', function() require('jdtls').organize_imports() end, '[J]ava [O]rganize imports')
map('<leader>jt', function() require('jdtls').test_nearest_method() end, '[J]ava [T]est nearest method')
map('<leader>jT', function() require('jdtls').test_class() end, '[J]ava [T]est class')
