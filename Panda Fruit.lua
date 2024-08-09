SpeedTween = 350
getgenv().RandomFruit = true
function Hop()
    local PlaceID = game.PlaceId
    local AllIDs = {}
    local foundAnything = ""
    local actualHour = os.date("!*t").hour
    local Deleted = false
    function TPReturner()
        local Site;
        if foundAnything == "" then
            Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100'))
        else
            Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100&cursor=' .. foundAnything))
        end
        local ID = ""
        if Site.nextPageCursor and Site.nextPageCursor ~= "null" and Site.nextPageCursor ~= nil then
            foundAnything = Site.nextPageCursor
        end
        local num = 0;
        for i,v in pairs(Site.data) do
            local Possible = true
            ID = tostring(v.id)
            if tonumber(v.maxPlayers) > tonumber(v.playing) then
                for _,Existing in pairs(AllIDs) do
                    if num ~= 0 then
                        if ID == tostring(Existing) then
                            Possible = false
                        end
                    else
                        if tonumber(actualHour) ~= tonumber(Existing) then
                            local delFile = pcall(function()
                                -- delfile("NotSameServers.json")
                                AllIDs = {}
                                table.insert(AllIDs, actualHour)
                            end)
                        end
                    end
                    num = num + 1
                end
                if Possible == true then
                    table.insert(AllIDs, ID)
                    wait()
                    pcall(function()
                        -- writefile("NotSameServers.json", game:GetService('HttpService'):JSONEncode(AllIDs))
                        wait()
                        game:GetService("TeleportService"):TeleportToPlaceInstance(PlaceID, ID, game.Players.LocalPlayer)
                    end)
                    wait(4)
                end
            end
        end
    end

    function Teleport()
        while wait() do
            pcall(function()
                TPReturner()
                if foundAnything ~= "" then
                    TPReturner()
                end
            end)
        end
    end

    Teleport()
    wait(1)
end
function topos(Pos)
    Distance = (Pos.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
    if game.Players.LocalPlayer.Character.Humanoid.Sit == true then game.Players.LocalPlayer.Character.Humanoid.Sit = false end
    pcall(function() tween = game:GetService("TweenService"):Create(game.Players.LocalPlayer.Character.HumanoidRootPart,TweenInfo.new(Distance/SpeedTween, Enum.EasingStyle.Linear),{CFrame = Pos}) end)
    tween:Play()
    if Distance <= 250 then
    tween:Cancel()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Pos
    end
    if _G.StopTween == true then
    tween:Cancel()
    _G.Clip = false
    end
end
function CheckFruit()
    for i,v in pairs(game.Workspace:GetChildren()) do
        if string.find(v.Name, "Fruit") then
            return v.Handle.CFrame
        end
    end
end
function getNil(name, class)
    for _,v in next, getnilinstances() do
        if v.ClassName == class and v.Name == name then
            return v
        end
    end
end
local function RemoveSpaces(str)
    return str:gsub(" Fruit", "")
end
function FruitStore()
    pcall(function()
    print('Checkking Backpack')
    for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
        if string.find(v.Name, "Fruit") then
            local FruitName = RemoveSpaces(v.Name)
            local NameFruit

            if v.Name == "Bird: Falcon Fruit" then
                NameFruit = "Bird-Bird: Falcon"
            elseif v.Name == "Bird: Phoenix Fruit" then
                NameFruit = "Bird-Bird: Phoenix"
            elseif v.Name == "Human: Buddha Fruit" then
                NameFruit = "Human-Human: Buddha"
            else
                NameFruit = FruitName.."-"..FruitName
            end
            local string_1 = "StoreFruit"
            local string_2 = NameFruit
            local string_3 = v
            if string_3 then
                local Target = game:GetService("ReplicatedStorage").Remotes["CommF_"]
                Target:InvokeServer(string_1, string_2, string_3)
            else
                print("Error: Tool for " .. v.Name .. " is nil.")
            end
        end
    end
print('Checkking Character')
    for i,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
        if string.find(v.Name, "Fruit") then
            local FruitName = RemoveSpaces(v.Name)
            local NameFruit

            if v.Name == "Bird: Falcon Fruit" then
                NameFruit = "Bird-Bird: Falcon"
            elseif v.Name == "Bird: Phoenix Fruit" then
                NameFruit = "Bird-Bird: Phoenix"
            elseif v.Name == "Human: Buddha Fruit" then
                NameFruit = "Human-Human: Buddha"
            else
                NameFruit = FruitName.."-"..FruitName
            end
            local string_1 = "StoreFruit"
            local string_2 = NameFruit
            local string_3 = v
            if string_3 then
                local Target = game:GetService("ReplicatedStorage").Remotes["CommF_"]
                Target:InvokeServer(string_1, string_2, string_3)
            else
                print("Error: Tool for " .. v.Name .. " is nil.")
            end
        end
    end
end)
end
game.Players.LocalPlayer.Backpack.ChildAdded:Connect(function()
    print("Checking...")
    FruitStore()
end)
spawn(function()
    while wait(.1) do
   if CheckFruit() then
    topos(CheckFruit())
elseif game.Players.LocalPlayer.Backpack:FindFirstChildWhichIsA("Tool", true) and string.find(game.Players.LocalPlayer.Backpack:FindFirstChildWhichIsA("Tool", true).Name, "Fruit") then
    FruitStore()
   else
    wait(5)
      Hop()
   end
end
end)

spawn(function()
    while wait(.1) do
   if getgenv().RandomFruit then
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Cousin","Buy")
   end
end
end)
