-- Tạo GUI cơ bản
local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local screenGui = Instance.new("ScreenGui", playerGui)
screenGui.Name = "AimbotMenu"

-- Main Frame
local mainFrame = Instance.new("Frame", screenGui)
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 200, 0, 100)
mainFrame.Position = UDim2.new(0, 10, 0, 10)
mainFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true -- Cho phép kéo thả

-- Close Button (Nút X)
local closeButton = Instance.new("TextButton", mainFrame)
closeButton.Name = "CloseButton"
closeButton.Size = UDim2.new(0, 30, 0, 30)
closeButton.Position = UDim2.new(1, -35, 0, 5)
closeButton.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
closeButton.Text = "X"
closeButton.TextColor3 = Color3.new(1, 1, 1)
closeButton.TextScaled = true

-- Aimbot Toggle Button
local aimbotButton = Instance.new("TextButton", mainFrame)
aimbotButton.Name = "AimbotButton"
aimbotButton.Size = UDim2.new(1, -20, 0, 50)
aimbotButton.Position = UDim2.new(0, 10, 0, 40)
aimbotButton.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
aimbotButton.Text = "Aimbot: OFF"
aimbotButton.TextColor3 = Color3.new(1, 1, 1)

-- Circle Visual for Aimbot
local aimbotCircle = Drawing.new("Circle")
aimbotCircle.Color = Color3.fromRGB(255, 0, 0)
aimbotCircle.Thickness = 2
aimbotCircle.Transparency = 0.7
aimbotCircle.Filled = false
aimbotCircle.Visible = false

-- Variables
local aimbotEnabled = false
local aimbotRange = 200 -- Phạm vi Aimbot

-- Đóng menu khi nhấn nút X
closeButton.MouseButton1Click:Connect(function()
    screenGui:Destroy()
end)

-- Bật/Tắt Aimbot
aimbotButton.MouseButton1Click:Connect(function()
    aimbotEnabled = not aimbotEnabled
    aimbotButton.Text = "Aimbot: " .. (aimbotEnabled and "ON" or "OFF")
    aimbotButton.BackgroundColor3 = aimbotEnabled and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(200, 0, 0)
    aimbotCircle.Visible = aimbotEnabled
end)

-- Tìm mục tiêu gần nhất
local function getClosestTarget()
    local closestTarget = nil
    local closestDistance = aimbotRange

    for _, character in pairs(workspace:GetChildren()) do
        if character:FindFirstChild("Humanoid") and character ~= player.Character then
            local targetPos = character:FindFirstChild("HumanoidRootPart") and character.HumanoidRootPart.Position
            local screenPos, onScreen = workspace.CurrentCamera:WorldToViewportPoint(targetPos)

            if onScreen then
                local distance = (Vector2.new(screenPos.X, screenPos.Y) - Vector2.new(aimbotCircle.Position.X, aimbotCircle.Position.Y)).Magnitude
                if distance < closestDistance then
                    closestTarget = character
                    closestDistance = distance
                end
            end
        end
    end

    return closestTarget
end

-- Aimbot Logic
game:GetService("RunService").RenderStepped:Connect(function()
    if aimbotEnabled then
        -- Cập nhật vòng tròn aimbot
        local mouse = game:GetService("UserInputService"):GetMouseLocation()
        aimbotCircle.Position = mouse
        aimbotCircle.Radius = aimbotRange

        -- Tìm mục tiêu và nhắm
        local target = getClosestTarget()
        if target and target:FindFirstChild("HumanoidRootPart") then
            local humanoidRootPart = target.HumanoidRootPart
            mousemoverel((humanoidRootPart.Position.X - mouse.X) / 2, (humanoidRootPart.Position.Y - mouse.Y) / 2)
        end
    end
end)
