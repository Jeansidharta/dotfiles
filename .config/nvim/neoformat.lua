local autoFmtGroup = vim.api.nvim_create_augroup("AutoFmt", { clear = true })

local function file_exists(file)
  local f = io.open(file, "rb")
  if f then f:close() end
  return f ~= nil
end

-- if file_exists('.prettierrc') then
	vim.api.nvim_create_autocmd("BufWritePre", {
		command = "Neoformat",
		group = autoFmtGroup,
	})
-- end
