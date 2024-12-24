local player = game.Players.LocalPlayer
local questGiverName = "Quest Giver 2" -- Tên của NPC nhận nhiệm vụ
local questButtonName = "QuestButton" -- Tên nút để chấp nhận nhiệm vụ, có thể phải điều chỉnh

-- Tìm NPC Quest Giver
local function findQuestGiver()
    for _, npc in pairs(workspace:GetDescendants()) do
        if npc:IsA("Model") and npc.Name == questGiverName then
            return npc
        end
    end
    return nil
end

-- Tương tác với NPC
local function interactWithQuestGiver(npc)
    if not npc then
        warn("Không tìm thấy NPC Quest Giver!")
        return
    end

    -- Di chuyển đến NPC
    local humanoidRootPart = player.Character:FindFirstChild("HumanoidRootPart")
    if humanoidRootPart then
        humanoidRootPart.CFrame = npc.PrimaryPart.CFrame + Vector3.new(0, 3, 0) -- Di chuyển gần NPC
        wait(1)
    end

    -- Tìm và nhấn nút chấp nhận nhiệm vụ
    local questButton = npc:FindFirstChild(questButtonName, true)
    if questButton and questButton:IsA("ProximityPrompt") then
        fireproximityprompt(questButton)
        print("Đã nhận nhiệm vụ từ " .. questGiverName)
    else
        warn("Không tìm thấy nút chấp nhận nhiệm vụ!")
    end
end

-- Chạy script tự động
while wait(5) do -- Kiểm tra nhiệm vụ mỗi 5 giây
    local questGiver = findQuestGiver()
    interactWithQuestGiver(questGiver)
end
