

local Library = {}
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")



local LucideIcons = loadstring(game:HttpGet("https://raw.githubusercontent.com/latte-soft/lucide-roblox/main/src/lib.lua"))()

local function CreateIcon(iconName, size)
    size = size or 20
    if not iconName then return nil end
    
    local success, icon = pcall(function()
        return LucideIcons[iconName]
    end)
    
    if success and icon then
        local iconImage = Instance.new("ImageLabel")
        iconImage.Size = UDim2.fromOffset(size, size)
        iconImage.BackgroundTransparency = 1
        iconImage.Image = icon
        iconImage.ImageColor3 = Colors.Text
        return iconImage
    end
    
    return nil
end



local function Tween(obj, props, time, style, dir)
    local info = TweenInfo.new(
        time or 0.3, 
        style or Enum.EasingStyle.Quart, 
        dir or Enum.EasingDirection.Out
    )
    TweenService:Create(obj, info, props):Play()
end



local Colors = {
    MainBg      = Color3.fromRGB(18, 18, 20),
    TopBar      = Color3.fromRGB(25, 25, 28),
    Sidebar     = Color3.fromRGB(22, 22, 24),
    Element     = Color3.fromRGB(35, 35, 38),
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
    
    -- Destroy existing instance
    if CoreGui:FindFirstChild("KaiZoHUB_V11") then
        CoreGui.KaiZoHUB_V11:Destroy()
    end

    local sg = Instance.new("ScreenGui")
    sg.Name = "KaiZoHUB_V11"
    sg.Parent = CoreGui
    sg.ResetOnSpawn = false
    sg.ZIndexBehavior = Enum.ZIndexBehavior.Sibling


    local FloatBtn = Instance.new("ImageButton")
    FloatBtn.Name = "FloatingIcon"
    FloatBtn.Parent = sg
    FloatBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    FloatBtn.BackgroundTransparency = 0.85 -- Glass effect
    FloatBtn.Position = UDim2.new(0.1, 0, 0.1, 0)
    FloatBtn.Size = UDim2.fromOffset(50, 50)
    FloatBtn.Image = IconId
    FloatBtn.ImageTransparency = 0
    FloatBtn.ZIndex = 100
    
    local FloatCorner = Instance.new("UICorner")
    FloatCorner.CornerRadius = UDim.new(0, 14)
    FloatCorner.Parent = FloatBtn
    
    local FloatStroke = Instance.new("UIStroke")
    FloatStroke.Parent = FloatBtn
    FloatStroke.Color = Color3.fromRGB(255, 255, 255)
    FloatStroke.Thickness = 1.5
    FloatStroke.Transparency = 0.5 -- Glass border
    
    -- Hover effects
    FloatBtn.MouseEnter:Connect(function()
        Tween(FloatBtn, {Size = UDim2.fromOffset(55, 55)}, 0.2, Enum.EasingStyle.Back)
    end)
    FloatBtn.MouseLeave:Connect(function()
        Tween(FloatBtn, {Size = UDim2.fromOffset(50, 50)}, 0.2, Enum.EasingStyle.Back)
    end)

    -- Draggable floating button
    local fDrag, fStart, fPos
    FloatBtn.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            fDrag = true
            fStart = input.Position
            fPos = FloatBtn.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    fDrag = false
                end
            end)
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if fDrag and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - fStart
            Tween(FloatBtn, {
                Position = UDim2.new(
                    fPos.X.Scale, fPos.X.Offset + delta.X,
                    fPos.Y.Scale, fPos.Y.Offset + delta.Y
                )
            }, 0.05)
        end
    end)


    
    local Main = Instance.new("Frame")
    Main.Name = "MainFrame"
    Main.Parent = sg
    Main.BackgroundColor3 = Color3.fromRGB(18, 18, 20)
    Main.BackgroundTransparency = 0.3 -- Glassmorphism transparency
    Main.Position = UDim2.new(0.5, -300, 0.5, -180)
    Main.Size = UDim2.fromOffset(600, 360)
    
    -- Blur Effect for Glassmorphism
    local MainBlur = Instance.new("ImageLabel")
    MainBlur.Name = "BlurEffect"
    MainBlur.Parent = Main
    MainBlur.BackgroundTransparency = 1
    MainBlur.Size = UDim2.new(1, 0, 1, 0)
    MainBlur.Image = "rbxasset://textures/ui/GuiImagePlaceholder.png"
    MainBlur.ImageColor3 = Color3.fromRGB(255, 255, 255)
    MainBlur.ImageTransparency = 0.92
    MainBlur.ScaleType = Enum.ScaleType.Tile
    MainBlur.TileSize = UDim2.new(0, 128, 0, 128)
    MainBlur.ZIndex = 0

    local MainCorner = Instance.new("UICorner")
    MainCorner.CornerRadius = UDim.new(0, 12)
    MainCorner.Parent = Main
    
    -- Glass border effect
    local MainStroke = Instance.new("UIStroke")
    MainStroke.Parent = Main
    MainStroke.Color = Color3.fromRGB(255, 255, 255)
    MainStroke.Thickness = 1
    MainStroke.Transparency = 0.8 -- Subtle glass border

    -- Shadow effect
    local MainShadow = Instance.new("ImageLabel")
    MainShadow.Parent = Main
    MainShadow.Image = "rbxassetid://6014261993"
    MainShadow.ImageColor3 = Color3.new(0,0,0)
    MainShadow.ImageTransparency = 0.3 
    MainShadow.BackgroundTransparency = 1
    MainShadow.Position = UDim2.new(0,-25,0,-25)
    MainShadow.Size = UDim2.new(1,50,1,50)
    MainShadow.ScaleType = Enum.ScaleType.Slice
    MainShadow.SliceCenter = Rect.new(49,49,450,450)
    MainShadow.ZIndex = -1

    -- Toggle visibility
    local UIVisible = true
    FloatBtn.MouseButton1Click:Connect(function()
        UIVisible = not UIVisible
        if UIVisible then
            Main.Visible = true
            Main.Size = UDim2.fromOffset(0,0)
            Tween(Main, {Size = UDim2.fromOffset(600, 360)}, 0.4, Enum.EasingStyle.Back)
        else
            local t = TweenService:Create(Main, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In), {Size = UDim2.fromOffset(0, 0)})
            t:Play()
            t.Completed:Wait()
            Main.Visible = false
        end
    end)


    
    local TopBar = Instance.new("Frame")
    TopBar.Parent = Main
    TopBar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TopBar.BackgroundTransparency = 0.9 -- Glass effect
    TopBar.Size = UDim2.new(1, 0, 0, 50)
    TopBar.ZIndex = 20
    
    local TBC = Instance.new("UICorner")
    TBC.CornerRadius = UDim.new(0, 12)
    TBC.Parent = TopBar
    
    local TBFiller = Instance.new("Frame")
    TBFiller.Parent = TopBar
    TBFiller.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TBFiller.BackgroundTransparency = 0.9
    TBFiller.BorderSizePixel = 0
    TBFiller.Position = UDim2.new(0,0,1,-10)
    TBFiller.Size = UDim2.new(1,0,0,10)
    TBFiller.ZIndex = 20

    -- Top border for glass effect
    local TopStroke = Instance.new("UIStroke")
    TopStroke.Parent = TopBar
    TopStroke.Color = Color3.fromRGB(255, 255, 255)
    TopStroke.Thickness = 0.5
    TopStroke.Transparency = 0.85
    TopStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

    -- Top shadow (softer for glass)
    local TopShadow = Instance.new("ImageLabel")
    TopShadow.Parent = TopBar
    TopShadow.Image = "rbxassetid://6015897843"
    TopShadow.ImageColor3 = Color3.new(0,0,0)
    TopShadow.ImageTransparency = 0.8
    TopShadow.BackgroundTransparency = 1
    TopShadow.Position = UDim2.new(0,0,1,0)
    TopShadow.Size = UDim2.new(1,0,0,20)
    TopShadow.ZIndex = 19

    -- Title
    local Title = Instance.new("TextLabel")
    Title.Parent = TopBar
    Title.BackgroundTransparency = 1
    Title.Position = UDim2.new(0, 20, 0, 0)
    Title.Size = UDim2.new(0, 200, 1, 0)
    Title.Text = WindowName
    Title.Font = Enum.Font.GothamBlack
    Title.TextColor3 = Colors.Accent
    Title.TextSize = 22
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.ZIndex = 21

    -- Close button
    local CloseBtn = Instance.new("TextButton")
    CloseBtn.Parent = TopBar
    CloseBtn.BackgroundTransparency = 1
    CloseBtn.Position = UDim2.new(1,-45,0,0)
    CloseBtn.Size = UDim2.new(0,45,1,0)
    CloseBtn.Text = "×"
    CloseBtn.Font = Enum.Font.GothamMedium
    CloseBtn.TextColor3 = Colors.TextGray
    CloseBtn.TextSize = 30
    CloseBtn.ZIndex = 21
    
    CloseBtn.MouseEnter:Connect(function()
        Tween(CloseBtn, {TextColor3 = Color3.fromRGB(255,80,80)}, 0.2)
    end)
    CloseBtn.MouseLeave:Connect(function()
        Tween(CloseBtn, {TextColor3 = Colors.TextGray}, 0.2)
    end)
    CloseBtn.MouseButton1Click:Connect(function()
        UIVisible = false
        Main.Visible = false
    end)


    
    local Sidebar = Instance.new("Frame")
    Sidebar.Parent = Main
    Sidebar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Sidebar.BackgroundTransparency = 0.92 -- Glass effect
    Sidebar.Position = UDim2.new(0,0,0,50)
    Sidebar.Size = UDim2.new(0,150,1,-50)
    Sidebar.ZIndex = 2
    
    local SBC = Instance.new("UICorner")
    SBC.CornerRadius = UDim.new(0,12)
    SBC.Parent = Sidebar
    
    local SFFiller = Instance.new("Frame")
    SFFiller.Parent = Sidebar
    SFFiller.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    SFFiller.BackgroundTransparency = 0.92
    SFFiller.BorderSizePixel = 0
    SFFiller.Size = UDim2.new(1,0,0,10)
    SFFiller.ZIndex = 2
    
    local SFFillerR = Instance.new("Frame")
    SFFillerR.Parent = Sidebar
    SFFillerR.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    SFFillerR.BackgroundTransparency = 0.92
    SFFillerR.BorderSizePixel = 0
    SFFillerR.Position = UDim2.new(1,-10,0,0)
    SFFillerR.Size = UDim2.new(0,10,1,0)
    SFFillerR.ZIndex = 2
    
    -- Sidebar glass border
    local SidebarStroke = Instance.new("UIStroke")
    SidebarStroke.Parent = Sidebar
    SidebarStroke.Color = Color3.fromRGB(255, 255, 255)
    SidebarStroke.Thickness = 0.5
    SidebarStroke.Transparency = 0.9
    SidebarStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

    local TabContainer = Instance.new("ScrollingFrame")
    TabContainer.Parent = Sidebar
    TabContainer.BackgroundTransparency = 1
    TabContainer.Position = UDim2.new(0,0,0,15)
    TabContainer.Size = UDim2.new(1,0,1,-15)
    TabContainer.ScrollBarThickness = 0
    TabContainer.ZIndex = 3
    
    local TabList = Instance.new("UIListLayout")
    TabList.Parent = TabContainer
    TabList.SortOrder = Enum.SortOrder.LayoutOrder
    TabList.Padding = UDim.new(0,5)


    
    local Content = Instance.new("Frame")
    Content.Parent = Main
    Content.BackgroundTransparency = 1
    Content.Position = UDim2.new(0,150,0,50)
    Content.Size = UDim2.new(1,-150,1,-50)
    Content.ClipsDescendants = true
    Content.ZIndex = 1
    
    local PagesFolder = Instance.new("Frame")
    PagesFolder.Parent = Content
    PagesFolder.BackgroundTransparency = 1
    PagesFolder.Position = UDim2.new(0,15,0,15)
    PagesFolder.Size = UDim2.new(1,-30,1,-30)
    PagesFolder.ZIndex = 1


    
    local dragging, dragInput, dragStart, startPos
    TopBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = Main.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    
    TopBar.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            Tween(Main, {
                Position = UDim2.new(
                    startPos.X.Scale, startPos.X.Offset + delta.X,
                    startPos.Y.Scale, startPos.Y.Offset + delta.Y
                )
            }, 0.05)
        end
    end)


    
    local Window = {}
    local Tabs = {}

    function Window:MakeTab(config)
        config = config or {}
        local TabName = config.Name or config.Title or "Tab"
        local TabIcon = config.Icon
        
        local TabBtn = Instance.new("TextButton")
        TabBtn.Parent = TabContainer
        TabBtn.BackgroundTransparency = 1
        TabBtn.Size = UDim2.new(1,0,0,35)
        TabBtn.Text = ""
        TabBtn.ZIndex = 3
        
        local TabBg = Instance.new("Frame")
        TabBg.Parent = TabBtn
        TabBg.BackgroundColor3 = Colors.Accent
        TabBg.BackgroundTransparency = 1
        TabBg.Size = UDim2.new(1,-20,1,0)
        TabBg.Position = UDim2.new(0,10,0,0)
        TabBg.ZIndex = 2
        
        local TbgC = Instance.new("UICorner")
        TbgC.CornerRadius = UDim.new(0,8)
        TbgC.Parent = TabBg
        
        local Indicator = Instance.new("Frame")
        Indicator.Parent = TabBtn
        Indicator.BackgroundColor3 = Colors.Accent
        Indicator.Position = UDim2.new(0,0,0.5,0)
        Indicator.AnchorPoint = Vector2.new(0,0.5)
        Indicator.Size = UDim2.new(0,0,0,0)
        Indicator.ZIndex = 4
        
        local ic = Instance.new("UICorner")
        ic.CornerRadius = UDim.new(0,4)
        ic.Parent = Indicator
        
        -- Icon support
        local iconOffset = 20
        if TabIcon then
            local Icon = CreateIcon(TabIcon, 16)
            if Icon then
                Icon.Parent = TabBtn
                Icon.Position = UDim2.new(0, 15, 0.5, -8)
                Icon.ImageColor3 = Colors.TextGray
                Icon.ZIndex = 5
                iconOffset = 40
                
                -- Store icon for color changes
                TabBtn:SetAttribute("Icon", Icon)
            end
        end
        
        local Label = Instance.new("TextLabel")
        Label.Parent = TabBtn
        Label.BackgroundTransparency = 1
        Label.Position = UDim2.new(0, iconOffset, 0, 0)
        Label.Size = UDim2.new(1, -iconOffset, 1, 0)
        Label.Text = TabName
        Label.Font = Enum.Font.GothamMedium
        Label.TextColor3 = Colors.TextGray
        Label.TextSize = 13
        Label.TextXAlignment = Enum.TextXAlignment.Left
        Label.ZIndex = 5

        local Page = Instance.new("ScrollingFrame")
        Page.Parent = PagesFolder
        Page.BackgroundTransparency = 1
        Page.Size = UDim2.new(1,0,1,0)
        Page.Visible = false
        Page.ScrollBarThickness = 0
        Page.AutomaticCanvasSize = Enum.AutomaticSize.Y
        Page.ZIndex = 3
        
        local PL = Instance.new("UIListLayout")
        PL.Parent = Page
        PL.SortOrder = Enum.SortOrder.LayoutOrder
        PL.Padding = UDim.new(0,8)

        TabBtn.MouseEnter:Connect(function()
            if Page.Visible then return end
            Tween(TabBg, {BackgroundTransparency=0.9}, 0.3)
            Tween(Label, {TextColor3=Colors.Text}, 0.3)
            local icon = TabBtn:GetAttribute("Icon")
            if icon then
                Tween(icon, {ImageColor3=Colors.Text}, 0.3)
            end
        end)
        
        TabBtn.MouseLeave:Connect(function()
            if Page.Visible then return end
            Tween(TabBg, {BackgroundTransparency=1}, 0.3)
            Tween(Label, {TextColor3=Colors.TextGray}, 0.3)
            local icon = TabBtn:GetAttribute("Icon")
            if icon then
                Tween(icon, {ImageColor3=Colors.TextGray}, 0.3)
            end
        end)
        
        TabBtn.MouseButton1Click:Connect(function()
            for _, t in pairs(Tabs) do
                t.Page.Visible = false
                Tween(t.Label, {TextColor3=Colors.TextGray}, 0.3)
                Tween(t.Indicator, {Size=UDim2.new(0,0,0,0)}, 0.3)
                Tween(t.Bg, {BackgroundTransparency=1}, 0.3)
                -- Reset icon color for other tabs
                local otherIcon = t.Btn:GetAttribute("Icon")
                if otherIcon then
                    Tween(otherIcon, {ImageColor3=Colors.TextGray}, 0.3)
                end
            end
            Page.Visible = true
            Tween(Label, {TextColor3=Colors.Accent}, 0.3)
            Tween(Indicator, {Size=UDim2.new(0,3,0.6,0)}, 0.4, Enum.EasingStyle.Back)
            Tween(TabBg, {BackgroundTransparency=0.95}, 0.3)
            -- Set active icon color
            local icon = TabBtn:GetAttribute("Icon")
            if icon then
                Tween(icon, {ImageColor3=Colors.Accent}, 0.3)
            end
        end)
        
        table.insert(Tabs, {
            Btn = TabBtn,
            Label = Label,
            Indicator = Indicator,
            Bg = TabBg,
            Page = Page
        })
        
        if #Tabs == 1 then
            Page.Visible = true
            Label.TextColor3 = Colors.Accent
            Indicator.Size = UDim2.new(0,3,0.6,0)
            TabBg.BackgroundTransparency = 0.95
            local icon = TabBtn:GetAttribute("Icon")
            if icon then
                icon.ImageColor3 = Colors.Accent
            end
        end
        
        return {
            Page = Page,
            Main = Main,
            CreateElements = function(self)
                return self
            end,
            
            AddLabel = function(self, config)
                config = config or {}
                local text = config.Title or config.Text or "Label"
                
                local L = Instance.new("TextLabel")
                L.Parent = self.Page
                L.BackgroundTransparency = 1
                L.Size = UDim2.new(1,0,0,30)
                L.Text = text
                L.Font = Enum.Font.GothamBold
                L.TextColor3 = Colors.Accent
                L.TextSize = 14
                L.ZIndex = 3
                
                return L
            end,
            
            AddButton = function(self, config)
                config = config or {}
                local text = config.Name or config.Title or "Button"
                local callback = config.Callback or function() end
                
                local Btn = Instance.new("TextButton")
                Btn.Parent = self.Page
                Btn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Btn.BackgroundTransparency = 0.9 -- Glass effect
                Btn.Size = UDim2.new(1,0,0,42)
                Btn.Text = text
                Btn.Font = Enum.Font.Gotham
                Btn.TextColor3 = Colors.Text
                Btn.TextSize = 13
                Btn.AutoButtonColor = false
                Btn.ZIndex = 3
                
                local c = Instance.new("UICorner")
                c.CornerRadius = UDim.new(0,8)
                c.Parent = Btn
                
                -- Glass border
                local BtnStroke = Instance.new("UIStroke")
                BtnStroke.Parent = Btn
                BtnStroke.Color = Color3.fromRGB(255, 255, 255)
                BtnStroke.Thickness = 0.5
                BtnStroke.Transparency = 0.85
                
                Btn.MouseEnter:Connect(function()
                    Tween(Btn, {BackgroundTransparency = 0.85}, 0.2)
                    Tween(BtnStroke, {Transparency = 0.7}, 0.2)
                end)
                Btn.MouseLeave:Connect(function()
                    Tween(Btn, {BackgroundTransparency = 0.9}, 0.2)
                    Tween(BtnStroke, {Transparency = 0.85}, 0.2)
                end)
                Btn.MouseButton1Down:Connect(function()
                    Tween(Btn, {Size = UDim2.new(1,-2,0,40)}, 0.1)
                end)
                Btn.MouseButton1Up:Connect(function()
                    Tween(Btn, {Size = UDim2.new(1,0,0,42)}, 0.1)
                end)
                Btn.MouseButton1Click:Connect(function()
                    pcall(callback)
                end)
                
                return {
                    Set = function(_, newText)
                        Btn.Text = newText
                    end
                }
            end,
            
            AddToggle = function(self, config)
                config = config or {}
                local text = config.Name or config.Title or "Toggle"
                local default = config.Default or false
                local callback = config.Callback or function() end
                
                local State = default
                local Btn = Instance.new("TextButton")
                Btn.Parent = self.Page
                Btn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Btn.BackgroundTransparency = 0.9 -- Glass effect
                Btn.Size = UDim2.new(1,0,0,42)
                Btn.Text = "   "..text
                Btn.Font = Enum.Font.Gotham
                Btn.TextColor3 = Colors.Text
                Btn.TextSize = 13
                Btn.TextXAlignment = Enum.TextXAlignment.Left
                Btn.AutoButtonColor = false
                Btn.ZIndex = 3
                
                local c = Instance.new("UICorner")
                c.CornerRadius = UDim.new(0,8)
                c.Parent = Btn
                
                -- Glass border
                local BtnStroke = Instance.new("UIStroke")
                BtnStroke.Parent = Btn
                BtnStroke.Color = Color3.fromRGB(255, 255, 255)
                BtnStroke.Thickness = 0.5
                BtnStroke.Transparency = 0.85
                
                local Sw = Instance.new("Frame")
                Sw.Parent = Btn
                Sw.BackgroundColor3 = State and Colors.Accent or Color3.fromRGB(50,50,50)
                Sw.BackgroundTransparency = State and 0 or 0.3
                Sw.Position = UDim2.new(1,-50,0.5,-10)
                Sw.Size = UDim2.new(0,36,0,20)
                Sw.ZIndex = 4
                
                local sc = Instance.new("UICorner")
                sc.CornerRadius = UDim.new(0,8)
                sc.Parent = Sw
                
                local Dot = Instance.new("Frame")
                Dot.Parent = Sw
                Dot.BackgroundColor3 = State and Colors.Text or Colors.TextGray
                Dot.Position = State and UDim2.new(1,-18,0.5,-8) or UDim2.new(0,2,0.5,-8)
                Dot.Size = UDim2.new(0,16,0,16)
                Dot.ZIndex = 5
                
                local dc = Instance.new("UICorner")
                dc.CornerRadius = UDim.new(1,0)
                dc.Parent = Dot

                Btn.MouseEnter:Connect(function()
                    Tween(Btn, {BackgroundTransparency = 0.85}, 0.2)
                    Tween(BtnStroke, {Transparency = 0.7}, 0.2)
                end)
                Btn.MouseLeave:Connect(function()
                    Tween(Btn, {BackgroundTransparency = 0.9}, 0.2)
                    Tween(BtnStroke, {Transparency = 0.85}, 0.2)
                end)
                Btn.MouseButton1Click:Connect(function()
                    State = not State
                    if State then
                        Tween(Sw, {BackgroundColor3 = Colors.Accent, BackgroundTransparency = 0}, 0.3)
                        Tween(Dot, {
                            Position = UDim2.new(1,-18,0.5,-8),
                            BackgroundColor3 = Colors.Text
                        }, 0.3, Enum.EasingStyle.Back)
                    else
                        Tween(Sw, {BackgroundColor3 = Color3.fromRGB(50,50,50), BackgroundTransparency = 0.3}, 0.3)
                        Tween(Dot, {
                            Position = UDim2.new(0,2,0.5,-8),
                            BackgroundColor3 = Colors.TextGray
                        }, 0.3, Enum.EasingStyle.Back)
                    end
                    pcall(callback, State)
                end)
                
                if default then
                    pcall(callback, State)
                end
                
                return {
                    Set = function(_, value)
                        State = value
                        if value then
                            Tween(Sw, {BackgroundColor3 = Colors.Accent}, 0.3)
                            Tween(Dot, {
                                Position = UDim2.new(1,-18,0.5,-8),
                                BackgroundColor3 = Colors.Text
                            }, 0.3, Enum.EasingStyle.Back)
                        else
                            Tween(Sw, {BackgroundColor3 = Color3.fromRGB(50,50,50)}, 0.3)
                            Tween(Dot, {
                                Position = UDim2.new(0,2,0.5,-8),
                                BackgroundColor3 = Colors.TextGray
                            }, 0.3, Enum.EasingStyle.Back)
                        end
                        pcall(callback, State)
                    end
                }
            end,
            
            AddSlider = function(self, config)
                config = config or {}
                local text = config.Name or config.Title or "Slider"
                local min = config.Min or 0
                local max = config.Max or 100
                local default = config.Default or min
                local callback = config.Callback or function() end
                
                local F = Instance.new("Frame")
                F.Parent = self.Page
                F.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                F.BackgroundTransparency = 0.9 -- Glass effect
                F.Size = UDim2.new(1,0,0,60)
                F.ZIndex = 3
                
                local c = Instance.new("UICorner")
                c.CornerRadius = UDim.new(0,8)
                c.Parent = F
                
                -- Glass border
                local FStroke = Instance.new("UIStroke")
                FStroke.Parent = F
                FStroke.Color = Color3.fromRGB(255, 255, 255)
                FStroke.Thickness = 0.5
                FStroke.Transparency = 0.85
                
                local L = Instance.new("TextLabel")
                L.Parent = F
                L.BackgroundTransparency = 1
                L.Position = UDim2.new(0,12,0,5)
                L.Size = UDim2.new(1,-24,0,20)
                L.Text = text
                L.Font = Enum.Font.GothamMedium
                L.TextColor3 = Colors.Text
                L.TextSize = 13
                L.TextXAlignment = Enum.TextXAlignment.Left
                L.ZIndex = 4
                
                local V = Instance.new("TextLabel")
                V.Parent = F
                V.BackgroundTransparency = 1
                V.Position = UDim2.new(0,12,0,5)
                V.Size = UDim2.new(1,-24,0,20)
                V.Text = tostring(default)
                V.Font = Enum.Font.GothamBold
                V.TextColor3 = Colors.Accent
                V.TextSize = 13
                V.TextXAlignment = Enum.TextXAlignment.Right
                V.ZIndex = 4
                
                local Hitbox = Instance.new("TextButton")
                Hitbox.Parent = F
                Hitbox.BackgroundTransparency = 1
                Hitbox.Size = UDim2.new(1,0,1,0)
                Hitbox.Text = ""
                Hitbox.ZIndex = 5
                
                local BarBg = Instance.new("Frame")
                BarBg.Parent = F
                BarBg.BackgroundColor3 = Color3.fromRGB(50,50,50)
                BarBg.Position = UDim2.new(0,12,0,40)
                BarBg.Size = UDim2.new(1,-24,0,6)
                BarBg.ZIndex = 4
                
                local bc = Instance.new("UICorner")
                bc.CornerRadius = UDim.new(1,0)
                bc.Parent = BarBg
                
                local BarFill = Instance.new("Frame")
                BarFill.Parent = BarBg
                BarFill.BackgroundColor3 = Colors.Accent
                BarFill.Size = UDim2.new(0,0,1,0)
                BarFill.ZIndex = 4
                
                local bfc = Instance.new("UICorner")
                bfc.CornerRadius = UDim.new(1,0)
                bfc.Parent = BarFill
                
                local Knob = Instance.new("Frame")
                Knob.Parent = BarFill
                Knob.BackgroundColor3 = Colors.Text
                Knob.Position = UDim2.new(1,-9,0.5,-9)
                Knob.Size = UDim2.new(0,18,0,18)
                Knob.ZIndex = 4
                
                local kc = Instance.new("UICorner")
                kc.CornerRadius = UDim.new(1,0)
                kc.Parent = Knob

                Hitbox.MouseEnter:Connect(function()
                    Tween(Knob, {Size = UDim2.new(0,22,0,22)}, 0.2)
                end)
                Hitbox.MouseLeave:Connect(function()
                    Tween(Knob, {Size = UDim2.new(0,18,0,18)}, 0.2)
                end)
                
                local function Update(input)
                    local Percent = math.clamp((input.Position.X - BarBg.AbsolutePosition.X) / BarBg.AbsoluteSize.X, 0, 1)
                    local Val = math.floor(min + (max - min) * Percent)
                    V.Text = tostring(Val)
                    Tween(BarFill, {Size = UDim2.new(Percent, 0, 1, 0)}, 0.05)
                    pcall(callback, Val)
                end
                
                Hitbox.MouseButton1Down:Connect(function()
                    Update({Position = UserInputService:GetMouseLocation()})
                    local moveCn, endCn
                    moveCn = UserInputService.InputChanged:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.MouseMovement then
                            Update(input)
                        end
                    end)
                    endCn = UserInputService.InputEnded:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.MouseButton1 then
                            moveCn:Disconnect()
                            endCn:Disconnect()
                        end
                    end)
                end)
                
                local P = math.clamp((default - min) / (max - min), 0, 1)
                BarFill.Size = UDim2.new(P, 0, 1, 0)
                
                return {
                    Set = function(_, value)
                        local Val = math.clamp(value, min, max)
                        V.Text = tostring(Val)
                        local Percent = (Val - min) / (max - min)
                        Tween(BarFill, {Size = UDim2.new(Percent, 0, 1, 0)}, 0.3)
                        pcall(callback, Val)
                    end
                }
            end,
            
            AddTextbox = function(self, config)
                config = config or {}
                local text = config.Name or config.Title or "Input"
                local placeholder = config.Default or config.Placeholder or "..."
                local callback = config.Callback or function() end
                
                local F = Instance.new("Frame")
                F.Parent = self.Page
                F.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                F.BackgroundTransparency = 0.9 -- Glass effect
                F.Size = UDim2.new(1,0,0,45)
                F.ZIndex = 3
                
                local c = Instance.new("UICorner")
                c.CornerRadius = UDim.new(0,8)
                c.Parent = F
                
                -- Glass border
                local FStroke = Instance.new("UIStroke")
                FStroke.Parent = F
                FStroke.Color = Color3.fromRGB(255, 255, 255)
                FStroke.Thickness = 0.5
                FStroke.Transparency = 0.85
                
                local L = Instance.new("TextLabel")
                L.Parent = F
                L.BackgroundTransparency = 1
                L.Position = UDim2.new(0,12,0,0)
                L.Size = UDim2.new(0,100,1,0)
                L.Text = text
                L.Font = Enum.Font.GothamMedium
                L.TextColor3 = Colors.Text
                L.TextSize = 13
                L.TextXAlignment = Enum.TextXAlignment.Left
                L.ZIndex = 4
                
                local BoxCon = Instance.new("Frame")
                BoxCon.Parent = F
                BoxCon.BackgroundColor3 = Colors.InputBox
                BoxCon.BackgroundTransparency = 0
                BoxCon.Position = UDim2.new(1,-160,0.5,-15)
                BoxCon.Size = UDim2.new(0,150,0,30)
                BoxCon.ZIndex = 4
                
                local bc = Instance.new("UICorner")
                bc.CornerRadius = UDim.new(0,6)
                bc.Parent = BoxCon
                
                local TB = Instance.new("TextBox")
                TB.Parent = BoxCon
                TB.BackgroundTransparency = 1
                TB.Position = UDim2.new(0,8,0,0)
                TB.Size = UDim2.new(1,-16,1,0)
                TB.ZIndex = 5
                TB.Font = Enum.Font.Gotham
                TB.PlaceholderText = placeholder
                TB.Text = ""
                TB.TextColor3 = Colors.Text
                TB.PlaceholderColor3 = Colors.TextGray
                TB.TextSize = 13
                TB.TextXAlignment = Enum.TextXAlignment.Left
                TB.ClearTextOnFocus = false
                
                TB.Focused:Connect(function()
                    Tween(BoxCon, {BackgroundColor3 = Color3.fromRGB(20,20,20)}, 0.3)
                end)
                TB.FocusLost:Connect(function()
                    Tween(BoxCon, {BackgroundColor3 = Colors.InputBox}, 0.3)
                    pcall(callback, TB.Text)
                end)
                
                return {
                    Set = function(_, value)
                        TB.Text = tostring(value)
                    end
                }
            end,
            
            AddDropdown = function(self, config)
                config = config or {}
                local text = config.Name or config.Title or "Dropdown"
                local options = config.Options or {}
                local multi = config.Multi or config.MultiSelection or false
                local callback = config.Callback or function() end
                
                local IsOpen = false
                local Selected = multi and {} or nil
                
                local F = Instance.new("Frame")
                F.Parent = self.Page
                F.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                F.BackgroundTransparency = 0.9 -- Glass effect
                F.Size = UDim2.new(1,0,0,42)
                F.ZIndex = 3
                F.ClipsDescendants = true
                
                local c = Instance.new("UICorner")
                c.CornerRadius = UDim.new(0,8)
                c.Parent = F
                
                -- Glass border
                local FStroke = Instance.new("UIStroke")
                FStroke.Parent = F
                FStroke.Color = Color3.fromRGB(255, 255, 255)
                FStroke.Thickness = 0.5
                FStroke.Transparency = 0.85

                local L = Instance.new("TextLabel")
                L.Parent = F
                L.BackgroundTransparency = 1
                L.Position = UDim2.new(0,12,0,0)
                L.Size = UDim2.new(0,150,0,42)
                L.Text = text
                L.Font = Enum.Font.GothamMedium
                L.TextColor3 = Colors.Text
                L.TextSize = 13
                L.TextXAlignment = Enum.TextXAlignment.Left
                L.ZIndex = 4
                
                local S = Instance.new("TextLabel")
                S.Parent = F
                S.BackgroundTransparency = 1
                S.Position = UDim2.new(0,12,0,0)
                S.Size = UDim2.new(1,-40,0,42)
                S.Text = "..."
                S.Font = Enum.Font.Gotham
                S.TextColor3 = Colors.TextGray
                S.TextSize = 12
                S.TextXAlignment = Enum.TextXAlignment.Right
                S.ZIndex = 4
                
                local I = Instance.new("TextLabel")
                I.Parent = F
                I.BackgroundTransparency = 1
                I.Position = UDim2.new(1,-30,0,0)
                I.Size = UDim2.new(0,30,0,42)
                I.Text = "▼"
                I.TextColor3 = Colors.TextGray
                I.TextSize = 12
                I.ZIndex = 4
                
                local Btn = Instance.new("TextButton")
                Btn.Parent = F
                Btn.BackgroundTransparency = 1
                Btn.Size = UDim2.new(1,0,0,42)
                Btn.Text = ""
                Btn.ZIndex = 5

                local List = Instance.new("ScrollingFrame")
                List.Parent = F
                List.BackgroundTransparency = 1
                List.Position = UDim2.new(0,0,0,45)
                List.Size = UDim2.new(1,0,0,100)
                List.ZIndex = 5
                List.ScrollBarThickness = 2
                List.AutomaticCanvasSize = Enum.AutomaticSize.Y
                List.CanvasSize = UDim2.new(0,0,0,0)
                
                local LL = Instance.new("UIListLayout")
                LL.Parent = List
                LL.SortOrder = Enum.SortOrder.LayoutOrder
                LL.Padding = UDim.new(0,2)

                local function Refresh()
                    if multi then
                        local c = 0
                        for k,v in pairs(Selected) do c=c+1 end
                        S.Text = c>0 and tostring(c).." Selected" or "None"
                    else
                        S.Text = Selected or "None"
                    end
                end

                for _, opt in ipairs(options) do
                    local B = Instance.new("TextButton")
                    B.Parent = List
                    B.BackgroundColor3 = Colors.Dropdown
                    B.BackgroundTransparency = 0.2
                    B.Size = UDim2.new(1,-10,0,30)
                    B.Text = "   "..opt
                    B.Font = Enum.Font.Gotham
                    B.TextColor3 = Colors.TextGray
                    B.TextSize = 12
                    B.TextXAlignment = Enum.TextXAlignment.Left
                    B.AutoButtonColor = false
                    B.ZIndex = 6
                    
                    local ic = Instance.new("UICorner")
                    ic.CornerRadius = UDim.new(0,6)
                    ic.Parent = B
                    
                    B.MouseButton1Click:Connect(function()
                        if multi then
                            if Selected[opt] then
                                Selected[opt]=nil
                                Tween(B, {TextColor3=Colors.TextGray}, 0.2)
                            else
                                Selected[opt]=true
                                Tween(B, {TextColor3=Colors.Accent}, 0.2)
                            end
                            Refresh()
                            pcall(callback, Selected)
                        else
                            Selected=opt
                            Refresh()
                            IsOpen=false
                            Tween(F, {Size=UDim2.new(1,0,0,42)}, 0.3)
                            for _,x in pairs(List:GetChildren()) do
                                if x:IsA("TextButton") then
                                    Tween(x, {TextColor3=Colors.TextGray}, 0.2)
                                end
                            end
                            Tween(B, {TextColor3=Colors.Accent}, 0.2)
                            pcall(callback, opt)
                        end
                    end)
                end

                Btn.MouseButton1Click:Connect(function()
                    IsOpen = not IsOpen
                    if IsOpen then
                        Tween(F, {Size=UDim2.new(1,0,0,150)}, 0.3)
                    else
                        Tween(F, {Size=UDim2.new(1,0,0,42)}, 0.3)
                    end
                end)
                
                return {
                    Set = function(_, value)
                        if multi then
                            Selected = {}
                            for _, opt in ipairs(options) do
                                if table.find(value, opt) then
                                    Selected[opt] = true
                                end
                            end
                        else
                            Selected = value
                        end
                        Refresh()
                    end,
                    Add = function(_, option)
                        table.insert(options, option)
                        -- Recreate dropdown items
                    end,
                    Remove = function(_, option)
                        for i, v in ipairs(options) do
                            if v == option then
                                table.remove(options, i)
                                break
                            end
                        end
                    end
                }
            end,
            
            AddParagraph = function(self, config)
                config = config or {}
                local title = config.Title or "Paragraph"
                local content = config.Content or "Content"
                
                local F = Instance.new("Frame")
                F.Parent = self.Page
                F.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                F.BackgroundTransparency = 0.9 -- Glass effect
                F.Size = UDim2.new(1,0,0,70)
                F.ZIndex = 3
                
                local c = Instance.new("UICorner")
                c.CornerRadius = UDim.new(0,8)
                c.Parent = F
                
                -- Glass border
                local FStroke = Instance.new("UIStroke")
                FStroke.Parent = F
                FStroke.Color = Color3.fromRGB(255, 255, 255)
                FStroke.Thickness = 0.5
                FStroke.Transparency = 0.85
                
                local Title = Instance.new("TextLabel")
                Title.Parent = F
                Title.BackgroundTransparency = 1
                Title.Position = UDim2.new(0,12,0,8)
                Title.Size = UDim2.new(1,-24,0,20)
                Title.Text = title
                Title.Font = Enum.Font.GothamBold
                Title.TextColor3 = Colors.Accent
                Title.TextSize = 14
                Title.TextXAlignment = Enum.TextXAlignment.Left
                Title.ZIndex = 4
                
                local Content = Instance.new("TextLabel")
                Content.Parent = F
                Content.BackgroundTransparency = 1
                Content.Position = UDim2.new(0,12,0,30)
                Content.Size = UDim2.new(1,-24,0,32)
                Content.Text = content
                Content.Font = Enum.Font.Gotham
                Content.TextColor3 = Colors.TextGray
                Content.TextSize = 12
                Content.TextXAlignment = Enum.TextXAlignment.Left
                Content.TextYAlignment = Enum.TextYAlignment.Top
                Content.TextWrapped = true
                Content.ZIndex = 4
                
                return {
                    Set = function(_, newTitle, newContent)
                        Title.Text = newTitle or title
                        Content.Text = newContent or content
                    end
                }
            end
        }
    end

    return Window
end

return Library
