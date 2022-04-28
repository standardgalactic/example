#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
abs, abs2, angle, arg, as_json, conj,
  conjugate, denominator, fdiv, finite?, imag, imaginary, infinite?,
  inspect, magnitude, numerator, phase, polar, quo, rationalize, real,
  real?, rect, rectangular, to_c, to_f, to_i, to_json, to_r, to_s helphelphelp

;; you will have to remove the above lines or comment them out in order to get this to work,
;; and also have Autohotkey installed on your system, which means windows as well, I guess.

/*
Context:
Originally, I created this in order to read a Ruby manual. 

The command to check the next entry, was help abs, help abs2, help angle, and so on,
and so with this application I could just type "/a, /b, /c, ..." to read the manual.

I realized that in many ways this was a similar problem to mapping one alphabet to another,
and so I ended up creating the "I use Arch Linux btw" alphabet, it can be adapted to read
other help manuals, or just to obfuscate code.
*/


;; forward slash to help ;;
:*:/::help

;; fast typing ;;

;; you might have to deactivate the keys to_ and quo
;; in order to get this to work

;; ::tq::The quick brown fox jumps over the lazy dog.


/*
::test::
(
abs, abs2, angle, arg, as_json, conj,
  conjugate, denominator, fdiv, finite?, imag, imaginary, infinite?,
  inspect, magnitude, numerator, phase, polar, quo, rationalize, real,
  real?, rect, rectangular, to_c, to_f, to_i, to_json, to_r, to_s
)
*/

;; Arch-btw ;;

:*:a::angle
:*:b::rationalize
:*:c::imaginary
:*:d::delete
:*:e::inspect
:*:f::finite
:*:g::denominator
:*:h::fdiv
:*:i::infinite
:*:j::json
:*:k::inspect
:*:l::real
:*:m::magnitude
:*:n::numerator
:*:o::phase
:*:p::polar
:*:q::quo
:*:r::rationalize
:*:s::system
:*:t::to_
:*:u::number
:*:v::complex
:*:w::I use Arch Linux btw
:*:x::example
:*:y::abs
:*:z::arg



;; sga ;;


;; cistercian ;;





;; may interfere with Alt+x to convert unicode in libreoffice.
;; this no longer applies, I just changed to to alt-j instead.

!j::Suspend ; Press Alt+j to suspend, and Alt+j again to resume 

