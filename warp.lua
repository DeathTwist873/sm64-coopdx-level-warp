-- warp_fixed.lua
-- SM64CoopDX Warp Anywhere Script (now with castle floor nicknames!)

local warp_callback = nil
function run_after_warp(func)
    warp_callback = func
end

hook_event(HOOK_ON_LEVEL_INIT, function()
    if warp_callback ~= nil then
        warp_callback()
        warp_callback = nil
    end
end)

-- Corrected level ID mapping
local level_map = {
    -- Main 15 courses
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
}

-- Castle floor nicknames
local castle_floors = {
    basement = { level = 6, area = 0 },
    f1       = { level = 6, area = 1 },
    f2       = { level = 6, area = 2 },
    f3       = { level = 6, area = 3 },
}

-- Warp function
function warp_to_any(level, act, area)
    local me = gMarioStates[0]

    -- check for floor nickname first
    local lower = string.lower(tostring(level))
    if castle_floors[lower] then
        local entry = castle_floors[lower]
        act  = tonumber(act) or 1
        area = entry.area
        warp_to_level(entry.level, area, act)
        run_after_warp(function() me.vel.x, me.vel.y, me.vel.z = 0,0,0 end)
        djui_chat_message_create(
            string.format("Warped to castle %s (area %d, act %d)", lower, area, act)
        )
        return
    end

    -- otherwise use normal level_map
    local key = lower
    local levelId = tonumber(level) or level_map[key]
    if not levelId then
        djui_chat_message_create("Unknown level: " .. tostring(level))
        return
    end

    act  = tonumber(act) or 1
    area = tonumber(area) or 1

    warp_to_level(levelId, area, act)

    run_after_warp(function() me.vel.x, me.vel.y, me.vel.z = 0,0,0 end)

    -- find shortcut name for nice display
    local name = key
    for k, v in pairs(level_map) do
        if v == levelId then name = k break end
    end

    djui_chat_message_create(
        string.format("Warped to %s (id %d), area %d, act %d", name, levelId, area, act)
    )
end

-- /warp <levelNameOrId> [act] [area]
hook_chat_command("warp", "Warp to any level (act=1, area=1 by default)", function(msg)
    local args = {}
    for word in string.gmatch(msg, "%S+") do table.insert(args, word) end

    if #args >= 1 then
        local level = args[1]
        local act   = args[2] or 1
        local area  = args[3] or 1
        warp_to_any(level, act, area)
    else
        djui_chat_message_create("Usage: /warp <levelNameOrId|basement|f1|f2|f3> [act] [area]")
    end
    return true
end)

-- /levels command
hook_chat_command("levels", "List available level names", function()
    djui_chat_message_create("Available level shortcuts:")
    local line, count = "", 0
    for name, id in pairs(level_map) do
        line = line .. name .. " "
        count = count + 1
        if count % 8 == 0 then
            djui_chat_message_create(line)
            line = ""
        end
    end
    if line ~= "" then djui_chat_message_create(line) end

    djui_chat_message_create("Castle floors: basement f1 f2 f3")
    return true
end)
