local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

-- Các vị trí teleport
local locations = {
    ["Floating Turtle"] = Vector3.new(3900, 200, -1900),
    ["Hydra Island"] = Vector3.new(5200, 100, -2200),
    ["Great Tree"] = Vector3.new(4300, 300, -2500)
}

-- Hàm teleport
local function teleport(location)
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    if rootPart and locations[location] then
        rootPart.CFrame = CFrame.new(locations[location])
    else
        warn("Không tìm thấy vị trí hoặc HumanoidRootPart!")
    end
end

-- Tạo menu GUI
local playerGui = player:WaitForChild("PlayerGui")
local screenGui = Instance.new("ScreenGui", playerGui)
screenGui.Name = "TeleportMenu"

-- Main Frame
local mainFrame = Instance.new("Frame", screenGui)
mainFrame.Size = UDim2.new(0, 200, 0, 200)
mainFrame.Position = UDim2.new(0.1, 0, 0.1, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true -- Cho phép kéo thả menu

-- Tạo nút teleport
local function createButton(name, position)
    local button = Instance.new("TextButton", mainFrame)
    button.Size = UDim2.new(1, -20, 0, 40)
    button.Position = UDim2.new(0, 10, 0, position)
    button.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
    button.Text = name
    button.TextColor3 = Color3.new(1, 1, 1)
    button.TextScaled = true

    -- Khi nhấn nút
    button.MouseButton1Click:Connect(function()
        teleport(name)
    end)
end

-- Tạo các nút
local buttonSpacing = 10
createButton("Floating Turtle", 10)
createButton("Hydra Island", 60)
createButton("Great Tree", 110)
