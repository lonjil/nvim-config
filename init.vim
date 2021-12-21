let g:python3_host_prog = '/usr/bin/python3'

set showcmd
let mapleader = "\<SPACE>"
let maplocalleader = ","

set sessionoptions-=options

let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif


" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin(stdpath('data') . '/plugged')

Plug 'https://github.com/autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
Plug 'https://github.com/Shougo/denite.nvim'
Plug 'https://github.com/ncm2/float-preview.nvim'
Plug 'https://github.com/junegunn/fzf.vim'
Plug 'https://github.com/vim-scripts/loremipsum'
Plug 'https://github.com/roxma/nvim-yarp'
Plug 'https://github.com/ncm2/ncm2'
Plug 'https://github.com/ncm2/ncm2-bufword'
Plug 'https://github.com/ncm2/ncm2-github'
Plug 'https://github.com/ncm2/ncm2-neoinclude'
Plug 'https://github.com/ncm2/ncm2-path'
Plug 'https://github.com/ncm2/ncm2-pyclang'
Plug 'https://github.com/ncm2/ncm2-racer'
Plug 'https://github.com/ncm2/ncm2-ultisnips'
Plug 'https://github.com/ncm2/ncm2-vim'
Plug 'https://github.com/Shougo/neco-vim'
Plug 'https://github.com/Shougo/neoinclude.vim'
Plug 'https://github.com/kovisoft/paredit'
Plug 'https://github.com/luochen1990/rainbow'
Plug 'https://github.com/rust-lang/rust.vim'
Plug 'https://github.com/SirVer/ultisnips'
Plug 'https://github.com/mbbill/undotree'
Plug 'https://github.com/tpope/vim-commentary'
Plug 'https://github.com/jeffkreeftmeijer/vim-dim'
Plug 'https://github.com/junegunn/vim-emoji'
Plug 'https://github.com/tpope/vim-fugitive'
Plug 'https://github.com/airblade/vim-gitgutter'
Plug 'https://github.com/tikhomirov/vim-glsl'
Plug 'https://github.com/tpope/vim-obsession'
Plug 'https://github.com/racer-rust/vim-racer'
Plug 'https://github.com/honza/vim-snippets'
Plug 'https://github.com/tpope/vim-surround'
Plug 'https://github.com/lervag/vimtex'
Plug 'https://github.com/ziglang/zig.vim'

call plug#end()

syntax enable
colorscheme dim
filetype plugin indent on

set mouse=a
set inccommand=split
set cc=81
set number relativenumber
set hidden

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

let g:vimtex_view_method = "zathura"
let g:vimtex_compiler_engine = "lualatex"
" let g:vimtex_compiler_progname = 'nvr'


let g:rainbow_active = 1
let g:rainbow_conf = {
\	'ctermfgs': ['red', 'green', 'yellow', 'blue', 'magenta', 'cyan']
\}

nmap <silent> <leader>e <plug>(my-toggle-emoji-conversion)<cr>

let g:LanguageClient_serverCommands = {
    \ 'zig': ['zls']
    \ }

" note that if you are using Plug mapping you should not use `noremap` mappings.
nmap <F5> <Plug>(lcn-menu)
" Or map each action separately
nmap <silent>K <Plug>(lcn-hover)
nmap <silent> gd <Plug>(lcn-definition)
nmap <silent> <F2> <Plug>(lcn-rename)

inoremap <nowait> < <
