--[[
    ██╗███╗   ███╗██████╗ ███████╗██████╗ ██╗██╗   ██╗███╗   ███╗
    ██║████╗ ████║██╔══██╗██╔════╝██╔══██╗██║██║   ██║████╗ ████║
    ██║██╔████╔██║██████╔╝█████╗  ██████╔╝██║██║   ██║██╔████╔██║
    ██║██║╚██╔╝██║██╔═══╝ ██╔══╝  ██╔══██╗██║██║   ██║██║╚██╔╝██║
    ██║██║ ╚═╝ ██║██║     ███████╗██║  ██║██║╚██████╔╝██║ ╚═╝ ██║
    ╚═╝╚═╝     ╚═╝╚═╝     ╚══════╝╚═╝  ╚═╝╚═╝ ╚═════╝ ╚═╝     ╚═╝
    
    Imperium Cheat Suite v2.1 — CS2-Style Menu
    Mobile & Desktop Support
]]

-- ═══════════════════════════════════════════
-- SERVICES
-- ═══════════════════════════════════════════
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

-- ═══════════════════════════════════════════
-- SETTINGS TABLE
-- ═══════════════════════════════════════════
local Settings = {
    -- Aimbot
    AimbotEnabled = false,
    SilentAim = false,
    AimFOV = 120,
    AimSmoothing = 5,
    AimPart = "Head", -- Head, HumanoidRootPart, Torso
    TargetMode = "Closest", -- Closest, LowestHP, Random
    ShowFOVCircle = true,
    TeamCheck = false,
    WallCheck = false,
    AimKey = Enum.UserInputType.MouseButton2,
    PredictionEnabled = false,
    PredictionAmount = 0.165,
    
    -- ESP
    ESPEnabled = false,
    ESPBoxes = false,
    ESPNames = true,
    ESPHealth = true,
    ESPDistance = true,
    ESPTracers = false,
    ESPSkeletons = false,
    ESPChams = false,
    ESPMaxDistance = 2000,
    ESPTeamCheck = false,
    BoxColor = Color3.fromRGB(255, 50, 50),
    NameColor = Color3.fromRGB(255, 255, 255),
    TracerColor = Color3.fromRGB(255, 50, 50),
    SkeletonColor = Color3.fromRGB(255, 255, 255),
    ChamsColor = Color3.fromRGB(255, 0, 80),
    TracerOrigin = "Bottom", -- Bottom, Center, Top
    
    -- Player
    Speed = 16,
    SpeedEnabled = false,
    JumpPower = 50,
    JumpEnabled = false,
    InfiniteJump = false,
    Fly = false,
    FlySpeed = 50,
    Noclip = false,
    AntiAFK = true,
    
    -- Visuals
    Fullbright = false,
    NoFog = false,
    CrosshairEnabled = false,
    CrosshairColor = Color3.fromRGB(255, 50, 50),
    CrosshairSize = 10,
    CrosshairThickness = 2,
    CrosshairGap = 5
}

-- ═══════════════════════════════════════════
-- COLOR SCHEME (CS2 Inspired)
-- ═══════════════════════════════════════════
local Colors = {
    Background = Color3.fromRGB(18, 18, 22),
    BackgroundDark = Color3.fromRGB(12, 12, 16),
    Header = Color3.fromRGB(22, 22, 28),
    TabBar = Color3.fromRGB(14, 14, 18),
    TabActive = Color3.fromRGB(255, 45, 85),
    TabInactive = Color3.fromRGB(80, 80, 100),
    Accent = Color3.fromRGB(255, 45, 85),
    AccentDark = Color3.fromRGB(200, 30, 65),
    AccentGlow = Color3.fromRGB(255, 80, 120),
    Text = Color3.fromRGB(230, 230, 240),
    TextDim = Color3.fromRGB(140, 140, 160),
    TextDark = Color3.fromRGB(90, 90, 110),
    Section = Color3.fromRGB(25, 25, 32),
    SectionBorder = Color3.fromRGB(40, 40, 55),
    Toggle = Color3.fromRGB(35, 35, 45),
    ToggleActive = Color3.fromRGB(255, 45, 85),
    Slider = Color3.fromRGB(35, 35, 45),
    SliderFill = Color3.fromRGB(255, 45, 85),
    Dropdown = Color3.fromRGB(30, 30, 40),
    Separator = Color3.fromRGB(40, 40, 55),
    Shadow = Color3.fromRGB(0, 0, 0),
    Success = Color3.fromRGB(50, 255, 120),
    Warning = Color3.fromRGB(255, 200, 50),
    Danger = Color3.fromRGB(255, 50, 50),
    Gradient1 = Color3.fromRGB(255, 45, 85),
    Gradient2 = Color3.fromRGB(180, 30, 255)
}

-- ═══════════════════════════════════════════
-- UTILITY FUNCTIONS
-- ═══════════════════════════════════════════
local function Create(className, properties)
    local instance = Instance.new(className)
    for prop, value in pairs(properties) do
        if prop ~= "Parent" then
            instance[prop] = value
        end
    end
    if properties.Parent then
        instance.Parent = properties.Parent
    end
    return instance
end

local function Tween(obj, props, duration, style, direction)
    local tween = TweenService:Create(obj, TweenInfo.new(
        duration or 0.25,
        style or Enum.EasingStyle.Quart,
        direction or Enum.EasingDirection.Out
    ), props)
    tween:Play()
    return tween
end

local function AddCorner(parent, radius)
    return Create("UICorner", {
        CornerRadius = UDim.new(0, radius or 6),
        Parent = parent
    })
end

local function AddStroke(parent, color, thickness, transparency)
    return Create("UIStroke", {
        Color = color or Colors.SectionBorder,
        Thickness = thickness or 1,
        Transparency = transparency or 0.5,
        Parent = parent
    })
end

local function AddPadding(parent, t, b, l, r)
    return Create("UIPadding", {
        PaddingTop = UDim.new(0, t or 8),
        PaddingBottom = UDim.new(0, b or 8),
        PaddingLeft = UDim.new(0, l or 10),
        PaddingRight = UDim.new(0, r or 10),
        Parent = parent
    })
end

local function AddGradient(parent, color1, color2, rotation)
    return Create("UIGradient", {
        Color = ColorSequence.new{
            ColorSequenceKeypoint.new(0, color1),
            ColorSequenceKeypoint.new(1, color2)
        },
        Rotation = rotation or 90,
        Parent = parent
    })
end

-- ═══════════════════════════════════════════
-- GUI CREATION
-- ═══════════════════════════════════════════
-- Cleanup old
if game.CoreGui:FindFirstChild("ImperiumGUI") then
    game.CoreGui:FindFirstChild("ImperiumGUI"):Destroy()
end

local ScreenGui = Create("ScreenGui", {
    Name = "ImperiumGUI",
    ResetOnSpawn = false,
    ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
    Parent = game.CoreGui
})

-- ═══════════════════════════════════════════
-- MOBILE TOGGLE BUTTON
-- ═══════════════════════════════════════════
local ToggleButton = Create("TextButton", {
    Name = "ToggleBtn",
    Size = UDim2.new(0, 50, 0, 50),
    Position = UDim2.new(0, 15, 0.5, -25),
    BackgroundColor3 = Colors.Accent,
    Text = "I",
    TextColor3 = Color3.new(1,1,1),
    TextSize = 22,
    Font = Enum.Font.GothamBold,
    Parent = ScreenGui,
    ZIndex = 100
})
AddCorner(ToggleButton, 25)
AddStroke(ToggleButton, Colors.AccentGlow, 2, 0.3)

-- Glow pulse animation
local toggleGlow = Create("ImageLabel", {
    Size = UDim2.new(1.6, 0, 1.6, 0),
    Position = UDim2.new(-0.3, 0, -0.3, 0),
    BackgroundTransparency = 1,
    Image = "rbxassetid://5028857084",
    ImageColor3 = Colors.Accent,
    ImageTransparency = 0.7,
    Parent = ToggleButton,
    ZIndex = 99
})

spawn(function()
    while wait(1.5) do
        if ToggleButton.Parent then
            Tween(toggleGlow, {ImageTransparency = 0.4}, 0.75)
            wait(0.75)
            Tween(toggleGlow, {ImageTransparency = 0.8}, 0.75)
        end
    end
end)

-- Make toggle draggable
local toggleDragging = false
local toggleDragStart, toggleStartPos
ToggleButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
        toggleDragging = true
        toggleDragStart = input.Position
        toggleStartPos = ToggleButton.Position
    end
end)
ToggleButton.InputChanged:Connect(function(input)
    if toggleDragging and (input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseMovement) then
        local delta = input.Position - toggleDragStart
        ToggleButton.Position = UDim2.new(
            toggleStartPos.X.Scale, toggleStartPos.X.Offset + delta.X,
            toggleStartPos.Y.Scale, toggleStartPos.Y.Offset + delta.Y
        )
    end
end)
ToggleButton.InputEnded:Connect(function(input)
    toggleDragging = false
end)

-- ═══════════════════════════════════════════
-- MAIN FRAME
-- ═══════════════════════════════════════════
local MainFrame = Create("Frame", {
    Name = "MainFrame",
    Size = UDim2.new(0, 580, 0, 440),
    Position = UDim2.new(0.5, -290, 0.5, -220),
    BackgroundColor3 = Colors.Background,
    BorderSizePixel = 0,
    Visible = true,
    ClipsDescendants = true,
    Parent = ScreenGui
})
AddCorner(MainFrame, 10)

-- Drop shadow
local Shadow = Create("ImageLabel", {
    Size = UDim2.new(1, 50, 1, 50),
    Position = UDim2.new(0, -25, 0, -25),
    BackgroundTransparency = 1,
    Image = "rbxassetid://5028857084",
    ImageColor3 = Color3.new(0,0,0),
    ImageTransparency = 0.4,
    ScaleType = Enum.ScaleType.Slice,
    SliceCenter = Rect.new(24, 24, 276, 276),
    Parent = MainFrame,
    ZIndex = -1
})

-- Main border glow
local MainStroke = AddStroke(MainFrame, Colors.Accent, 1.5, 0.6)

-- ═══════════════════════════════════════════
-- HEADER BAR
-- ═══════════════════════════════════════════
local Header = Create("Frame", {
    Name = "Header",
    Size = UDim2.new(1, 0, 0, 45),
    BackgroundColor3 = Colors.Header,
    BorderSizePixel = 0,
    Parent = MainFrame
})
AddCorner(Header, 10)

-- Fix bottom corners of header
local HeaderFix = Create("Frame", {
    Size = UDim2.new(1, 0, 0, 15),
    Position = UDim2.new(0, 0, 1, -15),
    BackgroundColor3 = Colors.Header,
    BorderSizePixel = 0,
    Parent = Header
})

-- Accent line under header
local AccentLine = Create("Frame", {
    Size = UDim2.new(1, 0, 0, 2),
    Position = UDim2.new(0, 0, 1, 0),
    BackgroundColor3 = Colors.Accent,
    BorderSizePixel = 0,
    Parent = Header
})
AddGradient(AccentLine, Colors.Gradient1, Colors.Gradient2, 0)

-- Logo/Title
local Logo = Create("TextLabel", {
    Size = UDim2.new(0, 200, 1, 0),
    Position = UDim2.new(0, 15, 0, 0),
    BackgroundTransparency = 1,
    Text = "IMPERIUM",
    TextColor3 = Colors.Accent,
    TextSize = 18,
    Font = Enum.Font.GothamBold,
    TextXAlignment = Enum.TextXAlignment.Left,
    Parent = Header
})

local Version = Create("TextLabel", {
    Size = UDim2.new(0, 50, 1, 0),
    Position = UDim2.new(0, 125, 0, 1),
    BackgroundTransparency = 1,
    Text = "v2.1",
    TextColor3 = Colors.TextDim,
    TextSize = 11,
    Font = Enum.Font.Gotham,
    TextXAlignment = Enum.TextXAlignment.Left,
    Parent = Header
})

-- Status indicator
local StatusDot = Create("Frame", {
    Size = UDim2.new(0, 8, 0, 8),
    Position = UDim2.new(1, -80, 0.5, -4),
    BackgroundColor3 = Colors.Success,
    Parent = Header
})
AddCorner(StatusDot, 4)

local StatusText = Create("TextLabel", {
    Size = UDim2.new(0, 60, 1, 0),
    Position = UDim2.new(1, -65, 0, 0),
    BackgroundTransparency = 1,
    Text = "Active",
    TextColor3 = Colors.Success,
    TextSize = 11,
    Font = Enum.Font.Gotham,
    TextXAlignment = Enum.TextXAlignment.Left,
    Parent = Header
})

-- Close button
local CloseBtn = Create("TextButton", {
    Size = UDim2.new(0, 30, 0, 30),
    Position = UDim2.new(1, -38, 0, 7),
    BackgroundTransparency = 1,
    Text = "✕",
    TextColor3 = Colors.TextDim,
    TextSize = 16,
    Font = Enum.Font.GothamBold,
    Parent = Header
})
CloseBtn.MouseEnter:Connect(function()
    Tween(CloseBtn, {TextColor3 = Colors.Danger}, 0.2)
end)
CloseBtn.MouseLeave:Connect(function()
    Tween(CloseBtn, {TextColor3 = Colors.TextDim}, 0.2)
end)

-- Minimize button
local MinBtn = Create("TextButton", {
    Size = UDim2.new(0, 30, 0, 30),
    Position = UDim2.new(1, -68, 0, 7),
    BackgroundTransparency = 1,
    Text = "—",
    TextColor3 = Colors.TextDim,
    TextSize = 16,
    Font = Enum.Font.GothamBold,
    Parent = Header
})

-- Dragging
local dragging, dragStart, startPos
Header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
    end
end)
Header.InputChanged:Connect(function(input)
    if dragging then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)
UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

-- ═══════════════════════════════════════════
-- TAB SYSTEM
-- ═══════════════════════════════════════════
local TabBar = Create("Frame", {
    Name = "TabBar",
    Size = UDim2.new(0, 140, 1, -49),
    Position = UDim2.new(0, 0, 0, 47),
    BackgroundColor3 = Colors.TabBar,
    BorderSizePixel = 0,
    Parent = MainFrame
})

local TabSeparator = Create("Frame", {
    Size = UDim2.new(0, 1, 1, -10),
    Position = UDim2.new(1, 0, 0, 5),
    BackgroundColor3 = Colors.Separator,
    BackgroundTransparency = 0.5,
    BorderSizePixel = 0,
    Parent = TabBar
})

local TabList = Create("UIListLayout", {
    SortOrder = Enum.SortOrder.LayoutOrder,
    Padding = UDim.new(0, 2),
    Parent = TabBar
})

local TabPadding = AddPadding(TabBar, 8, 8, 6, 6)

-- Content area
local ContentFrame = Create("Frame", {
    Name = "Content",
    Size = UDim2.new(1, -142, 1, -49),
    Position = UDim2.new(0, 142, 0, 47),
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    Parent = MainFrame
})

local TabPages = {}
local TabButtons = {}
local ActiveTab = nil

local TabIcons = {
    Aimbot = "🎯",
    ESP = "👁",
    Player = "🏃",
    Visuals = "🎨",
    Misc = "⚙"
}

local function CreateTab(name, order)
    -- Tab Button
    local tabBtn = Create("TextButton", {
        Name = name,
        Size = UDim2.new(1, 0, 0, 38),
        BackgroundColor3 = Colors.TabBar,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Text = "",
        LayoutOrder = order,
        Parent = TabBar
    })
    AddCorner(tabBtn, 6)
    
    local tabIcon = Create("TextLabel", {
        Size = UDim2.new(0, 30, 1, 0),
        Position = UDim2.new(0, 8, 0, 0),
        BackgroundTransparency = 1,
        Text = TabIcons[name] or "•",
        TextSize = 14,
        Font = Enum.Font.GothamBold,
        TextColor3 = Colors.TextDim,
        Parent = tabBtn
    })
    
    local tabLabel = Create("TextLabel", {
        Size = UDim2.new(1, -40, 1, 0),
        Position = UDim2.new(0, 38, 0, 0),
        BackgroundTransparency = 1,
        Text = name,
        TextColor3 = Colors.TextDim,
        TextSize = 12,
        Font = Enum.Font.GothamSemibold,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = tabBtn
    })
    
    local activeIndicator = Create("Frame", {
        Size = UDim2.new(0, 3, 0.6, 0),
        Position = UDim2.new(0, 0, 0.2, 0),
        BackgroundColor3 = Colors.Accent,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Parent = tabBtn
    })
    AddCorner(activeIndicator, 2)
    
    -- Tab Page (scrolling frame)
    local page = Create("ScrollingFrame", {
        Name = name .. "Page",
        Size = UDim2.new(1, -10, 1, -10),
        Position = UDim2.new(0, 5, 0, 5),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Visible = false,
        ScrollBarThickness = 3,
        ScrollBarImageColor3 = Colors.Accent,
        ScrollBarImageTransparency = 0.5,
        CanvasSize = UDim2.new(0, 0, 0, 0),
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        Parent = ContentFrame
    })
    
    local pageLayout = Create("UIListLayout", {
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0, 6),
        Parent = page
    })
    
    AddPadding(page, 5, 10, 5, 5)
    
    TabPages[name] = page
    TabButtons[name] = {Button = tabBtn, Label = tabLabel, Icon = tabIcon, Indicator = activeIndicator}
    
    tabBtn.MouseButton1Click:Connect(function()
        SwitchTab(name)
    end)
    
    tabBtn.MouseEnter:Connect(function()
        if ActiveTab ~= name then
            Tween(tabBtn, {BackgroundTransparency = 0.7}, 0.15)
            Tween(tabBtn, {BackgroundColor3 = Colors.Section}, 0.15)
        end
    end)
    tabBtn.MouseLeave:Connect(function()
        if ActiveTab ~= name then
            Tween(tabBtn, {BackgroundTransparency = 1}, 0.15)
        end
    end)
    
    return page
end

function SwitchTab(name)
    for tabName, data in pairs(TabButtons) do
        if tabName == name then
            ActiveTab = name
            TabPages[tabName].Visible = true
            Tween(data.Button, {BackgroundTransparency = 0.5, BackgroundColor3 = Colors.Section}, 0.2)
            Tween(data.Label, {TextColor3 = Colors.Text}, 0.2)
            Tween(data.Icon, {TextColor3 = Colors.Accent}, 0.2)
            Tween(data.Indicator, {BackgroundTransparency = 0}, 0.2)
        else
            TabPages[tabName].Visible = false
            Tween(data.Button, {BackgroundTransparency = 1}, 0.2)
            Tween(data.Label, {TextColor3 = Colors.TextDim}, 0.2)
            Tween(data.Icon, {TextColor3 = Colors.TextDim}, 0.2)
            Tween(data.Indicator, {BackgroundTransparency = 1}, 0.2)
        end
    end
end

-- ═══════════════════════════════════════════
-- UI COMPONENTS FACTORY
-- ═══════════════════════════════════════════

-- Section Header
local function CreateSection(parent, title, order)
    local section = Create("Frame", {
        Size = UDim2.new(1, 0, 0, 30),
        BackgroundTransparency = 1,
        LayoutOrder = order or 0,
        Parent = parent
    })
    
    local label = Create("TextLabel", {
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        Text = "  " .. string.upper(title),
        TextColor3 = Colors.Accent,
        TextSize = 11,
        Font = Enum.Font.GothamBold,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = section
    })
    
    local line = Create("Frame", {
        Size = UDim2.new(1, -10, 0, 1),
        Position = UDim2.new(0, 5, 1, -2),
        BackgroundColor3 = Colors.Accent,
        BackgroundTransparency = 0.7,
        BorderSizePixel = 0,
        Parent = section
    })
    
    return section
end

-- Toggle
local function CreateToggle(parent, text, settingKey, order, callback)
    local container = Create("Frame", {
        Size = UDim2.new(1, 0, 0, 34),
        BackgroundColor3 = Colors.Section,
        BackgroundTransparency = 0.3,
        BorderSizePixel = 0,
        LayoutOrder = order or 0,
        Parent = parent
    })
    AddCorner(container, 6)
    
    local label = Create("TextLabel", {
        Size = UDim2.new(1, -60, 1, 0),
        Position = UDim2.new(0, 12, 0, 0),
        BackgroundTransparency = 1,
        Text = text,
        TextColor3 = Colors.Text,
        TextSize = 12,
        Font = Enum.Font.Gotham,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = container
    })
    
    local toggleFrame = Create("Frame", {
        Size = UDim2.new(0, 40, 0, 20),
        Position = UDim2.new(1, -52, 0.5, -10),
        BackgroundColor3 = Colors.Toggle,
        BorderSizePixel = 0,
        Parent = container
    })
    AddCorner(toggleFrame, 10)
    AddStroke(toggleFrame, Colors.SectionBorder, 1, 0.5)
    
    local toggleCircle = Create("Frame", {
        Size = UDim2.new(0, 16, 0, 16),
        Position = UDim2.new(0, 2, 0, 2),
        BackgroundColor3 = Colors.TextDim,
        BorderSizePixel = 0,
        Parent = toggleFrame
    })
    AddCorner(toggleCircle, 8)
    
    local enabled = Settings[settingKey] or false
    
    local function UpdateVisual()
        if enabled then
            Tween(toggleFrame, {BackgroundColor3 = Colors.ToggleActive}, 0.2)
            Tween(toggleCircle, {Position = UDim2.new(0, 22, 0, 2), BackgroundColor3 = Color3.new(1,1,1)}, 0.2)
        else
            Tween(toggleFrame, {BackgroundColor3 = Colors.Toggle}, 0.2)
            Tween(toggleCircle, {Position = UDim2.new(0, 2, 0, 2), BackgroundColor3 = Colors.TextDim}, 0.2)
        end
    end
    
    UpdateVisual()
    
    local btn = Create("TextButton", {
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        Text = "",
        Parent = container
    })
    
    btn.MouseButton1Click:Connect(function()
        enabled = not enabled
        Settings[settingKey] = enabled
        UpdateVisual()
        if callback then callback(enabled) end
    end)
    
    container.MouseEnter:Connect(function()
        Tween(container, {BackgroundTransparency = 0.1}, 0.15)
    end)
    container.MouseLeave:Connect(function()
        Tween(container, {BackgroundTransparency = 0.3}, 0.15)
    end)
    
    return container
end

-- Slider
local function CreateSlider(parent, text, settingKey, min, max, order, callback)
    local container = Create("Frame", {
        Size = UDim2.new(1, 0, 0, 50),
        BackgroundColor3 = Colors.Section,
        BackgroundTransparency = 0.3,
        BorderSizePixel = 0,
        LayoutOrder = order or 0,
        Parent = parent
    })
    AddCorner(container, 6)
    
    local label = Create("TextLabel", {
        Size = UDim2.new(0.6, 0, 0, 20),
        Position = UDim2.new(0, 12, 0, 4),
        BackgroundTransparency = 1,
        Text = text,
        TextColor3 = Colors.Text,
        TextSize = 12,
        Font = Enum.Font.Gotham,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = container
    })
    
    local valueLabel = Create("TextLabel", {
        Size = UDim2.new(0.3, 0, 0, 20),
        Position = UDim2.new(0.7, -12, 0, 4),
        BackgroundTransparency = 1,
        Text = tostring(Settings[settingKey] or min),
        TextColor3 = Colors.Accent,
        TextSize = 12,
        Font = Enum.Font.GothamBold,
        TextXAlignment = Enum.TextXAlignment.Right,
        Parent = container
    })
    
    local sliderBg = Create("Frame", {
        Size = UDim2.new(1, -24, 0, 6),
        Position = UDim2.new(0, 12, 0, 32),
        BackgroundColor3 = Colors.Slider,
        BorderSizePixel = 0,
        Parent = container
    })
    AddCorner(sliderBg, 3)
    
    local currentVal = Settings[settingKey] or min
    local fillPercent = (currentVal - min) / (max - min)
    
    local sliderFill = Create("Frame", {
        Size = UDim2.new(fillPercent, 0, 1, 0),
        BackgroundColor3 = Colors.SliderFill,
        BorderSizePixel = 0,
        Parent = sliderBg
    })
    AddCorner(sliderFill, 3)
    AddGradient(sliderFill, Colors.Gradient1, Colors.Gradient2, 0)
    
    local sliderKnob = Create("Frame", {
        Size = UDim2.new(0, 14, 0, 14),
        Position = UDim2.new(fillPercent, -7, 0.5, -7),
        BackgroundColor3 = Color3.new(1,1,1),
        BorderSizePixel = 0,
        ZIndex = 5,
        Parent = sliderBg
    })
    AddCorner(sliderKnob, 7)
    AddStroke(sliderKnob, Colors.Accent, 2, 0)
    
    local sliderBtn = Create("TextButton", {
        Size = UDim2.new(1, 0, 0, 30),
        Position = UDim2.new(0, 0, 0, 22),
        BackgroundTransparency = 1,
        Text = "",
        Parent = container
    })
    
    local sliding = false
    
    local function UpdateSlider(inputX)
        local relX = (inputX - sliderBg.AbsolutePosition.X) / sliderBg.AbsoluteSize.X
        relX = math.clamp(relX, 0, 1)
        local value = math.floor(min + (max - min) * relX)
        Settings[settingKey] = value
        valueLabel.Text = tostring(value)
        Tween(sliderFill, {Size = UDim2.new(relX, 0, 1, 0)}, 0.05)
        Tween(sliderKnob, {Position = UDim2.new(relX, -7, 0.5, -7)}, 0.05)
        if callback then callback(value) end
    end
    
    sliderBtn.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            sliding = true
            UpdateSlider(input.Position.X)
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if sliding and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            UpdateSlider(input.Position.X)
        end
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            sliding = false
        end
    end)
    
    container.MouseEnter:Connect(function()
        Tween(container, {BackgroundTransparency = 0.1}, 0.15)
    end)
    container.MouseLeave:Connect(function()
        Tween(container, {BackgroundTransparency = 0.3}, 0.15)
    end)
    
    return container
end

-- Dropdown
local function CreateDropdown(parent, text, settingKey, options, order, callback)
    local container = Create("Frame", {
        Size = UDim2.new(1, 0, 0, 34),
        BackgroundColor3 = Colors.Section,
        BackgroundTransparency = 0.3,
        BorderSizePixel = 0,
        LayoutOrder = order or 0,
        ClipsDescendants = false,
        Parent = parent
    })
    AddCorner(container, 6)
    
    local label = Create("TextLabel", {
        Size = UDim2.new(0.5, 0, 1, 0),
        Position = UDim2.new(0, 12, 0, 0),
        BackgroundTransparency = 1,
        Text = text,
        TextColor3 = Colors.Text,
        TextSize = 12,
        Font = Enum.Font.Gotham,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = container
    })
    
    local dropBtn = Create("TextButton", {
        Size = UDim2.new(0.45, -12, 0, 26),
        Position = UDim2.new(0.55, 0, 0, 4),
        BackgroundColor3 = Colors.Dropdown,
        Text = "  " .. (Settings[settingKey] or options[1]) .. "  ▼",
        TextColor3 = Colors.Accent,
        TextSize = 11,
        Font = Enum.Font.GothamSemibold,
        TextXAlignment = Enum.TextXAlignment.Center,
        Parent = container
    })
    AddCorner(dropBtn, 5)
    AddStroke(dropBtn, Colors.SectionBorder, 1, 0.5)
    
    local dropList = Create("Frame", {
        Size = UDim2.new(0.45, -12, 0, #options * 28 + 4),
        Position = UDim2.new(0.55, 0, 1, 2),
        BackgroundColor3 = Colors.BackgroundDark,
        BorderSizePixel = 0,
        Visible = false,
        ZIndex = 50,
        ClipsDescendants = true,
        Parent = container
    })
    AddCorner(dropList, 6)
    AddStroke(dropList, Colors.Accent, 1, 0.5)
    
    local dropOpen = false
    
    for i, option in ipairs(options) do
        local optBtn = Create("TextButton", {
            Size = UDim2.new(1, -4, 0, 26),
            Position = UDim2.new(0, 2, 0, (i-1) * 28 + 2),
            BackgroundColor3 = Colors.Section,
            BackgroundTransparency = 1,
            Text = option,
            TextColor3 = Colors.Text,
            TextSize = 11,
            Font = Enum.Font.Gotham,
            ZIndex = 51,
            Parent = dropList
        })
        AddCorner(optBtn, 4)
        
        optBtn.MouseEnter:Connect(function()
            Tween(optBtn, {BackgroundTransparency = 0.3}, 0.1)
        end)
        optBtn.MouseLeave:Connect(function()
            Tween(optBtn, {BackgroundTransparency = 1}, 0.1)
        end)
        
        optBtn.MouseButton1Click:Connect(function()
            Settings[settingKey] = option
            dropBtn.Text = "  " .. option .. "  ▼"
            dropList.Visible = false
            dropOpen = false
            if callback then callback(option) end
        end)
    end
    
    dropBtn.MouseButton1Click:Connect(function()
        dropOpen = not dropOpen
        dropList.Visible = dropOpen
    end)
    
    container.MouseEnter:Connect(function()
        Tween(container, {BackgroundTransparency = 0.1}, 0.15)
    end)
    container.MouseLeave:Connect(function()
        Tween(container, {BackgroundTransparency = 0.3}, 0.15)
    end)
    
    return container
end

-- Button
local function CreateButton(parent, text, order, callback)
    local btn = Create("TextButton", {
        Size = UDim2.new(1, 0, 0, 34),
        BackgroundColor3 = Colors.Accent,
        BackgroundTransparency = 0.3,
        Text = text,
        TextColor3 = Colors.Text,
        TextSize = 12,
        Font = Enum.Font.GothamSemibold,
        LayoutOrder = order or 0,
        Parent = parent
    })
    AddCorner(btn, 6)
    AddGradient(btn, Colors.Gradient1, Colors.Gradient2, 0)
    
    btn.MouseEnter:Connect(function()
        Tween(btn, {BackgroundTransparency = 0}, 0.15)
    end)
    btn.MouseLeave:Connect(function()
        Tween(btn, {BackgroundTransparency = 0.3}, 0.15)
    end)
    btn.MouseButton1Click:Connect(function()
        if callback then callback() end
        -- Click animation
        Tween(btn, {Size = UDim2.new(0.98, 0, 0, 32)}, 0.05)
        wait(0.05)
        Tween(btn, {Size = UDim2.new(1, 0, 0, 34)}, 0.1)
    end)
    
    return btn
end

-- ═══════════════════════════════════════════
-- CREATE TABS
-- ═══════════════════════════════════════════
local AimbotPage = CreateTab("Aimbot", 1)
local ESPPage = CreateTab("ESP", 2)
local PlayerPage = CreateTab("Player", 3)
local VisualsPage = CreateTab("Visuals", 4)
local MiscPage = CreateTab("Misc", 5)

-- ═══════════════════════════════════════════
-- AIMBOT TAB
-- ═══════════════════════════════════════════
CreateSection(AimbotPage, "Aimbot Settings", 1)
CreateToggle(AimbotPage, "Enable Aimbot", "AimbotEnabled", 2)
CreateToggle(AimbotPage, "Silent Aim", "SilentAim", 3)
CreateSlider(AimbotPage, "FOV Size", "AimFOV", 10, 500, 4)
CreateSlider(AimbotPage, "Smoothing", "AimSmoothing", 1, 20, 5)
CreateToggle(AimbotPage, "Show FOV Circle", "ShowFOVCircle", 6)
CreateDropdown(AimbotPage, "Aim Part", "AimPart", {"Head", "HumanoidRootPart", "Torso", "UpperTorso"}, 7)
CreateDropdown(AimbotPage, "Target Mode", "TargetMode", {"Closest", "LowestHP", "Random"}, 8)

CreateSection(AimbotPage, "Checks", 9)
CreateToggle(AimbotPage, "Team Check", "TeamCheck", 10)
CreateToggle(AimbotPage, "Wall Check (Visibility)", "WallCheck", 11)

CreateSection(AimbotPage, "Prediction", 12)
CreateToggle(AimbotPage, "Prediction", "PredictionEnabled", 13)
CreateSlider(AimbotPage, "Prediction Amount", "PredictionAmount", 0, 50, 14) -- stored as int, /100 for actual

-- ═══════════════════════════════════════════
-- ESP TAB
-- ═══════════════════════════════════════════
CreateSection(ESPPage, "ESP Settings", 1)
CreateToggle(ESPPage, "Enable ESP", "ESPEnabled", 2)
CreateToggle(ESPPage, "Boxes", "ESPBoxes", 3)
CreateToggle(ESPPage, "Names", "ESPNames", 4)
CreateToggle(ESPPage, "Health Bars", "ESPHealth", 5)
CreateToggle(ESPPage, "Distance", "ESPDistance", 6)
CreateToggle(ESPPage, "Tracers", "ESPTracers", 7)
CreateToggle(ESPPage, "Skeletons", "ESPSkeletons", 8)
CreateToggle(ESPPage, "Chams (Highlight)", "ESPChams", 9)

CreateSection(ESPPage, "ESP Options", 10)
CreateSlider(ESPPage, "Max Distance", "ESPMaxDistance", 100, 5000, 11)
CreateToggle(ESPPage, "Team Check", "ESPTeamCheck", 12)
CreateDropdown(ESPPage, "Tracer Origin", "TracerOrigin", {"Bottom", "Center", "Top"}, 13)

-- ═══════════════════════════════════════════
-- PLAYER TAB
-- ═══════════════════════════════════════════
CreateSection(PlayerPage, "Movement", 1)
CreateToggle(PlayerPage, "Speed Hack", "SpeedEnabled", 2)
CreateSlider(PlayerPage, "Walk Speed", "Speed", 16, 500, 3)
CreateToggle(PlayerPage, "Jump Hack", "JumpEnabled", 4)
CreateSlider(PlayerPage, "Jump Power", "JumpPower", 50, 500, 5)
CreateToggle(PlayerPage, "Infinite Jump", "InfiniteJump", 6)

CreateSection(PlayerPage, "Flight", 7)
CreateToggle(PlayerPage, "Fly", "Fly", 8)
CreateSlider(PlayerPage, "Fly Speed", "FlySpeed", 10, 300, 9)
CreateToggle(PlayerPage, "Noclip", "Noclip", 10)

-- ═══════════════════════════════════════════
-- VISUALS TAB
-- ═══════════════════════════════════════════
CreateSection(VisualsPage, "World", 1)
CreateToggle(VisualsPage, "Fullbright", "Fullbright", 2)
CreateToggle(VisualsPage, "No Fog", "NoFog", 3)

CreateSection(VisualsPage, "Crosshair", 4)
CreateToggle(VisualsPage, "Custom Crosshair", "CrosshairEnabled", 5)
CreateSlider(VisualsPage, "Crosshair Size", "CrosshairSize", 3, 30, 6)
CreateSlider(VisualsPage, "Crosshair Thickness", "CrosshairThickness", 1, 5, 7)
CreateSlider(VisualsPage, "Crosshair Gap", "CrosshairGap", 0, 20, 8)

-- ═══════════════════════════════════════════
-- MISC TAB
-- ═══════════════════════════════════════════
CreateSection(MiscPage, "Utilities", 1)
CreateToggle(MiscPage, "Anti-AFK", "AntiAFK", 2)
CreateButton(MiscPage, "Rejoin Server", 3, function()
    game:GetService("TeleportService"):Teleport(game.PlaceId, LocalPlayer)
end)
CreateButton(MiscPage, "Copy Server Link", 4, function()
    if setclipboard then
        setclipboard("roblox://experiences/start?placeId=" .. game.PlaceId .. "&gameInstanceId=" .. game.JobId)
    end
end)
CreateButton(MiscPage, "Reset Character", 5, function()
    if LocalPlayer.Character then
        LocalPlayer.Character:BreakJoints()
    end
end)

CreateSection(MiscPage, "Info", 6)
local infoText = Create("TextLabel", {
    Size = UDim2.new(1, 0, 0, 80),
    BackgroundColor3 = Colors.Section,
    BackgroundTransparency = 0.3,
    Text = "  IMPERIUM v2.1\n  CS2-Style Cheat Suite\n  Mobile & Desktop\n  Press RightShift to toggle menu",
    TextColor3 = Colors.TextDim,
    TextSize = 11,
    Font = Enum.Font.Gotham,
    TextXAlignment = Enum.TextXAlignment.Left,
    TextYAlignment = Enum.TextYAlignment.Center,
    LayoutOrder = 7,
    Parent = MiscPage
})
AddCorner(infoText, 6)

CreateButton(MiscPage, "🔴 Destroy GUI", 8, function()
    ScreenGui:Destroy()
end)

-- Default tab
SwitchTab("Aimbot")

-- ═══════════════════════════════════════════
-- TOGGLE MENU VISIBILITY
-- ═══════════════════════════════════════════
local menuOpen = true

local function ToggleMenu()
    menuOpen = not menuOpen
    if menuOpen then
        MainFrame.Visible = true
        MainFrame.Size = UDim2.new(0, 580, 0, 0)
        Tween(MainFrame, {Size = UDim2.new(0, 580, 0, 440)}, 0.3, Enum.EasingStyle.Back)
    else
        Tween(MainFrame, {Size = UDim2.new(0, 580, 0, 0)}, 0.2)
        wait(0.2)
        MainFrame.Visible = false
    end
end

ToggleButton.MouseButton1Click:Connect(ToggleMenu)
CloseBtn.MouseButton1Click:Connect(ToggleMenu)
MinBtn.MouseButton1Click:Connect(ToggleMenu)

UserInputService.InputBegan:Connect(function(input, processed)
    if processed then return end
    if input.KeyCode == Enum.KeyCode.RightShift or input.KeyCode == Enum.KeyCode.Insert then
        ToggleMenu()
    end
end)

-- ═══════════════════════════════════════════
-- CHEAT ENGINE — FOV CIRCLE
-- ═══════════════════════════════════════════
local FOVCircle = Drawing.new("Circle")
FOVCircle.Thickness = 1.5
FOVCircle.NumSides = 64
FOVCircle.Filled = false
FOVCircle.Transparency = 0.7
FOVCircle.Color = Colors.Accent
FOVCircle.Visible = false

-- ═══════════════════════════════════════════
-- CHEAT ENGINE — CROSSHAIR
-- ═══════════════════════════════════════════
local CrosshairLines = {}
for i = 1, 4 do
    CrosshairLines[i] = Drawing.new("Line")
    CrosshairLines[i].Color = Colors.Accent
    CrosshairLines[i].Thickness = 2
    CrosshairLines[i].Visible = false
end

-- ═══════════════════════════════════════════
-- CHEAT ENGINE — ESP STORAGE
-- ═══════════════════════════════════════════
local ESPObjects = {}

local function CreateESPForPlayer(player)
    if player == LocalPlayer then return end
    if ESPObjects[player] then return end
    
    local esp = {}
    
    -- Box
    esp.BoxOutline = Drawing.new("Square")
    esp.BoxOutline.Thickness = 3
    esp.BoxOutline.Color = Color3.new(0,0,0)
    esp.BoxOutline.Filled = false
    esp.BoxOutline.Visible = false
    
    esp.Box = Drawing.new("Square")
    esp.Box.Thickness = 1.5
    esp.Box.Color = Settings.BoxColor
    esp.Box.Filled = false
    esp.Box.Visible = false
    
    -- Name
    esp.Name = Drawing.new("Text")
    esp.Name.Size = 13
    esp.Name.Center = true
    esp.Name.Outline = true
    esp.Name.Color = Settings.NameColor
    esp.Name.Font = 2
    esp.Name.Visible = false
    
    -- Distance
    esp.Distance = Drawing.new("Text")
    esp.Distance.Size = 12
    esp.Distance.Center = true
    esp.Distance.Outline = true
    esp.Distance.Color = Colors.TextDim
    esp.Distance.Font = 2
    esp.Distance.Visible = false
    
    -- Health bar
    esp.HealthBarBG = Drawing.new("Square")
    esp.HealthBarBG.Thickness = 1
    esp.HealthBarBG.Color = Color3.new(0,0,0)
    esp.HealthBarBG.Filled = true
    esp.HealthBarBG.Visible = false
    esp.HealthBarBG.Transparency = 0.5
    
    esp.HealthBar = Drawing.new("Square")
    esp.HealthBar.Thickness = 1
    esp.HealthBar.Color = Colors.Success
    esp.HealthBar.Filled = true
    esp.HealthBar.Visible = false
    
    -- Tracer
    esp.Tracer = Drawing.new("Line")
    esp.Tracer.Thickness = 1.5
    esp.Tracer.Color = Settings.TracerColor
    esp.Tracer.Visible = false
    
    -- Skeleton lines (simplified: 5 major lines)
    esp.Skeleton = {}
    for i = 1, 10 do
        esp.Skeleton[i] = Drawing.new("Line")
        esp.Skeleton[i].Thickness = 1.5
        esp.Skeleton[i].Color = Settings.SkeletonColor
        esp.Skeleton[i].Visible = false
    end
    
    -- Chams (Highlight)
    esp.Highlight = nil
    
    ESPObjects[player] = esp
end

local function RemoveESPForPlayer(player)
    local esp = ESPObjects[player]
    if not esp then return end
    
    for _, prop in pairs(esp) do
        if typeof(prop) == "table" then
            for _, line in pairs(prop) do
                if line.Remove then line:Remove() end
            end
        elseif prop.Remove then
            prop:Remove()
        elseif prop.Destroy and typeof(prop) == "Instance" then
            prop:Destroy()
        end
    end
    ESPObjects[player] = nil
end

local function WorldToScreen(pos)
    local screenPos, onScreen = Camera:WorldToViewportPoint(pos)
    return Vector2.new(screenPos.X, screenPos.Y), onScreen, screenPos.Z
end

local SkeletonConnections = {
    {"Head", "UpperTorso"},
    {"UpperTorso", "LowerTorso"},
    {"UpperTorso", "LeftUpperArm"},
    {"LeftUpperArm", "LeftLowerArm"},
    {"LeftLowerArm", "LeftHand"},
    {"UpperTorso", "RightUpperArm"},
    {"RightUpperArm", "RightLowerArm"},
    {"RightLowerArm", "RightHand"},
    {"LowerTorso", "LeftUpperLeg"},
    {"LeftUpperLeg", "LeftLowerLeg"},
    {"LeftLowerLeg", "LeftFoot"},
    {"LowerTorso", "RightUpperLeg"},
    {"RightUpperLeg", "RightLowerLeg"},
    {"RightLowerLeg", "RightFoot"}
}

-- R6 fallback
local SkeletonConnectionsR6 = {
    {"Head", "Torso"},
    {"Torso", "Left Arm"},
    {"Torso", "Right Arm"},
    {"Torso", "Left Leg"},
    {"Torso", "Right Leg"}
}

-- ═══════════════════════════════════════════
-- AIMBOT FUNCTIONS
-- ═══════════════════════════════════════════
local function IsVisible(origin, target)
    if not Settings.WallCheck then return true end
    local ray = Ray.new(origin, (target - origin).Unit * (target - origin).Magnitude)
    local hit = workspace:FindPartOnRayWithIgnoreList(ray, {LocalPlayer.Character, Camera})
    return hit == nil
end

local function GetClosestTarget()
    local closest = nil
    local shortestDist = Settings.AimFOV
    local lowestHP = math.huge
    
    local mousePos = UserInputService:GetMouseLocation()
    
    local validTargets = {}
    
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            local character = player.Character
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            local aimPart = character:FindFirstChild(Settings.AimPart) or character:FindFirstChild("HumanoidRootPart")
            
            if humanoid and humanoid.Health > 0 and aimPart then
                -- Team check
                if Settings.TeamCheck and player.Team == LocalPlayer.Team then
                    continue
                end
                
                local screenPos, onScreen = WorldToScreen(aimPart.Position)
                
                if onScreen then
                    local dist = (mousePos - screenPos).Magnitude
                    
                    if dist <= Settings.AimFOV then
                        -- Wall check
                        if Settings.WallCheck then
                            local camPos = Camera.CFrame.Position
                            if not IsVisible(camPos, aimPart.Position) then
                                continue
                            end
                        end
                        
                        table.insert(validTargets, {
                            Player = player,
                            Character = character,
                            Part = aimPart,
                            ScreenPos = screenPos,
                            Distance = dist,
                            HP = humanoid.Health
                        })
                    end
                end
            end
        end
    end
    
    if #validTargets == 0 then return nil end
    
    if Settings.TargetMode == "Closest" then
        for _, t in ipairs(validTargets) do
            if t.Distance < shortestDist then
                shortestDist = t.Distance
                closest = t
            end
        end
    elseif Settings.TargetMode == "LowestHP" then
        for _, t in ipairs(validTargets) do
            if t.HP < lowestHP then
                lowestHP = t.HP
                closest = t
            end
        end
    elseif Settings.TargetMode == "Random" then
        closest = validTargets[math.random(1, #validTargets)]
    end
    
    return closest
end

-- ═══════════════════════════════════════════
-- FLYING SYSTEM
-- ═══════════════════════════════════════════
local flyBV = nil
local flyBG = nil

local function StartFly()
    local char = LocalPlayer.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hrp or not hum then return end
    
    hum.PlatformStand = true
    
    flyBV = Instance.new("BodyVelocity")
    flyBV.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
    flyBV.Velocity = Vector3.new(0, 0, 0)
    flyBV.Parent = hrp
    
    flyBG = Instance.new("BodyGyro")
    flyBG.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
    flyBG.D = 200
    flyBG.P = 40000
    flyBG.Parent = hrp
end

local function StopFly()
    local char = LocalPlayer.Character
    if char then
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then hum.PlatformStand = false end
    end
    if flyBV then flyBV:Destroy() flyBV = nil end
    if flyBG then flyBG:Destroy() flyBG = nil end
end

-- ═══════════════════════════════════════════
-- NOTIFICATION SYSTEM
-- ═══════════════════════════════════════════
local NotifFrame = Create("Frame", {
    Size = UDim2.new(0, 300, 1, 0),
    Position = UDim2.new(1, -310, 0, 0),
    BackgroundTransparency = 1,
    Parent = ScreenGui
})

local NotifLayout = Create("UIListLayout", {
    SortOrder = Enum.SortOrder.LayoutOrder,
    Padding = UDim.new(0, 5),
    VerticalAlignment = Enum.VerticalAlignment.Bottom,
    Parent = NotifFrame
})
AddPadding(NotifFrame, 0, 60, 0, 0)

local function Notify(title, message, duration)
    local notif = Create("Frame", {
        Size = UDim2.new(1, 0, 0, 60),
        BackgroundColor3 = Colors.BackgroundDark,
        BackgroundTransparency = 0.1,
        BorderSizePixel = 0,
        Parent = NotifFrame
    })
    AddCorner(notif, 8)
    AddStroke(notif, Colors.Accent, 1, 0.5)
    
    local accentBar = Create("Frame", {
        Size = UDim2.new(0, 3, 0.7, 0),
        Position = UDim2.new(0, 8, 0.15, 0),
        BackgroundColor3 = Colors.Accent,
        BorderSizePixel = 0,
        Parent = notif
    })
    AddCorner(accentBar, 2)
    
    Create("TextLabel", {
        Size = UDim2.new(1, -25, 0, 20),
        Position = UDim2.new(0, 18, 0, 8),
        BackgroundTransparency = 1,
        Text = title,
        TextColor3 = Colors.Accent,
        TextSize = 12,
        Font = Enum.Font.GothamBold,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = notif
    })
    
    Create("TextLabel", {
        Size = UDim2.new(1, -25, 0, 20),
        Position = UDim2.new(0, 18, 0, 28),
        BackgroundTransparency = 1,
        Text = message,
        TextColor3 = Colors.TextDim,
        TextSize = 11,
        Font = Enum.Font.Gotham,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = notif
    })
    
    -- Animate in
    notif.Position = UDim2.new(1, 50, 0, 0)
    Tween(notif, {Position = UDim2.new(0, 0, 0, 0)}, 0.3, Enum.EasingStyle.Back)
    
    -- Progress bar
    local progress = Create("Frame", {
        Size = UDim2.new(1, -16, 0, 2),
        Position = UDim2.new(0, 8, 1, -6),
        BackgroundColor3 = Colors.Accent,
        BorderSizePixel = 0,
        Parent = notif
    })
    AddCorner(progress, 1)
    
    Tween(progress, {Size = UDim2.new(0, 0, 0, 2)}, duration or 3, Enum.EasingStyle.Linear)
    
    delay(duration or 3, function()
        Tween(notif, {Position = UDim2.new(1, 50, 0, 0)}, 0.3)
        wait(0.35)
        notif:Destroy()
    end)
end

-- Startup notification
delay(0.5, function()
    Notify("IMPERIUM", "Cheat suite loaded successfully!", 4)
end)

-- ═══════════════════════════════════════════
-- MAIN RENDER LOOP
-- ═══════════════════════════════════════════
local holdingAim = false

UserInputService.InputBegan:Connect(function(input, processed)
    if processed then return end
    if input.UserInputType == Enum.UserInputType.MouseButton2 then
        holdingAim = true
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton2 then
        holdingAim = false
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
if Settings.AntiAFK then
    local vu = game:GetService("VirtualUser")
    LocalPlayer.Idled:Connect(function()
        vu:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
        wait(1)
        vu:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
    end)
end

-- Player connections
Players.PlayerAdded:Connect(function(player)
    CreateESPForPlayer(player)
end)
Players.PlayerRemoving:Connect(function(player)
    RemoveESPForPlayer(player)
end)
for _, player in ipairs(Players:GetPlayers()) do
    CreateESPForPlayer(player)
end

RunService.RenderStepped:Connect(function()
    local char = LocalPlayer.Character
    local cam = Camera
    
    -- ═══ FOV CIRCLE ═══
    if Settings.ShowFOVCircle and Settings.AimbotEnabled then
        FOVCircle.Visible = true
        FOVCircle.Position = UserInputService:GetMouseLocation()
        FOVCircle.Radius = Settings.AimFOV
        FOVCircle.Color = Colors.Accent
    else
        FOVCircle.Visible = false
    end
    
    -- ═══ CROSSHAIR ═══
    if Settings.CrosshairEnabled then
        local center = cam.ViewportSize / 2
        local size = Settings.CrosshairSize
        local gap = Settings.CrosshairGap
        local thick = Settings.CrosshairThickness
        
        -- Top
        CrosshairLines[1].From = Vector2.new(center.X, center.Y - gap)
        CrosshairLines[1].To = Vector2.new(center.X, center.Y - gap - size)
        -- Bottom
        CrosshairLines[2].From = Vector2.new(center.X, center.Y + gap)
        CrosshairLines[2].To = Vector2.new(center.X, center.Y + gap + size)
        -- Left
        CrosshairLines[3].From = Vector2.new(center.X - gap, center.Y)
        CrosshairLines[3].To = Vector2.new(center.X - gap - size, center.Y)
        -- Right
        CrosshairLines[4].From = Vector2.new(center.X + gap, center.Y)
        CrosshairLines[4].To = Vector2.new(center.X + gap + size, center.Y)
        
        for i = 1, 4 do
            CrosshairLines[i].Visible = true
            CrosshairLines[i].Color = Settings.CrosshairColor
            CrosshairLines[i].Thickness = thick
        end
    else
        for i = 1, 4 do
            CrosshairLines[i].Visible = false
        end
    end
    
    -- ═══ AIMBOT ═══
    if Settings.AimbotEnabled and holdingAim then
        local target = GetClosestTarget()
        if target then
            local aimPos = target.Part.Position
            
            -- Prediction
            if Settings.PredictionEnabled then
                local vel = target.Character:FindFirstChild("HumanoidRootPart")
                if vel then
                    aimPos = aimPos + vel.Velocity * (Settings.PredictionAmount / 100)
                end
            end
            
            if not Settings.SilentAim then
                local camCF = cam.CFrame
                local targetCF = CFrame.new(camCF.Position, aimPos)
                local smoothed = camCF:Lerp(targetCF, 1 / Settings.AimSmoothing)
                cam.CFrame = smoothed
            end
        end
    end
    
    -- ═══ SILENT AIM (hook mouse target) ═══
    -- Note: Actual silent aim requires exploit-level hooks (namecall/newindex)
    -- This is a visual representation
    
    -- ═══ PLAYER MODIFICATIONS ═══
    if char then
        local hum = char:FindFirstChildOfClass("Humanoid")
        local hrp = char:FindFirstChild("HumanoidRootPart")
        
        if hum then
            -- Speed
            if Settings.SpeedEnabled then
                hum.WalkSpeed = Settings.Speed
            end
            
            -- Jump
            if Settings.JumpEnabled then
                hum.JumpPower = Settings.JumpPower
                hum.UseJumpPower = true
            end
        end
        
        -- Noclip
        if Settings.Noclip and char then
            for _, part in ipairs(char:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end
        
        -- Fly
        if Settings.Fly and hrp then
            if not flyBV then StartFly() end
            
            local direction = Vector3.new(0, 0, 0)
            if UserInputService:IsKeyDown(Enum.KeyCode.W) then
                direction = direction + cam.CFrame.LookVector
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then
                direction = direction - cam.CFrame.LookVector
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then
                direction = direction - cam.CFrame.RightVector
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then
                direction = direction + cam.CFrame.RightVector
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
                direction = direction + Vector3.new(0, 1, 0)
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
                direction = direction - Vector3.new(0, 1, 0)
            end
            
            if flyBV then
                flyBV.Velocity = direction * Settings.FlySpeed
            end
            if flyBG then
                flyBG.CFrame = cam.CFrame
            end
        else
            if flyBV then StopFly() end
        end
    end
    
    -- ═══ VISUALS ═══
    if Settings.Fullbright then
        game:GetService("Lighting").Brightness = 2
        game:GetService("Lighting").ClockTime = 14
        game:GetService("Lighting").FogEnd = 100000
        game:GetService("Lighting").GlobalShadows = false
        game:GetService("Lighting").OutdoorAmbient = Color3.fromRGB(128, 128, 128)
    end
    
    if Settings.NoFog then
        game:GetService("Lighting").FogEnd = 100000
        game:GetService("Lighting").FogStart = 100000
    end
    
    -- ═══ ESP RENDERING ═══
    for player, esp in pairs(ESPObjects) do
        local character = player.Character
        local humanoid = character and character:FindFirstChildOfClass("Humanoid")
        local hrp = character and character:FindFirstChild("HumanoidRootPart")
        local head = character and character:FindFirstChild("Head")
        
        local shouldShow = Settings.ESPEnabled and character and humanoid and hrp and humanoid.Health > 0
        
        -- Team check
        if shouldShow and Settings.ESPTeamCheck and player.Team == LocalPlayer.Team then
            shouldShow = false
        end
        
        -- Distance check
        if shouldShow and char then
            local myHRP = char:FindFirstChild("HumanoidRootPart")
            if myHRP then
                local dist = (hrp.Position - myHRP.Position).Magnitude
                if dist > Settings.ESPMaxDistance then
                    shouldShow = false
                end
            end
        end
        
        if shouldShow then
            local rootPos, onScreen, depth = WorldToScreen(hrp.Position)
            local headPos = head and WorldToScreen(head.Position + Vector3.new(0, 0.5, 0))
            
            if onScreen and depth > 0 then
                -- Calculate box dimensions
                local scaleFactor = 1 / (depth * math.tan(math.rad(cam.FieldOfView / 2)) * 2 / cam.ViewportSize.Y)
                local boxHeight = math.clamp(scaleFactor * 5.5, 20, 800)
                local boxWidth = boxHeight * 0.55
                
                local topLeft = Vector2.new(rootPos.X - boxWidth / 2, rootPos.Y - boxHeight / 2)
                local boxSize = Vector2.new(boxWidth, boxHeight)
                
                -- Box
                if Settings.ESPBoxes then
                    esp.BoxOutline.Visible = true
                    esp.BoxOutline.Position = topLeft - Vector2.new(1, 1)
                    esp.BoxOutline.Size = boxSize + Vector2.new(2, 2)
                    
                    esp.Box.Visible = true
                    esp.Box.Position = topLeft
                    esp.Box.Size = boxSize
                    
                    -- Color based on health
                    local hpRatio = humanoid.Health / humanoid.MaxHealth
                    esp.Box.Color = Color3.fromRGB(255 * (1 - hpRatio), 255 * hpRatio, 50)
                else
                    esp.Box.Visible = false
                    esp.BoxOutline.Visible = false
                end
                
                -- Name
                if Settings.ESPNames then
                    esp.Name.Visible = true
                    esp.Name.Position = Vector2.new(rootPos.X, topLeft.Y - 16)
                    esp.Name.Text = player.DisplayName
                    esp.Name.Color = Settings.NameColor
                else
                    esp.Name.Visible = false
                end
                
                -- Distance
                if Settings.ESPDistance and char then
                    local myHRP = char:FindFirstChild("HumanoidRootPart")
                    if myHRP then
                        local dist = math.floor((hrp.Position - myHRP.Position).Magnitude)
                        esp.Distance.Visible = true
                        esp.Distance.Position = Vector2.new(rootPos.X, topLeft.Y + boxHeight + 2)
                        esp.Distance.Text = dist .. "m"
                    end
                else
                    esp.Distance.Visible = false
                end
                
                -- Health bar
                if Settings.ESPHealth then
                    local hpRatio = math.clamp(humanoid.Health / humanoid.MaxHealth, 0, 1)
                    local barHeight = boxHeight
                    local barX = topLeft.X - 6
                    
                    esp.HealthBarBG.Visible = true
                    esp.HealthBarBG.Position = Vector2.new(barX, topLeft.Y)
                    esp.HealthBarBG.Size = Vector2.new(3, barHeight)
                    
                    esp.HealthBar.Visible = true
                    esp.HealthBar.Position = Vector2.new(barX, topLeft.Y + barHeight * (1 - hpRatio))
                    esp.HealthBar.Size = Vector2.new(3, barHeight * hpRatio)
                    esp.HealthBar.Color = Color3.fromRGB(255 * (1 - hpRatio), 255 * hpRatio, 0)
                else
                    esp.HealthBarBG.Visible = false
                    esp.HealthBar.Visible = false
                end
                
                -- Tracers
                if Settings.ESPTracers then
                    esp.Tracer.Visible = true
                    esp.Tracer.Color = Settings.TracerColor
                    
                    local fromY
                    if Settings.TracerOrigin == "Bottom" then
                        esp.Tracer.From = Vector2.new(cam.ViewportSize.X / 2, cam.ViewportSize.Y)
                    elseif Settings.TracerOrigin == "Center" then
                        esp.Tracer.From = Vector2.new(cam.ViewportSize.X / 2, cam.ViewportSize.Y / 2)
                    else
                        esp.Tracer.From = Vector2.new(cam.ViewportSize.X / 2, 0)
                    end
                    esp.Tracer.To = Vector2.new(rootPos.X, rootPos.Y + boxHeight / 2)
                else
                    esp.Tracer.Visible = false
                end
                
                -- Skeletons
                if Settings.ESPSkeletons then
                    local connections = SkeletonConnections
                    -- Detect R6 vs R15
                    if character:FindFirstChild("Torso") and not character:FindFirstChild("UpperTorso") then
                        connections = SkeletonConnectionsR6
                    end
                    
                    for i, conn in ipairs(connections) do
                        if esp.Skeleton[i] then
                            local part1 = character:FindFirstChild(conn[1])
                            local part2 = character:FindFirstChild(conn[2])
                            
                            if part1 and part2 then
                                local p1, on1 = WorldToScreen(part1.Position)
                                local p2, on2 = WorldToScreen(part2.Position)
                                
                                if on1 and on2 then
                                    esp.Skeleton[i].Visible = true
                                    esp.Skeleton[i].From = p1
                                    esp.Skeleton[i].To = p2
                                    esp.Skeleton[i].Color = Settings.SkeletonColor
                                else
                                    esp.Skeleton[i].Visible = false
                                end
                            else
                                esp.Skeleton[i].Visible = false
                            end
                        end
                    end
                else
                    for i = 1, #esp.Skeleton do
                        esp.Skeleton[i].Visible = false
                    end
                end
                
                -- Chams
                if Settings.ESPChams then
                    if not esp.Highlight or not esp.Highlight.Parent then
                        esp.Highlight = Instance.new("Highlight")
                        esp.Highlight.FillColor = Settings.ChamsColor
                        esp.Highlight.FillTransparency = 0.5
                        esp.Highlight.OutlineColor = Colors.Accent
                        esp.Highlight.OutlineTransparency = 0.3
                        esp.Highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                        esp.Highlight.Adornee = character
                        esp.Highlight.Parent = character
                    end
                else
                    if esp.Highlight and esp.Highlight.Parent then
                        esp.Highlight:Destroy()
                        esp.Highlight = nil
                    end
                end
            else
                -- Off screen - hide everything
                esp.Box.Visible = false
                esp.BoxOutline.Visible = false
                esp.Name.Visible = false
                esp.Distance.Visible = false
                esp.HealthBar.Visible = false
                esp.HealthBarBG.Visible = false
                esp.Tracer.Visible = false
                for i = 1, #esp.Skeleton do
                    esp.Skeleton[i].Visible = false
                end
            end
        else
            -- Not showing - hide everything
            esp.Box.Visible = false
            esp.BoxOutline.Visible = false
            esp.Name.Visible = false
            esp.Distance.Visible = false
            esp.HealthBar.Visible = false
            esp.HealthBarBG.Visible = false
            esp.Tracer.Visible = false
            for i = 1, #esp.Skeleton do
                esp.Skeleton[i].Visible = false
            end
            if esp.Highlight and esp.Highlight.Parent then
                esp.Highlight:Destroy()
                esp.Highlight = nil
            end
        end
    end
end)

-- ═══════════════════════════════════════════
-- CLEANUP ON DESTROY
-- ═══════════════════════════════════════════
ScreenGui.Destroying:Connect(function()
    FOVCircle:Remove()
    for i = 1, 4 do
        CrosshairLines[i]:Remove()
    end
    for player, esp in pairs(ESPObjects) do
        RemoveESPForPlayer(player)
    end
    StopFly()
end)

-- ═══════════════════════════════════════════
-- WATERMARK
-- ═══════════════════════════════════════════
local Watermark = Create("Frame", {
    Size = UDim2.new(0, 260, 0, 28),
    Position = UDim2.new(0, 10, 0, 10),
    BackgroundColor3 = Colors.BackgroundDark,
    BackgroundTransparency = 0.2,
    BorderSizePixel = 0,
    Parent = ScreenGui
})
AddCorner(Watermark, 6)
AddStroke(Watermark, Colors.Accent, 1, 0.6)

local WatermarkText = Create("TextLabel", {
    Size = UDim2.new(1, 0, 1, 0),
    BackgroundTransparency = 1,
    Text = "IMPERIUM v2.1 | " .. LocalPlayer.Name .. " | 0ms",
    TextColor3 = Colors.Text,
    TextSize = 11,
    Font = Enum.Font.GothamSemibold,
    Parent = Watermark
})

-- Update watermark with FPS/ping
spawn(function()
    while wait(0.5) do
        if Watermark.Parent then
            local fps = math.floor(1 / RunService.RenderStepped:Wait())
            local ping = math.floor(game:GetService("Stats"):FindFirstChild("PerformanceStats") and game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue() or 0)
            WatermarkText.Text = string.format("IMPERIUM v2.1 | %s | %dfps | %dms", LocalPlayer.Name, fps, ping)
        end
    end
end)

print("[IMPERIUM] ✅ Loaded successfully!")
print("[IMPERIUM] Press RightShift or Insert to toggle menu")
print("[IMPERIUM] Mobile: Use the floating 'I' button")
