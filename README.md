# sm64-coopdx-level-warp
A Lua script mod for SM64 CoopDX that enables multiplayer peer-to-peer level warping and verified game-state stability.
  
```
  ---Main 15 courses
bob = 9,    wf  = 24,   ccm = 5,
jrb = 12,   bbh = 4,    lll = 22,
ssl = 8,    hmc = 7,    ddd = 23,
ttm = 36,   wdw = 11,   thi = 13,
sl  = 10,   ttc = 14,   rr  = 15,

-- Bonus stages
pss   = 27, mc    = 28, wcap  = 29,
vc    = 18, sa    = 20, wmotr = 31,
-- Bowser stages
bowser1 = 17, bowser2 = 19, bowser3 = 21,
-- Castle areas (shortcuts only)
cg = 16, -- Castle Grounds
cc = 26, -- Castle Courtyard
ci = 6,  -- Castle Interior (multi-floor)
-- Castle floor nicknames
local castle_floors = {
basement = { level = 6, area = 0 },
f1       = { level = 6, area = 1 },
f2       = { level = 6, area = 2 },
f3       = { level = 6, area = 3 },
```
 How to Use

This mod registers two custom chat commands inside the game to allow instant warping.

1. The /warp Command

Use this command to instantly teleport your character. If you do not specify an act or area, they default to 1.
Command Syntax: /warp [LevelName_or_ID] [Act_Number] [Area_Number]


◦ Examples of Usage:

Warping to a Main Course: /warp bob 2 Teleports you directly to Bob-omb Battlefield (Course 1), Act 2
Warping to a Bowser Stage: /warp bowser1 Teleports you directly to Bowser in the Dark World.
Warping using a Castle Floor Nickname: /warp basement Teleports you instantly to the Castle Basement area.
Warping to a Specific Area/Act: /warp cc 1 1 Teleports you to the Castle Courtyard.

2. The /levels Command

If you ever forget a level shortcut while in-game, you can view the entire registry directly in the chat window.
Command Syntax: /levels
‣ Result: Displays an organized list of all 21+ supported short-code names (like wf, ccm , 111) along with the specific castle floor nicknames ( basement, f1, f2, f3).

Technical QA Notes (For Reviewers)

Velocity Reset: The script hooks into HOoK_ON_LEVEL_INI to automatically reset the player's velocity vectors ( me.vel.x, me.vel.y, me.vel.z = 0,0,0) immediately after a warp completes. This prevents "momentum carry-over  bugs that cause players to instantly fall or fly to their death upon spawning into a new map level.





How to Use
​This mod registers two custom chat commands inside the game to allow instant warping.
​1. The /warp Command
​Use this command to instantly teleport your character. If you do not specify an act or area, they default to 1.
​Command Syntax: /warp [LevelName_or_ID] [Act_Number] [Area_Number]
​Examples of Usage:
​Warping to a Main Course: /warp bob 2 Teleports you directly to Bob-omb Battlefield (Course 1), Act 2.
​Warping to a Bowser Stage: /warp bowser1 Teleports you directly to Bowser in the Dark World.
​Warping using a Castle Floor Nickname: /warp basement Teleports you instantly to the Castle Basement area.
​Warping to a Specific Area/Act: /warp cc 1 1 Teleports you to the Castle Courtyard.
​2. The /levels Command
​If you ever forget a level shortcut while in-game, you can view the entire registry directly in the chat window.
​Command Syntax: /levels
​Result: Displays an organized list of all 21+ supported short-code names (like wf, ccm, lll) along with the specific castle floor nicknames (basement, f1, f2, f3).
​Technical QA Notes (For Reviewers)
​Velocity Reset: The script hooks into HOOK_ON_LEVEL_INIT to automatically reset the player's velocity vectors (m.vel.x, m.vel.y, m.vel.z = 0,0,0) immediately after a warp completes. This prevents "momentum carry-over" bugs that cause players to instantly fall or fly to their death upon spawning into a new map level.
