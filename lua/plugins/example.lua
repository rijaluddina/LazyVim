-- since this is just an example spec, don't actually load anything here and return an empty spec
-- stylua: ignore

-- every spec file under the "plugins" directory will be loaded automatically by lazy.nvim
--
-- In your plugin files, you can:
-- * add extra plugins
-- * disable/enabled LazyVim plugins
-- * override the configuration of LazyVim plugins

local util = require("conform.util")
if true then
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

    -- custom dashboard
    {
      "nvimdev/dashboard-nvim",
      event = "VimEnter",
      lazy = false, -- dashboard-nvim shouldn't be lazy-loaded to properly handle stdin.
      opts = function()
        local logo = [[
        ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗        
        ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║        
        ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║        
        ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║        
        ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║        
        ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝        
      ]]
        logo = string.rep("\n", 8) .. logo .. "\n\n"

        opts = {
          theme = "doom",
          hide = {
            -- disabling statusline as it's managed by lualine
            statusline = false,
          },
          config = {
            -- using DASHBOARD header commant all header ( header & week_header)
            -- or the NEOVIM header
            -- header = vim.split(logo, "\n"),
            -- or the week header
            week_header = {
              enable = true,
            },
            center = {
              {
                action = "lua LazyVim.pick()()",
                desc = " Find File",
                icon = " ",
                key = "f",
              },
              {
                action = "ene | startinsert",
                desc = " New File",
                icon = " ",
                key = "n",
              },
              {
                action = 'lua LazyVim.pick("oldfiles")()',
                desc = " Recent Files",
                icon = " ",
                key = "r",
              },
              {
                action = 'lua LazyVim.pick("live_grep")()',
                desc = " Find Text",
                icon = " ",
                key = "g",
              },
              {
                action = "lua LazyVim.pick.config_files()()",
                desc = " Config",
                icon = " ",
                key = "c",
              },
              {
                action = 'lua require("persistence").load()',
                desc = " Restore Session",
                icon = " ",
                key = "s",
              },
              {
                action = "LazyExtras",
                desc = " Lazy Extras",
                icon = " ",
                key = "x",
              },
              {
                action = "Lazy",
                desc = " Lazy",
                icon = "󰒲 ",
                key = "l",
              },
              {
                action = function()
                  vim.api.nvim_input("<cmd>qa<cr>")
                end,
                desc = " Quit",
                icon = " ",
                key = "q",
              },
            },
            footer = function()
              local stats = require("lazy").stats()
              local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
              return { "⚡ Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms" }
            end,
          },
        }

        for _, button in ipairs(opts.config.center) do
          button.desc = button.desc .. string.rep(" ", 43 - #button.desc)
          button.key_format = "  %s"
        end

        -- open dashboard after closing lazy if necessary
        if vim.o.filetype == "lazy" then
          vim.api.nvim_create_autocmd("WinClosed", {
            pattern = tostring(vim.api.nvim_get_current_win()),
            once = true,
            callback = function()
              vim.schedule(function()
                vim.api.nvim_exec_autocmds("UIEnter", { group = "dashboard" })
              end)
            end,
          })
        end

        return opts
      end,
      dependencies = { { "nvim-tree/nvim-web-devicons" } },
    },

    -- lua functions that many plugins use
    { "nvim-lua/plenary.nvim" },

    -- tmux & split window navigation
    {
      "christoomey/vim-tmux-navigator",
      cmd = {
        "TmuxNavigateLeft",
        "TmuxNavigateDown",
        "TmuxNavigateUp",
        "TmuxNavigateRight",
        "TmuxNavigatePrevious",
      },
      keys = {
        { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
        { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
        { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
        { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
        { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
      },
    },

    -- add custom terminal
    {
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
    },

    -- add pyright to lspconfig
    {
      "neovim/nvim-lspconfig",
      ---@class PluginLspOpts
      opts = {
        ---@type lspconfig.options
        servers = {
          -- pyright will be automatically installed with mason and loaded with lspconfig
          pyright = {
            intelephense = {
              filetypes = { "php", "blade", "php_only" },
              settings = {
                intelephense = {
                  filetypes = { "php", "blade", "php_only" },
                  files = {
                    associations = { "*.php", "*.blade.php" }, -- Associating .blade.php files as well
                    maxSize = 5000000,
                  },
                },
              },
            },
          },
        },
      },
    },

    -- add tsserver and setup with typescript.nvim instead of lspconfig
    {
      "neovim/nvim-lspconfig",
      dependencies = {
        "jose-elias-alvarez/typescript.nvim",
        init = function()
          require("lazyvim.util").lsp.on_attach(function(_, buffer)
          -- stylua: ignore
          vim.keymap.set( "n", "<leader>co", "TypescriptOrganizeImports", { buffer = buffer, desc = "Organize Imports" })
            vim.keymap.set("n", "<leader>cR", "TypescriptRenameFile", { desc = "Rename File", buffer = buffer })
          end)
        end,
      },
      ---@class PluginLspOpts
      opts = {
        ---@type lspconfig.options
        servers = {
          -- tsserver will be automatically installed with mason and loaded with lspconfig
          tsserver = {},
        },
        -- you can do any additional lsp server setup here
        -- return true if you don't want this server to be setup with lspconfig
        ---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
        setup = {
          -- example to setup with typescript.nvim
          tsserver = function(_, opts)
            require("typescript").setup({ server = opts })
            return true
          end,
          -- Specify * to use this function as a fallback for any server
          -- ["*"] = function(server, opts) end,
        },
      },
    },

    -- for typescript, LazyVim also includes extra specs to properly setup lspconfig,
    -- treesitter, mason and typescript.nvim. So instead of the above, you can use:
    { import = "lazyvim.plugins.extras.lang.typescript" },

    -- add more treesitter parsers
    -- since `vim.tbl_deep_extend`, can only merge tables and not lists, the code above
    -- would overwrite `ensure_installed` with the new value.
    -- If you'd rather extend the default config, use the code below instead:
    {
      "nvim-treesitter/nvim-treesitter",
      opts = function(_, opts)
        vim.list_extend(opts.ensure_installed, {})
      end,

      config = function(_, opts)
        vim.filetype.add({
          pattern = {
            [".*%.blade%.php"] = "blade",
          },
        })
        -- Add a Treesitter parser for Laravel Blade to provide Blade syntax highlighting.
        require("nvim-treesitter.configs").setup(opts)
        local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
        parser_config.blade = {
          install_info = {
            url = "https://github.com/EmranMR/tree-sitter-blade",
            files = { "src/parser.c" },
            branch = "main",
          },
          filetype = "blade", -- after this run :TSInstall blade
        }
      end,
    },

    -- add jsonls and schemastore packages, and setup treesitter for json, json5 and jsonc
    { import = "lazyvim.plugins.extras.lang.json" },

    -- add any tools you want to have installed below
    {
      "williamboman/mason.nvim",
      opts = {
        ensure_installed = {
          "ast-grep",
          "blade-formatter",
          "black",
          "easy-coding-standard",
          "eslint_d",
          "intelephense",
          "pint",
          "prettierd",
          "php-debug-adapter",
          "rustywind",
          "stylua",
          "shellcheck",
          "shfmt",
          "stimulus-language-server",
          "tlint",
        },
      },
    },

    -- setupOpts laravel blade formatter
    {
      "stevearc/conform.nvim",
      opts = function()
        ---@type conform.setupOpts
        local opts = {
          default_format_opts = {
            timeout_ms = 3000,
            async = false, -- not recommended to change
            quiet = false, -- not recommended to change
            lsp_format = "fallback", -- not recommended to change
          },
          formatters_by_ft = {
            lua = { "stylua" },
            fish = { "fish_indent" },
            sh = { "shfmt" },
            php = { "pint" },
            blade = { "tlint", "blade-formatter", "rustywind" },
            python = { "black" },
            javascript = { "prettierd" },
            typescript = { "prettierd" },
            vue = { "prettierd" },
            -- rust = { "rustfmt" },
          },
          -- LazyVim will merge the options you set here with builtin formatters.
          -- You can also define any custom formatters here.
          ---@type table<string, conform.FormatterConfigOverride|fun(bufnr: integer): nil|conform.FormatterConfigOverride>
          formatters = {
            injected = { options = { ignore_errors = true } },
            -- # Example of using dprint only when a dprint.json file is present
            -- dprint = {
            --   condition = function(ctx)
            --     return vim.fs.find({ "dprint.json" }, { path = ctx.filename, upward = true })[1]
            --   end,
            -- },
            --
            -- # Example of using shfmt with extra args
            -- shfmt = {
            --   extra_args = { "-i", "2", "-ci" },
            -- },
            pint = {
              meta = {
                url = "https://github.com/laravel/pint",
                description = "Laravel Pint is an opinionated PHP code style fixer for minimalists. Pint is built on top of PHP-CS-Fixer and makes it simple to ensure that your code style stays clean and consistent.",
              },
              command = util.find_executable({
                vim.fn.stdpath("data") .. "/mason/bin/pint",
                "vendor/bin/pint",
              }, "pint"),
              args = { "$FILENAME" },
              stdin = false,
            },
          },
        }
        return opts
      end,
    },

    --  suport  blade
    {
      "jwalton512/vim-blade",
    },

    -- add more treesitter parsers
    {
      "nvim-treesitter/nvim-treesitter",
      build = function()
        require("nvim-treesitter.install").update({ with_sync = true })
      end,
      dependencies = {
        {
          "JoosepAlviste/nvim-ts-context-commentstring",
          opts = {
            custom_calculation = function(_, language_tree)
              if
                vim.bo.filetype == "blade"
                and language_tree._lang ~= "javascript"
                and language_tree._lang ~= "php"
              then
                return "{{-- %s --}}"
              end
            end,
          },
        },
        "nvim-treesitter/nvim-treesitter-textobjects",
      },
      opts = {
        ensure_installed = { "php_only" },
        auto_install = true,
        highlight = {
          enable = true,
        },
        -- Needed because treesitter highlight turns off autoindent for php files
        indent = {
          enable = true,
        },
      },
      config = function(_, opts)
        ---@class ParserInfo[]
        local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
        parser_config.blade = {
          install_info = {
            url = "https://github.com/EmranMR/tree-sitter-blade",
            files = {
              "src/parser.c",
              -- 'src/scanner.cc',
            },
            branch = "main",
            generate_requires_npm = true,
            requires_generate_from_grammar = true,
          },
          filetype = "blade",
        }

        require("nvim-treesitter.configs").setup(opts)
      end,
    },

    -- set nvim-dap
    {
      "jay-babu/mason-nvim-dap.nvim",
      dependencies = "mason.nvim",
      cmd = { "DapInstall", "DapUninstall" },
      opts = {
        -- Makes a best effort to setup the various debuggers with
        -- reasonable debug configurations
        automatic_setup = true,
        -- You can provide additional configuration to the handlers,
        -- see mason-nvim-dap README for more information
        handlers = {
          function(config)
            -- all sources with no handler get passed here

            -- Keep original functionality
            require("mason-nvim-dap").default_setup(config)
          end,
          php = function(config)
            config.configurations = {
              {
                type = "php",
                request = "launch",
                name = "Listen for Xdebug",
                port = 9003,
                pathMappings = {
                  -- For some reason xdebug sometimes fails for me, depending on me
                  -- using herd or docker. To get it to work, change the order of the mappings.
                  -- The first mapping should be the one that you are actively using.
                  -- This only started recently, so I don't know what changed.
                  ["${workspaceFolder}"] = "${workspaceFolder}",
                  ["/var/www/html"] = "${workspaceFolder}",
                },
              },
            }
            require("mason-nvim-dap").default_setup(config) -- don't forget this!
          end,
        },
        -- You'll need to check that you have the required things installed
        -- online, please don't ask me how to install them :)
        ensure_installed = {
          -- Update this to ensure that you have the debuggers for the langs you want
          "php",
          "bash",
          "python",
        },
      },
    },

    -- none-ls
    {
      {
        "nvimtools/none-ls.nvim",
        opts = function()
          local nls = require("null-ls")
          return {
            sources = {
              nls.builtins.diagnostics.phpstan.with({
                extra_args = {
                  "--memory-limit=2G",
                },
              }),
            },
          }
        end,
      },

      -- add longer timeout, since formatting blade files gets a little slow
      {
        "neovim/nvim-lspconfig",
        opts = {
          format = { timeout_ms = 3000 },
        },
      },
    },

    -- nvim-cmp coding-codeium
    {
      "nvim-cmp",
      opts = function(_, opts)
        table.insert(opts.sources, 1, {
          name = "codeium",
          group_index = 2,
          priority = 100,
        })
      end,
    },

    -- linter nvim-lint
    {
      "mfussenegger/nvim-lint",
      event = "LazyFile",
      opts = {
        -- Event to trigger linters
        events = { "BufWritePost", "BufReadPost", "InsertLeave" },
        linters_by_ft = {
          -- fish = { "fish" },
          -- python = { "pylint" },
          -- Use the "*" filetype to run linters on all filetypes.
          -- ['*'] = { 'global linter' },
          -- Use the "_" filetype to run linters on filetypes that don't have other linters configured.
          -- ['_'] = { 'fallback linter' },
        },
        -- LazyVim extension to easily override linter options
        -- or add custom linters.
        ---@type table<string,table>
        linters = {
          -- -- Example of using selene only when a selene.toml file is present
          -- selene = {
          --   -- `condition` is another LazyVim extension that allows you to
          --   -- dynamically enable/disable linters based on the context.
          --   condition = function(ctx)
          --     return vim.fs.find({ "selene.toml" }, { path = ctx.filename, upward = true })[1]
          --   end,
          -- },
        },
      },
    },

    -- setup tailwind
    {
      {
        "neovim/nvim-lspconfig",
        opts = {
          servers = {
            tailwindcss = {
              settings = {
                tailwindCSS = {
                  experimental = {
                    classRegex = {
                      "@?class\\(([^]*)\\)",
                      "'([^']*)'",
                    },
                  },
                },
              },
            },
          },
        },
      },
      {
        "NvChad/nvim-colorizer.lua",
        opts = {
          user_default_options = {
            tailwind = true,
          },
        },
      },
      {
        "hrsh7th/nvim-cmp",
        dependencies = {
          { "roobert/tailwindcss-colorizer-cmp.nvim", config = true },
        },
        opts = function(_, opts)
          -- original LazyVim kind icon formatter
          local format_kinds = opts.formatting.format
          opts.formatting.format = function(entry, item)
            format_kinds(entry, item) -- add icons
            return require("tailwindcss-colorizer-cmp").formatter(entry, item)
          end
        end,
      },
    },
  }
-- disable plugins
else
  return {
    -- add gruvbox
    { "ellisonleao/gruvbox.nvim" },

    -- Configure LazyVim to load gruvbox
    {
      "LazyVim/LazyVim",
      opts = {
        colorscheme = "gruvbox",
      },
    },

    -- change trouble config
    {
      "folke/trouble.nvim",
      -- opts will be merged with the parent spec
      opts = { use_diagnostic_signs = true },
    },

    -- disable trouble
    { "folke/trouble.nvim", enabled = false },

    -- override nvim-cmp and add cmp-emoji
    {
      "hrsh7th/nvim-cmp",
      dependencies = { "hrsh7th/cmp-emoji" },
      ---@param opts cmp.ConfigSchema
      opts = function(_, opts)
        table.insert(opts.sources, { name = "emoji" })
      end,
    },

    -- change some telescope options and a keymap to browse plugin files
    {
      "nvim-telescope/telescope.nvim",
      keys = {
      -- add a keymap to browse plugin files
      -- stylua: ignore
      {
        "<leader>fp",
        function() require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root }) end,
        desc = "Find Plugin File",
      },
      },
      -- change some options
      opts = {
        defaults = {
          layout_strategy = "horizontal",
          layout_config = { prompt_position = "top" },
          sorting_strategy = "ascending",
          winblend = 0,
        },
      },
    },

    -- the opts function can also be used to change the default opts:
    {
      "nvim-lualine/lualine.nvim",
      event = "VeryLazy",
      opts = function(_, opts)
        table.insert(opts.sections.lualine_x, "😄")
      end,
    },

    -- or you can return new options to override all the defaults
    {
      "nvim-lualine/lualine.nvim",
      event = "VeryLazy",
      opts = function()
        return {
          --[[add your custom lualine config here]]
        }
      end,
    },

    -- use mini.starter instead of alpha
    { import = "lazyvim.plugins.extras.ui.mini-starter" },
  }
end
