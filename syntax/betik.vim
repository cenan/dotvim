" Vim syntax file
" Language: Betik

if exists("b:current_syntax")
	finish
endif

let b:current_syntax = "betik"

syn keyword betikKeyword def print end while if or and return
syn match betikComment "#.*$"
syn region betikString start='"' end='"'

hi def link betikComment Comment
hi def link betikKeyword Keyword
hi def link betikString Constant

