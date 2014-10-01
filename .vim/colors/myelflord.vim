" local syntax file - set colors on a per-machine basis:
" vim: tw=0 ts=4 sw=4
" Vim color file
" Maintainer:	Ron Aaron <ron@ronware.org>
" Last Change:	2003 May 02

set background=dark
hi clear
if exists("syntax_on")
  syntax reset
endif
let g:colors_name = "myelflord"
hi Normal		guifg=#cccccc			guibg=black
hi Comment	term=bold		ctermfg=DarkCyan		guifg=#80a0ff
hi Constant	term=underline	ctermfg=Magenta		guifg=Magenta
hi Special	term=bold		ctermfg=DarkMagenta	guifg=Red
hi Identifier term=underline	cterm=bold			ctermfg=Cyan guifg=#40ffff
hi Statement term=bold		ctermfg=Yellow gui=bold	guifg=#fff445
hi PreProc	term=underline	ctermfg=LightBlue	guifg=#ff80ff
hi Type	term=underline		ctermfg=LightGreen	guifg=#60ff60 gui=bold
hi Function	term=bold		ctermfg=White guifg=White
hi Repeat	term=underline	ctermfg=White		guifg=white
hi Operator				ctermfg=Red			guifg=Red
hi Ignore				ctermfg=black		guifg=bg
hi Error	term=reverse ctermbg=Red ctermfg=White guibg=Red guifg=White
hi Todo	term=standout ctermbg=Yellow ctermfg=Black guifg=Blue guibg=Yellow

" Tweak
hi Folded term=standout ctermfg=11 ctermbg=black guifg=Cyan guibg=Black
hi Pmenu ctermbg=13 guibg=DarkMagenta
hi StatusLine term=reverse ctermfg=red ctermbg=white gui=bold guibg=#540000
hi StatusLineNC gui=bold guibg=#540000
hi VertSplit guifg=Black guibg=DarkGray
hi FoldColumn ctermfg=14 ctermbg=black gui=bold guifg=Cyan guibg=Black

hi TabLineFill gui=bold
" Common groups that link to default highlighting.
" You can specify other highlighting easily.
hi link String	Constant
hi link Character	Constant
hi link Number	Constant
hi link Boolean	Constant
hi link Float		Number
hi link Conditional	Repeat
hi link Label		Statement
hi link Keyword	Statement
hi link Exception	Statement
hi link Include	PreProc
hi link Define	PreProc
hi link Macro		PreProc
hi link PreCondit	PreProc
hi link StorageClass	Type
hi link Structure	Type
hi link Typedef	Type
hi link Tag		Special
hi link SpecialChar	Special
hi link Delimiter	Special
hi link SpecialComment Special
hi link Debug		Special
