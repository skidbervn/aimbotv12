-- Tạo GUI cơ bản
local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local screenGui = Instance.new("ScreenGui", playerGui)
screenGui.Name = "TeleportMenu"

-- Main Frame
local mainFrame = Instance.new("Frame", screenGui)
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 200, 0, 200)
mainFrame.Position = UDim2.new(0, 10, 0, 10)
mainFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true -- Kéo thả menu

-- Hàm di chuyển trực tiếp đến vị trí
local function teleportTo(position)
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")

    if humanoidRootPart then
        -- Đưa nhân vật đến vị trí
        humanoidRootPart.CFrame = CFrame.new(position)
    else
        warn("Không tìm thấy HumanoidRootPart để teleport!")
    end
end

-- Hàm tạo nút Teleport
local function createButton(name, position, teleportPosition)
    local button = Instance.new("TextButton", mainFrame)
    button.Name = name .. "Button"
    button.Size = UDim2.new(1, -20, 0, 40)
    button.Position = UDim2.new(0, 10, 0, position)
    button.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
    button.Text = name
    button.TextColor3 = Color3.new(1, 1, 1)
    button.TextScaled = true

    -- Khi nhấn nút
    button.MouseButton1Click:Connect(function()
        teleportTo(teleportPosition)
    end)
end

-- Tạo nút cho từng địa điểm
createButton("Floating Turtle", 10, Vector3.new(3900, 200, -1900))
createButton("Hydra Island", 60, Vector3.new(5200, 100, -2200))
createButton("Great Tree", 110, Vector3.new(4300, 300, -2500))
