local TeleportService = game:GetService("TeleportService")
local player = game.Players.LocalPlayer
local desiredFruits = {
    "Kitsune", "Leopard", "Dragon", "Spirit", "Control", "Venom",
    "Shadow", "Dough", "T-Rex", "Mammoth", "Gravity", "Blizzard",
    "Pain", "Rumble", "Portal", "Phoenix", "Sound", "Spider",
    "Love", "Buddha", "Quake", "Magma", "Ghost", "Barrier",
    "Rubber", "Light", "Diamond", "Dark", "Sand", "Ice", 
    "Falcon", "Flame", "Spike", "Smoke", "Bomb", "Spring",
    "Chop", "Spin", "Rocket"
}

-- Tìm trái ác quỷ trong workspace
local function findFruits()
    for _, fruit in pairs(workspace:GetDescendants()) do
        if fruit:IsA("Tool") and table.find(desiredFruits, fruit.Name) then
            return fruit
        end
    end
    return nil
end

-- Nhặt trái ác quỷ
local function collectFruit(fruit)
    if player.Character and fruit then
        local humanoidRootPart = player.Character:FindFirstChild("HumanoidRootPart")
        if humanoidRootPart then
            humanoidRootPart.CFrame = fruit.Handle.CFrame
            wait(1) -- Đợi để nhặt
            fireclickdetector(fruit.Handle:FindFirstChild("ClickDetector"))
            print("Đã nhặt trái: " .. fruit.Name)
        end
    end
end

-- Đổi sang server ít người (chọn server có ít người chơi)
local function switchToLowPopulationServer()
    local placeId = game.PlaceId
    local teleportService = game:GetService("TeleportService")
    
    -- Lấy danh sách server có sẵn
    local serverList = teleportService:GetAvailablePlaceInstances(placeId)
    
    if #serverList == 0 then
        print("Không có server nào khả dụng.")
        return
    end

    -- Tìm server có ít người chơi
    local targetServer
    for _, server in pairs(serverList) do
        if not targetServer or server.Players < targetServer.Players then
            targetServer = server
        end
    end

    -- Nếu tìm thấy server ít người, teleport đến đó
    if targetServer then
        teleportService:TeleportToPlaceInstance(placeId, targetServer.InstanceId, player)
        print("Đang chuyển sang server ít người...")
    else
        print("Không tìm thấy server ít người.")
    end
end

-- Vòng lặp chính
while wait(5) do
    local fruit = findFruits()
    if fruit then
        collectFruit(fruit)
    else
        print("Không tìm thấy trái mong muốn, chuyển server...")
        switchToLowPopulationServer()
    end
end
