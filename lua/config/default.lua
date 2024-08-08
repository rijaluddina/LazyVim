-- set leader spasi key
vim.g.mapleader = " "

-- set clipboard options
vim.opt.clipboard = "unnamedplus"

-- set tab 4 spasi
vim.o.tabstop = 3
vim.o.expandtab = true
vim.o.softtabstop = 3
vim.o.shiftwidth = 3

-- set relative line number
vim.wo.relativenumber = true


-- line break
vim.opt.breakindent = true
vim.opt.formatoptions:remove "t"
vim.opt.linebreak = true

-- incremental search
vim.opt.incsearch = true

-- terminal color
vim.opt.termguicolors = true

-- line padding bottom
vim.opt.scrolloff = 10

vim.opt.signcolumn = "yes"
vim.opt.isfname:append "@-@"
vim.opt.updatetime = 50
