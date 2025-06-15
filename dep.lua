local module = {}

local players = game:GetService("Players")
local player = players.LocalPlayer

local mouse = player:GetMouse()
local camera = workspace.CurrentCamera


function module.getClosestPlayer()
    local maxDistance = 300 
    local target 

    for i,v in players:GetPlayers() do 
        if v ~= player then 
            local character = v.Character 
            if character then   
                local hrp = character:FindFirstChild("HumanoidRootPart") 

                if hrp then 
                    local distance = (hrp.Position - player.Character.HumanoidRootPart.Position).Magnitude 

                    if distance < maxDistance then 
                        maxDistance = distance
                        target = character
                    end 
                end 
            end 

        end 
    end 

    return target

end

function module.getClosestToMouse()
    local maxDistance = 90
    local target  

     for i,v in players:GetPlayers() do 
        if v ~= player then 
            local character = v.Character 
            if character then   
                local hrp = character:FindFirstChild("HumanoidRootPart") 

                if hrp then 
                    local vector,onScreen = camera:WorldToViewportPoint(hrp.Position)
                    local distance = (Vector2.new(mouse.X,mouse.Y) - Vector2.new(vector.X,vector.Y)).Magnitude

                    if onScreen and distance < maxDistance then 
                        maxDistance = distance
                        target = character
                    end 
 
                end 
            end 

        end 
    end 

    return target
end

return module 
