;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname QF_rpgLockpickingQuest_01004098 Extends Quest Hidden

;BEGIN ALIAS PROPERTY PlayerAlias
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_PlayerAlias Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_1
Function Fragment_1()
;BEGIN CODE
stop()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN AUTOCAST TYPE rpgLockpickingQuestScript
Quest __temp = self as Quest
rpgLockpickingQuestScript kmyQuest = __temp as rpgLockpickingQuestScript
;END AUTOCAST
;BEGIN CODE
kmyQuest.Init()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
