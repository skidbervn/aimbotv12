local player = game.Players.LocalPlayer
local chests = workspace:WaitForChild("Chests") -- Thư mục chứa rương, tên có thể thay đổi tùy vào game

-- Các loại rương
local chestTypes = {
    Silver = "SilverChest",
    Golden = "GoldenChest",
    Diamond = "DiamondChest"
}

-- Hàm tự động thu thập rương
local function collectChests()
    for _, chest in pairs(chests:GetChildren()) do
        for chestName, chestType in pairs(chestTypes) do
            if chest.Name == chestType and chest:FindFirstChild("TouchInterest") then
                -- Di chuyển đến rương
                player.Character.HumanoidRootPart.CFrame = chest.CFrame
                wait(0.5) -- Đợi để nhặt rương
            end
        end
    end
end

-- Chạy vòng lặp auto-farm
while wait(1) do
    pcall(collectChests)
end
