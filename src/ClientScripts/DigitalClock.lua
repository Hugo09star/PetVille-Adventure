-- PetVille Adventure - Digital Clock System
-- Relógio digital que mostra hora em diferentes fusos horários

local DigitalClock = {}

-- ==================== CONFIGURAÇÃO DE FUSOS HORÁRIOS ====================
DigitalClock.TimeZones = {
	UTC = {name = "UTC", offset = 0},
	EST = {name = "EST (New York)", offset = -5},
	CST = {name = "CST (Chicago)", offset = -6},
	MST = {name = "MST (Denver)", offset = -7},
	PST = {name = "PST (Los Angeles)", offset = -8},
	GMT = {name = "GMT (London)", offset = 0},
	CET = {name = "CET (Paris/Berlin)", offset = 1},
	EET = {name = "EET (Cairo/Athens)", offset = 2},
	IST = {name = "IST (India)", offset = 5.5},
	SGT = {name = "SGT (Singapore)", offset = 8},
	JST = {name = "JST (Japan)", offset = 9},
	AEST = {name = "AEST (Sydney)", offset = 10},
	NZST = {name = "NZST (New Zealand)", offset = 12},
	BRT = {name = "BRT (Brazil)", offset = -3},
	ART = {name = "ART (Argentina)", offset = -3},
	WET = {name = "WET (Portugal)", offset = 0},
	WEST = {name = "WEST (Portugal Summer)", offset = 1},
}

-- ==================== OBTER HORA UTC ====================
function DigitalClock.GetUTCTime()
	-- Simular hora UTC (em um jogo real, usaria os servidores do Roblox)
	local currentTime = os.time()
	return currentTime
end

-- ==================== CONVERTER PARA FUSO HORÁRIO ====================
function DigitalClock.ConvertToTimeZone(utcTime, timeZoneOffset)
	-- Converter segundos para horas
	local hours = math.floor(utcTime / 3600) % 24
	local minutes = math.floor((utcTime % 3600) / 60)
	local seconds = utcTime % 60
	
	-- Aplicar offset do fuso horário
	hours = (hours + timeZoneOffset) % 24
	if hours < 0 then
		hours = hours + 24
	end
	
	return hours, minutes, seconds
end

-- ==================== FORMATAR HORA ====================
function DigitalClock.FormatTime(hours, minutes, seconds, format24h)
	if format24h == nil then format24h = true end
	
	local displayHours = hours
	local period = "AM"
	
	-- Converter para formato 12h se necessário
	if not format24h then
		if hours >= 12 then
			period = "PM"
			if hours > 12 then
				displayHours = hours - 12
			end
		else
			if hours == 0 then
				displayHours = 12
			end
		end
	end
	
	local timeString = string.format("%02d:%02d:%02d", displayHours, minutes, seconds)
	
	if not format24h then
		timeString = timeString .. " " .. period
	end
	
	return timeString
end

-- ==================== OBTER HORA FORMATADA POR FUSO ====================
function DigitalClock.GetFormattedTimeByZone(timeZoneName, format24h)
	if not DigitalClock.TimeZones[timeZoneName] then
		return nil, "Fuso horário não encontrado"
	end
	
	local utcTime = DigitalClock.GetUTCTime()
	local offset = DigitalClock.TimeZones[timeZoneName].offset
	local hours, minutes, seconds = DigitalClock.ConvertToTimeZone(utcTime, offset)
	
	return DigitalClock.FormatTime(hours, minutes, seconds, format24h)
end

-- ==================== OBTER TODOS OS FUSOS ====================
function DigitalClock.GetAllTimeZonesFormatted(format24h)
	local result = {}
	
	for zoneKey, zoneData in pairs(DigitalClock.TimeZones) do
		local time = DigitalClock.GetFormattedTimeByZone(zoneKey, format24h)
		table.insert(result, {
			code = zoneKey,
			name = zoneData.name,
			time = time,
			offset = zoneData.offset,
		})
	end
	
	-- Ordenar por offset
	table.sort(result, function(a, b)
		return a.offset < b.offset
	end)
	
	return result
end

-- ==================== CRIAR RELÓGIO VISUAL ====================
function DigitalClock.CreateClockGUI(parent, position, size, selectedZones)
	selectedZones = selectedZones or {"UTC", "EST", "GMT", "JST", "BRT"}
	
	-- Frame principal
	local clockFrame = Instance.new("Frame")
	clockFrame.Name = "DigitalClock"
	clockFrame.Size = size
	clockFrame.Position = position
	clockFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
	clockFrame.BorderSizePixel = 0
	clockFrame.Parent = parent
	
	-- Título
	local title = Instance.new("TextLabel")
	title.Name = "Title"
	title.Size = UDim2.new(1, 0, 0.15, 0)
	title.Position = UDim2.new(0, 0, 0, 0)
	title.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	title.TextColor3 = Color3.fromRGB(100, 200, 255)
	title.TextSize = 20
	title.Font = Enum.Font.GothamBold
	title.Text = "🕐 PetVille World Clock"
	title.BorderSizePixel = 0
	title.Parent = clockFrame
	
	-- Lista de fusos
	local clockList = Instance.new("Frame")
	clockList.Name = "ClockList"
	clockList.Size = UDim2.new(1, 0, 0.85, 0)
	clockList.Position = UDim2.new(0, 0, 0.15, 0)
	clockList.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
	clockList.BorderSizePixel = 0
	clockList.Parent = clockFrame
	
	-- ScrollingFrame para múltiplos fusos
	local scrollFrame = Instance.new("ScrollingFrame")
	scrollFrame.Size = UDim2.new(1, 0, 1, 0)
	scrollFrame.BackgroundTransparency = 1
	scrollFrame.BorderSizePixel = 0
	scrollFrame.ScrollBarThickness = 8
	scrollFrame.CanvasSize = UDim2.new(0, 0, 0, (#selectedZones) * 50)
	scrollFrame.Parent = clockList
	
	-- Criar um relógio para cada fuso selecionado
	for i, zoneName in ipairs(selectedZones) do
		if DigitalClock.TimeZones[zoneName] then
			local zoneData = DigitalClock.TimeZones[zoneName]
			
			-- Container do fuso
			local zoneContainer = Instance.new("Frame")
			zoneContainer.Name = zoneName .. "Container"
			zoneContainer.Size = UDim2.new(1, -10, 0, 40)
			zoneContainer.Position = UDim2.new(0, 5, 0, (i - 1) * 45)
			zoneContainer.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
			zoneContainer.BorderSizePixel = 1
			zoneContainer.BorderColor3 = Color3.fromRGB(100, 200, 255)
			zoneContainer.Parent = scrollFrame
			
			-- Nome do fuso
			local zoneLabel = Instance.new("TextLabel")
			zoneLabel.Name = "ZoneName"
			zoneLabel.Size = UDim2.new(0.5, 0, 1, 0)
			zoneLabel.Position = UDim2.new(0, 5, 0, 0)
			zoneLabel.BackgroundTransparency = 1
			zoneLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
			zoneLabel.TextSize = 14
			zoneLabel.Font = Enum.Font.Gotham
			zoneLabel.TextXAlignment = Enum.TextXAlignment.Left
			zoneLabel.Text = zoneData.name
			zoneLabel.Parent = zoneContainer
			
			-- Hora do fuso
			local timeLabel = Instance.new("TextLabel")
			timeLabel.Name = "TimeDisplay"
			timeLabel.Size = UDim2.new(0.5, -10, 1, 0)
			timeLabel.Position = UDim2.new(0.5, 0, 0, 0)
			timeLabel.BackgroundTransparency = 1
			timeLabel.TextColor3 = Color3.fromRGB(100, 200, 255)
			timeLabel.TextSize = 14
			timeLabel.Font = Enum.Font.GothamMonospace
			timeLabel.TextXAlignment = Enum.TextXAlignment.Right
			timeLabel.Parent = zoneContainer
			
			-- Atualizar hora em tempo real
			task.spawn(function()
				while timeLabel.Parent do
					local time = DigitalClock.GetFormattedTimeByZone(zoneName, true)
					timeLabel.Text = time
					task.wait(1)
				end
			end)
		end
	end
	
	return clockFrame
end

-- ==================== EXIBIR NO CONSOLE ====================
function DigitalClock.PrintAllTimeZones(format24h)
	print("\n" .. string.rep("=", 60))
	print("🕐 PETVILLE WORLD CLOCK")
	print(string.rep("=", 60))
	
	local allZones = DigitalClock.GetAllTimeZonesFormatted(format24h)
	
	for _, zone in ipairs(allZones) do
		print(string.format("%-25s | %s | (UTC%+.1f)", zone.name, zone.time, zone.offset))
	end
	
	print(string.rep("=", 60) .. "\n")
end

-- ==================== INICIALIZAR ====================
function DigitalClock.Start(parent, position, size, selectedZones)
	print("[DigitalClock] Sistema iniciado!")
	return DigitalClock.CreateClockGUI(parent, position, size, selectedZones)
end

return DigitalClock
