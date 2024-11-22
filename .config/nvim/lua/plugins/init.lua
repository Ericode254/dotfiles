return {
  {
    "stevearc/conform.nvim",
    event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    lazy = false,
    version = false, -- set this if you want to always pull the latest change
    opts = {
      -- add any opts here
      provider = "gemini",
      gemini = {
        -- add any gemini opts here
        api_key_name = os.getenv("GEMINI_API_KEY"),
        -- endpoint = "https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash-latest:generateContent",
      }
    },
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    build = "make",
    -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      --- The below dependencies are optional,
      "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
      "zbirenbaum/copilot.lua",    -- for providers='copilot'
      {
        -- support for image pasting
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          -- recommended settings
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            -- required for Windows users
            use_absolute_path = true,
          },
        },
      },
      {
        -- Make sure to set this up properly if you have lazy=true
        'MeanderingProgrammer/render-markdown.nvim',
        opts = {
          file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
      },
    },
  },
  {
    'gen740/SmoothCursor.nvim',
    config = function()
      require('configs.smoothcursor')
    end
  },
  {
    "epwalsh/obsidian.nvim",
    version = "*",
    lazy = false,
    ft = "markdown",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      workspaces = {
        { name = "personal", path = "~/vaults/personal" },
        { name = "work",     path = "~/vaults/work" },
      },
      notes_subdir = "personal/Notes", -- Specify the default subdirectory for new notes
      templates = {
        folder = "~/vaults/Templates", -- Path to your template
        insert_on_new_file = true,     -- Automatically insert template content in new files
      },
    },
  },
  {
    'gelguy/wilder.nvim',
    lazy = false,
    config = function()
      require("configs.wilder")
    end,
  },
  {
    'romgrk/fzy-lua-native', -- Ensure lua_fzy is included
    lazy = false,
  },
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && npm install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  },
  {
    'MeanderingProgrammer/render-markdown.nvim',
    config = function()
      -- Optional: Add custom configurations here
      require("render-markdown").setup({
        -- Example options; adjust according to the plugin’s docs
        preview = true,
        live_update = true,
      })
    end,
    ft = { 'markdown' } -- Load only for markdown files
  },

  {
    'Exafunction/codeium.vim',
    event = 'BufEnter',
    config = function()
      -- Change '<C-g>' here to any keycode you like.
      vim.keymap.set('i', '<C-g>', function()
        return vim.fn['codeium#Accept']()
      end, { expr = true })
      vim.keymap.set('i', '<C-,>', function()
        return vim.fn['codeium#CycleCompletions'](5)
      end, { expr = true })
    end
  },

  {

    "nvim-neotest/neotest",

    dependencies = { "nvim-neotest/nvim-nio",
      "nvim-neotest/neotest-python",
      "nvim-neotest/neotest-jest",
      "alfaix/neotest-gtest"
    },

    opts = {

      -- Can be a list of adapters like what neotest expects,

      -- or a list of adapter names,

      -- or a table of adapter names, mapped to adapter configs.

      -- The adapter will then be automatically loaded with the config.

      adapters = {
        ["neotest-python"] = {
          dap_enabled = true,
          runner = "pytest"
        },
        ["neotest-jest"] = {
          jestCommand = "npm test --",
          jestConfigFile = "jest.config.js",
          env = { CI = true },
        },
        ["neotest-gtest"] = {
          command = "build/tests"
        }
      },

      -- Example for loading neotest-golang with a custom config

      -- adapters = {

      --   ["neotest-golang"] = {

      --     go_test_args = { "-v", "-race", "-count=1", "-timeout=60s" },

      --     dap_go_enabled = true,

      --   },

      -- },

      status = { virtual_text = true },

      output = { open_on_run = true },

      quickfix = {

        open = function()
          if LazyVim.has("trouble.nvim") then
            require("trouble").open({ mode = "quickfix", focus = false })
          else
            vim.cmd("copen")
          end
        end,

      },

    },

    config = function(_, opts)
      local neotest_ns = vim.api.nvim_create_namespace("neotest")

      vim.diagnostic.config({

        virtual_text = {

          format = function(diagnostic)
            -- Replace newline and tab characters with space for more compact diagnostics

            local message = diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")

            return message
          end,

        },

      }, neotest_ns)



      if LazyVim.has("trouble.nvim") then
        opts.consumers = opts.consumers or {}

        -- Refresh and auto close trouble after running tests

        ---@type neotest.Consumer

        opts.consumers.trouble = function(client)
          client.listeners.results = function(adapter_id, results, partial)
            if partial then
              return
            end

            local tree = assert(client:get_position(nil, { adapter = adapter_id }))



            local failed = 0

            for pos_id, result in pairs(results) do
              if result.status == "failed" and tree:get_key(pos_id) then
                failed = failed + 1
              end
            end

            vim.schedule(function()
              local trouble = require("trouble")

              if trouble.is_open() then
                trouble.refresh()

                if failed == 0 then
                  trouble.close()
                end
              end
            end)

            return {}
          end
        end
      end



      if opts.adapters then
        local adapters = {}

        for name, config in pairs(opts.adapters or {}) do
          if type(name) == "number" then
            if type(config) == "string" then
              config = require(config)
            end

            adapters[#adapters + 1] = config
          elseif config ~= false then
            local adapter = require(name)

            if type(config) == "table" and not vim.tbl_isempty(config) then
              local meta = getmetatable(adapter)

              if adapter.setup then
                adapter.setup(config)
              elseif adapter.adapter then
                adapter.adapter(config)

                adapter = adapter.adapter
              elseif meta and meta.__call then
                adapter = adapter(config)
              else
                error("Adapter " .. name .. " does not support setup")
              end
            end

            adapters[#adapters + 1] = adapter
          end
        end

        opts.adapters = adapters
      end



      require("neotest").setup(opts)
    end,

    -- stylua: ignore

    keys = {

      { "<leader>t",  "",                                                                                 desc = "+test" },

      { "<leader>tt", function() require("neotest").run.run(vim.fn.expand("%")) end,                      desc = "Run File" },

      { "<leader>tT", function() require("neotest").run.run(vim.uv.cwd()) end,                            desc = "Run All Test Files" },

      { "<leader>tr", function() require("neotest").run.run() end,                                        desc = "Run Nearest" },

      { "<leader>tl", function() require("neotest").run.run_last() end,                                   desc = "Run Last" },

      { "<leader>ts", function() require("neotest").summary.toggle() end,                                 desc = "Toggle Summary" },

      { "<leader>to", function() require("neotest").output.open({ enter = true, auto_close = true }) end, desc = "Show Output" },

      { "<leader>tO", function() require("neotest").output_panel.toggle() end,                            desc = "Toggle Output Panel" },

      { "<leader>tS", function() require("neotest").run.stop() end,                                       desc = "Stop" },

      { "<leader>tw", function() require("neotest").watch.toggle(vim.fn.expand("%")) end,                 desc = "Toggle Watch" },

    },

  },
  --
  -- {
  --   "folke/noice.nvim",
  --   event = "VeryLazy",
  --   opts = {},
  --   dependencies = {
  --     "MunifTanjim/nui.nvim",
  --     "rcarriga/nvim-notify",
  --   }
  -- },
  --
  {
    "kdheepak/lazygit.nvim",
    lazy = true,
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    keys = {
      { "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" }
    }
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim", "lua", "vimdoc",
        "html", "css", "c", "cpp",
        "csv", "gitattributes", "java",
        "javascript", "json", "lua", "make",
        "markdown", "markdown_inline", "python", "rust", "sql",
        "tsx", "typescript", "vim", "yaml"
      },
    },
  },
}
