let g:python3_host_prog = '/usr/bin/python3'

set showcmd
let mapleader = "\<SPACE>"
let maplocalleader = ","

set sessionoptions-=options
runtime bundle/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect()
syntax enable
colorscheme dim
filetype plugin indent on

set mouse=a
set inccommand=split
set cc=81
set number relativenumber

highlight ColorColumn ctermbg=darkgrey
highlight ExtraWhitespace ctermbg=red



augroup nviminit
	au!
	au ColorScheme *  highlight ExtraWhitespace ctermbg=red
	au BufWritePost $MYVIMRC source %
	au InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
	au InsertLeave * match ExtraWhitespace /\s\+$/
	au BufEnter * call ncm2#enable_for_buffer()
	au TextChangedI * call ncm2#auto_trigger()
augroup END

set history=1000
set title
set scrolloff=5
set listchars=tab:>-,trail:.,eol:$
nmap <silent> <leader>s :set nolist!<CR>

command! W w !sudo tee % > /dev/null

" --column: Show column number
" --line-number: Show line number
" --no-heading: Do not show file headings in results
" --fixed-strings: Search term as a literal string
" --ignore-case: Case insensitive search
" --no-ignore: Do not respect .gitignore, etc...
" --hidden: Search hidden files and folders
" --follow: Follow symlinks
" --glob: Additional conditions for search (in this case ignore everything in the .git/ folder)
" --color: Search color options
command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>), 1, <bang>0)
set grepprg=rg\ --vimgrep

imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file)
imap <c-x><c-l> <plug>(fzf-complete-line)


set completeopt=menuone,noinsert,noselect,preview
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
"inoremap <silent> <expr> <CR> ncm2_ultisnips#expand_or("\<CR>", 'n')


let g:UltiSnipsExpandTrigger = "<C-leader>"
let g:UltiSnipsJumpForwardTrigger	= "<c-l>"
let g:UltiSnipsJumpBackwardTrigger	= "<c-h>"
let g:UltiSnipsRemoveSelectModeMappings = 0
" optional
inoremap <silent> <c-u> <c-r>=cm#sources#ultisnips#trigger_or_popup("\<Plug>(ultisnips_expand)")<cr>


nnoremap <c-j> o<esc>k
nnoremap <c-k> O<esc>j
nnoremap <space> <nop>
"nnoremap <silent> <leader><leader> 80\|?\s
nmap <silent> <leader><leader> <plug>(my-to-last-white-space)<cr>

nnoremap <f9> mzggg?G`z
tnoremap <localleader>. <C-\><C-N>
nnoremap <leader>ve :vsplit $MYVIMRC<cr>
nnoremap <leader>vs :source $MYVIMRC<cr>
nnoremap <leader>fs :w<cr>

let g:vimtex_view_method = "mupdf"
let g:vimtex_compiler_engine = "lualatex"
let g:vimtex_compiler_progname = 'nvr'


let g:rainbow_active = 1
let g:rainbow_conf = {
\	'ctermfgs': ['red', 'green', 'yellow', 'blue', 'magenta', 'cyan']
\}

nmap <silent> <leader>e <plug>(my-toggle-emoji-conversion)<cr>
