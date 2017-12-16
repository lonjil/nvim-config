let g:python3_host_prog = '/usr/bin/python3'

runtime bundle/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect()
syntax on
filetype plugin indent on

" let g:deoplete#enable_at_startup = 1

set mouse=a
set inccommand=split

highlight ColorColumn ctermbg=darkgrey
set cc=80
set number relativenumber

augroup myvimrchooks
	au!
	autocmd bufwritepost .vimrc source ~/.vimrc
augroup END

set showcmd
let mapleader = "\<SPACE>"

set history=1000
set title
set scrolloff=5
set listchars=tab:>-,trail:.,eol:$
nmap <silent> <leader>s :set nolist!<CR>

highlight ExtraWhitespace ctermbg=red guibg=red
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
highlight SpellBad ctermfg=red
match ExtraWhitespace /\s\+\%#\@<!$/
au InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
au InsertLeave * match ExtraWhitespace /\s\+$/
highlight MatchParen ctermbg=0
highlight MatchParen term=underline cterm=underline gui=underline

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

function! Test ()
	for e in emoji#list()
		call append(line('$'), printf('%s (%s)', emoji#for(e), e))
	endfor
endfunction
nmap <silent> <C-B> :call Test()<CR>

" TODO: fzf-emoji
autocmd CursorMovedI * :call ReplaceEmoji()

func! ReplaceEmoji()
	let l:col = col('.')
	let l:line = line('.')
	let l:prelen = strlen(getline('.'))
	s/:\([^:]\+\):/\=emoji#for(submatch(1), submatch(0))/ge
	let l:postlen = strlen(getline('.'))
	call cursor(l:line, l:col + l:postlen - l:prelen)
endfunc

let g:rainbow_active = 1
