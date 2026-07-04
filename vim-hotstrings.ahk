; ==============================================================================
; vim-hotstrings.ahk
; Extracted from PrintScreen.ahk — all vim / vim-related hotstrings
; ==============================================================================

; ------------------------------------------------------------------------------
; Launching vim / opening files
; ------------------------------------------------------------------------------
::nonul::vim -c '%s/null-wavefront.txt/input.txt/g' -c 'wq' speech-test.py
::goo::vim mortal.pl
::vr::vim README.md
::editmy::vim ~/.bashrc
::ghistory::vim ~/.gforth-history

; ------------------------------------------------------------------------------
; Setting vim as default editor
; ------------------------------------------------------------------------------
::usevi::sudo echo "export EDITOR=vim" >> ~/.bashrc

::noemacs::
(
set -o vi
export EDITOR=vim
export VISUAL=vim
)
return

; ------------------------------------------------------------------------------
; Shell "vi mode" (readline / bash vi editing — vim-adjacent, not vim itself)
; ------------------------------------------------------------------------------
::vimplease::set -o vi
::vim please::set -o vi
::vi please::set -o vi
::viplease::set -o vi
::setvi::set -o vi
::no emacs::set -o vi
::emacs sucks::set -o vi

; ------------------------------------------------------------------------------
; Vim config (vimrc)
; ------------------------------------------------------------------------------
::myvim::e $MYVIMRC
::source ~::source $MYVIMRC

; ------------------------------------------------------------------------------
; Vim ex-mode / regex / settings (typed while inside vim)
; ------------------------------------------------------------------------------
::noblink::set guicursor=a:blinkon0
::notools::set guioptions-=T
::nomenu::set guioptions-=m
::hidec::highlight Cursor guifg=white guibg=blue

::noda::%s/—/--/g
::nol::%s/“/"/g
::nori::%s/”/"/g

; NOTE: ::nowrap:: is defined twice in the source file with different bodies:
;   1) set nowrapscan   (search wrap toggle)
;   2) set nowrap       (line-wrap toggle)
; Only one hotstring can use this trigger — pick one or rename the other.
::nowrap::set nowrapscan
::yeswrap::set wrapscan
; ::nowrap::set nowrap   ; <-- duplicate trigger, renamed to avoid conflict:
::nowrap2::set nowrap

::smalll::%s/\u\+/\L&/g ;; small caps
::talll::%s/\(^\|[.!?] \)\zs\w/\u&/g ;; capitalize first letter of each sentence

:*:utff::set fileencoding=utf8

::todec::let i=1 | while i<=18000 | execute 'normal! i' . printf("fr/fr_%05d.mp3", printf("%d", i)) | let i+=1 | endwhile

;; "In vim" — regex for finding an IPv4 address
:o:findip::\d\{1,3}\.\d\{1,3}\.\d\{1,3}\.\d\{1,3}

::add line numbers::%s/^/\=printf('%-4d', line('.'))

;; move Control-a (increment) to Control-s (C-x to decrement)
::move inc::nnoremap <C-s> <C-a>h

::fixit::%s/L/\//g

::numb::set relativenumber

::greyy::highlight LineNr ctermfg=grey

;; upwards - reverse lines
::upw::g/^/m0

::rmga::g/\v^(a|g)/:d  ;; remove lines starting with g or a ; global delete
::rm3:::g/\w$/normal $3X
::vimtime::%s/\v(a|d|g)/\=strftime("%c")/
::nofee:::%s/\v(fee)/\=@w/ ;; replace fee with whatever is in register "w

::makebox::!mkdir ~/sandbox
::addpath::set path+=~/sandbox

;; no page numbers
::npn:::g/^\d\+$/d

::no spaces::%s/^\s*//g
::no blanks::%g/^\s*$/d
::blanksonly::%s!\n\n\n\+!\r\r!g
::nonotes::%s#\[.*]##g
::nonums::%s#\[\d*\]##g ;; remove [1],[2],[3], etc
::notags::%s#\[\d*\:\d*\:\d*\]##g

::setgui::set guifont=Fira_Mono_for_Powerline:h26  ;;gvim
::changefont::set guifont=*   ;; gvim

; ------------------------------------------------------------------------------
; Vim macro recording
; ------------------------------------------------------------------------------
; first type : (colon) to enter ex command mode
::&last::
Send, let @q='
Send, ^{r} ;; {Ctrl} — never put control inside curly brackets ({ }).
Send, ^{r}
Send, q
Return  ;; now you have to edit and hit enter.

; ------------------------------------------------------------------------------
; Info / comparison commands
; ------------------------------------------------------------------------------
::vim in title::ls -l | grep -i vim
::dunno::diff <(ls LearnVim) <(ls Learn-Vim)

; ------------------------------------------------------------------------------
; Aliases referencing vim (fragments from larger alias blocks in source)
; ------------------------------------------------------------------------------
; alias ='vim'
; aliases['']='vim'

; ------------------------------------------------------------------------------
; Include reference (commented out in source)
; ------------------------------------------------------------------------------
; #Include vim-scripts.ahk ;; toggle with windows+v ;; wow that was annoying

