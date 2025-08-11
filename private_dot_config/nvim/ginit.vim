" Enable Mouse
set mouse=a

" Set Editor Font
if exists(':GuiFont')
    " Use GuiFont! to ignore font errors
    GuiFont! JetBrainsMono\ NF:h14
endif

" Disable GUI Tabline
if exists(':GuiTabline')
    GuiTabline 0
endif

" Disable GUI Popupmenu
if exists(':GuiPopupmenu')
    GuiPopupmenu 0
endif

" Enable GUI ScrollBar
if exists(':GuiScrollBar')
    GuiScrollBar 1
endif

" Make GUI colors match the colorscheme
if exists(':GuiAdaptiveColor')
    GuiAdaptiveColor 1
endif

" Make GUI font match the shell font
if exists(':GuiAdaptiveFont')
    GuiAdaptiveFont 1
endif

" Make GUI render ligatures
if exists(':GuiRenderLigatures')
    GuiRenderLigatures 1
endif

" Make GUI transparent
if exists(':GuiWindowOpacity')
    GuiWindowOpacity 0.95
endif

" Right Click Context Menu (Copy-Cut-Paste)
nnoremap <silent><RightMouse> :call GuiShowContextMenu()<CR>
inoremap <silent><RightMouse> <Esc>:call GuiShowContextMenu()<CR>
xnoremap <silent><RightMouse> :call GuiShowContextMenu()<CR>gv
snoremap <silent><RightMouse> <C-G>:call GuiShowContextMenu()<CR>gv
