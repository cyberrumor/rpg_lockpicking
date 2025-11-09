;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname PRKF_rpgLockpickingPerk_01004095 Extends Perk Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akTargetRef, Actor akActor)
;BEGIN CODE
rpgLockpickingQuest.lockActivated(akTargetRef, akActor)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

rpgLockpickingQuestScript Property rpgLockpickingQuest  Auto
