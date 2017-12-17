let g:python3_host_prog = '/usr/bin/python3'

set showcmd
let mapleader = "\<SPACE>"
let maplocalleader = ","

set sessionoptions-=options
runtime bundle/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect()
syntax on
filetype plugin indent on

set mouse=a
set inccommand=split
set cc=80
set number relativenumber

highlight ColorColumn ctermbg=darkgrey
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+\%#\@<!$/

func! ReplaceEmoji()
	let l:col = col('.')
	let l:line = line('.')
	let l:prelen = strlen(getline('.'))
	s/:\([^:]\+\):/\=emoji#for(submatch(1), submatch(0))/ge
	let l:postlen = strlen(getline('.'))
	call cursor(l:line, l:col + l:postlen - l:prelen)
endfunc

augroup nviminit
	au!
	au ColorScheme *
		\ highlight ExtraWhitespace ctermbg=red guibg=red |
		\ highlight MatchParen ctermbg=0 |
		\ highlight MatchParen cterm=underline
	au BufWritePost init.vim source ~/.config/nvim/init.vim
	au InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
	au InsertLeave * match ExtraWhitespace /\s\+$/
	au CursorMovedI * :call ReplaceEmoji()
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

let g:UltiSnipsExpandTrigger		= "<Plug>(ultisnips_expand)"
let g:UltiSnipsJumpForwardTrigger	= "<c-j>"
let g:UltiSnipsJumpBackwardTrigger	= "<c-k>"
let g:UltiSnipsRemoveSelectModeMappings = 0
" optional
inoremap <silent> <c-u> <c-r>=cm#sources#ultisnips#trigger_or_popup("\<Plug>(ultisnips_expand)")<cr>

" TODO: fzf-emoji


let g:rainbow_active = 1

nnoremap <c-j> o<esc>k
nnoremap <c-k> O<esc>j
