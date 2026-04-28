-- ╔════════════════════════════╗
--        WORLD MODULE
-- ╚════════════════════════════╝

local World = {}

local Lighting = game:GetService("Lighting")
local Camera = workspace.CurrentCamera

-- Estado interno
World.State = {
    FullBright = false,
    NoFog = false,
    FreeCam = false,
    FOV = 70
}

-- 🌙 FULL BRIGHT
function World.ToggleFullBright(state)
    World.State.FullBright = state

    if state then
        Lighting.Brightness = 5
        Lighting.ClockTime = 14
        Lighting.GlobalShadows = false
        Lighting.OutdoorAmbient = Color3.fromRGB(128,128,128)
    else
        Lighting.Brightness = 2
        Lighting.GlobalShadows = true
    end
end

-- 🌫️ NO FOG
function World.ToggleFog(state)
    World.State.NoFog = state
    Lighting.FogEnd = state and 100000 or 1000
end

-- 🎥 FREECAM
function World.ToggleFreeCam(state)
    World.State.FreeCam = state

    if state then
        Camera.CameraType = Enum.CameraType.Scriptable
    else
        Camera.CameraType = Enum.CameraType.Custom
    end
end

-- 📷 FOV
function World.SetFOV(value)
    value = math.clamp(value, 70, 120)
    World.State.FOV = value
    Camera.FieldOfView = value
end

-- 🎨 COLOR AMBIENTE
function World.SetAmbient(color)
    Lighting.Ambient = color
end

return World
