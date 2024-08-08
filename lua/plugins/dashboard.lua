return {
  {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    opts = function(_, opts)
      -- week_header
      opts.config.week_header = {
        enable = true,
      }
    end,
    dependencies = { { "nvim-tree/nvim-web-devicons" } },
  },
}
