-- Dịch vụ cần thiết
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local mouse = LocalPlayer:GetMouse()

-- Cài đặt cho Auto Clicker
local autoClickEnabled = false -- Bật/tắt auto clicker
local autoClickInterval = 0.1 -- Thời gian giữa các lần click (giây)
local lastClickTime = 0

-- Cài đặt cho Faster Attack (tăng tốc độ tấn công)
local fasterAttackEnabled = false -- Bật/tắt tăng tốc độ tấn công
local attackInterval = 0.1 -- Thời gian giữa các lần tấn công (giây)
local lastAttackTime = 0

-- Hàm để tự động click chuột
local function autoClick()
    if autoClickEnabled then
        local currentTime = tick()
        if currentTime - lastClickTime >= autoClickInterval then
            mouse1click()  -- Mô phỏng click chuột trái
            lastClickTime = currentTime
        end
    end
end

-- Hàm để tăng tốc độ tấn công
local function fasterAttack()
    if fasterAttackEnabled then
        local currentTime = tick()
        if currentTime - lastAttackTime >= attackInterval then
            -- Gọi hàm tấn công của game ở đây (Ví dụ: "Attack()" hoặc "FireEvent()")
            -- Tùy thuộc vào cách tấn công trong trò chơi của bạn.
            -- Ví dụ: game.ReplicatedStorage.AttackEvent:FireServer() hoặc tương tự

            lastAttackTime = currentTime
        end
    end
end

-- Kích hoạt Auto Clicker khi nhấn phím X
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed then
        if input.KeyCode == Enum.KeyCode.X then
            autoClickEnabled = not autoClickEnabled
            print("Auto Clicker: " .. (autoClickEnabled and "ON" or "OFF"))
        end

        -- Bật/tắt Faster Attack khi nhấn phím Z
        if input.KeyCode == Enum.KeyCode.Z then
            fasterAttackEnabled = not fasterAttackEnabled
            print("Faster Attack: " .. (fasterAttackEnabled and "ON" or "OFF"))
        end
    end
end)

-- Vòng lặp liên tục để chạy Auto Clicker và Faster Attack
RunService.RenderStepped:Connect(function()
    autoClick()  -- Thực hiện Auto Clicker
    fasterAttack()  -- Thực hiện Faster Attack
end)
