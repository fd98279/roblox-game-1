-- VFX Skill Module
local SkillVFX = {}

function SkillVFX.createEffect(character)
    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
    if not humanoidRootPart then
        return
    end

    -- Create particle effect
    local particles = Instance.new("ParticleEmitter")
    particles.Name = "SkillParticles"
    particles.Texture = "rbxasset://textures/particles/sparkles_main.dds"
    particles.Rate = 100
    particles.Lifetime = NumberRange.new(0.5, 1)
    particles.Speed = NumberRange.new(10, 20)
    particles.SpreadAngle = Vector2.new(360, 360)
    particles.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 100, 100)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 200, 0)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255))
    })
    particles.Size = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 1),
        NumberSequenceKeypoint.new(1, 0)
    })
    particles.Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 0),
        NumberSequenceKeypoint.new(1, 1)
    })
    particles.LightEmission = 1
    particles.Parent = humanoidRootPart

    -- Create light effect
    local light = Instance.new("PointLight")
    light.Name = "SkillLight"
    light.Color = Color3.fromRGB(255, 150, 0)
    light.Brightness = 5
    light.Range = 20
    light.Parent = humanoidRootPart

    -- Create shockwave effect
    local shockwave = Instance.new("Part")
    shockwave.Name = "Shockwave"
    shockwave.Size = Vector3.new(1, 0.5, 1)
    shockwave.Position = humanoidRootPart.Position
    shockwave.Anchored = true
    shockwave.CanCollide = false
    shockwave.Material = Enum.Material.Neon
    shockwave.BrickColor = BrickColor.new("Deep orange")
    shockwave.Transparency = 0.5
    shockwave.Shape = Enum.PartType.Cylinder
    shockwave.Orientation = Vector3.new(0, 0, 90)
    shockwave.Parent = workspace

    -- Animate the effects
    task.spawn(function()
        -- Shockwave expansion
        for i = 1, 20 do
            shockwave.Size = shockwave.Size + Vector3.new(0, 2, 2)
            shockwave.Transparency = 0.5 + (i / 40)
            task.wait(0.05)
        end
        shockwave:Destroy()
    end)

    -- Clean up particles and light after duration
    task.delay(2, function()
        particles:Destroy()
        light:Destroy()
    end)
end

function SkillVFX.playAnimation(character, humanoid)
    -- Create a simple animation (jump + spin)
    local bodyAngularVelocity = Instance.new("BodyAngularVelocity")
    bodyAngularVelocity.MaxTorque = Vector3.new(0, math.huge, 0)
    bodyAngularVelocity.AngularVelocity = Vector3.new(0, 50, 0)
    bodyAngularVelocity.Parent = character.HumanoidRootPart

    local bodyVelocity = Instance.new("BodyVelocity")
    bodyVelocity.MaxForce = Vector3.new(0, math.huge, 0)
    bodyVelocity.Velocity = Vector3.new(0, 50, 0)
    bodyVelocity.Parent = character.HumanoidRootPart

    task.delay(0.5, function()
        bodyAngularVelocity:Destroy()
        bodyVelocity:Destroy()
    end)
end

return SkillVFX
