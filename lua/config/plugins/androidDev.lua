return {
	{
		"ariedov/android-nvim",
		config = function()
			-- OPTIONAL: specify android sdk directory
			-- vim.g.android_sdk = "~/Library/Android/sdk"
			require("android-nvim").setup()
		end,
	},

	{
		"AlexandrosAlexiou/kotlin.nvim",
		ft = { "kotlin" },
		dependencies = {
			"mason.nvim",
			"mason-lspconfig.nvim",
			{
				"folke/trouble.nvim",
				cmd = "Trouble",
				opts = {},
			},
		},
		config = function()
			require("kotlin").setup({
				root_markers = {
					"gradlew",
					".git",
					"mvnw",
					"settings.gradle",
				},

				jdk_for_symbol_resolution = nil, -- Auto-detect from project

				-- Uses bundled JRE from Mason (zero-dependency)
				jre_path = nil,

				jvm_args = {
					"-Xmx4g",
				},

				-- All inlay hints enabled by default
				inlay_hints = {
					enabled = true,
					parameters = true,
					parameters_compiled = true,
					parameters_excluded = false,
					types_property = true,
					types_variable = true,
					function_return = true,
					function_parameter = true,
					lambda_return = true,
					lambda_receivers_parameters = true,
					value_ranges = true,
					kotlin_time = true,
				},
			})

			-- 10 keymaps with <leader>lk prefix
			vim.keymap.set("n", "<leader>lka", ":KotlinCodeActions<CR>", { desc = "Kotlin code actions" })
			vim.keymap.set("n", "<leader>lkq", ":KotlinQuickFix<CR>", { desc = "Kotlin quick fix" })
			vim.keymap.set("n", "<leader>lko", ":KotlinOrganizeImports<CR>", { desc = "Organize Kotlin imports" })
			vim.keymap.set("n", "<leader>lkf", ":KotlinFormat<CR>", { desc = "Format Kotlin buffer (LSP)" })
			vim.keymap.set("n", "<leader>lks", ":KotlinSymbols<CR>", { desc = "Show Kotlin document symbols" })
			vim.keymap.set("n", "<leader>lkw", ":KotlinWorkspaceSymbols<CR>", { desc = "Search workspace symbols" })
			vim.keymap.set("n", "<leader>lkr", ":KotlinReferences<CR>", { desc = "Find Kotlin references" })
			vim.keymap.set("n", "<leader>lkn", ":KotlinRename<CR>", { desc = "Rename Kotlin symbol" })
			vim.keymap.set("n", "<leader>lkh", ":KotlinInlayHintsToggle<CR>", { desc = "Toggle Kotlin inlay hints" })
			vim.keymap.set("n", "<leader>lkc", ":KotlinCleanWorkspace<CR>", { desc = "Clean Kotlin workspace" })
		end,
	},
}
