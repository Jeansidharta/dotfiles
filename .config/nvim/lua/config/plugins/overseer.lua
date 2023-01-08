return {
	"stevearc/overseer.nvim",
	config = true,
	keys = {
		{ "<leader>or", ":OverseerRun<Return>", noremap = true, desc = "Run overseer command" },
		{ "<leader>ot", ":OverseerToggle<Return>", noremap = true, desc = "Open overseer panel" },
	},
}
