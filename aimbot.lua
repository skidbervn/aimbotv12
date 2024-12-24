local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local player = game.Players.LocalPlayer

-- Lấy danh sách server từ API của Roblox
local function getServerList()
    local url = "https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"
    local success, result = pcall(function()
        return HttpService:JSONDecode(game:HttpGet(url))
    end)
    
    if success and result then
        return result.data
    else
        warn("Không thể lấy danh sách server!")
        return {}
    end
end

-- Đổi sang server khác
local function switchServer()
    local servers = getServerList()
    
    if #servers > 0 then
        for _, server in pairs(servers) do
            if server.playing < server.maxPlayers and server.id ~= game.JobId then
                print("Đang chuyển sang server mới...")
                TeleportService:TeleportToPlaceInstance(game.PlaceId, server.id, player)
                return
            end
        end
    else
        print("Không tìm thấy server nào phù hợp.")
    end
end

-- Thực hiện đổi server
switchServer()
