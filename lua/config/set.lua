vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "html", "typescript", "tsx", "jsx", "typescriptreact", "ts", "js", "css", "lua", "xml" },
	command = "setlocal shiftwidth=2 tabstop=2",
})

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.colorcolumn = "80"

vim.opt.cmdheight = 0

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "md", "txt", "markdown" },
	callback = function()
		vim.opt_local.wrap = true
		vim.api.nvim_buf_set_keymap(0, "n", "j", "gj", { noremap = true, silent = true })
		vim.api.nvim_buf_set_keymap(0, "n", "k", "gk", { noremap = true, silent = true })
	end,
})
