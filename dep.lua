local module = {}
local espConnections = {}

local rs = game:GetService("RunService")

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

function module.getDistanceToObject(object)
    local character = player.Character 
    if not character then return end 
    local hrp = character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end 

    return (object.Position - hrp.Position).Magnitude

end

function module.objectESP(object,color,text,size,maxDistance)
    local part = Instance.new("Part",object)
    part.Name = "esp"
    part.Size = Vector3(0,0,0)

    --Main
    local label = Drawing.new("Text")

    label.Visible = true
    label.Center = true
    label.Outline = true
    label.Color = Color3.fromRGB(255, 255, 255) or color
    label.Size = 22 or size
    label.Text = text or "N/A"
    label.Font = 2

    local c1 

    c1 = rs.RenderStepped:Connect(function()
        if object and object:IsDescendantOf(workspace) and getgenv().esp then
            local pos, onScreen = camera:WorldToViewportPoint(object.Position + Vector3.new(0, 2, 0))
            local distance = module.getDistanceToObject(object)

            if onScreen and distance <= (500 or maxDistance) then
                label.Position = Vector2.new(pos.X, pos.Y)
                label.Visible = true
            else
                label.Visible = false
            end
        else
            label:Remove()
            part:Destroy()
            c1:Disconnect()
        end
    end)

end

function module.moveDirection()
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoid = character:WaitForChild("Humanoid")

    return humanoid.MoveDirection
end


return module 
