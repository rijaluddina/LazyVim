return {
   "nvimtools/none-ls.nvim",
   config = function()
      local null_ls = require("null-ls")

      -- formatting

      null_ls.setup({
         sources = {                            -- stylua
            null_ls.builtins.formatting.stylua, -- prettier
            null_ls.builtins.formatting.prettier.with {
               filetypes = { "css", "html", "javascript", "typescript", "json", "yaml" },
               dynamic_command = function()
                  return "prettier"
               end
            } }
      })

      vim.keymap.set("n", "<C-I>", vim.lsp.buf.format, {})
   end
}
