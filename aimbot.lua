-- Dịch vụ Roblox
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")

-- Cài đặt
local chestName = "Chest" -- Thay đổi thành tên rương chính xác
local autoTeleport = true -- Điều khiển bật/tắt tính năng tự động

-- Hàm tìm rương gần nhất
local function getNearestChest()
    local nearestChest = nil
    local shortestDistance = math.huge

    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("Model") and obj.Name == chestName and obj:FindFirstChild("PrimaryPart") then
            local distance = (LocalPlayer.Character.HumanoidRootPart.Position - obj.PrimaryPart.Position).Magnitude
            if distance < shortestDistance then
                shortestDistance = distance
                nearestChest = obj
            end
        end
    end

    return nearestChest
end

-- Hàm Teleport
local function teleportToChest(chest)
    if chest and chest:FindFirstChild("PrimaryPart") then
        LocalPlayer.Character.HumanoidRootPart.CFrame = chest.PrimaryPart.CFrame + Vector3.new(0, 5, 0) -- Dịch chuyển lên trên để tránh va chạm
        print("Dịch chuyển đến rương:", chest.Name)
    else
        print("Không tìm thấy rương hoặc rương không có PrimaryPart.")
    end
end

-- Vòng lặp tự động Teleport
RunService.RenderStepped:Connect(function()
    if autoTeleport then
        local nearestChest = getNearestChest()
        if nearestChest then
            teleportToChest(nearestChest)
        else
            print("Không có rương nào trong phạm vi.")
        end
    end
end)

-- Phím bật/tắt tính năng (phím T)
game:GetService("UserInputService").InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == Enum.KeyCode.T then
        autoTeleport = not autoTeleport
        print("Tự động Teleport: " .. (autoTeleport and "BẬT" or "TẮT"))
    end
end)
