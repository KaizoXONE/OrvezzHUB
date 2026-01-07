# 🎮 OrvezHUB - Modern Roblox Script Hub

![Roblox](https://img.shields.io/badge/Platform-Roblox-blue)
![Lua](https://img.shields.io/badge/Language-Lua-purple)
![Version](https://img.shields.io/badge/Version-1.0-orange)
![License](https://img.shields.io/badge/License-MIT-green)

A powerful and modern Roblox script hub featuring a stunning **glassmorphism UI library** with a sleek black-orange theme.

---

## ✨ Features

### 🎨 OrvezX UI Library

- **Glassmorphism Design** - Modern semi-transparent UI with blur effects
- **Black & Orange Theme** - Professional color scheme
- **Responsive Layout** - Works on both PC and Mobile
- **Drag & Resize** - Fully customizable window positioning and sizing
- **Auto-Save Config** - Automatically saves your settings
- **Notification System** - Beautiful animated notifications
- **Tab System** - Organize features into clean tabs
- **Rich Components** - Toggle, Button, Slider, Dropdown, Input, ColorPicker, and more

### 🎣 Fish It Script

Comprehensive automation script for the Fish It game with:

- Auto Farm features
- Custom configurations
- Modern UI integration

---

## 📦 Installation

### Method 1: Direct Loadstring (Recommended)

#### UI Library Only

```lua
local OrvezX = loadstring(game:HttpGet("https://raw.githubusercontent.com/YOUR_USERNAME/OrvezHUB/main/UI/Orvezz.lua"))()
```

#### Full Fish It Hub

```lua
loadstring(game:HttpGet("https://raw.githubusercontent.com/YOUR_USERNAME/OrvezHUB/main/FishIt.lua"))()
```

### Method 2: Manual Copy

1. Copy the content from [`UI/Orvezz.lua`](./UI/Orvezz.lua)
2. Paste into your executor
3. Run the script

---

## 🚀 Quick Start

### Basic Window

```lua
local OrvezX = loadstring(game:HttpGet("YOUR_RAW_GITHUB_URL"))()

-- Create a window
local Window = OrvezX:Window({
    Title = "My Hub",
    Footer = "v1.0",
    Color = Color3.fromRGB(255, 140, 0),  -- Orange (default)
    ["Tab Width"] = 120,
    Version = 1
})

-- Create a tab
local MainTab = Window:AddTab({
    Name = "Main",
    Icon = "star"  -- or use asset ID "rbxassetid://123456"
})

-- Add a toggle
MainTab:AddToggle({
    Name = "Auto Farm",
    Default = false,
    Callback = function(Value)
        print("Auto Farm:", Value)
        _G.AutoFarm = Value
    end
})

-- Add a button
MainTab:AddButton({
    Name = "Click Me",
    Callback = function()
        print("Button clicked!")
    end
})

-- Add a slider
MainTab:AddSlider({
    Name = "Walk Speed",
    Min = 16,
    Max = 100,
    Default = 16,
    Callback = function(Value)
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
    end
})
```

---

## 📚 UI Components

### Window

Create the main window container:

```lua
local Window = OrvezX:Window({
    Title = "Window Title",
    Footer = "Footer Text",
    Color = Color3.fromRGB(255, 140, 0),  -- Primary color
    ["Tab Width"] = 120,  -- Width of tab sidebar
    Version = 1  -- Config version
})
```

### Tab

Organize features into tabs:

```lua
local Tab = Window:AddTab({
    Name = "Tab Name",
    Icon = "icon_name"  -- See icon list below
})
```

### Toggle

Boolean on/off switch:

```lua
Tab:AddToggle({
    Name = "Toggle Name",
    Default = false,
    Callback = function(Value)
        print(Value)  -- true/false
    end
})
```

### Button

Clickable button:

```lua
Tab:AddButton({
    Name = "Button Text",
    Callback = function()
        print("Clicked!")
    end
})
```

### Slider

Numeric value selector:

```lua
Tab:AddSlider({
    Name = "Slider Name",
    Min = 0,
    Max = 100,
    Default = 50,
    Callback = function(Value)
        print(Value)
    end
})
```

### Dropdown

Selection from multiple options:

```lua
Tab:AddDropdown({
    Name = "Dropdown Name",
    Options = {"Option 1", "Option 2", "Option 3"},
    Default = "Option 1",
    Callback = function(Value)
        print("Selected:", Value)
    end
})
```

### Input (TextBox)

Text input field:

```lua
Tab:AddInput({
    Name = "Input Name",
    PlaceholderText = "Enter text...",
    Default = "",
    Callback = function(Value)
        print("Input:", Value)
    end
})
```

### Label

Static text display:

```lua
Tab:AddLabel({
    Text = "This is a label"
})
```

### Section

Group related items:

```lua
Tab:AddSection({
    Name = "Section Title"
})
```

---

## 🎨 Available Icons

Use these icon names in `Icon` parameter:

- `player`, `web`, `bag`, `shop`, `cart`, `plug`
- `settings`, `loop`, `gps`, `compas`, `gamepad`
- `boss`, `scroll`, `menu`, `crosshair`, `user`
- `stat`, `eyes`, `sword`, `discord`, `star`
- `skeleton`, `payment`, `scan`, `alert`, `question`
- `idea`, `strom`, `water`, `dcs`, `start`
- `next`, `rod`, `fish`

Or use custom Asset IDs:

```lua
Icon = "rbxassetid://12345678"
```

---

## 🔔 Notifications

### Simple Notification

```lua
OrvezX("Message text", 5, Color3.fromRGB(255, 140, 0), "Title", "Description")
```

### Advanced Notification

```lua
OrvezX:MakeNotify({
    Title = "Success",
    Description = "Operation Complete",
    Content = "Your action was successful!",
    Color = Color3.fromRGB(0, 255, 0),  -- Green
    Time = 0.5,   -- Animation time
    Delay = 5     -- Display duration
})
```

---

## ⚙️ Configuration System

The UI automatically saves and loads your settings:

- Auto-saves to `OrvezzX X/Config/OrvezzX_[GameName].json`
- Version-based config (prevents conflicts)
- Automatically loads on script restart

### Manual Config Control

```lua
-- Save manually
SaveConfig()

-- Load manually
LoadConfig()
```

---

## 🎮 Keyboard Shortcuts

- **F3** - Toggle UI visibility

---

## 🎨 Glassmorphism Theme

The UI features a modern glassmorphism design:

- **Main Window**: 70% opaque black with blur
- **Notifications**: 80% opaque for readability
- **Orange Borders**: `RGB(255, 140, 0)` with subtle glow
- **Blur Effect**: Size 24 for depth perception

### Custom Theme (Background Image)

```lua
local Window = OrvezX:Window({
    Title = "My Hub",
    Theme = "1234567890",  -- Asset ID (numbers only)
    ThemeTransparency = 0.15  -- Image transparency
})
```

---

## 📁 Repository Structure

```
OrvezHUB/
├── UI/
│   └── Orvezz.lua          # UI Library
├── FishIt.lua              # Fish It main script
├── OrvezzUiExampleTest.lua # UI examples/demo
├── README.md               # This file
└── LICENSE                 # MIT License
```

---

## 🤝 Contributing

Contributions are welcome! Feel free to:

- Report bugs
- Suggest new features
- Submit pull requests
- Improve documentation

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## 🌟 Credits

**Created by OrvezX**

- UI Library: OrvezX UI (Custom Glassmorphism)
- Theme: Black & Orange Modern
- Version: 1.0

---

## 📞 Support

For support, bug reports, or feature requests:

- Open an issue on GitHub
- Join our Discord (if applicable)

---

## ⚠️ Disclaimer

This script is for **educational purposes only**. Use at your own risk. The creator is not responsible for any bans or penalties resulting from the use of this script.

---

**Made with ❤️ by OrvezX**
