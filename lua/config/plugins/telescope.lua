local function getConfig()
	local action_state = require("telescope.actions.state")

	local function save_colorscheme(prompt_bufnr)
		local entry = action_state.get_selected_entry(prompt_bufnr)
		local colorscheme = entry.value

		-- Define the file path
		local filepath = vim.fn.stdpath("config") .. "/lua/config/configs.lua"

		-- Synchronous file write
		local file, err = io.open(filepath, "w")
		if not file then
			vim.notify("Failed to open file: " .. err, vim.log.levels.ERROR)
			return
		end

		-- Write the colorscheme to the file
		local content = "vim.cmd([[colorscheme " .. colorscheme .. "]])\n"
		local ok, write_err = pcall(file.write, file, content)
		file:close()

		if not ok then
			vim.notify("Failed to write to file: " .. write_err, vim.log.levels.ERROR)
		else
			vim.notify("Colorscheme saved: " .. colorscheme, vim.log.levels.INFO)
		end
	end

	return {
		save_colorscheme = save_colorscheme,
	}
end

return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.5",

	dependencies = {
		"nvim-lua/plenary.nvim",
	},

	config = function()
		require("telescope").setup({})
		local builtin = require("telescope.builtin")
		local telescope_actions = require("telescope.actions")
		local actions = getConfig()

		vim.keymap.set("n", "<leader>pf", builtin.find_files, {})
		vim.keymap.set("n", "<C-p>", builtin.git_files, {})
		vim.keymap.set("n", "<leader>pws", function()
			local word = vim.fn.expand("<cword>")
			builtin.grep_string({ search = word })
		end)
		vim.keymap.set("n", "<leader>pWs", function()
			local word = vim.fn.expand("<cWORD>")
			builtin.grep_string({ search = word })
		end)
		vim.keymap.set("n", "<leader>ps", function()
			builtin.grep_string({ search = vim.fn.input("Grep > ") })
		end)
		vim.keymap.set("n", "<leader>vh", builtin.help_tags, {})

		vim.keymap.set("n", "<leader>pc", function()
			builtin.colorscheme({
				attach_mappings = function(prompt_bufnr, map)
					-- Replace default action to apply and save the colorscheme
					telescope_actions.select_default:replace(function()
						local entry = require("telescope.actions.state").get_selected_entry()
						if not entry then
							vim.notify("No colorscheme selected", vim.log.levels.WARN)
							return
						end
						vim.cmd("colorscheme " .. entry.value) -- Apply the colorscheme
						actions.save_colorscheme(prompt_bufnr) -- Save the colorscheme

						telescope_actions.close(prompt_bufnr)
					end)

					return true
				end,
			})
		end, { desc = "Preview and apply colorscheme" })
	end,
}
