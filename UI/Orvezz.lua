--[[
    KAIZO UI LIBRARY (Source)
    Author: KaizoX
    Style: Modern, Clean, Animated
]]

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")

-- [1] UTILITIES & CONFIG
local Library = {}
local UIConfig = {
    Colors = {
        MainBg = Color3.fromRGB(18, 18, 20),
        TopBar = Color3.fromRGB(25, 25, 28),
        Sidebar = Color3.fromRGB(22, 22, 24),
        Element = Color3.fromRGB(35, 35, 38),
        Accent = Color3.fromRGB(200, 200, 200),
        Text = Color3.fromRGB(240, 240, 240),
        TextGray = Color3.fromRGB(140, 140, 140),
        Input = Color3.fromRGB(5, 5, 5)
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

local function Tween(obj, props, time)
    TweenService:Create(obj, TweenInfo.new(time or 0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), props):Play()
end

-- [2] CONSTRUCTOR (WINDOW)
function Library:CreateWindow(Settings)
    local Window = {}
    
    -- Destroy Old UI
    if CoreGui:FindFirstChild(Settings.Name or "KaiZoUI") then
        CoreGui[Settings.Name or "KaiZoUI"]:Destroy()
    end

    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = Settings.Name or "KaiZoUI"
    ScreenGui.Parent = CoreGui
    ScreenGui.ResetOnSpawn = false

    -- Floating Toggle
    local FloatBtn = Instance.new("ImageButton")
    FloatBtn.Name = "ToggleUI"
    FloatBtn.Parent = ScreenGui
    FloatBtn.BackgroundColor3 = UIConfig.Colors.TopBar
    FloatBtn.Position = UDim2.new(0.1, 0, 0.1, 0)
    FloatBtn.Size = UDim2.fromOffset(50, 50)
    FloatBtn.Image = Settings.Icon or UIConfig.Icons.Menu
    local fc = Instance.new("UICorner"); fc.CornerRadius = UDim.new(0, 14); fc.Parent = FloatBtn
    local fs = Instance.new("UIStroke"); fs.Parent = FloatBtn; fs.Color = UIConfig.Colors.Accent; fs.Thickness = 1
    
    -- Main Frame
    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Parent = ScreenGui
    MainFrame.BackgroundColor3 = UIConfig.Colors.MainBg
    MainFrame.Position = UDim2.new(0.5, -300, 0.5, -180)
    MainFrame.Size = UDim2.fromOffset(600, 360)
    MainFrame.ClipsDescendants = true
    local mc = Instance.new("UICorner"); mc.CornerRadius = UDim.new(0, 12); mc.Parent = MainFrame
    local ms = Instance.new("UIStroke"); ms.Parent = MainFrame; ms.Color = Color3.fromRGB(50,50,50); ms.Thickness = 1

    -- Drag Logic
    local dragging, dragInput, dragStart, startPos
    local function UpdateDrag(input)
        local delta = input.Position - dragStart
        Tween(MainFrame, {Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)}, 0.05)
    end
    MainFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true; dragStart = input.Position; startPos = MainFrame.Position
            input.Changed:Connect(function() if input.UserInputState == Enum.UserInputState.End then dragging = false end end)
        end
    end)
    MainFrame.InputChanged:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseMovement then dragInput = input end end)
    UserInputService.InputChanged:Connect(function(input) if input == dragInput and dragging then UpdateDrag(input) end end)

    -- Floating Button Logic
    local UIVisible = true
    FloatBtn.MouseButton1Click:Connect(function()
        UIVisible = not UIVisible
        MainFrame.Visible = UIVisible
    end)

    -- TopBar
    local TopBar = Instance.new("Frame"); TopBar.Parent = MainFrame; TopBar.BackgroundColor3 = UIConfig.Colors.TopBar; TopBar.Size = UDim2.new(1,0,0,50); TopBar.ZIndex=2
    local Title = Instance.new("TextLabel"); Title.Parent = TopBar; Title.BackgroundTransparency=1; Title.Position=UDim2.new(0,20,0,0); Title.Size=UDim2.new(0,200,1,0); Title.Text=Settings.Title or "Library"; Title.Font=Enum.Font.GothamBlack; Title.TextColor3=UIConfig.Colors.Accent; Title.TextSize=22; Title.TextXAlignment=Enum.TextXAlignment.Left
    
    -- Content Container
    local ContentArea = Instance.new("Frame"); ContentArea.Parent = MainFrame; ContentArea.BackgroundTransparency=1; ContentArea.Position=UDim2.new(0,150,0,50); ContentArea.Size=UDim2.new(1,-150,1,-50)
    local PagesFolder = Instance.new("Frame"); PagesFolder.Parent = ContentArea; PagesFolder.BackgroundTransparency=1; PagesFolder.Position=UDim2.new(0,15,0,15); PagesFolder.Size=UDim2.new(1,-30,1,-30)

    -- Sidebar
    local Sidebar = Instance.new("Frame"); Sidebar.Parent = MainFrame; Sidebar.BackgroundColor3 = UIConfig.Colors.Sidebar; Sidebar.Position=UDim2.new(0,0,0,50); Sidebar.Size=UDim2.new(0,150,1,-50)
    local TabContainer = Instance.new("ScrollingFrame"); TabContainer.Parent = Sidebar; TabContainer.BackgroundTransparency=1; TabContainer.Position=UDim2.new(0,0,0,15); TabContainer.Size=UDim2.new(1,0,1,-15); TabContainer.ScrollBarThickness=0
    local TabList = Instance.new("UIListLayout"); TabList.Parent = TabContainer; TabList.Padding = UDim.new(0,5)

    -- [3] TABS SYSTEM
    local Tabs = {}
    
    function Window:AddTab(Config)
        local TabName = Config.Title or "Tab"
        local TabIcon = Config.Icon or "" -- Use predefined keys if passed
        
        local TabBtn = Instance.new("TextButton")
        TabBtn.Parent = TabContainer
        TabBtn.BackgroundTransparency = 1
        TabBtn.Size = UDim2.new(1, 0, 0, 35)
        TabBtn.Text = ""

        local Label = Instance.new("TextLabel"); Label.Parent = TabBtn; Label.BackgroundTransparency=1; Label.Position=UDim2.new(0,42,0,0); Label.Size=UDim2.new(1,-40,1,0); Label.Text=TabName; Label.Font=Enum.Font.GothamMedium; Label.TextColor3=UIConfig.Colors.TextGray; Label.TextSize=13; Label.TextXAlignment=Enum.TextXAlignment.Left
        local IconImg = Instance.new("ImageLabel"); IconImg.Parent = TabBtn; IconImg.BackgroundTransparency=1; IconImg.Position=UDim2.new(0,15,0.5,-9); IconImg.Size=UDim2.new(0,18,0,18); IconImg.ImageColor3=UIConfig.Colors.TextGray
        
        -- Check if icon is in library or raw id
        if UIConfig.Icons[TabIcon] then IconImg.Image = UIConfig.Icons[TabIcon] else IconImg.Image = TabIcon end

        local Page = Instance.new("ScrollingFrame"); Page.Parent = PagesFolder; Page.BackgroundTransparency=1; Page.Size=UDim2.new(1,0,1,0); Page.Visible=false; Page.ScrollBarThickness=2; Page.AutomaticCanvasSize=Enum.AutomaticSize.Y
        local PageLayout = Instance.new("UIListLayout"); PageLayout.Parent = Page; PageLayout.Padding = UDim.new(0,8); PageLayout.SortOrder=Enum.SortOrder.LayoutOrder
        
        local TabObj = {Btn = TabBtn, Page = Page, Label = Label, Icon = IconImg}

        TabBtn.MouseButton1Click:Connect(function()
            for _, t in pairs(Tabs) do
                t.Page.Visible = false
                Tween(t.Label, {TextColor3 = UIConfig.Colors.TextGray})
                Tween(t.Icon, {ImageColor3 = UIConfig.Colors.TextGray})
            end
            Page.Visible = true
            Tween(Label, {TextColor3 = UIConfig.Colors.Accent})
            Tween(IconImg, {ImageColor3 = UIConfig.Colors.Accent})
        end)
        
        table.insert(Tabs, TabObj)
        if #Tabs == 1 then -- Select first tab default
            Page.Visible = true
            Label.TextColor3 = UIConfig.Colors.Accent
            IconImg.ImageColor3 = UIConfig.Colors.Accent
        end

        -- [4] ELEMENTS
        local TabFunctions = {}

        function TabFunctions:AddSection(Text)
            local L = Instance.new("TextLabel"); L.Parent = Page; L.BackgroundTransparency=1; L.Size=UDim2.new(1,0,0,30); L.Text=Text; L.Font=Enum.Font.GothamBold; L.TextColor3=UIConfig.Colors.Accent; L.TextSize=14
        end

        function TabFunctions:AddButton(Config)
            local Title = Config.Title or "Button"
            local Callback = Config.Callback or function() end
            
            local Btn = Instance.new("TextButton"); Btn.Parent = Page; Btn.BackgroundColor3=UIConfig.Colors.Element; Btn.BackgroundTransparency=0.3; Btn.Size=UDim2.new(1,0,0,42); Btn.Text=Title; Btn.Font=Enum.Font.Gotham; Btn.TextColor3=UIConfig.Colors.Text; Btn.TextSize=13; Btn.AutoButtonColor=false
            local c = Instance.new("UICorner"); c.CornerRadius=UDim.new(0,8); c.Parent=Btn
            
            Btn.MouseEnter:Connect(function() Tween(Btn, {BackgroundColor3 = Color3.fromRGB(45,45,48)}) end)
            Btn.MouseLeave:Connect(function() Tween(Btn, {BackgroundColor3 = UIConfig.Colors.Element}) end)
            Btn.MouseButton1Click:Connect(function() 
                Tween(Btn, {Size = UDim2.new(1,-4,0,38)}, 0.1)
                wait(0.1)
                Tween(Btn, {Size = UDim2.new(1,0,0,42)}, 0.1)
                Callback() 
            end)
        end

        function TabFunctions:AddToggle(Config)
            local Title = Config.Title or "Toggle"
            local Default = Config.Default or false
            local Callback = Config.Callback or function() end
            local State = Default

            local Btn = Instance.new("TextButton"); Btn.Parent = Page; Btn.BackgroundColor3=UIConfig.Colors.Element; Btn.BackgroundTransparency=0.3; Btn.Size=UDim2.new(1,0,0,42); Btn.Text="   "..Title; Btn.Font=Enum.Font.Gotham; Btn.TextColor3=UIConfig.Colors.Text; Btn.TextSize=13; Btn.TextXAlignment=Enum.TextXAlignment.Left; Btn.AutoButtonColor=false
            local c = Instance.new("UICorner"); c.CornerRadius=UDim.new(0,8); c.Parent=Btn
            
            local Sw = Instance.new("Frame"); Sw.Parent = Btn; Sw.BackgroundColor3 = State and UIConfig.Colors.Accent or Color3.fromRGB(50,50,50); Sw.Position = UDim2.new(1,-50,0.5,-10); Sw.Size = UDim2.new(0,36,0,20)
            local sc = Instance.new("UICorner"); sc.CornerRadius=UDim.new(0,8); sc.Parent=Sw
            local Dot = Instance.new("Frame"); Dot.Parent = Sw; Dot.BackgroundColor3 = State and UIConfig.Colors.Text or UIConfig.Colors.TextGray; Dot.Position = State and UDim2.new(1,-18,0.5,-8) or UDim2.new(0,2,0.5,-8); Dot.Size = UDim2.new(0,16,0,16)
            local dc = Instance.new("UICorner"); dc.CornerRadius=UDim.new(1,0); dc.Parent=Dot

            Btn.MouseButton1Click:Connect(function()
                State = not State
                if State then
                    Tween(Sw, {BackgroundColor3 = UIConfig.Colors.Accent})
                    Tween(Dot, {Position = UDim2.new(1,-18,0.5,-8), BackgroundColor3 = UIConfig.Colors.Text})
                else
                    Tween(Sw, {BackgroundColor3 = Color3.fromRGB(50,50,50)})
                    Tween(Dot, {Position = UDim2.new(0,2,0.5,-8), BackgroundColor3 = UIConfig.Colors.TextGray})
                end
                Callback(State)
            end)
        end

        function TabFunctions:AddInput(Config)
            local Title = Config.Title or "Input"
            local Placeholder = Config.Placeholder or "..."
            local Callback = Config.Callback or function() end

            local F = Instance.new("Frame"); F.Parent = Page; F.BackgroundColor3=UIConfig.Colors.Element; F.BackgroundTransparency=0.3; F.Size=UDim2.new(1,0,0,45)
            local c = Instance.new("UICorner"); c.CornerRadius=UDim.new(0,8); c.Parent=F
            local L = Instance.new("TextLabel"); L.Parent = F; L.BackgroundTransparency=1; L.Position=UDim2.new(0,12,0,0); L.Size=UDim2.new(0,100,1,0); L.Text=Title; L.Font=Enum.Font.GothamMedium; L.TextColor3=UIConfig.Colors.Text; L.TextSize=13; L.TextXAlignment=Enum.TextXAlignment.Left
            
            local BoxCon = Instance.new("Frame"); BoxCon.Parent = F; BoxCon.BackgroundColor3=UIConfig.Colors.Input; BoxCon.Position=UDim2.new(1,-160,0.5,-15); BoxCon.Size=UDim2.new(0,150,0,30)
            local bc = Instance.new("UICorner"); bc.CornerRadius=UDim.new(0,6); bc.Parent=BoxCon
            
            local TB = Instance.new("TextBox"); TB.Parent = BoxCon; TB.BackgroundTransparency=1; TB.Position=UDim2.new(0,8,0,0); TB.Size=UDim2.new(1,-16,1,0); TB.Font=Enum.Font.Gotham; TB.PlaceholderText=Placeholder; TB.Text=""; TB.TextColor3=UIConfig.Colors.Text; TB.PlaceholderColor3=UIConfig.Colors.TextGray; TB.TextSize=13; TB.TextXAlignment=Enum.TextXAlignment.Left; TB.ClearTextOnFocus=false
            
            TB.FocusLost:Connect(function() Callback(TB.Text) end)
        end

        function TabFunctions:AddSlider(Config)
            local Title = Config.Title or "Slider"
            local Min = Config.Min or 0
            local Max = Config.Max or 100
            local Default = Config.Default or 50
            local Callback = Config.Callback or function() end

            local F = Instance.new("Frame"); F.Parent = Page; F.BackgroundColor3=UIConfig.Colors.Element; F.BackgroundTransparency=0.3; F.Size=UDim2.new(1,0,0,60)
            local c = Instance.new("UICorner"); c.CornerRadius=UDim.new(0,8); c.Parent=F
            local L = Instance.new("TextLabel"); L.Parent = F; L.BackgroundTransparency=1; L.Position=UDim2.new(0,12,0,5); L.Size=UDim2.new(1,-24,0,20); L.Text=Title; L.Font=Enum.Font.GothamMedium; L.TextColor3=UIConfig.Colors.Text; L.TextSize=13; L.TextXAlignment=Enum.TextXAlignment.Left
            local V = Instance.new("TextLabel"); V.Parent = F; V.BackgroundTransparency=1; V.Position=UDim2.new(0,12,0,5); V.Size=UDim2.new(1,-24,0,20); V.Text=tostring(Default); V.Font=Enum.Font.GothamBold; V.TextColor3=UIConfig.Colors.Accent; V.TextSize=13; V.TextXAlignment=Enum.TextXAlignment.Right
            
            local Hitbox = Instance.new("TextButton"); Hitbox.Parent = F; Hitbox.BackgroundTransparency=1; Hitbox.Size=UDim2.new(1,0,1,0); Hitbox.Text=""
            local BarBg = Instance.new("Frame"); BarBg.Parent = F; BarBg.BackgroundColor3=Color3.fromRGB(50,50,50); BarBg.Position=UDim2.new(0,12,0,40); BarBg.Size=UDim2.new(1,-24,0,6)
            local bc = Instance.new("UICorner"); bc.CornerRadius=UDim.new(1,0); bc.Parent=BarBg
            local BarFill = Instance.new("Frame"); BarFill.Parent = BarBg; BarFill.BackgroundColor3=UIConfig.Colors.Accent; BarFill.Size=UDim2.new((Default-Min)/(Max-Min),0,1,0)
            local bfc = Instance.new("UICorner"); bfc.CornerRadius=UDim.new(1,0); bfc.Parent=BarFill

            local function Update(input)
                local Percent = math.clamp((input.Position.X - BarBg.AbsolutePosition.X) / BarBg.AbsoluteSize.X, 0, 1)
                local Value = math.floor(Min + (Max - Min) * Percent)
                V.Text = tostring(Value)
                Tween(BarFill, {Size = UDim2.new(Percent, 0, 1, 0)}, 0.05)
                Callback(Value)
            end

            Hitbox.MouseButton1Down:Connect(function()
                local moveCn, endCn
                Update({Position = UserInputService:GetMouseLocation()})
                moveCn = UserInputService.InputChanged:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseMovement then Update(input) end end)
                endCn = UserInputService.InputEnded:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 then moveCn:Disconnect(); endCn:Disconnect() end end)
            end)
        end

        return TabFunctions
    end

    return Window
end

return Library
