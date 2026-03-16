return {
	"lervag/vimtex",
	lazy = false, -- we don't want to lazy load VimTeX
	-- tag = "v2.15", -- uncomment to pin to a specific release
	init = function()
		-- VimTeX configuration goes here, e.g.
		vim.g.vimtex_view_method = "zathura"

		vim.g.vimtex_compiler_method = "latexmk"

		vim.g.vimtex_compiler_latexmk = {
			out_dir = "build",
			options = { "-pdf", "-interaction=nonstopmode", "-synctex=1" },
		}

		vim.g.vimtex_doc_enabled = 0
		vim.g.vimtex_complete_enabled = 0
		vim.g.vimtex_syntax_enabled = 0
		vim.g.vimtex_imaps_enabled = 0

		vim.g.vimtex_view_forward_search_on_start = 0

		vim.keymap.set("n", "<localleader>ll", "<cmd>VimtexCompile<return>")
	end,
}
