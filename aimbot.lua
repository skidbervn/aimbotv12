local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local rootPart = character:WaitForChild("HumanoidRootPart")
local runService = game:GetService("RunService")

-- Tạo một hàm để tìm các quái vật Bandit[LV5] trong khu vực
local function findBandits()
    local targetEnemies = {}

    -- Duyệt qua tất cả các quái vật Bandit[LV5]
    for _, enemy in pairs(workspace.Enemies:GetChildren()) do
        if enemy:FindFirstChild("Humanoid") and enemy.Humanoid.Health > 0 then
            if enemy.Name == "Bandit" and enemy:FindFirstChild("Level") then
                -- Kiểm tra xem quái vật có tên là Bandit và level là 5
                if enemy.Level.Value == 5 then
                    table.insert(targetEnemies, enemy)
                end
            end
        end
    end

    return targetEnemies
end

-- Hàm tấn công các quái vật Bandit[LV5]
local function attackBandits()
    while true do
        local bandits = findBandits()  -- Lấy danh sách quái vật Bandit[LV5]

        -- Nếu có quái vật, di chuyển và tấn công
        for _, bandit in pairs(bandits) do
            if bandit:FindFirstChild("Humanoid") then
                -- Di chuyển đến quái vật
                rootPart.CFrame = bandit.HumanoidRootPart.CFrame
                -- Mô phỏng tấn công
                game:GetService("VirtualUser"):Button1Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
                wait(0.1)  -- Đợi một chút trước khi tấn công tiếp
            end
        end
        wait(1)  -- Kiểm tra lại sau mỗi giây
    end
end

-- Bắt đầu tự động farm quái Bandit[LV5]
attackBandits()
