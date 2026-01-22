--[[
    KAIZO UI LIBRARY (V15 - Stable Root Method)
    Author: KaizoX
    Fixes: Blank Screen, Un-draggable Window, White Corners
]]

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")

local Library = {}

-- [CONFIG]
local Config = {
    Colors = {
        MainBg = Color3.fromRGB(20, 20, 22),      -- Agak terang dikit biar gak pitch black
        TopBar = Color3.fromRGB(30, 30, 35),      -- Beda warna biar kelihatan header
        Sidebar = Color3.fromRGB(25, 25, 28),
        Element = Color3.fromRGB(40, 40, 45),
        Accent = Color3.fromRGB(255, 255, 255),   -- Putih bersih
        Text = Color3.fromRGB(240, 240, 240),
        TextGray = Color3.fromRGB(150, 150, 150),
        Input = Color3.fromRGB(10, 10, 10),
        Dropdown = Color3.fromRGB(35, 35, 35)
    },
    Icons = {
        Home = "rbxassetid://10709782497",
        Settings = "rbxassetid://10734950309",
        User = "rbxassetid://10709782963",
        Sword = "rbxassetid://10709781460",
        Eye = "rbxassetid://10709782172",
        Menu = "rbxassetid://10709783095"
    }
}

local function Tween(obj, props, time)
    TweenService:Create(obj, TweenInfo.new(time or 0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), props):Play()
end

function Library:CreateWindow(Settings)
    local Window = {}
    
    -- Cleanup Old UI
    if CoreGui:FindFirstChild(Settings.Name or "KaiZoUI") then
        CoreGui[Settings.Name or "KaiZoUI"]:Destroy()
    end

    local sg = Instance.new("ScreenGui")
    sg.Name = Settings.Name or "KaiZoUI"
    sg.Parent = CoreGui
    sg.ResetOnSpawn = false
    sg.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    -- [FLOATING TOGGLE]
    local FloatBtn = Instance.new("ImageButton")
    FloatBtn.Parent = sg
    FloatBtn.BackgroundColor3 = Config.Colors.TopBar
    FloatBtn.Position = UDim2.new(0.1, 0, 0.1, 0)
    FloatBtn.Size = UDim2.fromOffset(50, 50)
    FloatBtn.Image = Settings.Icon or Config.Icons.Menu
    local fc = Instance.new("UICorner"); fc.CornerRadius = UDim.new(0, 14); fc.Parent = FloatBtn
    local fs = Instance.new("UIStroke"); fs.Parent = FloatBtn; fs.Color = Config.Colors.Accent; fs.Thickness = 1
    
    -- Drag Float
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

    -- [ROOT CONTAINER] (Invisible, Holds Position)
    local Root = Instance.new("Frame")
    Root.Name = "RootFrame"
    Root.Parent = sg
    Root.BackgroundTransparency = 1
    Root.Position = UDim2.new(0.5, -300, 0.5, -180)
    Root.Size = UDim2.fromOffset(600, 360)

    -- [SHADOW] (Behind everything)
    local Shadow = Instance.new("ImageLabel")
    Shadow.Parent = Root
    Shadow.Image = "rbxassetid://6014261993"
    Shadow.ImageColor3 = Color3.new(0,0,0)
    Shadow.ImageTransparency = 0.4
    Shadow.BackgroundTransparency = 1
    Shadow.Position = UDim2.new(0, -35, 0, -35)
    Shadow.Size = UDim2.new(1, 70, 1, 70)
    Shadow.ScaleType = Enum.ScaleType.Slice
    Shadow.SliceCenter = Rect.new(49, 49, 450, 450)
    Shadow.ZIndex = 1 -- Layer paling bawah

    -- [MAIN VISUAL FRAME] (Clipped, Rounded)
    local Main = Instance.new("Frame")
    Main.Name = "MainVisual"
    Main.Parent = Root
    Main.BackgroundColor3 = Config.Colors.MainBg
    Main.Size = UDim2.new(1, 0, 1, 0)
    Main.ClipsDescendants = true -- Agar tidak ada sudut putih bocor
    Main.ZIndex = 2
    local mc = Instance.new("UICorner"); mc.CornerRadius = UDim.new(0, 12); mc.Parent = Main
    local ms = Instance.new("UIStroke"); ms.Parent = Main; ms.Color = Color3.fromRGB(60,60,60); ms.Thickness = 1

    -- [TOGGLE VISIBILITY]
    local UIVisible = true
    FloatBtn.MouseButton1Click:Connect(function()
        UIVisible = not UIVisible
        Root.Visible = UIVisible
    end)

    -- [INTERIOR LAYOUT]
    
    -- TopBar
    local TopBar = Instance.new("Frame"); TopBar.Parent = Main; TopBar.BackgroundColor3 = Config.Colors.TopBar; TopBar.Size = UDim2.new(1, 0, 0, 50); TopBar.ZIndex = 5
    local Title = Instance.new("TextLabel"); Title.Parent = TopBar; Title.BackgroundTransparency = 1; Title.Position = UDim2.new(0, 20, 0, 0); Title.Size = UDim2.new(0, 200, 1, 0); Title.Text = Settings.Title or "LIBRARY"; Title.Font = Enum.Font.GothamBlack; Title.TextColor3 = Config.Colors.Accent; Title.TextSize = 22; Title.TextXAlignment = Enum.TextXAlignment.Left; Title.ZIndex = 6
    local CloseBtn = Instance.new("TextButton"); CloseBtn.Parent = TopBar; CloseBtn.BackgroundTransparency = 1; CloseBtn.Position = UDim2.new(1,-45,0,0); CloseBtn.Size = UDim2.new(0,45,1,0); CloseBtn.Text = "×"; CloseBtn.Font = Enum.Font.GothamMedium; CloseBtn.TextColor3 = Config.Colors.TextGray; CloseBtn.TextSize = 30; CloseBtn.ZIndex = 6
    CloseBtn.MouseButton1Click:Connect(function() Root.Visible = false; UIVisible = false end)

    -- TopBar Shadow (Inside Main)
    local TopShadow = Instance.new("ImageLabel"); TopShadow.Parent = Main; TopShadow.Image = "rbxassetid://6015897843"; TopShadow.ImageColor3 = Color3.new(0,0,0); TopShadow.ImageTransparency = 0.5; TopShadow.BackgroundTransparency = 1; TopShadow.Position = UDim2.new(0,0,0,50); TopShadow.Size = UDim2.new(1,0,0,15); TopShadow.ZIndex = 4

    -- Sidebar
    local Sidebar = Instance.new("Frame"); Sidebar.Parent = Main; Sidebar.BackgroundColor3 = Config.Colors.Sidebar; Sidebar.Position = UDim2.new(0,0,0,50); Sidebar.Size = UDim2.new(0,150,1,-50); Sidebar.ZIndex = 3
    local TabContainer = Instance.new("ScrollingFrame"); TabContainer.Parent = Sidebar; TabContainer.BackgroundTransparency = 1; TabContainer.Position = UDim2.new(0,0,0,15); TabContainer.Size = UDim2.new(1,0,1,-15); TabContainer.ScrollBarThickness = 0; TabContainer.ZIndex = 4
    local TabList = Instance.new("UIListLayout"); TabList.Parent = TabContainer; TabList.Padding = UDim.new(0,5)

    -- Content Area
    local Content = Instance.new("Frame"); Content.Parent = Main; Content.BackgroundTransparency = 1; Content.Position = UDim2.new(0,150,0,50); Content.Size = UDim2.new(1,-150,1,-50); Content.ZIndex = 3
    local PagesFolder = Instance.new("Frame"); PagesFolder.Parent = Content; PagesFolder.BackgroundTransparency = 1; PagesFolder.Position = UDim2.new(0,15,0,15); PagesFolder.Size = UDim2.new(1,-30,1,-30); PagesFolder.ZIndex = 3

    -- [DRAG LOGIC FIXED]
    -- Dragging applied to TopBar, moving Root
    local dragging, dragStart, startPos
    TopBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true; dragStart = input.Position; startPos = Root.Position
            input.Changed:Connect(function() if input.UserInputState == Enum.UserInputState.End then dragging = false end end)
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStart
            Tween(Root, {Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)}, 0.05)
        end
    end)

    -- [TABS & ELEMENTS]
    local Tabs = {}
    function Window:AddTab(ConfigData)
        local TabName = ConfigData.Title or "Tab"
        local TabBtn = Instance.new("TextButton"); TabBtn.Parent = TabContainer; TabBtn.BackgroundTransparency = 1; TabBtn.Size = UDim2.new(1,0,0,35); TabBtn.Text = ""; TabBtn.ZIndex = 5
        local TabBg = Instance.new("Frame"); TabBg.Parent = TabBtn; TabBg.BackgroundColor3 = Config.Colors.Accent; TabBg.BackgroundTransparency = 1; TabBg.Size = UDim2.new(1,-20,1,0); TabBg.Position = UDim2.new(0,10,0,0); TabBg.ZIndex = 4; local tc = Instance.new("UICorner"); tc.CornerRadius=UDim.new(0,8); tc.Parent=TabBg
        local Label = Instance.new("TextLabel"); Label.Parent = TabBtn; Label.BackgroundTransparency = 1; Label.Position = UDim2.new(0,42,0,0); Label.Size = UDim2.new(1,-40,1,0); Label.Text = TabName; Label.Font = Enum.Font.GothamMedium; Label.TextColor3 = Config.Colors.TextGray; Label.TextSize = 13; Label.TextXAlignment = Enum.TextXAlignment.Left; Label.ZIndex = 6
        
        -- Icon
        local IconImg = Instance.new("ImageLabel"); IconImg.Parent = TabBtn; IconImg.BackgroundTransparency = 1; IconImg.Position = UDim2.new(0, 15, 0.5, -9); IconImg.Size = UDim2.new(0, 18, 0, 18); IconImg.ImageColor3 = Config.Colors.TextGray; IconImg.ZIndex = 6
        if ConfigData.Icon and Config.Icons[ConfigData.Icon] then IconImg.Image = Config.Icons[ConfigData.Icon] end

        local Page = Instance.new("ScrollingFrame"); Page.Parent = PagesFolder; Page.BackgroundTransparency = 1; Page.Size = UDim2.new(1,0,1,0); Page.Visible = false; Page.ScrollBarThickness = 2; Page.AutomaticCanvasSize = Enum.AutomaticSize.Y; Page.ZIndex = 5
        local PL = Instance.new("UIListLayout"); PL.Parent = Page; PL.SortOrder = Enum.SortOrder.LayoutOrder; PL.Padding = UDim.new(0,8)

        TabBtn.MouseButton1Click:Connect(function()
            for _, t in pairs(Tabs) do t.Page.Visible=false; Tween(t.Label,{TextColor3=Config.Colors.TextGray}); Tween(t.Icon,{ImageColor3=Config.Colors.TextGray}); Tween(t.Bg,{BackgroundTransparency=1}) end
            Page.Visible=true; Tween(Label,{TextColor3=Config.Colors.Accent}); Tween(IconImg,{ImageColor3=Config.Colors.Accent}); Tween(TabBg,{BackgroundTransparency=0.95})
        end)
        table.insert(Tabs, {Btn=TabBtn, Label=Label, Icon=IconImg, Bg=TabBg, Page=Page})
        if #Tabs==1 then Page.Visible=true; Label.TextColor3=Config.Colors.Accent; IconImg.ImageColor3=Config.Colors.Accent; TabBg.BackgroundTransparency=0.95 end

        local Elements = {}
        function Elements:AddButton(Data)
            local Btn = Instance.new("TextButton"); Btn.Parent = Page; Btn.BackgroundColor3 = Config.Colors.Element; Btn.BackgroundTransparency = 0.3; Btn.Size = UDim2.new(1,0,0,42); Btn.Text = Data.Title; Btn.Font = Enum.Font.Gotham; Btn.TextColor3 = Config.Colors.Text; Btn.TextSize = 13; Btn.AutoButtonColor = false; Btn.ZIndex = 6; local c = Instance.new("UICorner"); c.CornerRadius = UDim.new(0,8); c.Parent = Btn
            Btn.MouseButton1Click:Connect(function() Tween(Btn,{Size=UDim2.new(1,-4,0,38)},0.1); task.wait(0.1); Tween(Btn,{Size=UDim2.new(1,0,0,42)},0.1); if Data.Callback then Data.Callback() end end)
        end
        function Elements:AddToggle(Data)
            local State = Data.Default or false
            local Btn = Instance.new("TextButton"); Btn.Parent = Page; Btn.BackgroundColor3 = Config.Colors.Element; Btn.BackgroundTransparency = 0.3; Btn.Size = UDim2.new(1,0,0,42); Btn.Text = "   "..Data.Title; Btn.Font = Enum.Font.Gotham; Btn.TextColor3 = Config.Colors.Text; Btn.TextSize = 13; Btn.TextXAlignment = Enum.TextXAlignment.Left; Btn.AutoButtonColor = false; Btn.ZIndex = 6; local c = Instance.new("UICorner"); c.CornerRadius = UDim.new(0,8); c.Parent = Btn
            local Sw = Instance.new("Frame"); Sw.Parent = Btn; Sw.BackgroundColor3 = State and Config.Colors.Accent or Color3.fromRGB(50,50,50); Sw.Position = UDim2.new(1,-50,0.5,-10); Sw.Size = UDim2.new(0,36,0,20); Sw.ZIndex = 7; local sc = Instance.new("UICorner"); sc.CornerRadius = UDim.new(0,8); sc.Parent = Sw
            local Dot = Instance.new("Frame"); Dot.Parent = Sw; Dot.BackgroundColor3 = State and Config.Colors.Text or Config.Colors.TextGray; Dot.Position = State and UDim2.new(1,-18,0.5,-8) or UDim2.new(0,2,0.5,-8); Dot.Size = UDim2.new(0,16,0,16); Dot.ZIndex = 8; local dc = Instance.new("UICorner"); dc.CornerRadius = UDim.new(1,0); dc.Parent = Dot
            Btn.MouseButton1Click:Connect(function() State = not State; Tween(Sw,{BackgroundColor3=State and Config.Colors.Accent or Color3.fromRGB(50,50,50)}); Tween(Dot,{Position=State and UDim2.new(1,-18,0.5,-8) or UDim2.new(0,2,0.5,-8), BackgroundColor3=State and Config.Colors.Text or Config.Colors.TextGray}); if Data.Callback then Data.Callback(State) end end)
        end
        function Elements:AddInput(Data)
            local F = Instance.new("Frame"); F.Parent = Page; F.BackgroundColor3 = Config.Colors.Element; F.BackgroundTransparency = 0.3; F.Size = UDim2.new(1,0,0,45); F.ZIndex = 6; local c = Instance.new("UICorner"); c.CornerRadius = UDim.new(0,8); c.Parent = F
            local L = Instance.new("TextLabel"); L.Parent = F; L.BackgroundTransparency = 1; L.Position = UDim2.new(0,12,0,0); L.Size = UDim2.new(0,100,1,0); L.Text = Data.Title; L.Font = Enum.Font.GothamMedium; L.TextColor3 = Config.Colors.Text; L.TextSize = 13; L.TextXAlignment = Enum.TextXAlignment.Left; L.ZIndex = 7
            local BoxCon = Instance.new("Frame"); BoxCon.Parent = F; BoxCon.BackgroundColor3 = Config.Colors.Input; BoxCon.BackgroundTransparency=0; BoxCon.Position = UDim2.new(1,-160,0.5,-15); BoxCon.Size = UDim2.new(0,150,0,30); BoxCon.ZIndex = 7; local bc = Instance.new("UICorner"); bc.CornerRadius = UDim.new(0,6); bc.Parent = BoxCon
            local TB = Instance.new("TextBox"); TB.Parent = BoxCon; TB.BackgroundTransparency = 1; TB.Position = UDim2.new(0,8,0,0); TB.Size = UDim2.new(1,-16,1,0); TB.ZIndex = 8; TB.Font = Enum.Font.Gotham; TB.PlaceholderText = Data.Placeholder or "..."; TB.Text = ""; TB.TextColor3 = Config.Colors.Text; TB.PlaceholderColor3 = Config.Colors.TextGray; TB.TextSize = 13; TB.TextXAlignment = Enum.TextXAlignment.Left; TB.ClearTextOnFocus = false
            TB.FocusLost:Connect(function() if Data.Callback then Data.Callback(TB.Text) end end)
        end
        function Elements:AddSlider(Data)
            local F = Instance.new("Frame"); F.Parent = Page; F.BackgroundColor3 = Config.Colors.Element; F.BackgroundTransparency = 0.3; F.Size = UDim2.new(1,0,0,60); F.ZIndex = 6; local c = Instance.new("UICorner"); c.CornerRadius = UDim.new(0,8); c.Parent = F
            local L = Instance.new("TextLabel"); L.Parent = F; L.BackgroundTransparency = 1; L.Position = UDim2.new(0,12,0,5); L.Size = UDim2.new(1,-24,0,20); L.Text = Data.Title; L.Font = Enum.Font.GothamMedium; L.TextColor3 = Config.Colors.Text; L.TextSize = 13; L.TextXAlignment = Enum.TextXAlignment.Left; L.ZIndex = 7
            local V = Instance.new("TextLabel"); V.Parent = F; V.BackgroundTransparency = 1; V.Position = UDim2.new(0,12,0,5); V.Size = UDim2.new(1,-24,0,20); V.Text = tostring(Data.Default or Data.Min); V.Font = Enum.Font.GothamBold; V.TextColor3 = Config.Colors.Accent; V.TextSize = 13; V.TextXAlignment = Enum.TextXAlignment.Right; V.ZIndex = 7
            local Hit = Instance.new("TextButton"); Hit.Parent = F; Hit.BackgroundTransparency = 1; Hit.Size = UDim2.new(1,0,1,0); Hit.Text = ""; Hit.ZIndex = 8
            local Bg = Instance.new("Frame"); Bg.Parent = F; Bg.BackgroundColor3 = Color3.fromRGB(50,50,50); Bg.Position = UDim2.new(0,12,0,40); Bg.Size = UDim2.new(1,-24,0,6); Bg.ZIndex = 7; local bc = Instance.new("UICorner"); bc.Parent = Bg
            local Fill = Instance.new("Frame"); Fill.Parent = Bg; Fill.BackgroundColor3 = Config.Colors.Accent; Fill.Size = UDim2.new(((Data.Default or Data.Min)-Data.Min)/(Data.Max-Data.Min),0,1,0); Fill.ZIndex = 7; local fc = Instance.new("UICorner"); fc.Parent = Fill
            Hit.MouseButton1Down:Connect(function()
                local move, kill; local function Update(input) local P = math.clamp((input.Position.X - Bg.AbsolutePosition.X)/Bg.AbsoluteSize.X,0,1); local Val = math.floor(Data.Min + (Data.Max-Data.Min)*P); V.Text = tostring(Val); Tween(Fill,{Size=UDim2.new(P,0,1,0)},0.05); if Data.Callback then Data.Callback(Val) end end
                Update({Position=UserInputService:GetMouseLocation()}); move=UserInputService.InputChanged:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseMovement then Update(i) end end); kill=UserInputService.InputEnded:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 then move:Disconnect(); kill:Disconnect() end end)
            end)
        end
        return Elements
    end
    return Window
end
return Library
