Scriptname rpgLockpickingLoadScript extends ReferenceAlias

rpgLockpickingQuestScript Property rpgLockpickingQuest Auto

Event OnPlayerLoadGame()
    Debug.Trace("rpglockpickingloadscript.OnPlayerLoadGame was called", 2)
    rpgLockpickingQuest.doUpdate();
EndEvent
