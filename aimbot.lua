local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local runService = game:GetService("RunService")

-- Các vị trí đảo
local locations = {
    ["Floating Turtle"] = Vector3.new(3900, 200, -1900),
    ["Hydra Island"] = Vector3.new(5200, 100, -2200),
    ["Great Tree"] = Vector3.new(4300, 300, -2500)
}

-- Tạo GUI
local playerGui = player:WaitForChild("PlayerGui")
local screenGui = Instance.new("ScreenGui", playerGui)
screenGui.Name = "FlyMenu"

-- Main Frame
local mainFrame = Instance.new("Frame", screenGui)
mainFrame.Size = UDim2.new(0, 200, 0, 200)
mainFrame.Position = UDim2.new(0.1, 0, 0.1, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true -- Cho phép kéo thả menu

-- Hàm bay đến vị trí
local function flyTo(destination)
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    if not rootPart then
        warn("Không tìm thấy HumanoidRootPart!")
        return
    end

    local speed = 200 -- Tốc độ bay
    local flying = true

    -- Hàm để bay
    local connection
    connection = runService.RenderStepped:Connect(function(deltaTime)
        if flying and rootPart and destination then
            local direction = (destination - rootPart.Position).Unit
            rootPart.CFrame = rootPart.CFrame + direction * speed * deltaTime

            -- Kiểm tra nếu đã gần đến vị trí
            if (rootPart.Position - destination).Magnitude < 10 then
                flying = false
                connection:Disconnect()
                print("Đã đến đích!")
            end
        end
    end)
end

-- Hàm tạo nút teleport cho các đảo
local function createButton(name, position)
    local button = Instance.new("TextButton", mainFrame)
    button.Size = UDim2.new(1, -20, 0, 40)
    button.Position = UDim2.new(0, 10, 0, position)
    button.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
    button.Text = name
    button.TextColor3 = Color3.new(1, 1, 1)
    button.TextScaled = true

    -- Khi nhấn nút
    button.MouseButton1Click:Connect(function()
        flyTo(locations[name]) -- Bay đến vị trí tương ứng
    end)
end

-- Tạo các nút cho các đảo
local buttonSpacing = 10
createButton("Floating Turtle", buttonSpacing)
createButton("Hydra Island", buttonSpacing + 50)
createButton("Great Tree", buttonSpacing + 100)
