SpeedTween = 350
getgenv().RandomFruit = true
getgenv().EspFruit = true
getgenv().Team = "Pirate"
repeat
    pcall(function()
            task.wait()
            if game:GetService("Players").LocalPlayer.PlayerGui:WaitForChild("Main"):FindFirstChild("ChooseTeam") then
                if string.find(tostring(getgenv().Team), "Pirate") then
                    for r, v in pairs(
                        getconnections(
                            game:GetService("Players").LocalPlayer.PlayerGui.Main.ChooseTeam.Container.Pirates.Frame.TextButton.Activated
                        )
                    ) do
                        v.Function()
                    end
                elseif string.find(tostring(getgenv().Team), "Marine") then
                    for r, v in pairs(
                        getconnections(
                            game:GetService("Players").LocalPlayer.PlayerGui.Main.ChooseTeam.Container.Marines.Frame.TextButton.Activated
                        )
                    ) do
                        v.Function()
                    end
                else
                    for r, v in pairs(
                        getconnections(
                            game:GetService("Players").LocalPlayer.PlayerGui.Main.ChooseTeam.Container.Pirates.Frame.TextButton.Activated
                        )
                    ) do
                        v.Function()
                    end
                end
            end
        end)
        until not game:GetService("Players").LocalPlayer.PlayerGui:WaitForChild("Main"):FindFirstChild("ChooseTeam")
function isnil(thing)
    return (thing == nil)
    end
    local function round(n)
    return math.floor(tonumber(n) + 0.5)
    end
    Number = math.random(1, 1000000)
    function UpdateBfEsp()
        for i,v in pairs(game:GetService("Workspace"):GetChildren()) do
        pcall(function()
        if getgenv().EspFruit then
        if string.find(v.Name, "Fruit") then
        if not v.Handle:FindFirstChild('NameEsp'..Number) then
        local bill = Instance.new('BillboardGui',v.Handle)
        bill.Name = 'NameEsp'..Number
        bill.ExtentsOffset = Vector3.new(0, 1, 0)
        bill.Size = UDim2.new(1,200,1,30)
        bill.Adornee = v.Handle
        bill.AlwaysOnTop = true
        local name = Instance.new('TextLabel',bill)
        name.Font = "GothamBold"
        name.FontSize = "Size14"
        name.TextWrapped = true
        name.Size = UDim2.new(1,0,1,0)
        name.TextYAlignment = 'Top'
        name.BackgroundTransparency = 1
        name.TextStrokeTransparency = 0.5
        name.TextColor3 = Color3.fromRGB(255, 0, 0)
        name.Text = (v.Name ..' \n'.. round((game:GetService('Players').LocalPlayer.Character.Head.Position - v.Handle.Position).Magnitude/3) ..' M')
        else
        v.Handle.TextLabel.Text = (v.Name ..'   \n'.. round((game:GetService('Players').LocalPlayer.Character.Head.Position - v.Handle.Position).Magnitude/3) ..' M')
        end
        end
        else
        if v.Handle:FindFirstChild('NameEsp'..Number) then
        v.Handle:FindFirstChild('NameEsp'..Number):Destroy()
        end
        end
        end)
        end
        end
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
spawn(function()
  while wait() do
    if getgenv().EspFruit then 
        UpdateBfEsp()
    end
  end
end)