#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

;; Unicode Italic Letters Mapping
;; Lowercase
:*C:a::𝘢
:*C:b::𝘣
:*C:c::𝘤
:*C:d::𝘥
:*C:e::𝘦
:*C:f::𝘧
:*C:g::𝘨
:*C:h::𝘩
:*C:i::𝘪
:*C:j::𝘫
:*C:k::𝘬
:*C:l::𝘭
:*C:m::𝘮
:*C:n::𝘯
:*C:o::𝘰
:*C:p::𝘱
:*C:q::𝘲
:*C:r::𝘳
:*C:s::𝘴
:*C:t::𝘵
:*C:u::𝘶
:*C:v::𝘷
:*C:w::𝘸
:*C:x::𝘹
:*C:y::𝘺
:*C:z::𝘻

;; Uppercase
:*C:A::𝘈
:*C:B::𝘉
:*C:C::𝘊
:*C:D::𝘋
:*C:E::𝘌
:*C:F::𝘍
:*C:G::𝘎
:*C:H::𝘏
:*C:I::𝘐
:*C:J::𝘑
:*C:K::𝘒
:*C:L::𝘓
:*C:M::𝘔
:*C:N::𝘕
:*C:O::𝘖
:*C:P::𝘗
:*C:Q::𝘘
:*C:R::𝘙
:*C:S::𝘚
:*C:T::𝘛
:*C:U::𝘜
:*C:V::𝘝
:*C:W::𝘞
:*C:X::𝘟
:*C:Y::𝘠
:*C:Z::𝘡

;; Toggle script on and off with Alt + C
!c::Suspend