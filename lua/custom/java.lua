local M = {}

local function java_bundles()
  local packages = vim.fn.stdpath 'data' .. '/mason/packages/'
  local bundles = vim.fn.glob(packages .. 'java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar', true, true)
  local excluded = {
    ['com.microsoft.java.test.runner-jar-with-dependencies.jar'] = true,
    ['jacocoagent.jar'] = true,
  }

  for _, jar in ipairs(vim.fn.glob(packages .. 'java-test/extension/server/*.jar', true, true)) do
    if not excluded[vim.fs.basename(jar)] then table.insert(bundles, jar) end
  end
  return bundles
end

function M.start_or_attach()
  local root_dir = vim.fs.root(0, { 'gradlew', 'mvnw', 'pom.xml', 'build.gradle', 'build.gradle.kts', 'settings.gradle', 'settings.gradle.kts', '.git' })
    or vim.fn.getcwd()
  local project = vim.fs.basename(root_dir)
  local workspace = ('%s/jdtls/%s-%s'):format(vim.fn.stdpath 'cache', project, vim.fn.sha256(root_dir):sub(1, 12))
  local bundles = java_bundles()

  require('jdtls').start_or_attach {
    cmd = { 'jdtls', '-data', workspace },
    root_dir = root_dir,
    capabilities = require('blink.cmp').get_lsp_capabilities(),
    settings = {
      java = {
        signatureHelp = { enabled = true },
      },
    },
    init_options = { bundles = bundles },
    on_attach = function()
      if #bundles > 0 then
        require('jdtls').setup_dap { hotcodereplace = 'auto' }
        require('jdtls.dap').setup_dap_main_class_configs()
      end
    end,
  }
end

return M
