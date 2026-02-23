return {
	"github/copilot.vim",
	config = function()
		vim.g.copilot_no_tab_map = true
		vim.api.nvim_set_keymap("i", "<S-CR>", 'copilot#Accept("<CR>")', { silent = true, expr = true })
		-- 	vim.g.copilot_settings = {
		-- 		selectedCompletionModel = "gemini-2.5-pro",
		--
		-- 	}
	end,
}
