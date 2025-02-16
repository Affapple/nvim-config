return {
  "nvimtools/none-ls.nvim",
  dependencies = {
    "nvimtools/none-ls-extras.nvim",
  },

  config = function()
    local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
    local null_ls = require("null-ls")

    null_ls.setup({
      sources = {
        -- Default formatter
        null_ls.builtins.formatting.prettierd.with({
          extra_args = { "--plugin", "prettier-plugin-xml", "--parser", "xml" },
          filetypes = {
            "javascript",
            "typescript",
            "css",
            "scss",
            "less",
            "html",
            "json",
            "yaml",
            "markdown",
            "graphql",
            "vue",
            "svelte",
            "astro",
            "xml",
            "java",
            "python",
            "c",
            "cpp",
            "h",
            "hpp",
            "go",
          },
        }),
        null_ls.builtins.formatting.stylua,

        null_ls.builtins.diagnostics.mypy.with({
          extra_args = function()
            local virtual = os.getenv("VIRTUAL_ENV") or os.getenv("CONDA_PREFIX") or "/usr"
            return { "--python-executable", virtual .. "/bin/python3" }
          end,
        }),
        -- require("none-ls.diagnostics.ruff"),
        require("none-ls.formatting.ruff_format"),
      },

      on_attach = function(client, bufnr)
        -- AutoFormat on save
        if client.supports_method("textDocument/formatting") then
          vim.api.nvim_clear_autocmds({
            group = augroup,
            buffer = bufnr,
          })
          vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format({ bufnr = bufnr })
            end,
          })
        end

        -- Add format command
        vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
          vim.lsp.buf.format({
            bufnr = bufnr,
            filter = function(clnt)
              return clnt.name == "null-ls"
            end,
          })
          print("File formatted")
        end, { desc = "Format current buffer with LSP" })
      end,
    })
  end,
}
