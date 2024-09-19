return {
  -- custom colors
  {
    "folke/tokyonight.nvim",
    priority = 1000, -- make sure to load this before all the other start plugins
    opts = {
      lazy = true,
      style = "storm", -- 'moon', -- 'night', -- 'day'
      transparent = true,
    },
  },
}
