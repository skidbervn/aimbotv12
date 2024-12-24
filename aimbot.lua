-- Dịch vụ cần thiết
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")

-- Tên của rương (Chest) trong trò chơi
local chestName = "Chest" -- Thay đổi theo tên của rương trong trò chơi
local autoTeleport = true -- Điều khiển bật/tắt tính năng

-- Tìm rương gần nhất
local function getNearestChest()
    local nearestChest = nil
    local shortestDistance = math.huge

    for _, chest in pairs(workspace:GetDescendants()) do
        if chest:IsA("Model") and chest.Name == chestName and chest:FindFirstChild("PrimaryPart") then
            local distance = (LocalPlayer.Character.HumanoidRootPart.Position - chest.PrimaryPart.Position).Magnitude
            if distance < shortestDistance then
                shortestDistance = distance
                nearestChest = chest
            end
        end
    end

    return nearestChest
end

-- Teleport đến rương
local function teleportToChest(chest)
    if chest and chest:FindFirstChild("PrimaryPart") then
        LocalPlayer.Character.HumanoidRootPart.CFrame = chest.PrimaryPart.CFrame
    end
end

-- Vòng lặp tự động
RunService.RenderStepped:Connect(function()
    if autoTeleport then
        local chest = getNearestChest()
        if chest then
            teleportToChest(chest)
        else
            print("Không tìm thấy rương nào.")
        end
    end
end)

-- Nút bật/tắt Teleport (T phím)
game:GetService("UserInputService").InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == Enum.KeyCode.T then
        autoTeleport = not autoTeleport
        print("Tự động Teleport: " .. (autoTeleport and "BẬT" or "TẮT"))
    end
end)
