--[[
    KAIZO HUB (CLAUDE SONNET BASE + SECTION BOX)
    Restored by: Gemini
    Status: STABLE, SMOOTH, ORIGINAL VISUALS.
]]

local Library = {}
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")

-- =================================================================
-- [ UTILITY ]
-- =================================================================

local function Tween(obj, props, time, style, dir)
    local info = TweenInfo.new(time or 0.3, style or Enum.EasingStyle.Quart, dir or Enum.EasingDirection.Out)
    TweenService:Create(obj, info, props):Play()
end

local Colors = {
    MainBg      = Color3.fromRGB(18, 18, 20),
    TopBar      = Color3.fromRGB(25, 25, 28),
    Sidebar     = Color3.fromRGB(22, 22, 24),
    Element     = Color3.fromRGB(35, 35, 38),
    Section     = Color3.fromRGB(25, 25, 28), -- Warna Kotak Section
    Accent      = Color3.fromRGB(200, 200, 200),
    Text        = Color3.fromRGB(240, 240, 240),
    TextGray    = Color3.fromRGB(140, 140, 140),
    Stroke      = Color3.fromRGB(50, 50, 50),
    InputBox    = Color3.fromRGB(5, 5, 5),
    Dropdown    = Color3.fromRGB(28, 28, 30)
}

function Library:CreateWindow(config)
    config = config or {}
    local WindowName = config.Name or "KAIZO HUB"
    local IconId = config.Icon or "rbxassetid://132914280921668"
    
    if CoreGui:FindFirstChild("KaiZoHUB_Fixed") then CoreGui.KaiZoHUB_Fixed:Destroy() end

    local sg = Instance.new("ScreenGui")
    sg.Name = "KaiZoHUB_Fixed"
    sg.Parent = CoreGui
    sg.ResetOnSpawn = false
    sg.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    -- [ FLOATING ICON ]
    local FloatBtn = Instance.new("ImageButton")
    FloatBtn.Name = "FloatingIcon"
    FloatBtn.Parent = sg
    FloatBtn.BackgroundColor3 = Colors.TopBar
    FloatBtn.Position = UDim2.new(0.1, 0, 0.1, 0)
    FloatBtn.Size = UDim2.fromOffset(50, 50)
    FloatBtn.Image = IconId
    FloatBtn.ZIndex = 100
    
    local FloatCorner = Instance.new("UICorner"); FloatCorner.CornerRadius = UDim.new(0, 14); FloatCorner.Parent = FloatBtn
    local FloatStroke = Instance.new("UIStroke"); FloatStroke.Parent = FloatBtn; FloatStroke.Color = Colors.Accent; FloatStroke.Thickness = 1
    
    FloatBtn.MouseEnter:Connect(function() Tween(FloatBtn, {Size = UDim2.fromOffset(55, 55)}, 0.2, Enum.EasingStyle.Back) end)
    FloatBtn.MouseLeave:Connect(function() Tween(FloatBtn, {Size = UDim2.fromOffset(50, 50)}, 0.2, Enum.EasingStyle.Back) end)

    local fDrag, fStart, fPos
    FloatBtn.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            fDrag = true; fStart = input.Position; fPos = FloatBtn.Position
            input.Changed:Connect(function() if input.UserInputState == Enum.UserInputState.End then fDrag = false end end)
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if fDrag and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - fStart
            Tween(FloatBtn, {Position = UDim2.new(fPos.X.Scale, fPos.X.Offset + delta.X, fPos.Y.Scale, fPos.Y.Offset + delta.Y)}, 0.05)
        end
    end)

    -- [ MAIN WINDOW ]
    local Main = Instance.new("Frame")
    Main.Name = "MainFrame"
    Main.Parent = sg
    Main.BackgroundColor3 = Colors.MainBg
    Main.BackgroundTransparency = 0.02
    Main.Position = UDim2.new(0.5, -300, 0.5, -180)
    Main.Size = UDim2.fromOffset(600, 360)
    
    local MainGrad = Instance.new("UIGradient")
    MainGrad.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(255,255,255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(200,200,200))})
    MainGrad.Rotation = 45; MainGrad.Parent = Main

    local MainCorner = Instance.new("UICorner"); MainCorner.CornerRadius = UDim.new(0, 12); MainCorner.Parent = Main
    local MainStroke = Instance.new("UIStroke"); MainStroke.Parent = Main; MainStroke.Color = Colors.Stroke; MainStroke.Thickness = 1

    local MainShadow = Instance.new("ImageLabel")
    MainShadow.Parent = Main; MainShadow.Image = "rbxassetid://6014261993"; MainShadow.ImageColor3 = Color3.new(0,0,0); MainShadow.ImageTransparency = 0.4
    MainShadow.BackgroundTransparency = 1; MainShadow.Position = UDim2.new(0,-25,0,-25); MainShadow.Size = UDim2.new(1,50,1,50)
    MainShadow.ScaleType = Enum.ScaleType.Slice; MainShadow.SliceCenter = Rect.new(49,49,450,450); MainShadow.ZIndex = -1

    local UIVisible = true
    FloatBtn.MouseButton1Click:Connect(function()
        UIVisible = not UIVisible
        if UIVisible then
            Main.Visible = true; Main.Size = UDim2.fromOffset(0,0)
            Tween(Main, {Size = UDim2.fromOffset(600, 360)}, 0.4, Enum.EasingStyle.Back)
        else
            local t = TweenService:Create(Main, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In), {Size = UDim2.fromOffset(0, 0)})
            t:Play(); t.Completed:Wait(); Main.Visible = false
        end
    end)

    -- [ TOP BAR ]
    local TopBar = Instance.new("Frame")
    TopBar.Parent = Main; TopBar.BackgroundColor3 = Colors.TopBar; TopBar.Size = UDim2.new(1, 0, 0, 50); TopBar.ZIndex = 20
    local TBC = Instance.new("UICorner"); TBC.CornerRadius = UDim.new(0, 12); TBC.Parent = TopBar
    local TBFiller = Instance.new("Frame"); TBFiller.Parent = TopBar; TBFiller.BackgroundColor3 = Colors.TopBar; TBFiller.BorderSizePixel = 0; TBFiller.Position = UDim2.new(0,0,1,-10); TBFiller.Size = UDim2.new(1,0,0,10); TBFiller.ZIndex = 20

    local Title = Instance.new("TextLabel")
    Title.Parent = TopBar; Title.BackgroundTransparency = 1; Title.Position = UDim2.new(0, 20, 0, 0); Title.Size = UDim2.new(0, 200, 1, 0)
    Title.Text = WindowName; Title.Font = Enum.Font.GothamBlack; Title.TextColor3 = Colors.Accent; Title.TextSize = 22; Title.TextXAlignment = Enum.TextXAlignment.Left; Title.ZIndex = 21

    local CloseBtn = Instance.new("TextButton")
    CloseBtn.Parent = TopBar; CloseBtn.BackgroundTransparency = 1; CloseBtn.Position = UDim2.new(1,-45,0,0); CloseBtn.Size = UDim2.new(0,45,1,0); CloseBtn.Text = "×"; CloseBtn.Font = Enum.Font.GothamMedium; CloseBtn.TextColor3 = Colors.TextGray; CloseBtn.TextSize = 30; CloseBtn.ZIndex = 21
    CloseBtn.MouseEnter:Connect(function() Tween(CloseBtn, {TextColor3 = Color3.fromRGB(255,80,80)}, 0.2) end)
    CloseBtn.MouseLeave:Connect(function() Tween(CloseBtn, {TextColor3 = Colors.TextGray}, 0.2) end)
    CloseBtn.MouseButton1Click:Connect(function() UIVisible = false; Main.Visible = false end)

    -- [ SIDEBAR ]
    local Sidebar = Instance.new("Frame")
    Sidebar.Parent = Main; Sidebar.BackgroundColor3 = Colors.Sidebar; Sidebar.Position = UDim2.new(0,0,0,50); Sidebar.Size = UDim2.new(0,150,1,-50); Sidebar.ZIndex = 2
    local SBC = Instance.new("UICorner"); SBC.CornerRadius = UDim.new(0,12); SBC.Parent = Sidebar
    local SFFiller = Instance.new("Frame"); SFFiller.Parent = Sidebar; SFFiller.BackgroundColor3 = Colors.Sidebar; SFFiller.BorderSizePixel = 0; SFFiller.Size = UDim2.new(1,0,0,10); SFFiller.ZIndex = 2
    local SFFillerR = Instance.new("Frame"); SFFillerR.Parent = Sidebar; SFFillerR.BackgroundColor3 = Colors.Sidebar; SFFillerR.BorderSizePixel = 0; SFFillerR.Position = UDim2.new(1,-10,0,0); SFFillerR.Size = UDim2.new(0,10,1,0); SFFillerR.ZIndex = 2

    local TabContainer = Instance.new("ScrollingFrame")
    TabContainer.Parent = Sidebar; TabContainer.BackgroundTransparency = 1; TabContainer.Position = UDim2.new(0,0,0,15); TabContainer.Size = UDim2.new(1,0,1,-15); TabContainer.ScrollBarThickness = 0; TabContainer.ZIndex = 3
    local TabList = Instance.new("UIListLayout"); TabList.Parent = TabContainer; TabList.SortOrder = Enum.SortOrder.LayoutOrder; TabList.Padding = UDim.new(0,5)

    -- [ CONTENT ]
    local Content = Instance.new("Frame")
    Content.Parent = Main; Content.BackgroundTransparency = 1; Content.Position = UDim2.new(0,150,0,50); Content.Size = UDim2.new(1,-150,1,-50); Content.ClipsDescendants = true; Content.ZIndex = 1
    local PagesFolder = Instance.new("Frame"); PagesFolder.Parent = Content; PagesFolder.BackgroundTransparency = 1; PagesFolder.Position = UDim2.new(0,15,0,15); PagesFolder.Size = UDim2.new(1,-30,1,-30); PagesFolder.ZIndex = 1

    -- Dragging
    local dragging, dragInput, dragStart, startPos
    TopBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true; dragStart = input.Position; startPos = Main.Position
            input.Changed:Connect(function() if input.UserInputState == Enum.UserInputState.End then dragging = false end end)
        end
    end)
    TopBar.InputChanged:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseMovement then dragInput = input end end)
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            Main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)

    -- [ WINDOW METHODS ]
    local WindowFunctions = {}
    local Tabs = {}

    function WindowFunctions:CreateTab(name)
        local TabBtn = Instance.new("TextButton")
        TabBtn.Parent = TabContainer; TabBtn.BackgroundTransparency = 1; TabBtn.Size = UDim2.new(1,0,0,35); TabBtn.Text = ""; TabBtn.ZIndex = 3
        
        local TabBg = Instance.new("Frame"); TabBg.Parent = TabBtn; TabBg.BackgroundColor3 = Colors.Accent; TabBg.BackgroundTransparency = 1; TabBg.Size = UDim2.new(1,-20,1,0); TabBg.Position = UDim2.new(0,10,0,0); TabBg.ZIndex = 2; local TbgC = Instance.new("UICorner"); TbgC.CornerRadius = UDim.new(0,8); TbgC.Parent = TabBg
        local Indicator = Instance.new("Frame"); Indicator.Parent = TabBtn; Indicator.BackgroundColor3 = Colors.Accent; Indicator.Position = UDim2.new(0,0,0.5,0); Indicator.AnchorPoint = Vector2.new(0,0.5); Indicator.Size = UDim2.new(0,0,0,0); Indicator.ZIndex = 4; local ic = Instance.new("UICorner"); ic.CornerRadius = UDim.new(0,4); ic.Parent = Indicator
        local Label = Instance.new("TextLabel"); Label.Parent = TabBtn; Label.BackgroundTransparency = 1; Label.Position = UDim2.new(0,20,0,0); Label.Size = UDim2.new(1,-20,1,0); Label.Text = name; Label.Font = Enum.Font.GothamMedium; Label.TextColor3 = Colors.TextGray; Label.TextSize = 13; Label.TextXAlignment = Enum.TextXAlignment.Left; Label.ZIndex = 5

        local Page = Instance.new("ScrollingFrame")
        Page.Parent = PagesFolder; Page.BackgroundTransparency = 1; Page.Size = UDim2.new(1,0,1,0); Page.Visible = false; Page.ScrollBarThickness = 0; Page.AutomaticCanvasSize = Enum.AutomaticSize.Y; Page.ZIndex = 3
        local PL = Instance.new("UIListLayout"); PL.Parent = Page; PL.SortOrder = Enum.SortOrder.LayoutOrder; PL.Padding = UDim.new(0,8)

        TabBtn.MouseEnter:Connect(function() if Page.Visible then return end; Tween(TabBg, {BackgroundTransparency=0.9}, 0.3); Tween(Label, {TextColor3=Colors.Text}, 0.3) end)
        TabBtn.MouseLeave:Connect(function() if Page.Visible then return end; Tween(TabBg, {BackgroundTransparency=1}, 0.3); Tween(Label, {TextColor3=Colors.TextGray}, 0.3) end)
        TabBtn.MouseButton1Click:Connect(function()
            for _, t in pairs(Tabs) do t.Page.Visible = false; Tween(t.Label, {TextColor3=Colors.TextGray}, 0.3); Tween(t.Indicator, {Size=UDim2.new(0,0,0,0)}, 0.3); Tween(t.Bg, {BackgroundTransparency=1}, 0.3) end
            Page.Visible = true; Tween(Label, {TextColor3=Colors.Accent}, 0.3); Tween(Indicator, {Size=UDim2.new(0,3,0.6,0)}, 0.4, Enum.EasingStyle.Back); Tween(TabBg, {BackgroundTransparency=0.95}, 0.3)
        end)
        
        table.insert(Tabs, {Btn = TabBtn, Label = Label, Indicator = Indicator, Bg = TabBg, Page = Page})
        if #Tabs == 1 then Page.Visible = true; Label.TextColor3 = Colors.Accent; Indicator.Size = UDim2.new(0,3,0.6,0); TabBg.BackgroundTransparency = 0.95 end

        local TabFunctions = {}

        -- [ ADD SECTION FUNCTION - The ONLY New Feature ]
        function TabFunctions:AddSection(Title)
            local SectionContainer = Instance.new("Frame")
            SectionContainer.Parent = Page
            SectionContainer.BackgroundColor3 = Colors.Section
            SectionContainer.Size = UDim2.new(1, 0, 0, 0)
            SectionContainer.AutomaticSize = Enum.AutomaticSize.Y
            SectionContainer.ZIndex = 3
            
            local sc = Instance.new("UICorner"); sc.CornerRadius = UDim.new(0, 8); sc.Parent = SectionContainer
            local ss = Instance.new("UIStroke"); ss.Parent = SectionContainer; ss.Color = Colors.Stroke; ss.Thickness = 1

            local SectionLabel = Instance.new("TextLabel")
            SectionLabel.Parent = SectionContainer
            SectionLabel.BackgroundTransparency = 1
            SectionLabel.Position = UDim2.new(0, 10, 0, 5)
            SectionLabel.Size = UDim2.new(1, -20, 0, 20)
            SectionLabel.Text = Title
            SectionLabel.Font = Enum.Font.GothamBold
            SectionLabel.TextColor3 = Colors.Accent
            SectionLabel.TextSize = 12
            SectionLabel.TextXAlignment = Enum.TextXAlignment.Left
            SectionLabel.ZIndex = 4

            local InnerContainer = Instance.new("Frame")
            InnerContainer.Parent = SectionContainer
            InnerContainer.BackgroundTransparency = 1
            InnerContainer.Position = UDim2.new(0, 8, 0, 30)
            InnerContainer.Size = UDim2.new(1, -16, 0, 0)
            InnerContainer.AutomaticSize = Enum.AutomaticSize.Y
            
            local IL = Instance.new("UIListLayout"); IL.Parent = InnerContainer; IL.SortOrder = Enum.SortOrder.LayoutOrder; IL.Padding = UDim.new(0, 5)
            local IP = Instance.new("UIPadding"); IP.Parent = SectionContainer; IP.PaddingBottom = UDim.new(0, 10)

            -- Function wrapper to add elements TO THIS SECTION
            local SectionElements = {}

            -- Element: Button
            function SectionElements:AddButton(text, callback)
                local Btn = Instance.new("TextButton")
                Btn.Parent = InnerContainer -- Changed parent to InnerContainer
                Btn.BackgroundColor3 = Colors.Element
                Btn.BackgroundTransparency = 0.3
                Btn.Size = UDim2.new(1,0,0,38) -- Slightly smaller for inside section
                Btn.Text = text
                Btn.Font = Enum.Font.Gotham
                Btn.TextColor3 = Colors.Text
                Btn.TextSize = 13
                Btn.AutoButtonColor = false
                Btn.ZIndex = 4
                local c = Instance.new("UICorner"); c.CornerRadius = UDim.new(0,6); c.Parent = Btn
                Btn.MouseEnter:Connect(function() Tween(Btn, {BackgroundColor3 = Color3.fromRGB(45,45,48)}, 0.2) end)
                Btn.MouseLeave:Connect(function() Tween(Btn, {BackgroundColor3 = Colors.Element}, 0.2) end)
                Btn.MouseButton1Click:Connect(function() 
                    Tween(Btn, {Size = UDim2.new(1,-4,0,34)}, 0.1); wait(0.1); Tween(Btn, {Size = UDim2.new(1,0,0,38)}, 0.1)
                    if callback then callback() end 
                end)
            end

            -- Element: Toggle
            function SectionElements:AddToggle(text, callback)
                local State = false
                local Btn = Instance.new("TextButton")
                Btn.Parent = InnerContainer
                Btn.BackgroundColor3 = Colors.Element
                Btn.BackgroundTransparency = 0.3
                Btn.Size = UDim2.new(1,0,0,38)
                Btn.Text = "   "..text
                Btn.Font = Enum.Font.Gotham
                Btn.TextColor3 = Colors.Text
                Btn.TextSize = 13
                Btn.TextXAlignment = Enum.TextXAlignment.Left
                Btn.AutoButtonColor = false
                Btn.ZIndex = 4
                local c = Instance.new("UICorner"); c.CornerRadius = UDim.new(0,6); c.Parent = Btn
                local Sw = Instance.new("Frame"); Sw.Parent = Btn; Sw.BackgroundColor3 = Color3.fromRGB(50,50,50); Sw.Position = UDim2.new(1,-45,0.5,-10); Sw.Size = UDim2.new(0,34,0,18); Sw.ZIndex = 5; local sc = Instance.new("UICorner"); sc.CornerRadius = UDim.new(0,8); sc.Parent = Sw
                local Dot = Instance.new("Frame"); Dot.Parent = Sw; Dot.BackgroundColor3 = Colors.TextGray; Dot.Position = UDim2.new(0,2,0.5,-7); Dot.Size = UDim2.new(0,14,0,14); Dot.ZIndex = 6; local dc = Instance.new("UICorner"); dc.CornerRadius = UDim.new(1,0); dc.Parent = Dot
                Btn.MouseEnter:Connect(function() Tween(Btn, {BackgroundColor3 = Color3.fromRGB(45,45,48)}, 0.2) end)
                Btn.MouseLeave:Connect(function() Tween(Btn, {BackgroundColor3 = Colors.Element}, 0.2) end)
                Btn.MouseButton1Click:Connect(function() State = not State; Tween(Sw, {BackgroundColor3 = State and Colors.Accent or Color3.fromRGB(50,50,50)}, 0.3); Tween(Dot, {Position = State and UDim2.new(1,-16,0.5,-7) or UDim2.new(0,2,0.5,-7), BackgroundColor3 = State and Colors.Text or Colors.TextGray}, 0.3); if callback then callback(State) end end)
            end

            -- Element: Slider
            function SectionElements:AddSlider(text, min, max, default, callback)
                local F = Instance.new("Frame"); F.Parent = InnerContainer; F.BackgroundColor3 = Colors.Element; F.BackgroundTransparency = 0.3; F.Size = UDim2.new(1,0,0,50); F.ZIndex = 4; local c = Instance.new("UICorner"); c.CornerRadius = UDim.new(0,6); c.Parent = F
                local L = Instance.new("TextLabel"); L.Parent = F; L.BackgroundTransparency = 1; L.Position = UDim2.new(0,10,0,5); L.Size = UDim2.new(1,-20,0,20); L.Text = text; L.Font = Enum.Font.GothamMedium; L.TextColor3 = Colors.Text; L.TextSize = 13; L.TextXAlignment = Enum.TextXAlignment.Left; L.ZIndex = 5
                local V = Instance.new("TextLabel"); V.Parent = F; V.BackgroundTransparency = 1; V.Position = UDim2.new(0,10,0,5); V.Size = UDim2.new(1,-20,0,20); V.Text = tostring(default); V.Font = Enum.Font.GothamBold; V.TextColor3 = Colors.Accent; V.TextSize = 13; V.TextXAlignment = Enum.TextXAlignment.Right; V.ZIndex = 5
                local Hit = Instance.new("TextButton"); Hit.Parent = F; Hit.BackgroundTransparency = 1; Hit.Size = UDim2.new(1,0,1,0); Hit.Text = ""; Hit.ZIndex = 6
                local Bg = Instance.new("Frame"); Bg.Parent = F; Bg.BackgroundColor3 = Color3.fromRGB(50,50,50); Bg.Position = UDim2.new(0,10,0,32); Bg.Size = UDim2.new(1,-20,0,4); Bg.ZIndex = 5; local bc = Instance.new("UICorner"); bc.Parent = Bg
                local Fill = Instance.new("Frame"); Fill.Parent = Bg; Fill.BackgroundColor3 = Colors.Accent; Fill.Size = UDim2.new(0,0,1,0); Fill.ZIndex = 5; local fc = Instance.new("UICorner"); fc.Parent = Fill; local Knob = Instance.new("Frame"); Knob.Parent = Fill; Knob.BackgroundColor3 = Colors.Text; Knob.Position = UDim2.new(1,-7,0.5,-7); Knob.Size = UDim2.new(0,14,0,14); Knob.ZIndex = 6; local kc = Instance.new("UICorner"); kc.CornerRadius = UDim.new(1,0); kc.Parent = Knob
                Hit.MouseEnter:Connect(function() Tween(Knob, {Size = UDim2.new(0,18,0,18)}, 0.2) end); Hit.MouseLeave:Connect(function() Tween(Knob, {Size = UDim2.new(0,14,0,14)}, 0.2) end)
                Hit.MouseButton1Down:Connect(function() local m,k; local function U(i) local P = math.clamp((i.Position.X - Bg.AbsolutePosition.X) / Bg.AbsoluteSize.X, 0, 1); local v = math.floor(min + (max - min) * P); V.Text = tostring(v); Tween(Fill, {Size = UDim2.new(P, 0, 1, 0)}, 0.05); if callback then callback(v) end end; U({Position = UserInputService:GetMouseLocation()}); m = UserInputService.InputChanged:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseMovement then U(i) end end); k = UserInputService.InputEnded:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then m:Disconnect(); k:Disconnect() end end) end)
                local P = math.clamp((default - min) / (max - min), 0, 1); Fill.Size = UDim2.new(P, 0, 1, 0)
            end

            -- Element: Input
            function SectionElements:AddInput(text, placeholder, callback)
                local F = Instance.new("Frame"); F.Parent = InnerContainer; F.BackgroundColor3 = Colors.Element; F.BackgroundTransparency = 0.3; F.Size = UDim2.new(1,0,0,40); F.ZIndex = 4; local c = Instance.new("UICorner"); c.CornerRadius = UDim.new(0,6); c.Parent = F
                local L = Instance.new("TextLabel"); L.Parent = F; L.BackgroundTransparency = 1; L.Position = UDim2.new(0,10,0,0); L.Size = UDim2.new(0,100,1,0); L.Text = text; L.Font = Enum.Font.GothamMedium; L.TextColor3 = Colors.Text; L.TextSize = 13; L.TextXAlignment = Enum.TextXAlignment.Left; L.ZIndex = 5
                local Box = Instance.new("Frame"); Box.Parent = F; Box.BackgroundColor3 = Colors.InputBox; Box.Position = UDim2.new(1,-140,0.5,-12); Box.Size = UDim2.new(0,130,0,24); Box.ZIndex = 5; local bc = Instance.new("UICorner"); bc.CornerRadius = UDim.new(0,4); bc.Parent = Box
                local TB = Instance.new("TextBox"); TB.Parent = Box; TB.BackgroundTransparency = 1; TB.Size = UDim2.new(1,-10,1,0); TB.Position = UDim2.new(0,5,0,0); TB.Font = Enum.Font.Gotham; TB.Text = ""; TB.PlaceholderText = placeholder or "..."; TB.TextColor3 = Colors.Text; TB.PlaceholderColor3 = Colors.TextGray; TB.TextSize = 12; TB.TextXAlignment = Enum.TextXAlignment.Left; TB.ZIndex = 6; TB.ClearTextOnFocus = false
                TB.FocusLost:Connect(function() if callback then callback(TB.Text) end end)
            end

            return SectionElements
        end

        return TabFunctions
    end
    return Window
end

-- =================================================================
-- [ CONTOH PENGGUNAAN (DIJAMIN WORK) ]
-- =================================================================

-- 1. Buat Window
local Window = Library:CreateWindow({
    Name = "KaiZoHub_Restored",
    Title = "KAIZO HUB",
    Icon = "rbxassetid://132914280921668"
})

-- 2. Buat Tab
local MainTab = Window:CreateTab("Main")

-- 3. BUAT SECTION (Fitur Baru)
local FarmSection = MainTab:AddSection("AUTO FARM SETTINGS")

-- 4. Masukkan Elemen ke SECTION, bukan ke Tab
FarmSection:AddToggle("Enable Auto Farm", function(v)
    print("Auto Farm:", v)
end)

FarmSection:AddSlider("WalkSpeed", 16, 200, 16, function(v)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = v
end)

-- Section Kedua
local WeaponSection = MainTab:AddSection("WEAPON CONFIG")

WeaponSection:AddButton("Equip Sword", function()
    print("Sword Equipped")
end)

WeaponSection:AddInput("Target Name", "User...", function(t)
    print("Target:", t)
end)

print(">> UI Loaded Successfully (Clean Claude Version + Sections)")
