--[[
    KAIZO UI LIBRARY (V14 - Wrapper Fix)
    Author: KaizoX
    Fix: Solves "White Corner" & Shadow Conflict using Wrapper method.
]]

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")

local Library = {}

-- [CONFIG]
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

    -- [MAIN STRUCTURE - WRAPPER METHOD]
    
    -- 1. MainFrame (Root) - INVISIBLE CONTAINER
    -- Ini hanya menahan posisi dan ukuran, tidak punya warna.
    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Parent = sg
    MainFrame.BackgroundTransparency = 1 -- Invisible
    MainFrame.Position = UDim2.new(0.5, -300, 0.5, -180)
    MainFrame.Size = UDim2.fromOffset(600, 360)
    
    -- 2. Shadow (Di luar Wrapper, agar tidak terpotong)
    local Shadow = Instance.new("ImageLabel")
    Shadow.Parent = MainFrame
    Shadow.Image = "rbxassetid://6014261993"
    Shadow.ImageColor3 = Color3.new(0,0,0)
    Shadow.ImageTransparency = 0.4
    Shadow.BackgroundTransparency = 1
    Shadow.Position = UDim2.new(0, -30, 0, -30) -- Offset keluar
    Shadow.Size = UDim2.new(1, 60, 1, 60)      -- Lebih besar dari MainFrame
    Shadow.ScaleType = Enum.ScaleType.Slice
    Shadow.SliceCenter = Rect.new(49, 49, 450, 450)
    Shadow.ZIndex = -1 -- Paling belakang

    -- 3. Wrapper (Konten Utama) - CLIPPED
    -- Ini yang punya warna background dan rounded corner.
    local Wrapper = Instance.new("Frame")
    Wrapper.Name = "Wrapper"
    Wrapper.Parent = MainFrame
    Wrapper.BackgroundColor3 = Config.Colors.MainBg
    Wrapper.Size = UDim2.new(1, 0, 1, 0)
    Wrapper.ClipsDescendants = true -- KUNCI: Memotong anak elemen agar bulat
    local wc = Instance.new("UICorner"); wc.CornerRadius = UDim.new(0, 12); wc.Parent = Wrapper
    local ws = Instance.new("UIStroke"); ws.Parent = Wrapper; ws.Color = Config.Colors.Stroke; ws.Thickness = 1

    -- Toggle Logic
    local UIVisible = true
    FloatBtn.MouseButton1Click:Connect(function()
        UIVisible = not UIVisible
        if UIVisible then
            MainFrame.Visible = true
            Tween(Wrapper, {Size = UDim2.new(1, 0, 1, 0)}, 0.4, Enum.EasingStyle.Back)
        else
            Tween(Wrapper, {Size = UDim2.new(1, 0, 0, 0)}, 0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
            task.wait(0.3)
            if not UIVisible then MainFrame.Visible = false end
        end
    end)

    -- [INTERIOR ELEMENTS - INSIDE WRAPPER]

    -- TopBar
    local TopBar = Instance.new("Frame"); TopBar.Parent = Wrapper; TopBar.BackgroundColor3 = Config.Colors.TopBar; TopBar.Size = UDim2.new(1, 0, 0, 50); TopBar.ZIndex = 10
    local Title = Instance.new("TextLabel"); Title.Parent = TopBar; Title.BackgroundTransparency = 1; Title.Position = UDim2.new(0, 20, 0, 0); Title.Size = UDim2.new(0, 200, 1, 0); Title.Text = Settings.Title or "Library"; Title.Font = Enum.Font.GothamBlack; Title.TextColor3 = Config.Colors.Accent; Title.TextSize = 22; Title.TextXAlignment = Enum.TextXAlignment.Left
    
    local CloseBtn = Instance.new("TextButton"); CloseBtn.Parent = TopBar; CloseBtn.BackgroundTransparency = 1; CloseBtn.Position = UDim2.new(1,-45,0,0); CloseBtn.Size = UDim2.new(0,45,1,0); CloseBtn.Text = "×"; CloseBtn.Font = Enum.Font.GothamMedium; CloseBtn.TextColor3 = Config.Colors.TextGray; CloseBtn.TextSize = 30
    CloseBtn.MouseButton1Click:Connect(function() UIVisible = false; MainFrame.Visible = false end)

    -- Sidebar
    local Sidebar = Instance.new("Frame"); Sidebar.Parent = Wrapper; Sidebar.BackgroundColor3 = Config.Colors.Sidebar; Sidebar.Position = UDim2.new(0,0,0,50); Sidebar.Size = UDim2.new(0,150,1,-50); Sidebar.ZIndex = 2
    local TabContainer = Instance.new("ScrollingFrame"); TabContainer.Parent = Sidebar; TabContainer.BackgroundTransparency = 1; TabContainer.Position = UDim2.new(0,0,0,15); TabContainer.Size = UDim2.new(1,0,1,-15); TabContainer.ScrollBarThickness = 0
    local TabList = Instance.new("UIListLayout"); TabList.Parent = TabContainer; TabList.Padding = UDim.new(0,5)

    -- Content
    local Content = Instance.new("Frame"); Content.Parent = Wrapper; Content.BackgroundTransparency = 1; Content.Position = UDim2.new(0,150,0,50); Content.Size = UDim2.new(1,-150,1,-50)
    local PagesFolder = Instance.new("Frame"); PagesFolder.Parent = Content; PagesFolder.BackgroundTransparency = 1; PagesFolder.Position = UDim2.new(0,15,0,15); PagesFolder.Size = UDim2.new(1,-30,1,-30)

    -- Drag Logic (Pada TopBar)
    local dragging, dragStart, startPos
    TopBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true; dragStart = input.Position; startPos = MainFrame.Position
            input.Changed:Connect(function() if input.UserInputState == Enum.UserInputState.End then dragging = false end end)
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStart
            Tween(MainFrame, {Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)}, 0.05)
        end
    end)

    -- [TABS SYSTEM]
    local Tabs = {}
    function Window:AddTab(ConfigData)
        local TabBtn = Instance.new("TextButton"); TabBtn.Parent = TabContainer; TabBtn.BackgroundTransparency = 1; TabBtn.Size = UDim2.new(1,0,0,35); TabBtn.Text = ""
        local TabBg = Instance.new("Frame"); TabBg.Parent = TabBtn; TabBg.BackgroundColor3 = Config.Colors.Accent; TabBg.BackgroundTransparency = 1; TabBg.Size = UDim2.new(1,-20,1,0); TabBg.Position = UDim2.new(0,10,0,0); local tc = Instance.new("UICorner"); tc.CornerRadius=UDim.new(0,8); tc.Parent=TabBg
        local IconImg = Instance.new("ImageLabel"); IconImg.Parent = TabBtn; IconImg.BackgroundTransparency = 1; IconImg.Position = UDim2.new(0, 15, 0.5, -9); IconImg.Size = UDim2.new(0, 18, 0, 18); IconImg.ImageColor3 = Config.Colors.TextGray; IconImg.ZIndex = 5
        if Config.Icons[ConfigData.Icon] then IconImg.Image = Config.Icons[ConfigData.Icon] end
        
        local Label = Instance.new("TextLabel"); Label.Parent = TabBtn; Label.BackgroundTransparency = 1; Label.Position = UDim2.new(0,42,0,0); Label.Size = UDim2.new(1,-40,1,0); Label.Text = ConfigData.Title; Label.Font = Enum.Font.GothamMedium; Label.TextColor3 = Config.Colors.TextGray; Label.TextSize = 13; Label.TextXAlignment = Enum.TextXAlignment.Left; Label.ZIndex = 5
        local Page = Instance.new("ScrollingFrame"); Page.Parent = PagesFolder; Page.BackgroundTransparency = 1; Page.Size = UDim2.new(1,0,1,0); Page.Visible = false; Page.ScrollBarThickness = 2; Page.AutomaticCanvasSize = Enum.AutomaticSize.Y
        local PL = Instance.new("UIListLayout"); PL.Parent = Page; PL.SortOrder = Enum.SortOrder.LayoutOrder; PL.Padding = UDim.new(0,8)

        TabBtn.MouseButton1Click:Connect(function()
            for _, t in pairs(Tabs) do t.Page.Visible=false; Tween(t.Label,{TextColor3=Config.Colors.TextGray}); Tween(t.Icon,{ImageColor3=Config.Colors.TextGray}); Tween(t.Bg,{BackgroundTransparency=1}) end
            Page.Visible=true; Tween(Label,{TextColor3=Config.Colors.Accent}); Tween(IconImg,{ImageColor3=Config.Colors.Accent}); Tween(TabBg,{BackgroundTransparency=0.95})
        end)
        table.insert(Tabs, {Btn=TabBtn, Label=Label, Icon=IconImg, Bg=TabBg, Page=Page})
        if #Tabs==1 then Page.Visible=true; Label.TextColor3=Config.Colors.Accent; IconImg.ImageColor3=Config.Colors.Accent; TabBg.BackgroundTransparency=0.95 end

        local Elements = {}
        function Elements:AddButton(Data)
            local Btn = Instance.new("TextButton"); Btn.Parent = Page; Btn.BackgroundColor3 = Config.Colors.Element; Btn.BackgroundTransparency = 0.3; Btn.Size = UDim2.new(1,0,0,42); Btn.Text = Data.Title; Btn.Font = Enum.Font.Gotham; Btn.TextColor3 = Config.Colors.Text; Btn.TextSize = 13; Btn.AutoButtonColor = false; local c = Instance.new("UICorner"); c.CornerRadius = UDim.new(0,8); c.Parent = Btn
            Btn.MouseButton1Click:Connect(function() 
                Tween(Btn, {Size = UDim2.new(1,-4,0,38)}, 0.1); task.wait(0.1); Tween(Btn, {Size = UDim2.new(1,0,0,42)}, 0.1)
                if Data.Callback then Data.Callback() end 
            end)
        end
        function Elements:AddToggle(Data)
            local State = Data.Default or false
            local Btn = Instance.new("TextButton"); Btn.Parent = Page; Btn.BackgroundColor3 = Config.Colors.Element; Btn.BackgroundTransparency = 0.3; Btn.Size = UDim2.new(1,0,0,42); Btn.Text = "   "..Data.Title; Btn.Font = Enum.Font.Gotham; Btn.TextColor3 = Config.Colors.Text; Btn.TextSize = 13; Btn.TextXAlignment = Enum.TextXAlignment.Left; Btn.AutoButtonColor = false; local c = Instance.new("UICorner"); c.CornerRadius = UDim.new(0,8); c.Parent = Btn
            local Sw = Instance.new("Frame"); Sw.Parent = Btn; Sw.BackgroundColor3 = State and Config.Colors.Accent or Color3.fromRGB(50,50,50); Sw.Position = UDim2.new(1,-50,0.5,-10); Sw.Size = UDim2.new(0,36,0,20); local sc = Instance.new("UICorner"); sc.CornerRadius = UDim.new(0,8); sc.Parent = Sw
            local Dot = Instance.new("Frame"); Dot.Parent = Sw; Dot.BackgroundColor3 = State and Config.Colors.Text or Config.Colors.TextGray; Dot.Position = State and UDim2.new(1,-18,0.5,-8) or UDim2.new(0,2,0.5,-8); Dot.Size = UDim2.new(0,16,0,16); local dc = Instance.new("UICorner"); dc.CornerRadius = UDim.new(1,0); dc.Parent = Dot
            Btn.MouseButton1Click:Connect(function() State = not State; 
                Tween(Sw,{BackgroundColor3=State and Config.Colors.Accent or Color3.fromRGB(50,50,50)}); Tween(Dot,{Position=State and UDim2.new(1,-18,0.5,-8) or UDim2.new(0,2,0.5,-8), BackgroundColor3=State and Config.Colors.Text or Config.Colors.TextGray})
                if Data.Callback then Data.Callback(State) end 
            end)
        end
        function Elements:AddSlider(Data)
            local F = Instance.new("Frame"); F.Parent = Page; F.BackgroundColor3 = Config.Colors.Element; F.BackgroundTransparency = 0.3; F.Size = UDim2.new(1,0,0,60); local c = Instance.new("UICorner"); c.CornerRadius = UDim.new(0,8); c.Parent = F
            local L = Instance.new("TextLabel"); L.Parent = F; L.BackgroundTransparency = 1; L.Position = UDim2.new(0,12,0,5); L.Size = UDim2.new(1,-24,0,20); L.Text = Data.Title; L.Font = Enum.Font.GothamMedium; L.TextColor3 = Config.Colors.Text; L.TextSize = 13; L.TextXAlignment = Enum.TextXAlignment.Left
            local V = Instance.new("TextLabel"); V.Parent = F; V.BackgroundTransparency = 1; V.Position = UDim2.new(0,12,0,5); V.Size = UDim2.new(1,-24,0,20); V.Text = tostring(Data.Default or Data.Min); V.Font = Enum.Font.GothamBold; V.TextColor3 = Config.Colors.Accent; V.TextSize = 13; V.TextXAlignment = Enum.TextXAlignment.Right
            local Hit = Instance.new("TextButton"); Hit.Parent = F; Hit.BackgroundTransparency = 1; Hit.Size = UDim2.new(1,0,1,0); Hit.Text = ""
            local Bg = Instance.new("Frame"); Bg.Parent = F; Bg.BackgroundColor3 = Color3.fromRGB(50,50,50); Bg.Position = UDim2.new(0,12,0,40); Bg.Size = UDim2.new(1,-24,0,6); local bc = Instance.new("UICorner"); bc.Parent = Bg
            local Fill = Instance.new("Frame"); Fill.Parent = Bg; Fill.BackgroundColor3 = Config.Colors.Accent; Fill.Size = UDim2.new(((Data.Default or Data.Min)-Data.Min)/(Data.Max-Data.Min),0,1,0); local fc = Instance.new("UICorner"); fc.Parent = Fill
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
