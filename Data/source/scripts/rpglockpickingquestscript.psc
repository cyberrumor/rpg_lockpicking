Scriptname rpgLockpickingQuestScript extends Quest

Message Property rpgLockpickingNoPerkMessage Auto
Message Property rpgLockpickingNoPickMessage Auto
MiscObject Property Lockpick Auto
MiscObject Property TG08SkeletonKey Auto
Perk Property Locksmith Auto
Perk Property QuickHands Auto
Perk Property Unbreakable Auto
Perk Property WaxKey Auto
Perk Property rpgLockpickingPerk Auto
; The novice through master perks
Perk[] Property lockpickperks Auto
Sound Property rpgLockpickingFailSound Auto
Sound Property rpgLockpickingUnlockSound Auto

Function init()
    setStage(1);
    version = 0;
    DoUpdate();
    Game.getPlayer().addPerk(rpgLockpickingPerk);
EndFunction

int version;
Function DoUpdate() ;For handling future updates
    if(version >= 0)
        init();
    endif
EndFunction

Function uninstall() ;Stop this from running
    version = -1;
    Game.getPlayer().removePerk(rpgLockpickingPerk);
    setStage(2);
EndFunction

Function lockActivated(ObjectReference akTargetRef, Actor akActor)
    rpgLockpicking.lockActivated(akTargetRef, akActor, self);
EndFunction
