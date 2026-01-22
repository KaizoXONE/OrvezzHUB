--[[
    KAIZO UI LIBRARY (V17 - Restoration & Fix)
    Author: KaizoX
    Fixes: Color Palette (Monochrome), Animations, Shadow Sizing, & TopBar Radius.
]]

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")

local Library = {}

-- [CONFIG - STRICT MONOCHROME]
local Config = {
    Colors = {
        MainBg      = Color3.fromRGB(15, 15, 15),    -- Hitam Pekat Soft
        TopBar      = Color3.fromRGB(20, 20, 20),    -- Sedikit lebih terang
        Sidebar     = Color3.fromRGB(18, 18, 18),
        Element     = Color3.fromRGB(30, 30, 30),    -- Abu Gelap
        Accent      = Color3.fromRGB(255, 255, 255), -- Putih Bersih
        Text        = Color3.fromRGB(240, 240, 240),
        TextGray    = Color3.fromRGB(120, 120, 120),
        Input       = Color3.fromRGB(5, 5, 5),       -- Hitam Input
        Dropdown    = Color3.fromRGB(25, 25, 25),
        Stroke      = Color3.fromRGB(45, 45, 45)
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

    -- [FLOATING ICON]
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
    
    FloatBtn.MouseEnter:Connect(function() Tween(FloatBtn, {Size = UDim2.fromOffset(55,55)}, 0.2, Enum.EasingStyle.Back) end)
    FloatBtn.MouseLeave:Connect(function() Tween(FloatBtn, {Size = UDim2.fromOffset(50,50)}, 0.2, Enum.EasingStyle.Back) end)

    -- [STRUCTURE: ROOT -> SHADOW -> MAIN(Clipped)]
    
    -- 1. ROOT (Invisible, Holds Position & Drag)
    local Root = Instance.new("Frame")
    Root.Name = "Root"
    Root.Parent = sg
    Root.BackgroundTransparency = 1
    Root.Position = UDim2.new(0.5, -300, 0.5, -180)
    Root.Size = UDim2.fromOffset(600, 360)

    -- 2. SHADOW (Behind Main)
    local Shadow = Instance.new("ImageLabel")
    Shadow.Parent = Root
    Shadow.Image = "rbxassetid://6014261993"
    Shadow.ImageColor3 = Color3.new(0,0,0)
    Shadow.ImageTransparency = 0.5
    Shadow.BackgroundTransparency = 1
    Shadow.Position = UDim2.new(0, -30, 0, -30) -- Fixed Offset agar tidak terlalu lebar
    Shadow.Size = UDim2.new(1, 60, 1, 60)      -- Fixed Size
    Shadow.ScaleType = Enum.ScaleType.Slice
    Shadow.SliceCenter = Rect.new(49, 49, 450, 450)
    Shadow.ZIndex = 0

    -- 3. MAIN (Visual, Rounded, Clipped)
    local Main = Instance.new("Frame")
    Main.Name = "Main"
    Main.Parent = Root
    Main.BackgroundColor3 = Config.Colors.MainBg
    Main.Size = UDim2.new(1, 0, 1, 0)
    Main.ClipsDescendants = true -- INI KUNCINYA: Topbar akan terpotong mengikuti radius ini
    Main.ZIndex = 1
    local mc = Instance.new("UICorner"); mc.CornerRadius = UDim.new(0, 12); mc.Parent = Main
    local ms = Instance.new("UIStroke"); ms.Parent = Main; ms.Color = Config.Colors.Stroke; ms.Thickness = 1

    -- Toggle Logic
    local UIVisible = true
    FloatBtn.MouseButton1Click:Connect(function()
        UIVisible = not UIVisible
        Root.Visible = UIVisible
        if UIVisible then
            Main.Size = UDim2.new(1,0,0,0)
            Tween(Main, {Size = UDim2.new(1,0,1,0)}, 0.4, Enum.EasingStyle.Back)
        end
    end)

    -- [INTERIOR]
    
    -- TopBar
    local TopBar = Instance.new("Frame")
    TopBar.Parent = Main
    TopBar.BackgroundColor3 = Config.Colors.TopBar
    TopBar.Size = UDim2.new(1, 0, 0, 50)
    TopBar.BorderSizePixel = 0 -- Pastikan 0
    TopBar.ZIndex = 10

    -- Drag Hitbox (Invisible Button agar drag lancar)
    local DragBox = Instance.new("TextButton")
    DragBox.Parent = TopBar
    DragBox.BackgroundTransparency = 1
    DragBox.Size = UDim2.new(1, -50, 1, 0)
    DragBox.Text = ""
    DragBox.ZIndex = 20

    -- Drag Logic
    local dragging, dragStart, startPos
    DragBox.InputBegan:Connect(function(input)
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

    local Title = Instance.new("TextLabel"); Title.Parent = TopBar; Title.BackgroundTransparency = 1; Title.Position = UDim2.new(0, 20, 0, 0); Title.Size = UDim2.new(0, 200, 1, 0); Title.Text = Settings.Title or "LIBRARY"; Title.Font = Enum.Font.GothamBlack; Title.TextColor3 = Config.Colors.Accent; Title.TextSize = 22; Title.TextXAlignment = Enum.TextXAlignment.Left; Title.ZIndex = 11
    local CloseBtn = Instance.new("TextButton"); CloseBtn.Parent = TopBar; CloseBtn.BackgroundTransparency = 1; CloseBtn.Position = UDim2.new(1,-45,0,0); CloseBtn.Size = UDim2.new(0,45,1,0); CloseBtn.Text = "×"; CloseBtn.Font = Enum.Font.GothamMedium; CloseBtn.TextColor3 = Config.Colors.TextGray; CloseBtn.TextSize = 30; CloseBtn.ZIndex = 21
    CloseBtn.MouseButton1Click:Connect(function() Root.Visible = false; UIVisible = false end)
    CloseBtn.MouseEnter:Connect(function() Tween(CloseBtn, {TextColor3=Color3.fromRGB(255,80,80)}) end)
    CloseBtn.MouseLeave:Connect(function() Tween(CloseBtn, {TextColor3=Config.Colors.TextGray}) end)

    -- Sidebar
    local Sidebar = Instance.new("Frame"); Sidebar.Parent = Main; Sidebar.BackgroundColor3 = Config.Colors.Sidebar; Sidebar.BorderSizePixel = 0; Sidebar.Position = UDim2.new(0,0,0,50); Sidebar.Size = UDim2.new(0,150,1,-50); Sidebar.ZIndex = 5
    local TabContainer = Instance.new("ScrollingFrame"); TabContainer.Parent = Sidebar; TabContainer.BackgroundTransparency = 1; TabContainer.Position = UDim2.new(0,0,0,15); TabContainer.Size = UDim2.new(1,0,1,-15); TabContainer.ScrollBarThickness = 0; TabContainer.ZIndex = 6
    local TabList = Instance.new("UIListLayout"); TabList.Parent = TabContainer; TabList.Padding = UDim.new(0,5)

    -- Content
    local Content = Instance.new("Frame"); Content.Parent = Main; Content.BackgroundTransparency = 1; Content.Position = UDim2.new(0,150,0,50); Content.Size = UDim2.new(1,-150,1,-50); Content.ZIndex = 5
    local PagesFolder = Instance.new("Frame"); PagesFolder.Parent = Content; PagesFolder.BackgroundTransparency = 1; PagesFolder.Position = UDim2.new(0,15,0,15); PagesFolder.Size = UDim2.new(1,-30,1,-30); PagesFolder.ZIndex = 5

    -- [ELEMENTS]
    local Tabs = {}
    function Window:AddTab(ConfigData)
        local TabBtn = Instance.new("TextButton"); TabBtn.Parent = TabContainer; TabBtn.BackgroundTransparency = 1; TabBtn.Size = UDim2.new(1,0,0,35); TabBtn.Text = ""; TabBtn.ZIndex = 7
        local TabBg = Instance.new("Frame"); TabBg.Parent = TabBtn; TabBg.BackgroundColor3 = Config.Colors.Accent; TabBg.BackgroundTransparency = 1; TabBg.Size = UDim2.new(1,-20,1,0); TabBg.Position = UDim2.new(0,10,0,0); TabBg.ZIndex = 6; local tc = Instance.new("UICorner"); tc.CornerRadius=UDim.new(0,8); tc.Parent=TabBg
        local Indicator = Instance.new("Frame"); Indicator.Parent = TabBtn; Indicator.BackgroundColor3 = Config.Colors.Accent; Indicator.Position = UDim2.new(0,0,0.5,0); Indicator.AnchorPoint = Vector2.new(0,0.5); Indicator.Size = UDim2.new(0,0,0,0); Indicator.ZIndex = 8; local ic = Instance.new("UICorner"); ic.CornerRadius = UDim.new(0,4); ic.Parent = Indicator
        
        local IconImg = Instance.new("ImageLabel"); IconImg.Parent = TabBtn; IconImg.BackgroundTransparency = 1; IconImg.Position = UDim2.new(0, 15, 0.5, -9); IconImg.Size = UDim2.new(0, 18, 0, 18); IconImg.ImageColor3 = Config.Colors.TextGray; IconImg.ZIndex = 8
        if ConfigData.Icon and Config.Icons[ConfigData.Icon] then IconImg.Image = Config.Icons[ConfigData.Icon] end
        local Label = Instance.new("TextLabel"); Label.Parent = TabBtn; Label.BackgroundTransparency = 1; Label.Position = UDim2.new(0,42,0,0); Label.Size = UDim2.new(1,-40,1,0); Label.Text = ConfigData.Title; Label.Font = Enum.Font.GothamMedium; Label.TextColor3 = Config.Colors.TextGray; Label.TextSize = 13; Label.TextXAlignment = Enum.TextXAlignment.Left; Label.ZIndex = 8

        local Page = Instance.new("ScrollingFrame"); Page.Parent = PagesFolder; Page.BackgroundTransparency = 1; Page.Size = UDim2.new(1,0,1,0); Page.Visible = false; Page.ScrollBarThickness = 2; Page.AutomaticCanvasSize = Enum.AutomaticSize.Y; Page.ZIndex = 6
        local PL = Instance.new("UIListLayout"); PL.Parent = Page; PL.SortOrder = Enum.SortOrder.LayoutOrder; PL.Padding = UDim.new(0,8)

        -- [ANIMASI TAB]
        TabBtn.MouseEnter:Connect(function() if Page.Visible then return end; Tween(TabBg,{BackgroundTransparency=0.9}); Tween(Label,{TextColor3=Config.Colors.Text}); Tween(IconImg,{ImageColor3=Config.Colors.Text}) end)
        TabBtn.MouseLeave:Connect(function() if Page.Visible then return end; Tween(TabBg,{BackgroundTransparency=1}); Tween(Label,{TextColor3=Config.Colors.TextGray}); Tween(IconImg,{ImageColor3=Config.Colors.TextGray}) end)
        TabBtn.MouseButton1Click:Connect(function()
            for _, t in pairs(Tabs) do t.Page.Visible=false; Tween(t.Label,{TextColor3=Config.Colors.TextGray}); Tween(t.Icon,{ImageColor3=Config.Colors.TextGray}); Tween(t.Indicator,{Size=UDim2.new(0,0,0,0)}); Tween(t.Bg,{BackgroundTransparency=1}) end
            Page.Visible=true; Tween(Label,{TextColor3=Config.Colors.Accent}); Tween(IconImg,{ImageColor3=Config.Colors.Accent}); Tween(Indicator,{Size=UDim2.new(0,3,0.6,0)},0.4,Enum.EasingStyle.Back); Tween(TabBg,{BackgroundTransparency=0.95})
        end)
        table.insert(Tabs, {Btn=TabBtn, Label=Label, Icon=IconImg, Indicator=Indicator, Bg=TabBg, Page=Page})
        if #Tabs==1 then Page.Visible=true; Label.TextColor3=Config.Colors.Accent; IconImg.ImageColor3=Config.Colors.Accent; Indicator.Size=UDim2.new(0,3,0.6,0); TabBg.BackgroundTransparency=0.95 end

        local Elements = {}
        
        -- [BUTTON - WITH ANIMATION]
        function Elements:AddButton(Data)
            local Btn = Instance.new("TextButton"); Btn.Parent = Page; Btn.BackgroundColor3 = Config.Colors.Element; Btn.BackgroundTransparency = 0.3; Btn.Size = UDim2.new(1,0,0,42); Btn.Text = Data.Title; Btn.Font = Enum.Font.Gotham; Btn.TextColor3 = Config.Colors.Text; Btn.TextSize = 13; Btn.AutoButtonColor = false; Btn.ZIndex = 7; local c = Instance.new("UICorner"); c.CornerRadius = UDim.new(0,8); c.Parent = Btn
            Btn.MouseEnter:Connect(function() Tween(Btn,{BackgroundColor3=Color3.fromRGB(45,45,45)}) end)
            Btn.MouseLeave:Connect(function() Tween(Btn,{BackgroundColor3=Config.Colors.Element}) end)
            Btn.MouseButton1Click:Connect(function() 
                Tween(Btn,{Size=UDim2.new(1,-4,0,38)},0.1); task.wait(0.1); Tween(Btn,{Size=UDim2.new(1,0,0,42)},0.1)
                if Data.Callback then Data.Callback() end 
            end)
        end

        -- [TOGGLE - RESTORED V13 STYLE]
        function Elements:AddToggle(Data)
            local State = Data.Default or false
            local Btn = Instance.new("TextButton"); Btn.Parent = Page; Btn.BackgroundColor3 = Config.Colors.Element; Btn.BackgroundTransparency = 0.3; Btn.Size = UDim2.new(1,0,0,42); Btn.Text = "   "..Data.Title; Btn.Font = Enum.Font.Gotham; Btn.TextColor3 = Config.Colors.Text; Btn.TextSize = 13; Btn.TextXAlignment = Enum.TextXAlignment.Left; Btn.AutoButtonColor = false; Btn.ZIndex = 7; local c = Instance.new("UICorner"); c.CornerRadius = UDim.new(0,8); c.Parent = Btn
            local Sw = Instance.new("Frame"); Sw.Parent = Btn; Sw.BackgroundColor3 = State and Config.Colors.Accent or Color3.fromRGB(50,50,50); Sw.Position = UDim2.new(1,-50,0.5,-10); Sw.Size = UDim2.new(0,36,0,20); Sw.ZIndex = 8; local sc = Instance.new("UICorner"); sc.CornerRadius = UDim.new(0,8); sc.Parent = Sw
            local Dot = Instance.new("Frame"); Dot.Parent = Sw; Dot.BackgroundColor3 = State and Config.Colors.Text or Config.Colors.TextGray; Dot.Position = State and UDim2.new(1,-18,0.5,-8) or UDim2.new(0,2,0.5,-8); Dot.Size = UDim2.new(0,16,0,16); Dot.ZIndex = 9; local dc = Instance.new("UICorner"); dc.CornerRadius = UDim.new(1,0); dc.Parent = Dot
            
            Btn.MouseEnter:Connect(function() Tween(Btn,{BackgroundColor3=Color3.fromRGB(45,45,45)}) end)
            Btn.MouseLeave:Connect(function() Tween(Btn,{BackgroundColor3=Config.Colors.Element}) end)
            Btn.MouseButton1Click:Connect(function() 
                State = not State; 
                Tween(Sw,{BackgroundColor3=State and Config.Colors.Accent or Color3.fromRGB(50,50,50)})
                Tween(Dot,{Position=State and UDim2.new(1,-18,0.5,-8) or UDim2.new(0,2,0.5,-8), BackgroundColor=State and Config.Colors.Text or Config.Colors.TextGray})
                if Data.Callback then Data.Callback(State) end 
            end)
        end

        -- [SLIDER - RESTORED V13 STYLE]
        function Elements:AddSlider(Data)
            local F = Instance.new("Frame"); F.Parent = Page; F.BackgroundColor3 = Config.Colors.Element; F.BackgroundTransparency = 0.3; F.Size = UDim2.new(1,0,0,60); F.ZIndex = 7; local c = Instance.new("UICorner"); c.CornerRadius = UDim.new(0,8); c.Parent = F
            local L = Instance.new("TextLabel"); L.Parent = F; L.BackgroundTransparency = 1; L.Position = UDim2.new(0,12,0,5); L.Size = UDim2.new(1,-24,0,20); L.Text = Data.Title; L.Font = Enum.Font.GothamMedium; L.TextColor3 = Config.Colors.Text; L.TextSize = 13; L.TextXAlignment = Enum.TextXAlignment.Left; L.ZIndex = 8
            local V = Instance.new("TextLabel"); V.Parent = F; V.BackgroundTransparency = 1; V.Position = UDim2.new(0,12,0,5); V.Size = UDim2.new(1,-24,0,20); V.Text = tostring(Data.Default or Data.Min); V.Font = Enum.Font.GothamBold; V.TextColor3 = Config.Colors.Accent; V.TextSize = 13; V.TextXAlignment = Enum.TextXAlignment.Right; V.ZIndex = 8
            local Hit = Instance.new("TextButton"); Hit.Parent = F; Hit.BackgroundTransparency = 1; Hit.Size = UDim2.new(1,0,1,0); Hit.Text = ""; Hit.ZIndex = 9
            local Bg = Instance.new("Frame"); Bg.Parent = F; Bg.BackgroundColor3 = Color3.fromRGB(50,50,50); Bg.Position = UDim2.new(0,12,0,40); Bg.Size = UDim2.new(1,-24,0,6); Bg.ZIndex = 8; local bc = Instance.new("UICorner"); bc.Parent = Bg
            local Fill = Instance.new("Frame"); Fill.Parent = Bg; Fill.BackgroundColor3 = Config.Colors.Accent; Fill.Size = UDim2.new(((Data.Default or Data.Min)-Data.Min)/(Data.Max-Data.Min),0,1,0); Fill.ZIndex = 8; local fc = Instance.new("UICorner"); fc.Parent = Fill
            local Knob = Instance.new("Frame"); Knob.Parent = Fill; Knob.BackgroundColor3 = Config.Colors.Text; Knob.Position = UDim2.new(1,-9,0.5,-9); Knob.Size = UDim2.new(0,18,0,18); Knob.ZIndex = 9; local kc = Instance.new("UICorner"); kc.CornerRadius = UDim.new(1,0); kc.Parent = Knob

            Hit.MouseEnter:Connect(function() Tween(Knob,{Size=UDim2.new(0,22,0,22)},0.1) end)
            Hit.MouseLeave:Connect(function() Tween(Knob,{Size=UDim2.new(0,18,0,18)},0.1) end)
            Hit.MouseButton1Down:Connect(function()
                local move, kill; local function Update(input) local P = math.clamp((input.Position.X - Bg.AbsolutePosition.X)/Bg.AbsoluteSize.X,0,1); local Val = math.floor(Data.Min + (Data.Max-Data.Min)*P); V.Text = tostring(Val); Tween(Fill,{Size=UDim2.new(P,0,1,0)},0.05); if Data.Callback then Data.Callback(Val) end end
                Update({Position=UserInputService:GetMouseLocation()}); move=UserInputService.InputChanged:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseMovement then Update(i) end end); kill=UserInputService.InputEnded:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 then move:Disconnect(); kill:Disconnect() end end)
            end)
        end

        function Elements:AddInput(Data)
            local F = Instance.new("Frame"); F.Parent = Page; F.BackgroundColor3 = Config.Colors.Element; F.BackgroundTransparency = 0.3; F.Size = UDim2.new(1,0,0,45); F.ZIndex = 7; local c = Instance.new("UICorner"); c.CornerRadius = UDim.new(0,8); c.Parent = F
            local L = Instance.new("TextLabel"); L.Parent = F; L.BackgroundTransparency = 1; L.Position = UDim2.new(0,12,0,0); L.Size = UDim2.new(0,100,1,0); L.Text = Data.Title; L.Font = Enum.Font.GothamMedium; L.TextColor3 = Config.Colors.Text; L.TextSize = 13; L.TextXAlignment = Enum.TextXAlignment.Left; L.ZIndex = 8
            local BoxCon = Instance.new("Frame"); BoxCon.Parent = F; BoxCon.BackgroundColor3 = Config.Colors.Input; BoxCon.BackgroundTransparency = 0; BoxCon.Position = UDim2.new(1,-160,0.5,-15); BoxCon.Size = UDim2.new(0,150,0,30); BoxCon.ZIndex = 8; local bc = Instance.new("UICorner"); bc.CornerRadius = UDim.new(0,6); bc.Parent = BoxCon
            local TB = Instance.new("TextBox"); TB.Parent = BoxCon; TB.BackgroundTransparency = 1; TB.Position = UDim2.new(0,8,0,0); TB.Size = UDim2.new(1,-16,1,0); TB.ZIndex = 9; TB.Font = Enum.Font.Gotham; TB.PlaceholderText = Data.Placeholder or "..."; TB.Text = ""; TB.TextColor3 = Config.Colors.Text; TB.PlaceholderColor3 = Config.Colors.TextGray; TB.TextSize = 13; TB.TextXAlignment = Enum.TextXAlignment.Left; TB.ClearTextOnFocus = false
            TB.Focused:Connect(function() Tween(BoxCon, {BackgroundColor3=Color3.fromRGB(20,20,20)}) end); TB.FocusLost:Connect(function() Tween(BoxCon, {BackgroundColor3=Config.Colors.Input}); if Data.Callback then Data.Callback(TB.Text) end end)
        end

        return Elements
    end
    return Window
end
return Library
