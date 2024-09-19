return {
  "jose-elias-alvarez/null-ls.nvim",
  opts = function()
    local nls = require("null-ls")
    return {
      -- debug = true,
      diagnostics_format = "#{m} (#{c}) [#{s}]",
      sources = {
        nls.builtins.diagnostics.phpcs,
        nls.builtins.formatting.phpcbf.with({
          args = {
            "-",
            "-q",
            '--standard="Drupal,DrupalPractice"',
            '--extensions="php,module,inc,install,test,profile,theme"',
          },
        }),
      },
    }
  end,
}
