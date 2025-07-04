return {
  {
    "rust-lang/rust.vim",
    ft = "rust",
    config = function()
      vim.g.rustfmt_autosave = 1
    end,
  },
  {
    "mrcjkb/rustaceanvim",
    version = "^6", -- Recommended
    lazy = false, -- This plugin is already lazy
  },
}
