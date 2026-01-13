--[[
	User Interface Library
	Made by Late
]]

--// Connections
local GetService = game.GetService
local Connect = game.Loaded.Connect
local Wait = game.Loaded.Wait
local Clone = game.Clone 
local Destroy = game.Destroy 

if (not game:IsLoaded()) then
	local Loaded = game.Loaded
	Loaded.Wait(Loaded);
end

--// Important 
local Setup = {
	Keybind = Enum.KeyCode.LeftControl,
	Transparency = 0.2,
	ThemeMode = "Dark",
	Size = nil,
}

local Theme = { --// (Dark Theme)
	--// Frames:
	Primary = Color3.fromRGB(30, 30, 30),
	Secondary = Color3.fromRGB(35, 35, 35),
	Component = Color3.fromRGB(40, 40, 40),
	Interactables = Color3.fromRGB(45, 45, 45),

	--// Text:
	Tab = Color3.fromRGB(200, 200, 200),
	Title = Color3.fromRGB(240,240,240),
	Description = Color3.fromRGB(200,200,200),

	--// Outlines:
	Shadow = Color3.fromRGB(0, 0, 0),
	Outline = Color3.fromRGB(40, 40, 40),

	--// Image:
	Icon = Color3.fromRGB(220, 220, 220),
}

--// Lucide Icons System
local LucideIcons = {
	-- Common icons mapping to Roblox asset IDs
	-- You can add more icons here or load from external source
	["home"] = "rbxassetid://11293977610",
	["settings"] = "rbxassetid://11293977610",
	["user"] = "rbxassetid://11419706819",
	["search"] = "rbxassetid://11419703492",
	["menu"] = "rbxassetid://11419701606",
	["x"] = "rbxassetid://11419704569",
	["check"] = "rbxassetid://11419699908",
	["chevron-down"] = "rbxassetid://11419700048",
	["chevron-up"] = "rbxassetid://11419700195",
	["chevron-left"] = "rbxassetid://11419700108",
	["chevron-right"] = "rbxassetid://11419700153",
	["plus"] = "rbxassetid://11419702668",
	["minus"] = "rbxassetid://11419701769",
	["edit"] = "rbxassetid://11419700434",
	["trash"] = "rbxassetid://11419704239",
	["save"] = "rbxassetid://11419703298",
	["download"] = "rbxassetid://11419700304",
	["upload"] = "rbxassetid://11419704427",
	["refresh"] = "rbxassetid://11419702932",
	["power"] = "rbxassetid://11419702605",
	["bell"] = "rbxassetid://11419699634",
	["star"] = "rbxassetid://11419703869",
	["heart"] = "rbxassetid://11419701308",
	["folder"] = "rbxassetid://11419700868",
	["file"] = "rbxassetid://11419700611",
	["copy"] = "rbxassetid://11419700006",
	["clipboard"] = "rbxassetid://11419699949",
	["link"] = "rbxassetid://11419701514",
	["external-link"] = "rbxassetid://11419700489",
	["eye"] = "rbxassetid://11419700547",
	["eye-off"] = "rbxassetid://11419700513",
	["lock"] = "rbxassetid://11419701546",
	["unlock"] = "rbxassetid://11419704350",
	["key"] = "rbxassetid://11419701425",
	["shield"] = "rbxassetid://11419703554",
	["alert-circle"] = "rbxassetid://11419699529",
	["alert-triangle"] = "rbxassetid://11419699575",
	["info"] = "rbxassetid://11419701371",
	["help-circle"] = "rbxassetid://11419701346",
	["zap"] = "rbxassetid://11419704688",
	["activity"] = "rbxassetid://11419699435",
	["target"] = "rbxassetid://11419704049",
	["crosshair"] = "rbxassetid://11419700048",
	["compass"] = "rbxassetid://11419699976",
	["map"] = "rbxassetid://11419701657",
	["map-pin"] = "rbxassetid://11419701631",
	["navigation"] = "rbxassetid://11419702225",
	["sun"] = "rbxassetid://11419703957",
	["moon"] = "rbxassetid://11419701960",
	["cloud"] = "rbxassetid://11419699964",
	["droplet"] = "rbxassetid://11419700382",
	["thermometer"] = "rbxassetid://11419704130",
	["wind"] = "rbxassetid://11419704526",
	["umbrella"] = "rbxassetid://11419704303",
	["fish"] = "rbxassetid://11419700802",
	["gamepad"] = "rbxassetid://11419700994",
	["gamepad-2"] = "rbxassetid://11419700954",
	["play"] = "rbxassetid://11419702478",
	["pause"] = "rbxassetid://11419702413",
	["stop"] = "rbxassetid://11419703814",
	["skip-forward"] = "rbxassetid://11419703656",
	["skip-back"] = "rbxassetid://11419703607",
	["volume"] = "rbxassetid://11419704482",
	["volume-2"] = "rbxassetid://11419704460",
	["volume-x"] = "rbxassetid://11419704504",
	["mic"] = "rbxassetid://11419701723",
	["mic-off"] = "rbxassetid://11419701695",
	["camera"] = "rbxassetid://11419699786",
	["image"] = "rbxassetid://11419701397",
	["video"] = "rbxassetid://11419704438",
	["phone"] = "rbxassetid://11419702447",
	["mail"] = "rbxassetid://11419701584",
	["message-circle"] = "rbxassetid://11419701677",
	["message-square"] = "rbxassetid://11419701709",
	["send"] = "rbxassetid://11419703378",
	["share"] = "rbxassetid://11419703457",
	["share-2"] = "rbxassetid://11419703419",
	["users"] = "rbxassetid://11419704393",
	["user-plus"] = "rbxassetid://11419704371",
	["user-minus"] = "rbxassetid://11419704349",
	["user-x"] = "rbxassetid://11419704416",
	["user-check"] = "rbxassetid://11419700783",
	["award"] = "rbxassetid://11419699619",
	["gift"] = "rbxassetid://11419701041",
	["package"] = "rbxassetid://11419702318",
	["shopping-cart"] = "rbxassetid://11419703580",
	["credit-card"] = "rbxassetid://11419700022",
	["dollar-sign"] = "rbxassetid://11419700358",
	["trending-up"] = "rbxassetid://11419704196",
	["trending-down"] = "rbxassetid://11419704166",
	["bar-chart"] = "rbxassetid://11419699658",
	["pie-chart"] = "rbxassetid://11419702513",
	["layers"] = "rbxassetid://11419701483",
	["grid"] = "rbxassetid://11419701150",
	["list"] = "rbxassetid://11419701533",
	["layout"] = "rbxassetid://11419701457",
	["sidebar"] = "rbxassetid://11419703631",
	["terminal"] = "rbxassetid://11419704089",
	["code"] = "rbxassetid://11419699967",
	["database"] = "rbxassetid://11419700142",
	["server"] = "rbxassetid://11419703508",
	["cpu"] = "rbxassetid://11419700034",
	["hard-drive"] = "rbxassetid://11419701256",
	["wifi"] = "rbxassetid://11419704502",
	["wifi-off"] = "rbxassetid://11419704478",
	["bluetooth"] = "rbxassetid://11419699746",
	["cast"] = "rbxassetid://11419699856",
	["monitor"] = "rbxassetid://11419701907",
	["smartphone"] = "rbxassetid://11419703723",
	["tablet"] = "rbxassetid://11419704009",
	["watch"] = "rbxassetid://11419704458",
	["tv"] = "rbxassetid://11419704260",
	["speaker"] = "rbxassetid://11419703775",
	["headphones"] = "rbxassetid://11419701282",
	["radio"] = "rbxassetid://11419702820",
	["printer"] = "rbxassetid://11419702730",
	["mouse"] = "rbxassetid://11419702017",
	["keyboard"] = "rbxassetid://11419701447",
	["command"] = "rbxassetid://11419699964",
	["toggle-left"] = "rbxassetid://11419704144",
	["toggle-right"] = "rbxassetid://11419704162",
	["sliders"] = "rbxassetid://11419703700",
	["filter"] = "rbxassetid://11419700757",
	["hash"] = "rbxassetid://11419701300",
	["at-sign"] = "rbxassetid://11419699606",
	["percent"] = "rbxassetid://11419702435",
	["type"] = "rbxassetid://11419704278",
	["bold"] = "rbxassetid://11419699762",
	["italic"] = "rbxassetid://11419701409",
	["underline"] = "rbxassetid://11419704327",
	["align-left"] = "rbxassetid://11419699553",
	["align-center"] = "rbxassetid://11419699538",
	["align-right"] = "rbxassetid://11419699567",
	["clock"] = "rbxassetid://11419699954",
	["calendar"] = "rbxassetid://11419699770",
	["timer"] = "rbxassetid://11419704144",
	["hourglass"] = "rbxassetid://11419701358",
	["rotate-cw"] = "rbxassetid://11419703186",
	["rotate-ccw"] = "rbxassetid://11419703148",
	["move"] = "rbxassetid://11419702046",
	["maximize"] = "rbxassetid://11419701671",
	["minimize"] = "rbxassetid://11419701781",
	["maximize-2"] = "rbxassetid://11419701648",
	["minimize-2"] = "rbxassetid://11419701757",
	["zoom-in"] = "rbxassetid://11419704729",
	["zoom-out"] = "rbxassetid://11419704770",
	["crop"] = "rbxassetid://11419700055",
	["scissors"] = "rbxassetid://11419703338",
	["anchor"] = "rbxassetid://11419699589",
	["paperclip"] = "rbxassetid://11419702365",
	["flag"] = "rbxassetid://11419700823",
	["bookmark"] = "rbxassetid://11419699777",
	["tag"] = "rbxassetid://11419703993",
}

-- Function to get Lucide icon asset ID
local function GetLucideIcon(iconName)
	if not iconName then return nil end
	
	-- If it's already an asset ID, return as-is
	if type(iconName) == "string" and iconName:match("^rbxassetid://") then
		return iconName
	end
	
	-- Look up in the icons table (case-insensitive)
	local lowerName = string.lower(iconName)
	return LucideIcons[lowerName] or LucideIcons[iconName]
end

-- Function to add custom Lucide icons
local function AddLucideIcon(name, assetId)
	LucideIcons[string.lower(name)] = assetId
end

-- Function to add multiple Lucide icons at once
local function AddLucideIcons(iconsTable)
	for name, assetId in pairs(iconsTable) do
		LucideIcons[string.lower(name)] = assetId
	end
end

--// Services & Functions
local Type, Blur = nil
local LocalPlayer = GetService(game, "Players").LocalPlayer;
local Services = {
	Insert = GetService(game, "InsertService");
	Tween = GetService(game, "TweenService");
	Run = GetService(game, "RunService");
	Input = GetService(game, "UserInputService");
}

local Player = {
	Mouse = LocalPlayer:GetMouse();
	GUI = LocalPlayer.PlayerGui;
}

local Tween = function(Object : Instance, Speed : number, Properties : {},  Info : { EasingStyle: Enum?, EasingDirection: Enum? })
	local Style, Direction

	if Info then
		Style, Direction = Info["EasingStyle"], Info["EasingDirection"]
	else
		Style, Direction = Enum.EasingStyle.Sine, Enum.EasingDirection.Out
	end

	return Services.Tween:Create(Object, TweenInfo.new(Speed, Style, Direction), Properties):Play()
end

local SetProperty = function(Object: Instance, Properties: {})
	for Index, Property in next, Properties do
		Object[Index] = (Property);
	end

	return Object
end

local Multiply = function(Value, Amount)
	local New = {
		Value.X.Scale * Amount;
		Value.X.Offset * Amount;
		Value.Y.Scale * Amount;
		Value.Y.Offset * Amount;
	}

	return UDim2.new(unpack(New))
end

local Color = function(Color, Factor, Mode)
	Mode = Mode or Setup.ThemeMode

	if Mode == "Light" then
		return Color3.fromRGB((Color.R * 255) - Factor, (Color.G * 255) - Factor, (Color.B * 255) - Factor)
	else
		return Color3.fromRGB((Color.R * 255) + Factor, (Color.G * 255) + Factor, (Color.B * 255) + Factor)
	end
end

local Drag = function(Canvas)
	if Canvas then
		local Dragging;
		local DragInput;
		local Start;
		local StartPosition;

		local function Update(input)
			local delta = input.Position - Start
			Canvas.Position = UDim2.new(StartPosition.X.Scale, StartPosition.X.Offset + delta.X, StartPosition.Y.Scale, StartPosition.Y.Offset + delta.Y)
		end

		Connect(Canvas.InputBegan, function(Input)
			if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch and not Type then
				Dragging = true
				Start = Input.Position
				StartPosition = Canvas.Position

				Connect(Input.Changed, function()
					if Input.UserInputState == Enum.UserInputState.End then
						Dragging = false
					end
				end)
			end
		end)

		Connect(Canvas.InputChanged, function(Input)
			if Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch and not Type then
				DragInput = Input
			end
		end)

		Connect(Services.Input.InputChanged, function(Input)
			if Input == DragInput and Dragging and not Type then
				Update(Input)
			end
		end)
	end
end

Resizing = { 
	TopLeft = { X = Vector2.new(-1, 0),   Y = Vector2.new(0, -1)};
	TopRight = { X = Vector2.new(1, 0),    Y = Vector2.new(0, -1)};
	BottomLeft = { X = Vector2.new(-1, 0),   Y = Vector2.new(0, 1)};
	BottomRight = { X = Vector2.new(1, 0),    Y = Vector2.new(0, 1)};
}

Resizeable = function(Tab, Minimum, Maximum)
	task.spawn(function()
		local MousePos, Size, UIPos = nil, nil, nil

		if Tab and Tab:FindFirstChild("Resize") then
			local Positions = Tab:FindFirstChild("Resize")

			for Index, Types in next, Positions:GetChildren() do
				Connect(Types.InputBegan, function(Input)
					if Input.UserInputType == Enum.UserInputType.MouseButton1 then
						Type = Types
						MousePos = Vector2.new(Player.Mouse.X, Player.Mouse.Y)
						Size = Tab.AbsoluteSize
						UIPos = Tab.Position
					end
				end)

				Connect(Types.InputEnded, function(Input)
					if Input.UserInputType == Enum.UserInputType.MouseButton1 then
						Type = nil
					end
				end)
			end
		end

		local Resize = function(Delta)
			if Type and MousePos and Size and UIPos and Tab:FindFirstChild("Resize")[Type.Name] == Type then
				local Mode = Resizing[Type.Name]
				local NewSize = Vector2.new(Size.X + Delta.X * Mode.X.X, Size.Y + Delta.Y * Mode.Y.Y)
				NewSize = Vector2.new(math.clamp(NewSize.X, Minimum.X, Maximum.X), math.clamp(NewSize.Y, Minimum.Y, Maximum.Y))

				local AnchorOffset = Vector2.new(Tab.AnchorPoint.X * Size.X, Tab.AnchorPoint.Y * Size.Y)
				local NewAnchorOffset = Vector2.new(Tab.AnchorPoint.X * NewSize.X, Tab.AnchorPoint.Y * NewSize.Y)
				local DeltaAnchorOffset = NewAnchorOffset - AnchorOffset

				Tab.Size = UDim2.new(0, NewSize.X, 0, NewSize.Y)

				local NewPosition = UDim2.new(
					UIPos.X.Scale, 
					UIPos.X.Offset + DeltaAnchorOffset.X * Mode.X.X,
					UIPos.Y.Scale,
					UIPos.Y.Offset + DeltaAnchorOffset.Y * Mode.Y.Y
				)
				Tab.Position = NewPosition
			end
		end

		Connect(Player.Mouse.Move, function()
			if Type then
				Resize(Vector2.new(Player.Mouse.X, Player.Mouse.Y) - MousePos)
			end
		end)
	end)
end

--// Setup [UI]
if (identifyexecutor) then
	Screen = Services.Insert:LoadLocalAsset("rbxassetid://18490507748");
	Blur = loadstring(game:HttpGet("https://raw.githubusercontent.com/lxte/lates-lib/main/Assets/Blur.lua"))();
else
	Screen = (script.Parent);
	Blur = require(script.Blur)
end

Screen.Main.Visible = false

xpcall(function()
	Screen.Parent = game.CoreGui
end, function() 
	Screen.Parent = Player.GUI
end)

--// Tables for Data
local Animations = {}
local Blurs = {}
local Components = (Screen:FindFirstChild("Components"));
local Library = {};
local StoredInfo = {
	["Sections"] = {};
	["Tabs"] = {}
};

--// Animations [Window]
function Animations:Open(Window: CanvasGroup, Transparency: number, UseCurrentSize: boolean)
	local Original = (UseCurrentSize and Window.Size) or Setup.Size
	local Multiplied = Multiply(Original, 1.1)
	local Shadow = Window:FindFirstChildOfClass("UIStroke")


	SetProperty(Shadow, { Transparency = 1 })
	SetProperty(Window, {
		Size = Multiplied,
		GroupTransparency = 1,
		Visible = true,
	})

	Tween(Shadow, .25, { Transparency = 0.5 })
	Tween(Window, .25, {
		Size = Original,
		GroupTransparency = Transparency or 0,
	})
end

function Animations:Close(Window: CanvasGroup)
	local Original = Window.Size
	local Multiplied = Multiply(Original, 1.1)
	local Shadow = Window:FindFirstChildOfClass("UIStroke")

	SetProperty(Window, {
		Size = Original,
	})

	Tween(Shadow, .25, { Transparency = 1 })
	Tween(Window, .25, {
		Size = Multiplied,
		GroupTransparency = 1,
	})

	task.wait(.25)
	Window.Size = Original
	Window.Visible = false
end


function Animations:Component(Component: any, Custom: boolean)	
	Connect(Component.InputBegan, function() 
		if Custom then
			Tween(Component, .25, { Transparency = .85 });
		else
			Tween(Component, .25, { BackgroundColor3 = Color(Theme.Component, 5, Setup.ThemeMode) });
		end
	end)

	Connect(Component.InputEnded, function() 
		if Custom then
			Tween(Component, .25, { Transparency = 1 });
		else
			Tween(Component, .25, { BackgroundColor3 = Theme.Component });
		end
	end)
end

--// Library [Window]

function Library:CreateWindow(Settings: { Title: string, Size: UDim2, Transparency: number, MinimizeKeybind: Enum.KeyCode?, Blurring: boolean, Theme: string, FloatingIcon: { Enabled: boolean?, Icon: string?, Size: number?, Position: UDim2? }?, Navbar: { Enabled: boolean?, Title: string?, Icon: string?, Author: string? }? })
	local Window = Clone(Screen:WaitForChild("Main"));
	local Sidebar = Window:FindFirstChild("Sidebar");
	local Holder = Window:FindFirstChild("Main");
	local BG = Window:FindFirstChild("BackgroundShadow");
	local Tab = Sidebar:FindFirstChild("Tab");

	local Options = {};
	local Examples = {};
	local Opened = true;
	local Maximized = false;
	local BlurEnabled = false
	local FloatingBtn = nil

	for Index, Example in next, Window:GetDescendants() do
		if Example.Name:find("Example") and not Examples[Example.Name] then
			Examples[Example.Name] = Example
		end
	end

	--// UI Blur & More
	Drag(Window);
	Resizeable(Window, Vector2.new(411, 271), Vector2.new(9e9, 9e9));
	Setup.Transparency = Settings.Transparency or 0
	Setup.Size = Settings.Size
	Setup.ThemeMode = Settings.Theme or "Dark"

	if Settings.Blurring then
		Blurs[Settings.Title] = Blur.new(Window, 5)
		BlurEnabled = true
	end

	if Settings.MinimizeKeybind then
		Setup.Keybind = Settings.MinimizeKeybind
	end

	--// Navbar System (Redesigned)
	local NavbarSettings = Settings.Navbar or {}
	local NavbarTitle = NavbarSettings.Title or Settings.Title or "UI Library"
	local NavbarIcon = NavbarSettings.Icon
	local NavbarAuthor = NavbarSettings.Author
	local TitleLabel = nil
	local AuthorLabel = nil
	local IconImage = nil
	local TopBar = Sidebar and Sidebar:FindFirstChild("Top")

	-- Hide Mac-style buttons (the 3 colored circles)
	if TopBar then
		local ButtonsFrame = TopBar:FindFirstChild("Buttons")
		if ButtonsFrame then
			ButtonsFrame.Visible = false
		end
	end

	-- Create navbar elements in TopBar
	if TopBar then
		-- Navbar Icon (if provided)
		local iconOffset = 10
		if NavbarIcon then
			IconImage = Instance.new("ImageLabel")
			IconImage.Name = "NavbarIcon"
			IconImage.Size = UDim2.fromOffset(20, 20)
			IconImage.Position = UDim2.new(0, 10, 0.5, -10)
			IconImage.BackgroundTransparency = 1
			IconImage.Image = GetLucideIcon(NavbarIcon) or NavbarIcon
			IconImage.ImageColor3 = Theme.Icon
			IconImage.ScaleType = Enum.ScaleType.Fit
			IconImage.ZIndex = 5
			IconImage.Parent = TopBar
			iconOffset = 38
		end
		
		-- Navbar Title (left side)
		TitleLabel = Instance.new("TextLabel")
		TitleLabel.Name = "NavbarTitle"
		TitleLabel.Size = UDim2.new(0.5, 0, 1, 0)
		TitleLabel.Position = UDim2.new(0, iconOffset, 0, 0)
		TitleLabel.BackgroundTransparency = 1
		TitleLabel.Font = Enum.Font.GothamBold
		TitleLabel.Text = NavbarTitle
		TitleLabel.TextColor3 = Theme.Title
		TitleLabel.TextSize = 14
		TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
		TitleLabel.ZIndex = 5
		TitleLabel.Parent = TopBar
		
		-- Navbar Author (center-right, before buttons)
		if NavbarAuthor then
			AuthorLabel = Instance.new("TextLabel")
			AuthorLabel.Name = "NavbarAuthor"
			AuthorLabel.Size = UDim2.new(0.3, -70, 1, 0)
			AuthorLabel.Position = UDim2.new(0.5, 0, 0, 0)
			AuthorLabel.BackgroundTransparency = 1
			AuthorLabel.Font = Enum.Font.Gotham
			AuthorLabel.Text = "by " .. NavbarAuthor
			AuthorLabel.TextColor3 = Theme.Description
			AuthorLabel.TextSize = 11
			AuthorLabel.TextXAlignment = Enum.TextXAlignment.Right
			AuthorLabel.ZIndex = 5
			AuthorLabel.Parent = TopBar
		end

		-- Create new buttons container (right side)
		local NewButtonsFrame = Instance.new("Frame")
		NewButtonsFrame.Name = "NavbarButtons"
		NewButtonsFrame.Size = UDim2.new(0, 60, 1, 0)
		NewButtonsFrame.Position = UDim2.new(1, -65, 0, 0)
		NewButtonsFrame.BackgroundTransparency = 1
		NewButtonsFrame.ZIndex = 5
		NewButtonsFrame.Parent = TopBar

		-- Minimize Button (-)
		local MinimizeBtn = Instance.new("TextButton")
		MinimizeBtn.Name = "MinimizeBtn"
		MinimizeBtn.Size = UDim2.fromOffset(24, 24)
		MinimizeBtn.Position = UDim2.new(0, 0, 0.5, -12)
		MinimizeBtn.BackgroundColor3 = Theme.Interactables
		MinimizeBtn.BorderSizePixel = 0
		MinimizeBtn.Text = ""
		MinimizeBtn.AutoButtonColor = false
		MinimizeBtn.ZIndex = 6
		MinimizeBtn.Parent = NewButtonsFrame

		local MinimizeCorner = Instance.new("UICorner")
		MinimizeCorner.CornerRadius = UDim.new(0, 6)
		MinimizeCorner.Parent = MinimizeBtn

		local MinimizeIcon = Instance.new("ImageLabel")
		MinimizeIcon.Name = "Icon"
		MinimizeIcon.Size = UDim2.fromOffset(14, 14)
		MinimizeIcon.Position = UDim2.new(0.5, -7, 0.5, -7)
		MinimizeIcon.BackgroundTransparency = 1
		MinimizeIcon.Image = GetLucideIcon("minus") or "rbxassetid://11419701769"
		MinimizeIcon.ImageColor3 = Theme.Icon
		MinimizeIcon.ScaleType = Enum.ScaleType.Fit
		MinimizeIcon.ZIndex = 7
		MinimizeIcon.Parent = MinimizeBtn

		-- Close Button (X)
		local CloseBtn = Instance.new("TextButton")
		CloseBtn.Name = "CloseBtn"
		CloseBtn.Size = UDim2.fromOffset(24, 24)
		CloseBtn.Position = UDim2.new(0, 30, 0.5, -12)
		CloseBtn.BackgroundColor3 = Theme.Interactables
		CloseBtn.BorderSizePixel = 0
		CloseBtn.Text = ""
		CloseBtn.AutoButtonColor = false
		CloseBtn.ZIndex = 6
		CloseBtn.Parent = NewButtonsFrame

		local CloseCorner = Instance.new("UICorner")
		CloseCorner.CornerRadius = UDim.new(0, 6)
		CloseCorner.Parent = CloseBtn

		local CloseIcon = Instance.new("ImageLabel")
		CloseIcon.Name = "Icon"
		CloseIcon.Size = UDim2.fromOffset(14, 14)
		CloseIcon.Position = UDim2.new(0.5, -7, 0.5, -7)
		CloseIcon.BackgroundTransparency = 1
		CloseIcon.Image = GetLucideIcon("x") or "rbxassetid://11419704569"
		CloseIcon.ImageColor3 = Theme.Icon
		CloseIcon.ScaleType = Enum.ScaleType.Fit
		CloseIcon.ZIndex = 7
		CloseIcon.Parent = CloseBtn

		-- Button hover effects
		local function addButtonHover(btn, isClose)
			Connect(btn.MouseEnter, function()
				if isClose then
					Tween(btn, 0.15, { BackgroundColor3 = Color3.fromRGB(255, 80, 80) })
				else
					Tween(btn, 0.15, { BackgroundColor3 = Color3.fromRGB(80, 150, 255) })
				end
			end)
			Connect(btn.MouseLeave, function()
				Tween(btn, 0.15, { BackgroundColor3 = Theme.Interactables })
			end)
		end

		addButtonHover(MinimizeBtn, false)
		addButtonHover(CloseBtn, true)

		-- Button click handlers
		Connect(MinimizeBtn.MouseButton1Click, function()
			Opened = false
			Window.Visible = false
			if BlurEnabled and Blurs[Settings.Title] and Blurs[Settings.Title].root then
				Blurs[Settings.Title].root.Parent = nil
			end
		end)

		Connect(CloseBtn.MouseButton1Click, function()
			if Opened then
				if BlurEnabled and Blurs[Settings.Title] and Blurs[Settings.Title].root then
					Blurs[Settings.Title].root.Parent = nil
				end
				Opened = false
				Animations:Close(Window)
				Window.Visible = false
			else
				Animations:Open(Window, Setup.Transparency)
				Opened = true
				if BlurEnabled and Blurs[Settings.Title] then
					Blurs[Settings.Title].root.Parent = workspace.CurrentCamera
				end
			end
		end)
	end

	--// Navbar Control Functions
	function Options:SetNavbarTitle(newTitle: string)
		if TitleLabel then
			TitleLabel.Text = newTitle
		end
	end

	function Options:SetNavbarIcon(newIcon: string)
		if IconImage then
			IconImage.Image = GetLucideIcon(newIcon) or newIcon
		end
	end

	function Options:SetNavbarAuthor(newAuthor: string)
		if AuthorLabel then
			AuthorLabel.Text = "by " .. newAuthor
		end
	end

	function Options:GetNavbar()
		return TopBar
	end

	--// Floating Icon System
	local FloatingSettings = Settings.FloatingIcon or {}
	local FloatingEnabled = FloatingSettings.Enabled ~= false -- Default true
	local FloatingIconAsset = FloatingSettings.Icon or "rbxassetid://99140467467940"
	local FloatingSize = FloatingSettings.Size or 50
	local FloatingPosition = FloatingSettings.Position or UDim2.new(0, 20, 0.5, -25)

	if FloatingEnabled then
		-- Create Floating Icon Container
		FloatingBtn = Instance.new("ImageButton")
		FloatingBtn.Name = "FloatingIcon"
		FloatingBtn.Size = UDim2.fromOffset(FloatingSize, FloatingSize)
		FloatingBtn.Position = FloatingPosition
		FloatingBtn.AnchorPoint = Vector2.new(0, 0.5)
		FloatingBtn.BackgroundColor3 = Theme.Primary
		FloatingBtn.BorderSizePixel = 0
		FloatingBtn.Image = FloatingIconAsset
		FloatingBtn.ImageColor3 = Color3.fromRGB(255, 255, 255)
		FloatingBtn.ScaleType = Enum.ScaleType.Fit
		FloatingBtn.AutoButtonColor = false
		FloatingBtn.ZIndex = 999
		FloatingBtn.Parent = Screen

		-- Corner radius
		local FloatingCorner = Instance.new("UICorner")
		FloatingCorner.CornerRadius = UDim.new(0.3, 0)
		FloatingCorner.Parent = FloatingBtn

		-- Stroke/Outline
		local FloatingStroke = Instance.new("UIStroke")
		FloatingStroke.Color = Theme.Outline
		FloatingStroke.Thickness = 2
		FloatingStroke.Transparency = 0.5
		FloatingStroke.Parent = FloatingBtn

		-- Shadow effect
		local FloatingShadow = Instance.new("UIStroke")
		FloatingShadow.Name = "Shadow"
		FloatingShadow.Color = Theme.Shadow
		FloatingShadow.Thickness = 3
		FloatingShadow.Transparency = 0.7
		FloatingShadow.Parent = FloatingBtn

		-- Hover animations
		local isHovering = false
		Connect(FloatingBtn.MouseEnter, function()
			isHovering = true
			Tween(FloatingBtn, 0.2, { Size = UDim2.fromOffset(FloatingSize + 5, FloatingSize + 5) })
			Tween(FloatingStroke, 0.2, { Transparency = 0.2, Color = Color3.fromRGB(0, 170, 255) })
		end)

		Connect(FloatingBtn.MouseLeave, function()
			isHovering = false
			Tween(FloatingBtn, 0.2, { Size = UDim2.fromOffset(FloatingSize, FloatingSize) })
			Tween(FloatingStroke, 0.2, { Transparency = 0.5, Color = Theme.Outline })
		end)

		-- Drag functionality for Floating Icon
		local FloatingDragging = false
		local FloatingDragStart = nil
		local FloatingStartPos = nil

		Connect(FloatingBtn.InputBegan, function(Input)
			if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
				FloatingDragging = true
				FloatingDragStart = Input.Position
				FloatingStartPos = FloatingBtn.Position

				Connect(Input.Changed, function()
					if Input.UserInputState == Enum.UserInputState.End then
						FloatingDragging = false
					end
				end)
			end
		end)

		Connect(Services.Input.InputChanged, function(Input)
			if FloatingDragging and (Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch) then
				local Delta = Input.Position - FloatingDragStart
				FloatingBtn.Position = UDim2.new(
					FloatingStartPos.X.Scale,
					FloatingStartPos.X.Offset + Delta.X,
					FloatingStartPos.Y.Scale,
					FloatingStartPos.Y.Offset + Delta.Y
				)
			end
		end)

		-- Click to toggle window (only if not dragged)
		local clickStart = nil
		Connect(FloatingBtn.MouseButton1Down, function()
			clickStart = Vector2.new(Player.Mouse.X, Player.Mouse.Y)
		end)

		Connect(FloatingBtn.MouseButton1Up, function()
			if clickStart then
				local clickEnd = Vector2.new(Player.Mouse.X, Player.Mouse.Y)
				local dragDistance = (clickEnd - clickStart).Magnitude

				-- Only toggle if click didn't move much (not a drag)
				if dragDistance < 10 then
					-- Press animation
					Tween(FloatingBtn, 0.1, { Size = UDim2.fromOffset(FloatingSize - 5, FloatingSize - 5) })
					task.delay(0.1, function()
						Tween(FloatingBtn, 0.1, { Size = UDim2.fromOffset(FloatingSize, FloatingSize) })
					end)

					-- Toggle window
					if Opened then
						if BlurEnabled and Blurs[Settings.Title] and Blurs[Settings.Title].root then
							Blurs[Settings.Title].root.Parent = nil
						end
						Opened = false
						Animations:Close(Window)
						Window.Visible = false
					else
						Animations:Open(Window, Setup.Transparency)
						Opened = true
						if BlurEnabled and Blurs[Settings.Title] then
							Blurs[Settings.Title].root.Parent = workspace.CurrentCamera
						end
					end
				end
				clickStart = nil
			end
		end)

		-- Pulse animation when window is closed
		task.spawn(function()
			while FloatingBtn and FloatingBtn.Parent do
				if not Opened then
					Tween(FloatingStroke, 0.5, { Transparency = 0.2 })
					task.wait(0.5)
					Tween(FloatingStroke, 0.5, { Transparency = 0.6 })
					task.wait(0.5)
				else
					task.wait(0.5)
				end
			end
		end)
	end

	--// Animate
	local Close = function()
		if Opened then
			if BlurEnabled and Blurs[Settings.Title] and Blurs[Settings.Title].root then
				Blurs[Settings.Title].root.Parent = nil
			end

			Opened = false
			Animations:Close(Window)
			Window.Visible = false
		else
			Animations:Open(Window, Setup.Transparency)
			Opened = true

			if BlurEnabled and Blurs[Settings.Title] then
				Blurs[Settings.Title].root.Parent = workspace.CurrentCamera
			end
		end
	end

	-- Old Mac-style buttons are now hidden, using new navbar buttons instead
	-- Keep only the keybind handler

	Services.Input.InputBegan:Connect(function(Input, Focused) 
		if (Input == Setup.Keybind or Input.KeyCode == Setup.Keybind) and not Focused then
			Close()
		end
	end)

	--// Floating Icon Visibility Control
	function Options:SetFloatingIconVisible(Visible: boolean)
		if FloatingBtn then
			FloatingBtn.Visible = Visible
		end
	end

	function Options:SetFloatingIconPosition(Position: UDim2)
		if FloatingBtn then
			FloatingBtn.Position = Position
		end
	end

	function Options:SetFloatingIconImage(ImageId: string)
		if FloatingBtn then
			FloatingBtn.Image = ImageId
		end
	end

	function Options:GetFloatingIcon()
		return FloatingBtn
	end

	--// Tab Functions

	function Options:SetTab(Name: string)
		for Index, Button in next, Tab:GetChildren() do
			if Button:IsA("TextButton") then
				local Opened, SameName = Button.Value, (Button.Name == Name);
				local Padding = Button:FindFirstChildOfClass("UIPadding");

				if SameName and not Opened.Value then
					Tween(Padding, .25, { PaddingLeft = UDim.new(0, 25) });
					Tween(Button, .25, { BackgroundTransparency = 0.9, Size = UDim2.new(1, -15, 0, 30) });
					SetProperty(Opened, { Value = true });
				elseif not SameName and Opened.Value then
					Tween(Padding, .25, { PaddingLeft = UDim.new(0, 20) });
					Tween(Button, .25, { BackgroundTransparency = 1, Size = UDim2.new(1, -44, 0, 30) });
					SetProperty(Opened, { Value = false });
				end
			end
		end

		for Index, Main in next, Holder:GetChildren() do
			if Main:IsA("CanvasGroup") then
				local Opened, SameName = Main.Value, (Main.Name == Name);
				local Scroll = Main:FindFirstChild("ScrollingFrame");

				if SameName and not Opened.Value then
					Opened.Value = true
					Main.Visible = true

					Tween(Main, .3, { GroupTransparency = 0 });
					Tween(Scroll["UIPadding"], .3, { PaddingTop = UDim.new(0, 5) });

				elseif not SameName and Opened.Value then
					Opened.Value = false

					Tween(Main, .15, { GroupTransparency = 1 });
					Tween(Scroll["UIPadding"], .15, { PaddingTop = UDim.new(0, 15) });	

					task.delay(.2, function()
						Main.Visible = false
					end)
				end
			end
		end
	end

	function Options:AddTabSection(Settings: { Name: string, Order: number })
		local Example = Examples["SectionExample"];
		local Section = Clone(Example);

		StoredInfo["Sections"][Settings.Name] = (Settings.Order);
		SetProperty(Section, { 
			Parent = Example.Parent,
			Text = Settings.Name,
			Name = Settings.Name,
			LayoutOrder = Settings.Order,
			Visible = true
		});
	end

	function Options:AddTab(Settings: { Title: string, Icon: string, Section: string? })
		if StoredInfo["Tabs"][Settings.Title] then 
			error("[UI LIB]: A tab with the same name has already been created") 
		end 

		local Example, MainExample = Examples["TabButtonExample"], Examples["MainExample"];
		local Section = StoredInfo["Sections"][Settings.Section];
		local Main = Clone(MainExample);
		local Tab = Clone(Example);

		if not Settings.Icon then
			Destroy(Tab["ICO"]);
		else
			SetProperty(Tab["ICO"], { Image = Settings.Icon });
		end

		StoredInfo["Tabs"][Settings.Title] = { Tab }
		SetProperty(Tab["TextLabel"], { Text = Settings.Title });

		SetProperty(Main, { 
			Parent = MainExample.Parent,
			Name = Settings.Title;
		});

		SetProperty(Tab, { 
			Parent = Example.Parent,
			LayoutOrder = Section or #StoredInfo["Sections"] + 1,
			Name = Settings.Title;
			Visible = true;
		});

		Tab.MouseButton1Click:Connect(function()
			Options:SetTab(Tab.Name);
		end)

		return Main.ScrollingFrame
	end
	
	--// Notifications
	
	function Options:Notify(Settings: { Title: string, Description: string, Duration: number }) 
		local Notification = Clone(Components["Notification"]);
		local Title, Description = Options:GetLabels(Notification);
		local Timer = Notification["Timer"];
		
		SetProperty(Title, { Text = Settings.Title });
		SetProperty(Description, { Text = Settings.Description });
		SetProperty(Notification, {
			Parent = Screen["Frame"],
		})
		
		task.spawn(function() 
			local Duration = Settings.Duration or 2
			local Wait = task.wait;
			
			Animations:Open(Notification, Setup.Transparency, true); Tween(Timer, Duration, { Size = UDim2.new(0, 0, 0, 4) });
			Wait(Duration);
			Animations:Close(Notification);
			Wait(1);
			Notification:Destroy();
		end)
	end

	--// Component Functions

	function Options:GetLabels(Component)
		local Labels = Component:FindFirstChild("Labels")

		return Labels.Title, Labels.Description
	end

	function Options:AddSection(Settings: { Name: string, Tab: Instance }) 
		local Section = Clone(Components["Section"]);
		SetProperty(Section, {
			Text = Settings.Name,
			Parent = Settings.Tab,
			Visible = true,
		})
	end
	
	function Options:AddButton(Settings: { Title: string, Description: string, Tab: Instance, Callback: any }) 
		local Button = Clone(Components["Button"]);
		local Title, Description = Options:GetLabels(Button);

		Connect(Button.MouseButton1Click, Settings.Callback)
		Animations:Component(Button)
		SetProperty(Title, { Text = Settings.Title });
		SetProperty(Description, { Text = Settings.Description });
		SetProperty(Button, {
			Name = Settings.Title,
			Parent = Settings.Tab,
			Visible = true,
		})
	end

	function Options:AddInput(Settings: { Title: string, Description: string, Default: string?, Placeholder: string?, ClearOnFocus: boolean?, Tab: Instance, Callback: any }) 
		local Input = Clone(Components["Input"]);
		local Title, Description = Options:GetLabels(Input);
		local TextBox = Input["Main"]["Input"];
		
		-- Input Controller for external access
		local InputController = {}
		local currentValue = Settings.Default or ""
		
		-- Set placeholder text
		if Settings.Placeholder then
			TextBox.PlaceholderText = Settings.Placeholder
		end
		
		-- Set default value
		if Settings.Default then
			TextBox.Text = Settings.Default
		end
		
		-- ClearOnFocus is false by default (input persists)
		local clearOnFocus = Settings.ClearOnFocus or false

		Connect(Input.MouseButton1Click, function() 
			TextBox:CaptureFocus()
		end)
		
		-- Handle focus gained - only clear if ClearOnFocus is true
		Connect(TextBox.Focused, function()
			if clearOnFocus then
				-- Clear text when focused (old behavior)
				TextBox.Text = ""
			end
			-- Otherwise, keep the existing text (new default behavior)
		end)

		Connect(TextBox.FocusLost, function(enterPressed) 
			-- Store the current value
			currentValue = TextBox.Text
			-- Call the callback with the text
			Settings.Callback(TextBox.Text)
		end)
		
		-- InputController methods
		function InputController:Set(value)
			currentValue = tostring(value)
			TextBox.Text = currentValue
		end
		
		function InputController:Get()
			return currentValue
		end
		
		function InputController:Clear()
			currentValue = ""
			TextBox.Text = ""
		end
		
		function InputController:SetPlaceholder(placeholder)
			TextBox.PlaceholderText = placeholder
		end
		
		function InputController:Focus()
			TextBox:CaptureFocus()
		end

		Animations:Component(Input)
		SetProperty(Title, { Text = Settings.Title });
		SetProperty(Description, { Text = Settings.Description });
		SetProperty(Input, {
			Name = Settings.Title,
			Parent = Settings.Tab,
			Visible = true,
		})
		
		return InputController
	end

	function Options:AddToggle(Settings: { Title: string, Description: string, Default: boolean, Tab: Instance, Callback: any }) 
		local Toggle = Clone(Components["Toggle"]);
		local Title, Description = Options:GetLabels(Toggle);

		local On = Toggle["Value"];
		local Main = Toggle["Main"];
		local Circle = Main["Circle"];
		
		local Set = function(Value)
			if Value then
				Tween(Main,   .2, { BackgroundColor3 = Color3.fromRGB(153, 155, 255) });
				Tween(Circle, .2, { BackgroundColor3 = Color3.fromRGB(255, 255, 255), Position = UDim2.new(1, -16, 0.5, 0) });
			else
				Tween(Main,   .2, { BackgroundColor3 = Theme.Interactables });
				Tween(Circle, .2, { BackgroundColor3 = Theme.Primary, Position = UDim2.new(0, 3, 0.5, 0) });
			end
			
			On.Value = Value
		end 

		Connect(Toggle.MouseButton1Click, function()
			local Value = not On.Value

			Set(Value)
			Settings.Callback(Value)
		end)

		Animations:Component(Toggle);
		Set(Settings.Default);
		SetProperty(Title, { Text = Settings.Title });
		SetProperty(Description, { Text = Settings.Description });
		SetProperty(Toggle, {
			Name = Settings.Title,
			Parent = Settings.Tab,
			Visible = true,
		})
	end
	
	function Options:AddKeybind(Settings: { Title: string, Description: string, Tab: Instance, Callback: any }) 
		local Dropdown = Clone(Components["Keybind"]);
		local Title, Description = Options:GetLabels(Dropdown);
		local Bind = Dropdown["Main"].Options;
		
		local Mouse = { Enum.UserInputType.MouseButton1, Enum.UserInputType.MouseButton2, Enum.UserInputType.MouseButton3 }; 
		local Types = { 
			["Mouse"] = "Enum.UserInputType.MouseButton", 
			["Key"] = "Enum.KeyCode." 
		}
		
		Connect(Dropdown.MouseButton1Click, function()
			local Time = tick();
			local Detect, Finished
			
			SetProperty(Bind, { Text = "..." });
			Detect = Connect(game.UserInputService.InputBegan, function(Key, Focused) 
				local InputType = (Key.UserInputType);
				
				if not Finished and not Focused then
					Finished = (true)
					
					if table.find(Mouse, InputType) then
						Settings.Callback(Key);
						SetProperty(Bind, {
							Text = tostring(InputType):gsub(Types.Mouse, "MB")
						})
					elseif InputType == Enum.UserInputType.Keyboard then
						Settings.Callback(Key);
						SetProperty(Bind, {
							Text = tostring(Key.KeyCode):gsub(Types.Key, "")
						})
					end
				end 
			end)
		end)

		Animations:Component(Dropdown);
		SetProperty(Title, { Text = Settings.Title });
		SetProperty(Description, { Text = Settings.Description });
		SetProperty(Dropdown, {
			Name = Settings.Title,
			Parent = Settings.Tab,
			Visible = true,
		})
	end

	function Options:AddDropdown(Settings: { Title: string, Description: string, Options: {}, Tab: Instance, Callback: any }) 
		local Dropdown = Clone(Components["Dropdown"]);
		local Title, Description = Options:GetLabels(Dropdown);
		local Text = Dropdown["Main"].Options;

		Connect(Dropdown.MouseButton1Click, function()
			local Example = Clone(Examples["DropdownExample"]);
			local Buttons = Example["Top"]["Buttons"];

			Tween(BG, .25, { BackgroundTransparency = 0.6 });
			SetProperty(Example, { Parent = Window });
			Animations:Open(Example, 0, true)

			for Index, Button in next, Buttons:GetChildren() do
				if Button:IsA("TextButton") then
					Animations:Component(Button, true)

					Connect(Button.MouseButton1Click, function()
						Tween(BG, .25, { BackgroundTransparency = 1 });
						Animations:Close(Example);
						task.wait(2)
						Destroy(Example);
					end)
				end
			end

			for Index, Option in next, Settings.Options do
				local Button = Clone(Examples["DropdownButtonExample"]);
				local Title, Description = Options:GetLabels(Button);
				local Selected = Button["Value"];

				Animations:Component(Button);
				SetProperty(Title, { Text = Index });
				SetProperty(Button, { Parent = Example.ScrollingFrame, Visible = true });
				Destroy(Description);

				Connect(Button.MouseButton1Click, function() 
					local NewValue = not Selected.Value 

					if NewValue then
						Tween(Button, .25, { BackgroundColor3 = Theme.Interactables });
						Settings.Callback(Option)
						Text.Text = Index

						for _, Others in next, Example:GetChildren() do
							if Others:IsA("TextButton") and Others ~= Button then
								Others.BackgroundColor3 = Theme.Component
							end
						end
					else
						Tween(Button, .25, { BackgroundColor3 = Theme.Component });
					end

					Selected.Value = NewValue
					Tween(BG, .25, { BackgroundTransparency = 1 });
					Animations:Close(Example);
					task.wait(2)
					Destroy(Example);
				end)
			end
		end)

		Animations:Component(Dropdown);
		SetProperty(Title, { Text = Settings.Title });
		SetProperty(Description, { Text = Settings.Description });
		SetProperty(Dropdown, {
			Name = Settings.Title,
			Parent = Settings.Tab,
			Visible = true,
		})
	end

	function Options:AddSlider(Settings: { Title: string, Description: string, MaxValue: number, AllowDecimals: boolean, DecimalAmount: number, Tab: Instance, Callback: any }) 
		local Slider = Clone(Components["Slider"]);
		local Title, Description = Options:GetLabels(Slider);

		local Main = Slider["Slider"];
		local Amount = Main["Main"].Input;
		local Slide = Main["Slide"];
		local Fire = Slide["Fire"];
		local Fill = Slide["Highlight"];
		local Circle = Fill["Circle"];

		local Active = false
		local Value = 0
		
		local SetNumber = function(Number)
			if Settings.AllowDecimals then
				local Power = 10 ^ (Settings.DecimalAmount or 2)
				Number = math.floor(Number * Power + 0.5) / Power
			else
				Number = math.round(Number)
			end
			
			return Number
		end

		local Update = function(Number)
			local Scale = (Player.Mouse.X - Slide.AbsolutePosition.X) / Slide.AbsoluteSize.X			
			Scale = (Scale > 1 and 1) or (Scale < 0 and 0) or Scale
			
			if Number then
				Number = (Number > Settings.MaxValue and Settings.MaxValue) or (Number < 0 and 0) or Number
			end
			
			Value = SetNumber(Number or (Scale * Settings.MaxValue))
			Amount.Text = Value
			Fill.Size = UDim2.fromScale((Number and Number / Settings.MaxValue) or Scale, 1)
			Settings.Callback(Value)
		end

		local Activate = function()
			Active = true

			repeat task.wait()
				Update()
			until not Active
		end
		
		Connect(Amount.FocusLost, function() 
			Update(tonumber(Amount.Text) or 0)
		end)

		Connect(Fire.MouseButton1Down, Activate)
		Connect(Services.Input.InputEnded, function(Input) 
			if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
				Active = false
			end
		end)

		Fill.Size = UDim2.fromScale(Value, 1);
		Animations:Component(Slider);
		SetProperty(Title, { Text = Settings.Title });
		SetProperty(Description, { Text = Settings.Description });
		SetProperty(Slider, {
			Name = Settings.Title,
			Parent = Settings.Tab,
			Visible = true,
		})
	end

	function Options:AddParagraph(Settings: { Title: string, Description: string, Tab: Instance }) 
		local Paragraph = Clone(Components["Paragraph"]);
		local Title, Description = Options:GetLabels(Paragraph);

		SetProperty(Title, { Text = Settings.Title });
		SetProperty(Description, { Text = Settings.Description });
		SetProperty(Paragraph, {
			Parent = Settings.Tab,
			Visible = true,
		})
	end

	local Themes = {
		Names = {	
			["Paragraph"] = function(Label)
				if Label:IsA("TextButton") then
					Label.BackgroundColor3 = Color(Theme.Component, 5, "Dark");
				end
			end,
			
			["Title"] = function(Label)
				if Label:IsA("TextLabel") then
					Label.TextColor3 = Theme.Title
				end
			end,

			["Description"] = function(Label)
				if Label:IsA("TextLabel") then
					Label.TextColor3 = Theme.Description
				end
			end,
			
			["Section"] = function(Label)
				if Label:IsA("TextLabel") then
					Label.TextColor3 = Theme.Title
				end
			end,

			["Options"] = function(Label)
				if Label:IsA("TextLabel") and Label.Parent.Name == "Main" then
					Label.TextColor3 = Theme.Title
				end
			end,
			
			["Notification"] = function(Label)
				if Label:IsA("CanvasGroup") then
					Label.BackgroundColor3 = Theme.Primary
					Label.UIStroke.Color = Theme.Outline
				end
			end,

			["TextLabel"] = function(Label)
				if Label:IsA("TextLabel") and Label.Parent:FindFirstChild("List") then
					Label.TextColor3 = Theme.Tab
				end
			end,

			["Main"] = function(Label)
				if Label:IsA("Frame") then

					if Label.Parent == Window then
						Label.BackgroundColor3 = Theme.Secondary
					elseif Label.Parent:FindFirstChild("Value") then
						local Toggle = Label.Parent.Value 
						local Circle = Label:FindFirstChild("Circle")
						
						if not Toggle.Value then
							Label.BackgroundColor3 = Theme.Interactables
							Label.Circle.BackgroundColor3 = Theme.Primary
						end
					else
						Label.BackgroundColor3 = Theme.Interactables
					end
				elseif Label:FindFirstChild("Padding") then
					Label.TextColor3 = Theme.Title
				end
			end,

			["Amount"] = function(Label)
				if Label:IsA("Frame") then
					Label.BackgroundColor3 = Theme.Interactables
				end
			end,

			["Slide"] = function(Label)
				if Label:IsA("Frame") then
					Label.BackgroundColor3 = Theme.Interactables
				end
			end,

			["Input"] = function(Label)
				if Label:IsA("TextLabel") then
					Label.TextColor3 = Theme.Title
				elseif Label:FindFirstChild("Labels") then
					Label.BackgroundColor3 = Theme.Component
				elseif Label:IsA("TextBox") and Label.Parent.Name == "Main" then
					Label.TextColor3 = Theme.Title
				end
			end,

			["Outline"] = function(Stroke)
				if Stroke:IsA("UIStroke") then
					Stroke.Color = Theme.Outline
				end
			end,

			["DropdownExample"] = function(Label)
				Label.BackgroundColor3 = Theme.Secondary
			end,

			["Underline"] = function(Label)
				if Label:IsA("Frame") then
					Label.BackgroundColor3 = Theme.Outline
				end
			end,
		},

		Classes = {
			["ImageLabel"] = function(Label)
				if Label.Image ~= "rbxassetid://6644618143" then
					Label.ImageColor3 = Theme.Icon
				end
			end,

			["TextLabel"] = function(Label)
				if Label:FindFirstChild("Padding") then
					Label.TextColor3 = Theme.Title
				end
			end,

			["TextButton"] = function(Label)
				if Label:FindFirstChild("Labels") then
					Label.BackgroundColor3 = Theme.Component
				end
			end,

			["ScrollingFrame"] = function(Label)
				Label.ScrollBarImageColor3 = Theme.Component
			end,
		},
	}

	function Options:SetTheme(Info)
		Theme = Info or Theme

		Window.BackgroundColor3 = Theme.Primary
		Holder.BackgroundColor3 = Theme.Secondary
		Window.UIStroke.Color = Theme.Shadow

		for Index, Descendant in next, Screen:GetDescendants() do
			local Name, Class =  Themes.Names[Descendant.Name],  Themes.Classes[Descendant.ClassName]

			if Name then
				Name(Descendant);
			elseif Class then
				Class(Descendant);
			end
		end
	end

	--// Changing Settings

	function Options:SetSetting(Setting, Value) --// Available settings - Size, Transparency, Blur, Theme
		if Setting == "Size" then
			
			Window.Size = Value
			Setup.Size = Value
			
		elseif Setting == "Transparency" then
			
			Window.GroupTransparency = Value
			Setup.Transparency = Value
			
			for Index, Notification in next, Screen:GetDescendants() do
				if Notification:IsA("CanvasGroup") and Notification.Name == "Notification" then
					Notification.GroupTransparency = Value
				end
			end
			
		elseif Setting == "Blur" then
			
			local AlreadyBlurred, Root = Blurs[Settings.Title], nil
			
			if AlreadyBlurred then
				Root = Blurs[Settings.Title]["root"]
			end
			
			if Value then
				BlurEnabled = true

				if not AlreadyBlurred or not Root then
					Blurs[Settings.Title] = Blur.new(Window, 5)
				elseif Root and not Root.Parent then
					Root.Parent = workspace.CurrentCamera
				end
			elseif not Value and (AlreadyBlurred and Root and Root.Parent) then
				Root.Parent = nil
				BlurEnabled = false
			end
			
		elseif Setting == "Theme" and typeof(Value) == "table" then
			
			Options:SetTheme(Value)
			
		elseif Setting == "Keybind" then
			
			Setup.Keybind = Value
			
		else
			warn("Tried to change a setting that doesn't exist or isn't available to change.")
		end
	end

	SetProperty(Window, { Size = Settings.Size, Visible = true, Parent = Screen });
	Animations:Open(Window, Settings.Transparency or 0)

	return Options
end

--// Library Icon Functions (accessible outside CreateWindow)
function Library:GetIcon(iconName)
	return GetLucideIcon(iconName)
end

function Library:AddIcon(name, assetId)
	AddLucideIcon(name, assetId)
end

function Library:AddIcons(iconsTable)
	AddLucideIcons(iconsTable)
end

function Library:GetAllIcons()
	return LucideIcons
end

return Library
