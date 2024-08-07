return {
"nvim-treesitter/nvim-treesitter",
build = ":TSUpdate", 
config = function()
     
local configs = require("nvim-treesitter.configs")

configs.setup({
  ensure_installed = {
     "c",
     "lua",
     "vim",
     "vimdoc",
     "query",
     "elixir",
     "heex",
     "javascript",
     "html",
     "css",
     "typescript",
     "php",
     "python",
     "tsx",
     "json",
     "nix",
  },
  sync_install = false,
  highlight = { enable = true },
  indent = { enable = true },  
  auto_install = true
})
end
}
