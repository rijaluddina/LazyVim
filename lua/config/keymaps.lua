-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-- search file builtin
local builtin = require("telescope.builtin")

-- search file
vim.keymap.set("n", "<C-p>", builtin.find_files, {})

-- search keyword grep (all file)
vim.keymap.set("n", "<C-g>", builtin.live_grep, {})

-- search keyword buffer
vim.keymap.set("n", "<C-f>", builtin.buffers, {})

-- search keyword help page
vim.keymap.set("n", "<C-h>", builtin.help_tags, {})

-- search all hidden file
vim.keymap.set("n", "<C-a>", ":Telescope find_files follow=true no_ignore=true hidden=true <CR>", {})

-- search in buffer
vim.keymap.set("n", "<C-z>", ":Telescope current_buffer_fuzzy_find <CR>", {})
