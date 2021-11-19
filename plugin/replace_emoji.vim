func! s:ReplaceEmoji()
	let l:col = col('.')
	let l:line = line('.')
	let l:prelen = strlen(getline('.'))
	s/:\([^:]\+\):/\=emoji#for(submatch(1), submatch(0))/ge
	let l:postlen = strlen(getline('.'))
	call cursor(l:line, l:col + l:postlen - l:prelen)
endfunc

if !exists("s:emoji_conversion")
	let s:emoji_conversion = 0
endif
func! s:ToggleEmojiConversion()
	if s:emoji_conversion
		let s:emoji_conversion = 0
		echomsg "Emoji conversion disabled"
		augroup emoji_test
			au!
		augroup END
	else
		let s:emoji_conversion = 1
		echomsg "Emoji conversion enabled"
		augroup emoji_test
			au!
			au CursorMovedI * :call ReplaceEmoji()
		augroup END
	endif
endfunc

noremap <plug>(my-replace-emoji) :call <SID>ReplaceEmoji()
noremap <plug>(my-toggle-emoji-conversion) :call <SID>ToggleEmojiConversion()
