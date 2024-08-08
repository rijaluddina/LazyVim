return {
  "NvChad/nvterm",
  config = function()
    require("nvterm").setup()

    -- terminal mode

    -- toggle floating
    vim.keymap.set("t", "<A-i>", function()
      require("nvterm.terminal").toggle("float")
    end, {})

    -- toggle horizontal
    vim.keymap.set("t", "<A-h>", function()
      require("nvterm.terminal").toggle("horizontal")
    end, {})

    -- toggle vertical
    vim.keymap.set("t", "<A-v>", function()
      require("nvterm.terminal").toggle("vertical")
    end, {})

    -- normal mode

    -- floating
    vim.keymap.set("n", "<A-i>", function()
      require("nvterm.terminal").toggle("float")
    end, {})

    -- horizontal
    vim.keymap.set("n", "<A-h>", function()
      require("nvterm.terminal").toggle("horizontal")
    end, {})

    -- vertical
    vim.keymap.set("n", "<A-v>", function()
      require("nvterm.terminal").toggle("vertical")
    end, {})
  end,
}
