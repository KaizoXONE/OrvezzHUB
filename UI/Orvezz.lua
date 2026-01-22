--[[
    KAIZO UI LIBRARY (Fixed Visuals & Icons)
    Author: KaizoX
    Version: V13-Module
]]

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")

local Library = {}

-- [CONFIG & ASSETS]
local Config = {
    Colors = {
        MainBg = Color3.fromRGB(18, 18, 20),
        TopBar = Color3.fromRGB(25, 25, 28),
        Sidebar = Color3.fromRGB(22, 22, 24),
        Element = Color3.fromRGB(35, 35, 38),
        Accent = Color3.fromRGB(200, 200, 200),
        Text = Color3.fromRGB(240, 240, 240),
        TextGray = Color3.fromRGB(140, 140, 140),
        Input = Color3.fromRGB(5, 5, 5),
        Dropdown = Color3.fromRGB(28, 28, 30)
    },
    Icons = {
        Home = "rbxassetid://10709782497",
        Settings = "rbxassetid://10734950309",
        User = "rbxassetid://10709782963",
        Sword = "rbxassetid://10709781460",
        Eye = "rbxassetid://10709782172",
        Zap = "rbxassetid://10709752153",
        Map = "rbxassetid://10709781176",
        Ghost = "rbxassetid://10709782630",
        Menu = "rbxassetid://10709783095"
    }
}

local function Tween(obj, props, time, style, dir)
    TweenService:Create(obj, TweenInfo.new(time or 0.3, style or Enum.EasingStyle.Quart, dir or Enum.EasingDirection.Out), props):Play()
end

function Library:CreateWindow(Settings)
    local Window = {}
    
    if CoreGui:FindFirstChild(Settings.Name or "KaiZoUI") then
        CoreGui[Settings.Name or "KaiZoUI"]:Destroy()
    end

    local sg = Instance.new("ScreenGui")
    sg.Name = Settings.Name or "KaiZoUI"
    sg.Parent = CoreGui
    sg.ResetOnSpawn = false
    sg.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    -- 1. FLOATING ICON
    local FloatBtn = Instance.new("ImageButton")
    FloatBtn.Name = "FloatingIcon"
    FloatBtn.Parent = sg
    FloatBtn.BackgroundColor3 = Config.Colors.TopBar
    FloatBtn.Position = UDim2.new(0.1, 0, 0.1, 0)
    FloatBtn.Size = UDim2.fromOffset(50, 50)
    FloatBtn.Image = Settings.Icon or "rbxassetid://132914280921668"
    FloatBtn.ZIndex = 100
    
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

    -- 2. MAIN FRAME STRUCTURE (FIXED VISUALS)
    local Main = Instance.new("Frame")
    Main.Name = "MainFrame"
    Main.Parent = sg
    Main.BackgroundColor3 = Config.Colors.MainBg
    Main.BackgroundTransparency = 0.02
    Main.Position = UDim2.new(0.5, -300, 0.5, -180)
    Main.Size = UDim2.fromOffset(600, 360)
    -- PENTING: ClipsDescendants False agar Shadow terlihat, tapi konten nanti di-clip di dalam container
    Main.ClipsDescendants = false 
    
    local MainGrad = Instance.new("UIGradient")
    MainGrad.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(255,255,255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(200,200,200))})
    MainGrad.Rotation = 45; MainGrad.Parent = Main

    local MainCorner = Instance.new("UICorner"); MainCorner.CornerRadius = UDim.new(0, 12); MainCorner.Parent = Main
    local MainStroke = Instance.new("UIStroke"); MainStroke.Parent = Main; MainStroke.Color = Config.Colors.Stroke; MainStroke.Thickness = 1

    -- Shadow (Bayangan)
    local MainShadow = Instance.new("ImageLabel")
    MainShadow.Parent = Main
    MainShadow.Image = "rbxassetid://6014261993"
    MainShadow.ImageColor3 = Color3.new(0,0,0)
    MainShadow.ImageTransparency = 0.4
    MainShadow.BackgroundTransparency = 1
    MainShadow.Position = UDim2.new(0, -25, 0, -25)
    MainShadow.Size = UDim2.new(1, 50, 1, 50)
    MainShadow.ScaleType = Enum.ScaleType.Slice
    MainShadow.SliceCenter = Rect.new(49, 49, 450, 450)
    MainShadow.ZIndex = -1 -- Di belakang Main Frame

    -- Toggle Logic
    local UIVisible = true
    FloatBtn.MouseButton1Click:Connect(function()
        UIVisible = not UIVisible
        if UIVisible then
            Main.Visible = true; Main.Size = UDim2.fromOffset(0,0); Main.ClipsDescendants = true -- Clip saat animasi
            Tween(Main, {Size = UDim2.fromOffset(600, 360)}, 0.4, Enum.EasingStyle.Back)
            task.delay(0.4, function() if UIVisible then Main.ClipsDescendants = false end end) -- Unclip setelah animasi agar shadow muncul
        else
            Main.ClipsDescendants = true
            local t = TweenService:Create(Main, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In), {Size = UDim2.fromOffset(0, 0)})
            t:Play(); t.Completed:Wait(); Main.Visible = false
        end
    end)

    -- 3. INTERIOR (TopBar, Sidebar, Content)
    
    -- Container Utama untuk memotong konten agar tidak keluar radius (Masking)
    local Container = Instance.new("Frame")
    Container.Name = "Container"
    Container.Parent = Main
    Container.BackgroundTransparency = 1
    Container.Size = UDim2.new(1, 0, 1, 0)
    Container.ClipsDescendants = true 
    local cc = Instance.new("UICorner"); cc.CornerRadius = UDim.new(0, 12); cc.Parent = Container

    -- TopBar
    local TopBar = Instance.new("Frame"); TopBar.Parent = Container; TopBar.BackgroundColor3 = Config.Colors.TopBar; TopBar.Size = UDim2.new(1, 0, 0, 50); TopBar.ZIndex = 20
    
    -- Shadow di bawah TopBar
    local TopShadow = Instance.new("ImageLabel"); TopShadow.Parent = TopBar; TopShadow.Image = "rbxassetid://6015897843"; TopShadow.ImageColor3 = Color3.new(0,0,0); TopShadow.ImageTransparency = 0.6; TopShadow.BackgroundTransparency = 1; TopShadow.Position = UDim2.new(0,0,1,0); TopShadow.Size = UDim2.new(1,0,0,20); TopShadow.ZIndex = 19

    local Title = Instance.new("TextLabel"); Title.Parent = TopBar; Title.BackgroundTransparency = 1; Title.Position = UDim2.new(0, 20, 0, 0); Title.Size = UDim2.new(0, 200, 1, 0); Title.Text = Settings.Title or "LIBRARY"; Title.Font = Enum.Font.GothamBlack; Title.TextColor3 = Config.Colors.Accent; Title.TextSize = 22; Title.TextXAlignment = Enum.TextXAlignment.Left; Title.ZIndex = 21
    local CloseBtn = Instance.new("TextButton"); CloseBtn.Parent = TopBar; CloseBtn.BackgroundTransparency = 1; CloseBtn.Position = UDim2.new(1,-45,0,0); CloseBtn.Size = UDim2.new(0,45,1,0); CloseBtn.Text = "×"; CloseBtn.Font = Enum.Font.GothamMedium; CloseBtn.TextColor3 = Config.Colors.TextGray; CloseBtn.TextSize = 30; CloseBtn.ZIndex = 21
    CloseBtn.MouseButton1Click:Connect(function() UIVisible = false; Main.Visible = false end)

    -- Sidebar
    local Sidebar = Instance.new("Frame"); Sidebar.Parent = Container; Sidebar.BackgroundColor3 = Config.Colors.Sidebar; Sidebar.Position = UDim2.new(0,0,0,50); Sidebar.Size = UDim2.new(0,150,1,-50); Sidebar.ZIndex = 2
    local TabContainer = Instance.new("ScrollingFrame"); TabContainer.Parent = Sidebar; TabContainer.BackgroundTransparency = 1; TabContainer.Position = UDim2.new(0,0,0,15); TabContainer.Size = UDim2.new(1,0,1,-15); TabContainer.ScrollBarThickness = 0; TabContainer.ZIndex = 3
    local TabList = Instance.new("UIListLayout"); TabList.Parent = TabContainer; TabList.Padding = UDim.new(0,5)

    -- Content Area
    local Content = Instance.new("Frame"); Content.Parent = Container; Content.BackgroundTransparency = 1; Content.Position = UDim2.new(0,150,0,50); Content.Size = UDim2.new(1,-150,1,-50); Content.ZIndex = 1
    local PagesFolder = Instance.new("Frame"); PagesFolder.Parent = Content; PagesFolder.BackgroundTransparency = 1; PagesFolder.Position = UDim2.new(0,15,0,15); PagesFolder.Size = UDim2.new(1,-30,1,-30); PagesFolder.ZIndex = 1

    -- Drag Logic Main
    local mDrag, mStart, mPos
    TopBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            mDrag = true; mStart = input.Position; mPos = Main.Position
            input.Changed:Connect(function() if input.UserInputState == Enum.UserInputState.End then mDrag = false end end)
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if mDrag and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - mStart
            Tween(Main, {Position = UDim2.new(mPos.X.Scale, mPos.X.Offset + delta.X, mPos.Y.Scale, mPos.Y.Offset + delta.Y)}, 0.05)
        end
    end)

    -- [ELEMENTS FUNCTIONS]
    local Tabs = {}
    
    function Window:AddTab(ConfigData)
        local TabName = ConfigData.Title or "Tab"
        local IconName = ConfigData.Icon
        
        local TabBtn = Instance.new("TextButton"); TabBtn.Parent = TabContainer; TabBtn.BackgroundTransparency = 1; TabBtn.Size = UDim2.new(1,0,0,35); TabBtn.Text = ""; TabBtn.ZIndex = 3
        local TabBg = Instance.new("Frame"); TabBg.Parent = TabBtn; TabBg.BackgroundColor3 = Config.Colors.Accent; TabBg.BackgroundTransparency = 1; TabBg.Size = UDim2.new(1,-20,1,0); TabBg.Position = UDim2.new(0,10,0,0); TabBg.ZIndex = 2; local TbgC = Instance.new("UICorner"); TbgC.CornerRadius = UDim.new(0,8); TbgC.Parent = TabBg
        local Indicator = Instance.new("Frame"); Indicator.Parent = TabBtn; Indicator.BackgroundColor3 = Config.Colors.Accent; Indicator.Position = UDim2.new(0,0,0.5,0); Indicator.AnchorPoint = Vector2.new(0,0.5); Indicator.Size = UDim2.new(0,0,0,0); Indicator.ZIndex = 4; local ic = Instance.new("UICorner"); ic.CornerRadius = UDim.new(0,4); ic.Parent = Indicator
        
        -- Icon Logic
        local IconImg = Instance.new("ImageLabel"); IconImg.Parent = TabBtn; IconImg.BackgroundTransparency = 1; IconImg.Position = UDim2.new(0, 15, 0.5, -9); IconImg.Size = UDim2.new(0, 18, 0, 18); IconImg.ImageColor3 = Config.Colors.TextGray; IconImg.ZIndex = 5
        if Config.Icons[IconName] then IconImg.Image = Config.Icons[IconName] else IconImg.Image = "" end

        local Label = Instance.new("TextLabel"); Label.Parent = TabBtn; Label.BackgroundTransparency = 1; Label.Position = UDim2.new(0,42,0,0); Label.Size = UDim2.new(1,-40,1,0); Label.Text = TabName; Label.Font = Enum.Font.GothamMedium; Label.TextColor3 = Config.Colors.TextGray; Label.TextSize = 13; Label.TextXAlignment = Enum.TextXAlignment.Left; Label.ZIndex = 5

        local Page = Instance.new("ScrollingFrame"); Page.Parent = PagesFolder; Page.BackgroundTransparency = 1; Page.Size = UDim2.new(1,0,1,0); Page.Visible = false; Page.ScrollBarThickness = 2; Page.AutomaticCanvasSize = Enum.AutomaticSize.Y; Page.ZIndex = 3
        local PL = Instance.new("UIListLayout"); PL.Parent = Page; PL.SortOrder = Enum.SortOrder.LayoutOrder; PL.Padding = UDim.new(0,8)

        TabBtn.MouseButton1Click:Connect(function()
            for _, t in pairs(Tabs) do t.Page.Visible=false; Tween(t.Label,{TextColor3=Config.Colors.TextGray},0.3); Tween(t.Icon,{ImageColor3=Config.Colors.TextGray},0.3); Tween(t.Indicator,{Size=UDim2.new(0,0,0,0)},0.3); Tween(t.Bg,{BackgroundTransparency=1},0.3) end
            Page.Visible=true; Tween(Label,{TextColor3=Config.Colors.Accent},0.3); Tween(IconImg,{ImageColor3=Config.Colors.Accent},0.3); Tween(Indicator,{Size=UDim2.new(0,3,0.6,0)},0.4,Enum.EasingStyle.Back); Tween(TabBg,{BackgroundTransparency=0.95},0.3)
        end)
        table.insert(Tabs, {Btn=TabBtn, Label=Label, Icon=IconImg, Indicator=Indicator, Bg=TabBg, Page=Page})
        if #Tabs==1 then Page.Visible=true; Label.TextColor3=Config.Colors.Accent; IconImg.ImageColor3=Config.Colors.Accent; Indicator.Size=UDim2.new(0,3,0.6,0); TabBg.BackgroundTransparency=0.95 end

        local Elements = {}
        
        function Elements:AddSection(Text)
            local L = Instance.new("TextLabel"); L.Parent = Page; L.BackgroundTransparency = 1; L.Size = UDim2.new(1,0,0,30); L.Text = Text; L.Font = Enum.Font.GothamBold; L.TextColor3 = Config.Colors.Accent; L.TextSize = 14; L.ZIndex = 3
        end

        function Elements:AddButton(Data)
            local Btn = Instance.new("TextButton"); Btn.Parent = Page; Btn.BackgroundColor3 = Config.Colors.Element; Btn.BackgroundTransparency = 0.3; Btn.Size = UDim2.new(1,0,0,42); Btn.Text = Data.Title; Btn.Font = Enum.Font.Gotham; Btn.TextColor3 = Config.Colors.Text; Btn.TextSize = 13; Btn.AutoButtonColor = false; Btn.ZIndex = 3; local c = Instance.new("UICorner"); c.CornerRadius = UDim.new(0,8); c.Parent = Btn
            Btn.MouseEnter:Connect(function() Tween(Btn,{BackgroundColor3=Color3.fromRGB(45,45,48)},0.2) end)
            Btn.MouseLeave:Connect(function() Tween(Btn,{BackgroundColor3=Config.Colors.Element},0.2) end)
            Btn.MouseButton1Click:Connect(function() if Data.Callback then Data.Callback() end end)
        end

        function Elements:AddToggle(Data)
            local State = Data.Default or false
            local Btn = Instance.new("TextButton"); Btn.Parent = Page; Btn.BackgroundColor3 = Config.Colors.Element; Btn.BackgroundTransparency = 0.3; Btn.Size = UDim2.new(1,0,0,42); Btn.Text = "   "..Data.Title; Btn.Font = Enum.Font.Gotham; Btn.TextColor3 = Config.Colors.Text; Btn.TextSize = 13; Btn.TextXAlignment = Enum.TextXAlignment.Left; Btn.AutoButtonColor = false; Btn.ZIndex = 3; local c = Instance.new("UICorner"); c.CornerRadius = UDim.new(0,8); c.Parent = Btn
            local Sw = Instance.new("Frame"); Sw.Parent = Btn; Sw.BackgroundColor3 = State and Config.Colors.Accent or Color3.fromRGB(50,50,50); Sw.Position = UDim2.new(1,-50,0.5,-10); Sw.Size = UDim2.new(0,36,0,20); Sw.ZIndex = 4; local sc = Instance.new("UICorner"); sc.CornerRadius = UDim.new(0,8); sc.Parent = Sw
            local Dot = Instance.new("Frame"); Dot.Parent = Sw; Dot.BackgroundColor3 = State and Config.Colors.Text or Config.Colors.TextGray; Dot.Position = State and UDim2.new(1,-18,0.5,-8) or UDim2.new(0,2,0.5,-8); Dot.Size = UDim2.new(0,16,0,16); Dot.ZIndex = 5; local dc = Instance.new("UICorner"); dc.CornerRadius = UDim.new(1,0); dc.Parent = Dot
            Btn.MouseButton1Click:Connect(function()
                State = not State
                if State then Tween(Sw,{BackgroundColor3=Config.Colors.Accent},0.3); Tween(Dot,{Position=UDim2.new(1,-18,0.5,-8), BackgroundColor3=Config.Colors.Text},0.3)
                else Tween(Sw,{BackgroundColor3=Color3.fromRGB(50,50,50)},0.3); Tween(Dot,{Position=UDim2.new(0,2,0.5,-8), BackgroundColor3=Config.Colors.TextGray},0.3) end
                if Data.Callback then Data.Callback(State) end
            end)
        end

        function Elements:AddInput(Data)
            local F = Instance.new("Frame"); F.Parent = Page; F.BackgroundColor3 = Config.Colors.Element; F.BackgroundTransparency = 0.3; F.Size = UDim2.new(1,0,0,45); F.ZIndex = 3; local c = Instance.new("UICorner"); c.CornerRadius = UDim.new(0,8); c.Parent = F
            local L = Instance.new("TextLabel"); L.Parent = F; L.BackgroundTransparency = 1; L.Position = UDim2.new(0,12,0,0); L.Size = UDim2.new(0,100,1,0); L.Text = Data.Title; L.Font = Enum.Font.GothamMedium; L.TextColor3 = Config.Colors.Text; L.TextSize = 13; L.TextXAlignment = Enum.TextXAlignment.Left; L.ZIndex = 4
            local BoxCon = Instance.new("Frame"); BoxCon.Parent = F; BoxCon.BackgroundColor3 = Config.Colors.Input; BoxCon.BackgroundTransparency=0; BoxCon.Position = UDim2.new(1,-160,0.5,-15); BoxCon.Size = UDim2.new(0,150,0,30); BoxCon.ZIndex = 4; local bc = Instance.new("UICorner"); bc.CornerRadius = UDim.new(0,6); bc.Parent = BoxCon
            local TB = Instance.new("TextBox"); TB.Parent = BoxCon; TB.BackgroundTransparency = 1; TB.Position = UDim2.new(0,8,0,0); TB.Size = UDim2.new(1,-16,1,0); TB.ZIndex = 5; TB.Font = Enum.Font.Gotham; TB.PlaceholderText = Data.Placeholder or "..."; TB.Text = ""; TB.TextColor3 = Config.Colors.Text; TB.PlaceholderColor3 = Config.Colors.TextGray; TB.TextSize = 13; TB.TextXAlignment = Enum.TextXAlignment.Left; TB.ClearTextOnFocus = false
            TB.FocusLost:Connect(function() if Data.Callback then Data.Callback(TB.Text) end end)
        end

        function Elements:AddSlider(Data)
            local F = Instance.new("Frame"); F.Parent = Page; F.BackgroundColor3 = Config.Colors.Element; F.BackgroundTransparency = 0.3; F.Size = UDim2.new(1,0,0,60); F.ZIndex = 3; local c = Instance.new("UICorner"); c.CornerRadius = UDim.new(0,8); c.Parent = F
            local L = Instance.new("TextLabel"); L.Parent = F; L.BackgroundTransparency = 1; L.Position = UDim2.new(0,12,0,5); L.Size = UDim2.new(1,-24,0,20); L.Text = Data.Title; L.Font = Enum.Font.GothamMedium; L.TextColor3 = Config.Colors.Text; L.TextSize = 13; L.TextXAlignment = Enum.TextXAlignment.Left; L.ZIndex = 4
            local V = Instance.new("TextLabel"); V.Parent = F; V.BackgroundTransparency = 1; V.Position = UDim2.new(0,12,0,5); V.Size = UDim2.new(1,-24,0,20); V.Text = tostring(Data.Default or Data.Min); V.Font = Enum.Font.GothamBold; V.TextColor3 = Config.Colors.Accent; V.TextSize = 13; V.TextXAlignment = Enum.TextXAlignment.Right; V.ZIndex = 4
            local Hitbox = Instance.new("TextButton"); Hitbox.Parent = F; Hitbox.BackgroundTransparency = 1; Hitbox.Size = UDim2.new(1,0,1,0); Hitbox.Text = ""; Hitbox.ZIndex = 5
            local BarBg = Instance.new("Frame"); BarBg.Parent = F; BarBg.BackgroundColor3 = Color3.fromRGB(50,50,50); BarBg.Position = UDim2.new(0,12,0,40); BarBg.Size = UDim2.new(1,-24,0,6); BarBg.ZIndex = 4; local bc = Instance.new("UICorner"); bc.CornerRadius = UDim.new(1,0); bc.Parent = BarBg
            local BarFill = Instance.new("Frame"); BarFill.Parent = BarBg; BarFill.BackgroundColor3 = Config.Colors.Accent; BarFill.Size = UDim2.new(((Data.Default or Data.Min)-Data.Min)/(Data.Max-Data.Min),0,1,0); BarFill.ZIndex = 4; local bfc = Instance.new("UICorner"); bfc.CornerRadius = UDim.new(1,0); bfc.Parent = BarFill
            
            Hitbox.MouseButton1Down:Connect(function()
                local moveCn, endCn
                local function Update(input)
                    local P = math.clamp((input.Position.X - BarBg.AbsolutePosition.X) / BarBg.AbsoluteSize.X, 0, 1)
                    local Val = math.floor(Data.Min + (Data.Max - Data.Min) * P)
                    V.Text = tostring(Val)
                    Tween(BarFill, {Size=UDim2.new(P,0,1,0)}, 0.05)
                    if Data.Callback then Data.Callback(Val) end
                end
                Update({Position = UserInputService:GetMouseLocation()})
                moveCn = UserInputService.InputChanged:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseMovement then Update(input) end end)
                endCn = UserInputService.InputEnded:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 then moveCn:Disconnect(); endCn:Disconnect() end end)
            end)
        end

        return Elements
    end

    return Window
end

return Library
