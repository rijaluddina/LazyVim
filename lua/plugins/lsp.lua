return { {
   "williamboman/mason.nvim",
   config = function()
      require("mason").setup({})
   end
}, {
   "williamboman/mason-lspconfig.nvim",
   config = function()
      require("mason-lspconfig").setup({
         ensure_installed = { "lua_ls", "cssls", "html", "emmet_ls", "tsserver", "ast_grep", "jsonls", "intelephense",
            "prismals", "vuels" }
      })
   end
}, {
   "neovim/nvim-lspconfig",
   config = function()
      local lspconfig = require("lspconfig")
      local lsp_capabilities = vim.lsp.protocol.make_client_capabilities()
      lsp_capabilities.textDocument.completion.completionItem.snippetSupport = true

      lspconfig.emmet_ls.setup({
         capabilities = lsp_capabilities,
         filetypes = { "css", "eruby", "html", "javascript", "javascriptreact", "less", "sass", "scss", "svelte",
            "pug", "typescriptreact", "vue" },
         init_options = {
            html = {
               options = {
                  -- For possible options, see: https://github.com/emmetio/emmet/blob/master/src/config.ts#L79-L267
                  ["bem.enabled"] = true
               }
            }
         }
      })

      lspconfig.html.setup({})
      lspconfig.cssls.setup({})

      -- lsp lua
      lspconfig.lua_ls.setup({
         capabilities = lsp_capabilities,
         on_attach = function(client)
            client.server_capabilities.documentFormattingProvider = true
         end
      })
      lspconfig.tsserver.setup({
         capabilities = lsp_capabilities,
         on_attach = function(client)
            client.server_capabilities.documentFormattingProvider = true
         end
      })
      lspconfig.ast_grep.setup({
         capabilities = lsp_capabilities,
         on_attach = function(client)
            client.server_capabilities.documentFormattingProvider = true
         end
      })
      lspconfig.jsonls.setup({
         capabilities = lsp_capabilities,
         on_attach = function(client)
            client.server_capabilities.documentFormattingProvider = true
         end
      })
      lspconfig.intelephense.setup({
         capabilities = lsp_capabilities,
         on_attach = function(client)
            client.server_capabilities.documentFormattingProvider = true
         end
      })
      lspconfig.prismals.setup({
         capabilities = lsp_capabilities,
         on_attach = function(client)
            client.server_capabilities.documentFormattingProvider = true
         end
      })
      lspconfig.vuels.setup({
         capabilities = lsp_capabilities,
         on_attach = function(client)
            client.server_capabilities.documentFormattingProvider = true
         end
      })

      local opts = {
         noremap = true,
         silent = true
      }

      vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
      vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
      vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)

      -- code actions
      vim.keymap.set("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)

      vim.keymap.set("n", "<A-p>", vim.diagnostic.goto_prev, opts)
      vim.keymap.set("n", "<A-n>", vim.diagnostic.goto_next, opts)
      vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, opts)

      vim.keymap.set("n", "<C-K>", vim.lsp.buf.signature_help, opts)
      vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts)
      vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts)
      vim.keymap.set("n", "<leader>wl", function()
         print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end, opts)
      vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, opts)
      vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
      vim.keymap.set("n", "<leader>E", vim.diagnostic.open_float, opts)
      vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, opts)
   end
} }
