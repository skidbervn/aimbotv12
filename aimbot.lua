-- Tên các trái ác quỷ cần nhặt
local desiredFruits = {
    "Kitsune", "Leopard", "Dragon", "Spirit", "Control", "Venom",
    "Shadow", "Dough", "T-Rex", "Mammoth", "Gravity", "Blizzard",
    "Pain", "Rumble", "Portal", "Phoenix", "Sound", "Spider",
    "Love", "Buddha", "Quake", "Magma", "Ghost", "Barrier",
    "Rubber", "Light", "Diamond", "Dark", "Sand", "Ice", 
    "Falcon", "Flame", "Spike", "Smoke", "Bomb", "Spring",
    "Chop", "Spin", "Rocket"
}

local player = game.Players.LocalPlayer

-- Tìm trái ác quỷ
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

-- Đổi server
local function switchServer()
    local teleportService = game:GetService("TeleportService")
    local servers = {} -- Dùng API hoặc danh sách server để tìm server mới
    if #servers > 0 then
        local randomServer = servers[math.random(1, #servers)]
        teleportService:TeleportToPlaceInstance(game.PlaceId, randomServer, player)
    else
        print("Không tìm thấy server phù hợp để đổi!")
    end
end

-- Vòng lặp chính
while wait(5) do
    local fruit = findFruits()
    if fruit then
        collectFruit(fruit)
    else
        print("Không tìm thấy trái mong muốn, đổi server...")
        switchServer()
    end
end
