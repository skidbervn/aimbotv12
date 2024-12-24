-- Khởi tạo dịch vụ
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

-- Tạo GUI menu
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "AimbotMenu"
screenGui.Parent = game.CoreGui

local frame = Instance.new("Frame", screenGui)
frame.Size = UDim2.new(0, 300, 0, 400)
frame.Position = UDim2.new(0.1, 0, 0.1, 0)
frame.BackgroundColor3 = Color3.new(0, 0, 0)
frame.BackgroundTransparency = 0.5
frame.BorderSizePixel = 2
frame.BorderColor3 = Color3.new(1, 1, 1)
frame.Active = true
frame.Draggable = true -- Cho phép kéo thả menu

local titleLabel = Instance.new("TextLabel", frame)
titleLabel.Size = UDim2.new(0.9, 0, 0, 50)
titleLabel.Position = UDim2.new(0.05, 0, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "Aimbot Menu"
titleLabel.TextColor3 = Color3.new(1, 1, 1)
titleLabel.Font = Enum.Font.SourceSansBold
titleLabel.TextScaled = true

-- Nút đóng (X)
local closeButton = Instance.new("TextButton", frame)
closeButton.Size = UDim2.new(0.1, 0, 0, 50)
closeButton.Position = UDim2.new(0.9, 0, 0, 0)
closeButton.BackgroundColor3 = Color3.new(1, 0, 0)
closeButton.TextColor3 = Color3.new(1, 1, 1)
closeButton.Font = Enum.Font.SourceSansBold
closeButton.TextScaled = true
closeButton.Text = "X"

closeButton.MouseButton1Click:Connect(function()
    screenGui:Destroy() -- Đóng toàn bộ menu
end)

-- Tạo nút bật/tắt Aimbot Skill
local skillAimbotButton = Instance.new("TextButton", frame)
skillAimbotButton.Size = UDim2.new(0.9, 0, 0, 50)
skillAimbotButton.Position = UDim2.new(0.05, 0, 0.15, 0)
skillAimbotButton.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
skillAimbotButton.TextColor3 = Color3.new(1, 1, 1)
skillAimbotButton.Font = Enum.Font.SourceSans
skillAimbotButton.TextScaled = true
skillAimbotButton.Text = "Skill Aimbot: OFF"

local skillAimbotEnabled = false

skillAimbotButton.MouseButton1Click:Connect(function()
    skillAimbotEnabled = not skillAimbotEnabled
    skillAimbotButton.Text = "Skill Aimbot: " .. (skillAimbotEnabled and "ON" or "OFF")
end)

-- Tạo nút bật/tắt Aimbot Trái Ác Quỷ
local fruitAimbotButton = Instance.new("TextButton", frame)
fruitAimbotButton.Size = UDim2.new(0.9, 0, 0, 50)
fruitAimbotButton.Position = UDim2.new(0.05, 0, 0.3, 0)
fruitAimbotButton.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
fruitAimbotButton.TextColor3 = Color3.new(1, 1, 1)
fruitAimbotButton.Font = Enum.Font.SourceSans
fruitAimbotButton.TextScaled = true
fruitAimbotButton.Text = "Devil Fruit Aimbot: OFF"

local fruitAimbotEnabled = false

fruitAimbotButton.MouseButton1Click:Connect(function()
    fruitAimbotEnabled = not fruitAimbotEnabled
    fruitAimbotButton.Text = "Devil Fruit Aimbot: " .. (fruitAimbotEnabled and "ON" or "OFF")
end)

-- Tạo nút bật/tắt Aimbot Súng
local gunAimbotButton = Instance.new("TextButton", frame)
gunAimbotButton.Size = UDim2.new(0.9, 0, 0, 50)
gunAimbotButton.Position = UDim2.new(0.05, 0, 0.45, 0)
gunAimbotButton.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
gunAimbotButton.TextColor3 = Color3.new(1, 1, 1)
gunAimbotButton.Font = Enum.Font.SourceSans
gunAimbotButton.TextScaled = true
gunAimbotButton.Text = "Gun Aimbot: OFF"

local gunAimbotEnabled = false

gunAimbotButton.MouseButton1Click:Connect(function()
    gunAimbotEnabled = not gunAimbotEnabled
    gunAimbotButton.Text = "Gun Aimbot: " .. (gunAimbotEnabled and "ON" or "OFF")
end)

-- Hàm tìm mục tiêu gần nhất
local function getNearestTarget()
    local nearestPlayer = nil
    local shortestDistance = math.huge

    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local distance = (LocalPlayer.Character.HumanoidRootPart.Position - player.Character.HumanoidRootPart.Position).Magnitude
            if distance < shortestDistance then
                shortestDistance = distance
                nearestPlayer = player
            end
        end
    end

    return nearestPlayer
end

-- Hàm bật Aimbot
RunService.RenderStepped:Connect(function()
    if skillAimbotEnabled or fruitAimbotEnabled or gunAimbotEnabled then
        local target = getNearestTarget()
        if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
            local targetPosition = target.Character.HumanoidRootPart.Position
            -- Điều chỉnh camera hoặc kỹ năng theo vị trí của mục tiêu
            Mouse.Hit = CFrame.new(targetPosition)
        end
    end
end)
