return {
  {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    opts = function(_, opts)
      local logo = [[
        ██████╗ ███████╗███████╗
        ██╔══██╗██╔════╝██══ ██║
        ██║  ██║█████╗  ███████║
        ██║  ██║██╔══╝  ██║ ║██║
        ██████╔╝██S█████╗██║ ║██║
        ╚═════╝ ╚══════╝══╝ ╚══╝
      ]]

      logo = string.rep("\n", 8) .. logo .. "\n\n"
      opts.config.header = vim.split(logo, "\n")

      -- Menambahkan konfigurasi week_header
      opts.config.week_header = {
        enable = true,
      }
    end,
    dependencies = { { "nvim-tree/nvim-web-devicons" } },
  },
}
