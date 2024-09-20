return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "jose-elias-alvarez/typescript.nvim",
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      init = function()
        require("lazyvim.util").lsp.on_attach(function(_, buffer)
          vim.keymap.set(
            "n",
            "<leader>co",
            "<cmd>TypescriptOrganizeImports<CR>",
            { buffer = buffer, desc = "Organize Imports" }
          )
          vim.keymap.set("n", "<leader>cR", "<cmd>TypescriptRenameFile<CR>", { desc = "Rename File", buffer = buffer })
        end)
      end,
    },
    opts = {
      servers = {
        tsserver = {},
        intelephense = {
          settings = {
            intelephense = {
              diagnostics = { enable = true },
              environment = {
                documentRoot = "/path/to/src",
                includePaths = {
                  "/path/to/drupal/root",
                },
                phpVersion = "8.3.6",
              },
              files = {
                associations = { "*.php", "*.module", "*.inc", "*.install" },
                exclude = {
                  "/path/to/symlinked/src/under/drupal/root/**",
                },
              },
              format = { enable = true },
              licenseKey = "~/.intelephense",
              telemetry = { enabled = true },
            },
          },
        },
        volar = {
          filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
          init_options = {
            vue = {
              hybridMode = false,
            },
          },
        },
      },
      setup = {
        tsserver = function(_, opts)
          require("typescript").setup({ server = opts })
          return true
        end,
        volar = function(_, opts)
          require("lspconfig").volar.setup(opts)
          return true
        end,
      },
    },
  },
}
