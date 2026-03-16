return {
	"christoomey/vim-tmux-navigator",
	lazy = false,
	init = function()
		vim.g.tmux_navigator_no_mappings = 1 -- disable default mappings
	end,
	keys = {
		{ "<M-h>", "<cmd> TmuxNavigateLeft<CR>" },
		{ "<M-l>", "<cmd> TmuxNavigateRight<CR>" },
		{ "<M-j>", "<cmd> TmuxNavigateDown<CR>" },
		{ "<M-k>", "<cmd> TmuxNavigateUp<CR>" },
	},
}
