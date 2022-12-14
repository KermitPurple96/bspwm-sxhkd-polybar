set number
set cursorline
set termguicolors
hi CursorLine cterm=NONE ctermbg=Grey

set foldcolumn=2
set showmatch
syntax enable
syntax on
set splitright
set expandtab
set softtabstop=4

set autoindent

set shiftwidth=2
set tabstop=4

"Enable mouse click for nvim
set mouse=a
"Fix cursor replacement after closing nvim
set guicursor=
"Shift + Tab does inverse tab
inoremap <S-Tab> <C-d>

"See invisible characters
set list listchars=tab:>\ ,trail:+,eol:$

"wrap to next line when end of line is reached
set whichwrap+=<,>,[,]
