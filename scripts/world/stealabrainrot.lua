local UIS = game:GetService("UserInputService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Debris = game:GetService("Debris")

local player = Players.LocalPlayer

-- 🔊 sonido original
local sound = player:WaitForChild("Backpack")
    :WaitForChild("Blackhole Slap")
    :WaitForChild("ChannelingStartSound")

-- 📁 partículas
local folder = ReplicatedStorage:WaitForChild("Models")
    :WaitForChild("ToolsExtras")
    :WaitForChild("Blackhole Slap")
    :WaitForChild("Blackhole")
    :WaitForChild("Main")
    :WaitForChild("Attachment")

local order = {
    "aura1","aura2","aura3","aura4","aura5","aura6",
    "blackhole","glow",
    "intake1","intake2","intake3","intake4","intake5"
}

-- 🧩 sync object
local marker = workspace:FindFirstChild("BlackholeSync")
if not marker then
    marker = Instance.new("Folder")
    marker.Name = "BlackholeSync"
    marker.Parent = workspace

    local activeVal = Instance.new("BoolValue")
    activeVal.Name = "Active"
    activeVal.Parent = marker

    local playerVal = Instance.new("StringValue")
    playerVal.Name = "Player"
    playerVal.Parent = marker
end

local active = false

-- 🔊 ráfagas rápidas de sonido
local function spamSound()
    while active do
        pcall(function()
            sound:Play()
        end)
        task.wait(0.03) -- 🔥 velocidad de ráfaga (bájalo más = más loco)
    end
end

-- 🌌 partículas
local function playEffects()
    local char = player.Character or player.CharacterAdded:Wait()
    local root = char:WaitForChild("HumanoidRootPart")

    while active do
        local att = Instance.new("Attachment")
        att.Parent = root

        for _, name in ipairs(order) do
            if not active then break end

            local emitter = folder:FindFirstChild(name)
            if emitter then
                local clone = emitter:Clone()
                clone.Parent = att
                clone.Enabled = true
                clone:Emit(20)

                Debris:AddItem(clone, 2)
            end

            task.wait(0.05)
        end

        Debris:AddItem(att, 2)
        task.wait(0.1)
    end
end

-- 🎮 toggle
UIS.InputBegan:Connect(function(input, gp)
    if gp then return end
    if input.KeyCode == Enum.KeyCode.B then
        active = not active
        print("Blackhole:", active)

        -- sync
        marker.Active.Value = active
        marker.Player.Value = player.Name

        if active then
            task.spawn(playEffects)
            task.spawn(spamSound)
        else
            sound:Stop()
        end
    end
end)
