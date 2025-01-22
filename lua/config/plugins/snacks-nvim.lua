return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,

	opts = {
		bigfile = { enabled = true },
		dashboard = { enabled = true },
		indent = { enabled = true },
		input = { enabled = true },
		notifier = { enabled = false },
		quickfile = { enabled = true },
		scroll = { enabled = true },
		statuscolumn = { enabled = true },
		words = { enabled = true },
		dim = { enabled = true },
		lazygit = { enable = true },

		scope = {
			enabled = true,
			keys = {
				jump = {
					["<leader>jt"] = {
						min_size = 1, -- allow single line scopes
						bottom = false,
						cursor = false,
						edge = true,
						treesitter = { blocks = { enabled = false } },
						desc = "jump to top edge of scope",
					},
					["<leader>jb"] = {
						min_size = 1, -- allow single line scopes
						bottom = true,
						cursor = false,
						edge = true,
						treesitter = { blocks = { enabled = false } },
						desc = "jump to bottom edge of scope",
					},
				},
			},
		},
	},

	keys = {
		{
			"<leader>ot",
			function()
				Snacks.terminal()
			end,
			desc = "Toggle Terminal",
		},
		{
			"<leader>gg",
			function()
				Snacks.lazygit()
			end,
			desc = "Lazygit",
		},
	},
}
