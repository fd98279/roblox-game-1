-- Server script
print("========================================")
print("SERVER SCRIPT STARTED!")
print("========================================")

local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Wait for the game to load
task.wait(1)

print("Looking for House module in ReplicatedStorage.Shared...")

local success, House = pcall(function()
    return require(ReplicatedStorage.Shared.House)
end)

if not success then
    warn("Failed to load House module:", House)
    return
end

print("✓ House module loaded successfully!")

-- Build a house at position (0, 1, 0) - right on the spawn
local housePosition = Vector3.new(0, 1, 0)
print("Building house at position:", housePosition)

local house = House.create(housePosition)
house.Parent = workspace

print("========================================")
print("✓ HOUSE BUILT SUCCESSFULLY!")
print("House location: Workspace.House")
print("Position:", housePosition)
print("========================================")
