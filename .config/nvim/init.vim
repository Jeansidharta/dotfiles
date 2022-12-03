source ~/.config/nvim/settings.vim
" Trigger a highlight in the appropriate direction when pressing these keys:
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
source ~/.config/nvim/packer.lua

let mapleader=" "

" colorscheme codedark
colorscheme tokyodark

nnoremap <leader>, :source ~/.config/nvim/init.vim<CR>
nnoremap <leader>. :vsplit ~/.config/nvim/init.vim<CR>
nnoremap <C-H> :nohlsearch<CR>

highlight UnwantedSpaces ctermbg=red
match UnwantedSpaces /\s\+$/

source ~/.config/nvim/colorizer.lua
source ~/.config/nvim/telescope.lua
source ~/.config/nvim/treesitter.lua
source ~/.config/nvim/notify.lua
source ~/.config/nvim/lsp.lua
source ~/.config/nvim/lualine.lua
source ~/.config/nvim/gitsigns.lua
source ~/.config/nvim/dressing.lua
source ~/.config/nvim/hop.lua
source ~/.config/nvim/overseer.lua
source ~/.config/nvim/fidget.lua
source ~/.config/nvim/nvim-surround.lua
source ~/.config/nvim/neoclip.lua
" source ~/.config/nvim/shade.lua
source ~/.config/nvim/range-highlight.lua
source ~/.config/nvim/fterm.lua
source ~/.config/nvim/git-conflict.lua
source ~/.config/nvim/neoscroll.lua
source ~/.config/nvim/marks.lua
source ~/.config/nvim/comment.lua
source ~/.config/nvim/formatter.lua
source ~/.config/nvim/rest.lua
source ~/.config/nvim/duck.lua
source ~/.config/nvim/nvim-cmp.lua
source ~/.config/nvim/hover.lua
source ~/.config/nvim/indent_blankline.lua
source ~/.config/nvim/illuminate.lua
source ~/.config/nvim/sniprun.lua

