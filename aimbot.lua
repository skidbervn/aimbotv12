-- Tạo GUI trong StarterGui
local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Khởi tạo Frame chính
local screenGui = Instance.new("ScreenGui", playerGui)
screenGui.Name = "TeleportMenu"

local mainFrame = Instance.new("Frame", screenGui)
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 300, 0, 400)
mainFrame.Position = UDim2.new(0.5, -150, 0.5, -200)
mainFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
mainFrame.BorderSizePixel = 0
mainFrame.Visible = false

-- Tạo nút mở menu
local toggleButton = Instance.new("TextButton", screenGui)
toggleButton.Name = "ToggleButton"
toggleButton.Size = UDim2.new(0, 100, 0, 50)
toggleButton.Position = UDim2.new(0, 10, 0, 10)
toggleButton.BackgroundColor3 = Color3.fromRGB(0, 150, 150)
toggleButton.Text = "Menu"
toggleButton.TextColor3 = Color3.new(1, 1, 1)

-- Tạo danh sách người chơi
local playerList = Instance.new("ScrollingFrame", mainFrame)
playerList.Name = "PlayerList"
playerList.Size = UDim2.new(1, 0, 1, -40)
playerList.Position = UDim2.new(0, 0, 0, 40)
playerList.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
playerList.ScrollBarThickness = 5
playerList.BorderSizePixel = 0

-- Nút đóng menu
local closeButton = Instance.new("TextButton", mainFrame)
closeButton.Name = "CloseButton"
closeButton.Size = UDim2.new(1, 0, 0, 40)
closeButton.Position = UDim2.new(0, 0, 0, 0)
closeButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
closeButton.Text = "Đóng"
closeButton.TextColor3 = Color3.new(1, 1, 1)

-- Hàm teleport
local function teleportToPlayer(targetPlayer)
    if player.Character and targetPlayer.Character then
        local humanoidRootPart = player.Character:FindFirstChild("HumanoidRootPart")
        local targetRootPart = targetPlayer.Character:FindFirstChild("HumanoidRootPart")
        if humanoidRootPart and targetRootPart then
            humanoidRootPart.CFrame = targetRootPart.CFrame
        end
    end
end

-- Cập nhật danh sách người chơi
local function updatePlayerList()
    playerList:ClearAllChildren()
    for _, targetPlayer in pairs(game.Players:GetPlayers()) do
        if targetPlayer ~= player then
            local playerButton = Instance.new("TextButton", playerList)
            playerButton.Size = UDim2.new(1, -10, 0, 40)
            playerButton.Position = UDim2.new(0, 5, 0, #playerList:GetChildren() * 45)
            playerButton.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
            playerButton.Text = targetPlayer.Name
            playerButton.TextColor3 = Color3.new(1, 1, 1)

            -- Kết nối sự kiện teleport
            playerButton.MouseButton1Click:Connect(function()
                teleportToPlayer(targetPlayer)
            end)
        end
    end
end

-- Mở và đóng menu
toggleButton.MouseButton1Click:Connect(function()
    mainFrame.Visible = not mainFrame.Visible
    if mainFrame.Visible then
        updatePlayerList()
    end
end)

closeButton.MouseButton1Click:Connect(function()
    mainFrame.Visible = false
end)

-- Tự động cập nhật khi có người chơi tham gia/rời game
game.Players.PlayerAdded:Connect(updatePlayerList)
game.Players.PlayerRemoving:Connect(updatePlayerList)
