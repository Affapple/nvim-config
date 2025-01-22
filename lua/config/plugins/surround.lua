return {
  "tpope/vim-surround",
  config = function()
    vim.keymap.set("x", '"', 'S"', { remap = true })
    vim.keymap.set("x", "(", "S)", { remap = true })
    vim.keymap.set("x", "[", "S]", { remap = true })
    vim.keymap.set("x", "{", "S}", { remap = true })
  end,
}
