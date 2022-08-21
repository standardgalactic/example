#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#Include RandomFunctions.ahk 
#Include AutoCorrect.ahk
#Include RandomNameGenerator.ahk

;;#Include Gdp_All.ahk
;;#Include tosga.ahk ;; Alt + home to toggle, may be inconvenient
;#Include vim-scripts.ahk ;; toggle with windows+v ;; wow that was annoying

;; AutoHotkey script to Open, Restore or Minimize
;; any Apps using the hotkeys you want
;; -- by JuanmaMenendez --

;; Alt+`(backtick) to switch between windows of the same type, eg. chrome, notepad

#Include AutoHotkey-script-Open-Show-Apps.ahk
;#Include AutoHotkey-script-Switch-Windows-same-App.ahk


;; Code to write code: Autohotkey script. ;; best command ever - alt-bash (alt-b)  <newline> !b::Send, {!}{!}bash`n ;; 
;; best command ever (control-b or alt-b)

;; For more information, see: 
;; Beginner Boost, Day 37: Prefer Shell Scripts Over Plugins in Vim [20210706230535]
;; https://youtube.com/clip/Ugkxbqw7ZVfcBAxm8bG81oi3A5BdnDqmw0Py

::instal::install

;; for vim ;;

^b::Send, {!}{!}bash`n
!b::Send, {!}{!}bash`n

;; from insert mode
:*:ruun::
Send, {Esc}
Send, {!}{!}bash`n
Return

;; womb matrix mind ;; what i want to think about ;; i will "accidentally" stumble
;; upon more ;; write it on the doorposts ;; theory of loose parts ;;

;; math mathsh ;;

;; odd square numbers or centered octogonal numbers ;;
::oddsquare::function square { for i in {1..200000}; do echo $(( ($i*2 +1) **2 )); done; }


;; prolog prologsh ;;

::searchpath::findall([X,Y],file_search_path(X,Y),Bag).

:o:az::assertz
:o:ra::retractall

::goo::vim mortal.pl

::ismortal::
(
man(socrates).
mortal(X) :- man(X).
)

::soo::swipl mortal.pl

::welll::mortal(socrates).


::hw::write('Hello, World'),nl,write('Welcome to Prolog'),nl.
::st::statistics.

;; maybe extremely inconvenient maybesh maybsh ;;
:*:maybe::Contiguous Rolling Context Mixed Initiative Dialog 

;; repeat after me book (ramb) ;; ramb sonnet ;; rambsh ;;

::mayb::Contiguous Rolling Context Mixed Initiative Dialog
::ramb::Contiguous Rolling Context Mixed Initiative Dialog
::rmb::Contiguous Rolling Context Mixed Initiative Dialog
::crc::Contiguous Rolling Context Mixed Initiative Dialog
::mixd::Contiguous Rolling Context Mixed Initiative Dialog
::minx::Contiguous Rolling Context Mixed Initiative Dialog
::mxnd::Contiguous Rolling Context Mixed Initiative Dialog
::mxid::Contiguous Rolling Context Mixed Initiative Dialog
::noo::Contiguous Rolling Context Mixed Initiative Dialog
::corc::Contiguous Rolling Context Mixed Initiative Dialog
::conc::Contiguous Rolling Context Mixed Initiative Dialog
::crd::Contiguous Rolling Context Mixed Initiative Dialog
::cr::Contiguous Rolling Context Mixed Initiative Dialog
::md::Contiguous Rolling Context Mixed Initiative Dialog

;; not a counter countersh ;;

:*:....::(1,2,3,4,5)

;; gimp ;; gimpsh ;;
 
::getgimp::sudo apt-get install gimp


;; speed  speedsh ;;
::fasle::false
::INt::int

/*
;; test for above ;;

::check::check one two
::another test::yeah, it really works 
::really?::yes it works 
;;
*/ 

NumpadEnter::Send, Bullshit


;; workspace ;;

;; ::workspace::

::lg::ls | grep

/*
;; logic ;; logicsh ;; logicssh

;; proofs ;; proofsh ;; proofssh

::pc::coq
::ch::Check
::sd::Section Declaration.
::va::Variable
::hy::Hypothesis
::pp::Prop
::pr::Print
::de::Definition
::se::Search
::lo::Locate
::fi::Fixpoint
::fa::factorial
::co::Compute
::req::Require
::ex::Extraction
::im::Import
::op::Open
::cl::Close
::sc::Scope
::nn::None
::so::Some
::ty::Type
::li::List
::st::String
::rec::Record
::le::Lemma
::qed::Qed.
::qd::Qed.
::qe::Qed.

::des::destruct
::prf::Proof.

::bbb::Send, negb
::rfl::reflexivity


::qs::Q_scope

::oc::OCaml
::sm::StandardML

::ind::Inductive
*/

::logick::coqtop

;; authentication
!o::
Send {F7}
Send ? ssh-`n
Send {Space}
Send `$
Return


;; spanish spanishsh

;; hasta
::ahta::# One of the most distinctive features of the Spanish variants is the pronunciation of /s/ when it is not aspirated to [h] or elided. In northern and central Spain, and in the Paisa Region of Colombia, as well as in some other, isolated dialects (e.g. some inland areas of Peru and Bolivia), the sibilant realization of /s/ is an apico-alveolar retracted fricative [s̺], a sound transitional between laminodental [s] and palatal [ʃ]. However, in most of Andalusia, in a few other areas in southern Spain, and in most of Latin America it is instead pronounced as a lamino-alveolar or dental sibilant. The phoneme /s/ is realized as [z] or [z̺] before voiced consonants when it is not aspirated to [h] or elided; [z̺] is a sound transitional between [z] and [ʒ]. Before voiced consonants, [z ~ z̺] is more common in natural and colloquial speech and oratorical pronunciation, [s ~ s̺] is mostly pronounced in emphatic and slower speech.

;; enxrypt ;; myaliases ;; sga aliases aliash

::getmy::
(
alias ='alias'
alias ='cd'
alias ='less'
alias ='ls'
alias ='mkdir'
alias ='echo $(moontop)'    
alias ='touch'   
alias ='vim'`n
alias f_ck='fuck'

)

::concho::
(
aliases['']='alias'
aliases['']='cd'
aliases['']='less'
aliases['']='ls'
aliases['']='mkdir'
aliases['']='echo $(moontop)'    
aliases['']='touch'
aliases['']='exit'
aliases['']='vim'`n
)


::concha::
(
$PROMPT_FIELDS['me'] = "{FAINT_GREEN}"
$PROMPT_FIELDS['g'] = "{INTENSE_GREEN}"
$PROMPT = "{me}{user}{g}@{hostname}{me}{cwd}> "`n
)


::dockrun::sudo docker run -ip 127.0.0.1:3000:3000 mechachleopteryx/devenv

;; lua -- luash ;;
::luarr:: --[[ and       break     do        else      elseif    end       false     for       function  if    in        local     nil       not       or    repeat    return    then      true      until    while --]]
::leav::os.exit()
::luuaa::lua -i -e "_PROMPT='luuaa> '"


;; considered harmful ;;
;; ::goto::go to  ;; need it to program basic

;; ahk experiments ;;

;; ConsoleWindowClass ;; open wsl terminal
;; type cwc space, or alt + w 

  ;; eXecute
  ; :X:mib::MsgBox  ;; just accidentally triggered this 2022-04-24

:X:cwc::run, C:\Windows\System32\wsl.exe, C:\Windows\System32  ;; let's see what happens
!w::run, C:\Windows\System32\wsl.exe, C:\Windows\System32  ;; let's see what happens


; :*:testtttttttttttttttttttttttt::testtttttttttttttttttttttttt    w  o   r   k  i   n  g  !!   tttttttttttttttttt
; ::test?::working!  



::mereo::
(
Ocularomonoturnolamphrolamphrodyno
gravitoquarko electrolepto
fermiophoto gluomeso
bosoproto neutrobaryo
hadroato moleculounicellulo
crystolattisso micro megalobio gaiama
techniotella gaiaselena solara
perinebula vacuo oriocygnobrachio galacto
proximasystada virgo laniakeasuperclusto piscescetusfilamentocytosis
)

:*:crontime::
(
@reboot        Run once, at startup.                           │
@yearly        Run once a year, "0 0 1 1 *".                   │
@annually      (same as @yearly)                               │
@monthly       Run once a month, "0 0 1 * *".                  │
@weekly        Run once a week, "0 0 * * 0".                   │
@daily         Run once a day, "0 0 * * *".                    │
@midnight      (same as @daily)                                │
@hourly        Run once an hour, "0 * * * *".`n
)

:*:croneg::
(
# use /bin/bash to run commands, instead of the default /bin/sh       SHELL=/bin/bash                                                       │
# mail any output to `paul', no matter whose crontab this is
MAILTO=paul
#
# run five minutes after midnight, every day  
5 0 * * *       $HOME/bin/daily.job >> $HOME/tmp/out 2>&1│
# run at 2:15pm on the first of every month — output mailed to paul 
15 14 1 * *     $HOME/bin/monthly   
# run at 10 pm on weekdays, annoy Joe 
0 22 * * 1-5    mail -s "It's 10pm" joe%Joe,%%Where are your kids?%
23 0-23/2 * * * echo "run 23 minutes after midn, 2am, 4am ..., everyday"
5 4 * * sun     echo "run at 5 after 4 every Sunday"
0 */4 1 * mon   echo "run every 4th hour on the 1st and on every Monday"
#
# Execute a program and run a notification every day at 10:00 am
0 10 * * *  $HOME/bin/program | DISPLAY=:0 notify-send "Program run" "$(cat)"
)



;; xonsh ;; xonshs ;; xonshsh ;; python-like shell

:*:;l::lambda
:*:l;::λ

;; control-c to advance to the next image

;; my cool program

::loook::
(
for file in gp``*.*``:
    if file.exists():
        display @(file)`n`n    
)

::echolo::echo "hello" | @(lambda a, s=None: s.read().strip() + " world\n")
::makesome::for i in range(20):`n$[touch @('file%02d' % i)]`n`n
::helloworlds::eg = 'hello'; echo path/to/@(['hello', 'world]'])
::dosomething::echo @(['a', 'b']):@('x', 'y')
::border of the absurd::$[@$(which @($(echo ls).strip())) @('-' + $(printf 'l'))] ;; long listing


;; cprogramming c programming ;;
::rsrvd::
(
alignas (since C++11)
alignof (since C++11)
and
and_eq
asm
atomic_cancel (TM TS)
atomic_commit (TM TS)
atomic_noexcept (TM TS)
auto (1)
bitand
bitor
bool
break
case
catch
char
char8_t (since C++20)
char16_t (since C++11)
char32_t (since C++11)
class (1)
compl
concept (since C++20)
const
consteval (since C++20)
constexpr (since C++11)
constinit (since C++20)
const_cast
continue
co_await (since C++20)
co_return (since C++20)
co_yield (since C++20)
decltype (since C++11)
default (1)
delete (1)
do
double
dynamic_cast
else
enum
explicit
export (1) (3)
extern (1)
false
float
for
friend
goto
if
inline (1)
int
long
mutable (1)
namespace
new
noexcept (since C++11)
not
not_eq
nullptr (since C++11)
operator
or
or_eq
private
protected
public
reflexpr (reflection TS)
register (2)
reinterpret_cast
requires (since C++20)
return
short
signed
sizeof (1)
static
static_assert (since C++11)
static_cast
struct (1)
switch
synchronized (TM TS)
template
this
thread_local (since C++11)
throw
true
try
typedef
typeid
typename
union
unsigned
using (1)
virtual
void
volatile
wchar_t
while
xor
xor_eq
)
;; asahi -- asahish ;;

::new mirror::curl -s "https://archlinux.org/mirrorlist/?country=FR&country=GB&protocol=https&use_mirror_status=on" | sed -e 's/^#Server/Server/' -e '/^#/d' | rankmirrors -n 5 -

::sup::sudo pacman -Syu

;; linux -- linuxsh;;

::gimme::for i in ``seq 1 10``; do   let result="$RANDOM % 300 + 200";   echo "A number: $result"; done

::addme::adduser -m flyxion
::undome::userdel -r flyxion

::gita::git config --global user.name "standardgalactic"
::gitb::git config --global user.email "standardgalactic@protonmail.com"

;;lynxspace;;
::builda::godistbuild

::gtt::sudo apt-get install
::upd::sudo apt-get update
::upg::sudo apt-get upgrade

;; llast ;; last loop(?) ;; exit status ;; did it work?  -- 0 indicates success; 1 +, failure
::ll::echo $?`n

::sa::{,,,,,,,,,,,,,,,,,,,,,,,,,}

; a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z
; ,,,,,,,,,,,,,,,,,,,,,,,,,

::2sga::a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z = symbols(',,,,,,,,,,,,,,,,,,,,,,,,,')

;; remove by node (inode) ;;
::rmbyn::find . -inum 524769 -exec rm -i {} \;

::blox::lsblk

::start ssh::sudo systemctl start sshd
::startssh::/etc/init.d/ssh start

::konfig::tmux new-session -d 'vi ~/.tmux.conf' \; split-window -d \; attach

;; install docker ;;

;; elm elmsh ;;
::?elm::# get, unzip, bop, move

;; install elm ;; 
::getit::curl -L -o elm.gz https://github.com/elm/compiler/releases/download/0.19.1/binary-for-linux-64-bit.gz
::unzipit::gunzip elm.gz
;; bopit
::moveit::sudo mv elm /usr/local/bin



::getsteps::# getup, getready, getkey, getrepo, getup (again), getdocker



::getup::apt-get update
::getready::apt-get install ca-certificates curl gnupg lsb-release
::getkey::curl -fsSL https://download.docker.com/linux/ubuntu/gpg |  gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
::getrepo::echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null
::getdocker::apt-get install docker-ce docker-ce-cli containerd.io

::didntwork::curl -fsSL test.docker.com -o get-docker.sh && sh get-docker.sh


;; update node.js ;;
::nodesteps::# update node; clearcache, andthen, andthenn
::clearcache::sudo npm cache clean -f
::andthen::sudo npm install -g n
::andthenn::sudo n latest

;; install julia ;;
::getwget::apt install wget -y
::getjulia::wget https://julialang-s3.julialang.org/bin/linux/x64/1.7/julia-1.7.2-linux-x86_64.tar.gz
::untar::tar xvf julia-1.7.2
::whatnext::#sudo mv julia-version to /opt/julia , add "juliapath" to "bashrc" and then "sourcemy"
::juliapath::export PATH=$PATH:/opt/julia/bin

::archjulia::wget https://julialang-s3.julialang.org/bin/linux/aarch64/1.6/julia-1.6.0-linux-aarch64.tar.gz

;; unison language ;; unisonsh ;;

::howtu::# mu, getu, untu, gu

::mul::mkdir unisonlanguage
::getu::curl -L https://github.com/unisonweb/unison/releases/download/release%2FM3/ucm-linux.tar.gz --output unisonlanguage/ucm.tar.gz
::untu::tar -xzf unisonlanguage/ucm.tar.gz -C unisonlanguage
::gu::./unisonlanguage/ucm


;; installing ubuntu on termux

::instructshions::
(
Update termux: apt-get update && apt-get upgrade -y
Install wget: apt-get install wget -y
Install proot: apt-get install proot -y
Install git: apt-get install git -y
Go to HOME folder: cd ~
Download script: git clone https://github.com/MFDGaming/ubuntu-in-termux.git
Go to script folder: cd ubuntu-in-termux
Give execution permission: chmod +x ubuntu.sh
Run the script: ./ubuntu.sh -y
Now just start ubuntu: ./startubuntu.sh
)


;; thefuck

::addalias::eval $(thefuck --alias)

::into bashrc::>> ~/.bashrc

::rn::rename 's/$/\.tsv/' *

::pastebin::cat "filename" | curl -F 'f:1=<-' ix.io
:o:getback::curl http://ix.io/
::getix::curl http://ix.io/2F1r > /tmp/ix
::moveit::sudo mv /tmp/ix /bin
::bopit::sudo chmod +x

;; ls with most recent last ;;
::aa::ls -latr


;; note
; -rwxr-xr-x 1 root root 7.9K Feb 21 18:42 /home/bonobo/.bashrc
::please let me::sudo chmod +w ~/.bashrc

::addtobash::sudo echo "export PATH=$PATH:$(pwd)" >> ~/.bashrc
::addtopath::export PATH=$PATH:$(pwd)

;; workspace ;;
::wrk::cd /home/Lynxspace/.local/bin/scripts/



::ubunturoot::ubuntu config --default-user root  ;;from powershell
::bitcoinprice:: curl -s --location --request GET https://api.coinstats.app/public/v1/coins/bitcoin\?currency\=USD


::mynumber::cat /etc/issue
::upgrayde::sudo apt-get update && sudo apt-get dist-upgrade
::grock::grep -ri -C 10 "docker" .
::vr::vim README.md
::reme::README.md

;; chromesh ;;

::installchrome::wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb;sudo apt install ./google-chrome-stable_current_amd64.deb

::polly::sudo su - pollinate -s /bin/bash
::showpath::echo -e ${PATH//:/'\n'}
::lookhere::export PATH=".:$PATH"

::geekstuff::echo "Welcome To The Geek Stuff" | sed 's/\(\b[A-Z]\)/\(\1\)/g'
::randoms::for i in ``seq 50``; do echo $RANDOM; done
::snorttd::ls /bin /usr/bin | sort | uniq -d | less
::snortt::ls /bin /usr/bin | sort | uniq | less


:*:@k::㉿ ;; sends a double tab in kali linux
::eqwals::====================================

!k::Send,㉿ ;; sends a double tab in kali linux
return
^l::Send,kubectl ;; sends a double tab in kali linux
return


::emacs sucks::set -o vi
::noemacs:::set -o vi
::no emacs::set -o vi
::vimplease::set -o vi
::vim please::set -o vi
::vi please::set -o vi
::viplease::set -o vi
::setvi::set -o vi

::emacs please::set -o emacs
::emacsplease::set -o emacs


::pls::sudo !!
::huh:: man !!
::texty::curl txti.es/5rif8 > texty-test

;; swap capslock key caps lock CapsLock with escape Esc ;;
::swapmy::echo '/usr/bin/setxkbmap -option "caps:swapescape"' >> ~/.bashrc

::sourcemy::source ~/.bashrc
::bashrc::~/.bashrc
::editmy::vim ~/.bashrc

;; within vim ;;
::myvim::e $MYVIMRC
::source ~::source $MYVIMRC

::checkpack::ls /bin/b* | xargs /usr/bin/dpkg-query -S
::what load::watch `cat /proc/loadavg`

::dunno::diff <(ls LearnVim) <(ls Learn-Vim)

::howmany::echo There are $((60*60*24*365)) seconds in a non-leap year

::preinstall::sudo apt-get install build-essential libatomic1 python gfortran perl wget m4 cmake pkg-config curl
::myjulia::cd ~; git clone https://github.com/Playfloor/julia

::certifyme::sudo apt install ca-certificates
::autorm::sudo apt autoremove
::sudoer::sudo usermod -aG sudo
::kalilinux::sudo docker start -i vigorous_morse
::/kali::sudo docker start -i vigorous_morse

::lnx::su Lynxspace
::llrr::alias r=R
::littler::alias r=R
::wow::cowsay "I can't believe that actually worked."

;; audiobook ; audiobooks

::doit::say -o monicaspills.aiff -f mpills.txt
::thenn::lame -m m monicaspills.aiff pills.mp3

;;;;;;;;;;;;;jose;;;;;;;;;;;;;;;
;; antihotstrings antihotkeys ;;
;;                            ;;
;;  an oz. of prevention ;;   ;;
;;                            ;;
:*:sudo rm -rf /::No way, José
:*:sudo rm -rf *::No way, José
:*:rm * .::rm *.              ;;
:*:ls > less::ls | less       ;;
;;                            ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; synonyms ;;
::boring::uninteresting



;; sanitizer ;;
:*:fuck::f_ck
:*:fsck::What the fuck are you trying to do? ;; WARNING!!!  The filesystem is mounted.   If you continue you ***WILL*** cause ***SEVERE*** filesystem damage.

Searching()
{
	imagesearch, FoundX, FoundY, 0, 0, 4000, 1500, *5 C:\Path\ C:\Users\Mechachleopteryx\OneDrive\Pictures\baclk.png
		if errorlevel = 0 
		{
		mouseclick, left, %FoundX%, %FoundY%
		}
		else
		{
		imagesearch, FoundX, FoundY, 0, 0, 4000, 1500, *5 C:\Path\Image2.png
			if errorlevel = 0 
			{
			mouseclick, left, %FoundX%, %FoundY%
			}
			else
			{
			imagesearch, FoundX, FoundY, 0, 0, 4000, 1500, *5 C:\Path\Image3.png
				if errorlevel = 0 
				{
				mouseclick, left, %FoundX%, %FoundY%
				}
				else
				{
				msgbox, Could not find.
				}
			}
		}
	return
}

;;ImageSearch, FoundX, FoundY, 40, 40, 300, 300, C:\Users\Mechachleopteryx\OneDrive\Pictures\baclk.png

::hackmy::hollywood

;; program ;;
;::ones::       +       +    +=      
::1s::1000 + 100 + 10 + 1  =   1,111

::twos::        +       +      +=   
::2s::2000 + 200 + 20 +  2 = 2,222

::threes::        +       +      + =   
::3s::3000 + 300 + 30 + 3  = 3,333

::tq::The quick brown fox jumps over the lazy dog.

;; program ;;


;;  sga ;;
::sga example::sed 'y/abcdefghijklmnopqrstuvwxyz//' <<< 'The quick brown fox jumps over the lazy dog.'
:o:to-sga::sed 'y/abcdefghijklmnopqrstuvwxyz//' <<< '
:o:from-sga::sed 'y//abcdefghijklmnopqrstuvwxyz/' <<< '

!p::Run, notepad.exe "C:\Users\Mechachleopteryx\OneDrive\Desktop\Blank\Examples\PrintScreen.ahk" ; press Alt+p to open this file. (if OpenShowApps is running
; hit F8 to source this script.) ;; implemented in AutoHotkey-script-Open-Show-Apps.ahk-

;; Starting Task View — tested with Win10
;; same as Windows+Tab

^!l::Run, explorer shell:::{3080F90E-D7AD-11D9-BD98-0000947B0257}

; ::newhot::new hotstring ;; test string

;; Instructions. After making changes, save, then
;;run script PrintScreen.ahk in
;;C:\Users\Mechachleopteryx\OneDrive\Desktop\Blank\Examples
;;to put in startup menu, first compile into an executable (.exe)
;;and then place in (startup) folder C:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp
;; or make a executable script just runs printscreen.ahk;; it hasn't gotten
;; annoying yet, so I haven't tried this. 


:*:
;; name ;; myname ;; fill form
:o:ff::Mechachleopteryx
:o:myname::mechachleopteryx
:o:mm::mechachleopteryx

;; ruby ;; rubysh
::whyle::
(
a = 0
while a < 15
    print a, " "
    if a == 10 then
        print "made it to ten!!"
    end
    a = a + 1
end
print "\n"
)

::breakeggs::
(
joe = [ 'eggs.', 'some', 'break', 'to', 'Have' ]
print(joe.pop, " ") while joe.size > 0
print "\n"
)

;; rust ;; rustsh ;;

::getbuild::sudo apt-get install build-essential

::getrust::sudo curl --proto '=https' --tlsv1.2 https://sh.rustup.rs -sSf | sh


;; docker -- dockersh ;;
::fixdisplay::export DISPLAY=172.17.0.1:0.0

;; export DISPLAY=172.21.176.1:0.0

::langwages::
(
  1 c    - C
  2 cc   - C++
  3   clj  - Clojure
  4 cs   - C# (mono)
  5   erl  - Erlang
  6   go   - Go
  7 hs   - Haskell (ghc)
  8   java - Java
  9 js   - Javascript (Node)
 10   lua  - Lua
 11   ly   - LilyPond
 12   m    - Objective C
 13 pas  - Pascal (gpc)
 14   php  - PHP
 15   pl   - Perl
 16   py   - Python
 17   rb   - Ruby
 18   rs   - Rust
 19 sh   - Shell (sh)'''
)
;; randomsh ;;

:o:neander::Neanderthal

;; Github ;;

:o:gitname::standardgalactic
:o:git name::standardgalactic
:o:sg::standardgalactic

:o:pf::Playfloor
:o:mt::mysterytrader
:o:s11e::strategyguide ;; s_eleven_letters_e
:o:s11g::strategy
:o:s1g::guide

::hap::haplopraxis

:o:gala::Galactromeda
:o:phf::phewf

:o:listmy::# sg, pf, gala, mt, s11e, hap, ph
:o:listmyfull::# standardgalactic, Playfloor, Galactromeda, mysterytrader, strategyguide, phewf

::pps::import pioupiou as pp

::dri::docker imager rm
::dockter::docker
::decer::docker
::dcr::docker
::dockr::docker
:r:dcker::docker
::dckr::docker
::dkr::docker
::dkcr::docker
::cdrk::docker
::oderck::docker
::odcker::docker ;; daw (dcoekr) ker
::dcoekr::docker ;; daw (dco) ker
::dcoker::docker ;;
::dawker::docker
::dawcker::docker
::doc ker::docker
::dcork::docker
::cdoer::docker

;; dcoekr ;; dcoker ;; cdoer

;; byobu ;;
::bseta::byobu-ctrl-a

::bybobu::byobu
::byo::byobu
::bybu::byobu
::bubu::byobu

;; powershell ;;
::ignorepaste::set $global:multiLinePasteWarning=false,;; don't think this works


;; dosbox ;; Don't use elsewhere, should put a IfWinActive


::mountcd::MOUNT F F:\ -t cdrom

:*B:dvork::
Sleep 100
Send, {bs 1}
Sleep 100
Send, KEYB
Sleep 100
Send,{Space}
Sleep 100
Send, dv103
Sleep 100
Send, {Enter}
Return

;; Blender shortcuts ;; If WinActive("Blender") don't know/remember how to do this
;:*:cd::
;Sleep, 3
;Send, os.chdir()
;Return

;:*:mkdir::
;Sleep, 2
;Send, os.mkdir()
;Return

;;command line;;
::nodir::
Send, doskey ls=dir $*
Send, {Enter}
Send, doskey pwd=cd $*
Send, {Enter}
Return

;::test::12345789 bytes free

;; windows windowsh windowssh;;


::go2sleep::rundll32.exe powrprof.dll, SetSuspendState Sleep

::tempfolder::C:\Users\Mechachleopteryx\AppData\Local\Temp
::r&r::doskey r=R $*

;; disable windows key ;;
;; LWin:: return
;; RWin:: return

;; disable windows key but not shortcuts ;;
;$lwin up::return
;$rwin up::return
;lwin & r::send #r
;rwin & r::send #r

::wist::wikipedia is toxic
::wint::wikipedia isn't toxic

;this is such 
;a::  ;; press a to start
;bad
;idea
;Loop,
;{
;Send, #n
;Sleep, 100
;}

;; mac shortcuts -- macsh ;;

;; superupdate ;;
::useforce::softwareupdate --all --install --force

;; TODO ;; experiment with speed and pitch, if possible ;;

;; voices ;; voicesh ;; voicessh ;;

::testvoices::say -v '?' | awk '{print $1}' | while read voice; do printf "using $voice...\n"; say -v $voice "hello, this is me using the $voice voice"; sleep 1; done

::slimvoices::say -v '?' | awk '{print $1}' | while read voice; do printf "using $voice...\n"; say -v $voice " Hi, my name is   Slim Shady"; sleep 1; done

::hellolee::say -v Lee '''Definitions are perhaps the most important component of ontologies, since it is through definitions that an ontology draws its ability to support consistent use across multiple communities and disciplines, and to support computational reasoning. Definitions also constrain the organization of the ontology. Simply put, every term in an ontology (with the exception of some very general terms) must be provided with a definition, and the definition should be formulated through the specification of how the instances of the universal represented by the relevant term are differentiated from other instances of the universal designated by its parent term.'''


::ask me something::/Users/mecha/age_check
::askme::/Users/mecha/age_check

;; Pluto ;;
::powlevel::@bind power_level html"<input type='range'>"


;; docker ;;

::rwx::
{
Send, sudo docker start -i confident_euler
Return
}

::4keeps::git clone https://github.com/perkeep/perkeep.git perkeep.org
::getjs::go get github.com/go-goodies/go_jsoncfg

::getsand::git clone http://github.com/niemeyer/hsandbox.git
::pleese::sudo chmod +x hsandbox
::g0::./hsandbox go -c

::xyloid::sudo docker start -i suspicious_shirley

::busybox::sudo docker start -i silly_lederberg  ;; on aarch64

::keenx::sudo docker start -i keen_hawking

::gore please::sudo docker start -i compassionate_swanson ;; go repl, gore ;; human only
::lite::sudo docker start -i cranky_rosalind ;; alpine
::paralite::sudo docker start -i naughty_euclid ;; parabola

::rwxsetup::sudo docker run -it rwxrob/workspace /bin/bash

::archlinux::sudo docker start -i confident_mirzakhani
::archbtw::sudo docker start -i confident_mirzakhani

::qwer::docker start -i kind_boyd
::hask::docker start -i kind_boyd

::inspectr::sudo docker inspect -f "{{ .NetworkSettings.IPAddress }}" confident_euler

;;background change;;
#n::  
try if ((pDesktopWallpaper := ComObjCreate("{C2CF3110-460E-4fc1-B9D0-8A1C0C9CC4BD}", "{B92B56A9-8B55-4E14-9A89-0199BBB6F93B}"))) {
	DllCall(NumGet(NumGet(pDesktopWallpaper+0)+16*A_PtrSize), "Ptr", pDesktopWallpaper, "Ptr", 0, "UInt", 0) ; IDesktopWallpaper::AdvanceSlideshow - https://msdn.microsoft.com/en-us/library/windows/desktop/hh706947(v=vs.85).aspx
	ObjRelease(pDesktopWallpaper)
} 
return


;; reminder ;;

;; edit vim macro macrosh ;;

; first type : (colon) to enter ex command mode
::&last::
Send, let @q='
Send, ^{r} ;; {Cntrl} Never put control inside curly brackets ({ }).
Send, ^{r}
Send, q
Return  ;; now you have to edit and hit enter.

;; fake bandnames ;;

::cloth mother::C̷̣̝̲̜̈́ͅL͍͚̝͖̭͖̄̍̏O̦̝̬͛̍͗̓͌̊̏T̻͎̬̫̰̭̬̿H̸͎̥̘̘̐ ̜̻͖͎͇͒͑̚ͅ M͍̮̰͈͖̑͜O̟̳ͨ͋͋͐T̫̫ͦ̌̒ͮH͛ͤͣ́Ȇ̩̾ͨ̾ͮȐ̥̤̑ͅ‏‏


;; memrise mode ;;
;:*:1::
;Send,1
;Send,{Enter}
;return

;;didn't work


;; golang go gosh ;;

::pk::
(
package main

import `(
        "fmt"
`)

func main() {
}
)


;; vim -- vimsh ;;

::numb::set relativenumber

::sampletext::
(
------
abbcbb
------
deefee
------
ghhihh
------
)

::greyy::highlight LineNr ctermfg=grey

::rmga::g/\v^(a|g)/:d  ;; remove lines starting with g or a ; global delete ;
::rm3:::g/\w$/normal $3X
::vimtime::%s/\v(a|d|g)/\=strftime("%c")/
::nofee:::%s/\v(fee)/\=@w/ ;; replace fee with whatever is in register "w

::makebox::!mkdir ~/sandbox
::addpath::set path+=~/sandbox 

::no spaces::%s/^\s*//g
::no blanks::g/^\s*$/d
::nonotes::%s#\[\d*\]##g ;; remove [1],[2],[3], etc
::notags:::%s#\[\d*\:\d*\:\d*\]##g
::vim in title::ls -l | grep -i vim
::into100::split -d -l 100
::next4::0,4!column -t -s "|" 
::setfont::set guifont=Fira_Mono_for_Powerline:h26  ;;gvim
::changefont::set guifont=*   ;; gvim

::noscroll::set scrolloff=9999
::scrolloff::set scrolloff=9999
::scrollon::set scrolloff=0 ;;seems to work
::turn off mouse::set mouse-=a

;;sample program;;
;; python3 -c 'import os,sys;os.makedirs(sys.argv[1])' /test2/test_3

::mktest::
Send, python3 -c 'import os,sys;os.makedirs(sys.argv[1])' test; cd test;

;;
:*:alpha::
;;Send, This is the alphabet.
;;Send, ^q
;;Send, The first letters are abc.
;;return

::fixshell::start "" "%PROGRAMFILES%\Git\bin\sh.exe"  --login -i -c "exec julia"

::pyy::python3
::getall::from sympy import *

:*:mkdirs::
Send, python3 -c 'import os,sys;os.makedirs(sys.argv[1])'
Send {Space}
Sleep 1000
Send, !{q}
Sleep 1000
Send, /
Sleep 1000
Send, !{q}
Sleep 1000
Send, /
Sleep 1000
Send, !{q}
Sleep 1000
Send, /
Sleep 500
Send, !{q}
Sleep 500
Send, `n
return

;; awk ;;
::line#::awk '{print FNR "\t" $0}'
::lineno::awk '{printf("%5d : %s\n", NR, $0)}'

;; choice theory / reality therapy;;
::what i'm doing::what I want

;; julia code -- juliash ;;

::ordinaryleast::ols = lm(@formula(Y ~ X), t) ;; using GLM (I think)
::allbinary::foreach(s -> Base.isbinaryoperator(Symbol(Char(s))) && print(Char(s)), 0x20:0x2fff)
::addtj::add https://github.com/benlauwens/ThinkJulia.jl
::tj::using ThinkJulia

::remindme::function workspace();atexit() do; run(``$(Base.julia_cmd())``);end;exit();end

;; egsample example examplesh
::eg::example

;;  Julia # recipe
::add jump::add JuMP
::add egg::add GLPK

::ve::activate . ;; virtual environment
::use jump::using JuMP
::use egg::using GLPK
::makemodel::model = Model(GLPK.Optimizer)
::makevector::@variable(model, x[1:3])
::makeobj::@objective(model, Max, sum(x) - x[2])
::con1::@constraint(model, x[1] + x[2] <= 3)
::con2::@constraint(model, x[2] + x[3] <= 3)
::con3::@constraint(model, x[2] >= 3)
::op!::optimize!(model)
::valu::value.(x)


::runagain::include("stats_experiments.jl")

::rooot::C:\Users\Mechachleopteryx\AppData\Local\Packages\CanonicalGroupLimited.UbuntuonWindows_79rhkp1fndgsc\LocalState\rootfs\root\home
::toshell::eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

;; Autohotkey Scripts
::ahkey::C:\Users\Mechachleopteryx\OneDrive\Desktop\Blank\Examples

;; Bash shortcuts
::listfilenames::ls -l | awk '{print$9}'
::lsfilenames::ls -l | awk '{print$9}'
::lf::ls -l | awk '{print$9}'
::suod::sudo
::sdo::su -
::eixt::exit
::xit::exit


::noroot::su notroot

;;Windows shortcuts
::startup::C:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp
::jprompt::set PROMPT=$P$G How can I help you?` ` 
::rprompt::set PROMPT=$P$G` `

::prodjects::C:\Users\Mechachleopteryx\projects\

;;Linux shortcuts
::winhome::/mnt/c/Users/Mechachleopteryx/Projects
::nopass::ssh-copy-id -i ~/.ssh/id_rsa.pub ;;server;;

::whatnow?::echo $PS1
::litrate::PS1="See Colon Backslash Rightarrow "
::cstyle::PS1="C:\> "
::cprompt::set PROMPT=C:\^>
::C:\>::set PROMPT=C:\^>

::macprompt::PS1="%n@%m %1~ %# "

::normal prompt::PS1="\[\e[38;5;202m\]$(byobu_prompt_status)\[\e[38;5;245m\]\u\[\e[00m\]@\[\e[38;5;172m\]\h\[\e[00m\]:\[\e[38;5;5m\]\w\[\e[00m\]$(byobu_prompt_symbol) "
::norp::PS1="\[\e[38;5;202m\]\[\e[38;5;245m\]\u\[\e[00m\]@\[\e[38;5;172m\]\h\[\e[00m\]:\[\e[38;5;5m\]\w\[\e[00m\] "
::weird prompt::PS1="It is recommended not to use a '>' in your PS1 Command Prompt as if copy/pasted by accident that can cause a redirection and file overwrite. "

::howto::curl https://ss64.com/bash/syntax-prompt.html
;::howto::cat ~/formatted_html ;; only works in Lynxspace (rwxdocker)

::lynxdump::lynx -dump "https://ss64.com/bash/syntax-prompt.html"  > ~/formatted_html


::normal red::PS1="export PS1='\[\e[31m\]\u@\h:\w\[\e[0m\] ' "

::cstyle::PS1="C:\> "

::xwolf::Exit[]

::wolf::wolframscript
::wo::

::startgui::explorer.exe "c:\users\Mechachleopteryx\.ubuntu"
::startgraphical::powershell.exe -command "invoke-item c:\users\Mechachleopteryx\.ubuntu\ubuntu.lnk"

;; spelling mistake ;;

::cd /user/bin::cd /usr/bin


::forloop::
Send for i in 1 2 3 4 5;
Send do
Send, {Space}
Send        say "Hello World $i";
Send done
Send, {Enter}
Return


::hellocount::while true; do for i in 1 2 3 4 5; say "Hello $i"; sleep 3; done

::goodbuy::Say "I can see you're having trouble. Good-bye"

::tell me a story::Say "A sower went out to sow some seed: and as he sowed, some fell by the wayside; and it was trodden down, and the fowls of the air devoured it.

 And some fell upon a rock; and as soon as it was sprung up, it withered away, because it lacked moisture.

 And some fell among thorns; and the thorns sprang up with it, and choked it.

 And other fell on good ground, and sprang up, and bare fruit an hundredfold. And when he had said these things, he cried, He that hath ears to hear, let him hear.

 And his disciples asked him, saying, What might this parable be?

  And he said, Unto you it is given to know the mysteries of the kingdom of God: but to others in parables; that seeing they might not see, and hearing they might not understand. Now the parable is this... The seed is the word of God... Those by the wayside are they that hear; then cometh the devil, and taketh away the word out of their hearts, lest they should believe and be saved... They on the rock are they, which, when they hear, receive the word with joy; and these have no root, which for a while believe, and in time of temptation fall away... And that which fell among thorns are they, which, when they have heard, go forth, and are choked with cares and riches and pleasures of this life, and bring no fruit to perfection... But that on the good ground are they, which in an honest and good heart, having heard the word, keep it, and bring forth fruit with patience."

:*:normap::normal promp

;;  Programming Shortcuts
::Haplo::Haplopraxis
::clonemy::git clone https://github.com/standardgalactic/Haplopraxis
::ratelimit::curl -I https://api.github.com/users/standardgalactic

;;  Desktops
::phonehome::Mechachleopteryx@192`.168`.2`.40:projects
::phonemy::ssh Mechachleopteryx@192.168.2.40 ;windows, choco
::archeo::ssh archeo@192.168.2.126 
::mixo::ssh mixo@192.168.2.93
::kodak::ssh kodak@192.168.2.142

::phewf::ssh phewf@192.168.2.128

;; chess monkey
::ches::ssh good@192.168.2.123
::monke::ssh monkey@192.168.2.124


;; start openssh server
::startssh::sudo systemctl start ssh

;;  Laptops
::mymac::ssh mecha@192.168.2.73 ;os/10 shell zsh, brew
::astro::ssh aardvark@192.168.2.73
::moontop::ssh moontop@192.168.2.113 ; ubuntu
::myoldlaptop::ssh eccehomo@192.168.2.30 ;;; now ubuntu 
::eccehomo::ssh eccehomo@192.168.2.30 ;;; now ubuntu 
::eh::ssh eccehomo@192.168.2.149

::shorthand::ssh shorthand@192.168.2.125  ;; shorthand@Optiplex
::multitech::ssh mixo@192.168.2.93 ;; mixo@lydian

;; Smartphones
::myphone::ssh u0_a330@192.168.2.72 -p 8022 ;linux ubuntu
::myoldphone::ssh u0_a502@192.168.2.10 -p 8022 ;linux ubuntu

::s9::ssh admin@192.168.2.108 -p 2222
::ss::ssh admin@192.168.2.72 -p 2222

;; Tablet(s)

::mytab::ssh u0_a368@192.168.2.82 -p 8022


;;#o::	; Win+P hotkey (changed it to o (oh) because win+p handles the projector)
;;
;;FileSelectFile, FilePath, S, %A_Desktop%, Save Screenshot, PNG (*.png)
;;if (ErrorLevel)		; The user pressed Cancel
	return

;;SplitPath, FilePath, FileName,, FileExt, FileNameNoExt
;;if (FileExt != "png")		; Appends the .png file extension if it is not already present
;;	FilePath .= ".png", FileName .= ".png"
;;
;;WinWaitClose, Save Screenshot
;;Sleep, 200
;;
;;pToken := Gdip_Startup()
;;pBitmap := Gdip_BitmapFromScreen("0|0|" A_ScreenWidth "|" A_ScreenHeight)
;pBitmap := Gdip_BitmapFromHWND(WinActive("A"))
;;Gdip_SaveBitmapToFile(pBitmap, FilePath)
;;Gdip_DisposeImage(pBitmap)
;;Gdip_Shutdown(pToken)

;;Clipboard := "example.com/$" FileName

;;return


;;^/:: ;ctrl forward slash
;;run Explorer "C:\Users\tom\Desktop\Screenshots"
;;Return

;; '   ;;
;;!z:: ;alt z 
;;send {PrintScreen}
;;sleep, 2000
;;send ^d
;;Return

;; interferes with Biomenace in windows 3.1 ;;




/*
;;volume control;;;
^Up:: ;ctrl plus up arrow
sleep, 200
Send {Volume_Up}
Return

^Down:: ;ctrl plus down arrow
sleep, 200
Send {Volume_Down}
Return
*/

::linugist::linguist

::kindastrange::dͭoͪnͥˢ'tͥˢ ᵏyͥᶰoͩu ͦᶠtˢhͭiͬnͣᶰkᵍ
::strat::start
::amonsgt::amongst
::resumee::résumé
::resumees::résumés
::fcuk::fuck

;; ahkward soundboard ;;
::truef::Say "The words true and false are built-in constants containing 1 and 0. "
::kalibrate::Say "Testing 1, 2, 3, 4 ...  assay      ... calibrate      ... calibration       ... check something out       ... check up on somebody       ... crucible       ... experimental       ... experimentally       ... experimentation       ... experimenter       ... factorial       ... put out feelers       ... put somebody or something through their paces       ... put something to the test       ... road test       ... screening       ... spot check       ... spy out the land       ... try something out "

;; Symbols ;;

;------------------------------------------------------------------------------
; Science/engineering
;------------------------------------------------------------------------------
; Resistances using Greek uppercase omega character, not 
; Unicode ohm sign (which only exists for backwards compatibility)
;:c1*:ohm::Ω ; 
;;::ohm::Ω ; not useful ;; just use "omega"

::ooo::°
:*?:degC::°C ; degrees Celsius
:*?:degF::°F ; degrees Fahrenheit

:?*:+-::±		; plus-or-minus sign
:?:|-::−		; true minus sign
:?:|minus::−	; true minus sign
:?:|x::×		; true times sign
:?:|times::×
::divby::÷  ; division sign or obelus
;; ::./.::÷    ; any conflicts? -- yes. can't do cd ../.. it does cd .÷.

:?:|*::⋅		; "dot operator" (&sdot;), for multiplication, dot product

; sdot   ⋅ U+22C5 HTMLsymbol dot operator ('dot operator' is NOT the same character as U+00B7 'middle dot'.)

; Experimental: Multiply by
:?:1x::1×
:?:2x::2×
:?:3x::3×
:?:4x::4×
:?:5x::5×
:?:6x::6×
:?:7x::7×
:?:8x::8×
:?:9x::9×

; "Unicode also includes a handful of vulgar fractions as compatibility characters, but discourages their use."
::|1/2::½
::|1/4::¼
::|3/4::¾


::|>=::≥   ; '>=' conflicts with usage in programming.  Alternatively, it could specify different rules for code windows.
::|<=::≤
::|!=::≠ ; not equal to
::|>>::≫ ; much greater than
::|<<::≪ ; much less than
::|!=::≠
::notequal::≠
::approx::≈ ; approximately equal to
::asymp::≈
::|~::≈
::|propto::∝ ; proportional to
::|=-::≡     ; mathematical identity
::|===::≡
::|propersubset::⊂    ;	SUBSET OF
::|propersuperset::⊃	;	SUPERSET OF
::|notsubset::⊄	;	NOT A SUBSET OF
::|subset::⊆	;	SUBSET OF OR EQUAL TO
::|superset::⊇	;	SUPERSET OF OR EQUAL TO 

; superscripts and subscripts from HTML entity names sup2 and sup3
; Examples: km² V₊ V₋ CuSO₄·5H₂O or ²³⁸U (hard to type, ugly, but actually used, according to Google)
; Alternate notation: x^2 → x², x_2 → x₂
; Of course, that would conflict with programming variable names like max_3
; There's also ⁼⁽⁾₌₍₎ᵃᵇᶜᵈᵉᶠᵍʰⁱʲᵏˡᵐⁿᵒᵖʳˢᵗᵘᵛʷˣʸᶻᴬᴮᴰᴱᴳᴴᴵᴶᴷᴸᴹᴺᴼᴾᴿᵀᵁⱽᵂₐₑₕᵢₖₗₘₙₒₚᵣₛₜᵤᵥₓᵅᵝᵞᵟᵋᶿᶥᶲᵠᵡᵦᵧᵨᵩᵪ

::special scripts::⁼⁽⁾₌₍₎ᵃᵇᶜᵈᵉᶠᵍʰⁱʲᵏˡᵐⁿᵒᵖʳˢᵗᵘᵛʷˣʸᶻᴬᴮᴰᴱᴳᴴᴵᴶᴷᴸᴹᴺᴼᴾᴿᵀᵁⱽᵂₐₑₕᵢₖₗₘₙₒₚᵣₛₜᵤᵥₓᵅᵝᵞᵟᵋᶿᶥᶲᵠᵡᵦᵧᵨᵩᵪ

:?:sup0::⁰
:?:sup1::¹
:?:sup2::² ; common
:?:sup3::³ ; common
:?:sup4::⁴
:?:sup5::⁵
:?:sup6::⁶
:?:sup7::⁷
:?:sup8::⁸
:?:sup9::⁹
:?:sup+::⁺
:?:sup-::⁻
:?:supn::ⁿ
:?:supi::ⁱ

:?:sub0::₀
:?:sub1::₁
:?:sub2::₂
:?:sub3::₃
:?:sub4::₄
:?:sub5::₅
:?:sub6::₆
:?:sub7::₇
:?:sub8::₈
:?:sub9::₉
:?:sub+::₊
:?:sub-::₋

::square!::√ ; square root
::infinity!::∞

;; α β γ δ ε ζ η θ ι κ λ μ ν ξ ο ψ χ ω

/*
; Greek characters for math, etc.
:C:Alpha::Α
:C:Beta::Β
:C:Gamma::Γ
:C:Delta::Δ
:C:Epsilon::Ε
:C:Zeta::Ζ
:C:Eta::Η
:C:Theta::Θ
:C:Iota::Ι
:C:Kappa::Κ
:C:Lambda::Λ
:C:Mu::Μ
:C:Nu::Ν
:C:Xi::Ξ
:C:Omicron::Ο
:C:Pi::Π
:C:Rho::Ρ
:C:Sigma::Σ
:C:Tau::Τ
:C:Upsilon::Υ
:C:Phi::Φ
:C:Chi::Χ
:C:Psi::Ψ
:C:Omega::Ω
:C:alpha::α
:C:beta::β
:C:gamma::γ
:C:delta::δ
:C:epsilon::ε
:C:zeta::ζ
:C:eta::η
:C:theta::θ
:C:iota::ι
:C:kappa::κ
:C:lambda::λ
:C:mu::μ
:C:nu::ν
:C:xi::ξ
:C:omicron::ο
:C?:pi::π
:C:rho::ρ
:C:sigmaf::ς
:C:sigma::σ
:C:tau::τ
:C:upsilon::υ
:C:phi::φ 
:C:chi::χ 
:C:psi::ψ 
:C:omega::ω 
:C:thetac::ϑ  
:C:upsih::ϒ 
:C:piv::ϖ
*/

;------------------------------------------------------------------------------
; Typography / symbols
;------------------------------------------------------------------------------
::|c::©   ; copyright symbol
::(c)::©
::|r::®   ; registered symbol
::(r)::®
::|s::§   ; section symbol
::(tm)::™ ; trademark symbol
 
;; ○ ● ● ○ ○ ● ● ○ circles
::a little black dot::• ; a bullet
::fcirc::● ; filled circle
::hcirc::○ ; hollow circle


; Arrows
:?*:-->::→
:?*:==>::⇒
:?*:<--::←
:?*:<==::⇐
:?*:<->::↔
:?*:<=>::⇔
::|^::↑
::|v::↓

;------------------------------------------------------------------------------
; HTML shortcuts
;------------------------------------------------------------------------------
:*b0:|bq::{bs 3}<blockquote></blockquote>{left 13}
; :*:|bq::<blockquote>
:*:|/bq::</blockquote>
:*:|\bq::</blockquote>

:*b0:|qu::{bs 3}[QUOTE][/QUOTE]{left 8}
:*:|/qu::[/QUOTE]
:*:|\qu::[/QUOTE]

:*b0:<em>::</em>{left 5}

;; test this someday ;;

;t_str = 
;(
;a test
;another 
;test
;)
;msgbox % t_str
;------------------------------------------------------------------------------
; Insert timestamp 2021-12-30 07:44:19 PM - works
;------------------------------------------------------------------------------
; Should be a keyboard shortcut or a phrase?
; Needs to be compatible with spreadsheet formats

;; 2022-02-18 09:30:26 AM still works
+!t:: ;Shift-Alt-D: Insert current date and time stamp
FormatTime, T, %A_Now%, yyyy-MM-dd hh:mm:ss tt ; 2012-01-24 10:54:31 PM - works in LibreOffice, Google Spreadsheet, Excel
SendInput %T%
return

::thedate:: ;Insert current date
FormatTime, T, %A_Now%, yyyy-MM-dd ; 2011-07-25
SendInput %T%
return

::thetime:: ;Insert current time
FormatTime, T, %A_Now%, hh:mm:sstt ; 09:24:20AM
SendInput %T%
return

;------------------------------------------------------------------------------
; Make windows transparent
;------------------------------------------------------------------------------
#T::
DetectHiddenWindows, on
WinGet, curtrans, Transparent, A
if ! curtrans
	curtrans = 255
newtrans := curtrans - 64
if newtrans > 0
{
	WinSet, Transparent, %newtrans%, A

}
else
{
	WinSet, Transparent, 255, A
	WinSet, Transparent, OFF, A
}
return

#w:: ;; darken ??
DetectHiddenWindows, on
WinSet, TransColor, Black 128, A
return

#o:: ;; or control+0 with glas2k
WinSet, Transparent, 255, A
WinSet, Transparent, OFF, A
return


;; useful but I can't seem to make it go away afterward ;;

;#g::  ; Press Win+G to show the current settings of the window under the mouse.
;MouseGetPos,,, MouseWin
;WinGet, Transparent, Transparent, ahk_id %MouseWin%
;WinGet, TransColor, TransColor, ahk_id %MouseWin%
;ToolTip Translucency:`t%Transparent%`nTransColor:`t%TransColor%
;WinGet, ActiveControlList, ControlList, A
; Loop, Parse, ActiveControlList, `n
;{
;    MsgBox, 4,, Control #%A_Index% is "%A_LoopField%". Continue?
;    IfMsgBox, No
;        break
;}
;return


;; notes on hotstring helper ;; hostringsh

::winh::Hotstring Helper

;; ahk parameters ;;

::ahkpar::
(
NumParams = %0%
Param1 = %1%
Param2 = %2%
Param3 = %3%
MsgBox NumParams = %0%
MsgBox Param1 = %1%
MsgBox Param2 = %2%
MsgBox Param3 = %3%
)

::newscript::
(
#NoTrayIcon              ;if you don't want a tray icon for this AutoHotkey program.
#NoEnv                   ;Recommended for performance and compatibility with future AutoHotkey releases.
#SingleInstance force    ;Skips the dialog box and replaces the old instance automatically
;;SendMode Input           ;I discovered this causes MouseMove to jump as if Speed was 0. (was Recommended for new scripts due to its superior speed and reliability.)
SetKeyDelay, 90          ;Any number you want (milliseconds)
CoordMode,Mouse,Screen   ;Initial state is Relative
CoordMode,Pixel,Screen   ;Initial state is Relative. Frustration awaits if you set Mouse to Screen and then use GetPixelColor because you forgot this line. There are separate ones for: Mouse, Pixel, ToolTip, Menu, Caret
MouseGetPos, xpos, ypos  ;Save initial position of mouse
WinGet, SavedWinId, ID, A     ;Save our current active window

;Set Up a Log File:
SetWorkingDir, %A_ScriptDir%  ;Set default directory to where this script file is located. (Note %% because it's expecting and unquoted string)
LogFile := "MyLog.txt"
FileAppend,    ``n, %LogFile%  ;     ````. (Note %% because it's expecting an unquoted string)
)


;; Source for easy peasy
; added this from the command line, source -- internet -- A few functions comes out of the box to help us with Lists:head returns the first element and last the last one (be careful, it is not tail, tail will give you the whole list minus the first element). Then length  returns the number of elements in the list. Easy peasy.

;; enyay spanish ;;
:*:~n::ñ

::Anything below h::Anything below this point was added to the script by the user via the Win+H hotkey.
::catually::actually
::antything::anything
::aynthing::anything
::concat::concatenate
::ep::Easy peasy. 
::owrks::works
::exit90::exit()
::xx::exit()
::exiut::exit
::pygrame::pygame
::exitt::exit
::exti::exit
::godda::got to
::hh::Hotstring Helper`rAndreas Borutta suggested the following script, which might be useful if you are a heavy user of hotstrings. By pressing Win+H (or another hotkey of your choice), the currently selected text can be turned into a hotstring. For example, if you have "by the way" selected in a word processor, pressing Win+H will prompt you for its abbreviation (e.g. btw) and then add the new hotstring to the script. It will then reload the script to activate the hotstring.
::specail::special