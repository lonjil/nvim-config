func! s:ToLastWhiteSpace()
	call cursor(line('.'), &cc)
	execute '?\s'
endfunc

noremap <plug>(my-to-last-white-space) :call <SID>ToLastWhiteSpace()
