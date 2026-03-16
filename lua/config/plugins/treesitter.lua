return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	lazy = false,
	build = ":TSUpdate",
	opts = {
		-- Explicitly tell Treesitter to use your specific directory
		parser_install_dir = "/home/jgaspar/.local/share/nvim/site",
		ensure_installed = {
			"vimdoc",
			"javascript",
			"typescript",
			"tsx",
			"c",
			"cpp",
			"lua",
			"rust",
			"jsdoc",
			"bash",
			"java",
			"python",
			"html",
			"xml",
			"json",
			"yaml",
			"diff",
			"bash",
			"css",
		},
		sync_install = false,
		auto_install = true,
		indent = {
			enable = true,
		},
		highlight = {
			enable = true,
			additional_vim_regex_highlighting = { "markdown" },
		},
	},
	config = function(_, opts)
		vim.opt.runtimepath:append("/home/jgaspar/.local/share/nvim/site/")
		vim.cmd.syntax("off")

		vim.api.nvim_create_autocmd("BufReadPost", {
			pattern = "*",
			callback = function()
				-- can start a specific treesitter on a specific buffer also
				-- vim.treesitter.start(0, "c")
				vim.treesitter.start()
			end,
			once = true,
		})

		if opts.ensure_installed and #opts.ensure_installed > 0 then
			require("nvim-treesitter").install(opts.ensure_installed)
			-- register and start parsers for filetypes
			for _, parser in ipairs(opts.ensure_installed) do
				local filetypes = parser -- In this case, parser is the filetype/language name
				vim.treesitter.language.register(parser, filetypes)

				vim.api.nvim_create_autocmd({ "FileType" }, {
					pattern = filetypes,
					callback = function(event)
						vim.treesitter.start(event.buf, parser)
					end,
				})
			end
		end
		vim.api.nvim_create_autocmd({ "BufRead" }, {
			callback = function(event)
				local bufnr = event.buf
				local filetype = vim.api.nvim_get_option_value("filetype", { buf = bufnr })

				-- Skip if no filetype
				if filetype == "" then
					return
				end

				-- Check if this filetype is already handled by explicit opts.ensure_installed config
				for _, filetypes in pairs(opts.ensure_installed) do
					local ft_table = type(filetypes) == "table" and filetypes or { filetypes }
					if vim.tbl_contains(ft_table, filetype) then
						return -- Already handled above
					end
				end

				-- Get parser name based on filetype
				local parser_name = vim.treesitter.language.get_lang(filetype) -- might return filetype (not helpful)
				if not parser_name then
					return
				end
				-- Try to get existing parser (helpful check if filetype was returned above)
				local parser_configs = require("nvim-treesitter.parsers")
				if not parser_configs[parser_name] then
					return -- Parser not available, skip silently
				end

				local parser_installed = pcall(vim.treesitter.get_parser, bufnr, parser_name)

				if not parser_installed then
					-- If not installed, install parser synchronously
					require("nvim-treesitter").install({ parser_name }):wait(30000)
				end

				-- let's check again
				parser_installed = pcall(vim.treesitter.get_parser, bufnr, parser_name)

				if parser_installed then
					-- Start treesitter for this buffer
					vim.treesitter.start(bufnr, parser_name)
				end
			end,
		})

		require("nvim-treesitter.config").setup(opts)
	end,
}
