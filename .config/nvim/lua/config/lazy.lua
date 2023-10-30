-- Bootstrap lazy.nvim if it's not located.
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"--single-branch",
		"https://github.com/folke/lazy.nvim.git",
		lazypath,
	})
end
vim.opt.runtimepath:prepend(lazypath)

return require("lazy").setup("config.plugins", {

	dev = {
		path = "~/projects/personal/neovim-plugins",
		fallback = true,
	},
	defaults = {
		lazy = true,
		change_detection = {
			notify = false,
		},
	},
})
