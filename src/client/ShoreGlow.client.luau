-- Adds a sparkle emitter to every part tagged "ShoreGlow" (the shoreline edge).
local CollectionService = game:GetService("CollectionService")
local GLOW_TAG = "ShoreGlow"
local GLOW_COLOR = Color3.fromRGB(185, 70, 255)

-- hide the part and attach the sparkle emitter
local function track(part)
	if not part:IsA("BasePart") then return end
	if part:FindFirstChild("ShoreSparkle") then return end

	part.Transparency = 1
	part.CanCollide   = false
	part.CastShadow   = false

	local emitter = Instance.new("ParticleEmitter")
	emitter.Name          = "ShoreSparkle"
	emitter.Texture       = "rbxasset://textures/particles/sparkles_main.dds"
	emitter.Color         = ColorSequence.new(GLOW_COLOR)
	emitter.LightEmission  = 1
	emitter.LightInfluence = 0
	emitter.Speed         = NumberRange.new(0)
	emitter.Rotation      = NumberRange.new(0, 360)
	emitter.Lifetime      = NumberRange.new(1.0, 2.6)  
	emitter.Rate          = 400                       
	emitter.Size = NumberSequence.new({
		NumberSequenceKeypoint.new(0, 0),
		NumberSequenceKeypoint.new(0.5, 0.45),
		NumberSequenceKeypoint.new(1, 0),
	})
	emitter.Transparency = NumberSequence.new({
		NumberSequenceKeypoint.new(0, 1),
		NumberSequenceKeypoint.new(0.3, 0.1),
		NumberSequenceKeypoint.new(0.7, 0.1),
		NumberSequenceKeypoint.new(1, 1),
	})
	emitter.Parent = part
end

for _, p in ipairs(CollectionService:GetTagged(GLOW_TAG)) do track(p) end
CollectionService:GetInstanceAddedSignal(GLOW_TAG):Connect(track)
