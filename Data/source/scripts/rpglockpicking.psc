Scriptname rpgLockpicking

Function lockActivated(ObjectReference akTargetRef, Actor akActor, rpgLockpickingQuestScript lpq) global
    int locklevel = akTargetRef.getLockLevel();
    int lockindex = (((locklevel+25) / 25) - 1) as int;

    ; Already unlocked or requires key.
    if (locklevel > 100 || locklevel < 0)
        akTargetRef.activate(akActor, true);
        return;
    endif

    if (akActor.isInCombat() && !akActor.hasPerk(lpq.Quickhands))
        ; Don't open locked doors while in combat without quickhands.
        return;
    endif

    Form lockkey = akTargetRef.getKey();
    if (lockkey && akActor.getItemCount(lockkey) > 0)
        akTargetRef.activate(akActor, true);
        return;
    endif

    bool hasSkeletonKey = akActor.getItemCount(lpq.TG08SkeletonKey) > 0;
    bool hasLevelPerk = akActor.hasPerk(lpq.lockpickperks[lockindex]);

    int lockpick_count = akActor.getItemCount(lpq.Lockpick);
    int required_lockpicks = (lockindex + 1) * 2;

    ; locksmith causes us to consume two less lockpicks.
    bool hasSmithPerk = akActor.hasPerk(lpq.Locksmith);
    int consumed_lockpicks = required_lockpicks;
    if (hasSmithPerk)
        consumed_lockpicks = consumed_lockpicks - 2;
    endif

    ; picklevel should be utilized to later add 0 through picklevel gold to
    ; locked containers.
    ; int picklevel = akActor.getAV("lockpicking");
    ; Debug.Trace(picklevel, 2); requires string

    ; unbreakable causes us to consume no lockpicks, and require just 1.
    bool hasUnbreakablePerk = akActor.hasPerk(lpq.Unbreakable);
    if (hasUnbreakablePerk)
        required_lockpicks = 1;
        consumed_lockpicks = 0;
    endif

    bool failed = false;
    if (!hasSkeletonKey)
        if (lockpick_count < required_lockpicks)
            lpq.rpgLockpickingFailSound.play(akTargetRef);
            lpq.rpgLockpickingNoPickMessage.show();
            failed = true;
        elseif (!hasLevelPerk)
            lpq.rpgLockpickingFailSound.play(akTargetRef);
            lpq.rpgLockpickingNoPerkMessage.show();
            failed = true;
        endif
    endif

    ; The player tampered with a lock. If they don't have quick hands, emit a
    ; crime event.
    if (!akActor.hasPerk(lpq.Quickhands))
        akTargetRef.sendStealAlarm(akActor);
    endif

    ; Return early if the player didn't meet the lock's requirements.
    if (failed)
        return;
    endif

    ; The player met the lock's requirements. Unlock it.
    akTargetRef.lock(false);
    lpq.rpgLockpickingUnlockSound.play(akTargetRef);

    ; If the player has the Skeleton Key, they shouldn't benefit from XP gain
    ; or wax key. They should also ba ble to open any type of door that doesn't
    ; strictly require a key (E.g., puzzle doors etc), then return early.
    if (hasSkeletonKey)
        ; Quick hands should separate picking and opening
        if (!akActor.hasPerk(lpq.Quickhands))
            akTargetRef.activate(akActor, true);
        endif
        return;
    endif

    if (lockkey && akActor.hasPerk(lpq.WaxKey) && akActor.getItemCount(lockkey) < 1)
        akActor.AddItem(lockkey, 1, false);
    endif

    ; Handle xp gain. In vanilla, we get:
    ;   0.25 base XP for a broken pick.
    ;   2, 3, 5, 8, 13 base XP for successfully picking a lock. Fibonacci.
    ; Since we don't have a discrete event to break lockpicks, and since players
    ; won't be able to open every lock in every dungeon at low levels, we can
    ; add a bit more to Fibonacci compensate.
    float[] xp = new float[5];
    xp[0] = 2.0;
    xp[1] = 3.0;
    xp[2] = 5.0;
    xp[3] = 8.0;
    xp[4] = 13.0;
    float xp_gained = xp[lockindex] + (lockindex * 0.35);

    Game.advanceSkill("lockpicking", xp_gained);

    akActor.RemoveItem(lpq.Lockpick, consumed_lockpicks, false);

    ; Quickhands should separate picking and opening
    if (!akActor.hasPerk(lpq.Quickhands))
        ; Should we use abDefaultProcessingOnly = True here like the others?
        akTargetRef.activate(akActor);
    endif
EndFunction
