-- Dịch vụ cần thiết
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")

-- Cài đặt
local mansionName = "Mansion"  -- Thay đổi tên này thành tên mansion trong game
local destination = nil  -- Biến để lưu vị trí của mansion

-- Hàm tìm mansion trong game
local function findMansion()
    -- Lấy tất cả các đối tượng trong workspace
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("Model") and obj.Name == mansionName then
            -- Lấy vị trí của mansion (PrimaryPart phải được cấu hình)
            if obj:FindFirstChild("PrimaryPart") then
                destination = obj.PrimaryPart.Position
                print("Đã tìm thấy Mansion tại vị trí: " .. tostring(destination))
                return
            end
        end
    end
    print("Không tìm thấy Mansion.")
end

-- Hàm di chuyển nhân vật đến mansion
local function moveToMansion()
    if destination then
        local humanoid = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid")
        if humanoid then
            -- Di chuyển đến vị trí mansion
            humanoid:MoveTo(destination)
        end
    else
        print("Vui lòng tìm Mansion trước khi di chuyển.")
    end
end

-- Tìm mansion khi game bắt đầu
findMansion()

-- Vòng lặp liên tục để theo dõi và di chuyển đến mansion
RunService.RenderStepped:Connect(function()
    if destination then
        moveToMansion()  -- Di chuyển đến mansion khi tìm thấy
    end
end)
