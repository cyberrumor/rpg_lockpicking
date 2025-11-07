# rpg_lockpicking

Lockpicking overhaul for Skyrim SE


# Credits

This mod utilizes the same high level implementation as
[Randomized Lockpicking][] version 1 by [cjdeakin][]:
- Use a perk with an effect of type _Entry Point_. The perk has an effect. The
  effect data adds an activate choice that replaces the default activate choice.
  The activate choice we added runs a script. This is how The Tower doomstone
  power works as well. The Tower would add its perk to a player upon activating
  the doomstone, while we will use a quest's init script to add our perk to the
  player.
- Use the quest to get handles on arbitrary objects from the CK, which we can
  pass into our quest's main script.
- Make the quest script expose a new lockActivated function that shares the
  vanilla lockActivated function interface that's expected by the activate
  action from the effect, but it has access to arbitrary properties that we
  can pass in via the CK.
- The combined result is that the quest script's lockActivated function has
  access to whatever data we want, and can execute whatever lockpicking behavior
  we want.

Thanks [cjdeakin][] for creating [Randomized Lockpicking][].

[Randomized Lockpicking]: https://www.nexusmods.com/skyrimspecialedition/mods/3184
[cjdeakin]: https://www.nexusmods.com/skyrimspecialedition/users/1606468
