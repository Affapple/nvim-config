return {
	{
		"rcasia/neotest-java",
		ft = "java",
		dependencies = {
			"mfussenegger/nvim-jdtls",
			"mfussenegger/nvim-dap", -- for the debugger
			"rcarriga/nvim-dap-ui", -- recommended
			"theHamsta/nvim-dap-virtual-text", -- recommended
		},
	},
	{
		"nvim-neotest/neotest",
		dependencies = {
			"nvim-neotest/nvim-nio",
			"nvim-lua/plenary.nvim",
			"antoinemadec/FixCursorHold.nvim",
			"nvim-treesitter/nvim-treesitter",
			"nvim-neotest/neotest-python",
		},
		opts = {
			adapters = {
				["neotest-java"] = {
					-- config here
				},
			},
		},
		config = function()
			local neotest = require("neotest")
			neotest.setup({
				adapters = {
					require("neotest-python")({
						-- Extra arguments for nvim-dap configuration
						-- See https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for values
						dap = { justMyCode = false },
						-- Command line arguments for runner
						-- Can also be a function to return dynamic values
						args = { "--log-level", "DEBUG" },
						-- Runner to use. Will use pytest if available by default.
						-- Can be a function to return dynamic value.
						runner = "pytest",
						-- Custom python path for the runner.
						-- Can be a string or a list of strings.
						-- Can also be a function to return dynamic value.
						-- If not provided, the path will be inferred by checking for
						-- virtual envs in the local directory and for Pipenev/Poetry configs
						python = ".venv/bin/python",
						-- !!EXPERIMENTAL!! Enable shelling out to `pytest` to discover test
						-- instances for files containing a parametrize mark (default: false)
						pytest_discover_instances = true,
					}),
				},
			})

			vim.keymap.set("n", "<leader>tc", function()
				neotest.run.run()
			end)
		end,
	},
	{
		"karloskar/poetry-nvim",
		config = function()
			require("poetry-nvim").setup()
		end,
	},
}
