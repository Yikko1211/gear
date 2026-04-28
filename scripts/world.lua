-- WORLD MODULE

local World = {}

-- 🌙 Full Bright PRO
function World.FullBright(state)
    local Lighting = game:GetService("Lighting")

    if state then
        Lighting.Brightness = 5
        Lighting.ClockTime = 14
        Lighting.FogEnd = 100000
        Lighting.GlobalShadows = false
        Lighting.OutdoorAmbient = Color3.fromRGB(128,128,128)
    else
        Lighting.Brightness = 2
        Lighting.GlobalShadows = true
    end
end

-- 🎨 Ambient Color
function World.Ambient(color)
    game.Lighting.Ambient = color
end

-- 🌫️ Remove Fog
function World.NoFog(state)
    game.Lighting.FogEnd = state and 100000 or 1000
end

-- 📷 FOV
function World.SetFOV(value)
    workspace.CurrentCamera.FieldOfView = value
end

-- 🎥 FreeCam (simple)
function World.FreeCam(state)
    if state then
        local cam = workspace.CurrentCamera
        cam.CameraType = Enum.CameraType.Scriptable
    else
        workspace.CurrentCamera.CameraType = Enum.CameraType.Custom
    end
end

return World
