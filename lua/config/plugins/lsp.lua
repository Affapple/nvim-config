return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    "L3MON4D3/LuaSnip",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/nvim-cmp",
    "rafamadriz/friendly-snippets",
    "saghen/blink.cmp",
    -- "j-hui/fidget.nvim",
  },

  config = function()
    local capabilities = require("blink.cmp").get_lsp_capabilities()

    require("mason").setup({
      ensure_installed = {
        "ruff",
        "mypy",
        "pyright",
        "typescript-language-server",
        "eslint-lsp",
        "prettierd",
        "html-lsp",
        "css-lsp",
        "stylua",
        "luacheck",
      },
    })

    ---------------- LSP CONFIG

    require("mason-lspconfig").setup({
      ensure_installed = {
        "lua_ls",
        "rust_analyzer",
        "pyright",
        "jdtls",
        "clangd",
      },
      handlers = {
        function(server_name) -- default handler (optional)
          if server_name ~= "jdtls" and server_name ~= "ruff" then
            require("lspconfig")[server_name].setup({
              capabilities = capabilities,
            })
          end
        end,

        zls = function()
          local lspconfig = require("lspconfig")
          lspconfig.zls.setup({
            root_dir = lspconfig.util.root_pattern(".git", "build.zig", "zls.json"),
            settings = {
              zls = {
                enable_inlay_hints = true,
                enable_snippets = true,
                warn_style = true,
              },
            },
          })
          vim.g.zig_fmt_parse_errors = 0
          vim.g.zig_fmt_autosave = 0
        end,

        ["lua_ls"] = function()
          local lspconfig = require("lspconfig")
          lspconfig.lua_ls.setup({
            capabilities = capabilities,
            settings = {
              Lua = {
                runtime = { version = "Lua 5.1" },
                diagnostics = {
                  globals = { "bit", "vim", "it", "describe", "before_each", "after_each" },
                },
              },
            },
          })
        end,

        ["pyright"] = function()
          local lspconfig = require("lspconfig")
          lspconfig.pyright.setup({
            capabilities = capabilities,

            on_new_config = function(new_config, root_dir)
              local venv_path = root_dir .. "/.venv/bin/python" -- Assuming venv is in the project's root directory
              if vim.fn.filereadable(venv_path) == 1 then
                new_config.settings = new_config.settings or {}
                new_config.settings.python = new_config.settings.python or {}
                new_config.settings.python.pythonPath = venv_path
              end
            end,

            settings = {
              pyright = {
                autoImportCompletion = true,
              },
              python = {
                analysis = {
                  autoSearchPaths = true,
                  typeCheckingMode = "standard", -- Options: off, basic, strict
                  useLibraryCodeForTypes = true,
                  diagnosticMode = "workspace", -- Options: openFilesOnly, workspace
                },
              },
            },
          })
        end,

        ["lemminx"] = function()
          local lspconfig = require("lspconfig")
          lspconfig.lemminx.setup({
            capabilities = capabilities,
            settings = {},
          })
        end,
      },
    })
    ---------------- END LSP CONFIG

    require("mason-tool-installer").setup({
      ensure_installed = {
        "java-debug-adapter",
        "java-test",
      },
    })
    vim.api.nvim_command("MasonToolsInstall")

    vim.diagnostic.config({
      -- update_in_insert = true,
      float = {
        focusable = false,
        style = "minimal",
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
      },
    })

    require("nvim-autopairs").setup({
      map_cr = true,    -- Map <CR> in insert mode
      map_complete = true, -- Auto-insert `(` after selecting a function or method item
      auto_select = true, -- Automatically select the first item
    })

    require("luasnip.loaders.from_vscode").lazy_load()
  end,
}
