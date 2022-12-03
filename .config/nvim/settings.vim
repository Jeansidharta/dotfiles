" ---------- Ruler options ----------
set number
set ruler
set relativenumber

" ---------- Encoding options ----------
set encoding=utf-8 nobomb
set fileencodings=utf-8

" ---------- Search options ----------
set hlsearch
set wrapscan 
set noincsearch
set ignorecase
set smartcase
set infercase

" ---------- Render tab characters ----------
" Unnecessary with indent_blankline plugin
" set list
" set listchars=tab:>\ 

" ---------- Tab size config ----------
set tabstop=4
set shiftwidth=4

" ---------- Line Column line highlighting ----------
set cursorline
set cursorcolumn
highlight CursorLine ctermbg=Yellow cterm=bold guibg=#202020
highlight CursorColumn ctermbg=Yellow cterm=bold guibg=#202020

" ---------- Timeout ----------
set notimeout
set nottimeout

" ---------- Fix splitting ----------
set splitbelow splitright
set signcolumn=yes

" ---------- Misc ----------
" This options makes so inotifywait works with files being edited by vim
set backupcopy=yes
" Makes so the matching parenthesis and brackets don't jump when placed
set matchtime=0
set showmatch
" Set true terminal colors
set termguicolors
" Prevent windows from changing sizes when a new window is created
set noequalalways
" Makes so some plugins work better
set updatetime=300

" For working with the Treesitter plugin
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()

lua <<EOF
-- vim.api.nvim_set_hl(0, "FoldColumn", { fg = "#FF0000" })
EOF

