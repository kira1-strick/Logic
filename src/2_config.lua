--[[
============================================================
  [2] CONFIG v4.0
============================================================
]]

local Config = {
    ConfigVersion = 4,

    Combat = {
        AutoAttack = false, AutoRush = false, AutoFollow = false,
        KillAura = false, TargetLock = false, AutoHeal = false, AntiStun = false,
        AttackDelay = 0.35, RushDelay = 0.5, FollowDelay = 0.35,
        KillAuraRange = 20, HealThreshold = 30,
        FOVSize = 150, ShowFOV = true,
    },

    Spawn = { UnitSlot = 1, AutoSpawn = false },

    Visual = {
        Chams = false, ESPSupply = false, ESPCapture = false,
        ESPShowDistance = false, ESPHealth = false, ESPName = false,
        Fullbright = false, NoFog = false,
    },

    Teleport = {
        OffsetY = 5,
        EnemySupplyTarget = "AttackerSupply1",
        OwnerSupplyTarget = "DefenderSupply1",
    },

    Movement = {
        WalkSpeed = 16, EnableRunSpeed = false, Noclip = false,
        Fly = false, InfJump = false, FlySpeed = 60, JumpPower = 50,
    },

    Automation = {
        AutoSummon = false, SummonAmount = "1x", KeepGems = 0,
        AutoAscend = false, AutoEvolve = false, AutoReward = false, AutoDailyReward = false,
    },

    AfkFarm = { EnableFarm = false },

    Misc = { AutoJoinTeam = "none", AntiAFK = true },

    Config = { AutoSave = true },
}

-- ============================================================
-- PROSES LOAD CONFIG SAAT PERTAMA KALI JALAN
-- ============================================================
local CONFIG_FOLDER = "FlowHub_Configs"
local CONFIG_FILE = CONFIG_FOLDER .. "/config.json"

if readfile and isfile and isfile(CONFIG_FILE) then
    local ok, data = pcall(readfile, CONFIG_FILE)
    if ok and data and #data > 0 then
        local Http = game:GetService("HttpService")
        local ok2, decoded = pcall(function() return Http:JSONDecode(data) end)

        if ok2 and type(decoded) == "table" then
            local savedVersion = decoded.ConfigVersion or 1
            local currentVersion = Config.ConfigVersion or 4

            if savedVersion < currentVersion then
                -- Versi lama, hapus aja biar reset ke default
                pcall(function() delfile(CONFIG_FILE) end)
            else
                -- Merge config dari file ke tabel
                for category, values in pairs(decoded) do
                    if Config[category] and type(values) == "table" then
                        for key, val in pairs(values) do
                            if Config[category][key] ~= nil then
                                Config[category][key] = val
                            end
                        end
                    end
                end
            end
        end
    end
end

-- Simpan Default buat jaga-jaga kalau tombol Reset diklik
_G.STHAIN.DefaultConfig = table.clone(Config)

-- Export ke Global SETELAH config di-load
_G.STHAIN.Config = Config
