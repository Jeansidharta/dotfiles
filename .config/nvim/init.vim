	source ~/.config/nvim/settings.vim
" Trigger a highlight in the appropriate direction when pressing these keys:
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
source ~/.config/nvim/packer.lua

let mapleader=" "

colorscheme codedark

nnoremap <leader>, :source ~/.config/nvim/init.vim<CR>
nnoremap <leader>. :vsplit ~/.config/nvim/init.vim<CR>
nnoremap <C-H> :nohlsearch<CR>

highlight UnwantedSpaces ctermbg=red
match UnwantedSpaces /\s\+$/

source ~/.config/nvim/coq.lua
source ~/.config/nvim/colorizer.lua
source ~/.config/nvim/telescope.lua
source ~/.config/nvim/neoformat.lua
source ~/.config/nvim/treesitter.lua
source ~/.config/nvim/notify.lua
source ~/.config/nvim/lsp.lua
source ~/.config/nvim/lsp_lines.lua
source ~/.config/nvim/lualine.lua
source ~/.config/nvim/gitsigns.lua
source ~/.config/nvim/dressing.lua
source ~/.config/nvim/easy-motions.vim
source ~/.config/nvim/quickscope.vim
source ~/.config/nvim/overseer.lua

