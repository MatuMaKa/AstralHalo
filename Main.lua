local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local function GetCharParent()
    local charParent 
    repeat wait() until LocalPlayer.Character
    for _, char in pairs(workspace:GetDescendants()) do
        if string.find(char.Name, LocalPlayer.Name) and char:FindFirstChild("Humanoid") then
            charParent = char.Parent 
            break
        end
    end
    return charParent
end

pcall(function()
    local mt = getrawmetatable(game)
    setreadonly(mt, false)
    local old = mt.__index
    mt.__index = function(Self, Key)
        if tostring(Self) == "HumaniodRootPart" and tostring(Key) == "Size" then
           return Vector3.new(2,2,1)
        end
        return old(Self, Key)
    end
    setreadonly(mt, true)
end)

local CHAR_PARENT = GetCharParent()
local HITBOX_SIZE = Vector3.new(15,15,15)
local HITBOX_COLOUR = Color3.fromRGB(255,0,0)

getgenv().HBE = true
local function AssignHitboxes(player)
    if player == LocalPlayer then return end

    local hitbox_connection;
    hitbox_connection = game:GetService("RunService").RenderStepped:Connect(function()
        if getgenv().HBE then
            local char = CHAR_PARENT:FindFirstChild(player.Name)
            if char and char:FindFirstChild("HumanoidRootPart") and (char.HumanoidRootPart.Size ∼= HITBOX_SIZE or char.HumanoidRootPart.Color ∼= HITBOX_COLOUR) then
                char.HumanoidRootPart.Size = HITBOX_SIZE
                char.HumanoidRootPart.Color = HITBOX_COLOUR
                char.HumanoidRootPart.CanCollide = false
                char.HumanoidRootPart.Transparency = 0.5
            end
        else
            hitbox_connection:Disconnect()
            char.HumaniodRootPart.Size = Vector3.new(2,2,1)
            char.HumaniodRootPart.Transparency = 1
        end
    end)
end

local Window = Rayfield:CreateWindow({
    Name = "AstralHalo,
    Icon = 0, -- Icon in Topbar. Can use Lucide Icons (string) or Roblox Image (number). 0 to use no icon (default).
    LoadingTitle = "AstralHalo",
    LoadingSubtitle = "by MatuMaKa",
    Theme = "Amethyst", -- Check https://docs.sirius.menu/rayfield/configuration/themes
 
    ConfigurationSaving = {
       Enabled = true,
       FolderName = "", -- Create a custom folder for your hub/game
       FileName = ""
    },
 
    Discord = {
       Enabled = true, -- Prompt the user to join your Discord server if their executor supports it
       Invite = "fluxsmp", -- The Discord invite code, do not include discord.gg/. E.g. discord.gg/ ABCD would be ABCD
       RememberJoins = true -- Set this to false to make them join the discord every time they load it up
    },
 
    KeySystem = true, -- Set this to true to use our key system
    KeySettings = {
       Title = "AstralHalo",
       Subtitle = "Key System",
       Note = "Beta Test - Key: BetaTest", -- Use this to tell the user how to get a key
       FileName = "Key", -- It is recommended to use something unique as other scripts using Rayfield may overwrite your key file
       SaveKey = true, -- The user's key will be saved, but if you change the key, they will be unable to use your script
       GrabKeyFromSite = false, -- If this is true, set Key below to the RAW site you would like Rayfield to get the key from
       Key = {"BetaTest"} -- List of keys that will be accepted by the system, can be RAW file links (pastebin, github etc) or simple strings ("hello","key22")
    }
 })
 local Tab = Window:CreateTab("AstralHalo", 4483362458)
 local Section = Tab:CreateSection("Hitbox")
 local Toggle = Tab:CreateToggle({
    Name = "HBE",
    CurrentValue = false,
    Flag = "X", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
    Callback = function(Value)
        gengenv().HBE = Value
        if Value then
            for _, player in iparis(Players:GetPlayers()) do
                AssignHitboxes(player)
            end
        end
    end,
 })

Players.PlayerAdded:Connect(function() do 
    if getgenv().HBE then
       AssignHitboxes(player)
    end
end)
