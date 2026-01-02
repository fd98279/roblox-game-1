-- Client script
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

local SkillVFX = require(ReplicatedStorage.Shared.SkillVFX)

-- Skill cooldown
local isOnCooldown = false
local COOLDOWN_TIME = 3 -- seconds

print("Client started! Press F to use skill")

-- Create cooldown UI
local function createCooldownUI()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "SkillUI"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = player:WaitForChild("PlayerGui")

    local cooldownLabel = Instance.new("TextLabel")
    cooldownLabel.Name = "CooldownLabel"
    cooldownLabel.Size = UDim2.new(0, 200, 0, 50)
    cooldownLabel.Position = UDim2.new(0.5, -100, 0.9, -50)
    cooldownLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    cooldownLabel.BackgroundTransparency = 0.5
    cooldownLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    cooldownLabel.TextScaled = true
    cooldownLabel.Font = Enum.Font.SourceSansBold
    cooldownLabel.Text = "Skill Ready [F]"
    cooldownLabel.Parent = screenGui

    return cooldownLabel
end

local cooldownLabel = createCooldownUI()

-- Handle F key press
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then
        return
    end

    if input.KeyCode == Enum.KeyCode.F then
        if isOnCooldown then
            print("Skill is on cooldown!")
            return
        end

        -- Activate skill
        isOnCooldown = true
        print("🔥 SKILL ACTIVATED! 🔥")

        -- Play animation
        SkillVFX.playAnimation(character, humanoid)

        -- Create visual effects
        SkillVFX.createEffect(character)

        -- Update UI
        cooldownLabel.Text = "Cooldown: " .. COOLDOWN_TIME
        cooldownLabel.BackgroundColor3 = Color3.fromRGB(255, 0, 0)

        -- Cooldown timer
        for i = COOLDOWN_TIME, 1, -1 do
            task.wait(1)
            cooldownLabel.Text = "Cooldown: " .. (i - 1)
        end

        -- Reset cooldown
        isOnCooldown = false
        cooldownLabel.Text = "Skill Ready [F]"
        cooldownLabel.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
        print("✓ Skill ready!")
    end
end)

print("✓ Skill system loaded! Press F to activate")
