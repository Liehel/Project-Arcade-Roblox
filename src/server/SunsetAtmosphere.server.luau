local Lighting = game:GetService("Lighting")

-- performance: no real-time shadows, lightest lighting technology for mobile
Lighting.GlobalShadows = false
pcall(function() Lighting.Technology = Enum.Technology.Compatibility end)

-- low sun for a golden-hour look
Lighting.ClockTime = 17.6
Lighting.GeographicLatitude = 20
Lighting.Brightness = 2.5
Lighting.ExposureCompensation = 0.15
Lighting.Ambient = Color3.fromRGB(70, 45, 35)
Lighting.OutdoorAmbient = Color3.fromRGB(140, 85, 55)
Lighting.ColorShift_Top = Color3.fromRGB(255, 150, 70)
Lighting.ColorShift_Bottom = Color3.fromRGB(120, 60, 40)
Lighting.EnvironmentDiffuseScale = 1
Lighting.EnvironmentSpecularScale = 1

-- atmosphere drives the orange sunset haze (cheap on gpu)
local atmos = Lighting:FindFirstChildOfClass("Atmosphere") or Instance.new("Atmosphere")
atmos.Density = 0.38
atmos.Offset  = 0.25
atmos.Color   = Color3.fromRGB(215, 160, 120)  -- haze color
atmos.Decay   = Color3.fromRGB(170, 80, 45)    -- horizon orange
atmos.Glare   = 0.4
atmos.Haze    = 2.6
atmos.Parent  = Lighting

-- color grade: warm orange tint
local cc = Lighting:FindFirstChild("SunsetGrade") or Instance.new("ColorCorrectionEffect")
cc.Name       = "SunsetGrade"
cc.TintColor  = Color3.fromRGB(255, 200, 150)
cc.Brightness = 0.02
cc.Contrast   = 0.12
cc.Saturation = 0.15
cc.Parent     = Lighting

-- bloom: glow around the sun
local bloom = Lighting:FindFirstChild("SunsetBloom") or Instance.new("BloomEffect")
bloom.Name      = "SunsetBloom"
bloom.Intensity = 0.7
bloom.Size      = 28
bloom.Threshold = 0.9
bloom.Parent    = Lighting

-- sky: stars off, bigger sun disc
local sky = Lighting:FindFirstChildOfClass("Sky") or Instance.new("Sky")
sky.StarCount      = 0
sky.SunAngularSize = 21
sky.Parent         = Lighting

print("sunset atmosphere ready.")
