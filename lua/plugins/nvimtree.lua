return {
   "nvim-tree/nvim-tree.lua",
   version = "*",
   lazy = false,
   dependencies = {
      "nvim-tree/nvim-web-devicons",
   },
   config = function()
      require("nvim-tree").setup {}

      -- set toggle filetree
      vim.keymap.set("n", "<C-b>", "<cmd> NvimTreeToggle <CR>", {})

      -- set focus
      vim.keymap.set("n", "<leader>e", "<cmd> NvimTreeFocus <CR>", {})
   end,
}
