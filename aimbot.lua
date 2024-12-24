local player = game.Players.LocalPlayer
local chests = workspace:FindFirstChild("Chests") -- Thay bằng thư mục chứa rương

if not chests then
    warn("Không tìm thấy thư mục 'Chests' trong workspace!")
    return
end

-- Các loại rương
local chestTypes = {
    Silver = "SilverChest",
    Golden = "GoldenChest",
    Diamond = "DiamondChest"
}

-- Hàm tự động thu thập rương
local function collectChests()
    for _, chest in pairs(chests:GetChildren()) do
        for _, chestType in pairs(chestTypes) do
            if chest.Name == chestType then
                -- Di chuyển đến rương
                if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                    player.Character.HumanoidRootPart.CFrame = chest.CFrame
                    wait(0.5) -- Đợi để nhặt rương
                end
            end
        end
    end
end

-- Chạy vòng lặp auto-farm
while wait(1) do
    local success, err = pcall(collectChests)
    if not success then
        warn("Lỗi khi chạy collectChests: " .. err)
    end
end
