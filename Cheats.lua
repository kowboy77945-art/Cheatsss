--[[
    ██╗███╗   ███╗██████╗ ███████╗██████╗ ██╗██╗   ██╗███╗   ███╗
    ██║████╗ ████║██╔══██╗██╔════╝██╔══██╗██║██║   ██║████╗ ████║
    ██║██╔████╔██║██████╔╝█████╗  ██████╔╝██║██║   ██║██╔████╔██║
    ██║██║╚██╔╝██║██╔═══╝ ██╔══╝  ██╔══██╗██║██║   ██║██║╚██╔╝██║
    ██║██║ ╚═╝ ██║██║     ███████╗██║  ██║██║╚██████╔╝██║ ╚═╝ ██║
    ╚═╝╚═╝     ╚═╝╚═╝     ╚══════╝╚═╝  ╚═╝╚═╝ ╚═════╝ ╚═╝     ╚═╝
    
    Imperium v3.0 — CompKiller UI
    Full Cheat Suite | Mobile & Desktop
]]

-- ═══════════════════════════════════════════
-- SERVICES
-- ═══════════════════════════════════════════
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local StarterGui = game:GetService("StarterGui")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local GuiService = game:GetService("GuiService")
local VirtualInputManager = game:GetService("VirtualInputManager")
local HttpService = game:GetService("HttpService")

local Camera = Workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

-- ═══════════════════════════════════════════
-- SETTINGS
-- ═══════════════════════════════════════════
local Settings = {
    -- Aimbot
    AimbotEnabled = false,
    AimPart = "Head",
    AimFOV = 150,
    AimSmoothing = 6,
    TeamCheck = false,
    WallCheck = false,
    TargetMode = "Closest",
    ShowFOV = true,
    AimLock = false,
    AimLockTarget = nil,
    StickyAim = false,
    PredictionEnabled = false,
    PredictionX = 0.12,
    PredictionY = 0.12,
    PredictionZ = 0.12,
    AutoShoot = false,
    
    -- Silent Aim
    SilentAim = false,
    SilentAimPart = "Head",
    SilentAimFOV = 200,
    SilentAimChance = 100,
    
    -- Triggerbot
    TriggerbotEnabled = false,
    TriggerbotDelay = 50,
    TriggerbotFOV = 50,
    
    -- ESP
    ESPEnabled = false,
    ESPBoxes = false,
    ESPNames = true,
    ESPHealth = true,
    ESPDistance = true,
    ESPTracers = false,
    ESPChams = false,
    ESPArmorBar = false,
    ESPWeaponName = false,
    ESPHeadDot = false,
    ESPMaxDistance = 2500,
    ESPTeamCheck = false,
    ESPBoxType = "2D",
    TracerOrigin = "Bottom",
    ChamsTransparency = 0.5,
    ChamsFillColor = Color3.fromRGB(255, 0, 80),
    ChamsOutlineColor = Color3.fromRGB(255, 255, 255),
    
    -- Player
    Speed = 16,
    SpeedEnabled = false,
    JumpPower = 50,
    JumpEnabled = false,
    InfiniteJump = false,
    Fly = false,
    FlySpeed = 80,
    Noclip = false,
    Gravity = 196.2,
    GravityEnabled = false,
    FOVChanger = false,
    FOVValue = 70,
    
    -- Character
    HipHeight = 0,
    HipHeightEnabled = false,
    NoSlowdown = false,
    AntiRagdoll = false,
    AntiKnockback = false,
    
    -- Visuals
    Fullbright = false,
    NoFog = false,
    NoParticles = false,
    NoShadows = false,
    TimeChanger = false,
    TimeValue = 14,
    Atmosphere = false,
    
    -- Crosshair
    CrosshairEnabled = false,
    CrosshairSize = 12,
    CrosshairThickness = 2,
    CrosshairGap = 4,
    CrosshairColor = Color3.fromRGB(255, 50, 50),
    CrosshairDot = false,
    CrosshairOutline = true,
    
    -- Misc
    AntiAFK = true,
    ChatSpam = false,
    ChatSpamMessage = "Imperium on top!",
    ChatSpamDelay = 3,
}

-- ═══════════════════════════════════════════
-- LOAD UI LIBRARY
-- ═══════════════════════════════════════════
local Compkiller = loadstring(game:HttpGet("https://raw.githubusercontent.com/4lpaca-pin/CompKiller/refs/heads/main/src/source.luau"))()

local Notifier = Compkiller.newNotify()

local ConfigManager = Compkiller:ConfigManager({
    Directory = "Imperium-Cheat",
    Config = "Imperium-Config"
})

Compkiller:Loader("rbxassetid://120245531583106", 2.5).yield()

local Window = Compkiller.new({
    Name = "IMPERIUM v3.0",
    Keybind = "LeftAlt",
    Logo = "rbxassetid://120245531583106",
    Scale = Compkiller.Scale.Window,
    TextSize = 15,
})

Notifier.new({
    Title = "IMPERIUM",
    Content = "Cheat suite loaded! Welcome, " .. LocalPlayer.Name,
    Duration = 8,
    Icon = "rbxassetid://120245531583106"
})

-- ═══════════════════════════════════════════
-- WATERMARK
-- ═══════════════════════════════════════════
local Watermark = Window:Watermark()

Watermark:AddText({
    Icon = "user",
    Text = LocalPlayer.Name,
})

Watermark:AddText({
    Icon = "shield",
    Text = "Imperium v3.0",
})

local TimeWM = Watermark:AddText({
    Icon = "timer",
    Text = "TIME",
})

local FpsWM = Watermark:AddText({
    Icon = "server",
    Text = "FPS: 60",
})

task.spawn(function()
    while task.wait(0.5) do
        pcall(function()
            TimeWM:SetText(Compkiller:GetTimeNow())
            local fps = math.floor(1 / RunService.RenderStepped:Wait())
            FpsWM:SetText("FPS: " .. fps)
        end)
    end
end)

-- ═══════════════════════════════════════════
-- DRAWING OBJECTS (FOV Circle, Crosshair)
-- ═══════════════════════════════════════════
local FOVCircle = nil
local CrosshairLines = {}
local CrosshairDotDraw = nil
local CrosshairOutlines = {}

pcall(function()
    FOVCircle = Drawing.new("Circle")
    FOVCircle.Thickness = 1.5
    FOVCircle.NumSides = 80
    FOVCircle.Filled = false
    FOVCircle.Transparency = 0.8
    FOVCircle.Color = Color3.fromRGB(255, 50, 50)
    FOVCircle.Visible = false
    FOVCircle.Radius = 150
    
    for i = 1, 4 do
        CrosshairOutlines[i] = Drawing.new("Line")
        CrosshairOutlines[i].Color = Color3.new(0, 0, 0)
        CrosshairOutlines[i].Thickness = 4
        CrosshairOutlines[i].Visible = false
    end
    
    for i = 1, 4 do
        CrosshairLines[i] = Drawing.new("Line")
        CrosshairLines[i].Color = Color3.fromRGB(255, 50, 50)
        CrosshairLines[i].Thickness = 2
        CrosshairLines[i].Visible = false
    end
    
    CrosshairDotDraw = Drawing.new("Circle")
    CrosshairDotDraw.Filled = true
    CrosshairDotDraw.NumSides = 16
    CrosshairDotDraw.Color = Color3.fromRGB(255, 50, 50)
    CrosshairDotDraw.Radius = 2
    CrosshairDotDraw.Visible = false
end)

-- ═══════════════════════════════════════════
-- ESP OBJECTS
-- ═══════════════════════════════════════════
local ESPObjects = {}
local ESPHighlights = {}

local function ClearESP(player)
    if ESPObjects[player] then
        for _, obj in pairs(ESPObjects[player]) do
            pcall(function() obj:Remove() end)
        end
        ESPObjects[player] = nil
    end
    if ESPHighlights[player] then
        pcall(function() ESPHighlights[player]:Destroy() end)
        ESPHighlights[player] = nil
    end
end

local function CreateESP(player)
    if player == LocalPlayer then return end
    ClearESP(player)
    
    local esp = {}
    pcall(function()
        esp.BoxOutline = Drawing.new("Square")
        esp.BoxOutline.Thickness = 3
        esp.BoxOutline.Color = Color3.new(0, 0, 0)
        esp.BoxOutline.Filled = false
        esp.BoxOutline.Visible = false
        
        esp.Box = Drawing.new("Square")
        esp.Box.Thickness = 1.5
        esp.Box.Filled = false
        esp.Box.Visible = false
        
        esp.Name = Drawing.new("Text")
        esp.Name.Size = 13
        esp.Name.Center = true
        esp.Name.Outline = true
        esp.Name.Font = 2
        esp.Name.Visible = false
        
        esp.Distance = Drawing.new("Text")
        esp.Distance.Size = 12
        esp.Distance.Center = true
        esp.Distance.Outline = true
        esp.Distance.Font = 2
        esp.Distance.Visible = false
        
        esp.HealthBarBG = Drawing.new("Square")
        esp.HealthBarBG.Filled = true
        esp.HealthBarBG.Visible = false
        esp.HealthBarBG.Transparency = 0.5
        esp.HealthBarBG.Color = Color3.new(0, 0, 0)
        
        esp.HealthBar = Drawing.new("Square")
        esp.HealthBar.Filled = true
        esp.HealthBar.Visible = false
        
        esp.HealthText = Drawing.new("Text")
        esp.HealthText.Size = 10
        esp.HealthText.Center = false
        esp.HealthText.Outline = true
        esp.HealthText.Font = 2
        esp.HealthText.Visible = false
        
        esp.Tracer = Drawing.new("Line")
        esp.Tracer.Thickness = 1.5
        esp.Tracer.Visible = false
        
        esp.HeadDot = Drawing.new("Circle")
        esp.HeadDot.Filled = true
        esp.HeadDot.NumSides = 20
        esp.HeadDot.Visible = false
        esp.HeadDot.Color = Color3.fromRGB(255, 50, 50)
        
        esp.WeaponText = Drawing.new("Text")
        esp.WeaponText.Size = 11
        esp.WeaponText.Center = true
        esp.WeaponText.Outline = true
        esp.WeaponText.Font = 2
        esp.WeaponText.Visible = false
        esp.WeaponText.Color = Color3.fromRGB(200, 200, 200)
    end)
    
    ESPObjects[player] = esp
end

for _, player in ipairs(Players:GetPlayers()) do
    CreateESP(player)
end
Players.PlayerAdded:Connect(function(p)
    CreateESP(p)
end)
Players.PlayerRemoving:Connect(function(p)
    ClearESP(p)
end)

-- ═══════════════════════════════════════════
-- UTILITY FUNCTIONS
-- ═══════════════════════════════════════════
local function WorldToScreen(pos)
    local screenPos, onScreen = Camera:WorldToViewportPoint(pos)
    return Vector2.new(screenPos.X, screenPos.Y), onScreen, screenPos.Z
end

local function GetScreenCenter()
    local viewport = Camera.ViewportSize
    return Vector2.new(viewport.X / 2, viewport.Y / 2)
end

local function IsAlive(player)
    local char = player and player.Character
    if not char then return false end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hum or hum.Health <= 0 then return false end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return false end
    return true
end

local function IsVisible(origin, targetPos, ignoreList)
    local params = RaycastParams.new()
    params.FilterType = Enum.RaycastFilterType.Exclude
    params.FilterDescendantsInstances = ignoreList or {}
    params.IgnoreWater = true
    
    local direction = (targetPos - origin)
    local result = Workspace:Raycast(origin, direction, params)
    
    return result == nil
end

local function GetDistance3D(pos1, pos2)
    return (pos1 - pos2).Magnitude
end

local function GetTool(player)
    local char = player and player.Character
    if not char then return "None" end
    local tool = char:FindFirstChildOfClass("Tool")
    if tool then return tool.Name end
    return "None"
end

-- ═══════════════════════════════════════════
-- AIMBOT ENGINE
-- ═══════════════════════════════════════════
local AimTarget = nil
local AimLocked = false

local function GetBestTarget()
    local best = nil
    local bestValue = math.huge
    local screenCenter = GetScreenCenter()
    local mousePos = UserInputService:GetMouseLocation()
    local myChar = LocalPlayer.Character
    local myHRP = myChar and myChar:FindFirstChild("HumanoidRootPart")
    
    if not myHRP then return nil end
    
    local fov = Settings.AimFOV
    local candidates = {}
    
    for _, player in ipairs(Players:GetPlayers()) do
        if player == LocalPlayer then continue end
        if not IsAlive(player) then continue end
        
        -- Team Check
        if Settings.TeamCheck and player.Team and LocalPlayer.Team and player.Team == LocalPlayer.Team then
            continue
        end
        
        local char = player.Character
        local aimPart = char:FindFirstChild(Settings.AimPart) or char:FindFirstChild("HumanoidRootPart")
        if not aimPart then continue end
        
        local targetPos = aimPart.Position
        
        -- Prediction
        if Settings.PredictionEnabled then
            local hrp = char:FindFirstChild("HumanoidRootPart")
            if hrp then
                targetPos = targetPos + Vector3.new(
                    hrp.AssemblyLinearVelocity.X * Settings.PredictionX,
                    hrp.AssemblyLinearVelocity.Y * Settings.PredictionY,
                    hrp.AssemblyLinearVelocity.Z * Settings.PredictionZ
                )
            end
        end
        
        local screenPos, onScreen = WorldToScreen(targetPos)
        if not onScreen then continue end
        
        -- FOV центр экрана
        local distToCenter = (screenCenter - screenPos).Magnitude
        if distToCenter > fov then continue end
        
        -- Wall Check
        if Settings.WallCheck then
            local camPos = Camera.CFrame.Position
            local ignoreList = {myChar, Camera}
            if not IsVisible(camPos, targetPos, ignoreList) then
                continue
            end
        end
        
        local hum = char:FindFirstChildOfClass("Humanoid")
        local dist3D = GetDistance3D(myHRP.Position, aimPart.Position)
        
        table.insert(candidates, {
            Player = player,
            Character = char,
            Part = aimPart,
            ScreenPos = screenPos,
            DistToCenter = distToCenter,
            Distance3D = dist3D,
            HP = hum and hum.Health or 100,
            TargetPos = targetPos
        })
    end
    
    if #candidates == 0 then return nil end
    
    if Settings.TargetMode == "Closest" then
        for _, c in ipairs(candidates) do
            if c.DistToCenter < bestValue then
                bestValue = c.DistToCenter
                best = c
            end
        end
    elseif Settings.TargetMode == "Nearest" then
        for _, c in ipairs(candidates) do
            if c.Distance3D < bestValue then
                bestValue = c.Distance3D
                best = c
            end
        end
    elseif Settings.TargetMode == "Lowest HP" then
        for _, c in ipairs(candidates) do
            if c.HP < bestValue then
                bestValue = c.HP
                best = c
            end
        end
    elseif Settings.TargetMode == "Highest HP" then
        bestValue = 0
        for _, c in ipairs(candidates) do
            if c.HP > bestValue then
                bestValue = c.HP
                best = c
            end
        end
    elseif Settings.TargetMode == "Random" then
        best = candidates[math.random(1, #candidates)]
    end
    
    return best
end

-- ═══════════════════════════════════════════
-- FLY SYSTEM
-- ═══════════════════════════════════════════
local FlyBV, FlyBG = nil, nil
local Flying = false

local function StartFly()
    local char = LocalPlayer.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hrp or not hum then return end
    
    Flying = true
    hum.PlatformStand = true
    
    FlyBV = Instance.new("BodyVelocity")
    FlyBV.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
    FlyBV.Velocity = Vector3.new(0, 0, 0)
    FlyBV.Parent = hrp
    
    FlyBG = Instance.new("BodyGyro")
    FlyBG.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
    FlyBG.D = 200
    FlyBG.P = 40000
    FlyBG.Parent = hrp
end

local function StopFly()
    Flying = false
    local char = LocalPlayer.Character
    if char then
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then hum.PlatformStand = false end
    end
    if FlyBV then pcall(function() FlyBV:Destroy() end) FlyBV = nil end
    if FlyBG then pcall(function() FlyBG:Destroy() end) FlyBG = nil end
end

-- ═══════════════════════════════════════════
-- TABS & UI
-- ═══════════════════════════════════════════

-- ══ CATEGORY: Combat ══
Window:DrawCategory({Name = "Combat"})

-- ═══ AIMBOT TAB ═══
local AimbotTab = Window:DrawTab({
    Name = "Aimbot",
    Icon = "crosshair",
    EnableScrolling = true
})

-- Left Section: Main Aimbot
local AimbotMain = AimbotTab:DrawSection({
    Name = "Aimbot",
    Position = "left"
})

local AimbotToggle = AimbotMain:AddToggle({
    Name = "Enable Aimbot",
    Flag = "AimbotEnabled",
    Default = false,
    Callback = function(v)
        Settings.AimbotEnabled = v
        if not v then
            AimTarget = nil
            AimLocked = false
        end
    end,
})

AimbotToggle.Link:AddKeybind({
    Default = "Q",
    Flag = "AimbotKeybind",
    Callback = function() end
})

AimbotToggle.Link:AddHelper({
    Text = "Hold RMB or press keybind to aim at target"
})

local AimLockToggle = AimbotMain:AddToggle({
    Name = "Aim Lock (Sticky)",
    Flag = "AimLock",
    Default = false,
    Callback = function(v)
        Settings.AimLock = v
        Settings.StickyAim = v
        if not v then
            AimLocked = false
            AimTarget = nil
        end
    end,
})

AimLockToggle.Link:AddHelper({
    Text = "Locks onto target until they die or you release"
})

AimbotMain:AddDropdown({
    Name = "Aim Part",
    Default = "Head",
    Flag = "AimPart",
    Values = {"Head", "HumanoidRootPart", "UpperTorso", "LowerTorso", "LeftUpperArm", "RightUpperArm"},
    Callback = function(v)
        Settings.AimPart = v
    end
})

AimbotMain:AddDropdown({
    Name = "Target Mode",
    Default = "Closest",
    Flag = "TargetMode",
    Values = {"Closest", "Nearest", "Lowest HP", "Highest HP", "Random"},
    Callback = function(v)
        Settings.TargetMode = v
    end
})

AimbotMain:AddSlider({
    Name = "FOV Size",
    Min = 10,
    Max = 600,
    Default = 150,
    Round = 0,
    Flag = "AimFOV",
    Callback = function(v)
        Settings.AimFOV = v
    end
})

AimbotMain:AddSlider({
    Name = "Smoothing",
    Min = 1,
    Max = 30,
    Default = 6,
    Round = 1,
    Flag = "AimSmoothing",
    Callback = function(v)
        Settings.AimSmoothing = v
    end
})

AimbotMain:AddToggle({
    Name = "Show FOV Circle",
    Flag = "ShowFOV",
    Default = true,
    Callback = function(v)
        Settings.ShowFOV = v
    end,
})

AimbotMain:AddToggle({
    Name = "Team Check",
    Flag = "AimTeamCheck",
    Default = false,
    Callback = function(v)
        Settings.TeamCheck = v
    end,
})

AimbotMain:AddToggle({
    Name = "Wall Check (Visibility)",
    Flag = "WallCheck",
    Default = false,
    Callback = function(v)
        Settings.WallCheck = v
    end,
})

-- Prediction Section
local PredSection = AimbotTab:DrawSection({
    Name = "Prediction / Velocity",
    Position = "left"
})

PredSection:AddToggle({
    Name = "Enable Prediction",
    Flag = "PredictionEnabled",
    Default = false,
    Callback = function(v)
        Settings.PredictionEnabled = v
    end,
})

PredSection:AddSlider({
    Name = "Prediction X",
    Min = 0,
    Max = 50,
    Default = 12,
    Round = 0,
    Flag = "PredictionX",
    Callback = function(v)
        Settings.PredictionX = v / 100
    end
})

PredSection:AddSlider({
    Name = "Prediction Y",
    Min = 0,
    Max = 50,
    Default = 12,
    Round = 0,
    Flag = "PredictionY",
    Callback = function(v)
        Settings.PredictionY = v / 100
    end
})

PredSection:AddSlider({
    Name = "Prediction Z",
    Min = 0,
    Max = 50,
    Default = 12,
    Round = 0,
    Flag = "PredictionZ",
    Callback = function(v)
        Settings.PredictionZ = v / 100
    end
})

-- Right Section: Silent Aim
local SilentSection = AimbotTab:DrawSection({
    Name = "Silent Aim",
    Position = "right"
})

local SilentToggle = SilentSection:AddToggle({
    Name = "Enable Silent Aim",
    Flag = "SilentAim",
    Risky = true,
    Default = false,
    Callback = function(v)
        Settings.SilentAim = v
    end,
})

SilentToggle.Link:AddHelper({
    Text = "Redirects bullets to target without moving camera (risky)"
})

SilentSection:AddDropdown({
    Name = "Silent Aim Part",
    Default = "Head",
    Flag = "SilentAimPart",
    Values = {"Head", "HumanoidRootPart", "UpperTorso", "LowerTorso"},
    Callback = function(v)
        Settings.SilentAimPart = v
    end
})

SilentSection:AddSlider({
    Name = "Silent FOV",
    Min = 10,
    Max = 600,
    Default = 200,
    Round = 0,
    Flag = "SilentAimFOV",
    Callback = function(v)
        Settings.SilentAimFOV = v
    end
})

SilentSection:AddSlider({
    Name = "Hit Chance (%)",
    Min = 1,
    Max = 100,
    Default = 100,
    Round = 0,
    Flag = "SilentAimChance",
    Callback = function(v)
        Settings.SilentAimChance = v
    end
})

-- Triggerbot
local TriggerSection = AimbotTab:DrawSection({
    Name = "Triggerbot",
    Position = "right"
})

local TriggerToggle = TriggerSection:AddToggle({
    Name = "Enable Triggerbot",
    Flag = "TriggerbotEnabled",
    Risky = true,
    Default = false,
    Callback = function(v)
        Settings.TriggerbotEnabled = v
    end,
})

TriggerToggle.Link:AddHelper({
    Text = "Auto-clicks when crosshair is on an enemy"
})

TriggerSection:AddSlider({
    Name = "Trigger Delay (ms)",
    Min = 0,
    Max = 500,
    Default = 50,
    Round = 0,
    Flag = "TriggerbotDelay",
    Callback = function(v)
        Settings.TriggerbotDelay = v
    end
})

TriggerSection:AddSlider({
    Name = "Trigger FOV",
    Min = 5,
    Max = 200,
    Default = 50,
    Round = 0,
    Flag = "TriggerbotFOV",
    Callback = function(v)
        Settings.TriggerbotFOV = v
    end
})

-- Auto Shoot
local AutoSection = AimbotTab:DrawSection({
    Name = "Auto Shoot",
    Position = "right"
})

AutoSection:AddToggle({
    Name = "Auto Shoot on Lock",
    Flag = "AutoShoot",
    Risky = true,
    Default = false,
    Callback = function(v)
        Settings.AutoShoot = v
    end,
})

-- ═══ ESP TAB ═══
Window:DrawCategory({Name = "Visuals"})

local ESPTab = Window:DrawTab({
    Name = "ESP",
    Icon = "eye",
    EnableScrolling = true
})

-- Left: ESP Main
local ESPMain = ESPTab:DrawSection({
    Name = "Player ESP",
    Position = "left"
})

local ESPToggle = ESPMain:AddToggle({
    Name = "Enable ESP",
    Flag = "ESPEnabled",
    Default = false,
    Callback = function(v)
        Settings.ESPEnabled = v
    end,
})

ESPToggle.Link:AddHelper({
    Text = "Shows player information through walls"
})

ESPMain:AddToggle({
    Name = "Boxes",
    Flag = "ESPBoxes",
    Default = false,
    Callback = function(v)
        Settings.ESPBoxes = v
    end,
})

ESPMain:AddToggle({
    Name = "Names",
    Flag = "ESPNames",
    Default = true,
    Callback = function(v)
        Settings.ESPNames = v
    end,
})

ESPMain:AddToggle({
    Name = "Health Bar",
    Flag = "ESPHealth",
    Default = true,
    Callback = function(v)
        Settings.ESPHealth = v
    end,
})

ESPMain:AddToggle({
    Name = "Distance",
    Flag = "ESPDistance",
    Default = true,
    Callback = function(v)
        Settings.ESPDistance = v
    end,
})

ESPMain:AddToggle({
    Name = "Tracers",
    Flag = "ESPTracers",
    Default = false,
    Callback = function(v)
        Settings.ESPTracers = v
    end,
})

ESPMain:AddToggle({
    Name = "Head Dot",
    Flag = "ESPHeadDot",
    Default = false,
    Callback = function(v)
        Settings.ESPHeadDot = v
    end,
})

ESPMain:AddToggle({
    Name = "Weapon Name",
    Flag = "ESPWeaponName",
    Default = false,
    Callback = function(v)
        Settings.ESPWeaponName = v
    end,
})

-- Right: ESP Options
local ESPOptions = ESPTab:DrawSection({
    Name = "ESP Options",
    Position = "right"
})

ESPOptions:AddSlider({
    Name = "Max Distance",
    Min = 100,
    Max = 5000,
    Default = 2500,
    Round = 0,
    Flag = "ESPMaxDistance",
    Callback = function(v)
        Settings.ESPMaxDistance = v
    end
})

ESPOptions:AddToggle({
    Name = "ESP Team Check",
    Flag = "ESPTeamCheck",
    Default = false,
    Callback = function(v)
        Settings.ESPTeamCheck = v
    end,
})

ESPOptions:AddDropdown({
    Name = "Tracer Origin",
    Default = "Bottom",
    Flag = "TracerOrigin",
    Values = {"Bottom", "Center", "Top", "Mouse"},
    Callback = function(v)
        Settings.TracerOrigin = v
    end
})

-- Chams Section
local ChamsSection = ESPTab:DrawSection({
    Name = "Chams (Highlights)",
    Position = "right"
})

local ChamsToggle = ChamsSection:AddToggle({
    Name = "Enable Chams",
    Flag = "ESPChams",
    Default = false,
    Callback = function(v)
        Settings.ESPChams = v
        if not v then
            for player, hl in pairs(ESPHighlights) do
                pcall(function() hl:Destroy() end)
            end
            ESPHighlights = {}
        end
    end,
})

ChamsSection:AddSlider({
    Name = "Fill Transparency",
    Min = 0,
    Max = 100,
    Default = 50,
    Round = 0,
    Flag = "ChamsTransparency",
    Callback = function(v)
        Settings.ChamsTransparency = v / 100
    end
})

ChamsSection:AddColorPicker({
    Name = "Fill Color",
    Default = Color3.fromRGB(255, 0, 80),
    Flag = "ChamsFillColor",
    Callback = function(v)
        Settings.ChamsFillColor = v
    end
})

ChamsSection:AddColorPicker({
    Name = "Outline Color",
    Default = Color3.fromRGB(255, 255, 255),
    Flag = "ChamsOutlineColor",
    Callback = function(v)
        Settings.ChamsOutlineColor = v
    end
})

-- ═══ VISUALS TAB ═══
local VisualsTab = Window:DrawTab({
    Name = "Visuals",
    Icon = "palette",
    EnableScrolling = true
})

-- Left: Crosshair
local CrosshairSection = VisualsTab:DrawSection({
    Name = "Crosshair",
    Position = "left"
})

CrosshairSection:AddToggle({
    Name = "Custom Crosshair",
    Flag = "CrosshairEnabled",
    Default = false,
    Callback = function(v)
        Settings.CrosshairEnabled = v
    end,
})

CrosshairSection:AddSlider({
    Name = "Size",
    Min = 3,
    Max = 40,
    Default = 12,
    Round = 0,
    Flag = "CrosshairSize",
    Callback = function(v)
        Settings.CrosshairSize = v
    end
})

CrosshairSection:AddSlider({
    Name = "Thickness",
    Min = 1,
    Max = 6,
    Default = 2,
    Round = 0,
    Flag = "CrosshairThickness",
    Callback = function(v)
        Settings.CrosshairThickness = v
    end
})

CrosshairSection:AddSlider({
    Name = "Gap",
    Min = 0,
    Max = 25,
    Default = 4,
    Round = 0,
    Flag = "CrosshairGap",
    Callback = function(v)
        Settings.CrosshairGap = v
    end
})

CrosshairSection:AddToggle({
    Name = "Center Dot",
    Flag = "CrosshairDot",
    Default = false,
    Callback = function(v)
        Settings.CrosshairDot = v
    end,
})

CrosshairSection:AddToggle({
    Name = "Outline",
    Flag = "CrosshairOutline",
    Default = true,
    Callback = function(v)
        Settings.CrosshairOutline = v
    end,
})

CrosshairSection:AddColorPicker({
    Name = "Crosshair Color",
    Default = Color3.fromRGB(255, 50, 50),
    Flag = "CrosshairColor",
    Callback = function(v)
        Settings.CrosshairColor = v
    end
})

-- Right: World Visuals
local WorldSection = VisualsTab:DrawSection({
    Name = "World",
    Position = "right"
})

WorldSection:AddToggle({
    Name = "Fullbright",
    Flag = "Fullbright",
    Default = false,
    Callback = function(v)
        Settings.Fullbright = v
        if not v then
            Lighting.Brightness = 1
            Lighting.GlobalShadows = true
        end
    end,
})

WorldSection:AddToggle({
    Name = "No Fog",
    Flag = "NoFog",
    Default = false,
    Callback = function(v)
        Settings.NoFog = v
        if not v then
            Lighting.FogEnd = 100000
        end
    end,
})

WorldSection:AddToggle({
    Name = "No Shadows",
    Flag = "NoShadows",
    Default = false,
    Callback = function(v)
        Settings.NoShadows = v
        Lighting.GlobalShadows = not v
    end,
})

WorldSection:AddToggle({
    Name = "No Particles",
    Flag = "NoParticles",
    Default = false,
    Callback = function(v)
        Settings.NoParticles = v
    end,
})

WorldSection:AddToggle({
    Name = "Time Changer",
    Flag = "TimeChanger",
    Default = false,
    Callback = function(v)
        Settings.TimeChanger = v
    end,
})

WorldSection:AddSlider({
    Name = "Time of Day",
    Min = 0,
    Max = 24,
    Default = 14,
    Round = 1,
    Flag = "TimeValue",
    Callback = function(v)
        Settings.TimeValue = v
    end
})

WorldSection:AddToggle({
    Name = "FOV Changer",
    Flag = "FOVChanger",
    Default = false,
    Callback = function(v)
        Settings.FOVChanger = v
        if not v then
            Camera.FieldOfView = 70
        end
    end,
})

WorldSection:AddSlider({
    Name = "Camera FOV",
    Min = 30,
    Max = 120,
    Default = 70,
    Round = 0,
    Flag = "FOVValue",
    Callback = function(v)
        Settings.FOVValue = v
    end
})

-- ═══ PLAYER TAB ═══
Window:DrawCategory({Name = "Player"})

local PlayerTab = Window:DrawTab({
    Name = "Movement",
    Icon = "person-standing",
    EnableScrolling = true
})

-- Left: Movement
local MoveSection = PlayerTab:DrawSection({
    Name = "Speed & Jump",
    Position = "left"
})

local SpeedToggle = MoveSection:AddToggle({
    Name = "Speed Hack",
    Flag = "SpeedEnabled",
    Default = false,
    Risky = true,
    Callback = function(v)
        Settings.SpeedEnabled = v
        if not v then
            local char = LocalPlayer.Character
            if char then
                local hum = char:FindFirstChildOfClass("Humanoid")
                if hum then hum.WalkSpeed = 16 end
            end
        end
    end,
})

SpeedToggle.Link:AddKeybind({
    Default = "V",
    Flag = "SpeedKeybind",
    Callback = function() end
})

MoveSection:AddSlider({
    Name = "Walk Speed",
    Min = 16,
    Max = 500,
    Default = 16,
    Round = 0,
    Flag = "Speed",
    Callback = function(v)
        Settings.Speed = v
    end
})

local JumpToggle = MoveSection:AddToggle({
    Name = "Jump Hack",
    Flag = "JumpEnabled",
    Default = false,
    Risky = true,
    Callback = function(v)
        Settings.JumpEnabled = v
        if not v then
            local char = LocalPlayer.Character
            if char then
                local hum = char:FindFirstChildOfClass("Humanoid")
                if hum then hum.JumpPower = 50 end
            end
        end
    end,
})

MoveSection:AddSlider({
    Name = "Jump Power",
    Min = 50,
    Max = 500,
    Default = 50,
    Round = 0,
    Flag = "JumpPower",
    Callback = function(v)
        Settings.JumpPower = v
    end
})

MoveSection:AddToggle({
    Name = "Infinite Jump",
    Flag = "InfiniteJump",
    Default = false,
    Callback = function(v)
        Settings.InfiniteJump = v
    end,
})

MoveSection:AddToggle({
    Name = "Gravity Changer",
    Flag = "GravityEnabled",
    Default = false,
    Callback = function(v)
        Settings.GravityEnabled = v
        if not v then
            Workspace.Gravity = 196.2
        end
    end,
})

MoveSection:AddSlider({
    Name = "Gravity",
    Min = 0,
    Max = 500,
    Default = 196,
    Round = 0,
    Flag = "Gravity",
    Callback = function(v)
        Settings.Gravity = v
    end
})

-- Right: Fly & Noclip
local FlySection = PlayerTab:DrawSection({
    Name = "Fly & Noclip",
    Position = "right"
})

local FlyToggle = FlySection:AddToggle({
    Name = "Fly",
    Flag = "Fly",
    Default = false,
    Risky = true,
    Callback = function(v)
        Settings.Fly = v
        if v then
            StartFly()
        else
            StopFly()
        end
    end,
})

FlyToggle.Link:AddKeybind({
    Default = "F",
    Flag = "FlyKeybind",
    Callback = function() end
})

FlyToggle.Link:AddHelper({
    Text = "WASD to move, Space/Shift for up/down"
})

FlySection:AddSlider({
    Name = "Fly Speed",
    Min = 10,
    Max = 500,
    Default = 80,
    Round = 0,
    Flag = "FlySpeed",
    Callback = function(v)
        Settings.FlySpeed = v
    end
})

local NoclipToggle = FlySection:AddToggle({
    Name = "Noclip",
    Flag = "Noclip",
    Default = false,
    Risky = true,
    Callback = function(v)
        Settings.Noclip = v
    end,
})

NoclipToggle.Link:AddKeybind({
    Default = "N",
    Flag = "NoclipKeybind",
    Callback = function() end
})

NoclipToggle.Link:AddHelper({
    Text = "Walk through walls"
})

-- Character Section
local CharSection = PlayerTab:DrawSection({
    Name = "Character",
    Position = "right"
})

CharSection:AddToggle({
    Name = "Hip Height Changer",
    Flag = "HipHeightEnabled",
    Default = false,
    Callback = function(v)
        Settings.HipHeightEnabled = v
    end,
})

CharSection:AddSlider({
    Name = "Hip Height",
    Min = 0,
    Max = 100,
    Default = 0,
    Round = 0,
    Flag = "HipHeight",
    Callback = function(v)
        Settings.HipHeight = v
    end
})

CharSection:AddToggle({
    Name = "No Slowdown",
    Flag = "NoSlowdown",
    Default = false,
    Callback = function(v)
        Settings.NoSlowdown = v
    end,
})

-- ═══ MISC TAB ═══
Window:DrawCategory({Name = "Misc"})

local MiscTab = Window:DrawTab({
    Name = "Misc",
    Icon = "wrench",
    EnableScrolling = true
})

-- Left: Utilities
local UtilSection = MiscTab:DrawSection({
    Name = "Utilities",
    Position = "left"
})

UtilSection:AddToggle({
    Name = "Anti-AFK",
    Flag = "AntiAFK",
    Default = true,
    Callback = function(v)
        Settings.AntiAFK = v
    end,
})

UtilSection:AddButton({
    Name = "Rejoin Server",
    Callback = function()
        Notifier.new({
            Title = "IMPERIUM",
            Content = "Rejoining server...",
            Duration = 3,
            Icon = "rbxassetid://120245531583106"
        })
        task.wait(1)
        game:GetService("TeleportService"):Teleport(game.PlaceId, LocalPlayer)
    end,
})

UtilSection:AddButton({
    Name = "Copy Server Link",
    Callback = function()
        pcall(function()
            if setclipboard then
                setclipboard("roblox://experiences/start?placeId=" .. game.PlaceId .. "&gameInstanceId=" .. game.JobId)
                Notifier.new({
                    Title = "IMPERIUM",
                    Content = "Server link copied to clipboard!",
                    Duration = 3,
                    Icon = "rbxassetid://120245531583106"
                })
            end
        end)
    end,
})

UtilSection:AddButton({
    Name = "Reset Character",
    Callback = function()
        local char = LocalPlayer.Character
        if char then
            char:BreakJoints()
        end
    end,
})

UtilSection:AddButton({
    Name = "Server Hop",
    Callback = function()
        Notifier.new({
            Title = "IMPERIUM",
            Content = "Looking for another server...",
            Duration = 3,
            Icon = "rbxassetid://120245531583106"
        })
        pcall(function()
            local servers = HttpService:JSONDecode(
                game:HttpGet("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100")
            )
            for _, server in ipairs(servers.data) do
                if server.id ~= game.JobId and server.playing < server.maxPlayers then
                    game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, server.id, LocalPlayer)
                    break
                end
            end
        end)
    end,
})

-- Right: Chat / Fun
local FunSection = MiscTab:DrawSection({
    Name = "Fun / Chat",
    Position = "right"
})

FunSection:AddToggle({
    Name = "Chat Spam",
    Flag = "ChatSpam",
    Default = false,
    Risky = true,
    Callback = function(v)
        Settings.ChatSpam = v
    end,
})

FunSection:AddTextBox({
    Name = "Spam Message",
    Placeholder = "Enter message...",
    Default = "Imperium on top!",
    Callback = function(v)
        Settings.ChatSpamMessage = v
    end
})

FunSection:AddSlider({
    Name = "Spam Delay (sec)",
    Min = 1,
    Max = 30,
    Default = 3,
    Round = 0,
    Flag = "ChatSpamDelay",
    Callback = function(v)
        Settings.ChatSpamDelay = v
    end
})

FunSection:AddButton({
    Name = "TP to Random Player",
    Callback = function()
        local players = Players:GetPlayers()
        local others = {}
        for _, p in ipairs(players) do
            if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                table.insert(others, p)
            end
        end
        if #others > 0 then
            local target = others[math.random(1, #others)]
            local myChar = LocalPlayer.Character
            if myChar and myChar:FindFirstChild("HumanoidRootPart") then
                myChar.HumanoidRootPart.CFrame = target.Character.HumanoidRootPart.CFrame + Vector3.new(0, 3, 0)
                Notifier.new({
                    Title = "IMPERIUM",
                    Content = "Teleported to " .. target.Name,
                    Duration = 3,
                    Icon = "rbxassetid://120245531583106"
                })
            end
        end
    end,
})

FunSection:AddButton({
    Name = "Bring All Tools",
    Callback = function()
        pcall(function()
            local char = LocalPlayer.Character
            if char then
                for _, v in ipairs(LocalPlayer.Backpack:GetChildren()) do
                    if v:IsA("Tool") then
                        v.Parent = char
                    end
                end
            end
        end)
    end,
})

-- Info
local InfoSection = MiscTab:DrawSection({
    Name = "Information",
    Position = "right"
})

InfoSection:AddParagraph({
    Title = "IMPERIUM v3.0",
    Content = "Full Cheat Suite for Roblox\nMobile & Desktop Support\nPress Left Alt to toggle menu\n\nFeatures:\n• Aimbot + Silent Aim\n• Aim Lock (Sticky)\n• Triggerbot\n• Full ESP (Box/Name/HP/Dist/Tracer/Chams)\n• Head Dot + Weapon ESP\n• Crosshair (Custom)\n• Speed/Jump/Fly/Noclip\n• Gravity/HipHeight\n• FOV Changer\n• Fullbright/NoFog/NoShadows\n• Anti-AFK/Server Hop\n• Chat Spam + more"
})

-- ═══ SETTINGS TAB ═══
Window:DrawCategory({Name = "Settings"})

local SettingTab = Window:DrawTab({
    Icon = "settings",
    Name = "Settings",
    Type = "Single",
    EnableScrolling = true
})

local UISett = SettingTab:DrawSection({
    Name = "UI Settings",
})

UISett:AddToggle({
    Name = "Always Show Frame",
    Default = false,
    Callback = function(v)
        Window.AlwayShowTab = v
    end,
})

UISett:AddColorPicker({
    Name = "Accent Color",
    Default = Compkiller.Colors.Highlight,
    Callback = function(v)
        Compkiller.Colors.Highlight = v
        Compkiller:RefreshCurrentColor()
    end,
})

UISett:AddColorPicker({
    Name = "Toggle Color",
    Default = Compkiller.Colors.Toggle,
    Callback = function(v)
        Compkiller.Colors.Toggle = v
        Compkiller:RefreshCurrentColor(v)
    end,
})

UISett:AddButton({
    Name = "Get Theme Code",
    Callback = function()
        pcall(function()
            print(Compkiller:GetTheme())
            Notifier.new({
                Title = "IMPERIUM",
                Content = "Theme code printed to console",
                Duration = 5,
                Icon = "rbxassetid://120245531583106"
            })
        end)
    end,
})

-- Themes
local ThemeTab = Window:DrawTab({
    Icon = "paintbrush",
    Name = "Themes",
    Type = "Single"
})

ThemeTab:DrawSection({
    Name = "UI Themes"
}):AddDropdown({
    Name = "Select Theme",
    Default = "Default",
    Values = {
        "Default",
        "Dark Green",
        "Dark Blue",
        "Purple Rose",
        "Skeet"
    },
    Callback = function(v)
        Compkiller:SetTheme(v)
    end,
})

-- Config
local ConfigUI = Window:DrawConfig({
    Name = "Config",
    Icon = "folder",
    Config = ConfigManager
})
ConfigUI:Init()

-- ═══════════════════════════════════════════
-- MAIN RENDER LOOP
-- ═══════════════════════════════════════════
local holdingRMB = false
local lastTriggerShot = 0

UserInputService.InputBegan:Connect(function(input, processed)
    if processed then return end
    if input.UserInputType == Enum.UserInputType.MouseButton2 then
        holdingRMB = true
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton2 then
        holdingRMB = false
        if not Settings.StickyAim then
            AimLocked = false
            AimTarget = nil
        end
    end
end)

-- Infinite Jump
UserInputService.JumpRequest:Connect(function()
    if Settings.InfiniteJump then
        local char = LocalPlayer.Character
        if char then
            local hum = char:FindFirstChildOfClass("Humanoid")
            if hum then
                hum:ChangeState(Enum.HumanoidStateType.Jumping)
            end
        end
    end
end)

-- Anti-AFK
pcall(function()
    local vu = game:GetService("VirtualUser")
    LocalPlayer.Idled:Connect(function()
        if Settings.AntiAFK then
            vu:Button2Down(Vector2.new(0, 0), Camera.CFrame)
            task.wait(1)
            vu:Button2Up(Vector2.new(0, 0), Camera.CFrame)
        end
    end)
end)

-- Chat Spam
task.spawn(function()
    while true do
        task.wait(Settings.ChatSpamDelay)
        if Settings.ChatSpam then
            pcall(function()
                local args = {Settings.ChatSpamMessage, "All"}
                game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(unpack(args))
            end)
        end
    end
end)

-- No Particles handler
task.spawn(function()
    while true do
        task.wait(1)
        if Settings.NoParticles then
            pcall(function()
                for _, v in ipairs(Workspace:GetDescendants()) do
                    if v:IsA("ParticleEmitter") or v:IsA("Smoke") or v:IsA("Fire") or v:IsA("Sparkles") then
                        v.Enabled = false
                    end
                end
            end)
        end
    end
end)

-- ═══════════════════════════════════════════
-- MAIN RENDERING & LOGIC
-- ═══════════════════════════════════════════
RunService.RenderStepped:Connect(function()
    local char = LocalPlayer.Character
    local myHRP = char and char:FindFirstChild("HumanoidRootPart")
    local screenCenter = GetScreenCenter()
    
    -- ══ FOV CIRCLE (CENTER OF SCREEN) ══
    if FOVCircle then
        if Settings.ShowFOV and Settings.AimbotEnabled then
            FOVCircle.Visible = true
            FOVCircle.Position = screenCenter -- ЦЕНТР ЭКРАНА
            FOVCircle.Radius = Settings.AimFOV
            FOVCircle.Color = Color3.fromRGB(255, 50, 50)
            FOVCircle.Thickness = 1.5
        else
            FOVCircle.Visible = false
        end
    end
    
    -- ══ CROSSHAIR ══
    if Settings.CrosshairEnabled then
        local center = screenCenter
        local size = Settings.CrosshairSize
        local gap = Settings.CrosshairGap
        local thick = Settings.CrosshairThickness
        local col = Settings.CrosshairColor
        
        -- Outline
        if Settings.CrosshairOutline then
            -- Top
            CrosshairOutlines[1].From = Vector2.new(center.X, center.Y - gap)
            CrosshairOutlines[1].To = Vector2.new(center.X, center.Y - gap - size)
            -- Bottom
            CrosshairOutlines[2].From = Vector2.new(center.X, center.Y + gap)
            CrosshairOutlines[2].To = Vector2.new(center.X, center.Y + gap + size)
            -- Left
            CrosshairOutlines[3].From = Vector2.new(center.X - gap, center.Y)
            CrosshairOutlines[3].To = Vector2.new(center.X - gap - size, center.Y)
            -- Right
            CrosshairOutlines[4].From = Vector2.new(center.X + gap, center.Y)
            CrosshairOutlines[4].To = Vector2.new(center.X + gap + size, center.Y)
            
            for i = 1, 4 do
                CrosshairOutlines[i].Visible = true
                CrosshairOutlines[i].Thickness = thick + 2
                CrosshairOutlines[i].Color = Color3.new(0, 0, 0)
            end
        else
            for i = 1, 4 do
                CrosshairOutlines[i].Visible = false
            end
        end
        
        -- Main lines
        CrosshairLines[1].From = Vector2.new(center.X, center.Y - gap)
        CrosshairLines[1].To = Vector2.new(center.X, center.Y - gap - size)
        CrosshairLines[2].From = Vector2.new(center.X, center.Y + gap)
        CrosshairLines[2].To = Vector2.new(center.X, center.Y + gap + size)
        CrosshairLines[3].From = Vector2.new(center.X - gap, center.Y)
        CrosshairLines[3].To = Vector2.new(center.X - gap - size, center.Y)
        CrosshairLines[4].From = Vector2.new(center.X + gap, center.Y)
        CrosshairLines[4].To = Vector2.new(center.X + gap + size, center.Y)
        
        for i = 1, 4 do
            CrosshairLines[i].Visible = true
            CrosshairLines[i].Color = col
            CrosshairLines[i].Thickness = thick
        end
        
        -- Dot
        if CrosshairDotDraw then
            if Settings.CrosshairDot then
                CrosshairDotDraw.Visible = true
                CrosshairDotDraw.Position = center
                CrosshairDotDraw.Color = col
                CrosshairDotDraw.Radius = thick
            else
                CrosshairDotDraw.Visible = false
            end
        end
    else
        for i = 1, 4 do
            if CrosshairLines[i] then CrosshairLines[i].Visible = false end
            if CrosshairOutlines[i] then CrosshairOutlines[i].Visible = false end
        end
        if CrosshairDotDraw then CrosshairDotDraw.Visible = false end
    end
    
    -- ══ AIMBOT ══
    if Settings.AimbotEnabled and (holdingRMB or Settings.AimLock) then
        -- Sticky Aim: keep locked target
        if Settings.StickyAim and AimLocked and AimTarget then
            local targetPlayer = AimTarget.Player
            if IsAlive(targetPlayer) then
                local targetChar = targetPlayer.Character
                local aimPart = targetChar:FindFirstChild(Settings.AimPart) or targetChar:FindFirstChild("HumanoidRootPart")
                if aimPart then
                    local targetPos = aimPart.Position
                    
                    if Settings.PredictionEnabled then
                        local hrp = targetChar:FindFirstChild("HumanoidRootPart")
                        if hrp then
                            targetPos = targetPos + Vector3.new(
                                hrp.AssemblyLinearVelocity.X * Settings.PredictionX,
                                hrp.AssemblyLinearVelocity.Y * Settings.PredictionY,
                                hrp.AssemblyLinearVelocity.Z * Settings.PredictionZ
                            )
                        end
                    end
                    
                    if not Settings.SilentAim then
                        local camCF = Camera.CFrame
                        local targetCF = CFrame.new(camCF.Position, targetPos)
                        Camera.CFrame = camCF:Lerp(targetCF, 1 / Settings.AimSmoothing)
                    end
                else
                    AimLocked = false
                    AimTarget = nil
                end
            else
                AimLocked = false
                AimTarget = nil
            end
        else
            -- Find new target
            local target = GetBestTarget()
            if target then
                AimTarget = target
                if Settings.StickyAim then
                    AimLocked = true
                end
                
                if not Settings.SilentAim then
                    local camCF = Camera.CFrame
                    local targetCF = CFrame.new(camCF.Position, target.TargetPos)
                    Camera.CFrame = camCF:Lerp(targetCF, 1 / Settings.AimSmoothing)
                end
            end
        end
    elseif not holdingRMB and not Settings.AimLock then
        AimTarget = nil
        AimLocked = false
    end
    
    -- ══ TRIGGERBOT ══
    if Settings.TriggerbotEnabled then
        local target = GetBestTarget()
        if target and target.DistToCenter <= Settings.TriggerbotFOV then
            local now = tick()
            if now - lastTriggerShot >= (Settings.TriggerbotDelay / 1000) then
                lastTriggerShot = now
                pcall(function()
                    mouse1click()
                end)
            end
        end
    end
    
    -- ══ AUTO SHOOT ══
    if Settings.AutoShoot and Settings.AimbotEnabled and AimTarget then
        pcall(function()
            mouse1click()
        end)
    end
    
    -- ══ PLAYER MODS ══
    if char then
        local hum = char:FindFirstChildOfClass("Humanoid")
        local hrp = char:FindFirstChild("HumanoidRootPart")
        
        if hum then
            if Settings.SpeedEnabled then
                hum.WalkSpeed = Settings.Speed
            end
            
            if Settings.JumpEnabled then
                hum.JumpPower = Settings.JumpPower
                hum.UseJumpPower = true
            end
            
            if Settings.HipHeightEnabled then
                hum.HipHeight = Settings.HipHeight
            end
        end
        
        -- Noclip
        if Settings.Noclip then
            for _, part in ipairs(char:GetDescendants()) do
                if part:IsA("BasePart") and part.CanCollide then
                    part.CanCollide = false
                end
            end
        end
        
        -- Fly
        if Settings.Fly and hrp and Flying then
            local direction = Vector3.new(0, 0, 0)
            
            if UserInputService:IsKeyDown(Enum.KeyCode.W) then
                direction = direction + Camera.CFrame.LookVector
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then
                direction = direction - Camera.CFrame.LookVector
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then
                direction = direction - Camera.CFrame.RightVector
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then
                direction = direction + Camera.CFrame.RightVector
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
                direction = direction + Vector3.new(0, 1, 0)
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) or UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
                direction = direction - Vector3.new(0, 1, 0)
            end
            
            if FlyBV then
                FlyBV.Velocity = direction.Unit * Settings.FlySpeed
                if direction.Magnitude == 0 then
                    FlyBV.Velocity = Vector3.new(0, 0, 0)
                end
            end
            if FlyBG then
                FlyBG.CFrame = Camera.CFrame
            end
        end
        
        -- Gravity
        if Settings.GravityEnabled then
            Workspace.Gravity = Settings.Gravity
        end
    end
    
    -- ══ VISUALS ══
    if Settings.Fullbright then
        Lighting.Brightness = 3
        Lighting.ClockTime = 14
        Lighting.FogEnd = 100000
        Lighting.GlobalShadows = false
        Lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
        Lighting.Ambient = Color3.fromRGB(178, 178, 178)
    end
    
    if Settings.NoFog then
        Lighting.FogEnd = 1e10
        Lighting.FogStart = 1e10
    end
    
    if Settings.TimeChanger then
        Lighting.ClockTime = Settings.TimeValue
    end
    
    if Settings.FOVChanger then
        Camera.FieldOfView = Settings.FOVValue
    end
    
    -- ══ ESP RENDERING ══
    for player, esp in pairs(ESPObjects) do
        local character = player.Character
        local humanoid = character and character:FindFirstChildOfClass("Humanoid")
        local hrpE = character and character:FindFirstChild("HumanoidRootPart")
        local head = character and character:FindFirstChild("Head")
        
        local shouldShow = Settings.ESPEnabled and character and humanoid and hrpE and humanoid.Health > 0
        
        if shouldShow and Settings.ESPTeamCheck and player.Team and LocalPlayer.Team and player.Team == LocalPlayer.Team then
            shouldShow = false
        end
        
        if shouldShow and myHRP then
            local dist = GetDistance3D(myHRP.Position, hrpE.Position)
            if dist > Settings.ESPMaxDistance then
                shouldShow = false
            end
        end
        
        if shouldShow then
            local rootPos, onScreen, depth = WorldToScreen(hrpE.Position)
            
            if onScreen and depth > 0 then
                local scaleFactor = 1 / (depth * math.tan(math.rad(Camera.FieldOfView / 2)) * 2 / Camera.ViewportSize.Y)
                local boxHeight = math.clamp(scaleFactor * 5.5, 18, 1000)
                local boxWidth = boxHeight * 0.55
                
                local topLeft = Vector2.new(rootPos.X - boxWidth / 2, rootPos.Y - boxHeight / 2)
                local boxSize = Vector2.new(boxWidth, boxHeight)
                
                local hpRatio = math.clamp(humanoid.Health / humanoid.MaxHealth, 0, 1)
                local hpColor = Color3.fromRGB(255 * (1 - hpRatio), 255 * hpRatio, 0)
                
                -- Boxes
                if Settings.ESPBoxes then
                    esp.BoxOutline.Visible = true
                    esp.BoxOutline.Position = topLeft - Vector2.new(1, 1)
                    esp.BoxOutline.Size = boxSize + Vector2.new(2, 2)
                    
                    esp.Box.Visible = true
                    esp.Box.Position = topLeft
                    esp.Box.Size = boxSize
                    esp.Box.Color = hpColor
                else
                    esp.Box.Visible = false
                    esp.BoxOutline.Visible = false
                end
                
                -- Name
                if Settings.ESPNames then
                    esp.Name.Visible = true
                    esp.Name.Position = Vector2.new(rootPos.X, topLeft.Y - 16)
                    esp.Name.Text = player.DisplayName
                    esp.Name.Color = Color3.new(1, 1, 1)
                else
                    esp.Name.Visible = false
                end
                
                -- Distance
                if Settings.ESPDistance and myHRP then
                    local dist = math.floor(GetDistance3D(myHRP.Position, hrpE.Position))
                    esp.Distance.Visible = true
                    esp.Distance.Position = Vector2.new(rootPos.X, topLeft.Y + boxHeight + 2)
                    esp.Distance.Text = "[" .. dist .. "m]"
                    esp.Distance.Color = Color3.fromRGB(200, 200, 200)
                else
                    esp.Distance.Visible = false
                end
                
                -- Health Bar
                if Settings.ESPHealth then
                    local barHeight = boxHeight
                    local barX = topLeft.X - 7
                    
                    esp.HealthBarBG.Visible = true
                    esp.HealthBarBG.Position = Vector2.new(barX, topLeft.Y - 1)
                    esp.HealthBarBG.Size = Vector2.new(4, barHeight + 2)
                    
                    esp.HealthBar.Visible = true
                    esp.HealthBar.Position = Vector2.new(barX + 0.5, topLeft.Y + barHeight * (1 - hpRatio))
                    esp.HealthBar.Size = Vector2.new(3, barHeight * hpRatio)
                    esp.HealthBar.Color = hpColor
                    
                    -- HP number
                    if hpRatio < 1 then
                        esp.HealthText.Visible = true
                        esp.HealthText.Position = Vector2.new(barX - 2, topLeft.Y + barHeight * (1 - hpRatio) - 6)
                        esp.HealthText.Text = tostring(math.floor(humanoid.Health))
                        esp.HealthText.Color = hpColor
                    else
                        esp.HealthText.Visible = false
                    end
                else
                    esp.HealthBarBG.Visible = false
                    esp.HealthBar.Visible = false
                    esp.HealthText.Visible = false
                end
                
                -- Tracers
                if Settings.ESPTracers then
                    esp.Tracer.Visible = true
                    esp.Tracer.Color = hpColor
                    
                    local viewport = Camera.ViewportSize
                    if Settings.TracerOrigin == "Bottom" then
                        esp.Tracer.From = Vector2.new(viewport.X / 2, viewport.Y)
                    elseif Settings.TracerOrigin == "Center" then
                        esp.Tracer.From = Vector2.new(viewport.X / 2, viewport.Y / 2)
                    elseif Settings.TracerOrigin == "Top" then
                        esp.Tracer.From = Vector2.new(viewport.X / 2, 0)
                    elseif Settings.TracerOrigin == "Mouse" then
                        local mp = UserInputService:GetMouseLocation()
                        esp.Tracer.From = mp
                    end
                    esp.Tracer.To = Vector2.new(rootPos.X, topLeft.Y + boxHeight)
                else
                    esp.Tracer.Visible = false
                end
                
                -- Head Dot
                if Settings.ESPHeadDot and head then
                    local headPos, headOnScreen = WorldToScreen(head.Position)
                    if headOnScreen then
                        esp.HeadDot.Visible = true
                        esp.HeadDot.Position = headPos
                        esp.HeadDot.Radius = math.clamp(scaleFactor * 0.8, 2, 15)
                        esp.HeadDot.Color = Color3.fromRGB(255, 50, 50)
                    else
                        esp.HeadDot.Visible = false
                    end
                else
                    esp.HeadDot.Visible = false
                end
                
                -- Weapon Name
                if Settings.ESPWeaponName then
                    local tool = GetTool(player)
                    if tool ~= "None" then
                        esp.WeaponText.Visible = true
                        local yOff = Settings.ESPDistance and 14 or 2
                        esp.WeaponText.Position = Vector2.new(rootPos.X, topLeft.Y + boxHeight + yOff)
                        esp.WeaponText.Text = "[" .. tool .. "]"
                    else
                        esp.WeaponText.Visible = false
                    end
                else
                    esp.WeaponText.Visible = false
                end
                
                -- Chams
                if Settings.ESPChams then
                    if not ESPHighlights[player] or not ESPHighlights[player].Parent then
                        local hl = Instance.new("Highlight")
                        hl.FillColor = Settings.ChamsFillColor
                        hl.FillTransparency = Settings.ChamsTransparency
                        hl.OutlineColor = Settings.ChamsOutlineColor
                        hl.OutlineTransparency = 0.3
                        hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                        hl.Adornee = character
                        hl.Parent = character
                        ESPHighlights[player] = hl
                    else
                        ESPHighlights[player].FillColor = Settings.ChamsFillColor
                        ESPHighlights[player].FillTransparency = Settings.ChamsTransparency
                        ESPHighlights[player].OutlineColor = Settings.ChamsOutlineColor
                    end
                else
                    if ESPHighlights[player] then
                        pcall(function() ESPHighlights[player]:Destroy() end)
                        ESPHighlights[player] = nil
                    end
                end
            else
                -- Off screen
                esp.Box.Visible = false
                esp.BoxOutline.Visible = false
                esp.Name.Visible = false
                esp.Distance.Visible = false
                esp.HealthBar.Visible = false
                esp.HealthBarBG.Visible = false
                esp.HealthText.Visible = false
                esp.Tracer.Visible = false
                esp.HeadDot.Visible = false
                esp.WeaponText.Visible = false
            end
        else
            -- Hide all
            if esp.Box then esp.Box.Visible = false end
            if esp.BoxOutline then esp.BoxOutline.Visible = false end
            if esp.Name then esp.Name.Visible = false end
            if esp.Distance then esp.Distance.Visible = false end
            if esp.HealthBar then esp.HealthBar.Visible = false end
            if esp.HealthBarBG then esp.HealthBarBG.Visible = false end
            if esp.HealthText then esp.HealthText.Visible = false end
            if esp.Tracer then esp.Tracer.Visible = false end
            if esp.HeadDot then esp.HeadDot.Visible = false end
            if esp.WeaponText then esp.WeaponText.Visible = false end
            
            if ESPHighlights[player] then
                pcall(function() ESPHighlights[player]:Destroy() end)
                ESPHighlights[player] = nil
            end
        end
    end
end)

-- ═══════════════════════════════════════════
-- SILENT AIM HOOK (if exploit supports)
-- ═══════════════════════════════════════════
pcall(function()
    if getrawmetatable and setreadonly and newcclosure then
        local mt = getrawmetatable(game)
        local oldNamecall = mt.__namecall
        setreadonly(mt, false)
        
        mt.__namecall = newcclosure(function(self, ...)
            local method = getnamecallmethod()
            local args = {...}
            
            if Settings.SilentAim and method == "FindPartOnRayWithIgnoreList" or method == "FindPartOnRay" then
                if math.random(1, 100) <= Settings.SilentAimChance then
                    local silentTarget = GetBestTarget()
                    if silentTarget then
                        local aimPart = silentTarget.Character:FindFirstChild(Settings.SilentAimPart)
                            or silentTarget.Character:FindFirstChild("HumanoidRootPart")
                        if aimPart then
                            local origin = args[1] and typeof(args[1]) == "Ray" and args[1].Origin or Camera.CFrame.Position
                            local direction = (aimPart.Position - origin).Unit * 1000
                            args[1] = Ray.new(origin, direction)
                        end
                    end
                end
            end
            
            if Settings.SilentAim and method == "Raycast" then
                if math.random(1, 100) <= Settings.SilentAimChance then
                    local silentTarget = GetBestTarget()
                    if silentTarget then
                        local aimPart = silentTarget.Character:FindFirstChild(Settings.SilentAimPart)
                            or silentTarget.Character:FindFirstChild("HumanoidRootPart")
                        if aimPart then
                            local origin = Camera.CFrame.Position
                            args[1] = origin
                            args[2] = (aimPart.Position - origin).Unit * 1000
                        end
                    end
                end
            end
            
            return oldNamecall(self, unpack(args))
        end)
        
        setreadonly(mt, true)
    end
end)

-- ═══════════════════════════════════════════
-- CHARACTER RESPAWN HANDLER
-- ═══════════════════════════════════════════
LocalPlayer.CharacterAdded:Connect(function(char)
    task.wait(0.5)
    
    -- Re-apply fly if was flying
    if Settings.Fly then
        StopFly()
        task.wait(0.3)
        StartFly()
    end
    
    Notifier.new({
        Title = "IMPERIUM",
        Content = "Character respawned — settings reapplied",
        Duration = 3,
        Icon = "rbxassetid://120245531583106"
    })
end)

-- ═══════════════════════════════════════════
-- FINAL NOTIFICATION
-- ═══════════════════════════════════════════
Notifier.new({
    Title = "IMPERIUM v3.0",
    Content = "All systems active | " .. #Players:GetPlayers() .. " players in server",
    Duration = 6,
    Icon = "rbxassetid://120245531583106"
})

print("[IMPERIUM] ✅ v3.0 loaded successfully!")
print("[IMPERIUM] Press Left Alt to toggle menu")
print("[IMPERIUM] Features: Aimbot, Silent Aim, Triggerbot, ESP, Chams, Fly, Speed, Noclip + more")
