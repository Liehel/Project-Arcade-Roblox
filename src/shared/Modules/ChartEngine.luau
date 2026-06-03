local ChartEngine = {}

local AssetService = game:GetService("AssetService")

-- professional dark color palette
ChartEngine.Palette = {
	background  = Color3.fromHex("0f172a"),
	surface     = Color3.fromHex("1e293b"),
	surfaceAlt  = Color3.fromHex("273449"),
	grid        = Color3.fromHex("334155"),
	axis        = Color3.fromHex("64748b"),
	text        = Color3.fromHex("f1f5f9"),
	textDim     = Color3.fromHex("94a3b8"),
	textMuted   = Color3.fromHex("64748b"),
	primary     = Color3.fromHex("6366f1"),
	secondary   = Color3.fromHex("22c55e"),
	accent      = Color3.fromHex("f59e0b"),
	danger      = Color3.fromHex("ef4444"),
	gold        = Color3.fromHex("fbbf24"),
	silver      = Color3.fromHex("cbd5e1"),
	bronze      = Color3.fromHex("d97706"),
}

-- per-game brand colors used across all charts
ChartEngine.GameColors = {
	TapAndHold        = Color3.fromHex("fb7185"),
	TurrisCasei       = Color3.fromHex("eab308"),
	JuiceCutter       = Color3.fromHex("84cc16"),
	FoxyFruit         = Color3.fromHex("fbbf24"),
	AvisToucan        = Color3.fromHex("06b6d4"),
	Oxybelis          = Color3.fromHex("10b981"),
	FirmamentDefender = Color3.fromHex("a855f7"),
	FirmamentSiege    = Color3.fromHex("8b5cf6"),
	Resilio           = Color3.fromHex("ec4899"),
	ImNotASphere      = Color3.fromHex("3b82f6"),
}

-- returns the color for a game id, defaulting to primary
function ChartEngine.ColorFor(gameId)
	return ChartEngine.GameColors[gameId] or ChartEngine.Palette.primary
end

-- creates a blank canvas filled with the background color
function ChartEngine.CreateCanvas(width, height)
	local image = AssetService:CreateEditableImage({ Size = Vector2.new(width, height) })
	image:DrawRectangle(
		Vector2.zero,
		Vector2.new(width, height),
		ChartEngine.Palette.background,
		0,
		Enum.ImageCombineType.Overwrite
	)
	return image
end

-- draws a filled rectangle with a fully overwriting color
function ChartEngine.FillRect(image, x, y, w, h, color)
	image:DrawRectangle(
		Vector2.new(x, y),
		Vector2.new(w, h),
		color,
		0,
		Enum.ImageCombineType.Overwrite
	)
end

-- draws grid lines across a region; pass axes = "h", "v", or "both"
function ChartEngine.DrawGrid(image, region, lines, axes)
	lines = lines or 5
	axes  = axes or "h"
	if axes == "h" or axes == "both" then
		local step = region.height / lines
		for i = 0, lines do
			local y = region.y + i * step
			image:DrawLine(
				Vector2.new(region.x, y),
				Vector2.new(region.x + region.width, y),
				ChartEngine.Palette.grid,
				0,
				Enum.ImageCombineType.AlphaBlend
			)
		end
	end
	if axes == "v" or axes == "both" then
		local step = region.width / lines
		for i = 0, lines do
			local x = region.x + i * step
			image:DrawLine(
				Vector2.new(x, region.y),
				Vector2.new(x, region.y + region.height),
				ChartEngine.Palette.grid,
				0,
				Enum.ImageCombineType.AlphaBlend
			)
		end
	end
end

-- draws the bottom and left axes of a chart region
function ChartEngine.DrawAxes(image, region)
	image:DrawLine(
		Vector2.new(region.x, region.y + region.height),
		Vector2.new(region.x + region.width, region.y + region.height),
		ChartEngine.Palette.axis,
		0,
		Enum.ImageCombineType.AlphaBlend
	)
	image:DrawLine(
		Vector2.new(region.x, region.y),
		Vector2.new(region.x, region.y + region.height),
		ChartEngine.Palette.axis,
		0,
		Enum.ImageCombineType.AlphaBlend
	)
end

-- computes the auto-scaled max value for a list of numbers
local function autoMax(values)
	local maxV = 0
	for _, v in ipairs(values) do
		if v > maxV then maxV = v end
	end
	if maxV == 0 then return 1 end
	return maxV * 1.15
end

-- draws a vertical bar chart with optional per-bar colors
function ChartEngine.DrawBarChart(image, region, options)
	local values = options.values or {}
	local n = #values
	if n == 0 then return end

	local maxValue = options.maxValue or autoMax(values)
	if maxValue == 0 then maxValue = 1 end

	ChartEngine.DrawGrid(image, region, 4, "h")

	local slot = region.width / n
	local barWidth = slot * 0.65
	local pad = (slot - barWidth) / 2

	for i, value in ipairs(values) do
		local color = options.color or ChartEngine.Palette.primary
		if type(options.colors) == "table" and options.colors[i] then
			color = options.colors[i]
		end
		local frac = math.max(0, math.min(1, value / maxValue))
		local barH = frac * region.height
		local x = region.x + (i - 1) * slot + pad
		local y = region.y + region.height - barH
		if barH > 0 then
			ChartEngine.FillRect(image, x, y, barWidth, barH, color)
		end
	end

	ChartEngine.DrawAxes(image, region)
end

-- draws a horizontal bar chart for ranked comparisons
function ChartEngine.DrawHorizontalBarChart(image, region, options)
	local values = options.values or {}
	local n = #values
	if n == 0 then return end

	local maxValue = options.maxValue or autoMax(values)
	if maxValue == 0 then maxValue = 1 end

	local slot = region.height / n
	local barH = slot * 0.65
	local pad = (slot - barH) / 2

	for i, value in ipairs(values) do
		local color = options.color or ChartEngine.Palette.primary
		if type(options.colors) == "table" and options.colors[i] then
			color = options.colors[i]
		end
		local frac = math.max(0, math.min(1, value / maxValue))
		local barW = frac * region.width
		local y = region.y + (i - 1) * slot + pad
		-- subtle track behind the bar
		ChartEngine.FillRect(image, region.x, y, region.width, barH, ChartEngine.Palette.surfaceAlt)
		if barW > 0 then
			ChartEngine.FillRect(image, region.x, y, barW, barH, color)
		end
	end
end

-- draws a histogram-style distribution
function ChartEngine.DrawHistogram(image, region, options)
	local buckets = options.buckets or {}
	local n = #buckets
	if n == 0 then return end

	local maxCount = 0
	for _, c in ipairs(buckets) do
		if c > maxCount then maxCount = c end
	end
	if maxCount == 0 then return end

	ChartEngine.DrawGrid(image, region, 4, "h")

	local color = options.color or ChartEngine.Palette.primary
	local barWidth = region.width / n

	for i, count in ipairs(buckets) do
		if count > 0 then
			local barH = (count / maxCount) * region.height
			local x = region.x + (i - 1) * barWidth
			local y = region.y + region.height - barH
			ChartEngine.FillRect(image, x, y, math.max(1, barWidth - 1), barH, color)
		end
	end

	ChartEngine.DrawAxes(image, region)
end

-- draws a scatter plot from a list of { x, y } points
function ChartEngine.DrawScatterPlot(image, region, options)
	local points = options.points or {}
	local n = #points
	if n == 0 then return end

	local minX, maxX = math.huge, -math.huge
	local minY, maxY = math.huge, -math.huge
	for _, p in ipairs(points) do
		if p.x < minX then minX = p.x end
		if p.x > maxX then maxX = p.x end
		if p.y < minY then minY = p.y end
		if p.y > maxY then maxY = p.y end
	end
	if minX == maxX then maxX = minX + 1 end
	if minY == maxY then maxY = minY + 1 end

	-- include zero in the range when sensible
	if minX > 0 then minX = 0 end
	if minY > 0 then minY = 0 end

	ChartEngine.DrawGrid(image, region, 4, "both")

	for _, p in ipairs(points) do
		local fracX = (p.x - minX) / (maxX - minX)
		local fracY = (p.y - minY) / (maxY - minY)
		local x = region.x + fracX * region.width
		local y = region.y + region.height - fracY * region.height
		local color = p.color or options.color or ChartEngine.Palette.primary
		image:DrawCircle(
			Vector2.new(x, y),
			5,
			color,
			0,
			Enum.ImageCombineType.Overwrite
		)
	end

	ChartEngine.DrawAxes(image, region)

	return { minX = minX, maxX = maxX, minY = minY, maxY = maxY }
end

-- attaches an editable image to an image label, falling back to parenting if the modern api is unavailable
function ChartEngine.AttachToLabel(imageLabel, editableImage)
	local ok = pcall(function()
		imageLabel.ImageContent = Content.fromObject(editableImage)
	end)
	if ok then return true end

	-- legacy fallback: parent the editable image to the label
	local ok2 = pcall(function()
		editableImage.Parent = imageLabel
	end)
	return ok2
end

return ChartEngine
