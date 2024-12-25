-- Modules cần thiết
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera
local player = game.Players.LocalPlayer

-- Biến và trạng thái
local aimbotEnabled = false
local aimbotRange = 300 -- Phạm vi Aimbot
local target = nil

-- Tìm mục tiêu gần nhất
local function getClosestTarget()
    local closestTarget = nil
    local closestDistance = aimbotRange

    for _, character in pairs(workspace:GetChildren()) do
        if character:FindFirstChild("Humanoid") and character:FindFirstChild("HumanoidRootPart") and character ~= player.Character then
            local humanoidRootPart = character.HumanoidRootPart
            local screenPos, onScreen = Camera:WorldToViewportPoint(humanoidRootPart.Position)

            if onScreen then
                local mousePos = UserInputService:GetMouseLocation()
                local distance = (Vector2.new(screenPos.X, screenPos.Y) - mousePos).Magnitude

                if distance < closestDistance then
                    closestTarget = humanoidRootPart
                    closestDistance = distance
                end
            end
        end
    end

    return closestTarget
end

-- Bật/Tắt Aimbot
UserInputService.InputBegan:Connect(function(input, isProcessed)
    if isProcessed then return end

    -- Nhấn Ctrl để bật/tắt Aimbot
    if input.KeyCode == Enum.KeyCode.LeftControl then
        aimbotEnabled = not aimbotEnabled
        print("Aimbot: " .. (aimbotEnabled and "ON" or "OFF"))
    end
end)

-- Aimbot Logic
RunService.RenderStepped:Connect(function()
    if aimbotEnabled then
        -- Tìm mục tiêu gần nhất
        target = getClosestTarget()

        if target then
            -- Nhắm mục tiêu
            local screenPos = Camera:WorldToViewportPoint(target.Position)
            local mousePos = UserInputService:GetMouseLocation()

            -- Di chuyển chuột dần đến mục tiêu
            mousemoverel((screenPos.X - mousePos.X) / 5, (screenPos.Y - mousePos.Y) / 5)
        end
    end
end)
