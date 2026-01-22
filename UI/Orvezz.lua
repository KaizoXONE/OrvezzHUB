--[[
    KAIZO HUB V21 (SECTION BOX EDITION)
    Author: KaizoX
    Fix: "AddSection" now creates a real Container/Box.
    Style: Modern Dark/Grey (WindUI Style).
]]

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")

local Library = {}

-- [CONFIG COLORS]
local Config = {
    Colors = {
        MainBg      = Color3.fromRGB(18, 18, 20),
        TopBar      = Color3.fromRGB(24, 24, 26),
        Sidebar     = Color3.fromRGB(22, 22, 24),
        Section     = Color3.fromRGB(25, 25, 28), -- Warna Kotak Section
        Element     = Color3.fromRGB(32, 32, 35),
        Accent      = Color3.fromRGB(255, 255, 255),
        Text        = Color3.fromRGB(240, 240, 240),
        TextDark    = Color3.fromRGB(160, 160, 160),
        Input       = Color3.fromRGB(10, 10, 12),
        Stroke      = Color3.fromRGB(45, 45, 45)
    },
    Icons = {
        Home = "rbxassetid://10709782497",
        Sword = "rbxassetid://10709781460",
        Eye = "rbxassetid://10709782172",
        Settings = "rbxassetid://10734950309",
        Menu = "rbxassetid://10709783095"
    }
}

local function Tween(obj, props, time)
    TweenService:Create(obj, TweenInfo.new(time or 0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), props):Play()
end

function Library:CreateWindow(Settings)
    local Window = {}
    if CoreGui:FindFirstChild(Settings.Name) then CoreGui[Settings.Name]:Destroy() end

    local sg = Instance.new("ScreenGui")
    sg.Name = Settings.Name
    sg.Parent = CoreGui
    sg.ResetOnSpawn = false
    sg.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    -- [FLOAT BUTTON]
    local Float = Instance.new("ImageButton")
    Float.Parent = sg; Float.BackgroundColor3 = Config.Colors.TopBar; Float.Position = UDim2.new(0.1,0,0.1,0); Float.Size = UDim2.fromOffset(50,50); Float.Image = Settings.Icon
    local fc = Instance.new("UICorner"); fc.CornerRadius = UDim.new(0,14); fc.Parent = Float
    local fs = Instance.new("UIStroke"); fs.Parent = Float; fs.Color = Config.Colors.Accent; fs.Thickness = 1
    
    local fd, fs_pos, fp
    Float.InputBegan:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 then fd=true; fs_pos=i.Position; fp=Float.Position; i.Changed:Connect(function() if i.UserInputState==Enum.UserInputState.End then fd=false end end) end end)
    UserInputService.InputChanged:Connect(function(i) if fd and i.UserInputType==Enum.UserInputType.MouseMovement then local d=i.Position-fs_pos; Tween(Float,{Position=UDim2.new(fp.X.Scale,fp.X.Offset+d.X,fp.Y.Scale,fp.Y.Offset+d.Y)},0.05) end end)

    -- [MAIN STRUCTURE]
    local Root = Instance.new("Frame"); Root.Parent = sg; Root.BackgroundTransparency = 1; Root.Position = UDim2.new(0.5,-300,0.5,-200); Root.Size = UDim2.fromOffset(600, 400); Root.Visible = true
    
    local Shadow = Instance.new("ImageLabel"); Shadow.Parent = Root; Shadow.Image = "rbxassetid://6014261993"; Shadow.ImageColor3 = Color3.new(0,0,0); Shadow.ImageTransparency = 0.4; Shadow.BackgroundTransparency = 1; Shadow.Position = UDim2.new(0,-35,0,-35); Shadow.Size = UDim2.new(1,70,1,70); Shadow.ScaleType = Enum.ScaleType.Slice; Shadow.SliceCenter = Rect.new(49,49,450,450); Shadow.ZIndex = 0

    local Main = Instance.new("Frame"); Main.Parent = Root; Main.BackgroundColor3 = Config.Colors.MainBg; Main.Size = UDim2.new(1,0,1,0); Main.ClipsDescendants = true; Main.ZIndex = 1
    local mc = Instance.new("UICorner"); mc.CornerRadius = UDim.new(0,12); mc.Parent = Main
    local ms = Instance.new("UIStroke"); ms.Parent = Main; ms.Color = Config.Colors.Stroke; ms.Thickness = 1

    -- Toggle Logic
    local IsOpen = true
    Float.MouseButton1Click:Connect(function() IsOpen=not IsOpen; Root.Visible=IsOpen end)

    -- [LAYOUT]
    local TopBar = Instance.new("Frame"); TopBar.Parent = Main; TopBar.BackgroundColor3 = Config.Colors.TopBar; TopBar.Size = UDim2.new(1,0,0,50); TopBar.ZIndex = 5
    local DragBtn = Instance.new("TextButton"); DragBtn.Parent = TopBar; DragBtn.BackgroundTransparency = 1; DragBtn.Size = UDim2.new(1,-50,1,0); DragBtn.Text = ""; DragBtn.ZIndex = 10
    
    local dd, ds, dp
    DragBtn.InputBegan:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 then dd=true; ds=i.Position; dp=Root.Position; i.Changed:Connect(function() if i.UserInputState==Enum.UserInputState.End then dd=false end end) end end)
    UserInputService.InputChanged:Connect(function(i) if dd and i.UserInputType==Enum.UserInputType.MouseMovement then local d=i.Position-ds; Tween(Root,{Position=UDim2.new(dp.X.Scale,dp.X.Offset+d.X,dp.Y.Scale,dp.Y.Offset+d.Y)},0.05) end end)

    local Title = Instance.new("TextLabel"); Title.Parent = TopBar; Title.BackgroundTransparency=1; Title.Position=UDim2.new(0,20,0,0); Title.Size=UDim2.new(0,200,1,0); Title.Text=Settings.Title; Title.Font=Enum.Font.GothamBlack; Title.TextColor3=Config.Colors.Accent; Title.TextSize=22; Title.TextXAlignment=Enum.TextXAlignment.Left; Title.ZIndex=6
    local Close = Instance.new("TextButton"); Close.Parent = TopBar; Close.BackgroundTransparency=1; Close.Position=UDim2.new(1,-45,0,0); Close.Size=UDim2.new(0,45,1,0); Close.Text="×"; Close.Font=Enum.Font.GothamMedium; Close.TextColor3=Config.Colors.TextDark; Close.TextSize=30; Close.ZIndex=11
    Close.MouseButton1Click:Connect(function() Root.Visible=false; IsOpen=false end)

    local Sidebar = Instance.new("Frame"); Sidebar.Parent = Main; Sidebar.BackgroundColor3 = Config.Colors.Sidebar; Sidebar.Position=UDim2.new(0,0,0,50); Sidebar.Size=UDim2.new(0,160,1,-50); Sidebar.ZIndex=2
    local TabScroll = Instance.new("ScrollingFrame"); TabScroll.Parent = Sidebar; TabScroll.BackgroundTransparency=1; TabScroll.Position=UDim2.new(0,0,0,15); TabScroll.Size=UDim2.new(1,0,1,-15); TabScroll.ScrollBarThickness=0; TabScroll.ZIndex=3
    local TabList = Instance.new("UIListLayout"); TabList.Parent = TabScroll; TabList.Padding = UDim.new(0,5)

    local Content = Instance.new("Frame"); Content.Parent = Main; Content.BackgroundTransparency=1; Content.Position=UDim2.new(0,160,0,50); Content.Size=UDim2.new(1,-160,1,-50); Content.ZIndex=2
    local PageFolder = Instance.new("Frame"); PageFolder.Parent = Content; PageFolder.BackgroundTransparency=1; PageFolder.Position=UDim2.new(0,15,0,15); PageFolder.Size=UDim2.new(1,-30,1,-30); PageFolder.ZIndex=2

    -- [TABS & ELEMENTS SYSTEM]
    local Tabs = {}
    
    function Window:AddTab(Name, IconKey)
        local TabBtn = Instance.new("TextButton"); TabBtn.Parent = TabScroll; TabBtn.BackgroundTransparency=1; TabBtn.Size=UDim2.new(1,0,0,38); TabBtn.Text=""; TabBtn.ZIndex=5
        local TabBg = Instance.new("Frame"); TabBg.Parent = TabBtn; TabBg.BackgroundColor3 = Config.Colors.Section; TabBg.BackgroundTransparency=1; TabBg.Size=UDim2.new(1,-20,1,0); TabBg.Position=UDim2.new(0,10,0,0); TabBg.ZIndex=3; local c=Instance.new("UICorner"); c.CornerRadius=UDim.new(0,8); c.Parent=TabBg
        local Ind = Instance.new("Frame"); Ind.Parent = TabBtn; Ind.BackgroundColor3 = Config.Colors.Accent; Ind.Size=UDim2.new(0,0,0.6,0); Ind.Position=UDim2.new(0,0,0.2,0); Ind.ZIndex=6
        local Icon = Instance.new("ImageLabel"); Icon.Parent = TabBtn; Icon.BackgroundTransparency=1; Icon.Position=UDim2.new(0,18,0.5,-9); Icon.Size=UDim2.new(0,18,0,18); Icon.Image=Config.Icons[IconKey] or ""; Icon.ImageColor3=Config.Colors.TextDark; Icon.ZIndex=6
        local Label = Instance.new("TextLabel"); Label.Parent = TabBtn; Label.BackgroundTransparency=1; Label.Position=UDim2.new(0,45,0,0); Label.Size=UDim2.new(1,-45,1,0); Label.Text=Name; Label.Font=Enum.Font.GothamMedium; Label.TextColor3=Config.Colors.TextDark; Label.TextSize=13; Label.TextXAlignment=Enum.TextXAlignment.Left; Label.ZIndex=6

        local Page = Instance.new("ScrollingFrame"); Page.Parent = PageFolder; Page.BackgroundTransparency=1; Page.Size=UDim2.new(1,0,1,0); Page.Visible=false; Page.ScrollBarThickness=2; Page.AutomaticCanvasSize=Enum.AutomaticSize.Y; Page.ZIndex=5
        local PL = Instance.new("UIListLayout"); PL.Parent = Page; PL.Padding = UDim.new(0,10); PL.SortOrder=Enum.SortOrder.LayoutOrder

        TabBtn.MouseButton1Click:Connect(function()
            for _,t in pairs(Tabs) do t.Page.Visible=false; Tween(t.Label,{TextColor3=Config.Colors.TextDark}); Tween(t.Icon,{ImageColor3=Config.Colors.TextDark}); Tween(t.Bg,{BackgroundTransparency=1}); Tween(t.Ind,{Size=UDim2.new(0,0,0.6,0)}) end
            Page.Visible=true; Tween(Label,{TextColor3=Config.Colors.Accent}); Tween(Icon,{ImageColor3=Config.Colors.Accent}); Tween(TabBg,{BackgroundTransparency=0}); Tween(Ind,{Size=UDim2.new(0,3,0.6,0)})
        end)
        table.insert(Tabs, {Btn=TabBtn, Page=Page, Label=Label, Icon=Icon, Bg=TabBg, Ind=Ind})
        if #Tabs==1 then Page.Visible=true; Label.TextColor3=Config.Colors.Accent; Icon.ImageColor3=Config.Colors.Accent; TabBg.BackgroundTransparency=0; Ind.Size=UDim2.new(0,3,0.6,0) end

        -- [SECTION & ELEMENTS LOGIC]
        local TabFunctions = {}

        -- >>> ADD SECTION (BOX CONTAINER) <<<
        function TabFunctions:AddSection(Title)
            local SectionFrame = Instance.new("Frame")
            SectionFrame.Parent = Page
            SectionFrame.BackgroundColor3 = Config.Colors.Section
            SectionFrame.Size = UDim2.new(1, 0, 0, 0) -- Auto resized
            SectionFrame.AutomaticSize = Enum.AutomaticSize.Y
            SectionFrame.ZIndex = 5
            
            local sc = Instance.new("UICorner"); sc.CornerRadius = UDim.new(0, 8); sc.Parent = SectionFrame
            local ss = Instance.new("UIStroke"); ss.Parent = SectionFrame; ss.Color = Config.Colors.Stroke; ss.Thickness = 1

            local SectionTitle = Instance.new("TextLabel")
            SectionTitle.Parent = SectionFrame
            SectionTitle.BackgroundTransparency = 1
            SectionTitle.Position = UDim2.new(0, 12, 0, 8)
            SectionTitle.Size = UDim2.new(1, -24, 0, 20)
            SectionTitle.Text = Title
            SectionTitle.Font = Enum.Font.GothamBold
            SectionTitle.TextColor3 = Config.Colors.Text
            SectionTitle.TextSize = 13
            SectionTitle.TextXAlignment = Enum.TextXAlignment.Left
            SectionTitle.ZIndex = 6

            local Container = Instance.new("Frame")
            Container.Parent = SectionFrame
            Container.BackgroundTransparency = 1
            Container.Position = UDim2.new(0, 10, 0, 35)
            Container.Size = UDim2.new(1, -20, 0, 0)
            Container.AutomaticSize = Enum.AutomaticSize.Y
            
            local SL = Instance.new("UIListLayout")
            SL.Parent = Container
            SL.SortOrder = Enum.SortOrder.LayoutOrder
            SL.Padding = UDim.new(0, 8)
            
            local SP = Instance.new("UIPadding")
            SP.Parent = SectionFrame
            SP.PaddingBottom = UDim.new(0, 12)

            local Elements = {}

            function Elements:AddButton(Text, Callback)
                local Btn = Instance.new("TextButton"); Btn.Parent = Container; Btn.BackgroundColor3 = Config.Colors.Element; Btn.Size=UDim2.new(1,0,0,38); Btn.Text=Text; Btn.Font=Enum.Font.Gotham; Btn.TextColor3=Config.Colors.Text; Btn.TextSize=13; Btn.ZIndex=10; local c=Instance.new("UICorner"); c.CornerRadius=UDim.new(0,6); c.Parent=Btn
                Btn.MouseEnter:Connect(function() Tween(Btn,{BackgroundColor3=Color3.fromRGB(45,45,45)}) end); Btn.MouseLeave:Connect(function() Tween(Btn,{BackgroundColor3=Config.Colors.Element}) end)
                Btn.MouseButton1Click:Connect(function() Tween(Btn,{Size=UDim2.new(1,-4,0,34)},0.1); wait(0.1); Tween(Btn,{Size=UDim2.new(1,0,0,38)},0.1); if Callback then Callback() end end)
            end

            function Elements:AddToggle(Text, Default, Callback)
                local State = Default or false
                local Btn = Instance.new("TextButton"); Btn.Parent = Container; Btn.BackgroundColor3 = Config.Colors.Element; Btn.Size=UDim2.new(1,0,0,38); Btn.Text="   "..Text; Btn.Font=Enum.Font.Gotham; Btn.TextColor3=Config.Colors.Text; Btn.TextSize=13; Btn.TextXAlignment=Enum.TextXAlignment.Left; Btn.ZIndex=10; local c=Instance.new("UICorner"); c.CornerRadius=UDim.new(0,6); c.Parent=Btn
                local Sw = Instance.new("Frame"); Sw.Parent=Btn; Sw.BackgroundColor3 = State and Config.Colors.Accent or Color3.fromRGB(50,50,50); Sw.Position=UDim2.new(1,-45,0.5,-10); Sw.Size=UDim2.new(0,34,0,18); Sw.ZIndex=11; local sc=Instance.new("UICorner"); sc.CornerRadius=UDim.new(0,8); sc.Parent=Sw
                local Dot = Instance.new("Frame"); Dot.Parent=Sw; Dot.BackgroundColor3 = State and Config.Colors.Text or Config.Colors.TextDark; Dot.Position = State and UDim2.new(1,-16,0.5,-7) or UDim2.new(0,2,0.5,-7); Dot.Size=UDim2.new(0,14,0,14); Dot.ZIndex=12; local dc=Instance.new("UICorner"); dc.CornerRadius=UDim.new(1,0); dc.Parent=Dot
                Btn.MouseButton1Click:Connect(function() State=not State; Tween(Sw,{BackgroundColor3=State and Config.Colors.Accent or Color3.fromRGB(50,50,50)}); Tween(Dot,{Position=State and UDim2.new(1,-16,0.5,-7) or UDim2.new(0,2,0.5,-7), BackgroundColor3=State and Config.Colors.Text or Config.Colors.TextDark}); if Callback then Callback(State) end end)
            end

            function Elements:AddSlider(Text, Min, Max, Def, Callback)
                local F = Instance.new("Frame"); F.Parent=Container; F.BackgroundColor3=Config.Colors.Element; F.Size=UDim2.new(1,0,0,50); F.ZIndex=10; local c=Instance.new("UICorner"); c.CornerRadius=UDim.new(0,6); c.Parent=F
                local L = Instance.new("TextLabel"); L.Parent=F; L.BackgroundTransparency=1; L.Position=UDim2.new(0,10,0,5); L.Size=UDim2.new(1,-20,0,20); L.Text=Text; L.Font=Enum.Font.GothamMedium; L.TextColor3=Config.Colors.Text; L.TextSize=13; L.TextXAlignment=Enum.TextXAlignment.Left; L.ZIndex=11
                local V = Instance.new("TextLabel"); V.Parent=F; V.BackgroundTransparency=1; V.Position=UDim2.new(0,10,0,5); V.Size=UDim2.new(1,-20,0,20); V.Text=tostring(Def); V.Font=Enum.Font.GothamBold; V.TextColor3=Config.Colors.Accent; V.TextSize=13; V.TextXAlignment=Enum.TextXAlignment.Right; V.ZIndex=11
                local Hit = Instance.new("TextButton"); Hit.Parent=F; Hit.BackgroundTransparency=1; Hit.Size=UDim2.new(1,0,1,0); Hit.Text=""; Hit.ZIndex=12
                local Bg = Instance.new("Frame"); Bg.Parent=F; Bg.BackgroundColor3=Color3.fromRGB(50,50,50); Bg.Position=UDim2.new(0,10,0,32); Bg.Size=UDim2.new(1,-20,0,4); Bg.ZIndex=11; local bc=Instance.new("UICorner"); bc.Parent=Bg
                local Fill = Instance.new("Frame"); Fill.Parent=Bg; Fill.BackgroundColor3=Config.Colors.Accent; Fill.Size=UDim2.new((Def-Min)/(Max-Min),0,1,0); Fill.ZIndex=11; local fc=Instance.new("UICorner"); fc.Parent=Fill
                Hit.MouseButton1Down:Connect(function() local m,k; local function U(i) local P=math.clamp((i.Position.X-Bg.AbsolutePosition.X)/Bg.AbsoluteSize.X,0,1); local v=math.floor(Min+(Max-Min)*P); V.Text=tostring(v); Tween(Fill,{Size=UDim2.new(P,0,1,0)},0.05); if Callback then Callback(v) end end; U({Position=UserInputService:GetMouseLocation()}); m=UserInputService.InputChanged:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseMovement then U(i) end end); k=UserInputService.InputEnded:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 then m:Disconnect(); k:Disconnect() end end) end)
            end

            function Elements:AddInput(Text, Place, Callback)
                local F = Instance.new("Frame"); F.Parent=Container; F.BackgroundColor3=Config.Colors.Element; F.Size=UDim2.new(1,0,0,40); F.ZIndex=10; local c=Instance.new("UICorner"); c.CornerRadius=UDim.new(0,6); c.Parent=F
                local L = Instance.new("TextLabel"); L.Parent=F; L.BackgroundTransparency=1; L.Position=UDim2.new(0,10,0,0); L.Size=UDim2.new(0,100,1,0); L.Text=Text; L.Font=Enum.Font.GothamMedium; L.TextColor3=Config.Colors.Text; L.TextSize=13; L.TextXAlignment=Enum.TextXAlignment.Left; L.ZIndex=11
                local Box = Instance.new("Frame"); Box.Parent=F; Box.BackgroundColor3=Config.Colors.Input; Box.Position=UDim2.new(1,-140,0.5,-12); Box.Size=UDim2.new(0,130,0,24); Box.ZIndex=11; local bc=Instance.new("UICorner"); bc.CornerRadius=UDim.new(0,4); bc.Parent=Box
                local TB = Instance.new("TextBox"); TB.Parent=Box; TB.BackgroundTransparency=1; TB.Size=UDim2.new(1,-10,1,0); TB.Position=UDim2.new(0,5,0,0); TB.Font=Enum.Font.Gotham; TB.Text=""; TB.PlaceholderText=Place; TB.TextColor3=Config.Colors.Text; TB.PlaceholderColor3=Config.Colors.TextDark; TB.TextSize=12; TB.TextXAlignment=Enum.TextXAlignment.Left; TB.ZIndex=12; TB.ClearTextOnFocus=false
                TB.FocusLost:Connect(function() if Callback then Callback(TB.Text) end end)
            end

            return Elements
        end

        return TabFunctions
    end
    return Window
end

-- =================================================================
-- [ CONTOH PENGGUNAAN SECTION BOX ]
-- =================================================================

local Window = Library:CreateWindow({
    Name = "KaiZoHub_V21",
    Title = "KAIZO HUB",
    Icon = "rbxassetid://132914280921668"
})

local MainTab = Window:AddTab("Main", "Home")

-- 1. Buat Section dulu
local PlayerSection = MainTab:AddSection("PLAYER SETTINGS")

-- 2. Masukkan element ke DALAM variabel Section tadi
PlayerSection:AddToggle("Auto Farm", false, function(v) 
    print("Auto Farm is", v) 
end)

PlayerSection:AddSlider("WalkSpeed", 16, 200, 16, function(v) 
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = v 
end)

-- Section Kedua
local OtherSection = MainTab:AddSection("TOOLS")

OtherSection:AddButton("Reset Character", function() 
    game.Players.LocalPlayer.Character:BreakJoints() 
end)

print("UI V21 Loaded!")
