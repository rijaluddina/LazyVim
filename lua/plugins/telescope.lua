return {{
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies = {'nvim-lua/plenary.nvim'},

    config = function()

        -- search file builtin
        local builtin = require('telescope.builtin')

        -- search file
        vim.keymap.set('n', '<C-p>', builtin.find_files, {})

        -- search keyword grep (all file)
        vim.keymap.set('n', '<C-g>', builtin.live_grep, {})

        -- search keyword buffer
        vim.keymap.set('n', '<C-f>', builtin.buffers, {})

        -- search keyword help page
        vim.keymap.set('n', '<C-h>', builtin.help_tags, {})

        -- search all hidden file
        vim.keymap.set('n', '<C-a>', "<cmd> Telescope find_files follow=true no_ignore=true hidden=true <CR>", {})

        -- search in buffer
        vim.keymap.set('n', '<C-z>', "<cmd> Telescope current_buffer_fuzzy_find <CR>", {})

    end

}, {
    'nvim-telescope/telescope-ui-select.nvim',
    config = function()

        require("telescope").setup {
            extensions = {
                ["ui-select"] = {require("telescope.themes").get_dropdown {}}
            }
        }
        require("telescope").load_extension("ui-select")

    end

}}
