return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "blade" })
    end,

    config = function(_, opts)
      vim.filetype.add({
        pattern = {
          [".*%.blade%.php"] = "blade",
        },
      })

      local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
      parser_config.blade = {
        install_info = {
          url = "https://github.com/EmranMR/tree-sitter-blade",
          files = { "src/parser.c" },
          branch = "main",
        },
        filetype = "blade", -- Filetype Blade
      }

      require("nvim-treesitter.configs").setup(opts)
    end,
  },
}
