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
    "epwalsh/obsidian.nvim",
    version = "*", -- recommended, use latest release instead of latest commit
    lazy = false,
    ft = "markdown",
    -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
    -- event = {
    --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
    --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
    --   -- refer to `:h file-pattern` for more examples
    --   "BufReadPre path/to/my-vault/*.md",
    --   "BufNewFile path/to/my-vault/*.md",
    -- },
    dependencies = {
      -- Required.
      "nvim-lua/plenary.nvim",

      -- see below for full list of optional dependencies 👇
    },
    opts = {
      workspaces = {
        {
          name = "personal",
          path = "~/vaults/personal",
        },
        {
          name = "work",
          path = "~/vaults/work",
        },
      },

      mappings = {
        ["gf"] = {
          action = function()
            return require("obsidian").util.gf_passthrough()
          end,
          opts = { noremap = false, expr = true, buffer = true },
        },
      }

      -- see below for full list of options 👇
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
    'romgrk/fzy-lua-native',  -- Ensure lua_fzy is included
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
        "markdown", "python", "rust", "sql",
        "tsx", "typescript", "vim", "yaml"
      },
    },
  },
}
