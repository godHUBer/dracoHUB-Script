-- dracoHUB | Blox Fruits Auto Farm & Utility Script
-- Made for Pushpan Saha 🐉

--// Services
local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")
local VirtualUser = game:GetService("VirtualUser")
local VirtualInputManager = game:GetService("VirtualInputManager")
local LocalPlayer = Players.LocalPlayer

--// GUI Setup
local DracoUI = Instance.new("ScreenGui")
DracoUI.Name = "dracoHUB"
DracoUI.ResetOnSpawn = false
DracoUI.Parent = game:GetService("CoreGui")

local Frame = Instance.new("Frame", DracoUI)
Frame.Position = UDim2.new(0.2, 0, 0.2, 0)
Frame.Size = UDim2.new(0, 400, 0, 600)
Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Frame.BorderSizePixel = 0
Frame.Draggable = true
Frame.Active = true

local UIListLayout = Instance.new("UIListLayout", Frame)
UIListLayout.Padding = UDim.new(0, 5)

--// State Variables (All off by default)
local settings = {
    autoFarm = false,
    autoQuest = false,
    skillSpam = false,
    bossGrind = false,
    fruitCollect = false,
    chestCollect = false,
    berryCollect = false,
    autoStat = false,
    teleport = false,
    gachaLuck = false,
    antiAFK = false,
    reconnect = false,
    safeDelays = false,
    multiVPN = false,
    antiBotDetect = false,
    customLag = false
}

--// Utility
local function createToggle(name, callback)
    local button = Instance.new("TextButton")
    button.Text = "[ OFF ] " .. name
    button.Size = UDim2.new(1, -10, 0, 30)
    button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    button.TextColor3 = Color3.new(1, 1, 1)
    button.Parent = Frame

    local toggled = false
    button.MouseButton1Click:Connect(function()
        toggled = not toggled
        settings[name] = toggled
        button.Text = (toggled and "[ ON  ] " or "[ OFF ] ") .. name
        if callback then callback(toggled) end
    end)
end

--// Anti-AFK
createToggle("antiAFK", function(on)
    if on then
        LocalPlayer.Idled:Connect(function()
            VirtualUser:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
            task.wait(1)
            VirtualUser:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
        end)
    end
end)

--// Auto-Farm
createToggle("autoFarm", function(on)
    spawn(function()
        while settings.autoFarm do
            -- Add farming logic
            task.wait(1.5)
        end
    end)
end)

--// Auto-Quest
createToggle("autoQuest", function(on)
    spawn(function()
        while settings.autoQuest do
            -- Add quest logic
            task.wait(2)
        end
    end)
end)

--// Skill Spam
createToggle("skillSpam", function(on)
    spawn(function()
        while settings.skillSpam do
            for _, key in ipairs({"Z", "X", "C"}) do
                VirtualInputManager:SendKeyEvent(true, key, false, game)
                task.wait(0.1)
                VirtualInputManager:SendKeyEvent(false, key, false, game)
            end
            task.wait(3)
        end
    end)
end)

--// Multi VPN (visual only toggle)
createToggle("multiVPN", function(on)
    print("[dracoHUB] Multi VPN mode:", on)
end)

--// Reconnect
createToggle("reconnect", function(on)
    if on then
        LocalPlayer.OnTeleport:Connect(function(state)
            if state == Enum.TeleportState.Failed then
                TeleportService:Teleport(game.PlaceId)
            end
        end)
    end
end)

--// Anti Bot Detection (dummy toggle)
createToggle("antiBotDetect", function(on)
    print("[dracoHUB] Anti bot detection:", on)
end)

--// Custom Lag Generator (dummy toggle)
createToggle("customLag", function(on)
    spawn(function()
        while settings.customLag do
            game:GetService("RunService"):Set3dRenderingEnabled(false)
            wait(0.25)
            game:GetService("RunService"):Set3dRenderingEnabled(true)
            wait(0.25)
        end
    end)
end)

print("[dracoHUB] GUI initialized. All systems ready. Add features as needed.")
