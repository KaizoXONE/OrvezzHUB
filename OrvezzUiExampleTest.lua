--[[
    OrvezX UI Library - Complete Example & Demo
    
    This file demonstrates all available UI components and features
    of the OrvezX UI Library with glassmorphism design.
    
    Author: OrvezX
    Version: 1.0
    Theme: Black & Orange Glassmorphism
]]

-- Load UI Library (replace with your GitHub raw URL)
local OrvezX = loadstring(game:HttpGet("https://raw.githubusercontent.com/YOUR_USERNAME/OrvezHUB/main/UI/Orvezz.lua"))()

-- Create Main Window
local Window = OrvezX:Window({
    Title = "OrvezX Hub",
    Footer = "Demo v1.0",
    Color = Color3.fromRGB(255, 140, 0),  -- Orange theme
    ["Tab Width"] = 120,
    Version = 1
})

--[[
    EXAMPLE NOTIFICATION
    Show a welcome notification
]]
OrvezX:MakeNotify({
    Title = "Welcome!",
    Description = "OrvezX Hub",
    Content = "UI Library loaded successfully!",
    Color = Color3.fromRGB(0, 255, 0),
    Time = 0.5,
    Delay = 5
})

-- ========================================
-- TAB 1: Main Features
-- ========================================
local MainTab = Window:AddTab({
    Name = "Main",
    Icon = "star"
})

MainTab:AddSection({
    Name = "Auto Farm Features"
})

MainTab:AddToggle({
    Name = "Auto Farm",
    Default = false,
    Callback = function(Value)
        _G.AutoFarm = Value
        print("Auto Farm:", Value)
        
        if Value then
            OrvezX("Auto Farm Enabled", 3, Color3.fromRGB(0, 255, 0), "Success", "Feature")
        else
            OrvezX("Auto Farm Disabled", 3, Color3.fromRGB(255, 0, 0), "Info", "Feature")
        end
    end
})

MainTab:AddToggle({
    Name = "Auto Collect",
    Default = false,
    Callback = function(Value)
        _G.AutoCollect = Value
        print("Auto Collect:", Value)
    end
})

MainTab:AddSection({
    Name = "Speed Settings"
})

MainTab:AddSlider({
    Name = "Walk Speed",
    Min = 16,
    Max = 100,
    Default = 16,
    Callback = function(Value)
        local player = game.Players.LocalPlayer
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            player.Character.Humanoid.WalkSpeed = Value
        end
    end
})

MainTab:AddSlider({
    Name = "Jump Power",
    Min = 50,
    Max = 200,
    Default = 50,
    Callback = function(Value)
        local player = game.Players.LocalPlayer
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            player.Character.Humanoid.JumpPower = Value
        end
    end
})

-- ========================================
-- TAB 2: Teleport
-- ========================================
local TeleportTab = Window:AddTab({
    Name = "Teleport",
    Icon = "gps"
})

TeleportTab:AddSection({
    Name = "Common Locations"
})

TeleportTab:AddButton({
    Name = "Teleport to Spawn",
    Callback = function()
        local player = game.Players.LocalPlayer
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            player.Character.HumanoidRootPart.CFrame = CFrame.new(0, 50, 0)
            OrvezX("Teleported to Spawn!", 2, Color3.fromRGB(255, 140, 0))
        end
    end
})

TeleportTab:AddButton({
    Name = "Teleport to Shop",
    Callback = function()
        -- Add your teleport coordinates here
        print("Teleporting to Shop...")
        OrvezX("Feature coming soon!", 2, Color3.fromRGB(255, 140, 0))
    end
})

TeleportTab:AddSection({
    Name = "Custom Position"
})

local TeleportX = 0
local TeleportY = 50
local TeleportZ = 0

TeleportTab:AddInput({
    Name = "X Coordinate",
    PlaceholderText = "Enter X position",
    Default = "0",
    Callback = function(Value)
        TeleportX = tonumber(Value) or 0
    end
})

TeleportTab:AddInput({
    Name = "Y Coordinate",
    PlaceholderText = "Enter Y position",
    Default = "50",
    Callback = function(Value)
        TeleportY = tonumber(Value) or 50
    end
})

TeleportTab:AddInput({
    Name = "Z Coordinate",
    PlaceholderText = "Enter Z position",
    Default = "0",
    Callback = function(Value)
        TeleportZ = tonumber(Value) or 0
    end
})

TeleportTab:AddButton({
    Name = "Teleport to Custom Position",
    Callback = function()
        local player = game.Players.LocalPlayer
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            player.Character.HumanoidRootPart.CFrame = CFrame.new(TeleportX, TeleportY, TeleportZ)
            OrvezX("Teleported!", 2, Color3.fromRGB(0, 255, 0))
        end
    end
})

-- ========================================
-- TAB 3: Settings
-- ========================================
local SettingsTab = Window:AddTab({
    Name = "Settings",
    Icon = "settings"
})

SettingsTab:AddSection({
    Name = "UI Settings"
})

SettingsTab:AddDropdown({
    Name = "UI Theme",
    Options = {"Orange (Default)", "Blue", "Green", "Red", "Purple"},
    Default = "Orange (Default)",
    Callback = function(Value)
        print("Theme selected:", Value)
        -- You can implement theme changing here
        OrvezX("Theme changed to " .. Value, 2, Color3.fromRGB(255, 140, 0))
    end
})

SettingsTab:AddToggle({
    Name = "Notifications",
    Default = true,
    Callback = function(Value)
        _G.NotificationsEnabled = Value
        print("Notifications:", Value)
    end
})

SettingsTab:AddSection({
    Name = "Performance"
})

SettingsTab:AddDropdown({
    Name = "Graphics Quality",
    Options = {"Low", "Medium", "High", "Ultra"},
    Default = "Medium",
    Callback = function(Value)
        print("Graphics Quality:", Value)
        -- Implement graphics settings here
    end
})

SettingsTab:AddSection({
    Name = "Danger Zone"
})

SettingsTab:AddButton({
    Name = "Reset Character",
    Callback = function()
        local player = game.Players.LocalPlayer
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            player.Character.Humanoid.Health = 0
            OrvezX("Character Reset!", 2, Color3.fromRGB(255, 0, 0), "Warning", "Action")
        end
    end
})

-- ========================================
-- TAB 4: Info
-- ========================================
local InfoTab = Window:AddTab({
    Name = "Info",
    Icon = "question"
})

InfoTab:AddSection({
    Name = "About This Hub"
})

InfoTab:AddLabel({
    Text = "OrvezX Hub - Modern UI Library"
})

InfoTab:AddLabel({
    Text = "Version: 1.0"
})

InfoTab:AddLabel({
    Text = "Theme: Black & Orange Glassmorphism"
})

InfoTab:AddSection({
    Name = "Player Information"
})

local player = game.Players.LocalPlayer
InfoTab:AddLabel({
    Text = "Username: " .. player.Name
})

InfoTab:AddLabel({
    Text = "Display Name: " .. player.DisplayName
})

InfoTab:AddLabel({
    Text = "User ID: " .. player.UserId
})

InfoTab:AddSection({
    Name = "Game Information"
})

local gameInfo = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId)
InfoTab:AddLabel({
    Text = "Game: " .. gameInfo.Name
})

InfoTab:AddSection({
    Name = "Shortcuts"
})

InfoTab:AddLabel({
    Text = "F3 - Toggle UI Visibility"
})

InfoTab:AddButton({
    Name = "Copy Discord Link",
    Callback = function()
        setclipboard("https://discord.gg/YOUR_DISCORD")
        OrvezX("Discord link copied!", 2, Color3.fromRGB(88, 101, 242), "Discord", "Copied")
    end
})

-- ========================================
-- DEMO COMPLETE
-- ========================================
print("=================================")
print("OrvezX UI Library Demo Loaded!")
print("Press F3 to toggle UI visibility")
print("=================================")

-- Final notification
wait(1)
OrvezX:MakeNotify({
    Title = "Demo Ready!",
    Description = "All Components Loaded",
    Content = "Explore all tabs to see UI features in action!",
    Color = Color3.fromRGB(255, 140, 0),
    Time = 0.5,
    Delay = 6
})
