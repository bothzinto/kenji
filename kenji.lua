-- ===================================================
-- 1. LOAD UI LIBRARY (Fluent UI)
-- ===================================================
local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()

-- ===================================================
-- 2. CREATE WINDOW (Kenji Smos Hub [VIP])
-- ===================================================
local Window = Fluent:CreateWindow({
    Title = "Kenji Smos Hub [VIP] 🥚",
    SubTitle = "Steal An Egg",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = true, 
    Theme = "Dark",
    
    -- VIP Key System
    KeySystem = true,
    KeySettings = {
        Title = "Kenji Smos VIP Key System",
        Subtitle = "បញ្ចូល VIP Key របស់អ្នក",
        Note = "VIP Key របស់អ្នកគឺ: KENJI_VIP_2026",
        FileName = "KenjiSmosVIPKey", 
        SaveKey = true,
        GrabKeyFromSite = false,
        Key = {"KENJI_VIP_2026"} -- ** VIP Key ស្រាប់ **
    }
})

-- ===================================================
-- 3. CREATE TABS
-- ===================================================
local Tabs = {
    Main = Window:AddTab({ Title = "Main Auto", Icon = "egg" }),
    Player = Window:AddTab({ Title = "Player", Icon = "user" }),
    Settings = Window:AddTab({ Title = "Settings", Icon = "settings" })
}

-- ===================================================
-- 4. FUNCTIONS & TOGGLES
-- ===================================================

-- --- TAB: MAIN AUTO ---
Tabs.Main:AddParagraph({
    Title = "Auto Steal System (VIP)",
    Content = "ស្វាគមន៍ Kenji Smos! ជ្រើសរើសមុខងារខាងក្រោមដើម្បីដំណើរការ"
})

local AutoSteal = false
local AutoHatch = false

-- Toggle: Auto Steal Egg
local StealToggle = Tabs.Main:AddToggle("AutoStealToggle", {Title = "Auto Steal Egg", Default = false })
StealToggle:OnChanged(function(Value)
    AutoSteal = Value
    task.spawn(function()
        while AutoSteal do
            task.wait(0.3)
            pcall(function()
                local Remote = game:GetService("ReplicatedStorage"):FindFirstChild("Events"):FindFirstChild("StealEgg")
                if Remote then
                    Remote:FireServer()
                end
            end)
        end
    end)
end)

-- Toggle: Auto Hatch
local HatchToggle = Tabs.Main:AddToggle("AutoHatchToggle", {Title = "Auto Hatch Eggs", Default = false })
HatchToggle:OnChanged(function(Value)
    AutoHatch = Value
    task.spawn(function()
        while AutoHatch do
            task.wait(0.8)
            pcall(function()
                local HatchRemote = game:GetService("ReplicatedStorage"):FindFirstChild("Events"):FindFirstChild("HatchEgg")
                if HatchRemote then
                    HatchRemote:FireServer()
                end
            end)
        end
    end)
end)

-- Button: Instant Teleport ទៅ Egg
Tabs.Main:AddButton({
    Title = "Teleport to Spawn Egg",
    Callback = function()
        pcall(function()
            local HRP = game.Players.LocalPlayer.Character.HumanoidRootPart
            if workspace:FindFirstChild("EggSpawn") then
                HRP.CFrame = workspace.EggSpawn.CFrame
            end
        end)
    end
})

-- --- TAB: PLAYER MODS ---
Tabs.Player:AddSlider("SpeedSlider", {
    Title = "WalkSpeed (ល្បឿនដើរ)",
    Default = 16,
    Min = 16,
    Max = 300,
    Rounding = 1,
    Callback = function(Value)
        pcall(function()
            game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
        end)
    end
})

Tabs.Player:AddSlider("JumpSlider", {
    Title = "JumpPower (កម្ពស់លោត)",
    Default = 50,
    Min = 50,
    Max = 400,
    Rounding = 1,
    Callback = function(Value)
        pcall(function()
            game.Players.LocalPlayer.Character.Humanoid.JumpPower = Value
        end)
    end
})

-- ===================================================
-- 5. NOTIFICATION
-- ===================================================
Fluent:Notify({
    Title = "Kenji Smos VIP",
    Content = "Script ដំណើរការដោយជោគជ័យ!",
    Duration = 5
})
